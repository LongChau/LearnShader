Shader "Custom/MyLogicalCutoff"
{
    Properties
    {
        _MainTex ("Main Texture", 2D)                       =       "White" {}
        _RimColor ("Rim Color", Color)                      =       (0.0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0))            =       3.0
        _StripeWidth ("Stripe Width", Range(1, 20))         =       10
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldPos;
        };

        float4  _RimColor;
        float   _RimPower;
        float   _StripeWidth;

        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo.rgb        = tex2D(_MainTex, IN.uv_MainTex);
            half rim        = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y * _StripeWidth * 0.5) > 0.4 ? 
                    float3(0, 1, 0) * rim : float3(1, 0, 0) * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
