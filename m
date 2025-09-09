Return-Path: <linux-pm+bounces-34267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A1B4FDED
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4CA3BA51C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF6353373;
	Tue,  9 Sep 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dkI05y6g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C60341663;
	Tue,  9 Sep 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425279; cv=none; b=hKTm3yVBoLsvYph9FB4J10ouQZXylze6w0wrms6jVmZznsv/V/8H1DgcAhwa98hF91ePlishwcY8NOKwr6n8rMHRY3hxo6K6Efha+r3iMr3R7I8/SNINO6eckGeEpVCJqe6bVutpblA4HaJwnvBfQLn70wC1Gm/Xpx5fS+udVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425279; c=relaxed/simple;
	bh=DRjYKEn2nud9BTTTRxaMYgJotGkPOwwn5MtnmndnAT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z3ZhZ7pv85nDKIk5iIWIPVPBW+KeV78Cd7WAIHjly1zgo/ebUKHt+MmKXI1eQZbgeLF0OIYVqqdIXhtl5yyLbMGld67V6ojYB2XOXhov37v9lVkTCRqTVsyGAQ/weX2uOd38GYUYMhX0XzZsYMRu93QG5cQSaps7WjNMuQjhUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dkI05y6g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Lgie030651;
	Tue, 9 Sep 2025 13:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5r6NZm//czoCvWL8JQ5vuOTe3YsYCEqVkxBtSQ+FpDg=; b=dkI05y6gnRgTHDTk
	AW3cnkVoVBGb8xBOP4Oru/w2EADOXIR/un8Zmk9Dgs++qDsev7y/tx620OaKI8lh
	1lDQDMLph6aJ7VnJspys+9B00SoKMJ6VG9sQWh2SgB01VQGDX52TZY1bp91zWkYU
	NjhimdA/QG9OXdQqyyKDNw8E7cvsFnZUtANY/gWnyQiPtExDKLxprVD+qG08JgfC
	ANMU4VvLW2k7IkVuKjb++jx8uJKsQKql0l95YM1puhQrg7bsL59orR8bxrorngpl
	SyKDTQstAFdj5r5i0GXQx3TJ6qG0i//pQ4rx4xKh40NrDCpQu4hx6MJkrJ8+ayHh
	5APZ7A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j8fga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:41:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589Df4Hk026246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:41:04 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:40:04 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:16 +0800
Subject: [PATCH v5 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-7-332c49a8512b@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=10044;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=DRjYKEn2nud9BTTTRxaMYgJotGkPOwwn5MtnmndnAT4=;
 b=cVWut/sKnwdhGRswuFETnKojFTm8Xo4FfssoCC9sXOKIRG6eo+Q9Og37GESw9eU4Orc7kPKq/
 cCB9cyrjb8tB644QcauPlzZGZ1LX32T6bbHsPtUIlt7WPJvg6Q/Yffw
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX1aKejoJSE4Kh
 mQrV7bu+Be3BiQGqSYOTIzBMBWerEJC04uAe4iLtmRlwYs35TpZJZOHJYcdisaf13vdk7HSAbvf
 W8vl+nDnt6PS/enH0RZT2BeNjN8jIZMI59Fi9xa7d5iIMaTPbJg5kxKRgr3ck5DPhEmvV2inbGS
 x3UBb7HR9PG+KgssoyAZ5n5eJiNr591sTIw7zgSdPfP5uxwpNKMqNbUQnd6/D+7yva5oIvbulrv
 6f6Th/2rPOoYM4aB0Rcew2J9ElxC0lCO3jjFNz0z88qAnJWOxfoCs4IxK6QdWs1DQri1Vs00fAs
 mk4KOJhktetGGUFSu7rJz71qYGog51nSx1DDloyPC3gEl6djiZJP2WnkboW21F/QSZ5brOrfvY7
 nZUHHAfB
X-Proofpoint-ORIG-GUID: y8G53WSKwyo8n4SBDbP-WweCFGJePGLo
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c02e71 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=MNkOokDTngcochq761IA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y8G53WSKwyo8n4SBDbP-WweCFGJePGLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

NSS clock controller provides the clocks and resets to the networking
blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
devices.

Add support for the compatible string "qcom,ipq5424-nsscc" based on the
existing IPQ9574 NSS clock controller Device Tree binding. Additionally,
update the clock names for PPE and NSS for newer SoC additions like
IPQ5424 to use generic and reusable identifiers "nss" and "ppe" without
the clock rate suffix.

Also add master/slave ids for IPQ5424 networking interfaces, which is
used by nss-ipq5424 driver for providing interconnect services using
icc-clk framework.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 62 ++++++++++++++++++---
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 ++++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 +++++
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 +++++++++++++++
 4 files changed, 178 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index fc604279114f..35e5c1b7dcbe 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
@@ -12,21 +12,29 @@ maintainers:
 
 description: |
   Qualcomm networking sub system clock control module provides the clocks,
-  resets on IPQ9574
+  resets on IPQ9574 and IPQ5424
 
-  See also::
+  See also:
+    include/dt-bindings/clock/qcom,ipq5424-nsscc.h
     include/dt-bindings/clock/qcom,ipq9574-nsscc.h
+    include/dt-bindings/reset/qcom,ipq5424-nsscc.h
     include/dt-bindings/reset/qcom,ipq9574-nsscc.h
 
 properties:
   compatible:
-    const: qcom,ipq9574-nsscc
+    enum:
+      - qcom,ipq5424-nsscc
+      - qcom,ipq9574-nsscc
 
   clocks:
     items:
       - description: Board XO source
-      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
-      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
+      - description: CMN_PLL NSS (Bias PLL cc) clock source. This clock rate
+          can vary for different IPQ SoCs. For example, it is 1200 MHz on the
+          IPQ9574 and 300 MHz on the IPQ5424.
+      - description: CMN_PLL PPE (Bias PLL ubi nc) clock source. The clock
+          rate can vary for different IPQ SoCs. For example, it is 353 MHz
+          on the IPQ9574 and 375 MHz on the IPQ5424.
       - description: GCC GPLL0 OUT AUX clock source
       - description: Uniphy0 NSS Rx clock source
       - description: Uniphy0 NSS Tx clock source
@@ -42,8 +50,12 @@ properties:
   clock-names:
     items:
       - const: xo
-      - const: nss_1200
-      - const: ppe_353
+      - enum:
+          - nss_1200
+          - nss
+      - enum:
+          - ppe_353
+          - ppe
       - const: gpll0_out
       - const: uniphy0_rx
       - const: uniphy0_tx
@@ -61,6 +73,40 @@ required:
 
 allOf:
   - $ref: qcom,gcc.yaml#
+  - if:
+      properties:
+        compatible:
+          const: qcom,ipq9574-nsscc
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: xo
+            - const: nss_1200
+            - const: ppe_353
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
+    else:
+      properties:
+        clock-names:
+          items:
+            - const: xo
+            - const: nss
+            - const: ppe
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
 
 unevaluatedProperties: false
 
diff --git a/include/dt-bindings/clock/qcom,ipq5424-nsscc.h b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
new file mode 100644
index 000000000000..eeae0dc38042
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
+#define _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
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
+#define NSS_CC_PORT3_MAC_CLK					28
+#define NSS_CC_PORT3_RX_CLK					29
+#define NSS_CC_PORT3_RX_CLK_SRC					30
+#define NSS_CC_PORT3_RX_DIV_CLK_SRC				31
+#define NSS_CC_PORT3_TX_CLK					32
+#define NSS_CC_PORT3_TX_CLK_SRC					33
+#define NSS_CC_PORT3_TX_DIV_CLK_SRC				34
+#define NSS_CC_PPE_CLK_SRC					35
+#define NSS_CC_PPE_EDMA_CFG_CLK					36
+#define NSS_CC_PPE_EDMA_CLK					37
+#define NSS_CC_PPE_SWITCH_BTQ_CLK				38
+#define NSS_CC_PPE_SWITCH_CFG_CLK				39
+#define NSS_CC_PPE_SWITCH_CLK					40
+#define NSS_CC_PPE_SWITCH_IPE_CLK				41
+#define NSS_CC_UNIPHY_PORT1_RX_CLK				42
+#define NSS_CC_UNIPHY_PORT1_TX_CLK				43
+#define NSS_CC_UNIPHY_PORT2_RX_CLK				44
+#define NSS_CC_UNIPHY_PORT2_TX_CLK				45
+#define NSS_CC_UNIPHY_PORT3_RX_CLK				46
+#define NSS_CC_UNIPHY_PORT3_TX_CLK				47
+#define NSS_CC_XGMAC0_PTP_REF_CLK				48
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC			49
+#define NSS_CC_XGMAC1_PTP_REF_CLK				50
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC			51
+#define NSS_CC_XGMAC2_PTP_REF_CLK				52
+#define NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC			53
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index c5e0dec0b300..07b786bee7d6 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -44,4 +44,17 @@
 #define MASTER_CPU			0
 #define SLAVE_L3			1
 
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_CE_AXI		6
+#define SLAVE_NSSNOC_CE_AXI		7
+#define MASTER_NSSNOC_CE_APB		8
+#define SLAVE_NSSNOC_CE_APB		9
+#define MASTER_NSSNOC_EIP		10
+#define SLAVE_NSSNOC_EIP		11
+
 #endif /* INTERCONNECT_QCOM_IPQ5424_H */
diff --git a/include/dt-bindings/reset/qcom,ipq5424-nsscc.h b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
new file mode 100644
index 000000000000..9627e3b0ad30
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
+#define _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
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
+#define NSS_CC_PORT3_MAC_CLK_ARES				17
+#define NSS_CC_PORT3_RX_CLK_ARES				18
+#define NSS_CC_PORT3_TX_CLK_ARES				19
+#define NSS_CC_PPE_BCR						20
+#define NSS_CC_PPE_EDMA_CLK_ARES				21
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES				22
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES				23
+#define NSS_CC_PPE_SWITCH_CLK_ARES				24
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES				25
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES				26
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES				27
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES				28
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES				29
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES				30
+#define NSS_CC_UNIPHY_PORT3_RX_CLK_ARES				31
+#define NSS_CC_UNIPHY_PORT3_TX_CLK_ARES				32
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES				33
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES				34
+#define NSS_CC_XGMAC2_PTP_REF_CLK_ARES				35
+
+#endif

-- 
2.34.1


