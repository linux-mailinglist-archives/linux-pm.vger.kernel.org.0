Return-Path: <linux-pm+bounces-8957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF71904019
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BFA285092
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946336AEC;
	Tue, 11 Jun 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/kGdL2N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AB1BF53;
	Tue, 11 Jun 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120157; cv=none; b=BTq5nfvTsF5HZxoSdDXJ/auXeWgGry5ektFjcqaNj+CN+Ss/9Oc8xbLxa3GsgCH9f8nVJR+Nj44+4CchQMGmVdc5QV5RgXXQ/3AXT6ymk5mcsCjI7laWI5DtzhI9D6Hh1q9GQ4pGUGp9rpoiBDVset6PCAW2IpBPkOdGv4lZM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120157; c=relaxed/simple;
	bh=oUvA/5pu3i+KpUB+TKlzPN38a0Bv8TQgGszU2cqskbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GBHC6ZsT4uX5Ur1ZsF+yaGxCfoBsMiFLVa6+OiM1uD8p6Yny7vWjTcbHt+Xznzv3GHC8YO02Fd2/2z39cOmsLWm8Gepwdf4CVOA2MyVCFKfcTTVOeXeD/FgCTQOkjGWUjo5jBZ24cgFB2dCjRkBkCrgIAmXdCEhjdadPrQH3als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/kGdL2N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BDTuaE009742;
	Tue, 11 Jun 2024 15:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Boulg0ggYWkboGqBDVAdNuq1QoUa0shZCVpeljupYJQ=; b=T/kGdL2Nur61UuMP
	gNMlyZMsOxlLP6SYzYXNjrlTRG/XjGk3vhpGxTLieGld749Xz6+xTsfwNDg72mjd
	CAJMopGHhWc1E7nN0SP5ML9bQZpChv2t96euNab5SVnN8K4IncI0G8Kfiqov9OY+
	DihtGIS85zU61FH1DRswu7icJ982GnjlI2/G7NwLMHmvNoETn2KmqUi/lCr1NwSw
	H1Pn6emcKaNFk2okhBkbse6KACpIh19drGBOutRwxIEZQoba/t7IvDs0MTJBW6+y
	HKvnpJm+AWYs0YrZKA0BhkvuGWDAS+32tYbG4lJQlZZsGA5W2wKT4wwDzFIwQHpj
	Ai68wQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype911pmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:35:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BFZU4N009134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:35:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 08:35:29 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 11 Jun 2024 08:35:13 -0700
Subject: [PATCH v4 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-arm-psci-system_reset2-vendor-reboots-v4-1-98f55aa74ae8@quicinc.com>
References: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
In-Reply-To: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
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
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DWqrIaUkCqrqII0cjVskox_48gPY_jOQ
X-Proofpoint-ORIG-GUID: DWqrIaUkCqrqII0cjVskox_48gPY_jOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406110110

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array. Users of the
reboot-mode schema will need to specify the maxItems of the mode-.*
properties. Existing users will all be 1.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml        | 5 +++++
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml       | 8 ++++++++
 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml    | 4 ++--
 .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
index 627f8a6078c2..9b9bbc0f29e7 100644
--- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
@@ -31,6 +31,11 @@ properties:
 allOf:
   - $ref: reboot-mode.yaml#
 
+patternProperties:
+  "^mode-.*$":
+    items:
+      maxItems: 1
+
 required:
   - compatible
   - nvmem-cells
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index fc8105a7b9b2..4c87ff5ecc9a 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -54,6 +54,11 @@ required:
   - compatible
   - reg
 
+patternProperties:
+  "^mode-.*$":
+    items:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 allOf:
@@ -75,6 +80,9 @@ allOf:
         reg-names:
           items:
             - const: pon
+    else:
+      patternProperties:
+        "^mode-.*$": false
 
     # Special case for pm8941, which doesn't store reset mode
   - if:
diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index ad0a0b95cec1..523602fb82d2 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -28,13 +28,13 @@ description: |
 
 properties:
   mode-normal:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "#/patternProperties/^mode-.*$"
     description:
       Default value to set on a reboot if no command was provided.
 
 patternProperties:
   "^mode-.*$":
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
index b6acff199cde..e9d2e3b27885 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -32,6 +32,11 @@ properties:
 allOf:
   - $ref: reboot-mode.yaml#
 
+patternProperties:
+  "^mode-.*$":
+    items:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 required:

-- 
2.34.1


