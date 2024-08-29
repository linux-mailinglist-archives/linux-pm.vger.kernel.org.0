Return-Path: <linux-pm+bounces-13136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637A963E7A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B296B21393
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7A18C344;
	Thu, 29 Aug 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L+72ERyl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5F16133E;
	Thu, 29 Aug 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920180; cv=none; b=RdhBl4gbRv9Cwrkch66ZGUQ39r+foFQLUUTgnPsS6ywko+Owm9UdwhSxesMChKZpdISenyVxR/eQAzwdOz8Sh43jB6Uozr8Vqg6J7ZUzziMK5y+ggtXDnrJ0jxEuLInbsj3CqnGL8WSVOUPL45nq6XIWGRwvv8/TetcLHn3UwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920180; c=relaxed/simple;
	bh=6FquL7D28JeRTMGgxXitDxIasl1Fl9U6xpjT3ocpgfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmZOvMces0u2IdbYjLGWqINiB1usX7aQ5xZErxViesY/KwcbJahFj69OJSHzrA4i/5hjgH+iDMD95cCI/wuhwCxaMKC4w8r5g9L9NvFYVuFFCPyGap0cxov/7nsNT86xWmP8kTitZ1A6hFrp4ZwbROrvEP0vpgLLbuUNxcDuhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L+72ERyl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJNXDA022271;
	Thu, 29 Aug 2024 08:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wW7CmuuYW7cW5rOLbcOIc7Py+dDmsp1HBSPpTbJNDM0=; b=L+72ERylu4+6jtvW
	XcpXZZGytJnIaWjzMUZ6B4XsMoPznt3SDNtRjbZQN87IebglXgA3Z/gnGy7WVdqZ
	AmiWZ20JlxCBF9XGmE3ZMDOWM8F8QO/CFuYpgnPUjqKSwg9qvTbsGQw8OuoY4b8F
	fsHb0JG3++QKzJ18u0dt3Vp+w6SiPm5AGH8zjGtyEIJO0PfoZkAtrWThs3Cjo7fc
	lVaINRIQ5prZL5+kN8cglDTIfB0EahlNsUWIccllYEzRBkuRDm0dEiER8eL40NGM
	LHGM3oow9KPpELqhKoeqYEx20GfGPEoy5s031nAGQVulnGGKWUOruVUSE56aKIoT
	W0WbUw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putmh93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8TL4U002445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:29:14 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
Subject: [PATCH v5 3/8] dt-bindings: clock: add Qualcomm IPQ5332 NSSCC clock and reset definitions
Date: Thu, 29 Aug 2024 13:58:25 +0530
Message-ID: <20240829082830.56959-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829082830.56959-1-quic_varada@quicinc.com>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1C7cHWsIzs2dK3lrOyCWFuWtWDi0R0a-
X-Proofpoint-ORIG-GUID: 1C7cHWsIzs2dK3lrOyCWFuWtWDi0R0a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290062

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Add NSSCC clock and reset definitions for Qualcomm IPQ5332.
Enable interconnect provider ability for use by the ethernet
driver.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Marked #power-domain-cells as false
    Included #interconnect-cells
    Removed 'Reviewed-by: Krzysztof' due to above changes
---
 .../bindings/clock/qcom,ipq5332-nsscc.yaml    | 64 ++++++++++++++
 .../dt-bindings/clock/qcom,ipq5332-nsscc.h    | 86 +++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,ipq5332-nsscc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
new file mode 100644
index 000000000000..8a26635e9b19
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5332-nsscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ5332
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm networking sub system clock control module provides the clocks,
+  resets and power domains on IPQ5332
+
+  See also::
+    include/dt-bindings/clock/qcom,ipq5332-nsscc.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq5332-nsscc
+
+  clocks:
+    items:
+      - description: Common PLL nss clock 200M source
+      - description: Common PLL nss clock 300M source
+      - description: GCC GPLL0 out aux clock source
+      - description: Uniphy0 NSS Rx clock source
+      - description: Uniphy0 NSS Tx clock source
+      - description: Uniphy1 NSS Rx clock source
+      - description: Uniphy1 NSS Tx clock source
+      - description: Board XO source
+
+  '#power-domain-cells': false
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@39b00000 {
+      compatible = "qcom,ipq5332-nsscc";
+      reg = <0x39b00000 0x80000>;
+      clocks = <&bias_pll_cc_clk>,
+               <&bias_pll_nss_noc_clk>,
+               <&gcc_gpll0_out_aux>,
+               <&uniphy 0>,
+               <&uniphy 1>,
+               <&uniphy 2>,
+               <&uniphy 3>,
+               <&xo_board_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #interconnect-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,ipq5332-nsscc.h b/include/dt-bindings/clock/qcom,ipq5332-nsscc.h
new file mode 100644
index 000000000000..c077cde7f57d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5332-nsscc.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_NSS_CC_IPQ5332_H
+#define _DT_BINDINGS_CLK_QCOM_NSS_CC_IPQ5332_H
+
+/* NSS_CC clocks */
+#define NSS_CC_CE_APB_CLK					0
+#define NSS_CC_CE_AXI_CLK					1
+#define NSS_CC_CE_CLK_SRC					2
+#define NSS_CC_CFG_CLK_SRC					3
+#define NSS_CC_DEBUG_CLK					4
+#define NSS_CC_EIP_BFDCD_CLK_SRC				5
+#define NSS_CC_EIP_CLK						6
+#define NSS_CC_NSS_CSR_CLK					7
+#define NSS_CC_NSSNOC_CE_APB_CLK				8
+#define NSS_CC_NSSNOC_CE_AXI_CLK				9
+#define NSS_CC_NSSNOC_EIP_CLK					10
+#define NSS_CC_NSSNOC_NSS_CSR_CLK				11
+#define NSS_CC_NSSNOC_PPE_CFG_CLK				12
+#define NSS_CC_NSSNOC_PPE_CLK					13
+#define NSS_CC_PORT1_MAC_CLK					14
+#define NSS_CC_PORT1_RX_CLK					15
+#define NSS_CC_PORT1_RX_CLK_SRC					16
+#define NSS_CC_PORT1_RX_DIV_CLK_SRC				17
+#define NSS_CC_PORT1_TX_CLK					18
+#define NSS_CC_PORT1_TX_CLK_SRC					19
+#define NSS_CC_PORT1_TX_DIV_CLK_SRC				20
+#define NSS_CC_PORT2_MAC_CLK					21
+#define NSS_CC_PORT2_RX_CLK					22
+#define NSS_CC_PORT2_RX_CLK_SRC					23
+#define NSS_CC_PORT2_RX_DIV_CLK_SRC				24
+#define NSS_CC_PORT2_TX_CLK					25
+#define NSS_CC_PORT2_TX_CLK_SRC					26
+#define NSS_CC_PORT2_TX_DIV_CLK_SRC				27
+#define NSS_CC_PPE_CLK_SRC					28
+#define NSS_CC_PPE_EDMA_CFG_CLK					29
+#define NSS_CC_PPE_EDMA_CLK					30
+#define NSS_CC_PPE_SWITCH_BTQ_CLK				31
+#define NSS_CC_PPE_SWITCH_CFG_CLK				32
+#define NSS_CC_PPE_SWITCH_CLK					33
+#define NSS_CC_PPE_SWITCH_IPE_CLK				34
+#define NSS_CC_UNIPHY_PORT1_RX_CLK				35
+#define NSS_CC_UNIPHY_PORT1_TX_CLK				36
+#define NSS_CC_UNIPHY_PORT2_RX_CLK				37
+#define NSS_CC_UNIPHY_PORT2_TX_CLK				38
+#define NSS_CC_XGMAC0_PTP_REF_CLK				39
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC			40
+#define NSS_CC_XGMAC1_PTP_REF_CLK				41
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC			42
+
+#define NSS_CC_CE_APB_CLK_ARES					0
+#define NSS_CC_CE_AXI_CLK_ARES					1
+#define NSS_CC_DEBUG_CLK_ARES					2
+#define NSS_CC_EIP_CLK_ARES					3
+#define NSS_CC_NSS_CSR_CLK_ARES					4
+#define NSS_CC_NSSNOC_CE_APB_CLK_ARES				5
+#define NSS_CC_NSSNOC_CE_AXI_CLK_ARES				6
+#define NSS_CC_NSSNOC_EIP_CLK_ARES				7
+#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES				8
+#define NSS_CC_NSSNOC_PPE_CLK_ARES				9
+#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES				10
+#define NSS_CC_PORT1_MAC_CLK_ARES				11
+#define NSS_CC_PORT1_RX_CLK_ARES				12
+#define NSS_CC_PORT1_TX_CLK_ARES				13
+#define NSS_CC_PORT2_MAC_CLK_ARES				14
+#define NSS_CC_PORT2_RX_CLK_ARES				15
+#define NSS_CC_PORT2_TX_CLK_ARES				16
+#define NSS_CC_PPE_BCR						17
+#define NSS_CC_PPE_EDMA_CLK_ARES				18
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES				19
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES				20
+#define NSS_CC_PPE_SWITCH_CLK_ARES				21
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES				22
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES				23
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES				24
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES				25
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES				26
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES				27
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES				28
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES				29
+
+#endif
-- 
2.34.1


