Return-Path: <linux-pm+bounces-13937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6399731EC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C28B20B27
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D611917E1;
	Tue, 10 Sep 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MLKPceS7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E818CBE9;
	Tue, 10 Sep 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963055; cv=none; b=typ65eSjCMQS8/Xu4VREwV8+UQM6twWGNogYGRRr+5gnYl+kjDXTMuwYUsKG8uc3Zua4HQnL56I4zLGGG5kDQpOBS6DWfBP1NraA2LT1kSpi0J7zZg0LsBuO9yr4uHGfIjyLPOyD9VrSvWaiMWJOhAfAPiF8Fopgo0OsZarUKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963055; c=relaxed/simple;
	bh=eAb8BFNLWpEMJMP5cy63ZnTdz2m1rcAzzC8H2F3n5OE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbpTzBVq+iRzQOssD7KvV8yW0XB36FTX91IiHWUWQlPOrTsRsuAQi1ybUscpv8NTnhC9lEoTSkZHC+BO7Li2O78EkXYeVIpKbwiG/RYqtmOvhmk5r/ruZGu0cUNa2bUryzb0Gvj6JgLNrteV3ReLSfKku3R4QPlaj1ecw/l1z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MLKPceS7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A37FxC021352;
	Tue, 10 Sep 2024 10:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xqz5E8DsazvVef+xLxsj7rilTOyDNGwyKJ6LD5iU6XE=; b=MLKPceS7NQyEsIS+
	SQhU+kRfJCMLspIzXJrA+WVz8hK7Q9gtj6dqhOe+X87mQERQed4mbbRp7j6tgMi0
	5bN0BJxLVGiMW1oovjZWtxXOT92+BVtbvfQYx8ouuLqSa34t/4j4BHnYlH+cSd7Q
	/2UNOEu/SrrB75fQ2TYuRT8PJVsj/SMPprXmiq4ekXzFNpJHtvTbK3J7Lxtm93Bb
	2kAtimij1SAmGROpneiPTbGjjgkdDAeNRDWWQXM9iqk4oP271pqaEKkwybQMZtuJ
	R1Uv8kQEIDmt/F1fE727WGpqjhF4MKaNDSY5SUsJSiW3iifMofgUIIZFXniKok1k
	I5m3hQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpnh5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 10:10:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AAAelj017025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 10:10:40 GMT
Received: from 3a9ae799c7fb.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 03:10:34 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Stephan Gerhold
	<stephan.gerhold@kernkonzept.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        "Adam Skladowski" <a39.skl@gmail.com>,
        Vladimir Lypak
	<vladimir.lypak@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Odelu
 Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/2] dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS8300 SoC
Date: Tue, 10 Sep 2024 10:10:12 +0000
Message-ID: <20240910101013.3020-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
References: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xWono9N6PrppiTkCa-uZaG3GnEEIaU6Q
X-Proofpoint-GUID: xWono9N6PrppiTkCa-uZaG3GnEEIaU6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100077

Document the RPMh Network-On-Chip Interconnect of the QCS8300 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 .../interconnect/qcom,qcs8300-rpmh.yaml       |  72 +++++++
 .../interconnect/qcom,qcs8300-rpmh.h          | 189 ++++++++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
new file mode 100644
index 000000000000..e9f528d6d9a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qcs8300-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on QCS8300
+
+maintainers:
+  - Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also: include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs8300-aggre1-noc
+      - qcom,qcs8300-aggre2-noc
+      - qcom,qcs8300-clk-virt
+      - qcom,qcs8300-config-noc
+      - qcom,qcs8300-dc-noc
+      - qcom,qcs8300-gem-noc
+      - qcom,qcs8300-gpdsp-anoc
+      - qcom,qcs8300-lpass-ag-noc
+      - qcom,qcs8300-mc-virt
+      - qcom,qcs8300-mmss-noc
+      - qcom,qcs8300-nspa-noc
+      - qcom,qcs8300-pcie-anoc
+      - qcom,qcs8300-system-noc
+
+  reg:
+    maxItems: 1
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
+              - qcom,qcs8300-clk-virt
+              - qcom,qcs8300-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gem_noc: interconnect@9100000 {
+        compatible = "qcom,qcs8300-gem-noc";
+        reg = <0x9100000 0xf7080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    clk_virt: interconnect-0 {
+        compatible = "qcom,qcs8300-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h b/include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
new file mode 100644
index 000000000000..c5eeafa1b1dd
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCS8300_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QCS8300_H
+
+#define MASTER_QUP_3				0
+#define MASTER_EMAC				1
+#define MASTER_SDC				2
+#define MASTER_UFS_MEM				3
+#define MASTER_USB2				4
+#define MASTER_USB3_0				5
+#define SLAVE_A1NOC_SNOC			6
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_0				1
+#define MASTER_QUP_1				2
+#define MASTER_CNOC_A2NOC			3
+#define MASTER_CRYPTO_CORE0			4
+#define MASTER_CRYPTO_CORE1			5
+#define MASTER_IPA				6
+#define MASTER_QDSS_ETR_0			7
+#define MASTER_QDSS_ETR_1			8
+#define SLAVE_A2NOC_SNOC			9
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_3			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_3			5
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AHB2PHY_2				2
+#define SLAVE_AHB2PHY_3				3
+#define SLAVE_ANOC_THROTTLE_CFG			4
+#define SLAVE_AOSS				5
+#define SLAVE_APPSS				6
+#define SLAVE_BOOT_ROM				7
+#define SLAVE_CAMERA_CFG			8
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG		9
+#define SLAVE_CAMERA_RT_THROTTLE_CFG		10
+#define SLAVE_CLK_CTL				11
+#define SLAVE_CDSP_CFG				12
+#define SLAVE_RBCPR_CX_CFG			13
+#define SLAVE_RBCPR_MMCX_CFG			14
+#define SLAVE_RBCPR_MX_CFG			15
+#define SLAVE_CPR_NSPCX				16
+#define SLAVE_CPR_NSPHMX			17
+#define SLAVE_CRYPTO_0_CFG			18
+#define SLAVE_CX_RDPM				19
+#define SLAVE_DISPLAY_CFG			20
+#define SLAVE_DISPLAY_RT_THROTTLE_CFG		21
+#define SLAVE_EMAC_CFG				22
+#define SLAVE_GP_DSP0_CFG			23
+#define SLAVE_GPDSP0_THROTTLE_CFG		24
+#define SLAVE_GPU_TCU_THROTTLE_CFG		25
+#define SLAVE_GFX3D_CFG				26
+#define SLAVE_HWKM				27
+#define SLAVE_IMEM_CFG				28
+#define SLAVE_IPA_CFG				29
+#define SLAVE_IPC_ROUTER_CFG			30
+#define SLAVE_LPASS				31
+#define SLAVE_LPASS_THROTTLE_CFG		32
+#define SLAVE_MX_RDPM				33
+#define SLAVE_MXC_RDPM				34
+#define SLAVE_PCIE_0_CFG			35
+#define SLAVE_PCIE_1_CFG			36
+#define SLAVE_PCIE_TCU_THROTTLE_CFG		37
+#define SLAVE_PCIE_THROTTLE_CFG			38
+#define SLAVE_PDM				39
+#define SLAVE_PIMEM_CFG				40
+#define SLAVE_PKA_WRAPPER_CFG			41
+#define SLAVE_QDSS_CFG				42
+#define SLAVE_QM_CFG				43
+#define SLAVE_QM_MPU_CFG			44
+#define SLAVE_QUP_0				45
+#define SLAVE_QUP_1				46
+#define SLAVE_QUP_3				47
+#define SLAVE_SAIL_THROTTLE_CFG			48
+#define SLAVE_SDC1				49
+#define SLAVE_SECURITY				50
+#define SLAVE_SNOC_THROTTLE_CFG			51
+#define SLAVE_TCSR				52
+#define SLAVE_TLMM				53
+#define SLAVE_TSC_CFG				54
+#define SLAVE_UFS_MEM_CFG			55
+#define SLAVE_USB2				56
+#define SLAVE_USB3_0				57
+#define SLAVE_VENUS_CFG				58
+#define SLAVE_VENUS_CVP_THROTTLE_CFG		59
+#define SLAVE_VENUS_V_CPU_THROTTLE_CFG		60
+#define SLAVE_VENUS_VCODEC_THROTTLE_CFG		61
+#define SLAVE_DDRSS_CFG				62
+#define SLAVE_GPDSP_NOC_CFG			63
+#define SLAVE_CNOC_MNOC_HF_CFG			64
+#define SLAVE_CNOC_MNOC_SF_CFG			65
+#define SLAVE_PCIE_ANOC_CFG			66
+#define SLAVE_SNOC_CFG				67
+#define SLAVE_BOOT_IMEM				68
+#define SLAVE_IMEM				69
+#define SLAVE_PIMEM				70
+#define SLAVE_PCIE_0				71
+#define SLAVE_PCIE_1				72
+#define SLAVE_QDSS_STM				73
+#define SLAVE_TCU				74
+
+#define MASTER_CNOC_DC_NOC			0
+#define SLAVE_LLCC_CFG				1
+#define SLAVE_GEM_NOC_CFG			2
+
+#define MASTER_GPU_TCU				0
+#define MASTER_PCIE_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_COMPUTE_NOC			4
+#define MASTER_GEM_NOC_CFG			5
+#define MASTER_GPDSP_SAIL			6
+#define MASTER_GFX3D				7
+#define MASTER_MNOC_HF_MEM_NOC			8
+#define MASTER_MNOC_SF_MEM_NOC			9
+#define MASTER_ANOC_PCIE_GEM_NOC		10
+#define MASTER_SNOC_GC_MEM_NOC			11
+#define MASTER_SNOC_SF_MEM_NOC			12
+#define SLAVE_GEM_NOC_CNOC			13
+#define SLAVE_LLCC				14
+#define SLAVE_GEM_NOC_PCIE_CNOC			15
+#define SLAVE_SERVICE_GEM_NOC_1			16
+#define SLAVE_SERVICE_GEM_NOC_2			17
+#define SLAVE_SERVICE_GEM_NOC			18
+#define SLAVE_SERVICE_GEM_NOC2			19
+
+#define MASTER_SAILSS_MD0			0
+#define MASTER_DSP0				1
+#define SLAVE_GP_DSP_SAIL_NOC			2
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
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP0				3
+#define MASTER_MDP1				4
+#define MASTER_CNOC_MNOC_HF_CFG			5
+#define MASTER_CNOC_MNOC_SF_CFG			6
+#define MASTER_VIDEO_P0				7
+#define MASTER_VIDEO_PROC			8
+#define MASTER_VIDEO_V_PROC			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC_HF			12
+#define SLAVE_SERVICE_MNOC_SF			13
+
+#define MASTER_CDSP_NOC_CFG			0
+#define MASTER_CDSP_PROC			1
+#define SLAVE_HCP_A				2
+#define SLAVE_CDSP_MEM_NOC			3
+#define SLAVE_SERVICE_NSP_NOC			4
+
+#define MASTER_PCIE_0				0
+#define MASTER_PCIE_1				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
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
+#endif
-- 
2.39.2


