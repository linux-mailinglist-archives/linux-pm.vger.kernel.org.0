Return-Path: <linux-pm+bounces-32627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84902B2C055
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C8A1767DA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2897632BF55;
	Tue, 19 Aug 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTdS/h/a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1D32BF42
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602711; cv=none; b=Jlj4wn2gF3iE8ZZyXh6d+NPRIKY2664wGspEp4E/gCqFgNbI/rxJAaB4DfEuMpxTnloMWqhgx7Y7jHuPHH+egV1930dMZZ7RyVrqBDfkhCYEZ9sO8WlA88sw02szTuI7xdpseaOtGqoF1zmf1jGFpISvR7ndWkljUOSRoDpf3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602711; c=relaxed/simple;
	bh=tPWWVyCTWRXEYnYKUUoqFrp5QD4cC3uM+8GK+oqKBk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7aRLg7jfb0kT5k+lgHw+iiPaCVHsVWm4wj9jBkVZr0pyuhdEa8S4GOeQoNVNNnVRMRXL+RY2kr5h8S6CmAjglIHl10fFMNvgcOCB1GUVyaqtCr93//4JM+7nTIKzHZjub2TwnZUkuZty9cKB7+YQvyynYlvic3Epjhdw5HPc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KTdS/h/a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90ZBD021776
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mS6t9R8MhHGEHCu5gVY9vvZZ+OU5TObUI9277uydciQ=; b=KTdS/h/aQPUcG/T5
	qT58zMM3iPHtwExwJt5wCit85IHN3rg/c+4rO+xaxxLN3HLw77/WwMvMAeZYPksU
	acie22v3bWBDrJFy6LWnRhNGZUUbQMyIZBOQL7702w/iaCB+6dY5RbARfejROScx
	y0qRJkmuCMOpocLjDxBkePy6SHMMnFhPlEPYIlnKFr2gXj73vneuQV3bFUQ/OgqM
	WRyvc5BbBJbvbzHgQQrLi9M3iHpARgziBHZn3kbkw4q8ERJisjnw4gX7kGkVDdcp
	8tKdBNulqO9P18XXgAvZGRFvUZsQGLalcj+zBAbM2hz9BMSbpsFDktQeORx3MQmv
	AYaL5Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71ck1c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:25:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e8fc814so4762415b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 04:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602704; x=1756207504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS6t9R8MhHGEHCu5gVY9vvZZ+OU5TObUI9277uydciQ=;
        b=ITu2AeULIIo3YKWg1dwTYtLUA91mYTIbLYIlE2ym0HcQgRCT3IpRtXO4tnUq9NtbXn
         JT9kgNE1EBW6AtXtvUklbodH5PuO1Oa2tofAdh1JQcbYfGKNU6GJrQ46Q2QoXFmgek9Q
         E21NX3Xtbp+oJtdRQPdlvWGO+VPpw74sSu6o2YOoqaqALsg3PzRfN3ZxhrQFZmzWXVKO
         /XWCI/OfwsCkVig1pQ5LjstndpomaEbA1yuGndFTQFIK6uzFRWY3O0rud/nrUcGfftAi
         E+pTrNYuFTwGCdmENkilE1BY8rxyJhmeZ/C8GBGLSmJ97if1uY8dYSKgz/o8kScH5Fae
         czyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITJ3+ARG1/e3udTWXPSh9N1r56gnvjQnVcj7qQPT4GoZMHhiekmElzBrKJRlpXd6w/Noz5KGZLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+Dcm9rQdHiCUoxXLGtTVCxi3RKvHU1qJBMB0g645lidIH+S2
	BA1Q88OX8OoSh4TUUbn9C8iV7GZPbcCGrnrmLFWMZlCmcDLF0ruqux8612Ywmh5aN7I2zZ5M2j6
	KpvwI1I8tsMQZIEttrOZwhZpPOG/RjR75T6lD6VEPnveUByja05bm6Mtsk9eiRg==
X-Gm-Gg: ASbGncvF84ZvVazFF+dlG7KZ+0q98kBZx6QhROFG4LdYu4fRnc9tcw6hFB00+tbTcIj
	glBIMYCFNUuUSTy5OeBNDDJNlb9g+K6YqzQ1G8XoZP+LF7wDaZ+xw+3Zm/2ALDaIz3NiQwx0qkd
	k9qDYfkBTQU9/qav/dUaau6jG+UruzGnbymbhl7NXfG/mnmqvw9di5urxeARl1YG6OgsYWt0M1k
	4PiZy6QRIuNamO3uBULz/Lydld+nbn4ZbQAB9vG4wjMEGY5Vdj47CvFNKJnrSLzTUv9L/aoCWIY
	jx6UzfVz2jmsxfN0F1YZcVk3yPGH60xJWEyuATWV/Ox2VukSURHx/cTTf15pJ64=
X-Received: by 2002:a05:6a00:198e:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-76e80ee2326mr2968855b3a.7.1755602703523;
        Tue, 19 Aug 2025 04:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMqIUlrol5LRuocCJfIHzaBA6/77BPSuMjkCwUZ2O+nEb4gtgs0D8lTv+dWXddXteUJsotpA==
X-Received: by 2002:a05:6a00:198e:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-76e80ee2326mr2968816b3a.7.1755602702974;
        Tue, 19 Aug 2025 04:25:02 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm2202258b3a.63.2025.08.19.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:25:02 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:24:47 +0000
Subject: [PATCH v3 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-talos-l3-icc-v3-2-04529e85dac7@oss.qualcomm.com>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
In-Reply-To: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Z4HqUWJauRKJKTB4ENebK9i9Byw-UqpH
X-Proofpoint-GUID: Z4HqUWJauRKJKTB4ENebK9i9Byw-UqpH
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a45f10 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=D3nHYB1hGevEbxyc_hsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX8XIcs0ucwzOv
 Nt4UZ5NCZJKWAUF9qlPdeqYjFZk6R5dP9mWjBTWvyGudynCMJCMxZ3lhcF2FYDsywwN1CeXC8Jc
 5T9VWZbQ6lL7JeByDVBO3/BvF81XYp/FxFr8VWMru4qSiQTYvnpF86WGuZmhVfpagi0Kv21n9Pr
 TehzVp8y5ZSmSa1/yXhtN/RMEeDhDyst6ags7uiIIRx1g5B46cIYNqMNifEmA+QVMkTGkmLfOMx
 cS00v8TX7BTX2r1zGN+9mrPtym5ljiJk0Sp6pDWqzIea4NfXtXZxZ1emhJo4lX9Hxalj83OQURT
 48cntkGuDbgtm6CT27ZNa5sN0Z+MDhbvKWtc+EM1OUuFYqsHX2wZhQ10YTPaYpsB7+5IbDmAKql
 Mk8Zy1MB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

Add Operation State Manager (OSM) L3 interconnect provide node and OPP
tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
compatible as fallback for QCS615 OSM device node.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 50cd9275e4028eb8f689eae215bf47a9e06d4cfb..44b52276804799790473e6058cffb2cebe57d771 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -39,6 +40,10 @@ cpu0: cpu@0 {
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_0: l2-cache {
 			      compatible = "cache";
@@ -60,6 +65,10 @@ cpu1: cpu@100 {
 			next-level-cache = <&l2_100>;
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_100: l2-cache {
 			      compatible = "cache";
@@ -81,6 +90,10 @@ cpu2: cpu@200 {
 			next-level-cache = <&l2_200>;
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_200: l2-cache {
 			      compatible = "cache";
@@ -102,6 +115,10 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_300>;
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_300: l2-cache {
 			      compatible = "cache";
@@ -123,6 +140,10 @@ cpu4: cpu@400 {
 			next-level-cache = <&l2_400>;
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_400: l2-cache {
 			      compatible = "cache";
@@ -144,6 +165,10 @@ cpu5: cpu@500 {
 			next-level-cache = <&l2_500>;
 			clocks = <&cpufreq_hw 0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_500: l2-cache {
 			      compatible = "cache";
@@ -166,6 +191,10 @@ cpu6: cpu@600 {
 			clocks = <&cpufreq_hw 1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_600: l2-cache {
 			      compatible = "cache";
@@ -187,6 +216,10 @@ cpu7: cpu@700 {
 			next-level-cache = <&l2_700>;
 			clocks = <&cpufreq_hw 1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 
 			l2_700: l2-cache {
 			      compatible = "cache";
@@ -239,6 +272,111 @@ l3_0: l3-cache {
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
 
@@ -3894,6 +4032,16 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		osm_l3: interconnect@18321000 {
+			compatible = "qcom,qcs615-osm-l3", "qcom,sm8150-osm-l3", "qcom,osm-l3";
+			reg = <0x0 0x18321000 0x0 0x1400>;
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


