Return-Path: <linux-pm+bounces-31844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFECB19AF9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE0171410
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC92224256;
	Mon,  4 Aug 2025 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XekcNA7w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E52222D2
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283995; cv=none; b=AAVWhbdAlr0EHAkvRUOE5nHo18DDnEI3vUHdulfju0bUbMEqSf61iFn63tB3RoKlKxdZGtpMH2oG/h8ooDOlJSVhq2umkQn2AedkabZkB92KYo80TgOiZFI+c6FwGQwjNhsEVZErBXNB5Lm5moZT8puniEM18KVz/JWLiiuGjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283995; c=relaxed/simple;
	bh=IDOPV4mIao+gPxdKHovDOdq3yetQWTE1eqHrhAO5FcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okBglWqFww8Q1yh226Q2ZI/3STXAOf5qi4UKfW3ggcc4Bpp9Tk28gnNSNpEgIhTdZM/LY/ljVZ4oNG3JTgkx//pj9xZlB7din+ZXCBGIy9DSRyxY+EEHYxFwOys4jhk0zmY68XjLYc7uHxxUky3fWnUM7h5d6mxjDsbjh6Xt0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XekcNA7w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MDOgE003377
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 05:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yVg7O3KPfgI
	Qu1Zgx9CgkM6RnHfuKdPmRqKYM/he6Gk=; b=XekcNA7w4SFY19NEIc3BcEQmPx1
	0E5KrP0RUu07OGy8ERVPqyL7hFgPU65h6GCAKUHRRSZGgnDtvp5pwU/xqoc1vY09
	JrlPIqz7OipryqCv+LoL6sqa6vQjJ2q7mJoJWCizsZQYEB8Lde7uy/E1z2fTpO4u
	M2p4g2WScppj/z8tyN5gr4ZxnNf2kh4/K2QpJNAEZ0z/rmxoi8elE6AEyP1IRzaq
	3aFawDwNe8c62MjHbeURsTIDwdmbZqYhpLhfs9IFG2uT1sEgo1pmYsBkvYDJHLrw
	z8OM/lW9SAGFwR9HZgUQ+683cyn1X5yKdpSFeKOizR4NymZTBQ36Sm6iKbw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489aw73hhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:06:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400cbd4241so56438485ad.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 22:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283992; x=1754888792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVg7O3KPfgIQu1Zgx9CgkM6RnHfuKdPmRqKYM/he6Gk=;
        b=xIG7Kwr3XDOJ0t/E46qFupqZl0BWX/0E4+X93JGnHQx5fIpVgtwqXL+btSU4Yhk1kd
         Ny/rXoO0+39HBKBRLtwT6pzkudUWNsq8vffQuqi2Bk/OSeMxAUmuJGp+oj5fvSxXVD80
         gg4JVp+G0G9/HxSOxVR7x3vpqpPKagZLiGHDADlX8WVHAKHDwUUPyC2j5e8s1DQqyC0/
         wVRGr3tRTt/4RSZAWBfqtuo0rsL0G9O71aHuVvLNgu5bRUefTX2gS2pI4hN6bTGaZFfZ
         Gg+BvbDA7/IQER50vXUiI2/vbehl2gjcWTutna/L1dV/oB0MShWbcl41f2v2lyepBUtA
         8GLg==
X-Forwarded-Encrypted: i=1; AJvYcCUdVxrHJq0USQc00MSvw0Ejk16hF8B4LL19MZ16K9PzZXX52FGDyEus0/lNfLjSUILgJ8FRKlcrkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdpEpwTo9HOXwyOmev68XBxq+c/al03GX09YcXoFXVbL5gsbH
	5gXvbwKJFVLNmihvLJZkJIFAep0RbwU+H+zKUo/gvkUZUFa8t3iJIpNrzB6Ed27W7RWE096ktDx
	JLBmeLdYw9ip32fR4lY3hVZzXWAmuByAGU+4giJ2zOK71dtM0wKukk6wb2p42NA==
X-Gm-Gg: ASbGncureNb3wyB/vkJ53+EoPQMW6HPYJFRNNtj6gYQVinZCdqlOmURxTA7gplYB7Au
	DoH2Q37WlwD/kCm5LvCqVeUQ24iygGOWg9vgTibrW2AuBgdWGT/9K+VWNeRbNRyHL/Kwr0T0ErF
	+c6VWmm4pgoVxYBtKUh2ZgTBOtgk9GtOWSufzkPR6OJm9EET0COluOO1iBmXmFpj3tQR9MEHLjJ
	pBAZLXcmedNhvzMyA7jos5vN693GKwNUm0QFVa03INHZD4hPCUx4dlHvbc7CyNUXZaBq7OhOg90
	zmvUOxskBSweTBrajgMlPUNYsz2OY2efbZlzWUc9cT4/1rC4SOOGy1g32aw1g5bYSJSh7xW7nOZ
	P44o=
X-Received: by 2002:a17:902:d58a:b0:224:910:23f0 with SMTP id d9443c01a7336-242470589e8mr135636135ad.49.1754283991934;
        Sun, 03 Aug 2025 22:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtThvZX+Dj5I0CBWG8KGyfqCdYtjV9pvvzYsHSdjWypwUfl8cg4OJnNrpyQkrGjjGr9pcOSw==
X-Received: by 2002:a17:902:d58a:b0:224:910:23f0 with SMTP id d9443c01a7336-242470589e8mr135635365ad.49.1754283991018;
        Sun, 03 Aug 2025 22:06:31 -0700 (PDT)
Received: from e0cec1fbb194.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm99705135ad.7.2025.08.03.22.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:06:30 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and CPU OPP tables to scale DDR/L3
Date: Mon,  4 Aug 2025 05:05:42 +0000
Message-ID: <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 03YoWiDU34wHH-FjnSRZA4B44Xpqw8XL
X-Proofpoint-ORIG-GUID: 03YoWiDU34wHH-FjnSRZA4B44Xpqw8XL
X-Authority-Analysis: v=2.4 cv=MrZS63ae c=1 sm=1 tr=0 ts=68903fd8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=1ISD4PbNEMn50PZ00O0A:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNCBTYWx0ZWRfX429scWKyUmlE
 42zUnRrsapwJvwMMoCiHGUT4tYVQmOb+AJbIukPb1hD77ft7xffQIIOvM758nIl/Vx7xtSlHXIY
 mge5/CgHuGpT/S3Q2b+6A31iqlDGQRLfZSqXm/OwjjAy962CnTs0yhbsAW19Gpbwo9iSoErRsuM
 KW5B1zHaX+JXyPV3L3kMuVffs9+9n1CGhu0pbVj+UgOFszM5P6U4uscR6l3G4cm5/HLwgdEAWKB
 L5N8qIc8n3M9t2d6cWcnmBWq9Kmqr8drI98Uoz2IXBha+rvg6aw19ut2WeJYLlaMxxD5tNhlfA3
 znMfAayhNeMCDcBDiq0PTXaiahyHsizzBqt1PQmRiMnvroJkiUjUqWbefCqTD5ORFvC9vmiHXVP
 EB2QF3fgzdM1qLDiNdYqF9/rtY8kSDE+dGWeAD4TQelOJR0SQY6P6n+a2sjk2HgIhVhrYDcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040024

Add Operation State Manager (OSM) L3 interconnect provide node and OPP
tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
compatible as fallback for QCS615 OSM device node.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index e033b53f0f0f..d81e7daf9b5c 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -33,6 +34,10 @@ cpu0: cpu@0 {
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_0: l2-cache {
 			      compatible = "cache";
@@ -52,6 +57,10 @@ cpu1: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_100: l2-cache {
 			      compatible = "cache";
@@ -71,6 +80,10 @@ cpu2: cpu@200 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_200>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_200: l2-cache {
 			      compatible = "cache";
@@ -90,6 +103,10 @@ cpu3: cpu@300 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_300>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_300: l2-cache {
 			      compatible = "cache";
@@ -109,6 +126,10 @@ cpu4: cpu@400 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_400>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_400: l2-cache {
 			      compatible = "cache";
@@ -128,6 +149,10 @@ cpu5: cpu@500 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&l2_500>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_500: l2-cache {
 			      compatible = "cache";
@@ -148,6 +173,10 @@ cpu6: cpu@600 {
 			dynamic-power-coefficient = <404>;
 			next-level-cache = <&l2_600>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_600: l2-cache {
 			      compatible = "cache";
@@ -167,6 +196,10 @@ cpu7: cpu@700 {
 			capacity-dmips-mhz = <1740>;
 			dynamic-power-coefficient = <404>;
 			next-level-cache = <&l2_700>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_700: l2-cache {
 			      compatible = "cache";
@@ -219,6 +252,111 @@ l3_0: l3-cache {
 		};
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(300000 * 4) (300000 * 16)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(300000 * 4) (576000 * 16)>;
+		};
+
+		opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-peak-kBps = <(300000 * 4) (576000 * 16)>;
+		};
+
+		opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+			opp-peak-kBps = <(451000 * 4) (806400 * 16)>;
+		};
+
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(547000 * 4) (1017600 * 16)>;
+		};
+
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <(768000 * 4) (1209600 * 16)>;
+		};
+
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(768000 * 4) (1209600 * 16)>;
+		};
+
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-peak-kBps = <(1017000 * 4) (1363200 * 16)>;
+		};
+	};
+
+	cpu6_opp_table: opp-table-cpu6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(451000 * 4) (300000 * 16)>;
+		};
+
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <(451000 * 4) (576000 * 16)>;
+		};
+
+		opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-peak-kBps = <(451000 * 4) (576000 * 16)>;
+		};
+
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <(547000 * 4) (806400 * 16)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(547000 * 4) (806400 * 16)>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <109440000>;
+			opp-peak-kBps = <(1017600 * 4) (940800 * 16)>;
+		};
+
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(1017600 * 4) (1017600 * 16)>;
+		};
+
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <(1555000 * 4) (1209600 * 16)>;
+		};
+
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1555000 * 4) (1209600 * 16)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(1555000 * 4) (1363200 * 16)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(1555000 * 4) (1363200 * 16)>;
+		};
+	};
+
 	dummy_eud: dummy-sink {
 		compatible = "arm,coresight-dummy-sink";
 
@@ -3624,6 +3762,16 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		osm_l3: interconnect@18321000 {
+			compatible = "qcom,qcs615-osm-l3", "qcom,sm8150-osm-l3", "qcom,osm-l3";
+			reg = <0 0x18321000 0 0x1400>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,qcs615-qusb2-phy";
 			reg = <0x0 0x88e2000 0x0 0x180>;
-- 
2.43.0


