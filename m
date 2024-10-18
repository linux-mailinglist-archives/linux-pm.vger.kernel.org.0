Return-Path: <linux-pm+bounces-15995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806909A4730
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5771F24B6D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A9208971;
	Fri, 18 Oct 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2EcnoMR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8D205AD9;
	Fri, 18 Oct 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280428; cv=none; b=DDo7aS/p6Hba/6h2iRN0BirKQ2/u5ZIQEsqy8EdlSfqxXmoxSp5GwSADAGixSNMfN45FU91lwVkEG6PXf/OOBMwUVazPTHQdXBm+9MtSwB5JZLmNTS0q/tNoG1fEeOt8WBQwE7BpXQuBsAqDDz7HXzA+aXco23ptqUWldEpeIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280428; c=relaxed/simple;
	bh=+CvngsTHz2ClZoR/Vw1+MREwpHm2as9JGwxps/AEPKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bd304d9uehs2rMd5r68k3kciLGEByfM5hosvXT1efPhEqwGxEonqEV4GvfH9LZCSYgJu8z75kvn33LTj+G+laPYM3Cq/EWSpEQfzAqS+UEriJffU/dJG4mHzsDHgvEQwqL3YWOKwzRb1S/V0fEwWDmPy2TemyQikRdrZ/l5tmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2EcnoMR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBfTxB021848;
	Fri, 18 Oct 2024 19:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XRYtLbjjnpYdhjvtF6N8WzglTBQQH6Uq8UGfg015vHU=; b=R2EcnoMRPsz5pp4I
	iOxXOpgmDDYsyy4iDiL3Kuz/cuJNEl+AZxW1yRgWD78DlSnIQC1AXPjNv6h1k/qT
	4nDECFS+70gMgdHJG8fghIrqAKrwGui3mD31Uc7NhsJzUxoRfTeX1znkn2wqAODt
	uDb/gS06TGklrq1CrWLz4MI8cI+9+Y8cWK+Dr0e6lyjJK3NTcDEMR3K26zV2gHhA
	ADduRvMI8QUZ3+Qp+Leeb269b6nHV7McIEjW4aJz9uvBGxz4SSOKAIwpgFddxLks
	7hxzKyFDodpSoKXeqfPC4FqEqzEbgAAcvTFUh9Oaye+fBVmEEIF0Q1LEaomOAmSZ
	MsWg6w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42be8cav1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:40:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IJe5CK031149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:40:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Oct 2024 12:40:04 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 18 Oct 2024 12:39:46 -0700
Subject: [PATCH v6 1/5] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241018-arm-psci-system_reset2-vendor-reboots-v6-1-50cbe88b0a24@quicinc.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
In-Reply-To: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann
	<arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
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
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OS_fp8aQD17l-k0ShRWfho9jY4IU4Orw
X-Proofpoint-ORIG-GUID: OS_fp8aQD17l-k0ShRWfho9jY4IU4Orw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180125

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
index 627f8a6078c2..7f5f94673e9c 100644
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
index fc8105a7b9b2..3da3d02a6690 100644
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
index ad0a0b95cec1..3ddac06cec72 100644
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
index b6acff199cde..79ffc78b23ea 100644
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


