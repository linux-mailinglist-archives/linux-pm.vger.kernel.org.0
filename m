Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEC34025B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCRJqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhCRJqf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 05:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6193764F38;
        Thu, 18 Mar 2021 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616060794;
        bh=4lW7at++uzBOWwW2qDjo4aJMD6wyAVWr9mVXwLdpuvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USLTIdHEEDGVF9pwmZYMjd3Xl1Cu2SJLEJE9C0UUISi/VLn15bl/clYYKzGm2Z8Ed
         LaynK14EKLQatgLJ9djohsHJdPOja4IMpkmsBSr91OkvMpDcmCqx6v3k7Rq1QOO2Vw
         yXNzkYjzTiG1+RPI/wTzmnELtwqcSBPt2Ph62l3r90sh4+kIYqWVAPL+xwCNI6BR7v
         O/Nl9sGzTBg3GkHF62NruBzfu/YoVI8cdZyPqDH0xZtdCeEt7pm8NywYVqk4SSEfcm
         //Ux2ZrwqzvYKyLPys77xI4AsA0OcgVrN5nn4wcglo/dPOOpEUNurAcKyauKyvklkP
         Xo0NpZvGbLmyw==
From:   Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT bindings
Date:   Thu, 18 Mar 2021 15:16:16 +0530
Message-Id: <20210318094617.951212-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210318094617.951212-1-vkoul@kernel.org>
References: <20210318094617.951212-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM8350 platform has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  10 +
 .../dt-bindings/interconnect/qcom,sm8350.h    | 172 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 799e73cdb90b..cb6498108b78 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -71,6 +71,16 @@ properties:
       - qcom,sm8250-mmss-noc
       - qcom,sm8250-npu-noc
       - qcom,sm8250-system-noc
+      - qcom,sm8350-aggre1-noc
+      - qcom,sm8350-aggre2-noc
+      - qcom,sm8350-config-noc
+      - qcom,sm8350-dc-noc
+      - qcom,sm8350-gem-noc
+      - qcom,sm8350-lpass-ag-noc
+      - qcom,sm8350-mc-virt
+      - qcom,sm8350-mmss-noc
+      - qcom,sm8350-compute-noc
+      - qcom,sm8350-system-noc
 
   '#interconnect-cells':
     enum: [ 1, 2 ]
diff --git a/include/dt-bindings/interconnect/qcom,sm8350.h b/include/dt-bindings/interconnect/qcom,sm8350.h
new file mode 100644
index 000000000000..c7f7ed315aeb
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8350.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Qualcomm SM8350 interconnect IDs
+ *
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
+
+#define MASTER_QSPI_0			0
+#define MASTER_QUP_1			1
+#define MASTER_A1NOC_CFG		2
+#define MASTER_SDCC_4			3
+#define MASTER_UFS_MEM			4
+#define MASTER_USB3_0			5
+#define MASTER_USB3_1			6
+#define SLAVE_A1NOC_SNOC		7
+#define SLAVE_SERVICE_A1NOC		8
+
+#define MASTER_QDSS_BAM			0
+#define MASTER_QUP_0			1
+#define MASTER_QUP_2			2
+#define MASTER_A2NOC_CFG		3
+#define MASTER_CRYPTO			4
+#define MASTER_IPA			5
+#define MASTER_PCIE_0			6
+#define MASTER_PCIE_1			7
+#define MASTER_QDSS_ETR			8
+#define MASTER_SDCC_2			9
+#define MASTER_UFS_CARD			10
+#define SLAVE_A2NOC_SNOC		11
+#define SLAVE_ANOC_PCIE_GEM_NOC		12
+#define SLAVE_SERVICE_A2NOC		13
+
+#define MASTER_GEM_NOC_CNOC		0
+#define MASTER_GEM_NOC_PCIE_SNOC	1
+#define MASTER_QDSS_DAP			2
+#define SLAVE_AHB2PHY_SOUTH		3
+#define SLAVE_AHB2PHY_NORTH		4
+#define SLAVE_AOSS			5
+#define SLAVE_APPSS			6
+#define SLAVE_CAMERA_CFG		7
+#define SLAVE_CLK_CTL			8
+#define SLAVE_CDSP_CFG			9
+#define SLAVE_RBCPR_CX_CFG		10
+#define SLAVE_RBCPR_MMCX_CFG		11
+#define SLAVE_RBCPR_MX_CFG		12
+#define SLAVE_CRYPTO_0_CFG		13
+#define SLAVE_CX_RDPM			14
+#define SLAVE_DCC_CFG			15
+#define SLAVE_DISPLAY_CFG		16
+#define SLAVE_GFX3D_CFG			17
+#define SLAVE_HWKM			18
+#define SLAVE_IMEM_CFG			19
+#define SLAVE_IPA_CFG			20
+#define SLAVE_IPC_ROUTER_CFG		21
+#define SLAVE_LPASS			22
+#define SLAVE_CNOC_MSS			23
+#define SLAVE_MX_RDPM			24
+#define SLAVE_PCIE_0_CFG		25
+#define SLAVE_PCIE_1_CFG		26
+#define SLAVE_PDM			27
+#define SLAVE_PIMEM_CFG			28
+#define SLAVE_PKA_WRAPPER_CFG		29
+#define SLAVE_PMU_WRAPPER_CFG		30
+#define SLAVE_QDSS_CFG			31
+#define SLAVE_QSPI_0			32
+#define SLAVE_QUP_0			33
+#define SLAVE_QUP_1			34
+#define SLAVE_QUP_2			35
+#define SLAVE_SDCC_2			36
+#define SLAVE_SDCC_4			37
+#define SLAVE_SECURITY			38
+#define SLAVE_SPSS_CFG			39
+#define SLAVE_TCSR			40
+#define SLAVE_TLMM			41
+#define SLAVE_UFS_CARD_CFG		42
+#define SLAVE_UFS_MEM_CFG		43
+#define SLAVE_USB3_0			44
+#define SLAVE_USB3_1			45
+#define SLAVE_VENUS_CFG			46
+#define SLAVE_VSENSE_CTRL_CFG		47
+#define SLAVE_A1NOC_CFG			48
+#define SLAVE_A2NOC_CFG			49
+#define SLAVE_DDRSS_CFG			50
+#define SLAVE_CNOC_MNOC_CFG		51
+#define SLAVE_SNOC_CFG			52
+#define SLAVE_BOOT_IMEM			53
+#define SLAVE_IMEM			54
+#define SLAVE_PIMEM			55
+#define SLAVE_SERVICE_CNOC		56
+#define SLAVE_PCIE_0			57
+#define SLAVE_PCIE_1			58
+#define SLAVE_QDSS_STM			59
+#define SLAVE_TCU			60
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_GEM_NOC_CFG		2
+
+#define MASTER_GPU_TCU			0
+#define MASTER_SYS_TCU			1
+#define MASTER_APPSS_PROC		2
+#define MASTER_COMPUTE_NOC		3
+#define MASTER_GEM_NOC_CFG		4
+#define MASTER_GFX3D			5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_ANOC_PCIE_GEM_NOC	8
+#define MASTER_SNOC_GC_MEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC		10
+#define SLAVE_MSS_PROC_MS_MPU_CFG	11
+#define SLAVE_MCDMA_MS_MPU_CFG		12
+#define SLAVE_GEM_NOC_CNOC		13
+#define SLAVE_LLCC			14
+#define SLAVE_MEM_NOC_PCIE_SNOC		15
+#define SLAVE_SERVICE_GEM_NOC_1		16
+#define SLAVE_SERVICE_GEM_NOC_2		17
+#define SLAVE_SERVICE_GEM_NOC		18
+#define MASTER_MNOC_HF_MEM_NOC_DISP	19
+#define MASTER_MNOC_SF_MEM_NOC_DISP	20
+#define SLAVE_LLCC_DISP			21
+
+#define MASTER_CNOC_LPASS_AG_NOC	0
+#define SLAVE_LPASS_CORE_CFG		1
+#define SLAVE_LPASS_LPI_CFG		2
+#define SLAVE_LPASS_MPU_CFG		3
+#define SLAVE_LPASS_TOP_CFG		4
+#define SLAVE_SERVICES_LPASS_AML_NOC	5
+#define SLAVE_SERVICE_LPASS_AG_NOC	6
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI1			1
+#define MASTER_LLCC_DISP		2
+#define SLAVE_EBI1_DISP			3
+
+#define MASTER_CAMNOC_HF		0
+#define MASTER_CAMNOC_ICP		1
+#define MASTER_CAMNOC_SF		2
+#define MASTER_CNOC_MNOC_CFG		3
+#define MASTER_VIDEO_P0			4
+#define MASTER_VIDEO_P1			5
+#define MASTER_VIDEO_PROC		6
+#define MASTER_MDP0			7
+#define MASTER_MDP1			8
+#define MASTER_ROTATOR			9
+#define SLAVE_MNOC_HF_MEM_NOC		10
+#define SLAVE_MNOC_SF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+#define MASTER_MDP0_DISP		13
+#define MASTER_MDP1_DISP		14
+#define MASTER_ROTATOR_DISP		15
+#define SLAVE_MNOC_HF_MEM_NOC_DISP	16
+#define SLAVE_MNOC_SF_MEM_NOC_DISP	17
+
+#define MASTER_CDSP_NOC_CFG		0
+#define MASTER_CDSP_PROC		1
+#define SLAVE_CDSP_MEM_NOC		2
+#define SLAVE_SERVICE_NSP_NOC		3
+
+#define MASTER_A1NOC_SNOC		0
+#define MASTER_A2NOC_SNOC		1
+#define MASTER_SNOC_CFG			2
+#define MASTER_PIMEM			3
+#define MASTER_GIC			4
+#define SLAVE_SNOC_GEM_NOC_GC		5
+#define SLAVE_SNOC_GEM_NOC_SF		6
+#define SLAVE_SERVICE_SNOC		7
+
+#endif
-- 
2.26.3

