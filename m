Return-Path: <linux-pm+bounces-16085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E6B9A672A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6D31F217F4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BF1E908A;
	Mon, 21 Oct 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OMnKbRoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547791E907A;
	Mon, 21 Oct 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511735; cv=none; b=R6SJJLeXGRZ7s+GarpgYlsHISbJLUMUCOm59jLbRt+onAh91WAJFUYeGrSbMNVEUDGHgymD9FfdXVN8fSEFj8fS2q6+fE7PA9RHcG9XFEdzoiPzSYbOx22rQ7h+7If59ExxfTYs/bSxTiVsgRYO59dOQ8B8HHVtJBg+/kmtinoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511735; c=relaxed/simple;
	bh=iNjDqrQmV+s1Qw90kkgq+wmuj4k0D5Ggzsx+vRIGRbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LnAMmapkrTXBwUdE/WPxWg65sTuLmUpXDLb0hxtgJdHFkpUUY9b3ND/ouUt63I1QzCaV/2BE3xjwh42Fe7spxPlFeNgyZfRl0V2lDFh69hf4kxMV0XjI/fp5i+6Hd5K0lnypRePclGLi+iFAj5igDV7sZPRKLr7A6dJxER/jSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OMnKbRoK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LA4aRf032205;
	Mon, 21 Oct 2024 11:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jm8qmYE0qbYlBlDtYXO8HHGR2+G1tkkHvCXy2o1fEWA=; b=OMnKbRoKcfHIRLbW
	MIUyWwcTLGbEFQUUiKzQKfNqWt4wYW36tba2gtP6znR+ynnpk7BviYWAARthhUSH
	VviuXPhCFcV29r0HTxjBBflGqyVwv1BSYg9UXaRU4OUZupLOTP2r6AVT/YVHrcFN
	VeV+VbYEhgk72FBR6XgAjPnCVv2AK4Zy9cWgcNa2JWzFfDPHR5LYSO+0eqECcUu7
	Phwc4oBrTQqsE8jKYp/5vygOHxLVIgXWr7zFgyiG8GFf/ViBmP8ciwbhJeMQ7Z1r
	OG825oFoy7EpRWvs4wWEn5TxMgFR2jv67XnwLfbSWk9ELbO39bxK2CuBdWfdYxT4
	fIIrlw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rbckt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:55:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LBtKrO011437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:55:20 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 04:55:14 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Mon, 21 Oct 2024 17:23:43 +0530
Subject: [PATCH v2 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-gpu-acd-v2-2-9c25a62803bc@quicinc.com>
References: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
In-Reply-To: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729511702; l=3814;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=iNjDqrQmV+s1Qw90kkgq+wmuj4k0D5Ggzsx+vRIGRbk=;
 b=wJG1rIcvvUXuHP9zLExo7bOp06CZYsNDqPkq5Zy9cwE4qopo2uNpmJILNcds5sf19MTD3yYvC
 dUJmStfjYgEDn534A+Gy5hr7tq97NF9YXvMBD4TH/NiiJcwj6iuLz8I
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tjoC6_xN_7jA2JLqDaLZwcuWhjO1eMgb
X-Proofpoint-GUID: tjoC6_xN_7jA2JLqDaLZwcuWhjO1eMgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210085

Add a new schema which extends opp-v2 to support a new vendor specific
property required for Adreno GPUs found in Qualcomm's SoCs. The new
property called "qcom,opp-acd-level" carries a u32 value recommended
for each opp needs to be shared to GMU during runtime.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
new file mode 100644
index 000000000000..6d50c0405ef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Adreno compatible OPP supply
+
+description:
+  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
+  ACD related information tailored for the specific chipset. This binding
+  provides the information needed to describe such a hardware value.
+
+maintainers:
+  - Rob Clark <robdclark@gmail.com>
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: operating-points-v2-adreno
+      - const: operating-points-v2
+
+patternProperties:
+  '^opp-?[0-9]+$':
+    type: object
+    additionalProperties: false
+
+    properties:
+      opp-hz: true
+
+      opp-level: true
+
+      opp-peak-kBps: true
+
+      opp-supported-hw: true
+
+      qcom,opp-acd-level:
+        description: |
+          A positive value representing the ACD (Adaptive Clock Distribution,
+          a fancy name for clk throttling during voltage droop) level associated
+          with this OPP node. This value is shared to a co-processor inside GPU
+          (called Graphics Management Unit a.k.a GMU) during wake up. It may not
+          be present for some OPPs and GMU will disable ACD while transitioning
+          to that OPP. This value encodes a voltage threshold and few other knobs
+          which are identified by characterization of the SoC. So, it doesn't have
+          any unit.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - opp-hz
+      - opp-level
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    gpu_opp_table: opp-table {
+        compatible = "operating-points-v2-adreno", "operating-points-v2";
+
+        opp-687000000 {
+                opp-hz = /bits/ 64 <687000000>;
+                opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+                opp-peak-kBps = <8171875>;
+                qcom,opp-acd-level = <0x882e5ffd>;
+        };
+
+        opp-550000000 {
+                opp-hz = /bits/ 64 <550000000>;
+                opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+                opp-peak-kBps = <6074219>;
+                qcom,opp-acd-level = <0xc0285ffd>;
+        };
+
+        opp-390000000 {
+                opp-hz = /bits/ 64 <390000000>;
+                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+                opp-peak-kBps = <3000000>;
+                qcom,opp-acd-level = <0xc0285ffd>;
+        };
+
+        opp-300000000 {
+                opp-hz = /bits/ 64 <300000000>;
+                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+                opp-peak-kBps = <2136719>;
+                /* Intentionally left out qcom,opp-acd-level property here */
+        };
+
+    };

-- 
2.45.2


