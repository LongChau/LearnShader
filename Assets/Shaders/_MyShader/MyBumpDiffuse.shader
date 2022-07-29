Shader "Custom/MyBumpDiffuse" 
{
    Properties {
        _myDiffuseTex ("Diffuse Texture", 2D)     =   "white" {}

        // = "bump" de cho no du khong co thi cung khong do mau len.
        _myBumpMapTex ("Bump map Texture", 2D)    =   "bump" {}
        
        // mot slider de dieu chinh gia tri x,y.... Gia tri Z khong nen dieu chinh vi no anh huong 
        // rat nhieu den anh sang
        _mySlider ("Bump Amount", Range(0, 10))   =   1
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D     _myDiffuseTex;
        sampler2D     _myBumpMapTex;
        half          _mySlider;

        struct Input {
            float2 uv_myDiffuseTex;
            float2 uv_myBumpMapTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;

            // use UnpackNormal: de convert tu rgb sang vector normal (vector phap tuyen)
            o.Normal = UnpackNormal(tex2D(_myBumpMapTex, IN.uv_myBumpMapTex));
            // modify normal vector with slider value
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
