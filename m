Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D8340257
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCRJqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhCRJqi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 05:46:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2567764F10;
        Thu, 18 Mar 2021 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616060798;
        bh=K054W0/YbQHWUDXqwR5QiQLeZ2TO8PmjhpcdNDEOf98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB9idCn5OSeyGuWif3lVvuyXiIEr6OFl9GetUo7eSxlLGflGpCxrXk2qzuUZEv3qd
         5HuXjdsTOSY/JMvHp/zWJUOPRsqiEUvtmXU+Fso4HhBRjLxVI7ykm7L/ALVEShJvJv
         hQM1oXyY/6Nl7OkMQU9UCbXlvC09NV7vLIj5Ukau7yxm5+8M7SX+U6xjp960tZBE5+
         PWlDAWURkukD4IPD1RvGWxZvvp61mWVwy/1XXbt6Ek143n+TMl6tGf8n1u62EzGG1l
         9D5YJ7yOagICmh8tMh1NAIM8h1G9Rzc2KrQTOrxeTjaOCSGgBeM01z3ORQwd1x5sXK
         8paeigkrJJm+Q==
From:   Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] interconnect: qcom: Add SM8350 interconnect provider driver
Date:   Thu, 18 Mar 2021 15:16:17 +0530
Message-Id: <20210318094617.951212-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210318094617.951212-1-vkoul@kernel.org>
References: <20210318094617.951212-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SM8350 based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Generated from downstream interconnect driver written by David Dai

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/interconnect/qcom/Kconfig  |   9 +
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/sm8350.c | 633 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8350.h | 168 ++++++++
 4 files changed, 812 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8350.c
 create mode 100644 drivers/interconnect/qcom/sm8350.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index ca52647f8955..49bc8702782c 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -110,5 +110,14 @@ config INTERCONNECT_QCOM_SM8250
 	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
 	  platforms.
=20
+config INTERCONNECT_QCOM_SM8350
+	tristate "Qualcomm SM8350 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SM8350-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SMD_RPM
 	tristate
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index c6a735df067e..93d97e590836 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -12,6 +12,7 @@ qnoc-sdm845-objs			:=3D sdm845.o
 qnoc-sdx55-objs				:=3D sdx55.o
 qnoc-sm8150-objs			:=3D sm8150.o
 qnoc-sm8250-objs			:=3D sm8250.o
+qnoc-sm8350-objs			:=3D sm8350.o
 icc-smd-rpm-objs			:=3D smd-rpm.o icc-rpm.o
=20
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-voter.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) +=3D qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=3D qnoc-sm8350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) +=3D icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom=
/sm8350.c
new file mode 100644
index 000000000000..f3aab02b8678
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ *
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <dt-bindings/interconnect/qcom,sm8350.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sm8350.h"
+
+DEFINE_QNODE(qhm_qspi, SM8350_MASTER_QSPI_0, 1, 4, SM8350_SLAVE_A1NOC_SNOC=
);
+DEFINE_QNODE(qhm_qup0, SM8350_MASTER_QUP_0, 1, 4, SM8350_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(qhm_qup1, SM8350_MASTER_QUP_1, 1, 4, SM8350_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(qhm_qup2, SM8350_MASTER_QUP_2, 1, 4, SM8350_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(qnm_a1noc_cfg, SM8350_MASTER_A1NOC_CFG, 1, 4, SM8350_SLAVE_SE=
RVICE_A1NOC);
+DEFINE_QNODE(xm_sdc4, SM8350_MASTER_SDCC_4, 1, 8, SM8350_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(xm_ufs_mem, SM8350_MASTER_UFS_MEM, 1, 8, SM8350_SLAVE_A1NOC_S=
NOC);
+DEFINE_QNODE(xm_usb3_0, SM8350_MASTER_USB3_0, 1, 8, SM8350_SLAVE_A1NOC_SNO=
C);
+DEFINE_QNODE(xm_usb3_1, SM8350_MASTER_USB3_1, 1, 8, SM8350_SLAVE_A1NOC_SNO=
C);
+DEFINE_QNODE(qhm_qdss_bam, SM8350_MASTER_QDSS_BAM, 1, 4, SM8350_SLAVE_A2NO=
C_SNOC);
+DEFINE_QNODE(qnm_a2noc_cfg, SM8350_MASTER_A2NOC_CFG, 1, 4, SM8350_SLAVE_SE=
RVICE_A2NOC);
+DEFINE_QNODE(qxm_crypto, SM8350_MASTER_CRYPTO, 1, 8, SM8350_SLAVE_A2NOC_SN=
OC);
+DEFINE_QNODE(qxm_ipa, SM8350_MASTER_IPA, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(xm_pcie3_0, SM8350_MASTER_PCIE_0, 1, 8, SM8350_SLAVE_ANOC_PCI=
E_GEM_NOC);
+DEFINE_QNODE(xm_pcie3_1, SM8350_MASTER_PCIE_1, 1, 8, SM8350_SLAVE_ANOC_PCI=
E_GEM_NOC);
+DEFINE_QNODE(xm_qdss_etr, SM8350_MASTER_QDSS_ETR, 1, 8, SM8350_SLAVE_A2NOC=
_SNOC);
+DEFINE_QNODE(xm_sdc2, SM8350_MASTER_SDCC_2, 1, 8, SM8350_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(xm_ufs_card, SM8350_MASTER_UFS_CARD, 1, 8, SM8350_SLAVE_A2NOC=
_SNOC);
+DEFINE_QNODE(qnm_gemnoc_cnoc, SM8350_MASTER_GEM_NOC_CNOC, 1, 16, SM8350_SL=
AVE_AHB2PHY_SOUTH, SM8350_SLAVE_AHB2PHY_NORTH, SM8350_SLAVE_AOSS, SM8350_SL=
AVE_APPSS, SM8350_SLAVE_CAMERA_CFG, SM8350_SLAVE_CLK_CTL, SM8350_SLAVE_CDSP=
_CFG, SM8350_SLAVE_RBCPR_CX_CFG, SM8350_SLAVE_RBCPR_MMCX_CFG, SM8350_SLAVE_=
RBCPR_MX_CFG, SM8350_SLAVE_CRYPTO_0_CFG, SM8350_SLAVE_CX_RDPM, SM8350_SLAVE=
_DCC_CFG, SM8350_SLAVE_DISPLAY_CFG, SM8350_SLAVE_GFX3D_CFG, SM8350_SLAVE_HW=
KM, SM8350_SLAVE_IMEM_CFG, SM8350_SLAVE_IPA_CFG, SM8350_SLAVE_IPC_ROUTER_CF=
G, SM8350_SLAVE_LPASS, SM8350_SLAVE_CNOC_MSS, SM8350_SLAVE_MX_RDPM, SM8350_=
SLAVE_PCIE_0_CFG, SM8350_SLAVE_PCIE_1_CFG, SM8350_SLAVE_PDM, SM8350_SLAVE_P=
IMEM_CFG, SM8350_SLAVE_PKA_WRAPPER_CFG, SM8350_SLAVE_PMU_WRAPPER_CFG, SM835=
0_SLAVE_QDSS_CFG, SM8350_SLAVE_QSPI_0, SM8350_SLAVE_QUP_0, SM8350_SLAVE_QUP=
_1, SM8350_SLAVE_QUP_2, SM8350_SLAVE_SDCC_2, SM8350_SLAVE_SDCC_4, SM8350_SL=
AVE_SECURITY, SM8350_SLAVE_SPSS_CFG, SM8350_SLAVE_TCSR, SM8350_SLAVE_TLMM, =
SM8350_SLAVE_UFS_CARD_CFG, SM8350_SLAVE_UFS_MEM_CFG, SM8350_SLAVE_USB3_0, S=
M8350_SLAVE_USB3_1, SM8350_SLAVE_VENUS_CFG, SM8350_SLAVE_VSENSE_CTRL_CFG, S=
M8350_SLAVE_A1NOC_CFG, SM8350_SLAVE_A2NOC_CFG, SM8350_SLAVE_DDRSS_CFG, SM83=
50_SLAVE_CNOC_MNOC_CFG, SM8350_SLAVE_SNOC_CFG, SM8350_SLAVE_BOOT_IMEM, SM83=
50_SLAVE_IMEM, SM8350_SLAVE_PIMEM, SM8350_SLAVE_SERVICE_CNOC, SM8350_SLAVE_=
QDSS_STM, SM8350_SLAVE_TCU);
+DEFINE_QNODE(qnm_gemnoc_pcie, SM8350_MASTER_GEM_NOC_PCIE_SNOC, 1, 8, SM835=
0_SLAVE_PCIE_0, SM8350_SLAVE_PCIE_1);
+DEFINE_QNODE(xm_qdss_dap, SM8350_MASTER_QDSS_DAP, 1, 8, SM8350_SLAVE_AHB2P=
HY_SOUTH, SM8350_SLAVE_AHB2PHY_NORTH, SM8350_SLAVE_AOSS, SM8350_SLAVE_APPSS=
, SM8350_SLAVE_CAMERA_CFG, SM8350_SLAVE_CLK_CTL, SM8350_SLAVE_CDSP_CFG, SM8=
350_SLAVE_RBCPR_CX_CFG, SM8350_SLAVE_RBCPR_MMCX_CFG, SM8350_SLAVE_RBCPR_MX_=
CFG, SM8350_SLAVE_CRYPTO_0_CFG, SM8350_SLAVE_CX_RDPM, SM8350_SLAVE_DCC_CFG,=
 SM8350_SLAVE_DISPLAY_CFG, SM8350_SLAVE_GFX3D_CFG, SM8350_SLAVE_HWKM, SM835=
0_SLAVE_IMEM_CFG, SM8350_SLAVE_IPA_CFG, SM8350_SLAVE_IPC_ROUTER_CFG, SM8350=
_SLAVE_LPASS, SM8350_SLAVE_CNOC_MSS, SM8350_SLAVE_MX_RDPM, SM8350_SLAVE_PCI=
E_0_CFG, SM8350_SLAVE_PCIE_1_CFG, SM8350_SLAVE_PDM, SM8350_SLAVE_PIMEM_CFG,=
 SM8350_SLAVE_PKA_WRAPPER_CFG, SM8350_SLAVE_PMU_WRAPPER_CFG, SM8350_SLAVE_Q=
DSS_CFG, SM8350_SLAVE_QSPI_0, SM8350_SLAVE_QUP_0, SM8350_SLAVE_QUP_1, SM835=
0_SLAVE_QUP_2, SM8350_SLAVE_SDCC_2, SM8350_SLAVE_SDCC_4, SM8350_SLAVE_SECUR=
ITY, SM8350_SLAVE_SPSS_CFG, SM8350_SLAVE_TCSR, SM8350_SLAVE_TLMM, SM8350_SL=
AVE_UFS_CARD_CFG, SM8350_SLAVE_UFS_MEM_CFG, SM8350_SLAVE_USB3_0, SM8350_SLA=
VE_USB3_1, SM8350_SLAVE_VENUS_CFG, SM8350_SLAVE_VSENSE_CTRL_CFG, SM8350_SLA=
VE_A1NOC_CFG, SM8350_SLAVE_A2NOC_CFG, SM8350_SLAVE_DDRSS_CFG, SM8350_SLAVE_=
CNOC_MNOC_CFG, SM8350_SLAVE_SNOC_CFG, SM8350_SLAVE_BOOT_IMEM, SM8350_SLAVE_=
IMEM, SM8350_SLAVE_PIMEM, SM8350_SLAVE_SERVICE_CNOC, SM8350_SLAVE_QDSS_STM,=
 SM8350_SLAVE_TCU);
+DEFINE_QNODE(qnm_cnoc_dc_noc, SM8350_MASTER_CNOC_DC_NOC, 1, 4, SM8350_SLAV=
E_LLCC_CFG, SM8350_SLAVE_GEM_NOC_CFG);
+DEFINE_QNODE(alm_gpu_tcu, SM8350_MASTER_GPU_TCU, 1, 8, SM8350_SLAVE_GEM_NO=
C_CNOC, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(alm_sys_tcu, SM8350_MASTER_SYS_TCU, 1, 8, SM8350_SLAVE_GEM_NO=
C_CNOC, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(chm_apps, SM8350_MASTER_APPSS_PROC, 2, 32, SM8350_SLAVE_GEM_N=
OC_CNOC, SM8350_SLAVE_LLCC, SM8350_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qnm_cmpnoc, SM8350_MASTER_COMPUTE_NOC, 2, 32, SM8350_SLAVE_GE=
M_NOC_CNOC, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(qnm_gemnoc_cfg, SM8350_MASTER_GEM_NOC_CFG, 1, 4, SM8350_SLAVE=
_MSS_PROC_MS_MPU_CFG, SM8350_SLAVE_MCDMA_MS_MPU_CFG, SM8350_SLAVE_SERVICE_G=
EM_NOC_1, SM8350_SLAVE_SERVICE_GEM_NOC_2, SM8350_SLAVE_SERVICE_GEM_NOC);
+DEFINE_QNODE(qnm_gpu, SM8350_MASTER_GFX3D, 2, 32, SM8350_SLAVE_GEM_NOC_CNO=
C, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(qnm_mnoc_hf, SM8350_MASTER_MNOC_HF_MEM_NOC, 2, 32, SM8350_SLA=
VE_LLCC);
+DEFINE_QNODE(qnm_mnoc_sf, SM8350_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8350_SLA=
VE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(qnm_pcie, SM8350_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8350_SLAV=
E_GEM_NOC_CNOC, SM8350_SLAVE_LLCC);
+DEFINE_QNODE(qnm_snoc_gc, SM8350_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8350_SLAV=
E_LLCC);
+DEFINE_QNODE(qnm_snoc_sf, SM8350_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8350_SLA=
VE_GEM_NOC_CNOC, SM8350_SLAVE_LLCC, SM8350_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhm_config_noc, SM8350_MASTER_CNOC_LPASS_AG_NOC, 1, 4, SM8350=
_SLAVE_LPASS_CORE_CFG, SM8350_SLAVE_LPASS_LPI_CFG, SM8350_SLAVE_LPASS_MPU_C=
FG, SM8350_SLAVE_LPASS_TOP_CFG, SM8350_SLAVE_SERVICES_LPASS_AML_NOC, SM8350=
_SLAVE_SERVICE_LPASS_AG_NOC);
+DEFINE_QNODE(llcc_mc, SM8350_MASTER_LLCC, 4, 4, SM8350_SLAVE_EBI1);
+DEFINE_QNODE(qnm_camnoc_hf, SM8350_MASTER_CAMNOC_HF, 2, 32, SM8350_SLAVE_M=
NOC_HF_MEM_NOC);
+DEFINE_QNODE(qnm_camnoc_icp, SM8350_MASTER_CAMNOC_ICP, 1, 8, SM8350_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qnm_camnoc_sf, SM8350_MASTER_CAMNOC_SF, 2, 32, SM8350_SLAVE_M=
NOC_SF_MEM_NOC);
+DEFINE_QNODE(qnm_mnoc_cfg, SM8350_MASTER_CNOC_MNOC_CFG, 1, 4, SM8350_SLAVE=
_SERVICE_MNOC);
+DEFINE_QNODE(qnm_video0, SM8350_MASTER_VIDEO_P0, 1, 32, SM8350_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qnm_video1, SM8350_MASTER_VIDEO_P1, 1, 32, SM8350_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qnm_video_cvp, SM8350_MASTER_VIDEO_PROC, 1, 32, SM8350_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_mdp0, SM8350_MASTER_MDP0, 1, 32, SM8350_SLAVE_MNOC_HF_MEM=
_NOC);
+DEFINE_QNODE(qxm_mdp1, SM8350_MASTER_MDP1, 1, 32, SM8350_SLAVE_MNOC_HF_MEM=
_NOC);
+DEFINE_QNODE(qxm_rot, SM8350_MASTER_ROTATOR, 1, 32, SM8350_SLAVE_MNOC_SF_M=
EM_NOC);
+DEFINE_QNODE(qhm_nsp_noc_config, SM8350_MASTER_CDSP_NOC_CFG, 1, 4, SM8350_=
SLAVE_SERVICE_NSP_NOC);
+DEFINE_QNODE(qxm_nsp, SM8350_MASTER_CDSP_PROC, 2, 32, SM8350_SLAVE_CDSP_ME=
M_NOC);
+DEFINE_QNODE(qnm_aggre1_noc, SM8350_MASTER_A1NOC_SNOC, 1, 16, SM8350_SLAVE=
_SNOC_GEM_NOC_SF);
+DEFINE_QNODE(qnm_aggre2_noc, SM8350_MASTER_A2NOC_SNOC, 1, 16, SM8350_SLAVE=
_SNOC_GEM_NOC_SF);
+DEFINE_QNODE(qnm_snoc_cfg, SM8350_MASTER_SNOC_CFG, 1, 4, SM8350_SLAVE_SERV=
ICE_SNOC);
+DEFINE_QNODE(qxm_pimem, SM8350_MASTER_PIMEM, 1, 8, SM8350_SLAVE_SNOC_GEM_N=
OC_GC);
+DEFINE_QNODE(xm_gic, SM8350_MASTER_GIC, 1, 8, SM8350_SLAVE_SNOC_GEM_NOC_GC=
);
+DEFINE_QNODE(qnm_mnoc_hf_disp, SM8350_MASTER_MNOC_HF_MEM_NOC_DISP, 2, 32, =
SM8350_SLAVE_LLCC_DISP);
+DEFINE_QNODE(qnm_mnoc_sf_disp, SM8350_MASTER_MNOC_SF_MEM_NOC_DISP, 2, 32, =
SM8350_SLAVE_LLCC_DISP);
+DEFINE_QNODE(llcc_mc_disp, SM8350_MASTER_LLCC_DISP, 4, 4, SM8350_SLAVE_EBI=
1_DISP);
+DEFINE_QNODE(qxm_mdp0_disp, SM8350_MASTER_MDP0_DISP, 1, 32, SM8350_SLAVE_M=
NOC_HF_MEM_NOC_DISP);
+DEFINE_QNODE(qxm_mdp1_disp, SM8350_MASTER_MDP1_DISP, 1, 32, SM8350_SLAVE_M=
NOC_HF_MEM_NOC_DISP);
+DEFINE_QNODE(qxm_rot_disp, SM8350_MASTER_ROTATOR_DISP, 1, 32, SM8350_SLAVE=
_MNOC_SF_MEM_NOC_DISP);
+DEFINE_QNODE(qns_a1noc_snoc, SM8350_SLAVE_A1NOC_SNOC, 1, 16, SM8350_MASTER=
_A1NOC_SNOC);
+DEFINE_QNODE(srvc_aggre1_noc, SM8350_SLAVE_SERVICE_A1NOC, 1, 4);
+DEFINE_QNODE(qns_a2noc_snoc, SM8350_SLAVE_A2NOC_SNOC, 1, 16, SM8350_MASTER=
_A2NOC_SNOC);
+DEFINE_QNODE(qns_pcie_mem_noc, SM8350_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16, SM83=
50_MASTER_ANOC_PCIE_GEM_NOC);
+DEFINE_QNODE(srvc_aggre2_noc, SM8350_SLAVE_SERVICE_A2NOC, 1, 4);
+DEFINE_QNODE(qhs_ahb2phy0, SM8350_SLAVE_AHB2PHY_SOUTH, 1, 4);
+DEFINE_QNODE(qhs_ahb2phy1, SM8350_SLAVE_AHB2PHY_NORTH, 1, 4);
+DEFINE_QNODE(qhs_aoss, SM8350_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_apss, SM8350_SLAVE_APPSS, 1, 8);
+DEFINE_QNODE(qhs_camera_cfg, SM8350_SLAVE_CAMERA_CFG, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SM8350_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_compute_cfg, SM8350_SLAVE_CDSP_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_cx, SM8350_SLAVE_RBCPR_CX_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_mmcx, SM8350_SLAVE_RBCPR_MMCX_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_mx, SM8350_SLAVE_RBCPR_MX_CFG, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SM8350_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_cx_rdpm, SM8350_SLAVE_CX_RDPM, 1, 4);
+DEFINE_QNODE(qhs_dcc_cfg, SM8350_SLAVE_DCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_display_cfg, SM8350_SLAVE_DISPLAY_CFG, 1, 4);
+DEFINE_QNODE(qhs_gpuss_cfg, SM8350_SLAVE_GFX3D_CFG, 1, 8);
+DEFINE_QNODE(qhs_hwkm, SM8350_SLAVE_HWKM, 1, 4);
+DEFINE_QNODE(qhs_imem_cfg, SM8350_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SM8350_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipc_router, SM8350_SLAVE_IPC_ROUTER_CFG, 1, 4);
+DEFINE_QNODE(qhs_lpass_cfg, SM8350_SLAVE_LPASS, 1, 4, SM8350_MASTER_CNOC_L=
PASS_AG_NOC);
+DEFINE_QNODE(qhs_mss_cfg, SM8350_SLAVE_CNOC_MSS, 1, 4);
+DEFINE_QNODE(qhs_mx_rdpm, SM8350_SLAVE_MX_RDPM, 1, 4);
+DEFINE_QNODE(qhs_pcie0_cfg, SM8350_SLAVE_PCIE_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_pcie1_cfg, SM8350_SLAVE_PCIE_1_CFG, 1, 4);
+DEFINE_QNODE(qhs_pdm, SM8350_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_pimem_cfg, SM8350_SLAVE_PIMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_pka_wrapper_cfg, SM8350_SLAVE_PKA_WRAPPER_CFG, 1, 4);
+DEFINE_QNODE(qhs_pmu_wrapper_cfg, SM8350_SLAVE_PMU_WRAPPER_CFG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SM8350_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qspi, SM8350_SLAVE_QSPI_0, 1, 4);
+DEFINE_QNODE(qhs_qup0, SM8350_SLAVE_QUP_0, 1, 4);
+DEFINE_QNODE(qhs_qup1, SM8350_SLAVE_QUP_1, 1, 4);
+DEFINE_QNODE(qhs_qup2, SM8350_SLAVE_QUP_2, 1, 4);
+DEFINE_QNODE(qhs_sdc2, SM8350_SLAVE_SDCC_2, 1, 4);
+DEFINE_QNODE(qhs_sdc4, SM8350_SLAVE_SDCC_4, 1, 4);
+DEFINE_QNODE(qhs_security, SM8350_SLAVE_SECURITY, 1, 4);
+DEFINE_QNODE(qhs_spss_cfg, SM8350_SLAVE_SPSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_tcsr, SM8350_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_tlmm, SM8350_SLAVE_TLMM, 1, 4);
+DEFINE_QNODE(qhs_ufs_card_cfg, SM8350_SLAVE_UFS_CARD_CFG, 1, 4);
+DEFINE_QNODE(qhs_ufs_mem_cfg, SM8350_SLAVE_UFS_MEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_usb3_0, SM8350_SLAVE_USB3_0, 1, 4);
+DEFINE_QNODE(qhs_usb3_1, SM8350_SLAVE_USB3_1, 1, 4);
+DEFINE_QNODE(qhs_venus_cfg, SM8350_SLAVE_VENUS_CFG, 1, 4);
+DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8350_SLAVE_VSENSE_CTRL_CFG, 1, 4);
+DEFINE_QNODE(qns_a1_noc_cfg, SM8350_SLAVE_A1NOC_CFG, 1, 4);
+DEFINE_QNODE(qns_a2_noc_cfg, SM8350_SLAVE_A2NOC_CFG, 1, 4);
+DEFINE_QNODE(qns_ddrss_cfg, SM8350_SLAVE_DDRSS_CFG, 1, 4);
+DEFINE_QNODE(qns_mnoc_cfg, SM8350_SLAVE_CNOC_MNOC_CFG, 1, 4);
+DEFINE_QNODE(qns_snoc_cfg, SM8350_SLAVE_SNOC_CFG, 1, 4);
+DEFINE_QNODE(qxs_boot_imem, SM8350_SLAVE_BOOT_IMEM, 1, 8);
+DEFINE_QNODE(qxs_imem, SM8350_SLAVE_IMEM, 1, 8);
+DEFINE_QNODE(qxs_pimem, SM8350_SLAVE_PIMEM, 1, 8);
+DEFINE_QNODE(srvc_cnoc, SM8350_SLAVE_SERVICE_CNOC, 1, 4);
+DEFINE_QNODE(xs_pcie_0, SM8350_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(xs_pcie_1, SM8350_SLAVE_PCIE_1, 1, 8);
+DEFINE_QNODE(xs_qdss_stm, SM8350_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SM8350_SLAVE_TCU, 1, 8);
+DEFINE_QNODE(qhs_llcc, SM8350_SLAVE_LLCC_CFG, 1, 4);
+DEFINE_QNODE(qns_gemnoc, SM8350_SLAVE_GEM_NOC_CFG, 1, 4);
+DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qhs_modem_ms_mpu_cfg, SM8350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16);
+DEFINE_QNODE(qns_llcc, SM8350_SLAVE_LLCC, 4, 16, SM8350_MASTER_LLCC);
+DEFINE_QNODE(qns_pcie, SM8350_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8);
+DEFINE_QNODE(srvc_even_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
+DEFINE_QNODE(srvc_odd_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
+DEFINE_QNODE(srvc_sys_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC, 1, 4);
+DEFINE_QNODE(qhs_lpass_core, SM8350_SLAVE_LPASS_CORE_CFG, 1, 4);
+DEFINE_QNODE(qhs_lpass_lpi, SM8350_SLAVE_LPASS_LPI_CFG, 1, 4);
+DEFINE_QNODE(qhs_lpass_mpu, SM8350_SLAVE_LPASS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qhs_lpass_top, SM8350_SLAVE_LPASS_TOP_CFG, 1, 4);
+DEFINE_QNODE(srvc_niu_aml_noc, SM8350_SLAVE_SERVICES_LPASS_AML_NOC, 1, 4);
+DEFINE_QNODE(srvc_niu_lpass_agnoc, SM8350_SLAVE_SERVICE_LPASS_AG_NOC, 1, 4=
);
+DEFINE_QNODE(ebi, SM8350_SLAVE_EBI1, 4, 4);
+DEFINE_QNODE(qns_mem_noc_hf, SM8350_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8350_M=
ASTER_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(qns_mem_noc_sf, SM8350_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8350_M=
ASTER_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(srvc_mnoc, SM8350_SLAVE_SERVICE_MNOC, 1, 4);
+DEFINE_QNODE(qns_nsp_gemnoc, SM8350_SLAVE_CDSP_MEM_NOC, 2, 32, SM8350_MAST=
ER_COMPUTE_NOC);
+DEFINE_QNODE(service_nsp_noc, SM8350_SLAVE_SERVICE_NSP_NOC, 1, 4);
+DEFINE_QNODE(qns_gemnoc_gc, SM8350_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM8350_MAS=
TER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qns_gemnoc_sf, SM8350_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM8350_MA=
STER_SNOC_SF_MEM_NOC);
+DEFINE_QNODE(srvc_snoc, SM8350_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(qns_llcc_disp, SM8350_SLAVE_LLCC_DISP, 4, 16, SM8350_MASTER_L=
LCC_DISP);
+DEFINE_QNODE(ebi_disp, SM8350_SLAVE_EBI1_DISP, 4, 4);
+DEFINE_QNODE(qns_mem_noc_hf_disp, SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP, 2, 32=
, SM8350_MASTER_MNOC_HF_MEM_NOC_DISP);
+DEFINE_QNODE(qns_mem_noc_sf_disp, SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP, 2, 32=
, SM8350_MASTER_MNOC_SF_MEM_NOC_DISP);
+
+DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie);
+DEFINE_QBCM(bcm_cn1, "CN1", false, &xm_qdss_dap, &qhs_ahb2phy0, &qhs_ahb2p=
hy1, &qhs_aoss, &qhs_apss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_cfg,=
 &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_cx_rdpm, &=
qhs_dcc_cfg, &qhs_display_cfg, &qhs_gpuss_cfg, &qhs_hwkm, &qhs_imem_cfg, &q=
hs_ipa, &qhs_ipc_router, &qhs_mss_cfg, &qhs_mx_rdpm, &qhs_pcie0_cfg, &qhs_p=
cie1_cfg, &qhs_pimem_cfg, &qhs_pka_wrapper_cfg, &qhs_pmu_wrapper_cfg, &qhs_=
qdss_cfg, &qhs_qup0, &qhs_qup1, &qhs_qup2, &qhs_security, &qhs_spss_cfg, &q=
hs_tcsr, &qhs_tlmm, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_=
usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_a1_noc_cfg, &qns_a2_noc_=
cfg, &qns_ddrss_cfg, &qns_mnoc_cfg, &qns_snoc_cfg, &srvc_cnoc);
+DEFINE_QBCM(bcm_cn2, "CN2", false, &qhs_lpass_cfg, &qhs_pdm, &qhs_qspi, &q=
hs_sdc2, &qhs_sdc4);
+DEFINE_QBCM(bcm_co0, "CO0", false, &qns_nsp_gemnoc);
+DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_nsp);
+DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
+DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
+DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
+DEFINE_QBCM(bcm_mm4, "MM4", false, &qns_mem_noc_sf);
+DEFINE_QBCM(bcm_mm5, "MM5", false, &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_v=
ideo0, &qnm_video1, &qnm_video_cvp, &qxm_rot);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
+DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
+DEFINE_QBCM(bcm_sh4, "SH4", false, &chm_apps);
+DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_sn5, "SN5", false, &xm_pcie3_0);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &xm_pcie3_1);
+DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_aggre2_noc);
+DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
+DEFINE_QBCM(bcm_acv_disp, "ACV", false, &ebi_disp);
+DEFINE_QBCM(bcm_mc0_disp, "MC0", false, &ebi_disp);
+DEFINE_QBCM(bcm_mm0_disp, "MM0", false, &qns_mem_noc_hf_disp);
+DEFINE_QBCM(bcm_mm1_disp, "MM1", false, &qxm_mdp0_disp, &qxm_mdp1_disp);
+DEFINE_QBCM(bcm_mm4_disp, "MM4", false, &qns_mem_noc_sf_disp);
+DEFINE_QBCM(bcm_mm5_disp, "MM5", false, &qxm_rot_disp);
+DEFINE_QBCM(bcm_sh0_disp, "SH0", false, &qns_llcc_disp);
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *aggre1_noc_nodes[] =3D {
+	[MASTER_QSPI_0] =3D &qhm_qspi,
+	[MASTER_QUP_1] =3D &qhm_qup1,
+	[MASTER_A1NOC_CFG] =3D &qnm_a1noc_cfg,
+	[MASTER_SDCC_4] =3D &xm_sdc4,
+	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
+	[MASTER_USB3_0] =3D &xm_usb3_0,
+	[MASTER_USB3_1] =3D &xm_usb3_1,
+	[SLAVE_A1NOC_SNOC] =3D &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
+};
+
+static struct qcom_icc_desc sm8350_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm *aggre2_noc_bcms[] =3D {
+	&bcm_ce0,
+	&bcm_sn5,
+	&bcm_sn6,
+	&bcm_sn14,
+};
+
+static struct qcom_icc_node *aggre2_noc_nodes[] =3D {
+	[SM8350_MASTER_QDSS_BAM] =3D &qhm_qdss_bam,
+	[SM8350_MASTER_QUP_0] =3D &qhm_qup0,
+	[SM8350_MASTER_QUP_2] =3D &qhm_qup2,
+	[SM8350_MASTER_A2NOC_CFG] =3D &qnm_a2noc_cfg,
+	[SM8350_MASTER_CRYPTO] =3D &qxm_crypto,
+	[SM8350_MASTER_IPA] =3D &qxm_ipa,
+	[SM8350_MASTER_PCIE_0] =3D &xm_pcie3_0,
+	[SM8350_MASTER_PCIE_1] =3D &xm_pcie3_1,
+	[SM8350_MASTER_QDSS_ETR] =3D &xm_qdss_etr,
+	[SM8350_MASTER_SDCC_2] =3D &xm_sdc2,
+	[SM8350_MASTER_UFS_CARD] =3D &xm_ufs_card,
+	[SM8350_SLAVE_A2NOC_SNOC] =3D &qns_a2noc_snoc,
+	[SM8350_SLAVE_ANOC_PCIE_GEM_NOC] =3D &qns_pcie_mem_noc,
+	[SM8350_SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
+};
+
+static struct qcom_icc_desc sm8350_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] =3D {
+	&bcm_cn0,
+	&bcm_cn1,
+	&bcm_cn2,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] =3D {
+	[MASTER_GEM_NOC_CNOC] =3D &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] =3D &qnm_gemnoc_pcie,
+	[MASTER_QDSS_DAP] =3D &xm_qdss_dap,
+	[SLAVE_AHB2PHY_SOUTH] =3D &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] =3D &qhs_ahb2phy1,
+	[SLAVE_AOSS] =3D &qhs_aoss,
+	[SLAVE_APPSS] =3D &qhs_apss,
+	[SLAVE_CAMERA_CFG] =3D &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] =3D &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] =3D &qhs_compute_cfg,
+	[SLAVE_RBCPR_CX_CFG] =3D &qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] =3D &qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MX_CFG] =3D &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] =3D &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] =3D &qhs_cx_rdpm,
+	[SLAVE_DCC_CFG] =3D &qhs_dcc_cfg,
+	[SLAVE_DISPLAY_CFG] =3D &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] =3D &qhs_gpuss_cfg,
+	[SLAVE_HWKM] =3D &qhs_hwkm,
+	[SLAVE_IMEM_CFG] =3D &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] =3D &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] =3D &qhs_ipc_router,
+	[SLAVE_LPASS] =3D &qhs_lpass_cfg,
+	[SLAVE_CNOC_MSS] =3D &qhs_mss_cfg,
+	[SLAVE_MX_RDPM] =3D &qhs_mx_rdpm,
+	[SLAVE_PCIE_0_CFG] =3D &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] =3D &qhs_pcie1_cfg,
+	[SLAVE_PDM] =3D &qhs_pdm,
+	[SLAVE_PIMEM_CFG] =3D &qhs_pimem_cfg,
+	[SLAVE_PKA_WRAPPER_CFG] =3D &qhs_pka_wrapper_cfg,
+	[SLAVE_PMU_WRAPPER_CFG] =3D &qhs_pmu_wrapper_cfg,
+	[SLAVE_QDSS_CFG] =3D &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] =3D &qhs_qspi,
+	[SLAVE_QUP_0] =3D &qhs_qup0,
+	[SLAVE_QUP_1] =3D &qhs_qup1,
+	[SLAVE_QUP_2] =3D &qhs_qup2,
+	[SLAVE_SDCC_2] =3D &qhs_sdc2,
+	[SLAVE_SDCC_4] =3D &qhs_sdc4,
+	[SLAVE_SECURITY] =3D &qhs_security,
+	[SLAVE_SPSS_CFG] =3D &qhs_spss_cfg,
+	[SLAVE_TCSR] =3D &qhs_tcsr,
+	[SLAVE_TLMM] =3D &qhs_tlmm,
+	[SLAVE_UFS_CARD_CFG] =3D &qhs_ufs_card_cfg,
+	[SLAVE_UFS_MEM_CFG] =3D &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] =3D &qhs_usb3_0,
+	[SLAVE_USB3_1] =3D &qhs_usb3_1,
+	[SLAVE_VENUS_CFG] =3D &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] =3D &qhs_vsense_ctrl_cfg,
+	[SLAVE_A1NOC_CFG] =3D &qns_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] =3D &qns_a2_noc_cfg,
+	[SLAVE_DDRSS_CFG] =3D &qns_ddrss_cfg,
+	[SLAVE_CNOC_MNOC_CFG] =3D &qns_mnoc_cfg,
+	[SLAVE_SNOC_CFG] =3D &qns_snoc_cfg,
+	[SLAVE_BOOT_IMEM] =3D &qxs_boot_imem,
+	[SLAVE_IMEM] =3D &qxs_imem,
+	[SLAVE_PIMEM] =3D &qxs_pimem,
+	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
+	[SLAVE_PCIE_0] =3D &xs_pcie_0,
+	[SLAVE_PCIE_1] =3D &xs_pcie_1,
+	[SLAVE_QDSS_STM] =3D &xs_qdss_stm,
+	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
+};
+
+static struct qcom_icc_desc sm8350_config_noc =3D {
+	.nodes =3D config_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(config_noc_nodes),
+	.bcms =3D config_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm *dc_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] =3D {
+	[MASTER_CNOC_DC_NOC] =3D &qnm_cnoc_dc_noc,
+	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
+	[SLAVE_GEM_NOC_CFG] =3D &qns_gemnoc,
+};
+
+static struct qcom_icc_desc sm8350_dc_noc =3D {
+	.nodes =3D dc_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(dc_noc_nodes),
+	.bcms =3D dc_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm *gem_noc_bcms[] =3D {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_sh4,
+	&bcm_sh0_disp,
+};
+
+static struct qcom_icc_node *gem_noc_nodes[] =3D {
+	[MASTER_GPU_TCU] =3D &alm_gpu_tcu,
+	[MASTER_SYS_TCU] =3D &alm_sys_tcu,
+	[MASTER_APPSS_PROC] =3D &chm_apps,
+	[MASTER_COMPUTE_NOC] =3D &qnm_cmpnoc,
+	[MASTER_GEM_NOC_CFG] =3D &qnm_gemnoc_cfg,
+	[MASTER_GFX3D] =3D &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] =3D &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
+	[MASTER_ANOC_PCIE_GEM_NOC] =3D &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D &qnm_snoc_sf,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_MCDMA_MS_MPU_CFG] =3D &qhs_modem_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_CNOC] =3D &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] =3D &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] =3D &qns_pcie,
+	[SLAVE_SERVICE_GEM_NOC_1] =3D &srvc_even_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC_2] =3D &srvc_odd_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC] =3D &srvc_sys_gemnoc,
+	[MASTER_MNOC_HF_MEM_NOC_DISP] =3D &qnm_mnoc_hf_disp,
+	[MASTER_MNOC_SF_MEM_NOC_DISP] =3D &qnm_mnoc_sf_disp,
+	[SLAVE_LLCC_DISP] =3D &qns_llcc_disp,
+};
+
+static struct qcom_icc_desc sm8350_gem_noc =3D {
+	.nodes =3D gem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gem_noc_nodes),
+	.bcms =3D gem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *lpass_ag_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *lpass_ag_noc_nodes[] =3D {
+	[MASTER_CNOC_LPASS_AG_NOC] =3D &qhm_config_noc,
+	[SLAVE_LPASS_CORE_CFG] =3D &qhs_lpass_core,
+	[SLAVE_LPASS_LPI_CFG] =3D &qhs_lpass_lpi,
+	[SLAVE_LPASS_MPU_CFG] =3D &qhs_lpass_mpu,
+	[SLAVE_LPASS_TOP_CFG] =3D &qhs_lpass_top,
+	[SLAVE_SERVICES_LPASS_AML_NOC] =3D &srvc_niu_aml_noc,
+	[SLAVE_SERVICE_LPASS_AG_NOC] =3D &srvc_niu_lpass_agnoc,
+};
+
+static struct qcom_icc_desc sm8350_lpass_ag_noc =3D {
+	.nodes =3D lpass_ag_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms =3D lpass_ag_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mc_virt_bcms[] =3D {
+	&bcm_acv,
+	&bcm_mc0,
+	&bcm_acv_disp,
+	&bcm_mc0_disp,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] =3D {
+	[SM8350_MASTER_LLCC] =3D &llcc_mc,
+	[SM8350_SLAVE_EBI1] =3D &ebi,
+	[SM8350_MASTER_LLCC_DISP] =3D &llcc_mc_disp,
+	[SM8350_SLAVE_EBI1_DISP] =3D &ebi_disp,
+};
+
+static struct qcom_icc_desc sm8350_mc_virt =3D {
+	.nodes =3D mc_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(mc_virt_nodes),
+	.bcms =3D mc_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm4,
+	&bcm_mm5,
+	&bcm_mm0_disp,
+	&bcm_mm1_disp,
+	&bcm_mm4_disp,
+	&bcm_mm5_disp,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] =3D {
+	[SM8350_MASTER_CAMNOC_HF] =3D &qnm_camnoc_hf,
+	[SM8350_MASTER_CAMNOC_ICP] =3D &qnm_camnoc_icp,
+	[SM8350_MASTER_CAMNOC_SF] =3D &qnm_camnoc_sf,
+	[SM8350_MASTER_CNOC_MNOC_CFG] =3D &qnm_mnoc_cfg,
+	[SM8350_MASTER_VIDEO_P0] =3D &qnm_video0,
+	[SM8350_MASTER_VIDEO_P1] =3D &qnm_video1,
+	[SM8350_MASTER_VIDEO_PROC] =3D &qnm_video_cvp,
+	[SM8350_MASTER_MDP0] =3D &qxm_mdp0,
+	[SM8350_MASTER_MDP1] =3D &qxm_mdp1,
+	[SM8350_MASTER_ROTATOR] =3D &qxm_rot,
+	[SM8350_SLAVE_MNOC_HF_MEM_NOC] =3D &qns_mem_noc_hf,
+	[SM8350_SLAVE_MNOC_SF_MEM_NOC] =3D &qns_mem_noc_sf,
+	[SM8350_SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
+	[SM8350_MASTER_MDP0_DISP] =3D &qxm_mdp0_disp,
+	[SM8350_MASTER_MDP1_DISP] =3D &qxm_mdp1_disp,
+	[SM8350_MASTER_ROTATOR_DISP] =3D &qxm_rot_disp,
+	[SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP] =3D &qns_mem_noc_hf_disp,
+	[SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP] =3D &qns_mem_noc_sf_disp,
+};
+
+static struct qcom_icc_desc sm8350_mmss_noc =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm *nsp_noc_bcms[] =3D {
+	&bcm_co0,
+	&bcm_co3,
+};
+
+static struct qcom_icc_node *nsp_noc_nodes[] =3D {
+	[SM8350_MASTER_CDSP_NOC_CFG] =3D &qhm_nsp_noc_config,
+	[SM8350_MASTER_CDSP_PROC] =3D &qxm_nsp,
+	[SM8350_SLAVE_CDSP_MEM_NOC] =3D &qns_nsp_gemnoc,
+	[SM8350_SLAVE_SERVICE_NSP_NOC] =3D &service_nsp_noc,
+};
+
+static struct qcom_icc_desc sm8350_compute_noc =3D {
+	.nodes =3D nsp_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(nsp_noc_nodes),
+	.bcms =3D nsp_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] =3D {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn7,
+	&bcm_sn8,
+};
+
+static struct qcom_icc_node *system_noc_nodes[] =3D {
+	[MASTER_A1NOC_SNOC] =3D &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] =3D &qnm_aggre2_noc,
+	[MASTER_SNOC_CFG] =3D &qnm_snoc_cfg,
+	[MASTER_PIMEM] =3D &qxm_pimem,
+	[MASTER_GIC] =3D &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] =3D &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] =3D &qns_gemnoc_sf,
+	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
+};
+
+static struct qcom_icc_desc sm8350_system_noc =3D {
+	.nodes =3D system_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(system_noc_nodes),
+	.bcms =3D system_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(system_noc_bcms),
+};
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	const struct qcom_icc_desc *desc;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node **qnodes;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i;
+	int ret;
+
+	desc =3D of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes =3D desc->nodes;
+	num_nodes =3D desc->num_nodes;
+
+	qp =3D devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data =3D devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider =3D &qp->provider;
+	provider->dev =3D &pdev->dev;
+	provider->set =3D qcom_icc_set;
+	provider->pre_aggregate =3D qcom_icc_pre_aggregate;
+	provider->aggregate =3D qcom_icc_aggregate;
+	provider->xlate =3D of_icc_xlate_onecell;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data =3D data;
+
+	qp->dev =3D &pdev->dev;
+	qp->bcms =3D desc->bcms;
+	qp->num_bcms =3D desc->num_bcms;
+
+	qp->voter =3D of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter))
+		return PTR_ERR(qp->voter);
+
+	ret =3D icc_provider_add(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i =3D 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
+	for (i =3D 0; i < num_nodes; i++) {
+		size_t j;
+
+		if (!qnodes[i])
+			continue;
+
+		node =3D icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret =3D PTR_ERR(node);
+			goto err;
+		}
+
+		node->name =3D qnodes[i]->name;
+		node->data =3D qnodes[i];
+		icc_node_add(node, provider);
+
+		for (j =3D 0; j < qnodes[i]->num_links; j++)
+			icc_link_create(node, qnodes[i]->links[j]);
+
+		data->nodes[i] =3D node;
+	}
+	data->num_nodes =3D num_nodes;
+
+	platform_set_drvdata(pdev, qp);
+
+	return ret;
+
+err:
+	icc_nodes_remove(provider);
+	icc_provider_del(provider);
+	return ret;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp =3D platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
+static const struct of_device_id qnoc_of_match[] =3D {
+	{ .compatible =3D "qcom,sm8350-aggre1-noc", .data =3D &sm8350_aggre1_noc},
+	{ .compatible =3D "qcom,sm8350-aggre2-noc", .data =3D &sm8350_aggre2_noc},
+	{ .compatible =3D "qcom,sm8350-config-noc", .data =3D &sm8350_config_noc},
+	{ .compatible =3D "qcom,sm8350-dc-noc", .data =3D &sm8350_dc_noc},
+	{ .compatible =3D "qcom,sm8350-gem-noc", .data =3D &sm8350_gem_noc},
+	{ .compatible =3D "qcom,sm8350-lpass-ag-noc", .data =3D &sm8350_lpass_ag_=
noc},
+	{ .compatible =3D "qcom,sm8350-mc-virt", .data =3D &sm8350_mc_virt},
+	{ .compatible =3D "qcom,sm8350-mmss-noc", .data =3D &sm8350_mmss_noc},
+	{ .compatible =3D "qcom,sm8350-compute-noc", .data =3D &sm8350_compute_no=
c},
+	{ .compatible =3D "qcom,sm8350-system-noc", .data =3D &sm8350_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+	.probe =3D qnoc_probe,
+	.remove =3D qnoc_remove,
+	.driver =3D {
+		.name =3D "qnoc-sm8350",
+		.of_match_table =3D qnoc_of_match,
+		.sync_state =3D icc_sync_state,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("SM8350 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sm8350.h b/drivers/interconnect/qcom=
/sm8350.h
new file mode 100644
index 000000000000..328d15238a0d
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8350.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SM8350 interconnect IDs
+ *
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8350_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM8350_H
+
+#define SM8350_MASTER_GPU_TCU				0
+#define SM8350_MASTER_SYS_TCU				1
+#define SM8350_MASTER_APPSS_PROC			2
+#define SM8350_MASTER_LLCC				3
+#define SM8350_MASTER_CNOC_LPASS_AG_NOC			4
+#define SM8350_MASTER_CDSP_NOC_CFG			5
+#define SM8350_MASTER_QDSS_BAM				6
+#define SM8350_MASTER_QSPI_0				7
+#define SM8350_MASTER_QUP_0				8
+#define SM8350_MASTER_QUP_1				9
+#define SM8350_MASTER_QUP_2				10
+#define SM8350_MASTER_A1NOC_CFG				11
+#define SM8350_MASTER_A2NOC_CFG				12
+#define SM8350_MASTER_A1NOC_SNOC			13
+#define SM8350_MASTER_A2NOC_SNOC			14
+#define SM8350_MASTER_CAMNOC_HF				15
+#define SM8350_MASTER_CAMNOC_ICP			16
+#define SM8350_MASTER_CAMNOC_SF				17
+#define SM8350_MASTER_COMPUTE_NOC			18
+#define SM8350_MASTER_CNOC_DC_NOC			19
+#define SM8350_MASTER_GEM_NOC_CFG			20
+#define SM8350_MASTER_GEM_NOC_CNOC			21
+#define SM8350_MASTER_GEM_NOC_PCIE_SNOC			22
+#define SM8350_MASTER_GFX3D				23
+#define SM8350_MASTER_CNOC_MNOC_CFG			24
+#define SM8350_MASTER_MNOC_HF_MEM_NOC			25
+#define SM8350_MASTER_MNOC_SF_MEM_NOC			26
+#define SM8350_MASTER_ANOC_PCIE_GEM_NOC			27
+#define SM8350_MASTER_SNOC_CFG				28
+#define SM8350_MASTER_SNOC_GC_MEM_NOC			29
+#define SM8350_MASTER_SNOC_SF_MEM_NOC			30
+#define SM8350_MASTER_VIDEO_P0				31
+#define SM8350_MASTER_VIDEO_P1				32
+#define SM8350_MASTER_VIDEO_PROC			33
+#define SM8350_MASTER_QUP_CORE_0			34
+#define SM8350_MASTER_QUP_CORE_1			35
+#define SM8350_MASTER_QUP_CORE_2			36
+#define SM8350_MASTER_CRYPTO				37
+#define SM8350_MASTER_IPA				38
+#define SM8350_MASTER_MDP0				39
+#define SM8350_MASTER_MDP1				40
+#define SM8350_MASTER_CDSP_PROC				41
+#define SM8350_MASTER_PIMEM				42
+#define SM8350_MASTER_ROTATOR				43
+#define SM8350_MASTER_GIC				44
+#define SM8350_MASTER_PCIE_0				45
+#define SM8350_MASTER_PCIE_1				46
+#define SM8350_MASTER_QDSS_DAP				47
+#define SM8350_MASTER_QDSS_ETR				48
+#define SM8350_MASTER_SDCC_2				49
+#define SM8350_MASTER_SDCC_4				50
+#define SM8350_MASTER_UFS_CARD				51
+#define SM8350_MASTER_UFS_MEM				52
+#define SM8350_MASTER_USB3_0				53
+#define SM8350_MASTER_USB3_1				54
+#define SM8350_SLAVE_EBI1				55
+#define SM8350_SLAVE_AHB2PHY_SOUTH			56
+#define SM8350_SLAVE_AHB2PHY_NORTH			57
+#define SM8350_SLAVE_AOSS				58
+#define SM8350_SLAVE_APPSS				59
+#define SM8350_SLAVE_CAMERA_CFG				60
+#define SM8350_SLAVE_CLK_CTL				61
+#define SM8350_SLAVE_CDSP_CFG				62
+#define SM8350_SLAVE_RBCPR_CX_CFG			63
+#define SM8350_SLAVE_RBCPR_MMCX_CFG			64
+#define SM8350_SLAVE_RBCPR_MX_CFG			65
+#define SM8350_SLAVE_CRYPTO_0_CFG			66
+#define SM8350_SLAVE_CX_RDPM				67
+#define SM8350_SLAVE_DCC_CFG				68
+#define SM8350_SLAVE_DISPLAY_CFG			69
+#define SM8350_SLAVE_GFX3D_CFG				70
+#define SM8350_SLAVE_HWKM				71
+#define SM8350_SLAVE_IMEM_CFG				72
+#define SM8350_SLAVE_IPA_CFG				73
+#define SM8350_SLAVE_IPC_ROUTER_CFG			74
+#define SM8350_SLAVE_LLCC_CFG				75
+#define SM8350_SLAVE_LPASS				76
+#define SM8350_SLAVE_LPASS_CORE_CFG			77
+#define SM8350_SLAVE_LPASS_LPI_CFG			78
+#define SM8350_SLAVE_LPASS_MPU_CFG			79
+#define SM8350_SLAVE_LPASS_TOP_CFG			80
+#define SM8350_SLAVE_MSS_PROC_MS_MPU_CFG		81
+#define SM8350_SLAVE_MCDMA_MS_MPU_CFG			82
+#define SM8350_SLAVE_CNOC_MSS				83
+#define SM8350_SLAVE_MX_RDPM				84
+#define SM8350_SLAVE_PCIE_0_CFG				85
+#define SM8350_SLAVE_PCIE_1_CFG				86
+#define SM8350_SLAVE_PDM				87
+#define SM8350_SLAVE_PIMEM_CFG				88
+#define SM8350_SLAVE_PKA_WRAPPER_CFG			89
+#define SM8350_SLAVE_PMU_WRAPPER_CFG			90
+#define SM8350_SLAVE_QDSS_CFG				91
+#define SM8350_SLAVE_QSPI_0				92
+#define SM8350_SLAVE_QUP_0				93
+#define SM8350_SLAVE_QUP_1				94
+#define SM8350_SLAVE_QUP_2				95
+#define SM8350_SLAVE_SDCC_2				96
+#define SM8350_SLAVE_SDCC_4				97
+#define SM8350_SLAVE_SECURITY				98
+#define SM8350_SLAVE_SPSS_CFG				99
+#define SM8350_SLAVE_TCSR				100
+#define SM8350_SLAVE_TLMM				101
+#define SM8350_SLAVE_UFS_CARD_CFG			102
+#define SM8350_SLAVE_UFS_MEM_CFG			103
+#define SM8350_SLAVE_USB3_0				104
+#define SM8350_SLAVE_USB3_1				105
+#define SM8350_SLAVE_VENUS_CFG				106
+#define SM8350_SLAVE_VSENSE_CTRL_CFG			107
+#define SM8350_SLAVE_A1NOC_CFG				108
+#define SM8350_SLAVE_A1NOC_SNOC				109
+#define SM8350_SLAVE_A2NOC_CFG				110
+#define SM8350_SLAVE_A2NOC_SNOC				111
+#define SM8350_SLAVE_DDRSS_CFG				112
+#define SM8350_SLAVE_GEM_NOC_CNOC			113
+#define SM8350_SLAVE_GEM_NOC_CFG			114
+#define SM8350_SLAVE_SNOC_GEM_NOC_GC			115
+#define SM8350_SLAVE_SNOC_GEM_NOC_SF			116
+#define SM8350_SLAVE_LLCC				117
+#define SM8350_SLAVE_MNOC_HF_MEM_NOC			118
+#define SM8350_SLAVE_MNOC_SF_MEM_NOC			119
+#define SM8350_SLAVE_CNOC_MNOC_CFG			120
+#define SM8350_SLAVE_CDSP_MEM_NOC			121
+#define SM8350_SLAVE_MEM_NOC_PCIE_SNOC			122
+#define SM8350_SLAVE_ANOC_PCIE_GEM_NOC			123
+#define SM8350_SLAVE_SNOC_CFG				124
+#define SM8350_SLAVE_QUP_CORE_0				125
+#define SM8350_SLAVE_QUP_CORE_1				126
+#define SM8350_SLAVE_QUP_CORE_2				127
+#define SM8350_SLAVE_BOOT_IMEM				128
+#define SM8350_SLAVE_IMEM				129
+#define SM8350_SLAVE_PIMEM				130
+#define SM8350_SLAVE_SERVICE_NSP_NOC			131
+#define SM8350_SLAVE_SERVICE_A1NOC			132
+#define SM8350_SLAVE_SERVICE_A2NOC			133
+#define SM8350_SLAVE_SERVICE_CNOC			134
+#define SM8350_SLAVE_SERVICE_GEM_NOC_1			135
+#define SM8350_SLAVE_SERVICE_MNOC			136
+#define SM8350_SLAVE_SERVICES_LPASS_AML_NOC		137
+#define SM8350_SLAVE_SERVICE_LPASS_AG_NOC		138
+#define SM8350_SLAVE_SERVICE_GEM_NOC_2			139
+#define SM8350_SLAVE_SERVICE_SNOC			140
+#define SM8350_SLAVE_SERVICE_GEM_NOC			141
+#define SM8350_SLAVE_PCIE_0				142
+#define SM8350_SLAVE_PCIE_1				143
+#define SM8350_SLAVE_QDSS_STM				144
+#define SM8350_SLAVE_TCU				145
+#define SM8350_MASTER_LLCC_DISP				146
+#define SM8350_MASTER_MNOC_HF_MEM_NOC_DISP		147
+#define SM8350_MASTER_MNOC_SF_MEM_NOC_DISP		148
+#define SM8350_MASTER_MDP0_DISP				149
+#define SM8350_MASTER_MDP1_DISP				150
+#define SM8350_MASTER_ROTATOR_DISP			151
+#define SM8350_SLAVE_EBI1_DISP				152
+#define SM8350_SLAVE_LLCC_DISP				153
+#define SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP		154
+#define SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP		155
+
+#endif
--=20
2.26.3

