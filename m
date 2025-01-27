Return-Path: <linux-pm+bounces-20964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A81A1D36B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 10:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5331885C71
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483D1FDA9E;
	Mon, 27 Jan 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Txmzoh50"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0091FDA92;
	Mon, 27 Jan 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970317; cv=none; b=htQ6u3wi2aqJmYGMg3uHsZb4kFUycGYR+WcfGt68N7mrsTVOLN6G7srDMU1TmiDv/D7Hk7+kb00U7WWk60qA1FgOohJNXN9f1upV5h2Y4Q6o/7zJxcTirqlWfv7r10/q9j1CSSLpZkwkMDnqeJ2uoITpzm9hpYLOV3wUipGNzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970317; c=relaxed/simple;
	bh=UrdpU8m3WwGRra1df/DTSILFiSTjLqoNi28C1a7RAZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0Q4uG1N6FSVWZo2xj2Xv+wcYgaPRBotVo8JqRJbWNefkMumuMUd3qoqeaVVcb7h8qR2uXqbNbYiEcrTa1o9UoO7eAW+pDRo3kSdFN8AVS/i5J8VgE8pzozPI0CdVskdA7MCHhIeLMKDaUdh7u4/NfjhyyhOgtwVnodhz6nQmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Txmzoh50; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R0FCNV021393;
	Mon, 27 Jan 2025 09:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wjPjZbh9C/DaT4N8duCnctc7Vwn+PLxZQklx1Opjs38=; b=Txmzoh50tA/o+v/q
	9MGYcxokFF4H6UJjFQ9zBUvaJY4hrzmEmqa+9X+sTKbEpG2Z7ILZu3Ozs7Ne4gNs
	C8+F5ueOMblvmbZu3lj7Q2KOG4ZgCG9y5UdlOSvJBBDmCO/ydwH5QWsNt16bwxcq
	ax08vS/nj5fWPw9rsJ4v9rn6oTRqRFQMOO4OqdN/I2pb4A6QHIg3sv0nzga4YGpC
	j0Q6dk8kWbSrYbnXNv6k388GZn9GENHSl1MWjvRwrnDffBaDzHtXrFMBhKSeiMgU
	OU8suHpMxerhhlInBfFHXms8pyPkODqYDl3Mh0L+URO8zIGutq5iaQMDySXy++jN
	/CzY1Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dhu9hq3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:31:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R9VpmH011639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:31:51 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 01:31:46 -0800
From: Sricharan R <quic_srichara@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock controller
Date: Mon, 27 Jan 2025 15:01:25 +0530
Message-ID: <20250127093128.2611247-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127093128.2611247-1-quic_srichara@quicinc.com>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
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
X-Proofpoint-GUID: pOB-Np8iEBN-Hrd7PWpZ_09coYu6YF05
X-Proofpoint-ORIG-GUID: pOB-Np8iEBN-Hrd7PWpZ_09coYu6YF05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270076

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
The RCG and PLL have a separate register space from the GCC.
Also the L3 cache has a separate pll and needs to be scaled along
with the CPU.

Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 57 +++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
new file mode 100644
index 000000000000..df7cfb82bac3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
@@ -0,0 +1,57 @@
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
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
+    };
+
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
-- 
2.34.1


