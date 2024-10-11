Return-Path: <linux-pm+bounces-15557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55999AD8B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 22:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58252288849
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465941D1E61;
	Fri, 11 Oct 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R274WdVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBB1D174A;
	Fri, 11 Oct 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678638; cv=none; b=O4qUgJG4Bi7t0Drjxde8th7EsHNb8qOjmC+twASdTcppdoQjAtEK7WSsam3nXpY470H6anjogy1u/W6hDf7ZaViqM9DsCY4O2CWrBnX/qk/17yaFzJcrt+nuZbHnF/Clt4o+o6rJaFF50ECnw+r2kcUhQ0jNCew0uLm6PMekJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678638; c=relaxed/simple;
	bh=kD7xSzXYJwJjk5XVY65hAkRS0QUg4kLyhkdrj8GJxIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dGg7lBXz1nWZL7Yn1rNBmkH6xTinN2uVnAc+9uO29xSVj3lb7kthnEa5ALNXCPUITqSbPVff9dSEq+OnPNhSMHiWb9neDE4+ez4r1r3ME0wYosAlH99hu6dLbkIf00MbLO2EQvtb6rBqByJjLzTmTfX0yYDVo/SN/II9opDNO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R274WdVA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BA9w0c019504;
	Fri, 11 Oct 2024 20:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gkApnZlBqt/wisZG87GJ+IHy2ek2d9hZOJ6mUcRh1FQ=; b=R274WdVARDn6TNIb
	hXE5RO5jLf1XETwN4I/gCfOGjydUWp0PFq8yI5YZ0Fb4PI6ZLaEwnRW14QGytrAI
	mZR3++wzhjS9w557DRPYz7jxJEhAQPWNutKkq5K75pXJCgpw+JtMrbJgu0r6rPyH
	CMNf4bnSCAQjgb2pzy4I6+wAZIo7IDaWQ6lnG0hGdZorg/FU47wgNSVVjEyaypSB
	tz2Mhgu3Vt8rE9pV/qVDEyr8an6qF5e4GlZuFybHJeZPzlynAoXICDoYp98In1Tb
	e2j69dr81FdTfIAzFgtODQRO7SRlzl9aB9vTX4zZYofhE3rk3pcjjLocbnsKEFkJ
	iC6TVw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42721c9gq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BKUOVx024444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:24 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 13:30:18 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 12 Oct 2024 01:59:29 +0530
Subject: [PATCH RFC 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241012-gpu-acd-v1-2-1e5e91aa95b6@quicinc.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
In-Reply-To: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728678606; l=3116;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=kD7xSzXYJwJjk5XVY65hAkRS0QUg4kLyhkdrj8GJxIo=;
 b=x4RumzkzAD3xU/lD/uPdF8qhpaK5K/hFtZU1IMnaf00lEo2iZGvoB1jGmXKFuWNelKN+SishN
 vtgSsLj+rlQCbqGRYsGkZ9/lAdwcw7j5cjYOJ/uzPtyKjcTtConlHCQ
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YA1MGc9dCQwQ_3GbrW9JWnJFi19bptok
X-Proofpoint-GUID: YA1MGc9dCQwQ_3GbrW9JWnJFi19bptok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110143

Add a new schema which extends opp-v2 to support a new vendor specific
property required for Adreno GPUs found in Qualcomm's SoCs. The new
property called "qcom,opp-acd-level" carries a u32 value recommended
for each opp needs to be shared to GMU during runtime.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
new file mode 100644
index 000000000000..9fb828e9da86
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
@@ -0,0 +1,84 @@
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
+    const: operating-points-v2-adreno
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
+          A positive value representing the acd level associated with this
+          OPP node. This value is shared to GMU during GPU wake up. It may
+          not be present for some OPPs and GMU will disable ACD while
+          transitioning to that OPP.
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
+
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    gpu_opp_table: opp-table {
+        compatible = "operating-points-v2-adreno";
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


