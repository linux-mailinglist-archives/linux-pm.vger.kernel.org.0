Return-Path: <linux-pm+bounces-26532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95297AA690D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AA0188D96F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0419A298;
	Fri,  2 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVIGr3RR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C21946BC;
	Fri,  2 May 2025 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155471; cv=none; b=Tb8/LWyROHhldWnAxEdJQOY4Z24N6ayndIRltZCs+Njj8/I4yoJ7Ucw63qfMzfvHl89PscmxA4IRlH6P0sCWlDNwpAJUrAEBseIdbZnZd8ujdSlbPHbrnYEqY16y8kk6ai7jRtbsnMvCD4uQeLMGxiIs6w6hbuCibjHNlP+g98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155471; c=relaxed/simple;
	bh=77RRY1gfnGHVOdryckefcNeXi8AK+kAPQFY0iXee1uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+SzvgRDWlu3XkVVfGc5aOrsDCM1PKW0UZTGSS1Os5MJSwOtv5LNk0rFYx7CQg2W/thYAXjRwoH22WIrcPd0sKT+OGWO1SN8MgoNXdctgC0A+ZpYNld5IyIl+k4I9YhZwltqZXinOQRf7VO560kWlCfUe9bA05Y5NDfjTN9hrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVIGr3RR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421MuZg001319;
	Fri, 2 May 2025 03:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1YMGDY0/0IJuTfeZH9KPF7cm
	RUxl8WOxrbfXgfg9lCw=; b=jVIGr3RRolmt1c2bod1GJPQ9k4mM3TegOOgRlQdO
	B5r2kz3P6bLV6NlaPDhf9ihj95hpFk+IwqgIZPpXTjHSulggtMGyYUCHhZFKE8YF
	vlN493b3hi+c/suGGqlY8FMLiy/e6hDA0rHht5KLldw5iGkub7NGUD+SBEeaaFWZ
	lJgui9dqSes4xfblx8dp2kuFfBeyUp6fBgOHtTgNcKN0O+mzlKt8op9QuBBqVDlK
	kqd9TzreUqAmlNFPpMEUaVIuAhMcX1S71nwfEDmL+XzHvD8hDQptxGAPKxmJScRJ
	ToNhxxc7SqppJ2/KtuaqjtAnHVxmB3JLc4m69GEfY7bVEA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u2f3wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:11:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423B0Hb028533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:11:00 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:10:53 -0700
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
Subject: [PATCH v3 2/9] dt-bindings: serial: describe SA8255p
Date: Fri, 2 May 2025 08:40:11 +0530
Message-ID: <20250502031018.1292-3-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: JbBO0qbbf8wNYaBJ3pAhdEkRjoJxUQOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfXyckAtZ0CF2yM 8yp+KyeFrmIkaWo/vudbejIgwfgqlgrC519fzkN0rS6IaQ0Aqzs+KRKBIpabbUFRW86sctMSMU3 2DvB7LVmLS3H4zBrCMtmvFQ6pkpl0IC8nCYEGrjkx+m2sk7Oi1lcvTrNQcbJpWWdd6aAWFWrkow
 6e4R7psTsrWsDlA6/dkdK/ppCykhgnBhSdTBEgj70Zioyf1+E5eQ1BD5T1VoY89N8AZHsFTy+Rz /CzIos5WG5Z8WJ1LlDSJm6tCEwqbAuTgjjePH0uk7RZNizC/0zteMRw8lVGI+DsixKN7lcb/OkQ pi3PBxsO7CBNNjE+EYuAsvwP+J+ctuv7a5JR75zfWW6Bv7llvJnjZysYmWESYVCLPmU6JPlVsYF
 TbMKzqIHBuzv/RJYe+eN8+hqwJLvS6DSZPPPxjPCQOX7g/muWm68WZ0VqASiKxp3bydqxwkd
X-Authority-Analysis: v=2.4 cv=b5qy4sGx c=1 sm=1 tr=0 ts=681437c5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=rjx3OjMNV77wTL7fGyAA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JbBO0qbbf8wNYaBJ3pAhdEkRjoJxUQOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

From: Nikunj Kela <quic_nkela@quicinc.com>

SA8255p platform abstracts resources such as clocks, interconnect and
GPIO pins configuration in Firmware. SCMI power and perf protocols are
used to send request for resource configurations.

Add DT bindings for the QUP GENI UART controller on sa8255p platform.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

v2 -> v3
- dropped description for interrupt-names
- rebased reg property order in required option

v1 -> v2
- reorder sequence of tags in commit text
- moved reg property after compatible field
- added interrupt-names property
---
 .../serial/qcom,sa8255p-geni-uart.yaml        | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
new file mode 100644
index 000000000000..85b1d7c05079
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/qcom,sa8255p-geni-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Geni based QUP UART interface
+
+maintainers:
+  - Praveen Talari <quic_ptalari@quicinc.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sa8255p-geni-uart
+      - qcom,sa8255p-geni-debug-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: UART core irq
+      - description: Wakeup irq (RX GPIO)
+
+  interrupt-names:
+    items:
+      - const: uart
+      - const: wakeup
+
+  power-domains:
+    minItems: 2
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: power
+      - const: perf
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - power-domain-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@990000 {
+        compatible = "qcom,sa8255p-geni-uart";
+        reg = <0x990000 0x4000>;
+        interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
+        power-domain-names = "power", "perf";
+    };
+...
-- 
2.17.1


