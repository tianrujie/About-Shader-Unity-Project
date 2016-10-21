// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/MyDiffuseShader"
{
	Properties
	{
		_Diffuse ("Diffuse",color) = (1,1,1,1)  //材质漫反射颜色
		_Specular("Specular",color) = (1,1,1,1) //高光反射系数
		_Gloss("Gloss",Range(8.0,256)) = 20     //光滑度
	}

	SubShader
	{
	    //
		Tags {"RenderType"="Opaque" "LightMode" = "ForwardBase" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "Lighting.cginc"

			struct a2v
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed3 color: COLOR;
			};

			float4 _Diffuse;
			float4 _Specular;
			float _Gloss;

			v2f vert (a2v v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); //顶点坐标变化

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;//获取环境光

				fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject)); //顶点法线变换

				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz); //光源方向

				fixed3 diffuse = _LightColor0.rgb * _Diffuse * saturate(dot(worldNormal,worldLight));//计算漫反射颜色 Lambert
				//fixed3 diffuse = _LightColor0.rgb * _Diffuse * (0.5*dot(worldNormal,worldLight) + 0.5);//计算漫反射颜色 Half_Lambert

				fixed3 reflectDir = normalize(reflect(-worldLight,worldNormal)); //计算反射方向

				fixed3 viewDir = normalize(_WorldSpaceLightPos0.xyz - mul(unity_ObjectToWorld,v.vertex).xyz); //计算视角方向

				fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(reflectDir,viewDir)),_Gloss); //计算表面高光

				o.color = ambient + diffuse + specular;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				return fixed4(i.color,1);
			}
			ENDCG
		}

	}
}
