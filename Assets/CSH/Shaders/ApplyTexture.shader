﻿Shader "Custom/ApplyTexture"
{
    Properties
    {
        // 텍스쳐 설정
        _MainTex ("Main Texture (RBG)", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
        //LOD 100

        Pass
        {
            //  쉐이더와 그래픽 카드 간에 통역
            CGPROGRAM

            // 빌드 형태, 모양
            #pragma vertex vert

            // 빌드 색상
            #pragma fragment frag

            // 빌트 인 쉐이더
            #include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _Color;
            sampler2D _MainTex;
            //float4 _MainTex_ST;

            // 버텍스 함수
            v2f vert (appdata IN)
            {
                v2f OUT;
                OUT.pos = UnityObjectToClipPos(IN.vertex);
                OUT.uv = IN.uv;
                return OUT;
            }

            // 프래그맨트 함수
            fixed4 frag (v2f IN) : SV_Target
            {
                float4 texColor = tex2D(_MainTex, IN.uv);
                //fixed4 col = tex2D(_MainTex, IN.uv);
                return texColor * _Color;
            }
            ENDCG
        }
    }
}
