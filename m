Return-Path: <linux-pm+bounces-18581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEAA9E469B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE86286E2A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA61922FD;
	Wed,  4 Dec 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oIfSAo1A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC361917EE;
	Wed,  4 Dec 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347586; cv=none; b=FttrWoykz/YZfv4N7U264x8uBGVpsnRw/QttI6DESE1d3KvJNu4emB4AKmuPaoWKbm694pa6eScqawiAbZVepYcTd4R1xxi2/W8HAZMUVgf6Wsxk1N/KO5HDRkg4rmv6TThST4cBNph5qN5Kv71QJPEBAqO/kP/3EKaZkICqrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347586; c=relaxed/simple;
	bh=+3SQjWsL68y1TA8A5QUWabfPwmahFNKYenF/q2gWtpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q/aMBFpwEZ6EgzEDb89Y6vIHyFxDqSBax8DTSjyqCBkfwwQahcxsvyhhig2lRU5lc7AUh1O0zJ5aoXdZlnaOEbxtOeFlyDM5Mf/IVxoVTHBRBdihlV8JwXbGTIA9hPJ+dTqIrUC6V9IAFxuwyJk6d89pPUnhbH8iPX3/e90rL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oIfSAo1A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4HD94R031389;
	Wed, 4 Dec 2024 21:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6OQzEv01l5ZJiK7hG+3ZEHyYwXrqPaVq9UvyqTLx4E=; b=oIfSAo1AKWii0W74
	nS5RAlEZxoozKh27jJwgkclfsmXhd7kAJBJgBCNbAFLkP50xbtGRlsiXC+/csU4K
	GpVojiW91t9DQLoCSsCAIJOGBzbkxJ96DxJRQT9s1Jd3dXGVPjR/HXwJ2aCz6/T4
	BWucSFNJvJiUaMlcz2p4ckIdsCH5LJbKc/L2mQs/IzYcmtUj873QvSSk/0YPy/WY
	E2V1/+xAhPeIRnOoQFqMfnRPC72Fz6sYNvtP64tH+hOdfmpkNtds8kcxGYao5FaW
	4Yfr8yrk5/6I8+3NFZ3Urz55t1BWjfzp5V5TaPvUVAlA9VfnowNWBUURCJ4NB//p
	GxJznA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90whaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 21:26:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4LQI56015895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 21:26:18 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 13:26:18 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Date: Wed, 4 Dec 2024 13:26:05 -0800
Subject: [PATCH v3 1/2] dt-bindings: interconnect: add interconnect
 bindings for SM8750
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241204-sm8750_master_interconnects-v3-1-3d9aad4200e9@quicinc.com>
References: <20241204-sm8750_master_interconnects-v3-0-3d9aad4200e9@quicinc.com>
In-Reply-To: <20241204-sm8750_master_interconnects-v3-0-3d9aad4200e9@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733347577; l=8883;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=E8awTq6SdpmJA9Yp4CTGt5sylquHru73VwKXt7uqv4M=;
 b=v0VbtnUlPtGxbpaYd8w+uOvGqv9HJ4vcvutF64jSCgN3kA5KNCSIG6Cxh31a19M+b9D/GDESk
 CWiEIUD69+FB9pcs59qlv9TeTG3pT/J0mVEYdKyN5QgTuRm7YM878GQ
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZNJRSgWoTU88ZWb4RWJoowW-Lq7JcQFZ
X-Proofpoint-GUID: ZNJRSgWoTU88ZWb4RWJoowW-Lq7JcQFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040165

From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>

Add interconnect device bindings. These devices can be used
to describe any RPMh and NoC based interconnect devices.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,sm8750-rpmh.yaml    | 136 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm8750-rpmh.h    | 143 +++++++++++++++++++++
 2 files changed, 279 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a816acc301e1fe5dce9316ef7c44b62b7fbd6758
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8750-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM8750
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also:: include/dt-bindings/interconnect/qcom,sm8750-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8750-aggre1-noc
+      - qcom,sm8750-aggre2-noc
+      - qcom,sm8750-clk-virt
+      - qcom,sm8750-cnoc-main
+      - qcom,sm8750-config-noc
+      - qcom,sm8750-gem-noc
+      - qcom,sm8750-lpass-ag-noc
+      - qcom,sm8750-lpass-lpiaon-noc
+      - qcom,sm8750-lpass-lpicx-noc
+      - qcom,sm8750-mc-virt
+      - qcom,sm8750-mmss-noc
+      - qcom,sm8750-nsp-noc
+      - qcom,sm8750-pcie-anoc
+      - qcom,sm8750-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
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
+              - qcom,sm8750-clk-virt
+              - qcom,sm8750-mc-virt
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
+              - qcom,sm8750-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-aggre1-noc
+              - qcom,sm8750-aggre2-noc
+              - qcom,sm8750-pcie-anoc
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
+    clk_virt: interconnect-0 {
+      compatible = "qcom,sm8750-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,sm8750-aggre1-noc";
+      reg = <0x016e0000 0x16400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_phy_axi_clk>, <&gcc_prim_axi_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm8750-rpmh.h b/include/dt-bindings/interconnect/qcom,sm8750-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..30563952a646b332271b3ae410ca213eb49a3114
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8750-rpmh.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8750_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8750_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_QUP_3				2
+#define MASTER_SDCC_4				3
+#define MASTER_UFS_MEM				4
+#define MASTER_USB3_0				5
+#define SLAVE_A1NOC_SNOC			6
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_2				1
+#define MASTER_CRYPTO				2
+#define MASTER_IPA				3
+#define MASTER_SOCCP_AGGR_NOC			4
+#define MASTER_SP				5
+#define MASTER_QDSS_ETR				6
+#define MASTER_QDSS_ETR_1			7
+#define MASTER_SDCC_2				8
+#define SLAVE_A2NOC_SNOC			9
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_CRYPTO_0_CFG			5
+#define SLAVE_DISPLAY_CFG			6
+#define SLAVE_EVA_CFG				7
+#define SLAVE_GFX3D_CFG				8
+#define SLAVE_I2C				9
+#define SLAVE_I3C_IBI0_CFG			10
+#define SLAVE_I3C_IBI1_CFG			11
+#define SLAVE_IMEM_CFG				12
+#define SLAVE_CNOC_MSS				13
+#define SLAVE_PCIE_CFG				14
+#define SLAVE_PRNG				15
+#define SLAVE_QDSS_CFG				16
+#define SLAVE_QSPI_0				17
+#define SLAVE_QUP_3				18
+#define SLAVE_QUP_1				19
+#define SLAVE_QUP_2				20
+#define SLAVE_SDCC_2				21
+#define SLAVE_SDCC_4				22
+#define SLAVE_SPSS_CFG				23
+#define SLAVE_TCSR				24
+#define SLAVE_TLMM				25
+#define SLAVE_UFS_MEM_CFG			26
+#define SLAVE_USB3_0				27
+#define SLAVE_VENUS_CFG				28
+#define SLAVE_VSENSE_CTRL_CFG			29
+#define SLAVE_CNOC_MNOC_CFG			30
+#define SLAVE_PCIE_ANOC_CFG			31
+#define SLAVE_QDSS_STM				32
+#define SLAVE_TCU				33
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_CFG			4
+#define SLAVE_SOCCP				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_APPSS				7
+#define SLAVE_CNOC_CFG				8
+#define SLAVE_DDRSS_CFG				9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_BOOT_IMEM_2			12
+#define SLAVE_SERVICE_CNOC			13
+#define SLAVE_PCIE_0				14
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define MASTER_UBWC_P				11
+#define MASTER_GIC				12
+#define SLAVE_UBWC_P				13
+#define SLAVE_GEM_NOC_CNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_MEM_NOC_PCIE_SNOC			16
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_NRT_ICP_SF		1
+#define MASTER_CAMNOC_RT_CDM_SF			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_MDP				4
+#define MASTER_CDSP_HCP				5
+#define MASTER_VIDEO_CV_PROC			6
+#define MASTER_VIDEO_EVA			7
+#define MASTER_VIDEO_MVP			8
+#define MASTER_VIDEO_V_PROC			9
+#define MASTER_CNOC_MNOC_CFG			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_MNOC_SF_MEM_NOC			12
+#define SLAVE_SERVICE_MNOC			13
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+#define SLAVE_SERVICE_PCIE_ANOC			3
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define SLAVE_SNOC_GEM_NOC_SF			2
+
+#endif

-- 
2.46.1


