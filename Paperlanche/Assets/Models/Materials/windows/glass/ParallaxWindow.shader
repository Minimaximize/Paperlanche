// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UserSamples/ParallaxWindow"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Back("Back", 2D) = "white" {}
		_BackDark("Back Dark", Float) = 0.7
		_BackDepthScale("Back Depth Scale", Range( 0 , 1)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 2.5
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 texcoord_0;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform sampler2D _Back;
		uniform fixed _BackDepthScale;
		uniform fixed _BackDark;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 0.3,0.3 ) + float2( 0.3,0.3 );
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			o.Normal = fixed3(0,0,1);
			float2 Offset75 = ( ( 0.0 - 1.0 ) * i.viewDir.xy * _BackDepthScale ) + i.texcoord_0;
			float2 OffsetBack = Offset75;
			o.Albedo = ( tex2D( _Back,OffsetBack) * _BackDark ).xyz;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
2091;513;1040;830;96.71347;40.84224;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1716.362,402.5095;Float;False;0;-1;2;0;FLOAT2;0.3,0.3;False;1;FLOAT2;0.3,0.3;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;85;-1416.174,174.5851;Float;False;0;FLOAT2;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;54;-1339.354,167.9353;Float;False;Property;_BackDepthScale;Back Depth Scale;3;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;51;-1104.096,239.0735;Float;False;Tangent;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ParallaxMappingNode;75;-953.2018,119.736;Float;False;Normal;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-627.5119,138.6462;Float;False;OffsetBack;1;False;0;FLOAT2;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;45;-326.5037,181.3044;Float;True;Property;_Back;Back;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;61;-131.8694,395.756;Float;False;Property;_BackDark;Back Dark;2;0;0.7;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;112.1981,277.5027;Float;False;0;FLOAT4;0,0,0,0;False;1;FLOAT;0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.WireNode;86;-1398.606,375.6921;Float;False;0;FLOAT2;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.Vector3Node;50;606.1962,439.9033;Float;False;Constant;_Vector0;Vector 0;-1;0;0,0,1;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ParallaxMappingNode;76;-946.2023,332.5014;Float;False;Normal;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-619.4551,390.4736;Float;False;OffsetMid;2;False;0;FLOAT2;0.0,0;False;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;49;-1354.041,412.4043;Float;False;Property;_MidDepthScale;Mid Depth Scale;6;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1026.3,428.7931;Fixed;False;True;1;Fixed;ASEMaterialInspector;0;StandardSpecular;UserSamples/ParallaxWindow;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0.0;False;7;FLOAT3;0.0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;85;0;9;0
WireConnection;75;0;85;0
WireConnection;75;2;54;0
WireConnection;75;3;51;0
WireConnection;70;0;75;0
WireConnection;45;1;70;0
WireConnection;59;0;45;0
WireConnection;59;1;61;0
WireConnection;86;0;9;0
WireConnection;76;0;86;0
WireConnection;76;2;49;0
WireConnection;76;3;51;0
WireConnection;15;0;76;0
WireConnection;0;0;59;0
WireConnection;0;1;50;0
ASEEND*/
//CHKSM=917C61623510C9EA271244D7E9D7014D8A80A2FF