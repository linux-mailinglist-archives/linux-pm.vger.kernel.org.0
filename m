Return-Path: <linux-pm+bounces-31989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1CB1C4D4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC65E624605
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D35F2701B4;
	Wed,  6 Aug 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GcZQYoMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEF433C8;
	Wed,  6 Aug 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479716; cv=none; b=BxxKx28MojFIV1wsULHxvm2fKE8nkre8MdYS+EUDp1jN2cCd5MqGTUI+C/QLmgrWb5I43OMwjf+J5mwfsU0Q5OTh99gTXLQol7cUU0fwqM96WoFtXq8jtRZG5gHj7iVAaKWbqYOxfCnPqDYeoHfIM7XB9I46NrUs4nRoMf2bxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479716; c=relaxed/simple;
	bh=TCVDOI/nwq+wdsjFCcWQPH7JtA88k92LN5FhWHD/Se4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOffdCm1lWjv0zfqv1xrM2d5nMAMO25ChKc2CAPIX7X8y4pkpYGXQSiUtjElB8F9QcXFZ/IoxRMCf9dXY0bFLZswSj2BzjjP9DsU3PtT0/1G9TY92LvBTujsT8rrBZ4LFqROHrtVk5XxWaFUbjhp/6GNwpwxEbM05B8nZzbe7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GcZQYoMy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766Pffu022272;
	Wed, 6 Aug 2025 11:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KDQY8rvGFxV8xSkYF3XKEk+e/YEErkkSbNklOb1V5YE=; b=GcZQYoMyT7cOwm48
	ic2pIw2qOSfA475sJfOcbEUqeyrJ+4IhO+KPfdy84JmGd/i8mG5CXJR7EjllJJ+D
	+0LdmVxz2+hJvI+ziHerxp4iyEpzj0+DEe5JG4yOk8nQ0Lk21FV8R+OFMPtlYTpU
	gEj7wcTFnS8svyl9BkoEMG9s2m7ctgGzNaTWIztjfs2DAMeLkmc2VZk5oiwage9W
	okO0sV4VEz4ktkIp8K3s+FrCrCIKIkLGn2VDFH3EcfKt1HqmsfPkdHIwjJWgWvoQ
	u2EDUjTStP+YXeswsBtt4Qf2ZWD/Oam3for02c8olqvCPmx30kA/V1M4K14uZ4pG
	v76opQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8af4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:28:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 576BSTSa005526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 11:28:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 04:28:24 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: [PATCH v6 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock controller
Date: Wed, 6 Aug 2025 16:58:04 +0530
Message-ID: <20250806112807.2726890-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806112807.2726890-1-quic_varada@quicinc.com>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: k_TRDbaaXds3vAZb_x9dK6tYu4b58Yg0
X-Proofpoint-ORIG-GUID: k_TRDbaaXds3vAZb_x9dK6tYu4b58Yg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8BELyzMyBRuy
 nyxM1fVlNJyW2VT4PcZKMq6sMmjm3Goegx9cYmYSbvKjnvHvl7xDOtPV7bCz076M+6Tcy+Jy4XZ
 U8egppWzVmeO++pHiDaz8LaMZJSXcMzCl+sgOYlNAYienC9WzSq1qEk8fRXRIgsQqkbcCSErIV2
 CK/VTcUtm2yYIKKPw0aWsKVO7FHTbDUVUL9x+xRRrNaHCQeiKkzyPHut6Vf/G2PN3eqpTz1pSRL
 M0Yrk6N5krNdQgFxdGK7KnzbNTJsLzP/PF1T52EGY5KrNYxT5c2BT2KvICZGcHlVjgDk9qgauVx
 +FvMbVY0tx5YTioQao5M1CDJzVcx/xqad/1Ttps75UwXDqgfgyzmoENUsCoFEssLSIZF+lHQOIR
 blyATGaP
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=68933c5e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=uz76iGCsBMoyf62TQt8A:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
The RCG and PLL have a separate register space from the GCC.
Also the L3 cache has a separate pll and needs to be scaled along
with the CPU.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related changes ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Add 'Reviewed-by: Krzysztof Kozlowski'
    Drop 'clock-names'

v5: Remove previous maintainers
    Change clock@fa80000 to clock-controller@fa80000 in example
    Have one item per line for clocks and clock-names in example

v4: Add self to 'maintainers'
    s/gpll0/clk_ref/ in clock-names
    s/apss-clock/clock/ in example's node name

v2: Add #interconnect-cells to help enable L3 pll as ICC clock
    Add master/slave ids
---
 .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 55 +++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
 .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
 3 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
new file mode 100644
index 000000000000..def739fa0a8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APSS IPQ5424 Clock Controller
+
+maintainers:
+  - Varadarajan Narayanan <quic_varada@quicinc.com>
+
+description:
+  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
+  The RCG and PLL have a separate register space from the GCC.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5424-apss-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the XO clock.
+      - description: Reference to the GPLL0 clock.
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
+  - '#clock-cells'
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+
+    apss_clk: clock-controller@fa80000 {
+      compatible = "qcom,ipq5424-apss-clk";
+      reg = <0x0fa80000 0x20000>;
+      clocks = <&xo_board>,
+               <&gcc GPLL0>;
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


