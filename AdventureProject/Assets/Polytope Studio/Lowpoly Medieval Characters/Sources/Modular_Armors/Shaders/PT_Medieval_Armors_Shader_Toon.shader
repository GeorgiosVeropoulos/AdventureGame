// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Polytope Studio/ PT_Medieval Armors Shader Toon"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin][HDR]_SKINCOLOR("SKIN COLOR", Color) = (0.6792453,0.4017712,0.3300107,1)
		[HDR]_EYESCOLOR("EYES COLOR", Color) = (0.02723388,0.1132075,0.02941043,0)
		[HDR]_HAIRCOLOR("HAIR COLOR", Color) = (0.2924528,0.152883,0.03448736,0)
		[HDR]_SCLERACOLOR("SCLERA COLOR", Color) = (0.9056604,0.8159487,0.8159487,0)
		[HDR]_LIPSCOLOR("LIPS COLOR", Color) = (0.8301887,0.3185886,0.2780349,0)
		[HDR]_SCARSCOLOR("SCARS COLOR", Color) = (0.8490566,0.5037117,0.3884835,0)
		[HDR]_METAL1COLOR("METAL 1 COLOR", Color) = (0.8117647,0.3651657,0,0)
		[HDR]_METAL2COLOR("METAL 2 COLOR", Color) = (0.2768779,0.3082185,0.3207547,0)
		[HDR]_METAL3COLOR("METAL 3 COLOR", Color) = (0.04565683,0.04565683,0.05660379,0)
		[HDR]_LEATHER1COLOR("LEATHER 1 COLOR", Color) = (0.5,0.3367247,0.1438679,0)
		[HDR]_LEATHER2COLOR("LEATHER 2 COLOR", Color) = (0.2264151,0.1746179,0.1591314,0)
		[HDR]_LEATHER3COLOR("LEATHER 3 COLOR", Color) = (0.3207547,0.196269,0.1376825,0)
		[HDR]_CLOTH1COLOR("CLOTH 1 COLOR", Color) = (0.1465379,0.282117,0.3490566,0)
		[HDR]_CLOTH2COLOR("CLOTH 2 COLOR", Color) = (0.6226415,0,0,0)
		[HDR]_CLOTH3COLOR("CLOTH 3 COLOR", Color) = (0.4339623,0.3827875,0.3827875,0)
		[HDR]_GEMS1COLOR("GEMS 1 COLOR", Color) = (0.3773585,0,0.06650025,0)
		[HDR]_GEMS2COLOR("GEMS 2 COLOR", Color) = (0.2023368,0,0.4339623,0)
		[HDR]_GEMS3COLOR("GEMS 3 COLOR", Color) = (0,0.1132075,0.01206957,0)
		[HDR]_FEATHERS1COLOR("FEATHERS 1 COLOR", Color) = (0.7735849,0.492613,0.492613,0)
		[HDR]_FEATHERS2COLOR("FEATHERS 2 COLOR", Color) = (0.6792453,0,0,0)
		[HDR]_FEATHERS3COLOR("FEATHERS 3 COLOR", Color) = (0,0.1793142,0.7264151,0)
		[HideInInspector]_Texture0("Texture 0", 2D) = "white" {}
		[HideInInspector]_Texture1("Texture 1", 2D) = "white" {}
		[HideInInspector]_Texture6("Texture 6", 2D) = "white" {}
		[HideInInspector]_Texture3("Texture 3", 2D) = "white" {}
		[HideInInspector]_Texture5("Texture 5", 2D) = "white" {}
		[HideInInspector]_Texture2("Texture 2", 2D) = "white" {}
		[HideInInspector]_Texture4("Texture 4", 2D) = "white" {}
		[HideInInspector]_Texture7("Texture 7", 2D) = "white" {}
		[HDR]_COATOFARMSCOLOR("COAT OF ARMS COLOR", Color) = (1,0,0,0)
		[NoScaleOffset]_COATOFARMSMASK("COAT OF ARMS MASK", 2D) = "black" {}
		_LIGHT1SIZE("LIGHT 1 SIZE", Range( 0 , 1)) = 0.1
		_LIGHT2SIZE("LIGHT 2 SIZE", Range( 0 , 1)) = 0.4
		_LIGHT3SIZE("LIGHT 3 SIZE", Range( 0 , 1)) = 0.8
		_LIGHT1POWER("LIGHT 1 POWER", Range( 0 , 1)) = 0.15
		_LIGHT2POWER("LIGHT 2 POWER", Range( 0 , 1)) = 0.15
		_LIGHT3POWER("LIGHT 3 POWER", Range( 0 , 1)) = 0.15
		[HDR]_LIGHT1COLOR("LIGHT 1 COLOR", Color) = (1,1,1,0)
		[HDR]_LIGHT2COLOR("LIGHT 2 COLOR", Color) = (1,1,1,0)
		[ASEEnd][HDR]_LIGHT3COLOR("LIGHT 3 COLOR", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Back
		AlphaToMask Off
		HLSLINCLUDE
		#pragma target 2.0

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Texture2_ST;
			float4 _LIGHT2COLOR;
			float4 _LIGHT1COLOR;
			float4 _COATOFARMSCOLOR;
			float4 _SKINCOLOR;
			float4 _HAIRCOLOR;
			float4 _Texture0_ST;
			float4 _EYESCOLOR;
			float4 _SCLERACOLOR;
			float4 _LIPSCOLOR;
			float4 _Texture1_ST;
			float4 _SCARSCOLOR;
			float4 _METAL1COLOR;
			float4 _LIGHT3COLOR;
			float4 _Texture6_ST;
			float4 _METAL3COLOR;
			float4 _METAL2COLOR;
			float4 _LEATHER2COLOR;
			float4 _GEMS3COLOR;
			float4 _Texture7_ST;
			float4 _GEMS2COLOR;
			float4 _GEMS1COLOR;
			float4 _LEATHER1COLOR;
			float4 _Texture4_ST;
			float4 _FEATHERS2COLOR;
			float4 _FEATHERS3COLOR;
			float4 _CLOTH3COLOR;
			float4 _Texture5_ST;
			float4 _CLOTH2COLOR;
			float4 _CLOTH1COLOR;
			float4 _LEATHER3COLOR;
			float4 _Texture3_ST;
			float4 _FEATHERS1COLOR;
			float _LIGHT1SIZE;
			float _LIGHT1POWER;
			float _LIGHT2SIZE;
			float _LIGHT2POWER;
			float _LIGHT3SIZE;
			float _LIGHT3POWER;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _Texture2;
			sampler2D _Texture7;
			sampler2D _Texture4;
			sampler2D _Texture5;
			sampler2D _Texture3;
			sampler2D _Texture6;
			sampler2D _Texture1;
			sampler2D _Texture0;
			sampler2D _COATOFARMSMASK;
			SAMPLER(sampler_COATOFARMSMASK);


						
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				o.ase_texcoord3.zw = v.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif
				float2 uv_Texture2 = IN.ase_texcoord3.xy * _Texture2_ST.xy + _Texture2_ST.zw;
				float4 tex2DNode199 = tex2D( _Texture2, uv_Texture2 );
				float2 uv_Texture7 = IN.ase_texcoord3.xy * _Texture7_ST.xy + _Texture7_ST.zw;
				float4 tex2DNode222 = tex2D( _Texture7, uv_Texture7 );
				float3 temp_cast_0 = (tex2DNode222.b).xxx;
				float4 lerpResult219 = lerp( float4( 0,0,0,0 ) , ( tex2DNode199 * _GEMS3COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_0 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_1 = (tex2DNode222.g).xxx;
				float4 lerpResult214 = lerp( lerpResult219 , ( tex2DNode199 * _GEMS2COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_1 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_2 = (tex2DNode222.r).xxx;
				float4 lerpResult217 = lerp( lerpResult214 , ( tex2DNode199 * _GEMS1COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_2 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture4 = IN.ase_texcoord3.xy * _Texture4_ST.xy + _Texture4_ST.zw;
				float4 tex2DNode181 = tex2D( _Texture4, uv_Texture4 );
				float3 temp_cast_3 = (tex2DNode181.b).xxx;
				float4 lerpResult182 = lerp( lerpResult217 , ( tex2DNode199 * _FEATHERS3COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_3 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_4 = (tex2DNode181.g).xxx;
				float4 lerpResult189 = lerp( lerpResult182 , ( tex2DNode199 * _FEATHERS2COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_4 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_5 = (tex2DNode181.r).xxx;
				float4 lerpResult184 = lerp( lerpResult189 , ( tex2DNode199 * _FEATHERS1COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_5 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture5 = IN.ase_texcoord3.xy * _Texture5_ST.xy + _Texture5_ST.zw;
				float4 tex2DNode170 = tex2D( _Texture5, uv_Texture5 );
				float3 temp_cast_6 = (tex2DNode170.b).xxx;
				float4 lerpResult171 = lerp( lerpResult184 , ( tex2DNode199 * _CLOTH3COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_6 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_7 = (tex2DNode170.g).xxx;
				float4 lerpResult178 = lerp( lerpResult171 , ( tex2DNode199 * _CLOTH2COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_7 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_8 = (tex2DNode170.r).xxx;
				float4 lerpResult173 = lerp( lerpResult178 , ( tex2DNode199 * _CLOTH1COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_8 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture3 = IN.ase_texcoord3.xy * _Texture3_ST.xy + _Texture3_ST.zw;
				float4 tex2DNode159 = tex2D( _Texture3, uv_Texture3 );
				float3 temp_cast_9 = (tex2DNode159.b).xxx;
				float4 lerpResult160 = lerp( lerpResult173 , ( tex2DNode199 * _LEATHER3COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_9 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_10 = (tex2DNode159.g).xxx;
				float4 lerpResult167 = lerp( lerpResult160 , ( tex2DNode199 * _LEATHER2COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_10 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_11 = (tex2DNode159.r).xxx;
				float4 lerpResult162 = lerp( lerpResult167 , ( tex2DNode199 * _LEATHER1COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_11 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture6 = IN.ase_texcoord3.xy * _Texture6_ST.xy + _Texture6_ST.zw;
				float4 tex2DNode121 = tex2D( _Texture6, uv_Texture6 );
				float3 temp_cast_12 = (tex2DNode121.b).xxx;
				float4 lerpResult118 = lerp( lerpResult162 , ( tex2DNode199 * _METAL3COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_12 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_13 = (tex2DNode121.g).xxx;
				float4 lerpResult128 = lerp( lerpResult118 , ( tex2DNode199 * _METAL2COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_13 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_14 = (tex2DNode121.r).xxx;
				float4 lerpResult122 = lerp( lerpResult128 , ( tex2DNode199 * _METAL1COLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_14 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture1 = IN.ase_texcoord3.xy * _Texture1_ST.xy + _Texture1_ST.zw;
				float4 tex2DNode144 = tex2D( _Texture1, uv_Texture1 );
				float3 temp_cast_15 = (tex2DNode144.b).xxx;
				float4 lerpResult148 = lerp( lerpResult122 , ( tex2DNode199 * _SCARSCOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_15 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_16 = (tex2DNode144.g).xxx;
				float4 lerpResult151 = lerp( lerpResult148 , ( tex2DNode199 * _LIPSCOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_16 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_17 = (tex2DNode144.r).xxx;
				float4 lerpResult153 = lerp( lerpResult151 , ( tex2DNode199 * _SCLERACOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_17 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv_Texture0 = IN.ase_texcoord3.xy * _Texture0_ST.xy + _Texture0_ST.zw;
				float4 tex2DNode37 = tex2D( _Texture0, uv_Texture0 );
				float3 temp_cast_18 = (tex2DNode37.b).xxx;
				float4 lerpResult73 = lerp( lerpResult153 , ( tex2DNode199 * _EYESCOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_18 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_19 = (tex2DNode37.g).xxx;
				float4 lerpResult69 = lerp( lerpResult73 , ( tex2DNode199 * _HAIRCOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_19 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float3 temp_cast_20 = (tex2DNode37.r).xxx;
				float4 lerpResult62 = lerp( lerpResult69 , ( tex2DNode199 * _SKINCOLOR ) , saturate( ( 1.0 - ( ( distance( temp_cast_20 , float3( 0,0,0 ) ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
				float2 uv2_COATOFARMSMASK10 = IN.ase_texcoord3.zw;
				float temp_output_9_0 = ( 1.0 - tex2D( _COATOFARMSMASK, uv2_COATOFARMSMASK10 ).a );
				float4 temp_cast_21 = (temp_output_9_0).xxxx;
				float4 temp_output_1_0_g141 = temp_cast_21;
				float4 color25 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float4 temp_output_2_0_g141 = color25;
				float temp_output_11_0_g141 = distance( temp_output_1_0_g141 , temp_output_2_0_g141 );
				float2 _Vector0 = float2(1.6,1);
				float4 lerpResult21_g141 = lerp( _COATOFARMSCOLOR , temp_output_1_0_g141 , saturate( ( ( temp_output_11_0_g141 - _Vector0.x ) / max( _Vector0.y , 1E-05 ) ) ));
				float4 lerpResult64 = lerp( lerpResult62 , lerpResult21_g141 , ( 1.0 - temp_output_9_0 ));
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord4.xyz;
				float fresnelNdotV369 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode369 = ( 0.0 + 1.0 * pow( max( 1.0 - fresnelNdotV369 , 0.0001 ), 1.0 ) );
				float4 temp_cast_22 = (step( fresnelNode369 , _LIGHT1SIZE )).xxxx;
				float4 blendOpSrc689 = temp_cast_22;
				float4 blendOpDest689 = _LIGHT1COLOR;
				float4 temp_cast_23 = ((0.0 + (_LIGHT1POWER - 0.0) * (3.0 - 0.0) / (1.0 - 0.0))).xxxx;
				float4 blendOpSrc683 = ( saturate( ( blendOpSrc689 * blendOpDest689 ) ));
				float4 blendOpDest683 = temp_cast_23;
				float4 blendOpSrc661 = ( blendOpSrc683 * blendOpDest683 );
				float4 blendOpDest661 = lerpResult64;
				float fresnelNdotV365 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode365 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV365, 1.0 ) );
				float4 temp_cast_24 = (step( fresnelNode365 , _LIGHT2SIZE )).xxxx;
				float4 blendOpSrc696 = temp_cast_24;
				float4 blendOpDest696 = _LIGHT2COLOR;
				float4 temp_cast_25 = ((0.0 + (_LIGHT2POWER - 0.0) * (3.0 - 0.0) / (1.0 - 0.0))).xxxx;
				float4 blendOpSrc686 = ( saturate( ( blendOpSrc696 * blendOpDest696 ) ));
				float4 blendOpDest686 = temp_cast_25;
				float4 blendOpSrc662 = ( blendOpSrc686 * blendOpDest686 );
				float4 blendOpDest662 = lerpResult64;
				float fresnelNdotV368 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode368 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV368, 1.0 ) );
				float4 temp_cast_26 = (step( fresnelNode368 , _LIGHT3SIZE )).xxxx;
				float4 blendOpSrc698 = temp_cast_26;
				float4 blendOpDest698 = _LIGHT3COLOR;
				float4 temp_cast_27 = ((0.0 + (_LIGHT3POWER - 0.0) * (3.0 - 0.0) / (1.0 - 0.0))).xxxx;
				float4 blendOpSrc687 = ( saturate( ( blendOpSrc698 * blendOpDest698 ) ));
				float4 blendOpDest687 = temp_cast_27;
				float4 blendOpSrc663 = ( blendOpSrc687 * blendOpDest687 );
				float4 blendOpDest663 = lerpResult64;
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( lerpResult64 + ( ( blendOpSrc661 * blendOpDest661 ) + ( saturate( ( blendOpSrc662 * blendOpDest662 ) )) + ( saturate( ( blendOpSrc663 * blendOpDest663 ) )) ) ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Texture2_ST;
			float4 _LIGHT2COLOR;
			float4 _LIGHT1COLOR;
			float4 _COATOFARMSCOLOR;
			float4 _SKINCOLOR;
			float4 _HAIRCOLOR;
			float4 _Texture0_ST;
			float4 _EYESCOLOR;
			float4 _SCLERACOLOR;
			float4 _LIPSCOLOR;
			float4 _Texture1_ST;
			float4 _SCARSCOLOR;
			float4 _METAL1COLOR;
			float4 _LIGHT3COLOR;
			float4 _Texture6_ST;
			float4 _METAL3COLOR;
			float4 _METAL2COLOR;
			float4 _LEATHER2COLOR;
			float4 _GEMS3COLOR;
			float4 _Texture7_ST;
			float4 _GEMS2COLOR;
			float4 _GEMS1COLOR;
			float4 _LEATHER1COLOR;
			float4 _Texture4_ST;
			float4 _FEATHERS2COLOR;
			float4 _FEATHERS3COLOR;
			float4 _CLOTH3COLOR;
			float4 _Texture5_ST;
			float4 _CLOTH2COLOR;
			float4 _CLOTH1COLOR;
			float4 _LEATHER3COLOR;
			float4 _Texture3_ST;
			float4 _FEATHERS1COLOR;
			float _LIGHT1SIZE;
			float _LIGHT1POWER;
			float _LIGHT2SIZE;
			float _LIGHT2POWER;
			float _LIGHT3SIZE;
			float _LIGHT3POWER;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			

			
			float3 _LightDirection;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				float3 normalWS = TransformObjectToWorldDir( v.ase_normal );

				float4 clipPos = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = clipPos;

				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Texture2_ST;
			float4 _LIGHT2COLOR;
			float4 _LIGHT1COLOR;
			float4 _COATOFARMSCOLOR;
			float4 _SKINCOLOR;
			float4 _HAIRCOLOR;
			float4 _Texture0_ST;
			float4 _EYESCOLOR;
			float4 _SCLERACOLOR;
			float4 _LIPSCOLOR;
			float4 _Texture1_ST;
			float4 _SCARSCOLOR;
			float4 _METAL1COLOR;
			float4 _LIGHT3COLOR;
			float4 _Texture6_ST;
			float4 _METAL3COLOR;
			float4 _METAL2COLOR;
			float4 _LEATHER2COLOR;
			float4 _GEMS3COLOR;
			float4 _Texture7_ST;
			float4 _GEMS2COLOR;
			float4 _GEMS1COLOR;
			float4 _LEATHER1COLOR;
			float4 _Texture4_ST;
			float4 _FEATHERS2COLOR;
			float4 _FEATHERS3COLOR;
			float4 _CLOTH3COLOR;
			float4 _Texture5_ST;
			float4 _CLOTH2COLOR;
			float4 _CLOTH1COLOR;
			float4 _LEATHER3COLOR;
			float4 _Texture3_ST;
			float4 _FEATHERS1COLOR;
			float _LIGHT1SIZE;
			float _LIGHT1POWER;
			float _LIGHT2SIZE;
			float _LIGHT2POWER;
			float _LIGHT3SIZE;
			float _LIGHT3POWER;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			

			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = TransformWorldToHClip( positionWS );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18500
92;435;1906;920;4466.469;343.5687;3.011253;True;True
Node;AmplifyShaderEditor.CommentaryNode;228;-18395.06,107.5165;Inherit;False;2305.307;694.8573;Comment;14;223;219;218;222;221;215;216;214;213;217;220;229;230;231;GEMS COLORS;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;204;-10950.96,81.85144;Inherit;False;2342.301;700.673;Comment;14;163;159;203;166;165;202;160;161;201;158;164;167;162;157;LEATHER COLORS;0.7735849,0.5371538,0.1788003,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;212;-15940.94,100.0198;Inherit;False;2305.3;694.8572;Comment;14;183;185;182;188;184;180;181;187;189;186;179;224;225;226;FEATHERS COLORS;0.735849,0.7152051,0.3158597,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;208;-13458.26,101.9824;Inherit;False;2359.399;695.7338;Comment;14;168;175;173;178;170;172;169;174;176;177;171;209;211;210;CLOTH COLORS;0.4690726,0.7830189,0.47128,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;190;-5786.208,60.18156;Inherit;False;2305.296;707.5152;Comment;14;143;144;156;145;155;148;149;150;154;151;153;191;192;193;LIPS - SCARS - SCLERA COLORS;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;200;-19714.45,103.7145;Inherit;False;680.9902;282.8338;Comment;2;198;199;BASE TEXTURE;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;194;-8397.117,81.08585;Inherit;False;2305.301;694.8571;Comment;14;130;121;126;117;118;127;120;128;119;122;123;195;196;197;METAL COLORS;0.259434,0.8569208,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;360;-2384.559,956.9141;Inherit;False;2541.61;1272.682;Comment;32;379;662;663;661;686;559;560;390;683;687;688;684;685;374;371;370;369;367;368;365;364;366;362;361;363;689;690;695;697;699;700;701;TOON;0.990566,0.1822268,0.8019541,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1812.858,-1400.5;Inherit;False;1262.249;589.4722;;10;16;18;26;25;17;9;10;290;293;294;COAT OF ARMS;1,0,0.7651567,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;102;-3284.644,71.51185;Inherit;False;2305.298;694.8571;Comment;14;77;37;74;71;75;67;41;73;69;63;62;634;635;636;SKIN - HAIR - EYES COLORS;1,0,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;118;-7473.041,351.4701;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;-16457.13,164.9575;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;198;-19670.35,151.9277;Inherit;True;Property;_Texture2;Texture 2;26;1;[HideInInspector];Create;True;0;0;False;0;False;004b7cabc9421734bb88a754e99fd641;004b7cabc9421734bb88a754e99fd641;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.BlendOpsNode;662;-345.4095,1304.167;Inherit;False;Multiply;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;-7035.995,133.4648;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;210;-12318.56,167.2369;Inherit;False;Property;_CLOTH2COLOR;CLOTH 2 COLOR;13;1;[HDR];Create;True;0;0;False;0;False;0.6226415,0,0,0;0.6226415,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;162;-8792.659,347.0186;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;226;-14298.42,166.8393;Inherit;False;Property;_FEATHERS1COLOR;FEATHERS 1 COLOR;18;1;[HDR];Create;True;0;0;False;0;False;0.7735849,0.492613,0.492613,0;0.7735849,0.492613,0.492613,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-12655.9,151.9825;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;178;-11859.63,357.8348;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;700;-848.9835,1463.261;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;185;-15890.94,564.6931;Inherit;True;Property;_Texture4;Texture 4;27;1;[HideInInspector];Create;True;0;0;False;0;False;ae91646efc13ec44f8ccc5b5db2d6a8d;ae91646efc13ec44f8ccc5b5db2d6a8d;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;193;-5276.292,135.8387;Inherit;False;Property;_SCARSCOLOR;SCARS COLOR;5;1;[HDR];Create;True;0;0;False;0;False;0.8490566,0.5037117,0.3884835,0;0.8490566,0.5037117,0.3884835,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;182;-15016.86,370.4042;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;-17033.94,159.8954;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;163;-10900.96,552.5245;Inherit;True;Property;_Texture3;Texture 3;24;1;[HideInInspector];Create;True;0;0;False;0;False;9c0e067347abba2489817b3ce813c911;9c0e067347abba2489817b3ce813c911;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;229;-16691.28,179.7326;Inherit;False;Property;_GEMS1COLOR;GEMS 1 COLOR;15;1;[HDR];Create;True;0;0;False;0;False;0.3773585,0,0.06650025,0;0.3773585,0,0.06650025,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-11466.22,159.4234;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;77;-3234.644,536.1849;Inherit;True;Property;_Texture0;Texture 0;21;1;[HideInInspector];Create;True;0;0;False;0;False;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;209;-11733.9,176.3902;Inherit;False;Property;_CLOTH1COLOR;CLOTH 1 COLOR;12;1;[HDR];Create;True;0;0;False;0;False;0.1465379,0.282117,0.3490566,0;0.1465379,0.282117,0.3490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;144;-5442.563,537.6968;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;189;-14396.41,355.8722;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;224;-15434.72,169.3589;Inherit;False;Property;_FEATHERS3COLOR;FEATHERS 3 COLOR;20;1;[HDR];Create;True;0;0;False;0;False;0,0.1793142,0.7264151,0;0,0.1793142,0.7264151,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;217;-16273.75,372.6839;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;394;-405.1466,380.3712;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;184;-13819.64,365.1873;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;698;-1118.693,1581.753;Inherit;False;Multiply;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;199;-19366.46,153.7145;Inherit;True;Property;_TextureSample2;Texture Sample 2;14;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;222;-18051.41,572.374;Inherit;True;Property;_TextureSample6;Texture Sample 6;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;230;-17263.86,180.9097;Inherit;False;Property;_GEMS2COLOR;GEMS 2 COLOR;16;1;[HDR];Create;True;0;0;False;0;False;0.2023368,0,0.4339623,0;0.2023368,0,0.4339623,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;365;-1958.192,1272.703;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;171;-12480.08,372.3667;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;195;-6732.036,154.556;Inherit;False;Property;_METAL1COLOR;METAL 1 COLOR;6;1;[HDR];Create;True;0;0;False;0;False;0.8117647,0.3651657,0,0;0.8117647,0.3651657,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;220;-18345.06,572.19;Inherit;True;Property;_Texture7;Texture 7;28;1;[HideInInspector];Create;True;0;0;False;0;False;7d388dc79e41c6f498271666b30c0630;7d388dc79e41c6f498271666b30c0630;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;231;-17873.24,175.481;Inherit;False;Property;_GEMS3COLOR;GEMS 3 COLOR;17;1;[HDR];Create;True;0;0;False;0;False;0,0.1132075,0.01206957,0;0,0.1132075,0.01206957,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;196;-7295.61,136.1474;Inherit;False;Property;_METAL2COLOR;METAL 2 COLOR;7;1;[HDR];Create;True;0;0;False;0;False;0.2768779,0.3082185,0.3207547,0;0.2768779,0.3082185,0.3207547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;201;-9256.154,158.072;Inherit;False;Property;_LEATHER1COLOR;LEATHER 1 COLOR;9;1;[HDR];Create;True;0;0;False;0;False;0.5,0.3367247,0.1438679,0;0.5,0.3367247,0.1438679,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;143;-5736.208,537.5127;Inherit;True;Property;_Texture1;Texture 1;22;1;[HideInInspector];Create;True;0;0;False;0;False;9a688ecd3c6cbee4cb2a528bf72399d4;9a688ecd3c6cbee4cb2a528bf72399d4;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;180;-14617.37,604.2701;Inherit;False;Color Mask;-1;;143;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;179;-14090.69,579.3669;Inherit;False;Color Mask;-1;;149;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;176;-12680.84,613.952;Inherit;False;Color Mask;-1;;147;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;169;-12080.59,606.2324;Inherit;False;Color Mask;-1;;148;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;168;-11560.99,591.9452;Inherit;False;Color Mask;-1;;153;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;165;-10167.64,599.1292;Inherit;False;Color Mask;-1;;154;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;158;-9590.39,586.1017;Inherit;False;Color Mask;-1;;155;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;157;-9063.711,561.1985;Inherit;False;Color Mask;-1;;145;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;117;-7675.571,594.8251;Inherit;False;Color Mask;-1;;151;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;127;-7100.835,576.2403;Inherit;False;Color Mask;-1;;156;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;123;-6546.868,560.433;Inherit;False;Color Mask;-1;;136;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;145;-5066.379,586.5791;Inherit;False;Color Mask;-1;;144;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;149;-4462.642,577.0893;Inherit;True;Color Mask;-1;;139;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;150;-3935.964,552.1868;Inherit;True;Color Mask;-1;;137;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;71;-2618.101,582.2063;Inherit;False;Color Mask;-1;;134;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;187;-15251.39,613.759;Inherit;False;Color Mask;-1;;152;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1772.04,-1329.646;Inherit;True;Property;_COATOFARMSMASK;COAT OF ARMS MASK;30;1;[NoScaleOffset];Create;True;0;0;False;0;False;10;d294e9544b9eca64188ea9d2482ea8a1;d294e9544b9eca64188ea9d2482ea8a1;True;1;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;213;-16544.81,586.8638;Inherit;False;Color Mask;-1;;142;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;215;-17673.51,621.2559;Inherit;False;Color Mask;-1;;150;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;211;-12946.7,169.5253;Inherit;False;Property;_CLOTH3COLOR;CLOTH 3 COLOR;14;1;[HDR];Create;True;0;0;False;0;False;0.4339623,0.3827875,0.3827875,0;0.4339623,0.3827875,0.3827875,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;225;-14843.42,170.8393;Inherit;False;Property;_FEATHERS2COLOR;FEATHERS 2 COLOR;19;1;[HDR];Create;True;0;0;False;0;False;0.6792453,0,0,0;0.6792453,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;181;-15597.29,564.877;Inherit;True;Property;_TextureSample5;Texture Sample 5;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;362;-2290.99,1147.003;Inherit;False;Constant;_2;2;35;0;Create;True;0;0;False;0;False;1;0.3991557;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;697;-1341.959,1671.755;Inherit;False;Property;_LIGHT3COLOR;LIGHT 3 COLOR;39;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;690;-1382.336,1176.092;Inherit;False;Property;_LIGHT1COLOR;LIGHT 1 COLOR;37;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;695;-1338.313,1422.022;Inherit;False;Property;_LIGHT2COLOR;LIGHT 2 COLOR;38;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;-9552.838,134.2304;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;160;-9989.884,352.2355;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;685;-1116.953,1474.047;Inherit;False;Property;_LIGHT2POWER;LIGHT 2 POWER;35;0;Create;True;0;0;False;0;False;0.15;0.206;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;361;-2262.561,1359.56;Inherit;False;Constant;_1;1;32;0;Create;True;0;0;False;0;False;1;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;688;-1102.397,1725.987;Inherit;False;Property;_LIGHT3POWER;LIGHT 3 POWER;36;0;Create;True;0;0;False;0;False;0.15;0.247;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;159;-10570.31,546.7085;Inherit;True;Property;_TextureSample3;Texture Sample 3;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;173;-11282.86,367.1498;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;202;-9846.154,165.072;Inherit;False;Property;_LEATHER2COLOR;LEATHER 2 COLOR;10;1;[HDR];Create;True;0;0;False;0;False;0.2264151,0.1746179,0.1591314,0;0.2264151,0.1746179,0.1591314,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;216;-17057.34,608.2284;Inherit;False;Color Mask;-1;;146;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;214;-16850.53,363.3687;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-4413.934,110.1816;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-17646.8,157.5165;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;192;-4663.813,130.0028;Inherit;False;Property;_LIPSCOLOR;LIPS COLOR;4;1;[HDR];Create;True;0;0;False;0;False;0.8301887,0.3185886,0.2780349,0;0.8301887,0.3185886,0.2780349,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-6459.181,138.5268;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;293;-633.4137,-898.618;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;74;-2781.133,113.9129;Inherit;False;Property;_EYESCOLOR;EYES COLOR;1;1;[HDR];Create;True;0;0;False;0;False;0.02723388,0.1132075,0.02941043,0;0.02723388,0.1132075,0.02941043,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;634;-2498.852,121.8052;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;379;-48.5603,1282.605;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;69;-1747.119,334.3638;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;701;-822.0625,1730.397;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-8976.024,139.2924;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;197;-7995.427,149.6947;Inherit;False;Property;_METAL3COLOR;METAL 3 COLOR;8;1;[HDR];Create;True;0;0;False;0;False;0.04565683,0.04565683,0.05660379,0;0.04565683,0.04565683,0.05660379,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;374;-1422.798,1338.325;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-7648.856,131.0858;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;396;-404.1466,380.3712;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;17;-814.7589,-1227.691;Inherit;False;Replace Color;-1;;141;896dccb3016c847439def376a728b869;1,12,0;5;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-15192.68,150.0198;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;294;-644.1989,-930.3562;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;395;-405.1466,381.3712;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;75;-2221.695,132.1745;Inherit;False;Property;_HAIRCOLOR;HAIR COLOR;2;1;[HDR];Create;True;0;0;False;0;False;0.2924528,0.152883,0.03448736,0;0.2924528,0.152883,0.03448736,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;191;-4083.874,145.6415;Inherit;False;Property;_SCLERACOLOR;SCLERA COLOR;3;1;[HDR];Create;True;0;0;False;0;False;0.9056604,0.8159487,0.8159487,0;0.9056604,0.8159487,0.8159487,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;186;-14003.01,157.4608;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;382;501.8256,334.2374;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;128;-6852.589,336.9381;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;153;-3664.912,338.0065;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;25;-1067.646,-1364.901;Inherit;False;Constant;_Color4;Color 4;1;0;Create;True;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;122;-6275.816,346.2531;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-14579.82,152.3987;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;559;-412.1298,1549.633;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;16;-1249.699,-965.4095;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;18;-1043.557,-1002.802;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;False;1.6,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-12043.04,154.3614;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;203;-10425.53,155.7001;Inherit;False;Property;_LEATHER3COLOR;LEATHER 3 COLOR;11;1;[HDR];Create;True;0;0;False;0;False;0.3207547,0.196269,0.1376825,0;0.3207547,0.196269,0.1376825,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;636;-1350.868,100.2273;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;73;-2347.718,336.1837;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;292;-620.0846,401.4227;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-1435.856,-1221.265;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-5026.458,120.5587;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;686;-704.9259,1334.608;Inherit;False;Multiply;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;684;-1152.591,1217.51;Inherit;False;Property;_LIGHT1POWER;LIGHT 1 POWER;34;0;Create;True;0;0;False;0;False;0.15;0.22;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;363;-2264.815,1559.836;Inherit;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;390;-409.3758,1069.185;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-3838.642,126.7055;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;26;-1063.837,-1185.19;Inherit;False;Property;_COATOFARMSCOLOR;COAT OF ARMS COLOR;29;1;[HDR];Create;True;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;560;-404.1298,1339.633;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;41;-1619.047,133.8244;Inherit;False;Property;_SKINCOLOR;SKIN COLOR;0;1;[HDR];Create;True;0;0;False;0;False;0.6792453,0.4017712,0.3300107,1;0.490566,0.3895603,0.2661089,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-2944.998,538.3689;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;369;-1956.678,1036.234;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;661;-351.4232,1095.355;Inherit;False;Multiply;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;151;-4243.684,339.6917;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;290;-633.3123,-1147.438;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;696;-1115.047,1332.02;Inherit;False;Multiply;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;167;-9369.433,349.9297;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;219;-17470.98,377.9008;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;174;-13408.26,567.7161;Inherit;True;Property;_Texture5;Texture 5;25;1;[HideInInspector];Create;True;0;0;False;0;False;e4f1621d61032d045964d463b3806afe;e4f1621d61032d045964d463b3806afe;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;170;-13060.51,566.8392;Inherit;True;Property;_TextureSample4;Texture Sample 4;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-10170.95,137.1077;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;67;-2006.077,578.7616;Inherit;False;Color Mask;-1;;138;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;368;-1997.462,1519.467;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;687;-694.37,1584.548;Inherit;False;Multiply;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;63;-1434.398,550.8591;Inherit;False;Color Mask;-1;;140;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.1;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;367;-1763.215,1206.693;Inherit;False;Property;_LIGHT1SIZE;LIGHT 1 SIZE;31;0;Create;True;0;0;False;0;False;0.1;0.45;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;64;-583.6503,335.5556;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;699;-868.8555,1208.175;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;683;-760.7569,1072.747;Inherit;False;Multiply;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;130;-8347.117,545.759;Inherit;True;Property;_Texture6;Texture 6;23;1;[HideInInspector];Create;True;0;0;False;0;False;47efbf030a9bb7f428ba51b46a2fdd03;47efbf030a9bb7f428ba51b46a2fdd03;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;121;-8053.467,545.9429;Inherit;True;Property;_TextureSample8;Texture Sample 8;4;1;[HideInInspector];Create;True;0;0;False;0;False;10;b76fe68d69ca53f43a4e6f66d135dd90;b76fe68d69ca53f43a4e6f66d135dd90;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;371;-1481.249,1063.553;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;62;-1163.346,336.6786;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;689;-1114.33,1075.988;Inherit;False;Multiply;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;364;-1744.519,1402.56;Inherit;False;Property;_LIGHT2SIZE;LIGHT 2 SIZE;32;0;Create;True;0;0;False;0;False;0.4;0.243;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;366;-1764.589,1647.723;Inherit;False;Property;_LIGHT3SIZE;LIGHT 3 SIZE;33;0;Create;True;0;0;False;0;False;0.8;0.706;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;635;-1931.09,123.462;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;370;-1455.669,1593.09;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;291;-617.0846,363.4227;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;148;-4849.282,337.5115;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;663;-359.8096,1571.366;Inherit;False;Multiply;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;729;694.2826,334.4562;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;Polytope Studio/ PT_Medieval Armors Shader Toon;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;0;  Blend;0;Two Sided;1;Cast Shadows;1;  Use Shadow Threshold;0;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;0;Built-in Fog;0;DOTS Instancing;0;Meta Pass;0;Extra Pre Pass;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position,InvertActionOnDeselection;1;0;5;False;True;True;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;728;694.2826,334.4562;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;732;694.2826,334.4562;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;731;694.2826,334.4562;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;730;694.2826,334.4562;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;118;0;162;0
WireConnection;118;1;126;0
WireConnection;118;2;117;0
WireConnection;218;0;199;0
WireConnection;218;1;229;0
WireConnection;662;0;686;0
WireConnection;662;1;560;0
WireConnection;120;0;199;0
WireConnection;120;1;196;0
WireConnection;162;0;167;0
WireConnection;162;1;164;0
WireConnection;162;2;157;0
WireConnection;177;0;199;0
WireConnection;177;1;211;0
WireConnection;178;0;171;0
WireConnection;178;1;172;0
WireConnection;178;2;169;0
WireConnection;700;0;685;0
WireConnection;182;0;217;0
WireConnection;182;1;188;0
WireConnection;182;2;187;0
WireConnection;221;0;199;0
WireConnection;221;1;230;0
WireConnection;175;0;199;0
WireConnection;175;1;209;0
WireConnection;144;0;143;0
WireConnection;189;0;182;0
WireConnection;189;1;183;0
WireConnection;189;2;180;0
WireConnection;217;0;214;0
WireConnection;217;1;218;0
WireConnection;217;2;213;0
WireConnection;394;0;64;0
WireConnection;184;0;189;0
WireConnection;184;1;186;0
WireConnection;184;2;179;0
WireConnection;698;0;370;0
WireConnection;698;1;697;0
WireConnection;199;0;198;0
WireConnection;222;0;220;0
WireConnection;365;3;361;0
WireConnection;171;0;184;0
WireConnection;171;1;177;0
WireConnection;171;2;176;0
WireConnection;180;3;181;2
WireConnection;179;3;181;1
WireConnection;176;3;170;3
WireConnection;169;3;170;2
WireConnection;168;3;170;1
WireConnection;165;3;159;3
WireConnection;158;3;159;2
WireConnection;157;3;159;1
WireConnection;117;3;121;3
WireConnection;127;3;121;2
WireConnection;123;3;121;1
WireConnection;145;3;144;3
WireConnection;149;3;144;2
WireConnection;150;3;144;1
WireConnection;71;3;37;3
WireConnection;187;3;181;3
WireConnection;213;3;222;1
WireConnection;215;3;222;3
WireConnection;181;0;185;0
WireConnection;161;0;199;0
WireConnection;161;1;202;0
WireConnection;160;0;173;0
WireConnection;160;1;166;0
WireConnection;160;2;165;0
WireConnection;159;0;163;0
WireConnection;173;0;178;0
WireConnection;173;1;175;0
WireConnection;173;2;168;0
WireConnection;216;3;222;2
WireConnection;214;0;219;0
WireConnection;214;1;221;0
WireConnection;214;2;216;0
WireConnection;155;0;199;0
WireConnection;155;1;192;0
WireConnection;223;0;199;0
WireConnection;223;1;231;0
WireConnection;119;0;199;0
WireConnection;119;1;195;0
WireConnection;293;0;294;0
WireConnection;634;0;199;0
WireConnection;634;1;74;0
WireConnection;379;0;661;0
WireConnection;379;1;662;0
WireConnection;379;2;663;0
WireConnection;69;0;73;0
WireConnection;69;1;635;0
WireConnection;69;2;67;0
WireConnection;701;0;688;0
WireConnection;164;0;199;0
WireConnection;164;1;201;0
WireConnection;374;0;365;0
WireConnection;374;1;364;0
WireConnection;126;0;199;0
WireConnection;126;1;197;0
WireConnection;396;0;64;0
WireConnection;17;1;9;0
WireConnection;17;2;25;0
WireConnection;17;3;26;0
WireConnection;17;4;18;1
WireConnection;17;5;18;2
WireConnection;188;0;199;0
WireConnection;188;1;224;0
WireConnection;294;0;16;0
WireConnection;395;0;64;0
WireConnection;186;0;199;0
WireConnection;186;1;226;0
WireConnection;382;0;64;0
WireConnection;382;1;379;0
WireConnection;128;0;118;0
WireConnection;128;1;120;0
WireConnection;128;2;127;0
WireConnection;153;0;151;0
WireConnection;153;1;154;0
WireConnection;153;2;150;0
WireConnection;122;0;128;0
WireConnection;122;1;119;0
WireConnection;122;2;123;0
WireConnection;183;0;199;0
WireConnection;183;1;225;0
WireConnection;559;0;394;0
WireConnection;16;0;9;0
WireConnection;172;0;199;0
WireConnection;172;1;210;0
WireConnection;636;0;199;0
WireConnection;636;1;41;0
WireConnection;73;0;153;0
WireConnection;73;1;634;0
WireConnection;73;2;71;0
WireConnection;292;0;293;0
WireConnection;9;0;10;4
WireConnection;156;0;199;0
WireConnection;156;1;193;0
WireConnection;686;0;696;0
WireConnection;686;1;700;0
WireConnection;390;0;396;0
WireConnection;154;0;199;0
WireConnection;154;1;191;0
WireConnection;560;0;395;0
WireConnection;37;0;77;0
WireConnection;369;3;362;0
WireConnection;661;0;683;0
WireConnection;661;1;390;0
WireConnection;151;0;148;0
WireConnection;151;1;155;0
WireConnection;151;2;149;0
WireConnection;290;0;17;0
WireConnection;696;0;374;0
WireConnection;696;1;695;0
WireConnection;167;0;160;0
WireConnection;167;1;161;0
WireConnection;167;2;158;0
WireConnection;219;1;223;0
WireConnection;219;2;215;0
WireConnection;170;0;174;0
WireConnection;166;0;199;0
WireConnection;166;1;203;0
WireConnection;67;3;37;2
WireConnection;368;3;363;0
WireConnection;687;0;698;0
WireConnection;687;1;701;0
WireConnection;63;3;37;1
WireConnection;64;0;62;0
WireConnection;64;1;291;0
WireConnection;64;2;292;0
WireConnection;699;0;684;0
WireConnection;683;0;689;0
WireConnection;683;1;699;0
WireConnection;121;0;130;0
WireConnection;371;0;369;0
WireConnection;371;1;367;0
WireConnection;62;0;69;0
WireConnection;62;1;636;0
WireConnection;62;2;63;0
WireConnection;689;0;371;0
WireConnection;689;1;690;0
WireConnection;635;0;199;0
WireConnection;635;1;75;0
WireConnection;370;0;368;0
WireConnection;370;1;366;0
WireConnection;291;0;290;0
WireConnection;148;0;122;0
WireConnection;148;1;156;0
WireConnection;148;2;145;0
WireConnection;663;0;687;0
WireConnection;663;1;559;0
WireConnection;729;2;382;0
ASEEND*/
//CHKSM=5722393819E92A74B58A7ECBAD3A3F9E2B94BD1D