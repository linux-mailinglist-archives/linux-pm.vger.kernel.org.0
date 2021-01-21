Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8882D2FE1E7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 06:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhAUFmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 00:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAUFeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 00:34:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C221C061799
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 21:33:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y12so879704pji.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 21:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/QbepqunTR8sSfY8Zl4LqYBbvnEo5hWzdRctw7goMM=;
        b=LJLVaIMvkxtXIJD2p3enBvZlczqkgsGqHz++5PTaq7/IuR+VBsSiqPEEyMIPY/Iyn2
         99Qdd+WBWDquMckQsaLKMdJBXhdoXowD4iGc1KXKfoBrA8Act4OfDgfscNyb+wdI4Hc3
         /Tm+GgWOFlisLLElDdl+Imtubq1XvSk54mfuoo9dVWobehSlVhY7cye8iJxfG+xDbY4p
         UGM5dnhtNHnMHnMCILjJeiE9wEkVc9EryjFHqOXivrWypzY6BdFVI/H447B8tl/iDrQl
         hLJyhj8lXtoaKOlKWoJoK/kfbsmzQLU4ae7rBKSG/S1PVUxH+LzzdEeb6crmocZH8zMS
         Jzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/QbepqunTR8sSfY8Zl4LqYBbvnEo5hWzdRctw7goMM=;
        b=joBs1V+m+5IPWcr/bO3IfsouYxnO7/8bh8aAg4gbYTlSnLW+G9Kiw//bHcV+2wlZhY
         0SM89my9mdqYdUOQlDw3fb9wwDi+4epoxAwVjbPN9IZQiRVKwyZnv5BHit9X9UB+v8Ib
         RjljbjtSRrEhNNSLW0mP8w+sEiN1TDTsdAn8hgITh3xm3t6vNZnxW4sAfiilAI9ZuBuX
         hZJ1nkKgwK7Oi57RgdBa6qG4ZD7ch/jzoB+Rvp0xVkDYexDkFV8BewyChMmePApBmlY1
         tTmb4OxhznPyZhSKrU1M97kicAid7O6SE6bLk2T97qd1fbbsff77oZ3zYwXSG3dzHeJl
         LQwQ==
X-Gm-Message-State: AOAM5327IoqeofO+O0MOPZL/gEEFBUEnQAFp/NDM/BOvXLcchE82JiMD
        WAHJWQOYTHRhL1SbLNG+Jy81
X-Google-Smtp-Source: ABdhPJzjoDHDJc/bJ6iirhXOvNAQ1pBrQOyiFvGuZzBSrXdAhvn1BVsLXZ4vD1BKcJAAoxNAnF7xJg==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr9538602pjo.189.1611207202742;
        Wed, 20 Jan 2021 21:33:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id o14sm4332850pgr.44.2021.01.20.21.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 21:33:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] interconnect: qcom: Add SDX55 interconnect provider driver
Date:   Thu, 21 Jan 2021 11:02:54 +0530
Message-Id: <20210121053254.8355-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121053254.8355-1-manivannan.sadhasivam@linaro.org>
References: <20210121053254.8355-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SDX55 based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Based on SM8250 driver and generated from downstream dts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/interconnect/qcom/Kconfig  |   9 +
 drivers/interconnect/qcom/Makefile |   2 +
 drivers/interconnect/qcom/sdx55.c  | 356 +++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sdx55.h  |  70 ++++++
 4 files changed, 437 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdx55.c
 create mode 100644 drivers/interconnect/qcom/sdx55.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b3fb5b02bcf1..165e65174ab2 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -74,6 +74,15 @@ config INTERCONNECT_QCOM_SDM845
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SDX55
+	tristate "Qualcomm SDX55 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sdx55-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index cf628f7990cd..981a5ea45af9 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -8,6 +8,7 @@ qnoc-qcs404-objs			:= qcs404.o
 icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sc7180-objs			:= sc7180.o
 qnoc-sdm845-objs			:= sdm845.o
+qnoc-sdx55-objs				:= sdx55.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
 icc-smd-rpm-objs			:= smd-rpm.o
@@ -20,6 +21,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
new file mode 100644
index 000000000000..aa2382fd1c60
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm SDX55 interconnect driver
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * Copyright (c) 2021, Linaro Ltd.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sdx55.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sdx55.h"
+
+DEFINE_QNODE(ipa_core_master, SDX55_MASTER_IPA_CORE, 1, 8, SDX55_SLAVE_IPA_CORE);
+DEFINE_QNODE(llcc_mc, SDX55_MASTER_LLCC, 4, 4, SDX55_SLAVE_EBI_CH0);
+DEFINE_QNODE(acm_tcu, SDX55_MASTER_TCU_0, 1, 8, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qnm_snoc_gc, SDX55_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDX55_SLAVE_LLCC);
+DEFINE_QNODE(xm_apps_rdwr, SDX55_MASTER_AMPSS_M0, 1, 16, SDX55_SLAVE_LLCC, SDX55_SLAVE_MEM_NOC_SNOC, SDX55_SLAVE_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhm_audio, SDX55_MASTER_AUDIO, 1, 4, SDX55_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qhm_blsp1, SDX55_MASTER_BLSP_1, 1, 4, SDX55_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(qhm_qdss_bam, SDX55_MASTER_QDSS_BAM, 1, 4, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
+DEFINE_QNODE(qhm_qpic, SDX55_MASTER_QPIC, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
+DEFINE_QNODE(qhm_snoc_cfg, SDX55_MASTER_SNOC_CFG, 1, 4, SDX55_SLAVE_SERVICE_SNOC);
+DEFINE_QNODE(qhm_spmi_fetcher1, SDX55_MASTER_SPMI_FETCHER, 1, 4, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
+DEFINE_QNODE(qnm_aggre_noc, SDX55_MASTER_ANOC_SNOC, 1, 8, SDX55_SLAVE_PCIE_0, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_USB3, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
+DEFINE_QNODE(qnm_ipa, SDX55_MASTER_IPA, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_TLMM, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
+DEFINE_QNODE(qnm_memnoc, SDX55_MASTER_MEM_NOC_SNOC, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_TLMM, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QDSS_STM, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_APPSS,  SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
+DEFINE_QNODE(qnm_memnoc_pcie, SDX55_MASTER_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_SLAVE_PCIE_0);
+DEFINE_QNODE(qxm_crypto, SDX55_MASTER_CRYPTO_CORE_0, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP);
+DEFINE_QNODE(xm_emac, SDX55_MASTER_EMAC, 1, 8, SDX55_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(xm_ipa2pcie_slv, SDX55_MASTER_IPA_PCIE, 1, 8, SDX55_SLAVE_PCIE_0);
+DEFINE_QNODE(xm_pcie, SDX55_MASTER_PCIE, 1, 8, SDX55_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(xm_qdss_etr, SDX55_MASTER_QDSS_ETR, 1, 8, SDX55_SLAVE_SNOC_CFG, SDX55_SLAVE_EMAC_CFG, SDX55_SLAVE_USB3, SDX55_SLAVE_AOSS, SDX55_SLAVE_SPMI_FETCHER, SDX55_SLAVE_QDSS_CFG, SDX55_SLAVE_PDM, SDX55_SLAVE_SNOC_MEM_NOC_GC, SDX55_SLAVE_TCSR, SDX55_SLAVE_CNOC_DDRSS, SDX55_SLAVE_SPMI_VGI_COEX, SDX55_SLAVE_QPIC, SDX55_SLAVE_OCIMEM, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_USB3_PHY_CFG, SDX55_SLAVE_AOP, SDX55_SLAVE_BLSP_1, SDX55_SLAVE_SDCC_1, SDX55_SLAVE_CNOC_MSS, SDX55_SLAVE_PCIE_PARF, SDX55_SLAVE_ECC_CFG, SDX55_SLAVE_AUDIO, SDX55_SLAVE_AOSS, SDX55_SLAVE_PRNG, SDX55_SLAVE_CRYPTO_0_CFG, SDX55_SLAVE_TCU, SDX55_SLAVE_CLK_CTL, SDX55_SLAVE_IMEM_CFG);
+DEFINE_QNODE(xm_sdc1, SDX55_MASTER_SDCC_1, 1, 8, SDX55_SLAVE_AOSS, SDX55_SLAVE_IPA_CFG, SDX55_SLAVE_ANOC_SNOC, SDX55_SLAVE_AOP, SDX55_SLAVE_AUDIO);
+DEFINE_QNODE(xm_usb3, SDX55_MASTER_USB3, 1, 8, SDX55_SLAVE_ANOC_SNOC);
+DEFINE_QNODE(ipa_core_slave, SDX55_SLAVE_IPA_CORE, 1, 8);
+DEFINE_QNODE(ebi, SDX55_SLAVE_EBI_CH0, 1, 4);
+DEFINE_QNODE(qns_llcc, SDX55_SLAVE_LLCC, 1, 16, SDX55_SLAVE_EBI_CH0);
+DEFINE_QNODE(qns_memnoc_snoc, SDX55_SLAVE_MEM_NOC_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_SNOC);
+DEFINE_QNODE(qns_sys_pcie, SDX55_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SDX55_MASTER_MEM_NOC_PCIE_SNOC);
+DEFINE_QNODE(qhs_aop, SDX55_SLAVE_AOP, 1, 4);
+DEFINE_QNODE(qhs_aoss, SDX55_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_apss, SDX55_SLAVE_APPSS, 1, 4);
+DEFINE_QNODE(qhs_audio, SDX55_SLAVE_AUDIO, 1, 4);
+DEFINE_QNODE(qhs_blsp1, SDX55_SLAVE_BLSP_1, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SDX55_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SDX55_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_ddrss_cfg, SDX55_SLAVE_CNOC_DDRSS, 1, 4);
+DEFINE_QNODE(qhs_ecc_cfg, SDX55_SLAVE_ECC_CFG, 1, 4);
+DEFINE_QNODE(qhs_emac_cfg, SDX55_SLAVE_EMAC_CFG, 1, 4);
+DEFINE_QNODE(qhs_imem_cfg, SDX55_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SDX55_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_mss_cfg, SDX55_SLAVE_CNOC_MSS, 1, 4);
+DEFINE_QNODE(qhs_pcie_parf, SDX55_SLAVE_PCIE_PARF, 1, 4);
+DEFINE_QNODE(qhs_pdm, SDX55_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_prng, SDX55_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SDX55_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qpic, SDX55_SLAVE_QPIC, 1, 4);
+DEFINE_QNODE(qhs_sdc1, SDX55_SLAVE_SDCC_1, 1, 4);
+DEFINE_QNODE(qhs_snoc_cfg, SDX55_SLAVE_SNOC_CFG, 1, 4, SDX55_MASTER_SNOC_CFG);
+DEFINE_QNODE(qhs_spmi_fetcher, SDX55_SLAVE_SPMI_FETCHER, 1, 4);
+DEFINE_QNODE(qhs_spmi_vgi_coex, SDX55_SLAVE_SPMI_VGI_COEX, 1, 4);
+DEFINE_QNODE(qhs_tcsr, SDX55_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_tlmm, SDX55_SLAVE_TLMM, 1, 4);
+DEFINE_QNODE(qhs_usb3, SDX55_SLAVE_USB3, 1, 4);
+DEFINE_QNODE(qhs_usb3_phy, SDX55_SLAVE_USB3_PHY_CFG, 1, 4);
+DEFINE_QNODE(qns_aggre_noc, SDX55_SLAVE_ANOC_SNOC, 1, 8, SDX55_MASTER_ANOC_SNOC);
+DEFINE_QNODE(qns_snoc_memnoc, SDX55_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDX55_MASTER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qxs_imem, SDX55_SLAVE_OCIMEM, 1, 8);
+DEFINE_QNODE(srvc_snoc, SDX55_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(xs_pcie, SDX55_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(xs_qdss_stm, SDX55_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SDX55_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
+DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
+DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
+DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
+DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
+DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_sys_tcu_cfg);
+DEFINE_QBCM(bcm_pn5, "PN5", false, &qxm_crypto);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie);
+DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3,
+	    &qns_aggre_noc);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &qhm_qdss_bam, &xm_qdss_etr);
+DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc);
+DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_memnoc_pcie);
+DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_ipa, &xm_ipa2pcie_slv);
+
+static struct qcom_icc_bcm *mc_virt_bcms[] = {
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI_CH0] = &ebi,
+};
+
+const static struct qcom_icc_desc sdx55_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm *mem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh3,
+	&bcm_sh4,
+};
+
+static struct qcom_icc_node *mem_noc_nodes[] = {
+	[MASTER_TCU_0] = &acm_tcu,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_AMPSS_M0] = &xm_apps_rdwr,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_SNOC] = &qns_memnoc_snoc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_sys_pcie,
+};
+
+const static struct qcom_icc_desc sdx55_mem_noc = {
+	.nodes = mem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
+	.bcms = mem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_pn0,
+	&bcm_pn1,
+	&bcm_pn2,
+	&bcm_pn3,
+	&bcm_pn5,
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn6,
+	&bcm_sn7,
+	&bcm_sn8,
+	&bcm_sn9,
+	&bcm_sn10,
+	&bcm_sn11,
+};
+
+static struct qcom_icc_node *system_noc_nodes[] = {
+	[MASTER_AUDIO] = &qhm_audio,
+	[MASTER_BLSP_1] = &qhm_blsp1,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QPIC] = &qhm_qpic,
+	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
+	[MASTER_SPMI_FETCHER] = &qhm_spmi_fetcher1,
+	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
+	[MASTER_IPA] = &qnm_ipa,
+	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
+	[MASTER_MEM_NOC_PCIE_SNOC] = &qnm_memnoc_pcie,
+	[MASTER_CRYPTO_CORE_0] = &qxm_crypto,
+	[MASTER_EMAC] = &xm_emac,
+	[MASTER_IPA_PCIE] = &xm_ipa2pcie_slv,
+	[MASTER_PCIE] = &xm_pcie,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_USB3] = &xm_usb3,
+	[SLAVE_AOP] = &qhs_aop,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_AUDIO] = &qhs_audio,
+	[SLAVE_BLSP_1] = &qhs_blsp1,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
+	[SLAVE_ECC_CFG] = &qhs_ecc_cfg,
+	[SLAVE_EMAC_CFG] = &qhs_emac_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_PCIE_PARF] = &qhs_pcie_parf,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QPIC] = &qhs_qpic,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
+	[SLAVE_SPMI_FETCHER] = &qhs_spmi_fetcher,
+	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
+	[SLAVE_ANOC_SNOC] = &qns_aggre_noc,
+	[SLAVE_SNOC_MEM_NOC_GC] = &qns_snoc_memnoc,
+	[SLAVE_OCIMEM] = &qxs_imem,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+	[SLAVE_PCIE_0] = &xs_pcie,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+const static struct qcom_icc_desc sdx55_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static struct qcom_icc_bcm *ipa_virt_bcms[] = {
+	&bcm_ip0,
+};
+
+static struct qcom_icc_node *ipa_virt_nodes[] = {
+	[MASTER_IPA_CORE] = &ipa_core_master,
+	[SLAVE_IPA_CORE] = &ipa_core_slave,
+};
+
+const static struct qcom_icc_desc sdx55_ipa_virt = {
+	.nodes = ipa_virt_nodes,
+	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
+	.bcms = ipa_virt_bcms,
+	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
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
+	desc = device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider = &qp->provider;
+	provider->dev = &pdev->dev;
+	provider->set = qcom_icc_set;
+	provider->pre_aggregate = qcom_icc_pre_aggregate;
+	provider->aggregate = qcom_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = data;
+
+	qp->dev = &pdev->dev;
+	qp->bcms = desc->bcms;
+	qp->num_bcms = desc->num_bcms;
+
+	qp->voter = of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter))
+		return PTR_ERR(qp->voter);
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
+
+		if (!qnodes[i])
+			continue;
+
+		node = icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qnodes[i]->name;
+		node->data = qnodes[i];
+		icc_node_add(node, provider);
+
+		for (j = 0; j < qnodes[i]->num_links; j++)
+			icc_link_create(node, qnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
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
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sdx55-mc-virt",
+	  .data = &sdx55_mc_virt},
+	{ .compatible = "qcom,sdx55-mem-noc",
+	  .data = &sdx55_mem_noc},
+	{ .compatible = "qcom,sdx55-system-noc",
+	  .data = &sdx55_system_noc},
+	{ .compatible = "qcom,sdx55-ipa-virt",
+	  .data = &sdx55_ipa_virt},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-sdx55",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm SDX55 NoC driver");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sdx55.h b/drivers/interconnect/qcom/sdx55.h
new file mode 100644
index 000000000000..deff8afe0631
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx55.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, Linaro Ltd.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX55_H
+#define __DRIVERS_INTERCONNECT_QCOM_SDX55_H
+
+#define SDX55_MASTER_IPA_CORE			0
+#define SDX55_MASTER_LLCC			1
+#define SDX55_MASTER_TCU_0			2
+#define SDX55_MASTER_SNOC_GC_MEM_NOC		3
+#define SDX55_MASTER_AMPSS_M0			4
+#define SDX55_MASTER_AUDIO			5
+#define SDX55_MASTER_BLSP_1			6
+#define SDX55_MASTER_QDSS_BAM			7
+#define SDX55_MASTER_QPIC			8
+#define SDX55_MASTER_SNOC_CFG			9
+#define SDX55_MASTER_SPMI_FETCHER		10
+#define SDX55_MASTER_ANOC_SNOC			11
+#define SDX55_MASTER_IPA			12
+#define SDX55_MASTER_MEM_NOC_SNOC		13
+#define SDX55_MASTER_MEM_NOC_PCIE_SNOC		14
+#define SDX55_MASTER_CRYPTO_CORE_0		15
+#define SDX55_MASTER_EMAC			16
+#define SDX55_MASTER_IPA_PCIE			17
+#define SDX55_MASTER_PCIE			18
+#define SDX55_MASTER_QDSS_ETR			19
+#define SDX55_MASTER_SDCC_1			20
+#define SDX55_MASTER_USB3			21
+#define SDX55_SLAVE_IPA_CORE			22
+#define SDX55_SLAVE_EBI_CH0			23
+#define SDX55_SLAVE_LLCC			24
+#define SDX55_SLAVE_MEM_NOC_SNOC		25
+#define SDX55_SLAVE_MEM_NOC_PCIE_SNOC		26
+#define SDX55_SLAVE_ANOC_SNOC			27
+#define SDX55_SLAVE_SNOC_CFG			28
+#define SDX55_SLAVE_EMAC_CFG			29
+#define SDX55_SLAVE_USB3			30
+#define SDX55_SLAVE_TLMM			31
+#define SDX55_SLAVE_SPMI_FETCHER		32
+#define SDX55_SLAVE_QDSS_CFG			33
+#define SDX55_SLAVE_PDM				34
+#define SDX55_SLAVE_SNOC_MEM_NOC_GC		35
+#define SDX55_SLAVE_TCSR			36
+#define SDX55_SLAVE_CNOC_DDRSS			37
+#define SDX55_SLAVE_SPMI_VGI_COEX		38
+#define SDX55_SLAVE_QPIC			39
+#define SDX55_SLAVE_OCIMEM			40
+#define SDX55_SLAVE_IPA_CFG			41
+#define SDX55_SLAVE_USB3_PHY_CFG		42
+#define SDX55_SLAVE_AOP				43
+#define SDX55_SLAVE_BLSP_1			44
+#define SDX55_SLAVE_SDCC_1			45
+#define SDX55_SLAVE_CNOC_MSS			46
+#define SDX55_SLAVE_PCIE_PARF			47
+#define SDX55_SLAVE_ECC_CFG			48
+#define SDX55_SLAVE_AUDIO			49
+#define SDX55_SLAVE_AOSS			51
+#define SDX55_SLAVE_PRNG			52
+#define SDX55_SLAVE_CRYPTO_0_CFG		53
+#define SDX55_SLAVE_TCU				54
+#define SDX55_SLAVE_CLK_CTL			55
+#define SDX55_SLAVE_IMEM_CFG			56
+#define SDX55_SLAVE_SERVICE_SNOC		57
+#define SDX55_SLAVE_PCIE_0			58
+#define SDX55_SLAVE_QDSS_STM			59
+#define SDX55_SLAVE_APPSS			60
+
+#endif
-- 
2.25.1

