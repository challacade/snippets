local shaders = {}

shaders.whiteout = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);

        if (screen_coords.x < 400.0) {
            return vec4(0, 0, 1, pixel.a);
        }

        return pixel * color;
    }
]]

shaders.greyscale = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);
        
        // Calculate average of RGB channels
        float grey = (pixel.r + pixel.g + pixel.b) / 3.0;
        
        return vec4(grey, grey, grey, pixel.a) * color;
    }
]]

shaders.light = love.graphics.newShader[[
    extern vec2 playerPosition;

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);
        
        float distance = length(screen_coords - playerPosition);
        float fade = distance / 250;

        pixel.a = pixel.a * fade;
        
        return pixel * color;
    }
]]

shaders.multiLight = love.graphics.newShader[[
    extern vec3 lightPositions[16]; // x, y, radius
    extern int numLights; // total number of lights

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);
        
        float totalLight = 0.0;
        
        for (int i = 0; i < numLights; i++) {
            vec2 lightPos = lightPositions[i].xy;
            float radius = lightPositions[i].z;
            
            float distance = length(screen_coords - lightPos);
            float fade = clamp(distance / radius, 0.0, 1.0);
            
            // Invert fade so light is 1.0 at center, 0.0 at edge
            float lightAmount = 1.0 - fade;
            totalLight += lightAmount;
        }
        
        // Clamp total light and use it to reduce darkness
        totalLight = clamp(totalLight, 0.0, 1.0);
        pixel.a = pixel.a * (1.0 - totalLight);
        
        return pixel * color;
    }
]]

return shaders