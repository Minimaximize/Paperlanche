// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "carpet"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_carpetnor("carpet-nor", 2D) = "white" {}
		_TexturesCom_Carpet0011_1_seamless_S("TexturesCom_Carpet0011_1_seamless_S", 2D) = "white" {}
		_carpetspec("carpet spec", 2D) = "white" {}
		_carpetsmooth("carpet smooth", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _carpetnor;
		uniform float4 _carpetnor_ST;
		uniform sampler2D _TexturesCom_Carpet0011_1_seamless_S;
		uniform float4 _TexturesCom_Carpet0011_1_seamless_S_ST;
		uniform sampler2D _carpetspec;
		uniform float4 _carpetspec_ST;
		uniform sampler2D _carpetsmooth;
		uniform float4 _carpetsmooth_ST;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_carpetnor = i.uv_texcoord * _carpetnor_ST.xy + _carpetnor_ST.zw;
			o.Normal = tex2D( _carpetnor,uv_carpetnor).xyz;
			float2 uv_TexturesCom_Carpet0011_1_seamless_S = i.uv_texcoord * _TexturesCom_Carpet0011_1_seamless_S_ST.xy + _TexturesCom_Carpet0011_1_seamless_S_ST.zw;
			o.Albedo = lerp( float4(0.2614619,0.3623434,0.3823529,0) , tex2D( _TexturesCom_Carpet0011_1_seamless_S,uv_TexturesCom_Carpet0011_1_seamless_S) , 0.5 ).xyz;
			float2 uv_carpetspec = i.uv_texcoord * _carpetspec_ST.xy + _carpetspec_ST.zw;
			o.Specular = tex2D( _carpetspec,uv_carpetspec).xyz;
			float2 uv_carpetsmooth = i.uv_texcoord * _carpetsmooth_ST.xy + _carpetsmooth_ST.zw;
			o.Smoothness = tex2D( _carpetsmooth,uv_carpetsmooth).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
2014;515;1040;830;1244.803;838.301;2;True;False
Node;AmplifyShaderEditor.ColorNode;5;-470.9002,-524.3991;Float;False;Constant;_Color0;Color 0;4;0;0.2614619,0.3623434,0.3823529,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;2;-565.1007,-290.1995;Float;True;Property;_TexturesCom_Carpet0011_1_seamless_S;TexturesCom_Carpet0011_1_seamless_S;1;0;Assets/materials/carpet/TexturesCom_Carpet0011_1_seamless_S.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-592.3008,-77.29962;Float;True;Property;_carpetnor;carpet-nor;0;0;Assets/materials/carpet/carpet-nor.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-602.801,142.5005;Float;True;Property;_carpetsmooth;carpet smooth;3;0;Assets/materials/carpet/carpet smooth.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-433.401,399.2004;Float;True;Property;_carpetspec;carpet spec;2;0;Assets/materials/carpet/carpet spec.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;6;-200.5024,-341.601;Float;False;0;COLOR;0.0;False;1;FLOAT4;0.0,0,0,0;False;2;FLOAT;0.5;False;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;StandardSpecular;carpet;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;6;0;5;0
WireConnection;6;1;2;0
WireConnection;0;0;6;0
WireConnection;0;1;1;0
WireConnection;0;3;3;0
WireConnection;0;4;4;0
ASEEND*/
//CHKSM=1EDF0E72A294A0AC35D1B7DC28C8199B87D55368