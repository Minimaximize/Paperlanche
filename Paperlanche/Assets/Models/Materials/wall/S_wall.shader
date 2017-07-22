// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyEmptyShader"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_plaster_specular("plaster_specular", 2D) = "white" {}
		_Plaster_combination_diff("Plaster_combination_diff", 2D) = "white" {}
		_NormalAltered("Normal Altered", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
		};

		uniform sampler2D _NormalAltered;
		uniform sampler2D _Plaster_combination_diff;
		uniform sampler2D _plaster_specular;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 3,3 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = tex2D( _NormalAltered,i.texcoord_0).xyz;
			o.Albedo = lerp( float4(0.5620674,0.6385992,0.6764706,0) , tex2D( _Plaster_combination_diff,i.texcoord_0) , 0.0 ).xyz;
			o.Smoothness = tex2D( _plaster_specular,i.texcoord_0).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
1875;489;1040;830;1751.358;1143.473;2.811245;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1002.753,177.1463;Float;False;0;-1;2;0;FLOAT2;3,3;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-511.4009,-214.1312;Float;True;Property;_Plaster_combination_diff;Plaster_combination_diff;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;6;-464.9381,-561.6765;Float;False;Constant;_Color0;Color 0;4;0;0.5620674,0.6385992,0.6764706,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-497.231,203.0057;Float;True;Property;_plaster_specular;plaster_specular;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;7;-218.7865,-349.3108;Float;False;0;COLOR;0.0;False;1;FLOAT4;0.0,0,0,0;False;2;FLOAT;0.0;False;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;4;-496.793,-2.273392;Float;True;Property;_NormalAltered;Normal Altered;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;MyEmptyShader;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;3;1;8;0
WireConnection;1;1;8;0
WireConnection;7;0;6;0
WireConnection;7;1;3;0
WireConnection;4;1;8;0
WireConnection;0;0;7;0
WireConnection;0;1;4;0
WireConnection;0;4;1;0
ASEEND*/
//CHKSM=3FB554CCA74D186D605F95093D678AFD041B0DF1