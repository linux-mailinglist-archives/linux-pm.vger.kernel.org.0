Return-Path: <linux-pm+bounces-7878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1148C6EE9
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6166E282B7C
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5842073;
	Wed, 15 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aBV6qp/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AD3FE55;
	Wed, 15 May 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814629; cv=none; b=UQ+O7JorX7v4rxDdydINV6JyIqluIHKPWuGZxbS2ABKjtju0KIQoxEI5+nOvCs+je0IMg8z7KW4s4jZYcZP0XllEh8p5+wKvsSgazfdVcpRGCba1BTfzWc6A0UxSSiKPfh96eysNGAChHEWJhsqTWgItd25m5PfXLM0VfHye+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814629; c=relaxed/simple;
	bh=Zz68c0r5mB2HJA3QHS2x1gOeC+u9VHtVrSEwwbMzEME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g3FJQmt9G/C8ftIGtHp7pvtKGlPNR3SaY0KzCqw+MEl6cAJwMDtUr31cW6JnNt2N5pZA4vsSoEkv2VVl6sTj0jB90JEYnCscje0Ow7mRgrzZeCh6ncyivK4DJ+ox5g2DITJ70P/iOzvy7rfYwvH4/aWQ++TJRXE1Fo1wwUd6Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aBV6qp/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FK5r7b007487;
	Wed, 15 May 2024 23:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=kAZI2h+kQAy/9os7bUIy5NuQ21T7ryEOiCZ/BvXPBOs
	=; b=aBV6qp/tiTW1uhGHhBZhhOY1erx/eClIgbK69U1xOz+isLEMkSfcr+9Q3Co
	ofJ7PZ5ECyS5ixUJ7YngiHzW8T1MzoK6r5AusPCsfDdPgq8Zt+qeeYe7Ak5cRX3k
	b3BxX37ol/PrSQQSPrWNIt5eHQoRpX81yFbUKGq9zWHbfEQnhJpzkjmaOZxkOcVp
	nT4M/sjEEgc/j2t9C0QwTN8ZQcI93VvG2LHK/LQD3bpAtcUG+xojseV8By5n+ks9
	63XMjW2OfSYcKLZeD06MBExJgHrrLQZlfKXnNtgCC9Ay5H41tUecwFKX+1ODbW3F
	UdTeCZv40l/6m/5YtmloslciuIA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47f443pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FNA6n5008254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:06 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 16:10:05 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Wed, 15 May 2024 16:09:44 -0700
Subject: [PATCH v3 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240515-arm-psci-system_reset2-vendor-reboots-v3-1-16dd4f9c0ab4@quicinc.com>
References: <20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com>
In-Reply-To: <20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GaYIvjh5J8B_prHUQHBuuggWYDfWxDdp
X-Proofpoint-ORIG-GUID: GaYIvjh5J8B_prHUQHBuuggWYDfWxDdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150164

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array. Users of the
reboot-mode schema will need to specify the maxItems of the mode-.*
properties. Existing users will all be 1.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml |  4 ++++
 .../devicetree/bindings/power/reset/qcom,pon.yaml          |  4 ++++
 .../devicetree/bindings/power/reset/reboot-mode.yaml       | 14 ++++++++++++--
 .../bindings/power/reset/syscon-reboot-mode.yaml           |  4 ++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
index 627f8a6078c2..03b3b9be36de 100644
--- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
@@ -30,6 +30,10 @@ properties:
 
 allOf:
   - $ref: reboot-mode.yaml#
+  - patternProperties:
+      "^mode-.*$":
+        items:
+          maxItems: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index fc8105a7b9b2..95964e04d5d6 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -68,6 +68,10 @@ allOf:
     then:
       allOf:
         - $ref: reboot-mode.yaml#
+        - patternProperties:
+            "^mode-.*$":
+              items:
+                maxItems: 1
 
       properties:
         reg:
diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index ad0a0b95cec1..feb70609bb5f 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -28,13 +28,23 @@ description: |
 
 properties:
   mode-normal:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "#/patternProperties/^mode-.*$"
     description:
       Default value to set on a reboot if no command was provided.
 
 patternProperties:
   "^mode-.*$":
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    # Limit to 1 outer cell, e.g. no mode-normal = <0>, <1>;
+    maxItems: 1
+    # Note: to reference this schema, the allOf should include hint about
+    # maxItems for the inner cell
+    # allOf:
+    # - $ref: /schemas/power/reset/reboot-mode.yaml#
+    # - patternProperties:
+    #     "^mode-.*$":
+    #       items:
+    #         maxItems: 1
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index b6acff199cde..bf6d68355e7f 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -31,6 +31,10 @@ properties:
 
 allOf:
   - $ref: reboot-mode.yaml#
+  - patternProperties:
+      "^mode-.*$":
+        items:
+          maxItems: 1
 
 unevaluatedProperties: false
 

-- 
2.34.1


