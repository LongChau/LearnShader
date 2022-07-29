Shader "Custom/MyLogicalCutoff"
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
            float3 worldPos;
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
            //o.Emission      = _RimColor.rgb * pow(rim, _RimPower);

            // => outline effect (Just look like it) (1)
            // o.Emission      = rim > 0.5 ? float3(1, 0, 0) : rim > 0.3 ? float3(0, 1, 0) : 0;

            // (2)
            // (1) <=> (2)
            // Nhin nhu hieu ung hong ngoai
            // if (rim > 0.5)
            // {
            //     o.Emission = float3(1, 0, 0);
            // }
            // else
            // {
            //     if (rim > 0.3)
            //     {
            //         o.Emission = float3(0, 1, 0);
            //     }
            //     else
            //     {
            //         // o.Emission = 0;
            //         o.Emission = float3(0, 0, 1);
            //     }
            // }

            // nhin hieu ung effect danh cho chieu sang mat troi thay the cho anh sang, hay boi duoi nuoc len. 
            // o.Emission = IN.worldPos.y > 1 ? float3(0, 1, 0) : float3(1, 0, 0);

            // frac 
            // lay ra so du. Nhin nhu Giang Sinh
            // o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0);

            // add depth again
            o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? 
                    float3(0, 1, 0) * rim : float3(1, 0, 0) * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
