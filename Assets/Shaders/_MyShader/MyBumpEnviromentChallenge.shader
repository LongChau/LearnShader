Shader "Custom/MyBumpEnviromentChallenge" 
{
    // Give metallic reflective bump mapped surface
    Properties 
    {
        // = "bump" de cho no du khong co thi cung khong do mau len.
        _myBumpMapTex ("Bump map Texture", 2D)    =   "bump" {}

        _myCube ("Cube Map", CUBE)                = "white" {}

        _normalValue ("NormalValue", Range(0, 10)) = 0.3
    }
    
    SubShader 
    {

      CGPROGRAM
        #pragma surface surf Lambert

        sampler2D     _myBumpMapTex;
        samplerCUBE   _myCube;

        half          _normalValue;

        struct Input 
        {
            float2 uv_myBumpMapTex;
            float3 worldRefl;           INTERNAL_DATA
        };
        
        // surface function
        void surf (Input IN, inout SurfaceOutput o) 
        { 
            // o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex * _myScale).rgb;
            
            o.Albedo = texCUBE(_myCube, WorldReflectionVector (IN, o.Normal)).rgb;

            o.Normal = UnpackNormal(tex2D(_myBumpMapTex, IN.uv_myBumpMapTex));
            o.Normal *= float3(_normalValue, _normalValue, 1);

            //o.Emission = texCUBE(_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
        }
      
      ENDCG
    }

    Fallback "Diffuse"
}
