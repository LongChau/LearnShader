Shader "Custom/MyPropChallenge3" 
{
    Properties 
    {
        _myTex ("Example Texture", 2D) = "white" {}
    }
    SubShader 
    {
      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myTex;
        fixed4 _myColor;

        struct Input {
            float2 uv_myTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            //note below how to create a colour on the fly with code
            _myColor = float4(0, 1, 0, 1);
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myColor).rgb;
        }
      ENDCG
    }
    Fallback "Diffuse"
  }
