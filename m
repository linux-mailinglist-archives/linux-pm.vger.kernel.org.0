Return-Path: <linux-pm+bounces-14616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753F59847D3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976C61C22EDF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C871AB529;
	Tue, 24 Sep 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EBwz8wIn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A61AAE1E;
	Tue, 24 Sep 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188840; cv=none; b=p//WTQ6RnYDE8OvfjQrQ+RWME3dJZI8+W7NNP9ZTvKmNt/5lO8QAeYNOxI47M4Dgip49lj8INhh666uOOozpUJuOQN2Hl2EAyx4t3aJO79F0OE1Ern2g5CR/AcN0ZTnLGx8UgRhwhvcaaLhInYSa+hKGOc2IgcXe18ObjJQfGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188840; c=relaxed/simple;
	bh=DzhVPApwFf1b7zSQdVKpqN0I6vSGBMXk8fgBGh5qh38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJKRKopB+l2BQ+5rECxNzn+6eg6ha7n4432jD53Oa0jNGc5eAgqlxlwhbhJyjvk4K938QxmAfWMODwEE/vkVHFPCC5RWUr64lcB7qcNU/Urnv7VL/DEUtMsP68GJ3pJhuPOc4h0o4vGFKCCabeV3LRZBM4k/9WCusl5sruRnQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EBwz8wIn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O91L0O003174;
	Tue, 24 Sep 2024 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdyOzbKx+QM/oWxE7bzJZ3Oj+g48byciv8snQEl+fT0=; b=EBwz8wIn7c4Awebl
	HL8uv6tShTIoUJDugzqWj/aiFmqW+5SKXAUgoFUrdDJXpZ1WyHICsUn1omVVRZ9Y
	Q/xrYNP3tLRWkk7sWJsa+qTrK0jE7L7HXhrqelkXemP74EEbFCtOmifirORwZmLo
	KEHmlGqbwWF4ZNlkPTVORQs56QOTxNMiZ8rCcu+QgcVMyJ6Ot/nScNUFXuLIyRie
	8hSAb003/ee1DwwdNmmEo3aqSKV7X4LEY0P5qX0NL4Gm3iFUs5+BZxkd2ST6Xe7J
	k9YUpTzzVD0hoKl30QWOV0ZHq05h/SH1jfI8CZU9myUmgj8+5YNSrprT2NEfeYJd
	WnVUvg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuervf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OEeNpZ005266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:23 GMT
Received: from e20994d1867b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 07:40:19 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Adam Skladowski
	<a39.skl@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS615 SoC
Date: Tue, 24 Sep 2024 14:39:57 +0000
Message-ID: <20240924143958.25-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240924143958.25-1-quic_rlaggysh@quicinc.com>
References: <20240924143958.25-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: pWKjoAdq3y27mx79jB5pIneAc2nEnl0T
X-Proofpoint-ORIG-GUID: pWKjoAdq3y27mx79jB5pIneAc2nEnl0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240104

Document the RPMh Network-On-Chip Interconnect of the QCS615 platform.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 .../interconnect/qcom,qcs615-rpmh.yaml        |  73 ++++++++++
 .../interconnect/qcom,qcs615-rpmh.h           | 136 ++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs615-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
new file mode 100644
index 000000000000..383b4c93d14f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qcs615-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on QCS615
+
+maintainers:
+  - Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,qcs615-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs615-aggre1-noc
+      - qcom,qcs615-camnoc-virt
+      - qcom,qcs615-config-noc
+      - qcom,qcs615-dc-noc
+      - qcom,qcs615-gem-noc
+      - qcom,qcs615-ipa-virt
+      - qcom,qcs615-mc-virt
+      - qcom,qcs615-mmss-noc
+      - qcom,qcs615-system-noc
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
+              - qcom,qcs615-camnoc-virt
+              - qcom,qcs615-ipa-virt
+              - qcom,qcs615-mc-virt
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
+    gem_noc: interconnect@9680000 {
+        compatible = "qcom,qcs615-gem-noc";
+        reg = <0x9680000 0x3E200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    mc_virt: interconnect-2 {
+        compatible = "qcom,qcs615-mc-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,qcs615-rpmh.h b/include/dt-bindings/interconnect/qcom,qcs615-rpmh.h
new file mode 100644
index 000000000000..84ae0d39e73c
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qcs615-rpmh.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCS615_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QCS615_H
+
+#define MASTER_A1NOC_CFG		1
+#define MASTER_QDSS_BAM			2
+#define MASTER_QSPI			3
+#define MASTER_QUP_0			4
+#define MASTER_BLSP_1			5
+#define MASTER_CNOC_A2NOC		6
+#define MASTER_CRYPTO			7
+#define MASTER_IPA			8
+#define MASTER_EMAC_EVB			9
+#define MASTER_PCIE			10
+#define MASTER_QDSS_ETR			11
+#define MASTER_SDCC_1			12
+#define MASTER_SDCC_2			13
+#define MASTER_UFS_MEM			14
+#define MASTER_USB2			15
+#define MASTER_USB3_0			16
+#define SLAVE_A1NOC_SNOC		17
+#define SLAVE_LPASS_SNOC		18
+#define SLAVE_ANOC_PCIE_SNOC		19
+#define SLAVE_SERVICE_A2NOC		20
+
+#define MASTER_CAMNOC_HF0_UNCOMP	1
+#define MASTER_CAMNOC_HF1_UNCOMP	2
+#define MASTER_CAMNOC_SF_UNCOMP		3
+#define SLAVE_CAMNOC_UNCOMP		4
+
+#define MASTER_SPDM			1
+#define MASTER_SNOC_CNOC		2
+#define MASTER_QDSS_DAP			3
+#define SLAVE_A1NOC_CFG			4
+#define SLAVE_AHB2PHY_EAST		5
+#define SLAVE_AHB2PHY_WEST		6
+#define SLAVE_AOP			7
+#define SLAVE_AOSS			8
+#define SLAVE_CAMERA_CFG		9
+#define SLAVE_CLK_CTL			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_RBCPR_MX_CFG		12
+#define SLAVE_CRYPTO_0_CFG		13
+#define SLAVE_CNOC_DDRSS		14
+#define SLAVE_DISPLAY_CFG		15
+#define SLAVE_EMAC_AVB_CFG		16
+#define SLAVE_GLM			17
+#define SLAVE_GFX3D_CFG			18
+#define SLAVE_IMEM_CFG			19
+#define SLAVE_IPA_CFG			20
+#define SLAVE_CNOC_MNOC_CFG		21
+#define SLAVE_PCIE_CFG			22
+#define SLAVE_PIMEM_CFG			23
+#define SLAVE_PRNG			24
+#define SLAVE_QDSS_CFG			25
+#define SLAVE_QSPI			26
+#define SLAVE_QUP_0			27
+#define SLAVE_QUP_1			28
+#define SLAVE_SDCC_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SNOC_CFG			31
+#define SLAVE_SPDM_WRAPPER		32
+#define SLAVE_TCSR			33
+#define SLAVE_TLMM_EAST			34
+#define SLAVE_TLMM_SOUTH		35
+#define SLAVE_TLMM_WEST			36
+#define SLAVE_UFS_MEM_CFG		37
+#define SLAVE_USB2			38
+#define SLAVE_USB3			39
+#define SLAVE_VENUS_CFG			40
+#define SLAVE_VSENSE_CTRL_CFG		41
+#define SLAVE_CNOC_A2NOC		42
+#define SLAVE_SERVICE_CNOC		43
+
+#define MASTER_CNOC_DC_NOC		1
+#define SLAVE_DC_NOC_GEMNOC		2
+#define SLAVE_LLCC_CFG			3
+
+#define MASTER_APPSS_PROC		1
+#define MASTER_GPU_TCU			2
+#define MASTER_SYS_TCU			3
+#define MASTER_GEM_NOC_CFG		4
+#define MASTER_GFX3D			5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_SNOC_GC_MEM_NOC		8
+#define MASTER_SNOC_SF_MEM_NOC		9
+#define SLAVE_MSS_PROC_MS_MPU_CFG	10
+#define SLAVE_GEM_NOC_SNOC		11
+#define SLAVE_LLCC			12
+#define SLAVE_MEM_NOC_PCIE_SNOC		13
+#define SLAVE_SERVICE_GEM_NOC		14
+
+#define MASTER_IPA_CORE			1
+#define SLAVE_IPA_CORE			2
+
+#define MASTER_LLCC			1
+#define SLAVE_EBI1			2
+
+#define MASTER_CNOC_MNOC_CFG		1
+#define MASTER_CAMNOC_HF0		2
+#define MASTER_CAMNOC_HF1		3
+#define MASTER_CAMNOC_SF		4
+#define MASTER_MDP0			5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_PROC		8
+#define SLAVE_MNOC_SF_MEM_NOC		9
+#define SLAVE_MNOC_HF_MEM_NOC		10
+#define SLAVE_SERVICE_MNOC		11
+
+#define MASTER_SNOC_CFG			1
+#define MASTER_A1NOC_SNOC		2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_GEM_NOC_PCIE_SNOC	4
+#define MASTER_LPASS_ANOC		5
+#define MASTER_ANOC_PCIE_SNOC		6
+#define MASTER_PIMEM			7
+#define MASTER_GIC			8
+#define SLAVE_APPSS			9
+#define SLAVE_SNOC_CNOC			10
+#define SLAVE_SNOC_GEM_NOC_SF		11
+#define SLAVE_SNOC_MEM_NOC_GC		12
+#define SLAVE_IMEM			13
+#define SLAVE_PIMEM			14
+#define SLAVE_SERVICE_SNOC		15
+#define SLAVE_PCIE_0			16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_TCU			18
+
+#endif
+
-- 
2.39.2


