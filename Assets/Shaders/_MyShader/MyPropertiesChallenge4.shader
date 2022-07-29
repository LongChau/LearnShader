Shader "Custom/MyPropertiesChallenge4" 
{
    Properties {
        _myDiffuseTex ("Diffuse Texture", 2D) = "white" {}

        //set this texture to black to stop the white
        //overwhelming the effect if no emission texture
        //is present
        _myEmissionTex ("Emission Texture", 2D) = "black" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuseTex;
        sampler2D _myEmissionTex;

        struct Input {
            float2 uv_myDiffuseTex;
            float2 uv_myEmissionTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {

            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;
            o.Emission = tex2D(_myEmissionTex, IN.uv_myEmissionTex).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
