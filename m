Return-Path: <linux-pm+bounces-25715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227B9A93940
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559281B62C3D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51AA21325D;
	Fri, 18 Apr 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Td9Q2Bb9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18987213227;
	Fri, 18 Apr 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989210; cv=none; b=KCOBRiuNdK3fIxGH3LsJZM/nqqfZwmoPpdx0jHEklltTR9sjccsUuVHWZU4PEiEP9vkH6ksqVzUJT+SBGApRggYn6NGS+x/M6+hDx8a3S5VluamJp3jLWHY9tmCf1IecabR0xqsFq98Fum1MUBRbfJ8Q/JAg8xy+wUxH1NrjMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989210; c=relaxed/simple;
	bh=7cdwl+0UlsD8GFvZpA15i0N5dYWkjLfjtKC73puTCTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1jYWy0VZIQfFZR4UUrZQpk/MIMdiJtA0eCPbGxnoCsgZCqF5ODH7JYK4DxI6wbvO92z0u8E3/C71XwtV0iaM6SXsVixwBA/C/BchNkpmYGegjxEkE7Ar4MxdG30y8Kv8l37fyXUwGG6NvmwicGhpstr7zjgDqh3SWKB4KpTHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Td9Q2Bb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2vxDG012762;
	Fri, 18 Apr 2025 15:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+H7rHyckZgRe6H2I63ZTPijv
	5RKsPq5T0RS3eyDS+8M=; b=Td9Q2Bb9n6pQi9CAqgqvtxrAKKNxScg9m1pXaIhu
	w5GRqVWxiIJgz3hcHBLjDvuUgTtmyVLX+LGPwQdIjelAFYC73d7FyuHVnH89s5oo
	bnECZvP8YX066qhYOCyvFwWt8dMo5WpUDxWgsDymcf4XzrTwasKTt6hzQNICZ9z+
	dAI6hhPGkOAatf3+4Z6fcKw0RS20QXQwXE+mfHYwb3pG9WR8W1j6SpwW86+28yz5
	OOGhXvCH3fXHZQVabYQzR2TEbHSbPmF1dwGfppxQJXTf31CyfNDPtxjJBWVoyFsT
	po6jXEadoii4n73Hi6X0luBcViHfsSin1hrAC3un1NU1iQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vtdr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFDNQq006959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:23 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:13:16 -0700
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
Subject: [PATCH v2 3/9] dt-bindings: qcom: geni-se: describe SA8255p
Date: Fri, 18 Apr 2025 20:42:29 +0530
Message-ID: <20250418151235.27787-4-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250418151235.27787-1-quic_ptalari@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3NUHNeDOpCiXTFh2Pa4TgWieNCLD4u1f
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=68026c13 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=v7CWcBsnNxNFVLN3aFYA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3NUHNeDOpCiXTFh2Pa4TgWieNCLD4u1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

From: Nikunj Kela <quic_nkela@quicinc.com>

SA8255p platform abstracts resources such as clocks, interconnect
configuration in Firmware.

Add DT bindings for the QUP Wrapper on sa8255p platform.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v1 -> v2
- reorder sequence of tags in commit text
- resolved waring errors while encountered in dt binding and dtb check.
---
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
new file mode 100644
index 000000000000..0981635783a9
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
+        enum:
+          - qcom,sa8255p-geni-uart
+          - qcom,sa8255p-geni-debug-uart
+
+additionalProperties: false
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


