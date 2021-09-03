Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF881400851
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350775AbhICXZf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350770AbhICXZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F1C061575
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c8so1357085lfi.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUkdu7UGjA2OFB74Zoe9X+G2ubB5+YozYf7BNpJaLrM=;
        b=i8ionofUJFXvK8ukRaL1KKbnjwYtXY8SmYuG7YmQXBQWREO2DI7Nf0R2qMHX7MNpg8
         0Xf4FHhKaoYjpI9HG3IX1KxTA1TjJJyDd5cZMweDaiAHxxwVA27gXbKZiuKutEoh0SfU
         K3LJJTsIig/udQzk2kmUgcppj0FLBRFIzsgCexcjFdJYpoF1PKzg8L6F1fcuguJ+ZvD/
         J+BvEd7XyAdaYYxv91Jz5GMneqlh9fOoX5ER1CGFyjaGGYMwXT3eb2rLLYnKPNhCJy7v
         5FMt5UZxCLaFWOwk/6GXTcFKrYUN0ANgidshECEjmz1uPpTihjqUuOAkhxIkppulS44C
         5dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUkdu7UGjA2OFB74Zoe9X+G2ubB5+YozYf7BNpJaLrM=;
        b=YvgMUeOCsMD9aM29lnrpvEtLnXt5gdy6GtLPdJuSdGXaBIy9G/yyyyNvXb2KlHSgFt
         rXBm3Zp1UShYq6FoMsHhjiviQLCjCejiSRmkXuCiN4VQ11Tfls6RIzATmXWh75g+ZIYj
         McJlHtgtfJ2bmHZp3oCyZlDKfCpiC9sXcPSgaG6QqCaUuyfVUyfqMDoHfmSXdySATapd
         B1rrFOkifQ8dLWqyEaUNeeiNkWtiIUAzGIorl5YV+HO1Ue3hT5waB6Qb+99dqnA8UP81
         qb4MmaOk/UtwVmsdxhcs7sxWyet48DYYMq1UINHv2dr5hE+yxbsdzezkEEa70r0khF6C
         UiAg==
X-Gm-Message-State: AOAM531fYOkcv+tKIW5EHr/1UGL0mXFq/8q7LEoK5nc8HFpSC95FgZa7
        Q33PdiwtW1njuW1k7yd5V8/+fD5kqN9RCQ==
X-Google-Smtp-Source: ABdhPJycsQJQpjVjz5y6AkkVBM8kquJ9Mxm1MC8AjqAcofepAYvPizBEuErhna7jaIMDs4zTWXbNXw==
X-Received: by 2002:a05:6512:3408:: with SMTP id i8mr918942lfr.659.1630711472171;
        Fri, 03 Sep 2021 16:24:32 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:31 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 10/11] interconnect: qcs404: expand DEFINE_QNODE macros
Date:   Sat,  4 Sep 2021 02:24:20 +0300
Message-Id: <20210903232421.1384199-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To follow the example of the rest of icc-rpm.h drivers, expand
DEFINE_QNODE macros in the driver.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 954 ++++++++++++++++++++++++++---
 1 file changed, 881 insertions(+), 73 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 0f2fff230b13..416c8bff8efa 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -92,79 +92,887 @@ enum {
 	QCS404_SLAVE_LPASS,
 };
 
-DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_snoc_bimc_1, QCS404_SNOC_BIMC_1_MAS, 8, 76, -1, QCS404_SLAVE_EBI_CH0);
-DEFINE_QNODE(mas_tcu_0, QCS404_MASTER_TCU_0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_spdm, QCS404_MASTER_SPDM, 4, -1, -1, QCS404_PNOC_INT_3);
-DEFINE_QNODE(mas_blsp_1, QCS404_MASTER_BLSP_1, 4, 41, -1, QCS404_PNOC_INT_3);
-DEFINE_QNODE(mas_blsp_2, QCS404_MASTER_BLSP_2, 4, 39, -1, QCS404_PNOC_INT_3);
-DEFINE_QNODE(mas_xi_usb_hs1, QCS404_MASTER_XM_USB_HS1, 8, 138, -1, QCS404_PNOC_INT_0);
-DEFINE_QNODE(mas_crypto, QCS404_MASTER_CRYPTO_CORE0, 8, 23, -1, QCS404_PNOC_SNOC_SLV, QCS404_PNOC_INT_2);
-DEFINE_QNODE(mas_sdcc_1, QCS404_MASTER_SDCC_1, 8, 33, -1, QCS404_PNOC_INT_0);
-DEFINE_QNODE(mas_sdcc_2, QCS404_MASTER_SDCC_2, 8, 35, -1, QCS404_PNOC_INT_0);
-DEFINE_QNODE(mas_snoc_pcnoc, QCS404_SNOC_PNOC_MAS, 8, 77, -1, QCS404_PNOC_INT_2);
-DEFINE_QNODE(mas_qpic, QCS404_MASTER_QPIC, 4, -1, -1, QCS404_PNOC_INT_0);
-DEFINE_QNODE(mas_qdss_bam, QCS404_MASTER_QDSS_BAM, 4, -1, -1, QCS404_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_bimc_snoc, QCS404_BIMC_SNOC_MAS, 8, 21, -1, QCS404_SLAVE_OCMEM_64, QCS404_SLAVE_CATS_128, QCS404_SNOC_INT_0, QCS404_SNOC_INT_1);
-DEFINE_QNODE(mas_pcnoc_snoc, QCS404_PNOC_SNOC_MAS, 8, 29, -1, QCS404_SNOC_BIMC_1_SLV, QCS404_SNOC_INT_2, QCS404_SNOC_INT_0);
-DEFINE_QNODE(mas_qdss_etr, QCS404_MASTER_QDSS_ETR, 8, -1, -1, QCS404_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_emac, QCS404_MASTER_EMAC, 8, -1, -1, QCS404_SNOC_BIMC_1_SLV, QCS404_SNOC_INT_1);
-DEFINE_QNODE(mas_pcie, QCS404_MASTER_PCIE, 8, -1, -1, QCS404_SNOC_BIMC_1_SLV, QCS404_SNOC_INT_1);
-DEFINE_QNODE(mas_usb3, QCS404_MASTER_USB3, 8, -1, -1, QCS404_SNOC_BIMC_1_SLV, QCS404_SNOC_INT_1);
-DEFINE_QNODE(pcnoc_int_0, QCS404_PNOC_INT_0, 8, 85, 114, QCS404_PNOC_SNOC_SLV, QCS404_PNOC_INT_2);
-DEFINE_QNODE(pcnoc_int_2, QCS404_PNOC_INT_2, 8, 124, 184, QCS404_PNOC_SLV_10, QCS404_SLAVE_TCU, QCS404_PNOC_SLV_11, QCS404_PNOC_SLV_2, QCS404_PNOC_SLV_3, QCS404_PNOC_SLV_0, QCS404_PNOC_SLV_1, QCS404_PNOC_SLV_6, QCS404_PNOC_SLV_7, QCS404_PNOC_SLV_4, QCS404_PNOC_SLV_8, QCS404_PNOC_SLV_9);
-DEFINE_QNODE(pcnoc_int_3, QCS404_PNOC_INT_3, 8, 125, 185, QCS404_PNOC_SNOC_SLV);
-DEFINE_QNODE(pcnoc_s_0, QCS404_PNOC_SLV_0, 4, 89, 118, QCS404_SLAVE_PRNG, QCS404_SLAVE_SPDM_WRAPPER, QCS404_SLAVE_PDM);
-DEFINE_QNODE(pcnoc_s_1, QCS404_PNOC_SLV_1, 4, 90, 119, QCS404_SLAVE_TCSR);
-DEFINE_QNODE(pcnoc_s_2, QCS404_PNOC_SLV_2, 4, -1, -1, QCS404_SLAVE_GRAPHICS_3D_CFG);
-DEFINE_QNODE(pcnoc_s_3, QCS404_PNOC_SLV_3, 4, 92, 121, QCS404_SLAVE_MESSAGE_RAM);
-DEFINE_QNODE(pcnoc_s_4, QCS404_PNOC_SLV_4, 4, 93, 122, QCS404_SLAVE_SNOC_CFG);
-DEFINE_QNODE(pcnoc_s_6, QCS404_PNOC_SLV_6, 4, 94, 123, QCS404_SLAVE_BLSP_1, QCS404_SLAVE_TLMM_NORTH, QCS404_SLAVE_EMAC_CFG);
-DEFINE_QNODE(pcnoc_s_7, QCS404_PNOC_SLV_7, 4, 95, 124, QCS404_SLAVE_TLMM_SOUTH, QCS404_SLAVE_DISPLAY_CFG, QCS404_SLAVE_SDCC_1, QCS404_SLAVE_PCIE_1, QCS404_SLAVE_SDCC_2);
-DEFINE_QNODE(pcnoc_s_8, QCS404_PNOC_SLV_8, 4, 96, 125, QCS404_SLAVE_CRYPTO_0_CFG);
-DEFINE_QNODE(pcnoc_s_9, QCS404_PNOC_SLV_9, 4, 97, 126, QCS404_SLAVE_BLSP_2, QCS404_SLAVE_TLMM_EAST, QCS404_SLAVE_PMIC_ARB);
-DEFINE_QNODE(pcnoc_s_10, QCS404_PNOC_SLV_10, 4, 157, -1, QCS404_SLAVE_USB_HS);
-DEFINE_QNODE(pcnoc_s_11, QCS404_PNOC_SLV_11, 4, 158, 246, QCS404_SLAVE_USB3);
-DEFINE_QNODE(qdss_int, QCS404_SNOC_QDSS_INT, 8, -1, -1, QCS404_SNOC_BIMC_1_SLV, QCS404_SNOC_INT_1);
-DEFINE_QNODE(snoc_int_0, QCS404_SNOC_INT_0, 8, 99, 130, QCS404_SLAVE_LPASS, QCS404_SLAVE_APPSS, QCS404_SLAVE_WCSS);
-DEFINE_QNODE(snoc_int_1, QCS404_SNOC_INT_1, 8, 100, 131, QCS404_SNOC_PNOC_SLV, QCS404_SNOC_INT_2);
-DEFINE_QNODE(snoc_int_2, QCS404_SNOC_INT_2, 8, 134, 197, QCS404_SLAVE_QDSS_STM, QCS404_SLAVE_OCIMEM);
-DEFINE_QNODE(slv_ebi, QCS404_SLAVE_EBI_CH0, 8, -1, 0, 0);
-DEFINE_QNODE(slv_bimc_snoc, QCS404_BIMC_SNOC_SLV, 8, -1, 2, QCS404_BIMC_SNOC_MAS);
-DEFINE_QNODE(slv_spdm, QCS404_SLAVE_SPDM_WRAPPER, 4, -1, -1, 0);
-DEFINE_QNODE(slv_pdm, QCS404_SLAVE_PDM, 4, -1, 41, 0);
-DEFINE_QNODE(slv_prng, QCS404_SLAVE_PRNG, 4, -1, 44, 0);
-DEFINE_QNODE(slv_tcsr, QCS404_SLAVE_TCSR, 4, -1, 50, 0);
-DEFINE_QNODE(slv_snoc_cfg, QCS404_SLAVE_SNOC_CFG, 4, -1, 70, 0);
-DEFINE_QNODE(slv_message_ram, QCS404_SLAVE_MESSAGE_RAM, 4, -1, 55, 0);
-DEFINE_QNODE(slv_disp_ss_cfg, QCS404_SLAVE_DISPLAY_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_gpu_cfg, QCS404_SLAVE_GRAPHICS_3D_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_blsp_1, QCS404_SLAVE_BLSP_1, 4, -1, 39, 0);
-DEFINE_QNODE(slv_tlmm_north, QCS404_SLAVE_TLMM_NORTH, 4, -1, 214, 0);
-DEFINE_QNODE(slv_pcie, QCS404_SLAVE_PCIE_1, 4, -1, -1, 0);
-DEFINE_QNODE(slv_ethernet, QCS404_SLAVE_EMAC_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_blsp_2, QCS404_SLAVE_BLSP_2, 4, -1, 37, 0);
-DEFINE_QNODE(slv_tlmm_east, QCS404_SLAVE_TLMM_EAST, 4, -1, 213, 0);
-DEFINE_QNODE(slv_tcu, QCS404_SLAVE_TCU, 8, -1, -1, 0);
-DEFINE_QNODE(slv_pmic_arb, QCS404_SLAVE_PMIC_ARB, 4, -1, 59, 0);
-DEFINE_QNODE(slv_sdcc_1, QCS404_SLAVE_SDCC_1, 4, -1, 31, 0);
-DEFINE_QNODE(slv_sdcc_2, QCS404_SLAVE_SDCC_2, 4, -1, 33, 0);
-DEFINE_QNODE(slv_tlmm_south, QCS404_SLAVE_TLMM_SOUTH, 4, -1, -1, 0);
-DEFINE_QNODE(slv_usb_hs, QCS404_SLAVE_USB_HS, 4, -1, 40, 0);
-DEFINE_QNODE(slv_usb3, QCS404_SLAVE_USB3, 4, -1, 22, 0);
-DEFINE_QNODE(slv_crypto_0_cfg, QCS404_SLAVE_CRYPTO_0_CFG, 4, -1, 52, 0);
-DEFINE_QNODE(slv_pcnoc_snoc, QCS404_PNOC_SNOC_SLV, 8, -1, 45, QCS404_PNOC_SNOC_MAS);
-DEFINE_QNODE(slv_kpss_ahb, QCS404_SLAVE_APPSS, 4, -1, -1, 0);
-DEFINE_QNODE(slv_wcss, QCS404_SLAVE_WCSS, 4, -1, 23, 0);
-DEFINE_QNODE(slv_snoc_bimc_1, QCS404_SNOC_BIMC_1_SLV, 8, -1, 104, QCS404_SNOC_BIMC_1_MAS);
-DEFINE_QNODE(slv_imem, QCS404_SLAVE_OCIMEM, 8, -1, 26, 0);
-DEFINE_QNODE(slv_snoc_pcnoc, QCS404_SNOC_PNOC_SLV, 8, -1, 28, QCS404_SNOC_PNOC_MAS);
-DEFINE_QNODE(slv_qdss_stm, QCS404_SLAVE_QDSS_STM, 4, -1, 30, 0);
-DEFINE_QNODE(slv_cats_0, QCS404_SLAVE_CATS_128, 16, -1, -1, 0);
-DEFINE_QNODE(slv_cats_1, QCS404_SLAVE_OCMEM_64, 8, -1, -1, 0);
-DEFINE_QNODE(slv_lpass, QCS404_SLAVE_LPASS, 4, -1, -1, 0);
+static const u16 mas_apps_proc_links[] = {
+	QCS404_SLAVE_EBI_CH0,
+	QCS404_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_apps_proc = {
+	.name = "mas_apps_proc",
+	.id = QCS404_MASTER_AMPSS_M0,
+	.buswidth = 8,
+	.mas_rpm_id = 0,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_apps_proc_links),
+	.links = mas_apps_proc_links,
+};
+
+static const u16 mas_oxili_links[] = {
+	QCS404_SLAVE_EBI_CH0,
+	QCS404_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_oxili = {
+	.name = "mas_oxili",
+	.id = QCS404_MASTER_GRAPHICS_3D,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_oxili_links),
+	.links = mas_oxili_links,
+};
+
+static const u16 mas_mdp_links[] = {
+	QCS404_SLAVE_EBI_CH0,
+	QCS404_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_mdp = {
+	.name = "mas_mdp",
+	.id = QCS404_MASTER_MDP_PORT0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_mdp_links),
+	.links = mas_mdp_links,
+};
+
+static const u16 mas_snoc_bimc_1_links[] = {
+	QCS404_SLAVE_EBI_CH0
+};
+
+static struct qcom_icc_node mas_snoc_bimc_1 = {
+	.name = "mas_snoc_bimc_1",
+	.id = QCS404_SNOC_BIMC_1_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 76,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_1_links),
+	.links = mas_snoc_bimc_1_links,
+};
+
+static const u16 mas_tcu_0_links[] = {
+	QCS404_SLAVE_EBI_CH0,
+	QCS404_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_tcu_0 = {
+	.name = "mas_tcu_0",
+	.id = QCS404_MASTER_TCU_0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_tcu_0_links),
+	.links = mas_tcu_0_links,
+};
+
+static const u16 mas_spdm_links[] = {
+	QCS404_PNOC_INT_3
+};
+
+static struct qcom_icc_node mas_spdm = {
+	.name = "mas_spdm",
+	.id = QCS404_MASTER_SPDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_spdm_links),
+	.links = mas_spdm_links,
+};
+
+static const u16 mas_blsp_1_links[] = {
+	QCS404_PNOC_INT_3
+};
+
+static struct qcom_icc_node mas_blsp_1 = {
+	.name = "mas_blsp_1",
+	.id = QCS404_MASTER_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = 41,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_1_links),
+	.links = mas_blsp_1_links,
+};
+
+static const u16 mas_blsp_2_links[] = {
+	QCS404_PNOC_INT_3
+};
+
+static struct qcom_icc_node mas_blsp_2 = {
+	.name = "mas_blsp_2",
+	.id = QCS404_MASTER_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = 39,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_2_links),
+	.links = mas_blsp_2_links,
+};
+
+static const u16 mas_xi_usb_hs1_links[] = {
+	QCS404_PNOC_INT_0
+};
+
+static struct qcom_icc_node mas_xi_usb_hs1 = {
+	.name = "mas_xi_usb_hs1",
+	.id = QCS404_MASTER_XM_USB_HS1,
+	.buswidth = 8,
+	.mas_rpm_id = 138,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_xi_usb_hs1_links),
+	.links = mas_xi_usb_hs1_links,
+};
+
+static const u16 mas_crypto_links[] = {
+	QCS404_PNOC_SNOC_SLV,
+	QCS404_PNOC_INT_2
+};
+
+static struct qcom_icc_node mas_crypto = {
+	.name = "mas_crypto",
+	.id = QCS404_MASTER_CRYPTO_CORE0,
+	.buswidth = 8,
+	.mas_rpm_id = 23,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_crypto_links),
+	.links = mas_crypto_links,
+};
+
+static const u16 mas_sdcc_1_links[] = {
+	QCS404_PNOC_INT_0
+};
+
+static struct qcom_icc_node mas_sdcc_1 = {
+	.name = "mas_sdcc_1",
+	.id = QCS404_MASTER_SDCC_1,
+	.buswidth = 8,
+	.mas_rpm_id = 33,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
+	.links = mas_sdcc_1_links,
+};
+
+static const u16 mas_sdcc_2_links[] = {
+	QCS404_PNOC_INT_0
+};
+
+static struct qcom_icc_node mas_sdcc_2 = {
+	.name = "mas_sdcc_2",
+	.id = QCS404_MASTER_SDCC_2,
+	.buswidth = 8,
+	.mas_rpm_id = 35,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
+	.links = mas_sdcc_2_links,
+};
+
+static const u16 mas_snoc_pcnoc_links[] = {
+	QCS404_PNOC_INT_2
+};
+
+static struct qcom_icc_node mas_snoc_pcnoc = {
+	.name = "mas_snoc_pcnoc",
+	.id = QCS404_SNOC_PNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 77,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_pcnoc_links),
+	.links = mas_snoc_pcnoc_links,
+};
+
+static const u16 mas_qpic_links[] = {
+	QCS404_PNOC_INT_0
+};
+
+static struct qcom_icc_node mas_qpic = {
+	.name = "mas_qpic",
+	.id = QCS404_MASTER_QPIC,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qpic_links),
+	.links = mas_qpic_links,
+};
+
+static const u16 mas_qdss_bam_links[] = {
+	QCS404_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.name = "mas_qdss_bam",
+	.id = QCS404_MASTER_QDSS_BAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
+	.links = mas_qdss_bam_links,
+};
+
+static const u16 mas_bimc_snoc_links[] = {
+	QCS404_SLAVE_OCMEM_64,
+	QCS404_SLAVE_CATS_128,
+	QCS404_SNOC_INT_0,
+	QCS404_SNOC_INT_1
+};
+
+static struct qcom_icc_node mas_bimc_snoc = {
+	.name = "mas_bimc_snoc",
+	.id = QCS404_BIMC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 21,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_bimc_snoc_links),
+	.links = mas_bimc_snoc_links,
+};
+
+static const u16 mas_pcnoc_snoc_links[] = {
+	QCS404_SNOC_BIMC_1_SLV,
+	QCS404_SNOC_INT_2,
+	QCS404_SNOC_INT_0
+};
+
+static struct qcom_icc_node mas_pcnoc_snoc = {
+	.name = "mas_pcnoc_snoc",
+	.id = QCS404_PNOC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 29,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcnoc_snoc_links),
+	.links = mas_pcnoc_snoc_links,
+};
+
+static const u16 mas_qdss_etr_links[] = {
+	QCS404_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.name = "mas_qdss_etr",
+	.id = QCS404_MASTER_QDSS_ETR,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
+	.links = mas_qdss_etr_links,
+};
+
+static const u16 mas_emac_links[] = {
+	QCS404_SNOC_BIMC_1_SLV,
+	QCS404_SNOC_INT_1
+};
+
+static struct qcom_icc_node mas_emac = {
+	.name = "mas_emac",
+	.id = QCS404_MASTER_EMAC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_emac_links),
+	.links = mas_emac_links,
+};
+
+static const u16 mas_pcie_links[] = {
+	QCS404_SNOC_BIMC_1_SLV,
+	QCS404_SNOC_INT_1
+};
+
+static struct qcom_icc_node mas_pcie = {
+	.name = "mas_pcie",
+	.id = QCS404_MASTER_PCIE,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcie_links),
+	.links = mas_pcie_links,
+};
+
+static const u16 mas_usb3_links[] = {
+	QCS404_SNOC_BIMC_1_SLV,
+	QCS404_SNOC_INT_1
+};
+
+static struct qcom_icc_node mas_usb3 = {
+	.name = "mas_usb3",
+	.id = QCS404_MASTER_USB3,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_usb3_links),
+	.links = mas_usb3_links,
+};
+
+static const u16 pcnoc_int_0_links[] = {
+	QCS404_PNOC_SNOC_SLV,
+	QCS404_PNOC_INT_2
+};
+
+static struct qcom_icc_node pcnoc_int_0 = {
+	.name = "pcnoc_int_0",
+	.id = QCS404_PNOC_INT_0,
+	.buswidth = 8,
+	.mas_rpm_id = 85,
+	.slv_rpm_id = 114,
+	.num_links = ARRAY_SIZE(pcnoc_int_0_links),
+	.links = pcnoc_int_0_links,
+};
+
+static const u16 pcnoc_int_2_links[] = {
+	QCS404_PNOC_SLV_10,
+	QCS404_SLAVE_TCU,
+	QCS404_PNOC_SLV_11,
+	QCS404_PNOC_SLV_2,
+	QCS404_PNOC_SLV_3,
+	QCS404_PNOC_SLV_0,
+	QCS404_PNOC_SLV_1,
+	QCS404_PNOC_SLV_6,
+	QCS404_PNOC_SLV_7,
+	QCS404_PNOC_SLV_4,
+	QCS404_PNOC_SLV_8,
+	QCS404_PNOC_SLV_9
+};
+
+static struct qcom_icc_node pcnoc_int_2 = {
+	.name = "pcnoc_int_2",
+	.id = QCS404_PNOC_INT_2,
+	.buswidth = 8,
+	.mas_rpm_id = 124,
+	.slv_rpm_id = 184,
+	.num_links = ARRAY_SIZE(pcnoc_int_2_links),
+	.links = pcnoc_int_2_links,
+};
+
+static const u16 pcnoc_int_3_links[] = {
+	QCS404_PNOC_SNOC_SLV
+};
+
+static struct qcom_icc_node pcnoc_int_3 = {
+	.name = "pcnoc_int_3",
+	.id = QCS404_PNOC_INT_3,
+	.buswidth = 8,
+	.mas_rpm_id = 125,
+	.slv_rpm_id = 185,
+	.num_links = ARRAY_SIZE(pcnoc_int_3_links),
+	.links = pcnoc_int_3_links,
+};
+
+static const u16 pcnoc_s_0_links[] = {
+	QCS404_SLAVE_PRNG,
+	QCS404_SLAVE_SPDM_WRAPPER,
+	QCS404_SLAVE_PDM
+};
+
+static struct qcom_icc_node pcnoc_s_0 = {
+	.name = "pcnoc_s_0",
+	.id = QCS404_PNOC_SLV_0,
+	.buswidth = 4,
+	.mas_rpm_id = 89,
+	.slv_rpm_id = 118,
+	.num_links = ARRAY_SIZE(pcnoc_s_0_links),
+	.links = pcnoc_s_0_links,
+};
+
+static const u16 pcnoc_s_1_links[] = {
+	QCS404_SLAVE_TCSR
+};
+
+static struct qcom_icc_node pcnoc_s_1 = {
+	.name = "pcnoc_s_1",
+	.id = QCS404_PNOC_SLV_1,
+	.buswidth = 4,
+	.mas_rpm_id = 90,
+	.slv_rpm_id = 119,
+	.num_links = ARRAY_SIZE(pcnoc_s_1_links),
+	.links = pcnoc_s_1_links,
+};
+
+static const u16 pcnoc_s_2_links[] = {
+	QCS404_SLAVE_GRAPHICS_3D_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_2 = {
+	.name = "pcnoc_s_2",
+	.id = QCS404_PNOC_SLV_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_2_links),
+	.links = pcnoc_s_2_links,
+};
+
+static const u16 pcnoc_s_3_links[] = {
+	QCS404_SLAVE_MESSAGE_RAM
+};
+
+static struct qcom_icc_node pcnoc_s_3 = {
+	.name = "pcnoc_s_3",
+	.id = QCS404_PNOC_SLV_3,
+	.buswidth = 4,
+	.mas_rpm_id = 92,
+	.slv_rpm_id = 121,
+	.num_links = ARRAY_SIZE(pcnoc_s_3_links),
+	.links = pcnoc_s_3_links,
+};
+
+static const u16 pcnoc_s_4_links[] = {
+	QCS404_SLAVE_SNOC_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_4 = {
+	.name = "pcnoc_s_4",
+	.id = QCS404_PNOC_SLV_4,
+	.buswidth = 4,
+	.mas_rpm_id = 93,
+	.slv_rpm_id = 122,
+	.num_links = ARRAY_SIZE(pcnoc_s_4_links),
+	.links = pcnoc_s_4_links,
+};
+
+static const u16 pcnoc_s_6_links[] = {
+	QCS404_SLAVE_BLSP_1,
+	QCS404_SLAVE_TLMM_NORTH,
+	QCS404_SLAVE_EMAC_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_6 = {
+	.name = "pcnoc_s_6",
+	.id = QCS404_PNOC_SLV_6,
+	.buswidth = 4,
+	.mas_rpm_id = 94,
+	.slv_rpm_id = 123,
+	.num_links = ARRAY_SIZE(pcnoc_s_6_links),
+	.links = pcnoc_s_6_links,
+};
+
+static const u16 pcnoc_s_7_links[] = {
+	QCS404_SLAVE_TLMM_SOUTH,
+	QCS404_SLAVE_DISPLAY_CFG,
+	QCS404_SLAVE_SDCC_1,
+	QCS404_SLAVE_PCIE_1,
+	QCS404_SLAVE_SDCC_2
+};
+
+static struct qcom_icc_node pcnoc_s_7 = {
+	.name = "pcnoc_s_7",
+	.id = QCS404_PNOC_SLV_7,
+	.buswidth = 4,
+	.mas_rpm_id = 95,
+	.slv_rpm_id = 124,
+	.num_links = ARRAY_SIZE(pcnoc_s_7_links),
+	.links = pcnoc_s_7_links,
+};
+
+static const u16 pcnoc_s_8_links[] = {
+	QCS404_SLAVE_CRYPTO_0_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_8 = {
+	.name = "pcnoc_s_8",
+	.id = QCS404_PNOC_SLV_8,
+	.buswidth = 4,
+	.mas_rpm_id = 96,
+	.slv_rpm_id = 125,
+	.num_links = ARRAY_SIZE(pcnoc_s_8_links),
+	.links = pcnoc_s_8_links,
+};
+
+static const u16 pcnoc_s_9_links[] = {
+	QCS404_SLAVE_BLSP_2,
+	QCS404_SLAVE_TLMM_EAST,
+	QCS404_SLAVE_PMIC_ARB
+};
+
+static struct qcom_icc_node pcnoc_s_9 = {
+	.name = "pcnoc_s_9",
+	.id = QCS404_PNOC_SLV_9,
+	.buswidth = 4,
+	.mas_rpm_id = 97,
+	.slv_rpm_id = 126,
+	.num_links = ARRAY_SIZE(pcnoc_s_9_links),
+	.links = pcnoc_s_9_links,
+};
+
+static const u16 pcnoc_s_10_links[] = {
+	QCS404_SLAVE_USB_HS
+};
+
+static struct qcom_icc_node pcnoc_s_10 = {
+	.name = "pcnoc_s_10",
+	.id = QCS404_PNOC_SLV_10,
+	.buswidth = 4,
+	.mas_rpm_id = 157,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_10_links),
+	.links = pcnoc_s_10_links,
+};
+
+static const u16 pcnoc_s_11_links[] = {
+	QCS404_SLAVE_USB3
+};
+
+static struct qcom_icc_node pcnoc_s_11 = {
+	.name = "pcnoc_s_11",
+	.id = QCS404_PNOC_SLV_11,
+	.buswidth = 4,
+	.mas_rpm_id = 158,
+	.slv_rpm_id = 246,
+	.num_links = ARRAY_SIZE(pcnoc_s_11_links),
+	.links = pcnoc_s_11_links,
+};
+
+static const u16 qdss_int_links[] = {
+	QCS404_SNOC_BIMC_1_SLV,
+	QCS404_SNOC_INT_1
+};
+
+static struct qcom_icc_node qdss_int = {
+	.name = "qdss_int",
+	.id = QCS404_SNOC_QDSS_INT,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(qdss_int_links),
+	.links = qdss_int_links,
+};
+
+static const u16 snoc_int_0_links[] = {
+	QCS404_SLAVE_LPASS,
+	QCS404_SLAVE_APPSS,
+	QCS404_SLAVE_WCSS
+};
+
+static struct qcom_icc_node snoc_int_0 = {
+	.name = "snoc_int_0",
+	.id = QCS404_SNOC_INT_0,
+	.buswidth = 8,
+	.mas_rpm_id = 99,
+	.slv_rpm_id = 130,
+	.num_links = ARRAY_SIZE(snoc_int_0_links),
+	.links = snoc_int_0_links,
+};
+
+static const u16 snoc_int_1_links[] = {
+	QCS404_SNOC_PNOC_SLV,
+	QCS404_SNOC_INT_2
+};
+
+static struct qcom_icc_node snoc_int_1 = {
+	.name = "snoc_int_1",
+	.id = QCS404_SNOC_INT_1,
+	.buswidth = 8,
+	.mas_rpm_id = 100,
+	.slv_rpm_id = 131,
+	.num_links = ARRAY_SIZE(snoc_int_1_links),
+	.links = snoc_int_1_links,
+};
+
+static const u16 snoc_int_2_links[] = {
+	QCS404_SLAVE_QDSS_STM,
+	QCS404_SLAVE_OCIMEM
+};
+
+static struct qcom_icc_node snoc_int_2 = {
+	.name = "snoc_int_2",
+	.id = QCS404_SNOC_INT_2,
+	.buswidth = 8,
+	.mas_rpm_id = 134,
+	.slv_rpm_id = 197,
+	.num_links = ARRAY_SIZE(snoc_int_2_links),
+	.links = snoc_int_2_links,
+};
+
+static struct qcom_icc_node slv_ebi = {
+	.name = "slv_ebi",
+	.id = QCS404_SLAVE_EBI_CH0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+};
+
+static const u16 slv_bimc_snoc_links[] = {
+	QCS404_BIMC_SNOC_MAS
+};
+
+static struct qcom_icc_node slv_bimc_snoc = {
+	.name = "slv_bimc_snoc",
+	.id = QCS404_BIMC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 2,
+	.num_links = ARRAY_SIZE(slv_bimc_snoc_links),
+	.links = slv_bimc_snoc_links,
+};
+
+static struct qcom_icc_node slv_spdm = {
+	.name = "slv_spdm",
+	.id = QCS404_SLAVE_SPDM_WRAPPER,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slv_pdm",
+	.id = QCS404_SLAVE_PDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 41,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slv_prng",
+	.id = QCS404_SLAVE_PRNG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 44,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slv_tcsr",
+	.id = QCS404_SLAVE_TCSR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 50,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slv_snoc_cfg",
+	.id = QCS404_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 70,
+};
+
+static struct qcom_icc_node slv_message_ram = {
+	.name = "slv_message_ram",
+	.id = QCS404_SLAVE_MESSAGE_RAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 55,
+};
+
+static struct qcom_icc_node slv_disp_ss_cfg = {
+	.name = "slv_disp_ss_cfg",
+	.id = QCS404_SLAVE_DISPLAY_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_gpu_cfg = {
+	.name = "slv_gpu_cfg",
+	.id = QCS404_SLAVE_GRAPHICS_3D_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_blsp_1 = {
+	.name = "slv_blsp_1",
+	.id = QCS404_SLAVE_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 39,
+};
+
+static struct qcom_icc_node slv_tlmm_north = {
+	.name = "slv_tlmm_north",
+	.id = QCS404_SLAVE_TLMM_NORTH,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 214,
+};
+
+static struct qcom_icc_node slv_pcie = {
+	.name = "slv_pcie",
+	.id = QCS404_SLAVE_PCIE_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_ethernet = {
+	.name = "slv_ethernet",
+	.id = QCS404_SLAVE_EMAC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_blsp_2 = {
+	.name = "slv_blsp_2",
+	.id = QCS404_SLAVE_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 37,
+};
+
+static struct qcom_icc_node slv_tlmm_east = {
+	.name = "slv_tlmm_east",
+	.id = QCS404_SLAVE_TLMM_EAST,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 213,
+};
+
+static struct qcom_icc_node slv_tcu = {
+	.name = "slv_tcu",
+	.id = QCS404_SLAVE_TCU,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slv_pmic_arb",
+	.id = QCS404_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 59,
+};
+
+static struct qcom_icc_node slv_sdcc_1 = {
+	.name = "slv_sdcc_1",
+	.id = QCS404_SLAVE_SDCC_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 31,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slv_sdcc_2",
+	.id = QCS404_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 33,
+};
+
+static struct qcom_icc_node slv_tlmm_south = {
+	.name = "slv_tlmm_south",
+	.id = QCS404_SLAVE_TLMM_SOUTH,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_usb_hs = {
+	.name = "slv_usb_hs",
+	.id = QCS404_SLAVE_USB_HS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 40,
+};
+
+static struct qcom_icc_node slv_usb3 = {
+	.name = "slv_usb3",
+	.id = QCS404_SLAVE_USB3,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 22,
+};
+
+static struct qcom_icc_node slv_crypto_0_cfg = {
+	.name = "slv_crypto_0_cfg",
+	.id = QCS404_SLAVE_CRYPTO_0_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 52,
+};
+
+static const u16 slv_pcnoc_snoc_links[] = {
+	QCS404_PNOC_SNOC_MAS
+};
+
+static struct qcom_icc_node slv_pcnoc_snoc = {
+	.name = "slv_pcnoc_snoc",
+	.id = QCS404_PNOC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 45,
+	.num_links = ARRAY_SIZE(slv_pcnoc_snoc_links),
+	.links = slv_pcnoc_snoc_links,
+};
+
+static struct qcom_icc_node slv_kpss_ahb = {
+	.name = "slv_kpss_ahb",
+	.id = QCS404_SLAVE_APPSS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_wcss = {
+	.name = "slv_wcss",
+	.id = QCS404_SLAVE_WCSS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 23,
+};
+
+static const u16 slv_snoc_bimc_1_links[] = {
+	QCS404_SNOC_BIMC_1_MAS
+};
+
+static struct qcom_icc_node slv_snoc_bimc_1 = {
+	.name = "slv_snoc_bimc_1",
+	.id = QCS404_SNOC_BIMC_1_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 104,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_1_links),
+	.links = slv_snoc_bimc_1_links,
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slv_imem",
+	.id = QCS404_SLAVE_OCIMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+};
+
+static const u16 slv_snoc_pcnoc_links[] = {
+	QCS404_SNOC_PNOC_MAS
+};
+
+static struct qcom_icc_node slv_snoc_pcnoc = {
+	.name = "slv_snoc_pcnoc",
+	.id = QCS404_SNOC_PNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 28,
+	.num_links = ARRAY_SIZE(slv_snoc_pcnoc_links),
+	.links = slv_snoc_pcnoc_links,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slv_qdss_stm",
+	.id = QCS404_SLAVE_QDSS_STM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+};
+
+static struct qcom_icc_node slv_cats_0 = {
+	.name = "slv_cats_0",
+	.id = QCS404_SLAVE_CATS_128,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_cats_1 = {
+	.name = "slv_cats_1",
+	.id = QCS404_SLAVE_OCMEM_64,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_lpass = {
+	.name = "slv_lpass",
+	.id = QCS404_SLAVE_LPASS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
 
 static struct qcom_icc_node *qcs404_bimc_nodes[] = {
 	[MASTER_AMPSS_M0] = &mas_apps_proc,
-- 
2.33.0

