Return-Path: <linux-pm+bounces-31325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C256B0F0C8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5B16A2CD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208A2E11A9;
	Wed, 23 Jul 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U4wEUEYB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F982BEFFB;
	Wed, 23 Jul 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268928; cv=none; b=E6hrTYJN2pEypFGeUXRLG5DQZZYIoJoNOFoHCKcNt7f+jWDm6I9/KHySV7DNDMJ7P2IUqnLgp9SpvJMxuNWXXRPrPsnEhusKwaFoqhjnjmJqi6FSEAnyUoKPHSHvKnAQhOgte5RJSV9G5n9dVKaxGSAHSUSu/Uj8yzOrdV4GKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268928; c=relaxed/simple;
	bh=f5hFzyqfi79CYRrQfT0e+5B1D+tOqlPGzDYHQkwCOYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jcb5taJpt3Y2a8bkh7OAeX3WPCkIEWmBx9J8RpiXPiTd890rhHe2F/wmvfURonrO6fKiPYjT+F0cxX82CdAwDi9ZZnSl0CI+8YXOGJxQ7VLFnggVeRwUihdpz+9cl0cJOyz8g4EjJE5dV39iO60loRxi/3Q9dC15GPJp43qzdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U4wEUEYB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9b1lZ011036;
	Wed, 23 Jul 2025 11:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OO0ft4fq4gRriGrrw9/acPRVhY3XFlUUkjAFvDmYWEc=; b=U4wEUEYBKj2it7SP
	ZxLk3Sq+Ubc56KW07/rDb0TA1KxAEgXFfZGtrqIkkpS47Sxe++tjVOCBsjIuV7BH
	2OE7ur6rQansI9F6Wwc0mI6/xZKcxpbNxSnHEWKBd6qTs4kSXnSzFAguZS9JoFpk
	87cMIOg4MEwf3XioMQh3Zk/M9YlCogHBY6QUzNXl+GNdXyO8H1QLWx03hVQlgJyG
	GyRfvNenJcV/DHVP9PHTaQHzJ6asLFbqLP/naHeOLjwnl3KsYOpFXLxTn1tMtW9D
	XsNwE3LIoA9N9altKgzenx9X1giMVSKTjNsZUnYzqw7sYQpFffFfuIddADxbuAJ/
	/Bf08A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3htxar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56NB8eb4021807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Jul 2025 04:08:35 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock controller
Date: Wed, 23 Jul 2025 16:38:12 +0530
Message-ID: <20250723110815.2865403-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723110815.2865403-1-quic_varada@quicinc.com>
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880c2b9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8
 a=XO5-lTlbq7D_d7JOJAUA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX1mrvDP++QWF4
 qdn2melBQ+z5kIKK7W+6ZbQcgGlbTFQ9LAzLUU6SUGFTYkzJLJ+z+Tk8OMsFkOSvga8eYEF96j5
 26e5TPBh/5i7UDaMBrV0ifwD9aBN5qWTr2JJdYvyWOHKcZTm8OaaWRg19eRcKK8iKA/l+tcrN26
 SE4YxWyi3xhWcTNnsRp5Wbi5eVp83pJgnXEyd2iYyF19YY8CnGBJPW4mMK/9ZjVNKVSeQ3aAsCu
 5aJgsosNpDG9z1fU2xoHWINLRSRsVMsUb32VbCkmaW9ClNBtjUX5PqIEHVou1rRwthWY/hH+Mnc
 HO7OSNawOdUdsnqRb9A3zIdtRUn4RVHNaCUO2POeT9zLPF6rhFg3b3y/jY0wqSxFYpVFU6kbkGh
 NNCJYBI0xLtk05Jn8Sl8GC53++3vVqfVTALs83vXf7qMOpWVU+2ehCUzQ713TEniJcUXan0J
X-Proofpoint-GUID: yWRJmJ9HTUkuJlJzemt_Mi5fOzh5srNH
X-Proofpoint-ORIG-GUID: yWRJmJ9HTUkuJlJzemt_Mi5fOzh5srNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
The RCG and PLL have a separate register space from the GCC.
Also the L3 cache has a separate pll and needs to be scaled along
with the CPU.

Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related changes ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add #interconnect-cells to help enable L3 pll as ICC clock
    Add master/slave ids
---
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 61 +++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
 .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
 3 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
new file mode 100644
index 000000000000..abb9eb78d271
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APSS IPQ5424 Clock Controller
+
+maintainers:
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+  - Md Sadre Alam <quic_mdalam@quicinc.com>
+
+description: |
+  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
+  The RCG and PLL have a separate register space from the GCC.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5424-apss-clk
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the XO clock.
+      - description: Reference to the GPLL0 clock.
+
+  clock-names:
+    items:
+      - const: xo
+      - const: gpll0
+
+  '#clock-cells':
+    const: 1
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+
+    apss_clk: apss-clock@fa80000 {
+      compatible = "qcom,ipq5424-apss-clk";
+      reg = <0x0fa80000 0x20000>;
+      clocks = <&xo_board>, <&gcc GPLL0>;
+      clock-names = "xo", "gpll0";
+      #clock-cells = <1>;
+      #interconnect-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/qcom,apss-ipq.h b/include/dt-bindings/clock/qcom,apss-ipq.h
index 77b6e05492e2..0bb41e5efdef 100644
--- a/include/dt-bindings/clock/qcom,apss-ipq.h
+++ b/include/dt-bindings/clock/qcom,apss-ipq.h
@@ -8,5 +8,11 @@
 
 #define APCS_ALIAS0_CLK_SRC			0
 #define APCS_ALIAS0_CORE_CLK			1
+#define APSS_PLL_EARLY				2
+#define APSS_SILVER_CLK_SRC			3
+#define APSS_SILVER_CORE_CLK			4
+#define L3_PLL					5
+#define L3_CLK_SRC				6
+#define L3_CORE_CLK				7
 
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index a770356112ee..afd7e0683a24 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -21,4 +21,7 @@
 #define MASTER_CNOC_USB			16
 #define SLAVE_CNOC_USB			17
 
+#define MASTER_CPU			0
+#define SLAVE_L3			1
+
 #endif /* INTERCONNECT_QCOM_IPQ5424_H */
-- 
2.34.1


