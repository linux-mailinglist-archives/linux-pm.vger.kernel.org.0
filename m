Return-Path: <linux-pm+bounces-19858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCB9FEAF3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 22:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88C1613AC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B819E975;
	Mon, 30 Dec 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J48s2zEi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE19D070;
	Mon, 30 Dec 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593120; cv=none; b=GsNxTxLHquM6fXf0GWW4iVr/cuIPW9SpzDXaJSAYfqDi1T8ib7iTETwWiMGnFwh0eqMaYCxRavyBZcLXfROUG5R6vExn8hj4JQ04OBH99c000pUIhOOZJ4H9KcfHuXc4+byjWYu43EdLNg2hUJJ8m2uy6vX5o3yFo/EJCBZHZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593120; c=relaxed/simple;
	bh=v1H9hPEmwq+1KQk4ZihY9QFdNy9cZ2zvYnoLVk2L/OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eJ0rshFLg3ze8XdpDaLXPccXGkoyCTz75lTn13eQhQhN4bnFglPZoBWpfVS9aDUKNGU2yzN1lrNyVcQVDS3Hvx6lBFcMVEL7O+nr63LK3Ic9pn7CKXuXgX5UbVJgCdK9Gj3y5Csx5aysAGAQivSZKlqap5A3t91zkLVkj5GldO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J48s2zEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUKjhNH007790;
	Mon, 30 Dec 2024 21:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t8e/RYNdPtzWjmAPrNek3DccTlB5RaBsu4+1+5ZETVY=; b=J48s2zEi8K3hUKeb
	b4njrAc1XMoH5KNmx8v2aDk0WP3j7a5CX5J1LbnynPmtmed88ooWeRkwzvq2cVL3
	ZO4cPjW8fp4Qv87vzAtGqm86J0PBSGgS44KEV3k3UWmbTUQsHimaYEgVRwVX5N0U
	SHAfs/OgQ1oCVcNy0ng68wMWqRQnqRjNQpSD3J03oFuPDTlddAVoXYOZPRUNlgNZ
	Kp4LlYRzag7fFoufIf05iSXmlXf9K/tDL5IgPcoVYG46w4egFmypR/cq63EId6FB
	GLaFXYgjbmfgt3wwqBPovP4QnZYcShzLVAfEzu2G2m3kQx9714ntW1g9iFEnjBsb
	lhsfwg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43v0368cba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BULBlBX001637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 21:11:47 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 13:11:41 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Tue, 31 Dec 2024 02:41:05 +0530
Subject: [PATCH v3 4/6] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
In-Reply-To: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735593076; l=4473;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=v1H9hPEmwq+1KQk4ZihY9QFdNy9cZ2zvYnoLVk2L/OE=;
 b=8vOCoDky4wyLLtvgGgx6jNDy4mgGtVw3qeTaE6smq+aLe1jbBYJyW7Y+m3JXeolLJUo+tJFCH
 34oTJuLJPwCDXZ9zarpVeSztimr99HX8025d8ilFtoI0gN2i4nMDlJ2
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y-ysNZ8uMssHMREa5t9dJwT3H56sn1j1
X-Proofpoint-ORIG-GUID: Y-ysNZ8uMssHMREa5t9dJwT3H56sn1j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300182

Add a new schema which extends opp-v2 to support a new vendor specific
property required for Adreno GPUs found in Qualcomm's SoCs. The new
property called "qcom,opp-acd-level" carries a u32 value recommended
for each opp needs to be shared to GMU during runtime.

Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
new file mode 100644
index 000000000000..b7874f43aaf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
@@ -0,0 +1,97 @@
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
+  '^opp-[0-9]+$':
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
+          to that OPP. This value encodes a voltage threshold, delay cycles &
+          calibration margins which are identified by characterization of the
+          SoC. So, it doesn't have any unit. This data is passed to GMU firmware
+          via 'HFI_H2F_MSG_ACD' packet.
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
+            opp-hz = /bits/ 64 <687000000>;
+            opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+            opp-peak-kBps = <8171875>;
+            qcom,opp-acd-level = <0x882e5ffd>;
+        };
+
+        opp-550000000 {
+            opp-hz = /bits/ 64 <550000000>;
+            opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+            opp-peak-kBps = <6074219>;
+            qcom,opp-acd-level = <0xc0285ffd>;
+        };
+
+        opp-390000000 {
+            opp-hz = /bits/ 64 <390000000>;
+            opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+            opp-peak-kBps = <3000000>;
+            qcom,opp-acd-level = <0xc0285ffd>;
+        };
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+            opp-peak-kBps = <2136719>;
+            /* Intentionally left out qcom,opp-acd-level property here */
+        };
+
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..f7119623e1f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7292,6 +7292,7 @@ S:	Maintained
 B:	https://gitlab.freedesktop.org/drm/msm/-/issues
 T:	git https://gitlab.freedesktop.org/drm/msm.git
 F:	Documentation/devicetree/bindings/display/msm/gpu.yaml
+F:	Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
 F:	drivers/gpu/drm/msm/adreno/
 F:	drivers/gpu/drm/msm/msm_gpu.*
 F:	drivers/gpu/drm/msm/msm_gpu_devfreq.*

-- 
2.45.2


