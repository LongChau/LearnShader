Shader "Custom/MyRimLighting"
{
    Properties
    {
        _RimColor ("Rim Color", Color)              = (0.0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0))    = 3.0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir;
        };

        float4  _RimColor;
        float   _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
            // use saturate to clamp value from 0 -> 1
            // because rim = -1 not means anything. Worthless.
            half rim        = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));

            // use pow to archieve the effect that make intensive stays up for a while at the outer edges
            // before quickly drop-off
            o.Emission      = _RimColor.rgb * pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
