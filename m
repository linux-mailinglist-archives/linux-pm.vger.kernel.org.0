Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB221DA6A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgGMPnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbgGMPm7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:42:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD9C061794
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so12622349qkg.5
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4g6rQQ8hg12uzTo/V7M20L95nit3v8kP1DX57+u+hk=;
        b=XGrNZaC5+q2+QxbN+ardcTOrQkokc+cFEcW9InLWmQ0EeEMHztGcAst4X6srwRzhjQ
         TaQGXM499jbXKI6JjOk3t4v5n8J93R6EtOvlimvGWa4EYnH4LFO8vSKdQb0TFiM6RJLN
         JFpuMT2M+IYNXinbVUsm85j/L7x7YaXje7wXH2OerDStiFvOATIk46E3ysRd9DgdjdFV
         hcrRLAae3flumJrnDB3mM/XeZMPY7JPRHJlGnBDv2SNq4uLUneyY4Y6u/w8mBERBF6+c
         bbNHZ7/wxIWgWnXTZ1GecLuxWhx67vUiFgHGLXYYOA9qMplHMKifM4PO2n389IBgsIqd
         g7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4g6rQQ8hg12uzTo/V7M20L95nit3v8kP1DX57+u+hk=;
        b=NX5fHxtrnQg3l+FuHnF4T1wcZEPpnO0+/l60jqqsjYx/5aAWJBlQQJT1O+DmWzsyHd
         /93HLdy7qOE6NIJWhMQxlv+rc94hN8jMyvNsX8pBAxcbwMcExQ3ixQDJrhc4CNjhVLth
         3+aIIbVaBaosvJsIxwukqfaqeGv3Ys3yqgVK21JZPovEF81Q402OC2gT8+JuXAMZmAFH
         nf7MGH0LJipMuhgMRsrUG3limmYbbT8IyS18+JQGkMxw6TBs/U9GVidPkQJrSpH2HsC4
         vjV2Vt2and+JzglfuGspABUB9jSS2t3+S9bvaqNIVVB0ZrH9Dt6vvAifxm5VGujhrJms
         YzEA==
X-Gm-Message-State: AOAM532H9wJ/yq0RqpfVsglCBe3CLUylEnnp9kK2METJS/1+E3EFaFel
        qvVmo754sUdTZWUFyHHbqjGHWw==
X-Google-Smtp-Source: ABdhPJzSOl0zH+mfAPGaqNEL1vlM8+AeikW7WaYZi80wngbp6LsikrrvXxOxUgbIlOspuA1NXPFtgA==
X-Received: by 2002:a37:9e11:: with SMTP id h17mr151752qke.347.1594654977794;
        Mon, 13 Jul 2020 08:42:57 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l1sm19806371qtk.18.2020.07.13.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:42:57 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:INTERCONNECT API)
Subject: [PATCH v2 5/7] interconnect: qcom: Add SM8250 interconnect provider driver
Date:   Mon, 13 Jul 2020 11:41:14 -0400
Message-Id: <20200713154121.22094-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713154121.22094-1-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SM8250 based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Based on SC7180 driver and generated from downstream dts.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/interconnect/qcom/Kconfig  |  10 +
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/sm8250.c | 655 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8250.h | 163 +++++++
 4 files changed, 830 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8250.c
 create mode 100644 drivers/interconnect/qcom/sm8250.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index 25486de5a38d..a8f93ba265f8 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -75,5 +75,15 @@ config INTERCONNECT_QCOM_SM8150
 	  This is a driver for the Qualcomm Network-on-Chip on sm8150-based
 	  platforms.
=20
+config INTERCONNECT_QCOM_SM8250
+	tristate "Qualcomm SM8250 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SMD_RPM
 	tristate
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index 1702ece67dc5..cf628f7990cd 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -9,6 +9,7 @@ icc-rpmh-obj				:=3D icc-rpmh.o
 qnoc-sc7180-objs			:=3D sc7180.o
 qnoc-sdm845-objs			:=3D sdm845.o
 qnoc-sm8150-objs			:=3D sm8150.o
+qnoc-sm8250-objs			:=3D sm8250.o
 icc-smd-rpm-objs			:=3D smd-rpm.o
=20
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-voter.o
@@ -20,4 +21,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) +=3D icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) +=3D qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) +=3D icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom=
/sm8250.c
new file mode 100644
index 000000000000..8e63c19e01c0
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sm8250.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sm8250.h"
+
+DEFINE_QNODE(qhm_a1noc_cfg, SM8250_MASTER_A1NOC_CFG, 1, 4, SM8250_SLAVE_SE=
RVICE_A1NOC);
+DEFINE_QNODE(qhm_qspi, SM8250_MASTER_QSPI_0, 1, 4, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(qhm_qup1, SM8250_MASTER_QUP_1, 1, 4, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(qhm_qup2, SM8250_MASTER_QUP_2, 1, 4, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(qhm_tsif, SM8250_MASTER_TSIF, 1, 4, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(xm_pcie3_modem, SM8250_MASTER_PCIE_2, 1, 8, SM8250_SLAVE_ANOC=
_PCIE_GEM_NOC_1);
+DEFINE_QNODE(xm_sdc4, SM8250_MASTER_SDCC_4, 1, 8, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(xm_ufs_mem, SM8250_MASTER_UFS_MEM, 1, 8, SM8250_A1NOC_SNOC_SL=
V);
+DEFINE_QNODE(xm_usb3_0, SM8250_MASTER_USB3, 1, 8, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(xm_usb3_1, SM8250_MASTER_USB3_1, 1, 8, SM8250_A1NOC_SNOC_SLV);
+DEFINE_QNODE(qhm_a2noc_cfg, SM8250_MASTER_A2NOC_CFG, 1, 4, SM8250_SLAVE_SE=
RVICE_A2NOC);
+DEFINE_QNODE(qhm_qdss_bam, SM8250_MASTER_QDSS_BAM, 1, 4, SM8250_A2NOC_SNOC=
_SLV);
+DEFINE_QNODE(qhm_qup0, SM8250_MASTER_QUP_0, 1, 4, SM8250_A2NOC_SNOC_SLV);
+DEFINE_QNODE(qnm_cnoc, SM8250_MASTER_CNOC_A2NOC, 1, 8, SM8250_A2NOC_SNOC_S=
LV);
+DEFINE_QNODE(qxm_crypto, SM8250_MASTER_CRYPTO_CORE_0, 1, 8, SM8250_A2NOC_S=
NOC_SLV);
+DEFINE_QNODE(qxm_ipa, SM8250_MASTER_IPA, 1, 8, SM8250_A2NOC_SNOC_SLV);
+DEFINE_QNODE(xm_pcie3_0, SM8250_MASTER_PCIE, 1, 8, SM8250_SLAVE_ANOC_PCIE_=
GEM_NOC);
+DEFINE_QNODE(xm_pcie3_1, SM8250_MASTER_PCIE_1, 1, 8, SM8250_SLAVE_ANOC_PCI=
E_GEM_NOC);
+DEFINE_QNODE(xm_qdss_etr, SM8250_MASTER_QDSS_ETR, 1, 8, SM8250_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(xm_sdc2, SM8250_MASTER_SDCC_2, 1, 8, SM8250_A2NOC_SNOC_SLV);
+DEFINE_QNODE(xm_ufs_card, SM8250_MASTER_UFS_CARD, 1, 8, SM8250_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(qnm_npu, SM8250_MASTER_NPU, 2, 32, SM8250_SLAVE_CDSP_MEM_NOC);
+DEFINE_QNODE(qnm_snoc, SM8250_SNOC_CNOC_MAS, 1, 8, SM8250_SLAVE_CDSP_CFG, =
SM8250_SLAVE_CAMERA_CFG, SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NORTH, =
SM8250_SLAVE_SDCC_4, SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2, SM8250_SL=
AVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG, SM8250_SLAVE_SNOC_CFG, SM8250_=
SLAVE_PDM, SM8250_SLAVE_CX_RDPM, SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE_A2NO=
C_CFG, SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG, SM8250_SLAVE_PCIE_2=
_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG, SM8250_SLAVE_CNOC_DDRSS, SM8=
250_SLAVE_IPC_ROUTER_CFG, SM8250_SLAVE_PCIE_0_CFG, SM8250_SLAVE_RBCPR_MMCX_=
CFG, SM8250_SLAVE_NPU_CFG, SM8250_SLAVE_AHB2PHY_SOUTH, SM8250_SLAVE_AHB2PHY=
_NORTH, SM8250_SLAVE_GRAPHICS_3D_CFG, SM8250_SLAVE_VENUS_CFG, SM8250_SLAVE_=
TSIF, SM8250_SLAVE_IPA_CFG, SM8250_SLAVE_IMEM_CFG, SM8250_SLAVE_USB3, SM825=
0_SLAVE_SERVICE_CNOC, SM8250_SLAVE_UFS_CARD_CFG, SM8250_SLAVE_USB3_1, SM825=
0_SLAVE_LPASS, SM8250_SLAVE_RBCPR_CX_CFG, SM8250_SLAVE_A1NOC_CFG, SM8250_SL=
AVE_AOSS, SM8250_SLAVE_PRNG, SM8250_SLAVE_VSENSE_CTRL_CFG, SM8250_SLAVE_QSP=
I_0, SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_PIMEM_CFG, SM8250_SLAVE_RBCPR_=
MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_1, SM8250_SLAVE_QUP_2, SM8250_=
SLAVE_CLK_CTL);
+DEFINE_QNODE(xm_qdss_dap, SM8250_MASTER_QDSS_DAP, 1, 8, SM8250_SLAVE_CDSP_=
CFG, SM8250_SLAVE_CAMERA_CFG, SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NO=
RTH, SM8250_SLAVE_SDCC_4, SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2, SM82=
50_SLAVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG, SM8250_SLAVE_SNOC_CFG, SM=
8250_SLAVE_PDM, SM8250_SLAVE_CX_RDPM, SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE=
_A2NOC_CFG, SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG, SM8250_SLAVE_P=
CIE_2_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG, SM8250_SLAVE_CNOC_DDRSS=
, SM8250_SLAVE_IPC_ROUTER_CFG, SM8250_SLAVE_CNOC_A2NOC, SM8250_SLAVE_PCIE_0=
_CFG, SM8250_SLAVE_RBCPR_MMCX_CFG, SM8250_SLAVE_NPU_CFG, SM8250_SLAVE_AHB2P=
HY_SOUTH, SM8250_SLAVE_AHB2PHY_NORTH, SM8250_SLAVE_GRAPHICS_3D_CFG, SM8250_=
SLAVE_VENUS_CFG, SM8250_SLAVE_TSIF, SM8250_SLAVE_IPA_CFG, SM8250_SLAVE_IMEM=
_CFG, SM8250_SLAVE_USB3, SM8250_SLAVE_SERVICE_CNOC, SM8250_SLAVE_UFS_CARD_C=
FG, SM8250_SLAVE_USB3_1, SM8250_SLAVE_LPASS, SM8250_SLAVE_RBCPR_CX_CFG, SM8=
250_SLAVE_A1NOC_CFG, SM8250_SLAVE_AOSS, SM8250_SLAVE_PRNG, SM8250_SLAVE_VSE=
NSE_CTRL_CFG, SM8250_SLAVE_QSPI_0, SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_=
PIMEM_CFG, SM8250_SLAVE_RBCPR_MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_=
1, SM8250_SLAVE_QUP_2, SM8250_SLAVE_CLK_CTL);
+DEFINE_QNODE(qhm_cnoc_dc_noc, SM8250_MASTER_CNOC_DC_NOC, 1, 4, SM8250_SLAV=
E_GEM_NOC_CFG, SM8250_SLAVE_LLCC_CFG);
+DEFINE_QNODE(alm_gpu_tcu, SM8250_MASTER_GPU_TCU, 1, 8, SM8250_SLAVE_LLCC, =
SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(alm_sys_tcu, SM8250_MASTER_SYS_TCU, 1, 8, SM8250_SLAVE_LLCC, =
SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(chm_apps, SM8250_MASTER_AMPSS_M0, 2, 32, SM8250_SLAVE_LLCC, S=
M8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhm_gemnoc_cfg, SM8250_MASTER_GEM_NOC_CFG, 1, 4, SM8250_SLAVE=
_SERVICE_GEM_NOC_2, SM8250_SLAVE_SERVICE_GEM_NOC_1, SM8250_SLAVE_SERVICE_GE=
M_NOC);
+DEFINE_QNODE(qnm_cmpnoc, SM8250_MASTER_COMPUTE_NOC, 2, 32, SM8250_SLAVE_LL=
CC, SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_gpu, SM8250_MASTER_GRAPHICS_3D, 2, 32, SM8250_SLAVE_LLCC,=
 SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_mnoc_hf, SM8250_MASTER_MNOC_HF_MEM_NOC, 2, 32, SM8250_SLA=
VE_LLCC);
+DEFINE_QNODE(qnm_mnoc_sf, SM8250_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8250_SLA=
VE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_pcie, SM8250_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8250_SLAV=
E_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(qnm_snoc_gc, SM8250_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8250_SLAV=
E_LLCC);
+DEFINE_QNODE(qnm_snoc_sf, SM8250_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8250_SLA=
VE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(ipa_core_master, SM8250_MASTER_IPA_CORE, 1, 8, SM8250_SLAVE_I=
PA_CORE);
+DEFINE_QNODE(llcc_mc, SM8250_MASTER_LLCC, 4, 4, SM8250_SLAVE_EBI_CH0);
+DEFINE_QNODE(qhm_mnoc_cfg, SM8250_MASTER_CNOC_MNOC_CFG, 1, 4, SM8250_SLAVE=
_SERVICE_MNOC);
+DEFINE_QNODE(qnm_camnoc_hf, SM8250_MASTER_CAMNOC_HF, 2, 32, SM8250_SLAVE_M=
NOC_HF_MEM_NOC);
+DEFINE_QNODE(qnm_camnoc_icp, SM8250_MASTER_CAMNOC_ICP, 1, 8, SM8250_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qnm_camnoc_sf, SM8250_MASTER_CAMNOC_SF, 2, 32, SM8250_SLAVE_M=
NOC_SF_MEM_NOC);
+DEFINE_QNODE(qnm_video0, SM8250_MASTER_VIDEO_P0, 1, 32, SM8250_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qnm_video1, SM8250_MASTER_VIDEO_P1, 1, 32, SM8250_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qnm_video_cvp, SM8250_MASTER_VIDEO_PROC, 1, 32, SM8250_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_mdp0, SM8250_MASTER_MDP_PORT0, 1, 32, SM8250_SLAVE_MNOC_H=
F_MEM_NOC);
+DEFINE_QNODE(qxm_mdp1, SM8250_MASTER_MDP_PORT1, 1, 32, SM8250_SLAVE_MNOC_H=
F_MEM_NOC);
+DEFINE_QNODE(qxm_rot, SM8250_MASTER_ROTATOR, 1, 32, SM8250_SLAVE_MNOC_SF_M=
EM_NOC);
+DEFINE_QNODE(amm_npu_sys, SM8250_MASTER_NPU_SYS, 4, 32, SM8250_SLAVE_NPU_C=
OMPUTE_NOC);
+DEFINE_QNODE(amm_npu_sys_cdp_w, SM8250_MASTER_NPU_CDP, 2, 16, SM8250_SLAVE=
_NPU_COMPUTE_NOC);
+DEFINE_QNODE(qhm_cfg, SM8250_MASTER_NPU_NOC_CFG, 1, 4, SM8250_SLAVE_SERVIC=
E_NPU_NOC, SM8250_SLAVE_ISENSE_CFG, SM8250_SLAVE_NPU_LLM_CFG, SM8250_SLAVE_=
NPU_INT_DMA_BWMON_CFG, SM8250_SLAVE_NPU_CP, SM8250_SLAVE_NPU_TCM, SM8250_SL=
AVE_NPU_CAL_DP0, SM8250_SLAVE_NPU_CAL_DP1, SM8250_SLAVE_NPU_DPM);
+DEFINE_QNODE(qhm_snoc_cfg, SM8250_MASTER_SNOC_CFG, 1, 4, SM8250_SLAVE_SERV=
ICE_SNOC);
+DEFINE_QNODE(qnm_aggre1_noc, SM8250_A1NOC_SNOC_MAS, 1, 16, SM8250_SLAVE_SN=
OC_GEM_NOC_SF);
+DEFINE_QNODE(qnm_aggre2_noc, SM8250_A2NOC_SNOC_MAS, 1, 16, SM8250_SLAVE_SN=
OC_GEM_NOC_SF);
+DEFINE_QNODE(qnm_gemnoc, SM8250_MASTER_GEM_NOC_SNOC, 1, 16, SM8250_SLAVE_P=
IMEM, SM8250_SLAVE_OCIMEM, SM8250_SLAVE_APPSS, SM8250_SNOC_CNOC_SLV, SM8250=
_SLAVE_TCU, SM8250_SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_gemnoc_pcie, SM8250_MASTER_GEM_NOC_PCIE_SNOC, 1, 8, SM825=
0_SLAVE_PCIE_2, SM8250_SLAVE_PCIE_0, SM8250_SLAVE_PCIE_1);
+DEFINE_QNODE(qxm_pimem, SM8250_MASTER_PIMEM, 1, 8, SM8250_SLAVE_SNOC_GEM_N=
OC_GC);
+DEFINE_QNODE(xm_gic, SM8250_MASTER_GIC, 1, 8, SM8250_SLAVE_SNOC_GEM_NOC_GC=
);
+DEFINE_QNODE(alc, SM8250_MASTER_ALC, 1, 1);
+DEFINE_QNODE(qns_a1noc_snoc, SM8250_A1NOC_SNOC_SLV, 1, 16, SM8250_A1NOC_SN=
OC_MAS);
+DEFINE_QNODE(qns_pcie_modem_mem_noc, SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1, 1, =
16, SM8250_MASTER_ANOC_PCIE_GEM_NOC);
+DEFINE_QNODE(srvc_aggre1_noc, SM8250_SLAVE_SERVICE_A1NOC, 1, 4);
+DEFINE_QNODE(qns_a2noc_snoc, SM8250_A2NOC_SNOC_SLV, 1, 16, SM8250_A2NOC_SN=
OC_MAS);
+DEFINE_QNODE(qns_pcie_mem_noc, SM8250_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16, SM82=
50_MASTER_ANOC_PCIE_GEM_NOC);
+DEFINE_QNODE(srvc_aggre2_noc, SM8250_SLAVE_SERVICE_A2NOC, 1, 4);
+DEFINE_QNODE(qns_cdsp_mem_noc, SM8250_SLAVE_CDSP_MEM_NOC, 2, 32, SM8250_MA=
STER_COMPUTE_NOC);
+DEFINE_QNODE(qhs_a1_noc_cfg, SM8250_SLAVE_A1NOC_CFG, 1, 4, SM8250_MASTER_A=
1NOC_CFG);
+DEFINE_QNODE(qhs_a2_noc_cfg, SM8250_SLAVE_A2NOC_CFG, 1, 4, SM8250_MASTER_A=
2NOC_CFG);
+DEFINE_QNODE(qhs_ahb2phy0, SM8250_SLAVE_AHB2PHY_SOUTH, 1, 4);
+DEFINE_QNODE(qhs_ahb2phy1, SM8250_SLAVE_AHB2PHY_NORTH, 1, 4);
+DEFINE_QNODE(qhs_aoss, SM8250_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_camera_cfg, SM8250_SLAVE_CAMERA_CFG, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SM8250_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_compute_dsp, SM8250_SLAVE_CDSP_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_cx, SM8250_SLAVE_RBCPR_CX_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_mmcx, SM8250_SLAVE_RBCPR_MMCX_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_mx, SM8250_SLAVE_RBCPR_MX_CFG, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SM8250_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_cx_rdpm, SM8250_SLAVE_CX_RDPM, 1, 4);
+DEFINE_QNODE(qhs_dcc_cfg, SM8250_SLAVE_DCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_ddrss_cfg, SM8250_SLAVE_CNOC_DDRSS, 1, 4, SM8250_MASTER_C=
NOC_DC_NOC);
+DEFINE_QNODE(qhs_display_cfg, SM8250_SLAVE_DISPLAY_CFG, 1, 4);
+DEFINE_QNODE(qhs_gpuss_cfg, SM8250_SLAVE_GRAPHICS_3D_CFG, 1, 8);
+DEFINE_QNODE(qhs_imem_cfg, SM8250_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SM8250_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipc_router, SM8250_SLAVE_IPC_ROUTER_CFG, 1, 4);
+DEFINE_QNODE(qhs_lpass_cfg, SM8250_SLAVE_LPASS, 1, 4);
+DEFINE_QNODE(qhs_mnoc_cfg, SM8250_SLAVE_CNOC_MNOC_CFG, 1, 4, SM8250_MASTER=
_CNOC_MNOC_CFG);
+DEFINE_QNODE(qhs_npu_cfg, SM8250_SLAVE_NPU_CFG, 1, 4, SM8250_MASTER_NPU_NO=
C_CFG);
+DEFINE_QNODE(qhs_pcie0_cfg, SM8250_SLAVE_PCIE_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_pcie1_cfg, SM8250_SLAVE_PCIE_1_CFG, 1, 4);
+DEFINE_QNODE(qhs_pcie_modem_cfg, SM8250_SLAVE_PCIE_2_CFG, 1, 4);
+DEFINE_QNODE(qhs_pdm, SM8250_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_pimem_cfg, SM8250_SLAVE_PIMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_prng, SM8250_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SM8250_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qspi, SM8250_SLAVE_QSPI_0, 1, 4);
+DEFINE_QNODE(qhs_qup0, SM8250_SLAVE_QUP_0, 1, 4);
+DEFINE_QNODE(qhs_qup1, SM8250_SLAVE_QUP_1, 1, 4);
+DEFINE_QNODE(qhs_qup2, SM8250_SLAVE_QUP_2, 1, 4);
+DEFINE_QNODE(qhs_sdc2, SM8250_SLAVE_SDCC_2, 1, 4);
+DEFINE_QNODE(qhs_sdc4, SM8250_SLAVE_SDCC_4, 1, 4);
+DEFINE_QNODE(qhs_snoc_cfg, SM8250_SLAVE_SNOC_CFG, 1, 4, SM8250_MASTER_SNOC=
_CFG);
+DEFINE_QNODE(qhs_tcsr, SM8250_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_tlmm0, SM8250_SLAVE_TLMM_NORTH, 1, 4);
+DEFINE_QNODE(qhs_tlmm1, SM8250_SLAVE_TLMM_SOUTH, 1, 4);
+DEFINE_QNODE(qhs_tlmm2, SM8250_SLAVE_TLMM_WEST, 1, 4);
+DEFINE_QNODE(qhs_tsif, SM8250_SLAVE_TSIF, 1, 4);
+DEFINE_QNODE(qhs_ufs_card_cfg, SM8250_SLAVE_UFS_CARD_CFG, 1, 4);
+DEFINE_QNODE(qhs_ufs_mem_cfg, SM8250_SLAVE_UFS_MEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_usb3_0, SM8250_SLAVE_USB3, 1, 4);
+DEFINE_QNODE(qhs_usb3_1, SM8250_SLAVE_USB3_1, 1, 4);
+DEFINE_QNODE(qhs_venus_cfg, SM8250_SLAVE_VENUS_CFG, 1, 4);
+DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8250_SLAVE_VSENSE_CTRL_CFG, 1, 4);
+DEFINE_QNODE(qns_cnoc_a2noc, SM8250_SLAVE_CNOC_A2NOC, 1, 8, SM8250_MASTER_=
CNOC_A2NOC);
+DEFINE_QNODE(srvc_cnoc, SM8250_SLAVE_SERVICE_CNOC, 1, 4);
+DEFINE_QNODE(qhs_llcc, SM8250_SLAVE_LLCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_memnoc, SM8250_SLAVE_GEM_NOC_CFG, 1, 4, SM8250_MASTER_GEM=
_NOC_CFG);
+DEFINE_QNODE(qns_gem_noc_snoc, SM8250_SLAVE_GEM_NOC_SNOC, 1, 16, SM8250_MA=
STER_GEM_NOC_SNOC);
+DEFINE_QNODE(qns_llcc, SM8250_SLAVE_LLCC, 4, 16, SM8250_MASTER_LLCC);
+DEFINE_QNODE(qns_sys_pcie, SM8250_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SM8250_MA=
STER_GEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(srvc_even_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
+DEFINE_QNODE(srvc_odd_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
+DEFINE_QNODE(srvc_sys_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC, 1, 4);
+DEFINE_QNODE(ipa_core_slave, SM8250_SLAVE_IPA_CORE, 1, 8);
+DEFINE_QNODE(ebi, SM8250_SLAVE_EBI_CH0, 4, 4);
+DEFINE_QNODE(qns_mem_noc_hf, SM8250_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8250_M=
ASTER_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(qns_mem_noc_sf, SM8250_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8250_M=
ASTER_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(srvc_mnoc, SM8250_SLAVE_SERVICE_MNOC, 1, 4);
+DEFINE_QNODE(qhs_cal_dp0, SM8250_SLAVE_NPU_CAL_DP0, 1, 4);
+DEFINE_QNODE(qhs_cal_dp1, SM8250_SLAVE_NPU_CAL_DP1, 1, 4);
+DEFINE_QNODE(qhs_cp, SM8250_SLAVE_NPU_CP, 1, 4);
+DEFINE_QNODE(qhs_dma_bwmon, SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
+DEFINE_QNODE(qhs_dpm, SM8250_SLAVE_NPU_DPM, 1, 4);
+DEFINE_QNODE(qhs_isense, SM8250_SLAVE_ISENSE_CFG, 1, 4);
+DEFINE_QNODE(qhs_llm, SM8250_SLAVE_NPU_LLM_CFG, 1, 4);
+DEFINE_QNODE(qhs_tcm, SM8250_SLAVE_NPU_TCM, 1, 4);
+DEFINE_QNODE(qns_npu_sys, SM8250_SLAVE_NPU_COMPUTE_NOC, 2, 32);
+DEFINE_QNODE(srvc_noc, SM8250_SLAVE_SERVICE_NPU_NOC, 1, 4);
+DEFINE_QNODE(qhs_apss, SM8250_SLAVE_APPSS, 1, 8);
+DEFINE_QNODE(qns_cnoc, SM8250_SNOC_CNOC_SLV, 1, 8, SM8250_SNOC_CNOC_MAS);
+DEFINE_QNODE(qns_gemnoc_gc, SM8250_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM8250_MAS=
TER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qns_gemnoc_sf, SM8250_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM8250_MA=
STER_SNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxs_imem, SM8250_SLAVE_OCIMEM, 1, 8);
+DEFINE_QNODE(qxs_pimem, SM8250_SLAVE_PIMEM, 1, 8);
+DEFINE_QNODE(srvc_snoc, SM8250_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(xs_pcie_0, SM8250_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(xs_pcie_1, SM8250_SLAVE_PCIE_1, 1, 8);
+DEFINE_QNODE(xs_pcie_modem, SM8250_SLAVE_PCIE_2, 1, 8);
+DEFINE_QNODE(xs_qdss_stm, SM8250_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SM8250_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
+DEFINE_QBCM(bcm_alc, "ALC", false, &alc);
+DEFINE_QBCM(bcm_mc0, "MC0", false, &ebi);
+DEFINE_QBCM(bcm_sh0, "SH0", false, &qns_llcc);
+DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
+DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
+DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
+DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
+DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup1, &qhm_qup2, &qhm_qup0);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
+DEFINE_QBCM(bcm_mm3, "MM3", false, &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_v=
ideo0, &qnm_video1, &qnm_video_cvp);
+DEFINE_QBCM(bcm_sh4, "SH4", false, &chm_apps);
+DEFINE_QBCM(bcm_sn0, "SN0", false, &qns_gemnoc_sf);
+DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
+DEFINE_QBCM(bcm_cn0, "CN0", false, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cf=
g, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_ahb2phy1, &qhs_aoss, &qhs_camera_cf=
g, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx,=
 &qhs_crypto0_cfg, &qhs_cx_rdpm, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display=
_cfg, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_ipc_router, &qhs_lpass_=
cfg, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_pcie=
_modem_cfg, &qhs_pdm, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, =
&qhs_qup0, &qhs_qup1, &qhs_qup2, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_=
tcsr, &qhs_tlmm0, &qhs_tlmm1, &qhs_tlmm2, &qhs_tsif, &qhs_ufs_card_cfg, &qh=
s_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_c=
fg, &qns_cnoc_a2noc, &srvc_cnoc);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
+DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie_modem);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie_0, &xs_pcie_1);
+DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_aggre2_noc);
+DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_gemnoc_pcie);
+DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_gemnoc);
+DEFINE_QBCM(bcm_sn12, "SN12", false, &qns_pcie_modem_mem_noc, &qns_pcie_me=
m_noc);
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] =3D {
+	&bcm_qup0,
+	&bcm_sn12,
+};
+
+static struct qcom_icc_node *aggre1_noc_nodes[] =3D {
+	[MASTER_A1NOC_CFG] =3D &qhm_a1noc_cfg,
+	[MASTER_QSPI_0] =3D &qhm_qspi,
+	[MASTER_QUP_1] =3D &qhm_qup1,
+	[MASTER_QUP_2] =3D &qhm_qup2,
+	[MASTER_TSIF] =3D &qhm_tsif,
+	[MASTER_PCIE_2] =3D &xm_pcie3_modem,
+	[MASTER_SDCC_4] =3D &xm_sdc4,
+	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
+	[MASTER_USB3] =3D &xm_usb3_0,
+	[MASTER_USB3_1] =3D &xm_usb3_1,
+	[A1NOC_SNOC_SLV] =3D &qns_a1noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC_1] =3D &qns_pcie_modem_mem_noc,
+	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
+};
+
+static struct qcom_icc_desc sm8250_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm *aggre2_noc_bcms[] =3D {
+	&bcm_ce0,
+	&bcm_qup0,
+	&bcm_sn12,
+};
+
+static struct qcom_icc_node *aggre2_noc_nodes[] =3D {
+	[MASTER_A2NOC_CFG] =3D &qhm_a2noc_cfg,
+	[MASTER_QDSS_BAM] =3D &qhm_qdss_bam,
+	[MASTER_QUP_0] =3D &qhm_qup0,
+	[MASTER_CNOC_A2NOC] =3D &qnm_cnoc,
+	[MASTER_CRYPTO_CORE_0] =3D &qxm_crypto,
+	[MASTER_IPA] =3D &qxm_ipa,
+	[MASTER_PCIE] =3D &xm_pcie3_0,
+	[MASTER_PCIE_1] =3D &xm_pcie3_1,
+	[MASTER_QDSS_ETR] =3D &xm_qdss_etr,
+	[MASTER_SDCC_2] =3D &xm_sdc2,
+	[MASTER_UFS_CARD] =3D &xm_ufs_card,
+	[A2NOC_SNOC_SLV] =3D &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] =3D &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
+};
+
+static struct qcom_icc_desc sm8250_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm *compute_noc_bcms[] =3D {
+	&bcm_co0,
+	&bcm_co2,
+};
+
+static struct qcom_icc_node *compute_noc_nodes[] =3D {
+	[MASTER_NPU] =3D &qnm_npu,
+	[SLAVE_CDSP_MEM_NOC] =3D &qns_cdsp_mem_noc,
+};
+
+static struct qcom_icc_desc sm8250_compute_noc =3D {
+	.nodes =3D compute_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(compute_noc_nodes),
+	.bcms =3D compute_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(compute_noc_bcms),
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] =3D {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] =3D {
+	[SNOC_CNOC_MAS] =3D &qnm_snoc,
+	[MASTER_QDSS_DAP] =3D &xm_qdss_dap,
+	[SLAVE_A1NOC_CFG] =3D &qhs_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] =3D &qhs_a2_noc_cfg,
+	[SLAVE_AHB2PHY_SOUTH] =3D &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] =3D &qhs_ahb2phy1,
+	[SLAVE_AOSS] =3D &qhs_aoss,
+	[SLAVE_CAMERA_CFG] =3D &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] =3D &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] =3D &qhs_compute_dsp,
+	[SLAVE_RBCPR_CX_CFG] =3D &qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] =3D &qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MX_CFG] =3D &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] =3D &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] =3D &qhs_cx_rdpm,
+	[SLAVE_DCC_CFG] =3D &qhs_dcc_cfg,
+	[SLAVE_CNOC_DDRSS] =3D &qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] =3D &qhs_display_cfg,
+	[SLAVE_GRAPHICS_3D_CFG] =3D &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] =3D &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] =3D &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] =3D &qhs_ipc_router,
+	[SLAVE_LPASS] =3D &qhs_lpass_cfg,
+	[SLAVE_CNOC_MNOC_CFG] =3D &qhs_mnoc_cfg,
+	[SLAVE_NPU_CFG] =3D &qhs_npu_cfg,
+	[SLAVE_PCIE_0_CFG] =3D &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] =3D &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] =3D &qhs_pcie_modem_cfg,
+	[SLAVE_PDM] =3D &qhs_pdm,
+	[SLAVE_PIMEM_CFG] =3D &qhs_pimem_cfg,
+	[SLAVE_PRNG] =3D &qhs_prng,
+	[SLAVE_QDSS_CFG] =3D &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] =3D &qhs_qspi,
+	[SLAVE_QUP_0] =3D &qhs_qup0,
+	[SLAVE_QUP_1] =3D &qhs_qup1,
+	[SLAVE_QUP_2] =3D &qhs_qup2,
+	[SLAVE_SDCC_2] =3D &qhs_sdc2,
+	[SLAVE_SDCC_4] =3D &qhs_sdc4,
+	[SLAVE_SNOC_CFG] =3D &qhs_snoc_cfg,
+	[SLAVE_TCSR] =3D &qhs_tcsr,
+	[SLAVE_TLMM_NORTH] =3D &qhs_tlmm0,
+	[SLAVE_TLMM_SOUTH] =3D &qhs_tlmm1,
+	[SLAVE_TLMM_WEST] =3D &qhs_tlmm2,
+	[SLAVE_TSIF] =3D &qhs_tsif,
+	[SLAVE_UFS_CARD_CFG] =3D &qhs_ufs_card_cfg,
+	[SLAVE_UFS_MEM_CFG] =3D &qhs_ufs_mem_cfg,
+	[SLAVE_USB3] =3D &qhs_usb3_0,
+	[SLAVE_USB3_1] =3D &qhs_usb3_1,
+	[SLAVE_VENUS_CFG] =3D &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] =3D &qhs_vsense_ctrl_cfg,
+	[SLAVE_CNOC_A2NOC] =3D &qns_cnoc_a2noc,
+	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
+};
+
+static struct qcom_icc_desc sm8250_config_noc =3D {
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
+	[MASTER_CNOC_DC_NOC] =3D &qhm_cnoc_dc_noc,
+	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
+	[SLAVE_GEM_NOC_CFG] =3D &qhs_memnoc,
+};
+
+static struct qcom_icc_desc sm8250_dc_noc =3D {
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
+};
+
+static struct qcom_icc_node *gem_noc_nodes[] =3D {
+	[MASTER_GPU_TCU] =3D &alm_gpu_tcu,
+	[MASTER_SYS_TCU] =3D &alm_sys_tcu,
+	[MASTER_AMPSS_M0] =3D &chm_apps,
+	[MASTER_GEM_NOC_CFG] =3D &qhm_gemnoc_cfg,
+	[MASTER_COMPUTE_NOC] =3D &qnm_cmpnoc,
+	[MASTER_GRAPHICS_3D] =3D &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] =3D &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
+	[MASTER_ANOC_PCIE_GEM_NOC] =3D &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_SNOC] =3D &qns_gem_noc_snoc,
+	[SLAVE_LLCC] =3D &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] =3D &qns_sys_pcie,
+	[SLAVE_SERVICE_GEM_NOC_1] =3D &srvc_even_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC_2] =3D &srvc_odd_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC] =3D &srvc_sys_gemnoc,
+};
+
+static struct qcom_icc_desc sm8250_gem_noc =3D {
+	.nodes =3D gem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gem_noc_nodes),
+	.bcms =3D gem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *ipa_virt_bcms[] =3D {
+	&bcm_ip0,
+};
+
+static struct qcom_icc_node *ipa_virt_nodes[] =3D {
+	[MASTER_IPA_CORE] =3D &ipa_core_master,
+	[SLAVE_IPA_CORE] =3D &ipa_core_slave,
+};
+
+static struct qcom_icc_desc sm8250_ipa_virt =3D {
+	.nodes =3D ipa_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(ipa_virt_nodes),
+	.bcms =3D ipa_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(ipa_virt_bcms),
+};
+
+static struct qcom_icc_bcm *mc_virt_bcms[] =3D {
+	&bcm_acv,
+	&bcm_alc,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] =3D {
+	[MASTER_LLCC] =3D &llcc_mc,
+	[MASTER_ALC] =3D &alc,
+	[SLAVE_EBI_CH0] =3D &ebi,
+};
+
+static struct qcom_icc_desc sm8250_mc_virt =3D {
+	.nodes =3D mc_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(mc_virt_nodes),
+	.bcms =3D mc_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] =3D {
+	[MASTER_CNOC_MNOC_CFG] =3D &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF] =3D &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] =3D &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] =3D &qnm_camnoc_sf,
+	[MASTER_VIDEO_P0] =3D &qnm_video0,
+	[MASTER_VIDEO_P1] =3D &qnm_video1,
+	[MASTER_VIDEO_PROC] =3D &qnm_video_cvp,
+	[MASTER_MDP_PORT0] =3D &qxm_mdp0,
+	[MASTER_MDP_PORT1] =3D &qxm_mdp1,
+	[MASTER_ROTATOR] =3D &qxm_rot,
+	[SLAVE_MNOC_HF_MEM_NOC] =3D &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] =3D &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
+};
+
+static struct qcom_icc_desc sm8250_mmss_noc =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm *npu_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *npu_noc_nodes[] =3D {
+	[MASTER_NPU_SYS] =3D &amm_npu_sys,
+	[MASTER_NPU_CDP] =3D &amm_npu_sys_cdp_w,
+	[MASTER_NPU_NOC_CFG] =3D &qhm_cfg,
+	[SLAVE_NPU_CAL_DP0] =3D &qhs_cal_dp0,
+	[SLAVE_NPU_CAL_DP1] =3D &qhs_cal_dp1,
+	[SLAVE_NPU_CP] =3D &qhs_cp,
+	[SLAVE_NPU_INT_DMA_BWMON_CFG] =3D &qhs_dma_bwmon,
+	[SLAVE_NPU_DPM] =3D &qhs_dpm,
+	[SLAVE_ISENSE_CFG] =3D &qhs_isense,
+	[SLAVE_NPU_LLM_CFG] =3D &qhs_llm,
+	[SLAVE_NPU_TCM] =3D &qhs_tcm,
+	[SLAVE_NPU_COMPUTE_NOC] =3D &qns_npu_sys,
+	[SLAVE_SERVICE_NPU_NOC] =3D &srvc_noc,
+};
+
+static struct qcom_icc_desc sm8250_npu_noc =3D {
+	.nodes =3D npu_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(npu_noc_nodes),
+	.bcms =3D npu_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(npu_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] =3D {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn11,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn5,
+	&bcm_sn6,
+	&bcm_sn7,
+	&bcm_sn8,
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node *system_noc_nodes[] =3D {
+	[MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
+	[A1NOC_SNOC_MAS] =3D &qnm_aggre1_noc,
+	[A2NOC_SNOC_MAS] =3D &qnm_aggre2_noc,
+	[MASTER_GEM_NOC_SNOC] =3D &qnm_gemnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] =3D &qnm_gemnoc_pcie,
+	[MASTER_PIMEM] =3D &qxm_pimem,
+	[MASTER_GIC] =3D &xm_gic,
+	[SLAVE_APPSS] =3D &qhs_apss,
+	[SNOC_CNOC_SLV] =3D &qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_GC] =3D &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] =3D &qns_gemnoc_sf,
+	[SLAVE_OCIMEM] =3D &qxs_imem,
+	[SLAVE_PIMEM] =3D &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
+	[SLAVE_PCIE_0] =3D &xs_pcie_0,
+	[SLAVE_PCIE_1] =3D &xs_pcie_1,
+	[SLAVE_PCIE_2] =3D &xs_pcie_modem,
+	[SLAVE_QDSS_STM] =3D &xs_qdss_stm,
+	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
+};
+
+static struct qcom_icc_desc sm8250_system_noc =3D {
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
+	desc =3D device_get_match_data(&pdev->dev);
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
+	for (i =3D 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
+	platform_set_drvdata(pdev, qp);
+
+	return 0;
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
+	{ .compatible =3D "qcom,sm8250-aggre1-noc",
+	  .data =3D &sm8250_aggre1_noc},
+	{ .compatible =3D "qcom,sm8250-aggre2-noc",
+	  .data =3D &sm8250_aggre2_noc},
+	{ .compatible =3D "qcom,sm8250-compute-noc",
+	  .data =3D &sm8250_compute_noc},
+	{ .compatible =3D "qcom,sm8250-config-noc",
+	  .data =3D &sm8250_config_noc},
+	{ .compatible =3D "qcom,sm8250-dc-noc",
+	  .data =3D &sm8250_dc_noc},
+	{ .compatible =3D "qcom,sm8250-gem-noc",
+	  .data =3D &sm8250_gem_noc},
+	{ .compatible =3D "qcom,sm8250-ipa-virt",
+	  .data =3D &sm8250_ipa_virt},
+	{ .compatible =3D "qcom,sm8250-mc-virt",
+	  .data =3D &sm8250_mc_virt},
+	{ .compatible =3D "qcom,sm8250-mmss-noc",
+	  .data =3D &sm8250_mmss_noc},
+	{ .compatible =3D "qcom,sm8250-npu-noc",
+	  .data =3D &sm8250_npu_noc},
+	{ .compatible =3D "qcom,sm8250-system-noc",
+	  .data =3D &sm8250_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+	.probe =3D qnoc_probe,
+	.remove =3D qnoc_remove,
+	.driver =3D {
+		.name =3D "qnoc-sm8250",
+		.of_match_table =3D qnoc_of_match,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm SM8250 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom=
/sm8250.h
new file mode 100644
index 000000000000..af4b0b47146f
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm #define SM8250 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8250_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM8250_H
+
+#define SM8250_A1NOC_SNOC_MAS			0
+#define SM8250_A1NOC_SNOC_SLV			1
+#define SM8250_A2NOC_SNOC_MAS			2
+#define SM8250_A2NOC_SNOC_SLV			3
+#define SM8250_MASTER_A1NOC_CFG			4
+#define SM8250_MASTER_A2NOC_CFG			5
+#define SM8250_MASTER_ALC			6
+#define SM8250_MASTER_AMPSS_M0			7
+#define SM8250_MASTER_ANOC_PCIE_GEM_NOC		8
+#define SM8250_MASTER_CAMNOC_HF			9
+#define SM8250_MASTER_CAMNOC_ICP		10
+#define SM8250_MASTER_CAMNOC_SF			11
+#define SM8250_MASTER_CNOC_A2NOC		12
+#define SM8250_MASTER_CNOC_DC_NOC		13
+#define SM8250_MASTER_CNOC_MNOC_CFG		14
+#define SM8250_MASTER_COMPUTE_NOC		15
+#define SM8250_MASTER_CRYPTO_CORE_0		16
+#define SM8250_MASTER_GEM_NOC_CFG		17
+#define SM8250_MASTER_GEM_NOC_PCIE_SNOC		18
+#define SM8250_MASTER_GEM_NOC_SNOC		19
+#define SM8250_MASTER_GIC			20
+#define SM8250_MASTER_GPU_TCU			21
+#define SM8250_MASTER_GRAPHICS_3D		22
+#define SM8250_MASTER_IPA			23
+#define SM8250_MASTER_IPA_CORE			24
+#define SM8250_MASTER_LLCC			25
+#define SM8250_MASTER_MDP_PORT0			26
+#define SM8250_MASTER_MDP_PORT1			27
+#define SM8250_MASTER_MNOC_HF_MEM_NOC		28
+#define SM8250_MASTER_MNOC_SF_MEM_NOC		29
+#define SM8250_MASTER_NPU			30
+#define SM8250_MASTER_NPU_CDP			31
+#define SM8250_MASTER_NPU_NOC_CFG		32
+#define SM8250_MASTER_NPU_SYS			33
+#define SM8250_MASTER_PCIE			34
+#define SM8250_MASTER_PCIE_1			35
+#define SM8250_MASTER_PCIE_2			36
+#define SM8250_MASTER_PIMEM			37
+#define SM8250_MASTER_QDSS_BAM			38
+#define SM8250_MASTER_QDSS_DAP			39
+#define SM8250_MASTER_QDSS_ETR			40
+#define SM8250_MASTER_QSPI_0			41
+#define SM8250_MASTER_QUP_0			42
+#define SM8250_MASTER_QUP_1			43
+#define SM8250_MASTER_QUP_2			44
+#define SM8250_MASTER_ROTATOR			45
+#define SM8250_MASTER_SDCC_2			46
+#define SM8250_MASTER_SDCC_4			47
+#define SM8250_MASTER_SNOC_CFG			48
+#define SM8250_MASTER_SNOC_GC_MEM_NOC		49
+#define SM8250_MASTER_SNOC_SF_MEM_NOC		50
+#define SM8250_MASTER_SYS_TCU			51
+#define SM8250_MASTER_TSIF			52
+#define SM8250_MASTER_UFS_CARD			53
+#define SM8250_MASTER_UFS_MEM			54
+#define SM8250_MASTER_USB3			55
+#define SM8250_MASTER_USB3_1			56
+#define SM8250_MASTER_VIDEO_P0			57
+#define SM8250_MASTER_VIDEO_P1			58
+#define SM8250_MASTER_VIDEO_PROC		59
+#define SM8250_SLAVE_A1NOC_CFG			60
+#define SM8250_SLAVE_A2NOC_CFG			61
+#define SM8250_SLAVE_AHB2PHY_NORTH		62
+#define SM8250_SLAVE_AHB2PHY_SOUTH		63
+#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC		64
+#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1	65
+#define SM8250_SLAVE_AOSS			66
+#define SM8250_SLAVE_APPSS			67
+#define SM8250_SLAVE_CAMERA_CFG			68
+#define SM8250_SLAVE_CDSP_CFG			69
+#define SM8250_SLAVE_CDSP_MEM_NOC		70
+#define SM8250_SLAVE_CLK_CTL			71
+#define SM8250_SLAVE_CNOC_A2NOC			72
+#define SM8250_SLAVE_CNOC_DDRSS			73
+#define SM8250_SLAVE_CNOC_MNOC_CFG		74
+#define SM8250_SLAVE_CRYPTO_0_CFG		75
+#define SM8250_SLAVE_CX_RDPM			76
+#define SM8250_SLAVE_DCC_CFG			77
+#define SM8250_SLAVE_DISPLAY_CFG		78
+#define SM8250_SLAVE_EBI_CH0			79
+#define SM8250_SLAVE_GEM_NOC_CFG		80
+#define SM8250_SLAVE_GEM_NOC_SNOC		81
+#define SM8250_SLAVE_GRAPHICS_3D_CFG		82
+#define SM8250_SLAVE_IMEM_CFG			83
+#define SM8250_SLAVE_IPA_CFG			84
+#define SM8250_SLAVE_IPA_CORE			85
+#define SM8250_SLAVE_IPC_ROUTER_CFG		86
+#define SM8250_SLAVE_ISENSE_CFG			87
+#define SM8250_SLAVE_LLCC			88
+#define SM8250_SLAVE_LLCC_CFG			89
+#define SM8250_SLAVE_LPASS			90
+#define SM8250_SLAVE_MEM_NOC_PCIE_SNOC		91
+#define SM8250_SLAVE_MNOC_HF_MEM_NOC		92
+#define SM8250_SLAVE_MNOC_SF_MEM_NOC		93
+#define SM8250_SLAVE_NPU_CAL_DP0		94
+#define SM8250_SLAVE_NPU_CAL_DP1		95
+#define SM8250_SLAVE_NPU_CFG			96
+#define SM8250_SLAVE_NPU_COMPUTE_NOC		97
+#define SM8250_SLAVE_NPU_CP			98
+#define SM8250_SLAVE_NPU_DPM			99
+#define SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG	100
+#define SM8250_SLAVE_NPU_LLM_CFG		101
+#define SM8250_SLAVE_NPU_TCM			102
+#define SM8250_SLAVE_OCIMEM			103
+#define SM8250_SLAVE_PCIE_0			104
+#define SM8250_SLAVE_PCIE_0_CFG			105
+#define SM8250_SLAVE_PCIE_1			106
+#define SM8250_SLAVE_PCIE_1_CFG			107
+#define SM8250_SLAVE_PCIE_2			108
+#define SM8250_SLAVE_PCIE_2_CFG			109
+#define SM8250_SLAVE_PDM			110
+#define SM8250_SLAVE_PIMEM			111
+#define SM8250_SLAVE_PIMEM_CFG			112
+#define SM8250_SLAVE_PRNG			113
+#define SM8250_SLAVE_QDSS_CFG			114
+#define SM8250_SLAVE_QDSS_STM			115
+#define SM8250_SLAVE_QSPI_0			116
+#define SM8250_SLAVE_QUP_0			117
+#define SM8250_SLAVE_QUP_1			118
+#define SM8250_SLAVE_QUP_2			119
+#define SM8250_SLAVE_RBCPR_CX_CFG		120
+#define SM8250_SLAVE_RBCPR_MMCX_CFG		121
+#define SM8250_SLAVE_RBCPR_MX_CFG		122
+#define SM8250_SLAVE_SDCC_2			123
+#define SM8250_SLAVE_SDCC_4			124
+#define SM8250_SLAVE_SERVICE_A1NOC		125
+#define SM8250_SLAVE_SERVICE_A2NOC		126
+#define SM8250_SLAVE_SERVICE_CNOC		127
+#define SM8250_SLAVE_SERVICE_GEM_NOC		128
+#define SM8250_SLAVE_SERVICE_GEM_NOC_1		129
+#define SM8250_SLAVE_SERVICE_GEM_NOC_2		130
+#define SM8250_SLAVE_SERVICE_MNOC		131
+#define SM8250_SLAVE_SERVICE_NPU_NOC		132
+#define SM8250_SLAVE_SERVICE_SNOC		133
+#define SM8250_SLAVE_SNOC_CFG			134
+#define SM8250_SLAVE_SNOC_GEM_NOC_GC		135
+#define SM8250_SLAVE_SNOC_GEM_NOC_SF		136
+#define SM8250_SLAVE_TCSR			137
+#define SM8250_SLAVE_TCU			138
+#define SM8250_SLAVE_TLMM_NORTH			139
+#define SM8250_SLAVE_TLMM_SOUTH			140
+#define SM8250_SLAVE_TLMM_WEST			141
+#define SM8250_SLAVE_TSIF			142
+#define SM8250_SLAVE_UFS_CARD_CFG		143
+#define SM8250_SLAVE_UFS_MEM_CFG		144
+#define SM8250_SLAVE_USB3			145
+#define SM8250_SLAVE_USB3_1			146
+#define SM8250_SLAVE_VENUS_CFG			147
+#define SM8250_SLAVE_VSENSE_CTRL_CFG		148
+#define SM8250_SNOC_CNOC_MAS			149
+#define SM8250_SNOC_CNOC_SLV			150
+
+#endif
--=20
2.26.1

