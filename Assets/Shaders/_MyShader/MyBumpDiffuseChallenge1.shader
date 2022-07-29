Shader "Custom/MyBumpDiffuseChallenge1" 
{
    // Add another slider to the code developed in the previous lecture to scale the bump and albedo texture
    Properties {
        _myDiffuseTex ("Diffuse Texture", 2D)     =   "white" {}

        // = "bump" de cho no du khong co thi cung khong do mau len.
        _myBumpMapTex ("Bump map Texture", 2D)    =   "bump" {}
        
        // mot slider de dieu chinh gia tri x,y.... Gia tri Z khong nen dieu chinh vi no anh huong 
        // rat nhieu den anh sang
        _myBumpAmount ("Bump Amount", Range(0, 10))   =   1

        // bump scale, texture scale
        _myScale ("Texture Bump Scale", Range (0.5, 2))     =     1

        // brightness
        _myBrightness ("Brightness", Range(0, 2)) = 1

        // _myCube ("Cube Map", CUBE) = "white" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D     _myDiffuseTex;
        sampler2D     _myBumpMapTex;
        half          _myBumpAmount;
        half          _myScale;
        half          _myBrightness;

        // sampler2D     _myCube;

        struct Input {
            float2 uv_myDiffuseTex;
            float2 uv_myBumpMapTex;
            // float3 worldRefl;
        };
        
        // surface function
        void surf (Input IN, inout SurfaceOutput o) { 
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex * _myScale).rgb;
            
            // use UnpackNormal: de convert tu rgb sang vector normal (vector phap tuyen)
            // o.Normal = UnpackNormal(tex2D(_myBumpMapTex, IN.uv_myBumpMapTex * _myScale));
            o.Normal = UnpackNormal(tex2D(_myBumpMapTex, IN.uv_myBumpMapTex * _myScale)) * _myBrightness;
            // modify normal vector with slider value
            o.Normal *= float3(_myBumpAmount, _myBumpAmount, 1);

            // o.Albedo = tex2D(_myDiffuseTex, IN.worldRefl).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
