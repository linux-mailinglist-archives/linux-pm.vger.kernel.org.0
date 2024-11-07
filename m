Return-Path: <linux-pm+bounces-17162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99FE9C129C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 00:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644151F22FB5
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A521A4DA;
	Thu,  7 Nov 2024 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k5IlWviW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D51F12F5;
	Thu,  7 Nov 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022739; cv=none; b=OkjIbpPWu3+T1gBtd3/IsLkBXID1eEJ9t3HwhRUyuGhtF65dZOt5ANi1w3tZjtWYSXmF+dfnJbsfuZHfx/QPaVEqerGHDe2WEop37tq4/SniDnz02+6WXQ4OrPVOPDf16mmr3CsGbElslkoGVkLWX69h6I32U0KlVUyLFlWbwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022739; c=relaxed/simple;
	bh=M/2l4Xl3vNkDGlj6NTJzFIntJYAf5PgZgQw7T79na90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ay8T4Oqe7hKPYy4H2Tt1UuJ2DxlE8vxEMLw5EyZCBV8kGQGocpdjLhL9sDXoZe8Ow3Nh8E4q5GL/jgEXmGpNr+F0lLKJN0JhG24YQYbxx0ZYlMOGf7DnEgo14/zI2qzPuwsVFSWWN8wttvUx44PK/2lsFlaUgXWfKhonxzCjiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k5IlWviW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Max5X013457;
	Thu, 7 Nov 2024 23:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pGBcDJ4w4CXpuMx4u9qwtTgF3ku4Pb+02npBfURg4es=; b=k5IlWviWC/fh+7Rj
	W/Sg4l9vpjGWZAK449JwA1MpFKQXpqY2DRS8R/iV6+tzdKRPLSIgxBZ7jbDiqmc0
	L9q/Zo8AMOxzi3q7CDLzXTLD5hqZ4UCwXUQY2/cromnEUpyG9TXellfknbwZHKPS
	BXt8Gbt9/Jh/N67C5Jp9hVOYnsJqNp2wd5kVm8mOtW3+XPnGB9LrecwhGxXweI+j
	8FCZZfpN4sPTTZB51kZS+xHhGBEbaEDQKi06ZMked1pe55RPv+OumKE/UnlyQoD0
	vGS/uGK63WSGhYRQ1DcE3WoRLZfvrSJMqeQinCZZ8HMj9oOPMFLQDTY+TCyoDeAA
	Pt7kNg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gjg43x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:38:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7NcZRP027964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 23:38:35 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 15:38:35 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 7 Nov 2024 15:38:25 -0800
Subject: [PATCH v8 1/6] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-arm-psci-system_reset2-vendor-reboots-v8-1-e8715fa65cb5@quicinc.com>
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
In-Reply-To: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, "Olof
 Johansson" <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0iaJ7uWxrUvvrwWEH4l2LUaICDmH65-W
X-Proofpoint-ORIG-GUID: 0iaJ7uWxrUvvrwWEH4l2LUaICDmH65-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070184

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array. Users of the
reboot-mode schema will need to specify the maxItems of the mode-.*
properties. Existing users will all be 1.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml         | 4 ++++
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml        | 7 +++++++
 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml     | 4 ++--
 .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml        | 4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
index 627f8a6078c299e32e4bc7597509a6ef52d119d7..7f5f94673e9c248302bbd70378a19f0d25906b7c 100644
--- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
@@ -31,6 +31,10 @@ properties:
 allOf:
   - $ref: reboot-mode.yaml#
 
+patternProperties:
+  "^mode-.*$":
+    maxItems: 1
+
 required:
   - compatible
   - nvmem-cells
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index fc8105a7b9b268df5cb08ad32cde26c50ea955ce..3da3d02a669089af037f9492c64e0304c714b523 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -54,6 +54,10 @@ required:
   - compatible
   - reg
 
+patternProperties:
+  "^mode-.*$":
+    maxItems: 1
+
 unevaluatedProperties: false
 
 allOf:
@@ -75,6 +79,9 @@ allOf:
         reg-names:
           items:
             - const: pon
+    else:
+      patternProperties:
+        "^mode-.*$": false
 
     # Special case for pm8941, which doesn't store reset mode
   - if:
diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index ad0a0b95cec1267c8e479556aebf99cca653a2d9..3ddac06cec7277789b066d8426ea77d293298fac 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -28,13 +28,13 @@ description: |
 
 properties:
   mode-normal:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
       Default value to set on a reboot if no command was provided.
 
 patternProperties:
   "^mode-.*$":
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index b6acff199cdecea08c1243ed5e8ad71240d65e9a..79ffc78b23eaf913dcb43964d083b78befe76890 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -32,6 +32,10 @@ properties:
 allOf:
   - $ref: reboot-mode.yaml#
 
+patternProperties:
+  "^mode-.*$":
+    maxItems: 1
+
 unevaluatedProperties: false
 
 required:

-- 
2.34.1


