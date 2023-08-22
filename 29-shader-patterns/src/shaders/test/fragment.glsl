#define PI 3.1415926535897932384626433832795
varying vec2 vUv;

// Functions

float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

vec4 permute(vec4 x)
{
    return mod(((x*34.0)+1.0)*x, 289.0);
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson
//
vec2 fade(vec2 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

float cnoise(vec2 P){
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);
  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x,gy.x);
  vec2 g10 = vec2(gx.y,gy.y);
  vec2 g01 = vec2(gx.z,gy.z);
  vec2 g11 = vec2(gx.w,gy.w);
  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));
  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

void main()
{
   // gl_FragColor = vec4(0.5, 0.0, 1.0, 1.0);

    // Pattern 1: blue / purple gradient color
    // gl_FragColor = vec4(vUv.x, vUv.y, 1.0, 1.0);
    // gl_FragColor = vec4(vUv, 1.0, 1.0);

    // Pattern 2: green/ blue / purple gradient color
    // gl_FragColor = vec4(vUv, 0.5, 1.0);

    // Pattern 3: x axis black to white gradient
    // float strength = vUv.x;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);
    
    // Pattern 4: y axis black to white gradient
    // float strength = vUv.y;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 5: y axis white to black gradient
    // float strength = 1.0 - vUv.y;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 6: y axis white to black gradient (last 10% is black)
    // float strength = vUv.y * 10.0;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 7:  y axis white to black gradient (blinds)
    // float strength = mod(vUv.y * 10.0, 1.0);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 8: white blinds
    // float strength = mod(vUv.y * 10.0, 1.0);
    // strength = step(0.5, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 9: thin white blinds
    // float strength = mod(vUv.y * 10.0, 1.0);
    // strength = step(0.8, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 9: thin vertical white blinds
    // float strength = mod(vUv.x * 10.0, 1.0);
    // strength = step(0.8, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 10:  white grid
    // float strength = step(0.8, mod(vUv.y * 10.0, 1.0));
    // strength += step(0.8, mod(vUv.x * 10.0, 1.0));

    // gl_FragColor = vec4(strength, strength, strength, 1.0);
    
    // Pattern 11: small white squares grid
    // float strength = step(0.8, mod(vUv.y * 10.0, 1.0));
    // strength *= step(0.8, mod(vUv.x * 10.0, 1.0));

    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 12: white rectangle grid

    // float strength = step(0.8, mod(vUv.y * 10.0, 1.0));
    // strength *= step(0.4, mod(vUv.x * 10.0, 1.0));

    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 13: white top right angle grid
    // float barX = step(0.8, mod(vUv.y * 10.0, 1.0));
    // barX *= step(0.4, mod(vUv.x * 10.0, 1.0));

    // float barY = step(0.4, mod(vUv.y * 10.0, 1.0));
    // barY *= step(0.8, mod(vUv.x * 10.0, 1.0));

    // float strength = barX + barY;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 14: white plus grid

    // float barX = step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0));
    // barX *= step(0.4, mod(vUv.x * 10.0, 1.0));

    // float barY = step(0.4, mod(vUv.y * 10.0, 1.0));
    // barY *= step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0));

    // float strength = barY + barX;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 15: gradient black in the middle grey on the sides
    // float strength = abs(vUv.x - 0.5);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 16: gradient black cross
    // float strength = min(abs(vUv.x - 0.5), abs(vUv.y - 0.5));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 17: gradient black diamond
    // float strength = max(abs(vUv.x - 0.5), abs(vUv.y - 0.5));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 18: inner small black square
    // float strength = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 19: inner bigger black square
    // float square1 = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    // float square2 =  1.0 - step(0.25, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    // float strength = square1 * square2;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 20: graident blinds
    // float strength = floor(vUv.x * 10.0) / 10.0;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 21: gradient grid
    // float gradientX = floor(vUv.x * 10.0) / 10.0;
    // float gradientY = floor(vUv.y * 10.0) / 10.0;
    // float strength = gradientX * gradientY;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 22: Random static (random function above)

    // float strength = random(vUv);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);
    
    // Pattern 23: Random static bigger squares

    //  vec2 gridUv = vec2(floor(vUv.x * 10.0) / 10.0, floor(vUv.y * 10.0) / 10.0);
    //  float strength = random(gridUv);

    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 24: Random static bigger squares offset diagonal squares

    //  vec2 gridUv = vec2(
    //     floor(vUv.x * 10.0) / 10.0, 
    //     floor((vUv.y + vUv.x * 0.5) * 10.0) / 10.0
    // );

    //  float strength = random(gridUv);

    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 25:  left corner radial graident

    //  float strength = length(vUv);
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 26: center radial graident
    //  float strength = distance(vUv, vec2(0.5, 0.5));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 27: white center radial gradient
    // float strength = 1.0 - distance(vUv, vec2(0.5, 0.5));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 28: white pinhole gradient
    // float strength = 0.02 / distance(vUv, vec2(0.5, 0.5));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 29: stretched white pinhole gradient
    // vec2 lightUv = vec2(
    //     vUv.x * 0.2 + 0.4,
    //     vUv.y
    //     );
    // float strength = 0.02 / distance(lightUv, vec2(0.5, 0.5));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 30: diamond pinhole gradient
    // vec2 lightUvX = vec2(
    //     vUv.x * 0.2 + 0.4,
    //     vUv.y
    // );

    // float lightX = 0.025 / distance(lightUvX, vec2(0.5, 0.5));

    // vec2 lightUvY = vec2(
    //     vUv.x,
    //     vUv.y * 0.2 + 0.4
    // );

    // float lightY = 0.025 / distance(lightUvY, vec2(0.5, 0.5));

    // float strength = lightX * lightY;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 31: diamond pinhole gradient rotated
    // vec2 rotatedUv = rotate(vUv, PI / 4.0, vec2(0.5));

    // vec2 lightUvX = vec2(
    //     rotatedUv.x * 0.2 + 0.4,
    //     rotatedUv.y
    // );

    // float lightX = 0.025 / distance(lightUvX, vec2(0.5, 0.5));

    // vec2 lightUvY = vec2(
    //     rotatedUv.x,
    //     rotatedUv.y * 0.2 + 0.4
    // );

    // float lightY = 0.025 / distance(lightUvY, vec2(0.5, 0.5));

    // float strength = lightX * lightY;

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 33: Black inner circle

    // float strength = step(0.25, distance(vUv, vec2(0.5, 0.5)));

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 34: Black ring gradient
    // float strength = abs(distance(vUv, vec2(0.5, 0.5)) -0.25 );

    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 35: Black ring
    // float strength = step(0.01, abs(distance(vUv, vec2(0.5, 0.5)) -0.25 ));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 36: White ring
    // float strength = 1.0 - step(0.01, abs(distance(vUv, vec2(0.5, 0.5)) -0.25 ));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 36: Wavy White ring
    // vec2 wavedUv = vec2(
    //     vUv.x,
    //     vUv.y + sin(vUv.x * 30.0) * 0.1
    // );  
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5, 0.5)) -0.25 ));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 37: Wavy blob
    // vec2 wavedUv = vec2(
    //     vUv.x  + sin(vUv.y * 30.0) * 0.1,
    //     vUv.y + sin(vUv.x * 30.0) * 0.1
    // );  
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5, 0.5)) -0.25 ));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 38: wavy blob 2
    // vec2 wavedUv = vec2(
    //     vUv.x  + sin(vUv.y * 100.0) * 0.1,
    //     vUv.y + sin(vUv.x * 100.0) * 0.1
    // );  
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5, 0.5)) -0.25 ));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 39: left corner gradient angle
    // float angle = atan(vUv.x, vUv.y);
    // float strength = angle;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 40: middle gradient angle
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // float strength = angle;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 41: middle conical gradient angle
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // angle /= PI * 2.0;
    // angle += 0.5;
    // float strength = angle;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 42: spiral conical gradient angle
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / (PI * 2.0) + 0.5;
    // float strength = mod(angle * 20.0, 1.0);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 43: spiral conical gradient angle (bigger gaps)
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / (PI * 2.0) + 0.5;
    // float strength = sin(angle * 100.0);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 44: wavy circle 
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5) / (PI * 2.0) + 0.5;
    // float radius = 0.25 + sin(angle * 100.0) * 0.02;
    // float strength = 1.0 - step(0.01, abs(distance(vUv, vec2(0.5)) - radius));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 45 perlin nosie shader
//    float strength = cnoise(vUv * 10.0);
//     gl_FragColor = vec4(strength, strength, strength, 1.0);


    // Pattern 46 perlin nosie shader 2
//    float strength = step(0.0, cnoise(vUv * 10.0));
//    gl_FragColor = vec4(strength, strength, strength, 1.0);


  // Pattern 47 perlin nosie shader 3
//   float strength = 1.0 - abs(cnoise(vUv * 10.0));
//   gl_FragColor = vec4(strength, strength, strength, 1.0);

  // Pattern 48 perlin nosie shader 4
// float strength = sin(cnoise(vUv * 10.0) * 20.0);
//   gl_FragColor = vec4(strength, strength, strength, 1.0);

    // Pattern 49 perlin nosie shader 5
//   float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));
//   gl_FragColor = vec4(strength, strength, strength, 1.0);


  // pattern 50 coloured

  float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));

  vec3 blackColor = vec3(0.0);
  vec3 uvColor = vec3(vUv, 1.0);
  vec3 mixedColor = mix(blackColor, uvColor, strength);
  gl_FragColor = vec4(mixedColor, 1.0);

}