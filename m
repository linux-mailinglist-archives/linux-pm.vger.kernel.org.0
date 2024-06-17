Return-Path: <linux-pm+bounces-9352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B590B7B5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E87B28493E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524316CD17;
	Mon, 17 Jun 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHDOISyx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8F16CD10;
	Mon, 17 Jun 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644742; cv=none; b=THqyhmFeVMPqRlKerNTPt9JWky5+46ZVEeVa/kzf7NETeumCCQBhobYKMdJ8bUhlyt5SNDCtbFYRp5rvsNAqMUmWlny8DwsOBH7kGxisj2TWFNE7N6rLS9ghMJIQmTuvw2zkOGz7iJLj/QLbRm9GzR5VLotQsRhSFEYEphsxxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644742; c=relaxed/simple;
	bh=V2VNcGF/ITh8lvOdDdWBKd9rCbC2loen37eN3HOFN6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OnuPehRkR5rhQfZcfFyoyXpqs2qGU0EiX6uPJroZrZWhDMeeqBzTxi3OdiSZUrZIjEA8f7q1Al6Qk1akk6EGdKqKbpiRCL+E+taZoIJWGofMS+6XmU9ZR0P8ZEtX+B08jlEAHYwaQv693zq/mhRpDrpZHWChWop16sy6Jj5MxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHDOISyx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEhuJu030652;
	Mon, 17 Jun 2024 17:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0NyaR8ZYRcTKsVa4WgtyTIpbWfaOxMlFbz4ZtR0JJZA=; b=kHDOISyxbWk0RqjY
	96QQtqtKNv083NPT//6OMFl3zA/3wro3kqc2qAhfamwBzceoTojLf6raaTKyBqwo
	O8qxxp8mNFySH56SqDoNU3H1h9/LkoVdINrRs/S4sKi9iopam3obBujOsmCLrjgk
	+G3uf7FgYp7mMHUEjdaqe3Xwq2RLhvaAdgj886ud5jcJLDX7NhcO3/rsUa6C7l2S
	ugixhxWvG73xjqTEyQQR9kz1BkpPMIv7LRW5toqVi1tvzB8TfC9MfhBwnTXXeyXY
	lPufnE3klImBiLAjO9Adg6t2OP1rCbaCWBX0lMcTxgZ8g1W631MieL2cHRrkkKyV
	P6aL4A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytfut1fpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:18:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HHIUcl007979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:18:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 10:18:29 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Mon, 17 Jun 2024 10:18:07 -0700
Subject: [PATCH v5 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-arm-psci-system_reset2-vendor-reboots-v5-1-086950f650c8@quicinc.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7RfhUrd-MRB1D75jGkZU693Rv7sBs_E7
X-Proofpoint-GUID: 7RfhUrd-MRB1D75jGkZU693Rv7sBs_E7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170134

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array. Users of the
reboot-mode schema will need to specify the maxItems of the mode-.*
properties. Existing users will all be 1.

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


