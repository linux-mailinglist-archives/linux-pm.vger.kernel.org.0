Return-Path: <linux-pm+bounces-25161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC35A84B63
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DFB4E301D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BB28D826;
	Thu, 10 Apr 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mF4IqRqU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225528CF77;
	Thu, 10 Apr 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306869; cv=none; b=TgIm2rrA5I9+kknywfg7chz01TQ7L1G4p+Th4x2H2YwHkxVIYSM9ki44/XLps1tgSDCg6h6HTPRsl7csNCdVZaszmqEBai6Lt6aCHSf5xAmYnCYicbMqLmjNRnFTBlOpfM6D4rvXiPrcK7jOJxdEtHLoVN2+Sjr97gKsgDyxQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306869; c=relaxed/simple;
	bh=/2H1guO9j0KNE3lHyWKg1al7YCB62evG1eBajTrJjek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXOZw9CDoS20oMWKswra5FAcFKlFLDNzDVt7q1edw6xbVfR/WZ/+pNvHB/4aC3d9Bif6tXENIw2W6aKQRsLv/QQnw1ZEpOugHoDKbfYFhD13XcI5N87HQNrQiaaziaWquvufCCyYLqAaEPRw2lPzy1uLUdXoS4yrDEWsd4KMbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mF4IqRqU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFt6i7000880;
	Thu, 10 Apr 2025 17:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IEY7giXvXstwGTp+ywh/7yWs
	Mm601ZNKaembrPraqZ8=; b=mF4IqRqUZ4xPyc7zQgblmgG4+9Q8useTanrEskZO
	BmnedfJj0NNr6HYNvMgeGHNuD+8Mxq69YWS6kKLla7SVQCI2FSTKWqNTwgiDyUWC
	lfgQYrkzbzmJml8v5rKJLtQjCeS3JY0l72v9VfaEfDd5JMRizbfMMnI1bd3vY/Xc
	mSCP4P0fha8G6CNjtA6sECCbzY3BLRjPxpgzCmkRSNYTuTYR5zoGg7cX/FZzbiMX
	NFDNIYFEaiqMvUFiVJ3A+75QDJR6bWdeO5ksiEO5YepS0RdYhBphNH4EPXd694EJ
	T3XQyrD+q8mLXFwp3DrBd0ZAEWCBGsiDI1CB43Qj+S1RpA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2yu4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AHf0RF007986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:41:00 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 10:40:53 -0700
From: Praveen Talari <quic_ptalari@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Praveen Talari
	<quic_ptalari@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
Subject: [PATCH v1 3/9] dt-bindings: qcom: geni-se: describe SA8255p
Date: Thu, 10 Apr 2025 23:10:04 +0530
Message-ID: <20250410174010.31588-4-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250410174010.31588-1-quic_ptalari@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tqIpBGFNwoavirgIP5IjS_AINHPb3hR6
X-Proofpoint-GUID: tqIpBGFNwoavirgIP5IjS_AINHPb3hR6
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f802ad cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=s2ejLvL1BUKWkZXtkIwA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100127

From: Nikunj Kela <quic_nkela@quicinc.com>

SA8255p platform abstracts resources such as clocks, interconnect
configuration in Firmware.

Add DT bindings for the QUP Wrapper on sa8255p platform.

Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
new file mode 100644
index 000000000000..cdc2e032f570
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,sa8255p-geni-se-qup.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GENI Serial Engine QUP Wrapper Controller
+
+maintainers:
+  - Praveen Talari <quic_ptalari@quicinc.com>
+
+description:
+ Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
+ is a programmable module for supporting a wide range of serial interfaces
+ like UART, SPI, I2C, I3C, etc. A single QUP module can provide up to 8 Serial
+ Interfaces, using its internal Serial Engines. The GENI Serial Engine QUP
+ Wrapper controller is modeled as a node with zero or more child nodes each
+ representing a serial engine.
+
+properties:
+  compatible:
+    const: qcom,sa8255p-geni-se-qup
+
+  reg:
+    description: QUP wrapper common register address and length.
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+patternProperties:
+  "spi@[0-9a-f]+$":
+    type: object
+    description: GENI serial engine based SPI controller. SPI in master mode
+                 supports up to 50MHz, up to four chip selects, programmable
+                 data path from 4 bits to 32 bits and numerous protocol
+                 variants.
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: qcom,sa8255p-geni-spi
+
+  "i2c@[0-9a-f]+$":
+    type: object
+    description: GENI serial engine based I2C controller.
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: qcom,sa8255p-geni-i2c
+
+  "serial@[0-9a-f]+$":
+    type: object
+    description: GENI Serial Engine based UART Controller.
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: qcom,sa8255p-geni-uart
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    geniqup@9c0000 {
+        compatible = "qcom,sa8255p-geni-se-qup";
+        reg = <0 0x9c0000 0 0x6000>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        serial@990000 {
+            compatible = "qcom,sa8255p-geni-uart";
+            reg = <0 0x990000 0 0x4000>;
+            interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
+            power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
+            power-domain-names = "power", "perf";
+        };
+    };
+...
-- 
2.17.1


