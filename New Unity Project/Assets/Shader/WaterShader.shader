Shader "Custom/WaterShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpeedX ("X scroll Speed", Range(0,10)) = 2
		_SpeedY ("Y scroll Speed", Range(0,10)) = 2

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _SpeedX;
		half _SpeedY;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {

		    fixed2 scrolledUV= IN.uv_MainTex;

		    fixed xSpeed = _SpeedX*_Time;
		    fixed ySpeed = _SpeedY*_Time;

		    scrolledUV += fixed2(xSpeed,ySpeed);

			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, scrolledUV)* _Color ;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
