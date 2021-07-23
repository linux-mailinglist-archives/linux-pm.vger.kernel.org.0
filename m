Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7C3D4112
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGWTD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhGWTD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 15:03:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92FC0613D5
        for <linux-pm@vger.kernel.org>; Fri, 23 Jul 2021 12:44:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso3191881oth.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jul 2021 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hf0XHhghSq3NQn60OB3GbSwu8/6AMgwcWt99TsKGBNU=;
        b=mME586YpK0IsZ60/f6XP3lQRtjJWYaYrt8+wtT1t4m3a5hv2JIrPbsjidEYvc/EWG7
         48TtDRHM+Sx6/tya5ozY5H8XCC8YFq4VVQLBKuKtNW2Wb62ifRFXSDI3InIAY9SR8od1
         AXHtrUF9U/j3+LEg8E0x62ia39mqmjWS22TrWb9iK397cgQ1yUbulPv1ni3Nj+zs+n6K
         o1fsCPqnbFoF7vxOS+sY0rDIWUmQ6ADjKP4rZr02SbL8xu0JmXxn7HUEGEpEj4/CHi/k
         3H+w7IJzmArlRT7aNtLM4VCHAKssMr/+CU/WDpubkmdeipGokg4VhWLPgBZSIBxwbIl1
         Ko9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hf0XHhghSq3NQn60OB3GbSwu8/6AMgwcWt99TsKGBNU=;
        b=D3zOuUgHqFY5VeRCfDAtDqajnJhJpmIm4KZo3OWjuzl3SZe4BsSCq5MxahPNn16FbV
         MQEuOfP9BI4ITCMm0VZR5ItqZ/snfm/PO4/HYVKnxGDf2N7AQZ4Wf7sx3kMeiZsJiU9e
         nfUPKTFjOJMfxxVSrrPA13leMOMy30yvl3SvXpxIC/7MPVVmIB2RNfBlch+SLrRtr5i7
         RpTjyWl2t47XHwuSKg7do6kh0UMcBdLMgk1mKK2u3QSDEt2teS7ZvUiLhIpsP/RIu+9D
         sTrF6P1+5niJbFeXlDfcU0da5i13SCazjVmy4ooPPtBS8NWEyQ/Krl8xcl1NqSo4iopg
         hIZg==
X-Gm-Message-State: AOAM530s5W16DMGKaoRZyutbNPUWkAXde3iV2EsBGCqoJP67r1PtIGSu
        2fZ5h38N52MCuQo73KNja6vn1w==
X-Google-Smtp-Source: ABdhPJwKgzocbqvvQtsMcdTfsrc+YSM4DwL14wRAclBKYd66i4bo20kjOcFjwkBe2w2p0VrkmOVxjg==
X-Received: by 2002:a05:6830:2783:: with SMTP id x3mr4216233otu.37.1627069469924;
        Fri, 23 Jul 2021 12:44:29 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a83sm5802877oii.13.2021.07.23.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:44:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] interconnect: qcom: Add SC8180x providers
Date:   Fri, 23 Jul 2021 12:42:43 -0700
Message-Id: <20210723194243.3675795-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210723194243.3675795-1-bjorn.andersson@linaro.org>
References: <20210723194243.3675795-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Georgi Djakov <georgi.djakov@linaro.org>

The SC8180x contains the usual RPMH based interconnect providers, add a
driver which defines the various busses and ports.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/Kconfig   |   9 +
 drivers/interconnect/qcom/Makefile  |   2 +
 drivers/interconnect/qcom/sc8180x.c | 626 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sc8180x.h | 172 ++++++++
 4 files changed, 809 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc8180x.c
 create mode 100644 drivers/interconnect/qcom/sc8180x.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index 0d7a2500d0b8..daf1e25f6042 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -83,6 +83,15 @@ config INTERCONNECT_QCOM_SC7280
 	  This is a driver for the Qualcomm Network-on-Chip on sc7280-based
 	  platforms.
=20
+config INTERCONNECT_QCOM_SC8180X
+	tristate "Qualcomm SC8180X interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sc8180x-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SDM660
 	tristate "Qualcomm SDM660 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index 2880129a6fe4..69300b1d48ef 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -9,6 +9,7 @@ qnoc-qcs404-objs			:=3D qcs404.o
 icc-rpmh-obj				:=3D icc-rpmh.o
 qnoc-sc7180-objs			:=3D sc7180.o
 qnoc-sc7280-objs                        :=3D sc7280.o
+qnoc-sc8180x-objs			:=3D sc8180x.o
 qnoc-sdm660-objs			:=3D sdm660.o
 qnoc-sdm845-objs			:=3D sdm845.o
 qnoc-sdx55-objs				:=3D sdx55.o
@@ -26,6 +27,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) +=3D qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) +=3D icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) +=3D qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) +=3D qnoc-sc7280.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) +=3D qnoc-sc8180x.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) +=3D qnoc-sdm660.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) +=3D qnoc-sdx55.o
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qco=
m/sc8180x.c
new file mode 100644
index 000000000000..e9adf05b9330
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <dt-bindings/interconnect/qcom,sc8180x.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sc8180x.h"
+
+DEFINE_QNODE(mas_qhm_a1noc_cfg, SC8180X_MASTER_A1NOC_CFG, 1, 4, SC8180X_SL=
AVE_SERVICE_A1NOC);
+DEFINE_QNODE(mas_xm_ufs_card, SC8180X_MASTER_UFS_CARD, 1, 8, SC8180X_A1NOC=
_SNOC_SLV);
+DEFINE_QNODE(mas_xm_ufs_g4, SC8180X_MASTER_UFS_GEN4, 1, 8, SC8180X_A1NOC_S=
NOC_SLV);
+DEFINE_QNODE(mas_xm_ufs_mem, SC8180X_MASTER_UFS_MEM, 1, 8, SC8180X_A1NOC_S=
NOC_SLV);
+DEFINE_QNODE(mas_xm_usb3_0, SC8180X_MASTER_USB3, 1, 8, SC8180X_A1NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_xm_usb3_1, SC8180X_MASTER_USB3_1, 1, 8, SC8180X_A1NOC_SNO=
C_SLV);
+DEFINE_QNODE(mas_xm_usb3_2, SC8180X_MASTER_USB3_2, 1, 16, SC8180X_A1NOC_SN=
OC_SLV);
+DEFINE_QNODE(mas_qhm_a2noc_cfg, SC8180X_MASTER_A2NOC_CFG, 1, 4, SC8180X_SL=
AVE_SERVICE_A2NOC);
+DEFINE_QNODE(mas_qhm_qdss_bam, SC8180X_MASTER_QDSS_BAM, 1, 4, SC8180X_A2NO=
C_SNOC_SLV);
+DEFINE_QNODE(mas_qhm_qspi, SC8180X_MASTER_QSPI_0, 1, 4, SC8180X_A2NOC_SNOC=
_SLV);
+DEFINE_QNODE(mas_qhm_qspi1, SC8180X_MASTER_QSPI_1, 1, 4, SC8180X_A2NOC_SNO=
C_SLV);
+DEFINE_QNODE(mas_qhm_qup0, SC8180X_MASTER_QUP_0, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_qhm_qup1, SC8180X_MASTER_QUP_1, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_qhm_qup2, SC8180X_MASTER_QUP_2, 1, 4, SC8180X_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_qhm_sensorss_ahb, SC8180X_MASTER_SENSORS_AHB, 1, 4, SC818=
0X_A2NOC_SNOC_SLV);
+DEFINE_QNODE(mas_qxm_crypto, SC8180X_MASTER_CRYPTO_CORE_0, 1, 8, SC8180X_A=
2NOC_SNOC_SLV);
+DEFINE_QNODE(mas_qxm_ipa, SC8180X_MASTER_IPA, 1, 8, SC8180X_A2NOC_SNOC_SLV=
);
+DEFINE_QNODE(mas_xm_emac, SC8180X_MASTER_EMAC, 1, 8, SC8180X_A2NOC_SNOC_SL=
V);
+DEFINE_QNODE(mas_xm_pcie3_0, SC8180X_MASTER_PCIE, 1, 8, SC8180X_SLAVE_ANOC=
_PCIE_GEM_NOC);
+DEFINE_QNODE(mas_xm_pcie3_1, SC8180X_MASTER_PCIE_1, 1, 16, SC8180X_SLAVE_A=
NOC_PCIE_GEM_NOC);
+DEFINE_QNODE(mas_xm_pcie3_2, SC8180X_MASTER_PCIE_2, 1, 8, SC8180X_SLAVE_AN=
OC_PCIE_GEM_NOC);
+DEFINE_QNODE(mas_xm_pcie3_3, SC8180X_MASTER_PCIE_3, 1, 16, SC8180X_SLAVE_A=
NOC_PCIE_GEM_NOC);
+DEFINE_QNODE(mas_xm_qdss_etr, SC8180X_MASTER_QDSS_ETR, 1, 8, SC8180X_A2NOC=
_SNOC_SLV);
+DEFINE_QNODE(mas_xm_sdc2, SC8180X_MASTER_SDCC_2, 1, 8, SC8180X_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_xm_sdc4, SC8180X_MASTER_SDCC_4, 1, 8, SC8180X_A2NOC_SNOC_=
SLV);
+DEFINE_QNODE(mas_qxm_camnoc_hf0_uncomp, SC8180X_MASTER_CAMNOC_HF0_UNCOMP, =
1, 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(mas_qxm_camnoc_hf1_uncomp, SC8180X_MASTER_CAMNOC_HF1_UNCOMP, =
1, 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(mas_qxm_camnoc_sf_uncomp, SC8180X_MASTER_CAMNOC_SF_UNCOMP, 1,=
 32, SC8180X_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(mas_qnm_npu, SC8180X_MASTER_NPU, 1, 32, SC8180X_SLAVE_CDSP_ME=
M_NOC);
+DEFINE_QNODE(mas_qnm_snoc, SC8180X_SNOC_CNOC_MAS, 1, 8, SC8180X_SLAVE_TLMM=
_SOUTH, SC8180X_SLAVE_CDSP_CFG, SC8180X_SLAVE_SPSS_CFG, SC8180X_SLAVE_CAMER=
A_CFG, SC8180X_SLAVE_SDCC_4, SC8180X_SLAVE_AHB2PHY_CENTER, SC8180X_SLAVE_SD=
CC_2, SC8180X_SLAVE_PCIE_2_CFG, SC8180X_SLAVE_CNOC_MNOC_CFG, SC8180X_SLAVE_=
EMAC_CFG, SC8180X_SLAVE_QSPI_0, SC8180X_SLAVE_QSPI_1, SC8180X_SLAVE_TLMM_EA=
ST, SC8180X_SLAVE_SNOC_CFG, SC8180X_SLAVE_AHB2PHY_EAST, SC8180X_SLAVE_GLM, =
SC8180X_SLAVE_PDM, SC8180X_SLAVE_PCIE_1_CFG, SC8180X_SLAVE_A2NOC_CFG, SC818=
0X_SLAVE_QDSS_CFG, SC8180X_SLAVE_DISPLAY_CFG, SC8180X_SLAVE_TCSR, SC8180X_S=
LAVE_UFS_MEM_0_CFG, SC8180X_SLAVE_CNOC_DDRSS, SC8180X_SLAVE_PCIE_0_CFG, SC8=
180X_SLAVE_QUP_1, SC8180X_SLAVE_QUP_2, SC8180X_SLAVE_NPU_CFG, SC8180X_SLAVE=
_CRYPTO_0_CFG, SC8180X_SLAVE_GRAPHICS_3D_CFG, SC8180X_SLAVE_VENUS_CFG, SC81=
80X_SLAVE_TSIF, SC8180X_SLAVE_IPA_CFG, SC8180X_SLAVE_CLK_CTL, SC8180X_SLAVE=
_SECURITY, SC8180X_SLAVE_AOP, SC8180X_SLAVE_AHB2PHY_WEST, SC8180X_SLAVE_AHB=
2PHY_SOUTH, SC8180X_SLAVE_SERVICE_CNOC, SC8180X_SLAVE_UFS_CARD_CFG, SC8180X=
_SLAVE_USB3_1, SC8180X_SLAVE_USB3_2, SC8180X_SLAVE_PCIE_3_CFG, SC8180X_SLAV=
E_RBCPR_CX_CFG, SC8180X_SLAVE_TLMM_WEST, SC8180X_SLAVE_A1NOC_CFG, SC8180X_S=
LAVE_AOSS, SC8180X_SLAVE_PRNG, SC8180X_SLAVE_VSENSE_CTRL_CFG, SC8180X_SLAVE=
_QUP_0, SC8180X_SLAVE_USB3, SC8180X_SLAVE_RBCPR_MMCX_CFG, SC8180X_SLAVE_PIM=
EM_CFG, SC8180X_SLAVE_UFS_MEM_1_CFG, SC8180X_SLAVE_RBCPR_MX_CFG, SC8180X_SL=
AVE_IMEM_CFG);
+DEFINE_QNODE(mas_qhm_cnoc_dc_noc, SC8180X_MASTER_CNOC_DC_NOC, 1, 4, SC8180=
X_SLAVE_LLCC_CFG, SC8180X_SLAVE_GEM_NOC_CFG);
+DEFINE_QNODE(mas_acm_apps, SC8180X_MASTER_AMPSS_M0, 4, 64, SC8180X_SLAVE_E=
CC, SC8180X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_acm_gpu_tcu, SC8180X_MASTER_GPU_TCU, 1, 8, SC8180X_SLAVE_=
LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_acm_sys_tcu, SC8180X_MASTER_SYS_TCU, 1, 8, SC8180X_SLAVE_=
LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_qhm_gemnoc_cfg, SC8180X_MASTER_GEM_NOC_CFG, 1, 4, SC8180X=
_SLAVE_SERVICE_GEM_NOC_1, SC8180X_SLAVE_SERVICE_GEM_NOC, SC8180X_SLAVE_MSS_=
PROC_MS_MPU_CFG);
+DEFINE_QNODE(mas_qnm_cmpnoc, SC8180X_MASTER_COMPUTE_NOC, 2, 32, SC8180X_SL=
AVE_ECC, SC8180X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_qnm_gpu, SC8180X_MASTER_GRAPHICS_3D, 4, 32, SC8180X_SLAVE=
_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_qnm_mnoc_hf, SC8180X_MASTER_MNOC_HF_MEM_NOC, 2, 32, SC818=
0X_SLAVE_LLCC);
+DEFINE_QNODE(mas_qnm_mnoc_sf, SC8180X_MASTER_MNOC_SF_MEM_NOC, 1, 32, SC818=
0X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_qnm_pcie, SC8180X_MASTER_GEM_NOC_PCIE_SNOC, 1, 32, SC8180=
X_SLAVE_LLCC, SC8180X_SLAVE_GEM_NOC_SNOC);
+DEFINE_QNODE(mas_qnm_snoc_gc, SC8180X_MASTER_SNOC_GC_MEM_NOC, 1, 8, SC8180=
X_SLAVE_LLCC);
+DEFINE_QNODE(mas_qnm_snoc_sf, SC8180X_MASTER_SNOC_SF_MEM_NOC, 1, 32, SC818=
0X_SLAVE_LLCC);
+DEFINE_QNODE(mas_qxm_ecc, SC8180X_MASTER_ECC, 2, 32, SC8180X_SLAVE_LLCC);
+DEFINE_QNODE(mas_ipa_core_master, SC8180X_MASTER_IPA_CORE, 1, 8, SC8180X_S=
LAVE_IPA_CORE);
+DEFINE_QNODE(mas_llcc_mc, SC8180X_MASTER_LLCC, 8, 4, SC8180X_SLAVE_EBI_CH0=
);
+DEFINE_QNODE(mas_qhm_mnoc_cfg, SC8180X_MASTER_CNOC_MNOC_CFG, 1, 4, SC8180X=
_SLAVE_SERVICE_MNOC);
+DEFINE_QNODE(mas_qxm_camnoc_hf0, SC8180X_MASTER_CAMNOC_HF0, 1, 32, SC8180X=
_SLAVE_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_camnoc_hf1, SC8180X_MASTER_CAMNOC_HF1, 1, 32, SC8180X=
_SLAVE_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_camnoc_sf, SC8180X_MASTER_CAMNOC_SF, 1, 32, SC8180X_S=
LAVE_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_mdp0, SC8180X_MASTER_MDP_PORT0, 1, 32, SC8180X_SLAVE_=
MNOC_HF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_mdp1, SC8180X_MASTER_MDP_PORT1, 1, 32, SC8180X_SLAVE_=
MNOC_HF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_rot, SC8180X_MASTER_ROTATOR, 1, 32, SC8180X_SLAVE_MNO=
C_SF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_venus0, SC8180X_MASTER_VIDEO_P0, 1, 32, SC8180X_SLAVE=
_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_venus1, SC8180X_MASTER_VIDEO_P1, 1, 32, SC8180X_SLAVE=
_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(mas_qxm_venus_arm9, SC8180X_MASTER_VIDEO_PROC, 1, 8, SC8180X_=
SLAVE_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(mas_qhm_snoc_cfg, SC8180X_MASTER_SNOC_CFG, 1, 4, SC8180X_SLAV=
E_SERVICE_SNOC);
+DEFINE_QNODE(mas_qnm_aggre1_noc, SC8180X_A1NOC_SNOC_MAS, 1, 32, SC8180X_SL=
AVE_SNOC_GEM_NOC_SF, SC8180X_SLAVE_PIMEM, SC8180X_SLAVE_OCIMEM, SC8180X_SLA=
VE_APPSS, SC8180X_SNOC_CNOC_SLV, SC8180X_SLAVE_QDSS_STM);
+DEFINE_QNODE(mas_qnm_aggre2_noc, SC8180X_A2NOC_SNOC_MAS, 1, 16, SC8180X_SL=
AVE_SNOC_GEM_NOC_SF, SC8180X_SLAVE_PIMEM, SC8180X_SLAVE_PCIE_3, SC8180X_SLA=
VE_OCIMEM, SC8180X_SLAVE_APPSS, SC8180X_SLAVE_PCIE_2, SC8180X_SNOC_CNOC_SLV=
, SC8180X_SLAVE_PCIE_0, SC8180X_SLAVE_PCIE_1, SC8180X_SLAVE_TCU, SC8180X_SL=
AVE_QDSS_STM);
+DEFINE_QNODE(mas_qnm_gemnoc, SC8180X_MASTER_GEM_NOC_SNOC, 1, 8, SC8180X_SL=
AVE_PIMEM, SC8180X_SLAVE_OCIMEM, SC8180X_SLAVE_APPSS, SC8180X_SNOC_CNOC_SLV=
, SC8180X_SLAVE_TCU, SC8180X_SLAVE_QDSS_STM);
+DEFINE_QNODE(mas_qxm_pimem, SC8180X_MASTER_PIMEM, 1, 8, SC8180X_SLAVE_SNOC=
_GEM_NOC_GC, SC8180X_SLAVE_OCIMEM);
+DEFINE_QNODE(mas_xm_gic, SC8180X_MASTER_GIC, 1, 8, SC8180X_SLAVE_SNOC_GEM_=
NOC_GC, SC8180X_SLAVE_OCIMEM);
+DEFINE_QNODE(slv_qns_a1noc_snoc, SC8180X_A1NOC_SNOC_SLV, 1, 32, SC8180X_A1=
NOC_SNOC_MAS);
+DEFINE_QNODE(slv_srvc_aggre1_noc, SC8180X_SLAVE_SERVICE_A1NOC, 1, 4);
+DEFINE_QNODE(slv_qns_a2noc_snoc, SC8180X_A2NOC_SNOC_SLV, 1, 16, SC8180X_A2=
NOC_SNOC_MAS);
+DEFINE_QNODE(slv_qns_pcie_mem_noc, SC8180X_SLAVE_ANOC_PCIE_GEM_NOC, 1, 32,=
 SC8180X_MASTER_GEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(slv_srvc_aggre2_noc, SC8180X_SLAVE_SERVICE_A2NOC, 1, 4);
+DEFINE_QNODE(slv_qns_camnoc_uncomp, SC8180X_SLAVE_CAMNOC_UNCOMP, 1, 32);
+DEFINE_QNODE(slv_qns_cdsp_mem_noc, SC8180X_SLAVE_CDSP_MEM_NOC, 2, 32, SC81=
80X_MASTER_COMPUTE_NOC);
+DEFINE_QNODE(slv_qhs_a1_noc_cfg, SC8180X_SLAVE_A1NOC_CFG, 1, 4, SC8180X_MA=
STER_A1NOC_CFG);
+DEFINE_QNODE(slv_qhs_a2_noc_cfg, SC8180X_SLAVE_A2NOC_CFG, 1, 4, SC8180X_MA=
STER_A2NOC_CFG);
+DEFINE_QNODE(slv_qhs_ahb2phy_refgen_center, SC8180X_SLAVE_AHB2PHY_CENTER, =
1, 4);
+DEFINE_QNODE(slv_qhs_ahb2phy_refgen_east, SC8180X_SLAVE_AHB2PHY_EAST, 1, 4=
);
+DEFINE_QNODE(slv_qhs_ahb2phy_refgen_west, SC8180X_SLAVE_AHB2PHY_WEST, 1, 4=
);
+DEFINE_QNODE(slv_qhs_ahb2phy_south, SC8180X_SLAVE_AHB2PHY_SOUTH, 1, 4);
+DEFINE_QNODE(slv_qhs_aop, SC8180X_SLAVE_AOP, 1, 4);
+DEFINE_QNODE(slv_qhs_aoss, SC8180X_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(slv_qhs_camera_cfg, SC8180X_SLAVE_CAMERA_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_clk_ctl, SC8180X_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(slv_qhs_compute_dsp, SC8180X_SLAVE_CDSP_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_cpr_cx, SC8180X_SLAVE_RBCPR_CX_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_cpr_mmcx, SC8180X_SLAVE_RBCPR_MMCX_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_cpr_mx, SC8180X_SLAVE_RBCPR_MX_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_crypto0_cfg, SC8180X_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_ddrss_cfg, SC8180X_SLAVE_CNOC_DDRSS, 1, 4, SC8180X_MA=
STER_CNOC_DC_NOC);
+DEFINE_QNODE(slv_qhs_display_cfg, SC8180X_SLAVE_DISPLAY_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_emac_cfg, SC8180X_SLAVE_EMAC_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_glm, SC8180X_SLAVE_GLM, 1, 4);
+DEFINE_QNODE(slv_qhs_gpuss_cfg, SC8180X_SLAVE_GRAPHICS_3D_CFG, 1, 8);
+DEFINE_QNODE(slv_qhs_imem_cfg, SC8180X_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_ipa, SC8180X_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_mnoc_cfg, SC8180X_SLAVE_CNOC_MNOC_CFG, 1, 4, SC8180X_=
MASTER_CNOC_MNOC_CFG);
+DEFINE_QNODE(slv_qhs_npu_cfg, SC8180X_SLAVE_NPU_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_pcie0_cfg, SC8180X_SLAVE_PCIE_0_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_pcie1_cfg, SC8180X_SLAVE_PCIE_1_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_pcie2_cfg, SC8180X_SLAVE_PCIE_2_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_pcie3_cfg, SC8180X_SLAVE_PCIE_3_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_pdm, SC8180X_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(slv_qhs_pimem_cfg, SC8180X_SLAVE_PIMEM_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_prng, SC8180X_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(slv_qhs_qdss_cfg, SC8180X_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_qspi_0, SC8180X_SLAVE_QSPI_0, 1, 4);
+DEFINE_QNODE(slv_qhs_qspi_1, SC8180X_SLAVE_QSPI_1, 1, 4);
+DEFINE_QNODE(slv_qhs_qupv3_east0, SC8180X_SLAVE_QUP_1, 1, 4);
+DEFINE_QNODE(slv_qhs_qupv3_east1, SC8180X_SLAVE_QUP_2, 1, 4);
+DEFINE_QNODE(slv_qhs_qupv3_west, SC8180X_SLAVE_QUP_0, 1, 4);
+DEFINE_QNODE(slv_qhs_sdc2, SC8180X_SLAVE_SDCC_2, 1, 4);
+DEFINE_QNODE(slv_qhs_sdc4, SC8180X_SLAVE_SDCC_4, 1, 4);
+DEFINE_QNODE(slv_qhs_security, SC8180X_SLAVE_SECURITY, 1, 4);
+DEFINE_QNODE(slv_qhs_snoc_cfg, SC8180X_SLAVE_SNOC_CFG, 1, 4, SC8180X_MASTE=
R_SNOC_CFG);
+DEFINE_QNODE(slv_qhs_spss_cfg, SC8180X_SLAVE_SPSS_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_tcsr, SC8180X_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(slv_qhs_tlmm_east, SC8180X_SLAVE_TLMM_EAST, 1, 4);
+DEFINE_QNODE(slv_qhs_tlmm_south, SC8180X_SLAVE_TLMM_SOUTH, 1, 4);
+DEFINE_QNODE(slv_qhs_tlmm_west, SC8180X_SLAVE_TLMM_WEST, 1, 4);
+DEFINE_QNODE(slv_qhs_tsif, SC8180X_SLAVE_TSIF, 1, 4);
+DEFINE_QNODE(slv_qhs_ufs_card_cfg, SC8180X_SLAVE_UFS_CARD_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_ufs_mem0_cfg, SC8180X_SLAVE_UFS_MEM_0_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_ufs_mem1_cfg, SC8180X_SLAVE_UFS_MEM_1_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_usb3_0, SC8180X_SLAVE_USB3, 1, 4);
+DEFINE_QNODE(slv_qhs_usb3_1, SC8180X_SLAVE_USB3_1, 1, 4);
+DEFINE_QNODE(slv_qhs_usb3_2, SC8180X_SLAVE_USB3_2, 1, 4);
+DEFINE_QNODE(slv_qhs_venus_cfg, SC8180X_SLAVE_VENUS_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_vsense_ctrl_cfg, SC8180X_SLAVE_VSENSE_CTRL_CFG, 1, 4);
+DEFINE_QNODE(slv_srvc_cnoc, SC8180X_SLAVE_SERVICE_CNOC, 1, 4);
+DEFINE_QNODE(slv_qhs_gemnoc, SC8180X_SLAVE_GEM_NOC_CFG, 1, 4, SC8180X_MAST=
ER_GEM_NOC_CFG);
+DEFINE_QNODE(slv_qhs_llcc, SC8180X_SLAVE_LLCC_CFG, 1, 4);
+DEFINE_QNODE(slv_qhs_mdsp_ms_mpu_cfg, SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG, 1=
, 4);
+DEFINE_QNODE(slv_qns_ecc, SC8180X_SLAVE_ECC, 1, 32);
+DEFINE_QNODE(slv_qns_gem_noc_snoc, SC8180X_SLAVE_GEM_NOC_SNOC, 1, 8, SC818=
0X_MASTER_GEM_NOC_SNOC);
+DEFINE_QNODE(slv_qns_llcc, SC8180X_SLAVE_LLCC, 8, 16, SC8180X_MASTER_LLCC);
+DEFINE_QNODE(slv_srvc_gemnoc, SC8180X_SLAVE_SERVICE_GEM_NOC, 1, 4);
+DEFINE_QNODE(slv_srvc_gemnoc1, SC8180X_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
+DEFINE_QNODE(slv_ipa_core_slave, SC8180X_SLAVE_IPA_CORE, 1, 8);
+DEFINE_QNODE(slv_ebi, SC8180X_SLAVE_EBI_CH0, 8, 4);
+DEFINE_QNODE(slv_qns2_mem_noc, SC8180X_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SC818=
0X_MASTER_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(slv_qns_mem_noc_hf, SC8180X_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SC8=
180X_MASTER_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(slv_srvc_mnoc, SC8180X_SLAVE_SERVICE_MNOC, 1, 4);
+DEFINE_QNODE(slv_qhs_apss, SC8180X_SLAVE_APPSS, 1, 8);
+DEFINE_QNODE(slv_qns_cnoc, SC8180X_SNOC_CNOC_SLV, 1, 8, SC8180X_SNOC_CNOC_=
MAS);
+DEFINE_QNODE(slv_qns_gemnoc_gc, SC8180X_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SC818=
0X_MASTER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(slv_qns_gemnoc_sf, SC8180X_SLAVE_SNOC_GEM_NOC_SF, 1, 32, SC81=
80X_MASTER_SNOC_SF_MEM_NOC);
+DEFINE_QNODE(slv_qxs_imem, SC8180X_SLAVE_OCIMEM, 1, 8);
+DEFINE_QNODE(slv_qxs_pimem, SC8180X_SLAVE_PIMEM, 1, 8);
+DEFINE_QNODE(slv_srvc_snoc, SC8180X_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(slv_xs_pcie_0, SC8180X_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(slv_xs_pcie_1, SC8180X_SLAVE_PCIE_1, 1, 8);
+DEFINE_QNODE(slv_xs_pcie_2, SC8180X_SLAVE_PCIE_2, 1, 8);
+DEFINE_QNODE(slv_xs_pcie_3, SC8180X_SLAVE_PCIE_3, 1, 8);
+DEFINE_QNODE(slv_xs_qdss_stm, SC8180X_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(slv_xs_sys_tcu_cfg, SC8180X_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_acv, "ACV", false, &slv_ebi);
+DEFINE_QBCM(bcm_mc0, "MC0", false, &slv_ebi);
+DEFINE_QBCM(bcm_sh0, "SH0", false, &slv_qns_llcc);
+DEFINE_QBCM(bcm_mm0, "MM0", false, &slv_qns_mem_noc_hf);
+DEFINE_QBCM(bcm_co0, "CO0", false, &slv_qns_cdsp_mem_noc);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &mas_qxm_crypto);
+DEFINE_QBCM(bcm_cn0, "CN0", false, &mas_qnm_snoc, &slv_qhs_a1_noc_cfg, &sl=
v_qhs_a2_noc_cfg, &slv_qhs_ahb2phy_refgen_center, &slv_qhs_ahb2phy_refgen_e=
ast, &slv_qhs_ahb2phy_refgen_west, &slv_qhs_ahb2phy_south, &slv_qhs_aop, &s=
lv_qhs_aoss, &slv_qhs_camera_cfg, &slv_qhs_clk_ctl, &slv_qhs_compute_dsp, &=
slv_qhs_cpr_cx, &slv_qhs_cpr_mmcx, &slv_qhs_cpr_mx, &slv_qhs_crypto0_cfg, &=
slv_qhs_ddrss_cfg, &slv_qhs_display_cfg, &slv_qhs_emac_cfg, &slv_qhs_glm, &=
slv_qhs_gpuss_cfg, &slv_qhs_imem_cfg, &slv_qhs_ipa, &slv_qhs_mnoc_cfg, &slv=
_qhs_npu_cfg, &slv_qhs_pcie0_cfg, &slv_qhs_pcie1_cfg, &slv_qhs_pcie2_cfg, &=
slv_qhs_pcie3_cfg, &slv_qhs_pdm, &slv_qhs_pimem_cfg, &slv_qhs_prng, &slv_qh=
s_qdss_cfg, &slv_qhs_qspi_0, &slv_qhs_qspi_1, &slv_qhs_qupv3_east0, &slv_qh=
s_qupv3_east1, &slv_qhs_qupv3_west, &slv_qhs_sdc2, &slv_qhs_sdc4, &slv_qhs_=
security, &slv_qhs_snoc_cfg, &slv_qhs_spss_cfg, &slv_qhs_tcsr, &slv_qhs_tlm=
m_east, &slv_qhs_tlmm_south, &slv_qhs_tlmm_west, &slv_qhs_tsif, &slv_qhs_uf=
s_card_cfg, &slv_qhs_ufs_mem0_cfg, &slv_qhs_ufs_mem1_cfg, &slv_qhs_usb3_0, =
&slv_qhs_usb3_1, &slv_qhs_usb3_2, &slv_qhs_venus_cfg, &slv_qhs_vsense_ctrl_=
cfg, &slv_srvc_cnoc);
+DEFINE_QBCM(bcm_mm1, "MM1", false, &mas_qxm_camnoc_hf0_uncomp, &mas_qxm_ca=
mnoc_hf1_uncomp, &mas_qxm_camnoc_sf_uncomp, &mas_qxm_camnoc_hf0, &mas_qxm_c=
amnoc_hf1, &mas_qxm_mdp0, &mas_qxm_mdp1);
+DEFINE_QBCM(bcm_qup0, "QUP0", false, &mas_qhm_qup0, &mas_qhm_qup1, &mas_qh=
m_qup2);
+DEFINE_QBCM(bcm_sh2, "SH2", false, &slv_qns_gem_noc_snoc);
+DEFINE_QBCM(bcm_mm2, "MM2", false, &mas_qxm_camnoc_sf, &mas_qxm_rot, &mas_=
qxm_venus0, &mas_qxm_venus1, &mas_qxm_venus_arm9, &slv_qns2_mem_noc);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &mas_acm_apps);
+DEFINE_QBCM(bcm_sn0, "SN0", false, &slv_qns_gemnoc_sf);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &slv_qxs_imem);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &slv_qns_gemnoc_gc);
+DEFINE_QBCM(bcm_co2, "CO2", false, &mas_qnm_npu);
+DEFINE_QBCM(bcm_ip0, "IP0", false, &slv_ipa_core_slave);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &slv_srvc_aggre1_noc, &slv_qns_cnoc);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &slv_qxs_pimem);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &slv_xs_pcie_0, &slv_xs_pcie_1, &slv_xs=
_pcie_2, &slv_xs_pcie_3);
+DEFINE_QBCM(bcm_sn9, "SN9", false, &mas_qnm_aggre1_noc);
+DEFINE_QBCM(bcm_sn11, "SN11", false, &mas_qnm_aggre2_noc);
+DEFINE_QBCM(bcm_sn14, "SN14", false, &slv_qns_pcie_mem_noc);
+DEFINE_QBCM(bcm_sn15, "SN15", false, &mas_qnm_gemnoc);
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] =3D {
+	&bcm_sn3,
+	&bcm_ce0,
+	&bcm_qup0,
+};
+
+static struct qcom_icc_bcm *aggre2_noc_bcms[] =3D {
+	&bcm_sn14,
+	&bcm_ce0,
+	&bcm_qup0,
+};
+
+static struct qcom_icc_bcm *camnoc_virt_bcms[] =3D {
+	&bcm_mm1,
+};
+
+static struct qcom_icc_bcm *compute_noc_bcms[] =3D {
+	&bcm_co0,
+	&bcm_co2,
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] =3D {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_bcm *gem_noc_bcms[] =3D {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+};
+
+static struct qcom_icc_bcm *ipa_virt_bcms[] =3D {
+	&bcm_ip0,
+};
+
+static struct qcom_icc_bcm *mc_virt_bcms[] =3D {
+	&bcm_mc0,
+	&bcm_acv,
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] =3D {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn8,
+	&bcm_sn9,
+	&bcm_sn11,
+	&bcm_sn15,
+};
+
+static struct qcom_icc_node *aggre1_noc_nodes[] =3D {
+	[MASTER_A1NOC_CFG] =3D &mas_qhm_a1noc_cfg,
+	[MASTER_UFS_CARD] =3D &mas_xm_ufs_card,
+	[MASTER_UFS_GEN4] =3D &mas_xm_ufs_g4,
+	[MASTER_UFS_MEM] =3D &mas_xm_ufs_mem,
+	[MASTER_USB3] =3D &mas_xm_usb3_0,
+	[MASTER_USB3_1] =3D &mas_xm_usb3_1,
+	[MASTER_USB3_2] =3D &mas_xm_usb3_2,
+	[A1NOC_SNOC_SLV] =3D &slv_qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] =3D &slv_srvc_aggre1_noc,
+};
+
+static struct qcom_icc_node *aggre2_noc_nodes[] =3D {
+	[MASTER_A2NOC_CFG] =3D &mas_qhm_a2noc_cfg,
+	[MASTER_QDSS_BAM] =3D &mas_qhm_qdss_bam,
+	[MASTER_QSPI_0] =3D &mas_qhm_qspi,
+	[MASTER_QSPI_1] =3D &mas_qhm_qspi1,
+	[MASTER_QUP_0] =3D &mas_qhm_qup0,
+	[MASTER_QUP_1] =3D &mas_qhm_qup1,
+	[MASTER_QUP_2] =3D &mas_qhm_qup2,
+	[MASTER_SENSORS_AHB] =3D &mas_qhm_sensorss_ahb,
+	[MASTER_CRYPTO_CORE_0] =3D &mas_qxm_crypto,
+	[MASTER_IPA] =3D &mas_qxm_ipa,
+	[MASTER_EMAC] =3D &mas_xm_emac,
+	[MASTER_PCIE] =3D &mas_xm_pcie3_0,
+	[MASTER_PCIE_1] =3D &mas_xm_pcie3_1,
+	[MASTER_PCIE_2] =3D &mas_xm_pcie3_2,
+	[MASTER_PCIE_3] =3D &mas_xm_pcie3_3,
+	[MASTER_QDSS_ETR] =3D &mas_xm_qdss_etr,
+	[MASTER_SDCC_2] =3D &mas_xm_sdc2,
+	[MASTER_SDCC_4] =3D &mas_xm_sdc4,
+	[A2NOC_SNOC_SLV] =3D &slv_qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] =3D &slv_qns_pcie_mem_noc,
+	[SLAVE_SERVICE_A2NOC] =3D &slv_srvc_aggre2_noc,
+};
+
+static struct qcom_icc_node *camnoc_virt_nodes[] =3D {
+	[MASTER_CAMNOC_HF0_UNCOMP] =3D &mas_qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_HF1_UNCOMP] =3D &mas_qxm_camnoc_hf1_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] =3D &mas_qxm_camnoc_sf_uncomp,
+	[SLAVE_CAMNOC_UNCOMP] =3D &slv_qns_camnoc_uncomp,
+};
+
+static struct qcom_icc_node *compute_noc_nodes[] =3D {
+	[MASTER_NPU] =3D &mas_qnm_npu,
+	[SLAVE_CDSP_MEM_NOC] =3D &slv_qns_cdsp_mem_noc,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] =3D {
+	[SNOC_CNOC_MAS] =3D &mas_qnm_snoc,
+	[SLAVE_A1NOC_CFG] =3D &slv_qhs_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] =3D &slv_qhs_a2_noc_cfg,
+	[SLAVE_AHB2PHY_CENTER] =3D &slv_qhs_ahb2phy_refgen_center,
+	[SLAVE_AHB2PHY_EAST] =3D &slv_qhs_ahb2phy_refgen_east,
+	[SLAVE_AHB2PHY_WEST] =3D &slv_qhs_ahb2phy_refgen_west,
+	[SLAVE_AHB2PHY_SOUTH] =3D &slv_qhs_ahb2phy_south,
+	[SLAVE_AOP] =3D &slv_qhs_aop,
+	[SLAVE_AOSS] =3D &slv_qhs_aoss,
+	[SLAVE_CAMERA_CFG] =3D &slv_qhs_camera_cfg,
+	[SLAVE_CLK_CTL] =3D &slv_qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] =3D &slv_qhs_compute_dsp,
+	[SLAVE_RBCPR_CX_CFG] =3D &slv_qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] =3D &slv_qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MX_CFG] =3D &slv_qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] =3D &slv_qhs_crypto0_cfg,
+	[SLAVE_CNOC_DDRSS] =3D &slv_qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] =3D &slv_qhs_display_cfg,
+	[SLAVE_EMAC_CFG] =3D &slv_qhs_emac_cfg,
+	[SLAVE_GLM] =3D &slv_qhs_glm,
+	[SLAVE_GRAPHICS_3D_CFG] =3D &slv_qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] =3D &slv_qhs_imem_cfg,
+	[SLAVE_IPA_CFG] =3D &slv_qhs_ipa,
+	[SLAVE_CNOC_MNOC_CFG] =3D &slv_qhs_mnoc_cfg,
+	[SLAVE_NPU_CFG] =3D &slv_qhs_npu_cfg,
+	[SLAVE_PCIE_0_CFG] =3D &slv_qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] =3D &slv_qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] =3D &slv_qhs_pcie2_cfg,
+	[SLAVE_PCIE_3_CFG] =3D &slv_qhs_pcie3_cfg,
+	[SLAVE_PDM] =3D &slv_qhs_pdm,
+	[SLAVE_PIMEM_CFG] =3D &slv_qhs_pimem_cfg,
+	[SLAVE_PRNG] =3D &slv_qhs_prng,
+	[SLAVE_QDSS_CFG] =3D &slv_qhs_qdss_cfg,
+	[SLAVE_QSPI_0] =3D &slv_qhs_qspi_0,
+	[SLAVE_QSPI_1] =3D &slv_qhs_qspi_1,
+	[SLAVE_QUP_1] =3D &slv_qhs_qupv3_east0,
+	[SLAVE_QUP_2] =3D &slv_qhs_qupv3_east1,
+	[SLAVE_QUP_0] =3D &slv_qhs_qupv3_west,
+	[SLAVE_SDCC_2] =3D &slv_qhs_sdc2,
+	[SLAVE_SDCC_4] =3D &slv_qhs_sdc4,
+	[SLAVE_SECURITY] =3D &slv_qhs_security,
+	[SLAVE_SNOC_CFG] =3D &slv_qhs_snoc_cfg,
+	[SLAVE_SPSS_CFG] =3D &slv_qhs_spss_cfg,
+	[SLAVE_TCSR] =3D &slv_qhs_tcsr,
+	[SLAVE_TLMM_EAST] =3D &slv_qhs_tlmm_east,
+	[SLAVE_TLMM_SOUTH] =3D &slv_qhs_tlmm_south,
+	[SLAVE_TLMM_WEST] =3D &slv_qhs_tlmm_west,
+	[SLAVE_TSIF] =3D &slv_qhs_tsif,
+	[SLAVE_UFS_CARD_CFG] =3D &slv_qhs_ufs_card_cfg,
+	[SLAVE_UFS_MEM_0_CFG] =3D &slv_qhs_ufs_mem0_cfg,
+	[SLAVE_UFS_MEM_1_CFG] =3D &slv_qhs_ufs_mem1_cfg,
+	[SLAVE_USB3] =3D &slv_qhs_usb3_0,
+	[SLAVE_USB3_1] =3D &slv_qhs_usb3_1,
+	[SLAVE_USB3_2] =3D &slv_qhs_usb3_2,
+	[SLAVE_VENUS_CFG] =3D &slv_qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] =3D &slv_qhs_vsense_ctrl_cfg,
+	[SLAVE_SERVICE_CNOC] =3D &slv_srvc_cnoc,
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] =3D {
+	[MASTER_CNOC_DC_NOC] =3D &mas_qhm_cnoc_dc_noc,
+	[SLAVE_GEM_NOC_CFG] =3D &slv_qhs_gemnoc,
+	[SLAVE_LLCC_CFG] =3D &slv_qhs_llcc,
+};
+
+static struct qcom_icc_node *gem_noc_nodes[] =3D {
+	[MASTER_AMPSS_M0] =3D &mas_acm_apps,
+	[MASTER_GPU_TCU] =3D &mas_acm_gpu_tcu,
+	[MASTER_SYS_TCU] =3D &mas_acm_sys_tcu,
+	[MASTER_GEM_NOC_CFG] =3D &mas_qhm_gemnoc_cfg,
+	[MASTER_COMPUTE_NOC] =3D &mas_qnm_cmpnoc,
+	[MASTER_GRAPHICS_3D] =3D &mas_qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] =3D &mas_qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &mas_qnm_mnoc_sf,
+	[MASTER_GEM_NOC_PCIE_SNOC] =3D &mas_qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &mas_qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D &mas_qnm_snoc_sf,
+	[MASTER_ECC] =3D &mas_qxm_ecc,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &slv_qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_ECC] =3D &slv_qns_ecc,
+	[SLAVE_GEM_NOC_SNOC] =3D &slv_qns_gem_noc_snoc,
+	[SLAVE_LLCC] =3D &slv_qns_llcc,
+	[SLAVE_SERVICE_GEM_NOC] =3D &slv_srvc_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC_1] =3D &slv_srvc_gemnoc1,
+};
+
+static struct qcom_icc_node *ipa_virt_nodes[] =3D {
+	[MASTER_IPA_CORE] =3D &mas_ipa_core_master,
+	[SLAVE_IPA_CORE] =3D &slv_ipa_core_slave,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] =3D {
+	[MASTER_LLCC] =3D &mas_llcc_mc,
+	[SLAVE_EBI_CH0] =3D &slv_ebi,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] =3D {
+	[MASTER_CNOC_MNOC_CFG] =3D &mas_qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF0] =3D &mas_qxm_camnoc_hf0,
+	[MASTER_CAMNOC_HF1] =3D &mas_qxm_camnoc_hf1,
+	[MASTER_CAMNOC_SF] =3D &mas_qxm_camnoc_sf,
+	[MASTER_MDP_PORT0] =3D &mas_qxm_mdp0,
+	[MASTER_MDP_PORT1] =3D &mas_qxm_mdp1,
+	[MASTER_ROTATOR] =3D &mas_qxm_rot,
+	[MASTER_VIDEO_P0] =3D &mas_qxm_venus0,
+	[MASTER_VIDEO_P1] =3D &mas_qxm_venus1,
+	[MASTER_VIDEO_PROC] =3D &mas_qxm_venus_arm9,
+	[SLAVE_MNOC_SF_MEM_NOC] =3D &slv_qns2_mem_noc,
+	[SLAVE_MNOC_HF_MEM_NOC] =3D &slv_qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC] =3D &slv_srvc_mnoc,
+};
+
+static struct qcom_icc_node *system_noc_nodes[] =3D {
+	[MASTER_SNOC_CFG] =3D &mas_qhm_snoc_cfg,
+	[A1NOC_SNOC_MAS] =3D &mas_qnm_aggre1_noc,
+	[A2NOC_SNOC_MAS] =3D &mas_qnm_aggre2_noc,
+	[MASTER_GEM_NOC_SNOC] =3D &mas_qnm_gemnoc,
+	[MASTER_PIMEM] =3D &mas_qxm_pimem,
+	[MASTER_GIC] =3D &mas_xm_gic,
+	[SLAVE_APPSS] =3D &slv_qhs_apss,
+	[SNOC_CNOC_SLV] =3D &slv_qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_GC] =3D &slv_qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] =3D &slv_qns_gemnoc_sf,
+	[SLAVE_OCIMEM] =3D &slv_qxs_imem,
+	[SLAVE_PIMEM] =3D &slv_qxs_pimem,
+	[SLAVE_SERVICE_SNOC] =3D &slv_srvc_snoc,
+	[SLAVE_QDSS_STM] =3D &slv_xs_qdss_stm,
+	[SLAVE_TCU] =3D &slv_xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sc8180x_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_camnoc_virt =3D {
+	.nodes =3D camnoc_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(camnoc_virt_nodes),
+	.bcms =3D camnoc_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(camnoc_virt_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_compute_noc =3D {
+	.nodes =3D compute_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(compute_noc_nodes),
+	.bcms =3D compute_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(compute_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_config_noc =3D {
+	.nodes =3D config_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(config_noc_nodes),
+	.bcms =3D config_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(config_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_dc_noc =3D {
+	.nodes =3D dc_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(dc_noc_nodes),
+};
+
+static const struct qcom_icc_desc sc8180x_gem_noc  =3D {
+	.nodes =3D gem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gem_noc_nodes),
+	.bcms =3D gem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gem_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_ipa_virt  =3D {
+	.nodes =3D ipa_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(ipa_virt_nodes),
+	.bcms =3D ipa_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(ipa_virt_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_mc_virt  =3D {
+	.nodes =3D mc_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(mc_virt_nodes),
+	.bcms =3D mc_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(mc_virt_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_mmss_noc  =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static const struct qcom_icc_desc sc8180x_system_noc  =3D {
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
+	{ .compatible =3D "qcom,sc8180x-aggre1-noc", .data =3D &sc8180x_aggre1_no=
c },
+	{ .compatible =3D "qcom,sc8180x-aggre2-noc", .data =3D &sc8180x_aggre2_no=
c },
+	{ .compatible =3D "qcom,sc8180x-camnoc-virt", .data =3D &sc8180x_camnoc_v=
irt },
+	{ .compatible =3D "qcom,sc8180x-compute-noc", .data =3D &sc8180x_compute_=
noc, },
+	{ .compatible =3D "qcom,sc8180x-config-noc", .data =3D &sc8180x_config_no=
c },
+	{ .compatible =3D "qcom,sc8180x-dc-noc", .data =3D &sc8180x_dc_noc },
+	{ .compatible =3D "qcom,sc8180x-gem-noc", .data =3D &sc8180x_gem_noc },
+	{ .compatible =3D "qcom,sc8180x-ipa-virt", .data =3D &sc8180x_ipa_virt },
+	{ .compatible =3D "qcom,sc8180x-mc-virt", .data =3D &sc8180x_mc_virt },
+	{ .compatible =3D "qcom,sc8180x-mmss-noc", .data =3D &sc8180x_mmss_noc },
+	{ .compatible =3D "qcom,sc8180x-system-noc", .data =3D &sc8180x_system_no=
c },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+	.probe =3D qnoc_probe,
+	.remove =3D qnoc_remove,
+	.driver =3D {
+		.name =3D "qnoc-sc8180x",
+		.of_match_table =3D qnoc_of_match,
+		.sync_state =3D icc_sync_state,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm sc8180x NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qco=
m/sc8180x.h
new file mode 100644
index 000000000000..fed2dc2d4acb
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm #define SC8180X interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SC8180X_H
+#define __DRIVERS_INTERCONNECT_QCOM_SC8180X_H
+
+#define SC8180X_MASTER_A1NOC_CFG		1
+#define SC8180X_MASTER_UFS_CARD			2
+#define SC8180X_MASTER_UFS_GEN4			3
+#define SC8180X_MASTER_UFS_MEM			4
+#define SC8180X_MASTER_USB3			5
+#define SC8180X_MASTER_USB3_1			6
+#define SC8180X_MASTER_USB3_2			7
+#define SC8180X_MASTER_A2NOC_CFG		8
+#define SC8180X_MASTER_QDSS_BAM			9
+#define SC8180X_MASTER_QSPI_0			10
+#define SC8180X_MASTER_QSPI_1			11
+#define SC8180X_MASTER_QUP_0			12
+#define SC8180X_MASTER_QUP_1			13
+#define SC8180X_MASTER_QUP_2			14
+#define SC8180X_MASTER_SENSORS_AHB		15
+#define SC8180X_MASTER_CRYPTO_CORE_0		16
+#define SC8180X_MASTER_IPA			17
+#define SC8180X_MASTER_EMAC			18
+#define SC8180X_MASTER_PCIE			19
+#define SC8180X_MASTER_PCIE_1			20
+#define SC8180X_MASTER_PCIE_2			21
+#define SC8180X_MASTER_PCIE_3			22
+#define SC8180X_MASTER_QDSS_ETR			23
+#define SC8180X_MASTER_SDCC_2			24
+#define SC8180X_MASTER_SDCC_4			25
+#define SC8180X_MASTER_CAMNOC_HF0_UNCOMP	26
+#define SC8180X_MASTER_CAMNOC_HF1_UNCOMP	27
+#define SC8180X_MASTER_CAMNOC_SF_UNCOMP		28
+#define SC8180X_MASTER_NPU			29
+#define SC8180X_SNOC_CNOC_MAS			30
+#define SC8180X_MASTER_CNOC_DC_NOC		31
+#define SC8180X_MASTER_AMPSS_M0			32
+#define SC8180X_MASTER_GPU_TCU			33
+#define SC8180X_MASTER_SYS_TCU			34
+#define SC8180X_MASTER_GEM_NOC_CFG		35
+#define SC8180X_MASTER_COMPUTE_NOC		36
+#define SC8180X_MASTER_GRAPHICS_3D		37
+#define SC8180X_MASTER_MNOC_HF_MEM_NOC		38
+#define SC8180X_MASTER_MNOC_SF_MEM_NOC		39
+#define SC8180X_MASTER_GEM_NOC_PCIE_SNOC	40
+#define SC8180X_MASTER_SNOC_GC_MEM_NOC		41
+#define SC8180X_MASTER_SNOC_SF_MEM_NOC		42
+#define SC8180X_MASTER_ECC			43
+#define SC8180X_MASTER_IPA_CORE			44
+#define SC8180X_MASTER_LLCC			45
+#define SC8180X_MASTER_CNOC_MNOC_CFG		46
+#define SC8180X_MASTER_CAMNOC_HF0		47
+#define SC8180X_MASTER_CAMNOC_HF1		48
+#define SC8180X_MASTER_CAMNOC_SF		49
+#define SC8180X_MASTER_MDP_PORT0		50
+#define SC8180X_MASTER_MDP_PORT1		51
+#define SC8180X_MASTER_ROTATOR			52
+#define SC8180X_MASTER_VIDEO_P0			53
+#define SC8180X_MASTER_VIDEO_P1			54
+#define SC8180X_MASTER_VIDEO_PROC		55
+#define SC8180X_MASTER_SNOC_CFG			56
+#define SC8180X_A1NOC_SNOC_MAS			57
+#define SC8180X_A2NOC_SNOC_MAS			58
+#define SC8180X_MASTER_GEM_NOC_SNOC		59
+#define SC8180X_MASTER_PIMEM			60
+#define SC8180X_MASTER_GIC			61
+#define SC8180X_MASTER_MNOC_HF_MEM_NOC_DISPLAY	62
+#define SC8180X_MASTER_MNOC_SF_MEM_NOC_DISPLAY	63
+#define SC8180X_MASTER_LLCC_DISPLAY		64
+#define SC8180X_MASTER_MDP_PORT0_DISPLAY	65
+#define SC8180X_MASTER_MDP_PORT1_DISPLAY	66
+#define SC8180X_MASTER_ROTATOR_DISPLAY		67
+#define SC8180X_A1NOC_SNOC_SLV			68
+#define SC8180X_SLAVE_SERVICE_A1NOC		69
+#define SC8180X_A2NOC_SNOC_SLV			70
+#define SC8180X_SLAVE_ANOC_PCIE_GEM_NOC		71
+#define SC8180X_SLAVE_SERVICE_A2NOC		72
+#define SC8180X_SLAVE_CAMNOC_UNCOMP		73
+#define SC8180X_SLAVE_CDSP_MEM_NOC		74
+#define SC8180X_SLAVE_A1NOC_CFG			75
+#define SC8180X_SLAVE_A2NOC_CFG			76
+#define SC8180X_SLAVE_AHB2PHY_CENTER		77
+#define SC8180X_SLAVE_AHB2PHY_EAST		78
+#define SC8180X_SLAVE_AHB2PHY_WEST		79
+#define SC8180X_SLAVE_AHB2PHY_SOUTH		80
+#define SC8180X_SLAVE_AOP			81
+#define SC8180X_SLAVE_AOSS			82
+#define SC8180X_SLAVE_CAMERA_CFG		83
+#define SC8180X_SLAVE_CLK_CTL			84
+#define SC8180X_SLAVE_CDSP_CFG			85
+#define SC8180X_SLAVE_RBCPR_CX_CFG		86
+#define SC8180X_SLAVE_RBCPR_MMCX_CFG		87
+#define SC8180X_SLAVE_RBCPR_MX_CFG		88
+#define SC8180X_SLAVE_CRYPTO_0_CFG		89
+#define SC8180X_SLAVE_CNOC_DDRSS		90
+#define SC8180X_SLAVE_DISPLAY_CFG		91
+#define SC8180X_SLAVE_EMAC_CFG			92
+#define SC8180X_SLAVE_GLM			93
+#define SC8180X_SLAVE_GRAPHICS_3D_CFG		94
+#define SC8180X_SLAVE_IMEM_CFG			95
+#define SC8180X_SLAVE_IPA_CFG			96
+#define SC8180X_SLAVE_CNOC_MNOC_CFG		97
+#define SC8180X_SLAVE_NPU_CFG			98
+#define SC8180X_SLAVE_PCIE_0_CFG		99
+#define SC8180X_SLAVE_PCIE_1_CFG		100
+#define SC8180X_SLAVE_PCIE_2_CFG		101
+#define SC8180X_SLAVE_PCIE_3_CFG		102
+#define SC8180X_SLAVE_PDM			103
+#define SC8180X_SLAVE_PIMEM_CFG			104
+#define SC8180X_SLAVE_PRNG			105
+#define SC8180X_SLAVE_QDSS_CFG			106
+#define SC8180X_SLAVE_QSPI_0			107
+#define SC8180X_SLAVE_QSPI_1			108
+#define SC8180X_SLAVE_QUP_1			109
+#define SC8180X_SLAVE_QUP_2			110
+#define SC8180X_SLAVE_QUP_0			111
+#define SC8180X_SLAVE_SDCC_2			112
+#define SC8180X_SLAVE_SDCC_4			113
+#define SC8180X_SLAVE_SECURITY			114
+#define SC8180X_SLAVE_SNOC_CFG			115
+#define SC8180X_SLAVE_SPSS_CFG			116
+#define SC8180X_SLAVE_TCSR			117
+#define SC8180X_SLAVE_TLMM_EAST			118
+#define SC8180X_SLAVE_TLMM_SOUTH		119
+#define SC8180X_SLAVE_TLMM_WEST			120
+#define SC8180X_SLAVE_TSIF			121
+#define SC8180X_SLAVE_UFS_CARD_CFG		122
+#define SC8180X_SLAVE_UFS_MEM_0_CFG		123
+#define SC8180X_SLAVE_UFS_MEM_1_CFG		124
+#define SC8180X_SLAVE_USB3			125
+#define SC8180X_SLAVE_USB3_1			126
+#define SC8180X_SLAVE_USB3_2			127
+#define SC8180X_SLAVE_VENUS_CFG			128
+#define SC8180X_SLAVE_VSENSE_CTRL_CFG		129
+#define SC8180X_SLAVE_SERVICE_CNOC		130
+#define SC8180X_SLAVE_GEM_NOC_CFG		131
+#define SC8180X_SLAVE_LLCC_CFG			132
+#define SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG	133
+#define SC8180X_SLAVE_ECC			134
+#define SC8180X_SLAVE_GEM_NOC_SNOC		135
+#define SC8180X_SLAVE_LLCC			136
+#define SC8180X_SLAVE_SERVICE_GEM_NOC		137
+#define SC8180X_SLAVE_SERVICE_GEM_NOC_1		138
+#define SC8180X_SLAVE_IPA_CORE			139
+#define SC8180X_SLAVE_EBI_CH0			140
+#define SC8180X_SLAVE_MNOC_SF_MEM_NOC		141
+#define SC8180X_SLAVE_MNOC_HF_MEM_NOC		142
+#define SC8180X_SLAVE_SERVICE_MNOC		143
+#define SC8180X_SLAVE_APPSS			144
+#define SC8180X_SNOC_CNOC_SLV			145
+#define SC8180X_SLAVE_SNOC_GEM_NOC_GC		146
+#define SC8180X_SLAVE_SNOC_GEM_NOC_SF		147
+#define SC8180X_SLAVE_OCIMEM			148
+#define SC8180X_SLAVE_PIMEM			149
+#define SC8180X_SLAVE_SERVICE_SNOC		150
+#define SC8180X_SLAVE_PCIE_0			151
+#define SC8180X_SLAVE_PCIE_1			152
+#define SC8180X_SLAVE_PCIE_2			153
+#define SC8180X_SLAVE_PCIE_3			154
+#define SC8180X_SLAVE_QDSS_STM			155
+#define SC8180X_SLAVE_TCU			156
+#define SC8180X_SLAVE_LLCC_DISPLAY		157
+#define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
+#define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
+#define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
+
+#endif
--=20
2.29.2

