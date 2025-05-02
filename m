Return-Path: <linux-pm+bounces-26533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF48AA6913
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58241B6198E
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363F1A4F3C;
	Fri,  2 May 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RFOpw9s5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036D1946BC;
	Fri,  2 May 2025 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155476; cv=none; b=G+120Lx6lBGeVUPuLOA56EbC4bEVQGLpGJ4wYZjgzpoLm8zT12+9rQX+FUoCyEDRpanSJMUFlIYph1TxKfXaXv1Fv7UziaqV3P067UDCMOmSPMWNkacFl6Pd1jgwL529URjEP6RcWkKvG7PjgQl5lt8QwoS9UWxYcEcsxSyYs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155476; c=relaxed/simple;
	bh=2m7H+qFp9Hvgc7c/cukzUS+yauY7dxjCLlFLtFv7r7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtfRQ/bFHye3dwwKfcZ1e3MUK+r+pKeqM5RVF6r0xCw5lfjxnS6Uw/daxiXp9tL5sDleBGp7aeh3kXeOJfUnpCrxTKeI6BN8etmOZrsdq4Nc7N02V37C7lftYQDapSZN+1QKxyfkREm+luouWbP7WTjufgC5n8UstuE/Y9Hh7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RFOpw9s5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NHTw010559;
	Fri, 2 May 2025 03:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CryhNpqfJBxCwUelUeCXITsJ
	OgQl7/V7OBfQTpnv+l8=; b=RFOpw9s5mGyf56Y8RXpyZfVB956s5sxGr6EOaLU8
	40SgSh7SBAdp3SG3DXVF7xBxkOyII083AtJokp7B9Hsou5UMWGgVmxzs8B3SVACH
	bSywW9lPdRrJ0Ny194OuVv9nZcWCnhT6Bsjy8UEz1JSdSuCqnMNVc1uoDDUwqNvX
	UxOS2YDWd7V6g/Dq0UVMG/2BUwzFL6Y7Zs+qy3gAuRjg2TJZabOK9hL6QBAlGHvt
	T6UPVlAgViEe1DJScioJw5e8Jagagkw/L1sEdNrfxLWb873kbWkiDE/frdl2emsv
	6LEODhTNqFTpu0hFYSfsb7YAyB22aYx6m0jGMWnnEHzuIw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u9y099-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423B9rg028681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:09 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:11:02 -0700
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
Subject: [PATCH v3 3/9] dt-bindings: qcom: geni-se: describe SA8255p
Date: Fri, 2 May 2025 08:40:12 +0530
Message-ID: <20250502031018.1292-4-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250502031018.1292-1-quic_ptalari@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: NVhd4-dbQnFj7pXGAqjOIaNO-NXqHZ2i
X-Proofpoint-ORIG-GUID: NVhd4-dbQnFj7pXGAqjOIaNO-NXqHZ2i
X-Authority-Analysis: v=2.4 cv=UZZRSLSN c=1 sm=1 tr=0 ts=681437ce cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=v7CWcBsnNxNFVLN3aFYA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfXxi0CxqslQwrp 53azCw6nLJ4AH1PIlo5oC2Jopb5HvcV+TMNazNXfnvAqPvXbWTr3MidWJcweowW+FSM/aCAKDOo 4gLQwsQIikYDNv59ffsbNY7HM2I0W/LBPw02d8jePPc1y46TLTBHUJASGFeyDNLdKZ03N+K9yL/
 OERKRqcKWvg3aiAHbyQ9IHDZvQzIlPHPRRHWtVVH1hKHSVnGIMuOqLpACJQjWgNCKvwFCirigje cvXbJHU10YY3+nNloI17gHfoeKJVDwhn+hi1Z+Dr30ovGt+gh3PXM2AXzYSU5G842/BrFm3ys2L 1Bs6d60ce9Uol5tw2oTkh6ju7BpdeYU/iGFw+ru5MMwi/0jH3nyaTalLn5WPWW4IZFsNrrMNvPo
 26uJ0L/+FzurOGxaSkRr1M1OLpWFQdqY2hKh6yoYBXlZWVk0uMYsdb6L+c6lzJLnfurHjj/Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

From: Nikunj Kela <quic_nkela@quicinc.com>

SA8255p platform abstracts resources such as clocks, interconnect
configuration in Firmware.

Add DT bindings for the QUP Wrapper on sa8255p platform.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

v2 -> v3
- reordered required option

v1 -> v2
- reorder sequence of tags in commit text
- resolved waring errors while encountered in dt binding and dtb check.
---
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
new file mode 100644
index 000000000000..b66c7c45a6ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
@@ -0,0 +1,107 @@
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
+  Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
+  is a programmable module for supporting a wide range of serial interfaces
+  like UART, SPI, I2C, I3C, etc. A single QUP module can provide up to 8 Serial
+  Interfaces, using its internal Serial Engines. The GENI Serial Engine QUP
+  Wrapper controller is modeled as a node with zero or more child nodes each
+  representing a serial engine.
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
+        enum:
+          - qcom,sa8255p-geni-uart
+          - qcom,sa8255p-geni-debug-uart
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        geniqup@9c0000 {
+            compatible = "qcom,sa8255p-geni-se-qup";
+            reg = <0 0x9c0000 0 0x6000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            serial@990000 {
+                compatible = "qcom,sa8255p-geni-uart";
+                reg = <0 0x990000 0 0x4000>;
+                interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
+                power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
+                power-domain-names = "power", "perf";
+            };
+        };
+    };
+...
-- 
2.17.1


