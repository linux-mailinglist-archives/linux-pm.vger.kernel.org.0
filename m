Return-Path: <linux-pm+bounces-31368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74307B107B0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414DE1CC274F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EEF265632;
	Thu, 24 Jul 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XLGq/Bmd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1A265614;
	Thu, 24 Jul 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352773; cv=none; b=dHrZoyQyMnj1TPhKi7oinINsQaXCnJcFdU2aP83frtOLpoyXCFZBj4LLJ3Z44QwlG3J7dE1K54HOl4xWUq8UqSnY0Xc5lKnHZgVnUR47y0sqZ8uOiWBx8bk7QOXX2Ic5T5Y8mfnXkzT12FUtIyVj4uxeOZtratr6vTtco4Jxxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352773; c=relaxed/simple;
	bh=f5hFzyqfi79CYRrQfT0e+5B1D+tOqlPGzDYHQkwCOYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/LE/1jyt73UT+G4PJrtWrEdhtrXumtDOBbXhqWGe9XLnKtOsyzyCiwZvlgRpLUTxYuHyoZ9DuPJr3QqiMEdaLgIM0UrjKf68G3A9G2aqreGkFPDA+fs+SEF17slMsOtN9bSmv/MuvCxhIbG5sjTliPemvrj/sULqMIaV3pnFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XLGq/Bmd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9hsHT028534;
	Thu, 24 Jul 2025 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OO0ft4fq4gRriGrrw9/acPRVhY3XFlUUkjAFvDmYWEc=; b=XLGq/Bmd7Fhmdp5B
	6rY1KLCLfDIJGjVGbiHoPw0Ri/P6hMdTCvs5kZGts6QedzKq2DrKykqp3PneZ1zX
	+bRIJzNrULZ7i8LjmZ6W7wKZWe3DVC1GpQikfvkJrK9hkulJDiqkFv1xLdc8mSaR
	e0PrXiiNrc9PvR/wI/Z1Br5s1b+K0De8Y4MPlaArVWA6peBMOz1LsKw+HNIbAMea
	3BCByLFjbx7tqHcuavDnPG+Y++H0KqG3h9Wo0wG73ZwyCM9Wjuoe9Ug7P42SFL1x
	ui4zSSgKw54b74xy6jQGoT+3wZ41OrRLT8cCqYf8B50JBHE3UiA1VQsab13r8Gs/
	7IAnwg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1fpbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OAQ6gN014688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 03:26:01 -0700
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
Subject: [PATCH v3 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock controller
Date: Thu, 24 Jul 2025 15:55:37 +0530
Message-ID: <20250724102540.3762358-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724102540.3762358-1-quic_varada@quicinc.com>
References: <20250724102540.3762358-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: -Std3i49QQkuLO2do7TIeJocgrnA1Rnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NyBTYWx0ZWRfX3ElBPiG2vJ2U
 o5e/dJ8x2k8mQpORU/madQfDp26/9KVeWbkjfCFiioThtl/X+QTb5rNqetrL+SDDMVe4Klb+/9E
 Lro/HW+TInkDYgPtTydODkWDUOyFixR13OpUFe66HPzc9CrgdfHb+OCgEl/COFiZ/H/KiLcSc4R
 zg2NhzBqaxPbl7M/0nM8r1deh5fm4efWLxmVTpcbcFvijh8EI1WtBEBJX/VCrDcH8yFQlq/oVTn
 mGtO7HYT01zLIVR+ZRSaKyxihfyilu9VmfEheHhi3inTmKQA2VZ4ahIzVZDkoL1pABYNxSQb0Gv
 UlqLP6VPx2EQfWb9rxhXyd/PqTmXQ26NpMziqk1LiTIjp8s69FDonb+GtR9+rnBVinDaWrcLoGQ
 r3+gfV6uwPNpSpnd2wHmLhcM9P3Myt84ZxvOvv/cicfcUy/8GtZOcPjRaWcr79Dz7honzO50
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68820a3f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8
 a=XO5-lTlbq7D_d7JOJAUA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -Std3i49QQkuLO2do7TIeJocgrnA1Rnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240077

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


