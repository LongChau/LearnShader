Shader "Custom/MyDotProduct"
{
    Properties
    {
        //_MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Color1 ("Dot = 1", Color) = (1, 1, 1, 1)
        _Color0 ("Dot = 0", Color) = (1, 1, 1, 1)
        _Color90 ("Dot = -1, angle = 90", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        //sampler2D _MainTex;

        fixed3 _MyColor = (1, 1, 1);

        fixed4 _Color1;
        fixed4 _Color0;
        fixed4 _Color90;

        struct Input
        {
            //float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            half dotP = dot(IN.viewDir, o.Normal);  // white when face the same direction
            // half dotP = 1 - dot(IN.viewDir, o.Normal);  // blue when face the same direction

            _MyColor.x = dotP;

            // if (dotP == 0)
            //     _MyColor.r = _Color0.rgb;
            // else
            //     _MyColor.rgb = _Color90.rgb;

            // if (dotP == 1)
            // {
            //     // _MyColor.x = DecodeFloatRGBA(_Color1);

            //     _MyColor.x = _Color1.x;
            // }
            // else if (dotP == -1)
            // {
            //     _MyColor.x = _Color0.x;
            // }
            // else
            // {
            //     _MyColor.x = _Color90.x;
            // }
            

            //o.Albedo = _MyColor.rgb;

            //o.Albedo = float3(_MyColor.x, 1, 1);

            o.Albedo.rgb = float3(1, 1 - dotP, 0);
            // o.Albedo.rg = float2(IN.viewDir.x, 1 - dotP);
            // o.Albedo.rg = float2(IN.viewDir, 1 - dot(IN.viewDir, o.Normal));

            // o.Emission.r        = 1 - dotP;

            // o.Albedo = float3(1, 1, _MyColor.x);

            // o.Albedo = float3(dotP, 1, 1 - dotP);

            // o.Albedo.r          = 1 - dotP;
            // o.Emission.r        = 1 - dotP;

            // o.Albedo = float3(0, _MyColor.x, 1);

            // o.Albedo = float3(1, _MyColor.x, 1);
            // o.Albedo = float3(_MyColor.x, 0, 0);

            // o.Albedo = float3(dotP, 1, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
