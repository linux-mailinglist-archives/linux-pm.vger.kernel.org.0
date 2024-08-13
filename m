Return-Path: <linux-pm+bounces-12125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5394FBE9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 04:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A81F20623
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 02:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A51B948;
	Tue, 13 Aug 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="huaO08AI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B618C31;
	Tue, 13 Aug 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517315; cv=none; b=VGtBFVk1TpBl2gXjsAqxFauOpBPd/UehEGITUhhqcmzY3JgvtxRkqb1F64TJqQEQp3ocee7oOtH7z6BMe2XOYX0kDN4pG+nyOXyFnmL6NDi51a8hR3/KKTQGyF6pmQs04hYsTJlRx+Cyhl3KHm5f7FabgtvkAjs7n/gO9FGv7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517315; c=relaxed/simple;
	bh=Vo/RxPTSgEhkJ/CEY6gYMZXmVdgrZ0Am35PxqclBzzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G5pVPnuPFf61g9KaQ6chsBLNWz/MIBJZ3JPLCQozYTyJ8BVb/n29kf4dw+BqdXg+MFpBTMUk2U//isS5Zmy7soZvDYm/8oMEoLyIDT4ouWyRps5+PA1bkFrIk8cxNzfUTo1+b0U6GI8HmoiQpeAQ+tOIO+HshtnMmL7f+z3jBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=huaO08AI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSVKQ021418;
	Tue, 13 Aug 2024 02:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MBztWsieXbng4mPB8lpi1edrtwDgdHfJIWnSjQ88yHs=; b=huaO08AIWr753e0E
	5dtWKqIylZ8trWs99KDOhHBMlnkgrzwOwCyM5I1rg0Jsjt/TruKN7YY+UXawxPAD
	hRiKrljlTzH9JKsD+kEciku6Hu2CbkM/pU8MTafJGHJx0jpoNkew6zFJYFYPqG3q
	zWKgor/VdVdzL1yrgwaiab3I4EPg1i1Vt6lDby0TW5XOUIup/xEGOsm4+48twrbr
	umJ6xLEHq6JDyLLBRdmw51lAgysMs0BpO0dQmVScJpo7gzHYKrqWQEucUdiwtdGP
	aBtcQrIgGImKLJSmoXkWjTmFcXxOO7WuHkMTVDM4gg1ErZq1zSR/Xo6WmVhjHP0n
	GIthmg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1g7x35w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D2mO8m008831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:24 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 12 Aug 2024 19:48:18 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 13 Aug 2024 10:47:53 +0800
Subject: [PATCH v4 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-sm4450_interconnect-v4-1-41a426f0fc49@quicinc.com>
References: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
In-Reply-To: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723517295; l=9196;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=Vo/RxPTSgEhkJ/CEY6gYMZXmVdgrZ0Am35PxqclBzzo=;
 b=IdE1OkRtXZUMYSRBsE6v08Z8gqjsE2AbfDdtSY+Wio4E40klOOUim/CRDxiBHP4LFIQDCmtfM
 nVNzIj5z80eDFyuDwRjoM/Q22TJTeM67Lc/1Zjji+9jckkoW6fLB6Gr
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tOP2G1kf-YuJQmCinZfV1LhXWYV9WY3h
X-Proofpoint-ORIG-GUID: tOP2G1kf-YuJQmCinZfV1LhXWYV9WY3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130018

The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
and tuned dynamically according to the bandwidth demand.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 .../bindings/interconnect/qcom,sm4450-rpmh.yaml    | 133 +++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm4450.h     | 163 +++++++++++++++++++++
 2 files changed, 296 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
new file mode 100644
index 000000000000..afbef5124e06
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm4450-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM4450
+
+maintainers:
+  - Tengfei Fan <quic_tengfan@quicinc.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sm4450.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm4450-aggre1-noc
+      - qcom,sm4450-aggre2-noc
+      - qcom,sm4450-clk-virt
+      - qcom,sm4450-cnoc2
+      - qcom,sm4450-cnoc3
+      - qcom,sm4450-gem-noc
+      - qcom,sm4450-lpass-ag-noc
+      - qcom,sm4450-mc-virt
+      - qcom,sm4450-mmss-noc
+      - qcom,sm4450-pcie-anoc
+      - qcom,sm4450-system-noc
+      - qcom,sm4450-video-aggre-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-clk-virt
+              - qcom,sm4450-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe 0 AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+            - description: aggre-NOC USB3 AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm4450-aggre1-noc
+              - qcom,sm4450-aggre2-noc
+              - qcom,sm4450-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm4450-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    interconnect-0 {
+        compatible = "qcom,sm4450-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@1700000 {
+        compatible = "qcom,sm4450-aggre2-noc";
+        reg = <0x01700000 0x31080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&rpmhcc RPMH_IPA_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm4450.h b/include/dt-bindings/interconnect/qcom,sm4450.h
new file mode 100644
index 000000000000..0aa8fb65f429
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm4450.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM4450_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM4450_H
+
+#define MASTER_QUP_0				0
+#define MASTER_A1NOC_CFG			1
+#define MASTER_SDCC_2				2
+#define SLAVE_A1NOC_SNOC			3
+#define SLAVE_SERVICE_A1NOC			4
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_1				1
+#define MASTER_A2NOC_CFG			2
+#define MASTER_CNOC_A2NOC			3
+#define MASTER_CRYPTO				4
+#define MASTER_IPA				5
+#define MASTER_WLAN				6
+#define MASTER_QDSS_ETR				7
+#define MASTER_QDSS_ETR_1			8
+#define MASTER_SDCC_1				9
+#define MASTER_UFS_MEM				10
+#define MASTER_USB3_0				11
+#define SLAVE_A2NOC_SNOC			12
+#define SLAVE_SERVICE_A2NOC			13
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_CNOC3_CNOC2			0
+#define MASTER_QDSS_DAP				1
+#define SLAVE_AHB2PHY_SOUTH			2
+#define SLAVE_AHB2PHY_NORTH			3
+#define SLAVE_ANOC_THROTTLE_CFG			4
+#define SLAVE_CAMERA_CFG			5
+#define SLAVE_CLK_CTL				6
+#define SLAVE_RBCPR_CX_CFG			7
+#define SLAVE_RBCPR_MX_CFG			8
+#define SLAVE_CRYPTO_0_CFG			9
+#define SLAVE_CX_RDPM				10
+#define SLAVE_DISPLAY_CFG			11
+#define SLAVE_GFX3D_CFG				12
+#define SLAVE_IMEM_CFG				13
+#define SLAVE_IPA_CFG				14
+#define SLAVE_IPC_ROUTER_CFG			15
+#define SLAVE_LPASS				16
+#define SLAVE_CNOC_MSS				17
+#define SLAVE_MX_RDPM				18
+#define SLAVE_PCIE_0_CFG			19
+#define SLAVE_PDM				20
+#define SLAVE_PIMEM_CFG				21
+#define SLAVE_PMU_WRAPPER_CFG			22
+#define SLAVE_PRNG				23
+#define SLAVE_QUP_0				24
+#define SLAVE_QUP_1				25
+#define SLAVE_SDC1				26
+#define SLAVE_SDCC_2				27
+#define SLAVE_TCSR				28
+#define SLAVE_TLMM				29
+#define SLAVE_UFS_MEM_CFG			30
+#define SLAVE_USB3_0				31
+#define SLAVE_VENUS_CFG				32
+#define SLAVE_VSENSE_CTRL_CFG			33
+#define SLAVE_A1NOC_CFG				34
+#define SLAVE_A2NOC_CFG				35
+#define SLAVE_CNOC2_CNOC3			36
+#define SLAVE_CNOC_MNOC_CFG			37
+#define SLAVE_PCIE_ANOC_CFG			38
+#define SLAVE_SNOC_CFG				39
+#define SLAVE_VIDEO_ANOC_CFG			40
+
+#define MASTER_CNOC2_CNOC3			0
+#define MASTER_GEM_NOC_CNOC			1
+#define MASTER_GEM_NOC_PCIE_SNOC		2
+#define SLAVE_AOSS				3
+#define SLAVE_APPSS				4
+#define SLAVE_QDSS_CFG				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_WLAN				7
+#define SLAVE_CNOC3_CNOC2			8
+#define SLAVE_CNOC_A2NOC			9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_PIMEM				12
+#define SLAVE_PCIE_0				13
+#define SLAVE_QDSS_STM				14
+#define SLAVE_TCU				15
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_MSS_PROC				4
+#define MASTER_MNOC_HF_MEM_NOC			5
+#define MASTER_MNOC_SF_MEM_NOC			6
+#define MASTER_ANOC_PCIE_GEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC			8
+#define MASTER_SNOC_SF_MEM_NOC			9
+#define MASTER_WLAN_Q6				10
+#define SLAVE_GEM_NOC_CNOC			11
+#define SLAVE_LLCC				12
+#define SLAVE_MEM_NOC_PCIE_SNOC			13
+#define MASTER_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		15
+#define SLAVE_LLCC_DISP				16
+
+#define MASTER_CNOC_LPASS_AG_NOC		0
+#define MASTER_LPASS_PROC			1
+#define SLAVE_LPASS_CORE_CFG			2
+#define SLAVE_LPASS_LPI_CFG			3
+#define SLAVE_LPASS_MPU_CFG			4
+#define SLAVE_LPASS_TOP_CFG			5
+#define SLAVE_LPASS_SNOC			6
+#define SLAVE_SERVICES_LPASS_AML_NOC		7
+#define SLAVE_SERVICE_LPASS_AG_NOC		8
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CNOC_MNOC_CFG			4
+#define MASTER_VIDEO_P0_MMNOC			5
+#define MASTER_VIDEO_PROC_MMNOC			6
+#define SLAVE_MNOC_HF_MEM_NOC			7
+#define SLAVE_MNOC_SF_MEM_NOC			8
+#define SLAVE_SERVICE_MNOC			9
+#define MASTER_MDP_DISP				10
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		11
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+#define SLAVE_SERVICE_PCIE_ANOC			3
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_LPASS_ANOC			3
+#define MASTER_SNOC_CFG				4
+#define MASTER_PIMEM				5
+#define MASTER_GIC				6
+#define SLAVE_SNOC_GEM_NOC_GC			7
+#define SLAVE_SNOC_GEM_NOC_SF			8
+#define SLAVE_SERVICE_SNOC			9
+
+#define MASTER_VIDEO_ANOC_CFG			0
+#define MASTER_VIDEO_P0				1
+#define MASTER_VIDEO_PROC			2
+#define SLAVE_VIDEO_0_ANOC_MMNOC		3
+#define SLAVE_VIDEO_1_ANOC_MMNOC		4
+#define SLAVE_SERVICE_SRVC_VIDEO_ANOC		5
+
+#endif

-- 
2.25.1


