Return-Path: <linux-pm+bounces-7881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A256A8C6EF6
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 01:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA89282F4B
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 23:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C507482E2;
	Wed, 15 May 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l9nQ279a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF193CF6A;
	Wed, 15 May 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814639; cv=none; b=iFKY4chuLODGG434PIl9KPZ0lFchg0L0w6BesUVfAgo3qB4kqEOyQdmTxQPDiFOGOiSSdcm1J8EegCwu+ukyw/qnuozI7lFVy8fZkrNwcrzvjKf85GWDfbu3/xmQ6dTBKbHgr4BzsUlApA0g0ezwPlOed75z2snWBSFXnLrBebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814639; c=relaxed/simple;
	bh=8AXKvZ8EP7BiCy1+2dQti2Y/sJNHA9KXCuSj7SzSeUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s9v8WaEcrJ58ZaZsNCwnnIaPRqq4AsJhU+ntweG/M3pmNYKMkH32XUIgtuOpDVD/7lQJPrtj4wobs/sg0NR3IdCleg+Q6YrihTpNRvplHjxRYgVcdO/krdIkZ9sG+kt+FdJhQkRLRqDms4dWKjk3Q7oSKQR98zrgxnd3cDMv7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l9nQ279a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FMs4Tm006229;
	Wed, 15 May 2024 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=yKs5j0Cr0dh3HgK94KRz2k2K+I5xpRwU42X82p84/jA
	=; b=l9nQ279ay3VyvM1hL04gmCfY+ktZutoikqtF+mPXWduG8iCmEF6R5ZIza/D
	X9bgXiGBEOedQJ649R9tLXDdbm2V8ogkGQBbsP+of2cdLDRO0Nk2RD5xAvbq0jta
	/P6bt8M0l8KbTC+XQRFz6EUbfoTwNUso+JwNx5lJ2qv4igFVTrO8Nevhipr1Y/h8
	Jtve8Ec94Lzu2QTB+o1bNf9LwOwXfGIPtGwrtxbCqbxSak1Bl9Viut8k9z5HfKNU
	8Ky8bWGWw5z6s1vB6hCvwfKiPuZkOyZ5eMHwh5tpUXudkvBi79KDBpJfv7xaRm/z
	cTg18BTukvhWEKJrAXLfbEDmErw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvvt39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FNA6N3030147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:06 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 16:10:06 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Wed, 15 May 2024 16:09:45 -0700
Subject: [PATCH v3 2/4] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240515-arm-psci-system_reset2-vendor-reboots-v3-2-16dd4f9c0ab4@quicinc.com>
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
X-Proofpoint-GUID: nyU1o3LrxiZMp2jz_RsTVYip4l9x17VH
X-Proofpoint-ORIG-GUID: nyU1o3LrxiZMp2jz_RsTVYip4l9x17VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150164

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index cbb012e217ab..47b5bbe540ce 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -137,8 +137,34 @@ allOf:
       required:
         - cpu_off
         - cpu_on
-
-additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,psci-1.0
+    then:
+      properties:
+        reset-types:
+          type: object
+          $ref: /schemas/power/reset/reboot-mode.yaml#
+          properties:
+            # "mode-normal" is just SYSTEM_RESET
+            mode-normal: false
+          patternProperties:
+            "^mode-.*$":
+              items:
+                maxItems: 2
+              description: |
+                Describes a vendor-specific reset type. The string after "mode-"
+                maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+                Parameters are named mode-xxx = <type[, cookie]>, where xxx
+                is the name of the magic reboot mode, type is the lower 31 bits
+                of the reset_type, and, optionally, the cookie value. If the cookie
+                is not provided, it is defaulted to zero.
+                The 31st bit (vendor-resets) will be implicitly set by the driver.
+
+unevaluatedProperties: false
 
 examples:
   - |+
@@ -261,4 +287,17 @@ examples:
         domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reset-types {
+        mode-edl = <0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


