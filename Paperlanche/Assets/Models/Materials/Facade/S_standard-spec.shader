// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_standard-spec"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
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

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Normal = tex2D( _TextureSample1,uv_TextureSample1).rgb;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode1 = tex2D( _TextureSample0,uv_TextureSample0);
			float4 appendResult4 = float4( tex2DNode1.r , tex2DNode1.g , tex2DNode1.b , 0 );
			o.Albedo = lerp( float4(0.8529412,0.6252595,0.5017301,0) , appendResult4 , 0.7 ).xyz;
			o.Smoothness = tex2DNode1.a;
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float4 temp_cast_3 = (1.0).xxxx;
			o.Occlusion = lerp( tex2D( _TextureSample2,uv_TextureSample2) , temp_cast_3 , 0.5 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
1955;486;1040;830;873.1205;414.5603;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-733.1951,-70.9996;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.AppendNode;4;-395.1946,-45.79948;Float;False;FLOAT4;0;0;0;0;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.ColorNode;10;-479.12,-311.1603;Float;False;Constant;_Color0;Color 0;3;0;0.8529412,0.6252595,0.5017301,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-617.7951,450.6006;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-501.5607,641.3831;Float;False;Constant;_Float0;Float 0;3;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SamplerNode;2;-588.3945,199.0001;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;8;-215.1214,465.5432;Float;False;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;2;FLOAT;0.5;False;COLOR
Node;AmplifyShaderEditor.LerpOp;6;-127.597,-170.6993;Float;False;0;COLOR;0.0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0.7;False;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;StandardSpecular;S_standard-spec;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;4;0;1;1
WireConnection;4;1;1;2
WireConnection;4;2;1;3
WireConnection;8;0;5;0
WireConnection;8;1;9;0
WireConnection;6;0;10;0
WireConnection;6;1;4;0
WireConnection;0;0;6;0
WireConnection;0;1;2;0
WireConnection;0;4;1;4
WireConnection;0;5;8;0
ASEEND*/
//CHKSM=DDF4C1E9DB660326562FC08BAE19BE9CDB232B07