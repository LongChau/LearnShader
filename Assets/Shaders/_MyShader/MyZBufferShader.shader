Shader "Custom/MyZBufferShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        // specify the queue to use inside the shader by using tag
        Tags { "Queue" = "Geometry+100" }         // trong do: "Queue" theo sau la ten cua render order ma minh muon ve
        // ngoai ra con co the add them value. Trong TH nay thi shader draw AFTER other geometry objects and depending on
        // information in the Z-Buffer, that could bring your object to the front.

        // Depth information
        ZWrite Off              // => set Off: prevent depth information to be recorded => tell GPU that there is no depth information.
        // ZWrite On              // Set On: enable back depth information.

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
