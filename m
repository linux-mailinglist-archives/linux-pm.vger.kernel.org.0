Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE03EF7C1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhHRB6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbhHRB6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:58:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A9C0617AE
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i28so1189398lfl.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAa975XO/QOsubBnKjHJFLCaQ4DHVbvprW8/Xr7WVog=;
        b=cWzNnFljwwMtu8JR2HdrRcCOF2nZ9hRb6L15sRt+QhXH0v6UapZZqlu9LSBTEyrdyv
         MZV7TrJda8rIf5z/eQKRTbp5QMgM7V/Exd1z5lT342F+qYhellXUIpbks9b4uQsWu/OV
         Vxbc9UfxH5upvmzUL13+Xkv4x8BUFd8O7skSaY408H9jQMOly5hvuqhdB2KgRDucYqjG
         xRYUewCZNg4mgvIeGfpXC/MsmC+qqyY3pbE9acP5L9vGDbSoRUDEmX8LLhlo7wymQD17
         4uUxl37s8ffg42E7bgrmv28goQmCeUmn10u3pscyqZYNvf4ynJk/4iDXnWljYAx+tewD
         BISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAa975XO/QOsubBnKjHJFLCaQ4DHVbvprW8/Xr7WVog=;
        b=Y5CPfpBG3wmrtA+NhrqBFa9rq9qe37GDsklaxZwftsQhRXlzGjUJ+B8uapj/ilBAF5
         iQKrmPf1RW5x5gcLIOBUqbuLrbp9ULawIW5Zw2ISJhkhG1LwAuT57kuTRr7zDx5shB2H
         pW1ET/+LtZNO5Rg/Sq6eJ5fwDZBUWt93+LjUmmsgyNJas02ze4wy1NpT0jhUihzsa3Gd
         XADZlE6qlTVG9B/cO/RoWcIbtLr9UuW1rsfBuOmIesh9MjKcuZpQP/bEPAcgNGACeqh8
         aWTpLcfUhtVO4LNbUcaDWGpsVOa5pWS5AQUHoIAlZyOjayKgueozxHRWETtwhukJ4rzD
         z4rQ==
X-Gm-Message-State: AOAM530ZoaBjoBmogcvbzAJdc2LEOYFsXbCLtRZO9RL7R77I/jU8OYhP
        0BtzANqYzIOUdtJbwJCn/BeD3g==
X-Google-Smtp-Source: ABdhPJyj25+MTZz2Lw9ZqWAmF3G3sYb3fmVX5IyTDtXxbgMJGps65phhCmA+n/PcyQ6QSYk53kDu7Q==
X-Received: by 2002:a05:6512:33c7:: with SMTP id d7mr4603039lfg.545.1629251857379;
        Tue, 17 Aug 2021 18:57:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y8sm349500lfh.249.2021.08.17.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:57:37 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/5] interconnect: msm8916: add support for AP-owned nodes
Date:   Wed, 18 Aug 2021 04:57:31 +0300
Message-Id: <20210818015732.1717810-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
References: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Port support for AP-owned nodes from the downstream device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 70 +++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index fc0d48d2997a..680ec3190c23 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/of_device.h>
 
 #include <dt-bindings/interconnect/qcom,msm8916.h>
@@ -105,31 +106,31 @@ enum {
 	MSM8916_SNOC_PNOC_SLV,
 };
 
-DEFINE_QNODE(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, MSM8916_BIMC_SNOC_SLV);
-DEFINE_QNODE(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
-DEFINE_QNODE(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE_AP(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, -1, 0, -1, MSM8916_BIMC_SNOC_SLV);
+DEFINE_QNODE_AP(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, -1, 0, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
+DEFINE_QNODE_AP(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, NOC_QOS_MODE_FIXED, 0, 0, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
 DEFINE_QNODE(mas_audio, MSM8916_MASTER_LPASS, 4, -1, -1, MSM8916_PNOC_MAS_0);
 DEFINE_QNODE(mas_blsp_1, MSM8916_MASTER_BLSP_1, 4, -1, -1, MSM8916_PNOC_MAS_1);
 DEFINE_QNODE(mas_dehr, MSM8916_MASTER_DEHR, 4, -1, -1, MSM8916_PNOC_MAS_0);
-DEFINE_QNODE(mas_gfx, MSM8916_MASTER_GRAPHICS_3D, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_jpeg, MSM8916_MASTER_JPEG, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mas_mdp, MSM8916_MASTER_MDP_PORT0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE_AP(mas_gfx, MSM8916_MASTER_GRAPHICS_3D, 8, -1, -1, NOC_QOS_MODE_FIXED, 0, 2, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE_AP(mas_jpeg, MSM8916_MASTER_JPEG, 16, -1, -1, NOC_QOS_MODE_BYPASS, 0, 6, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE_AP(mas_mdp, MSM8916_MASTER_MDP_PORT0, 16, -1, -1, NOC_QOS_MODE_BYPASS, 0, 7, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
 DEFINE_QNODE(mas_pcnoc_crypto_0, MSM8916_MASTER_CRYPTO_CORE0, 8, -1, -1, MSM8916_PNOC_INT_1);
 DEFINE_QNODE(mas_pcnoc_sdcc_1, MSM8916_MASTER_SDCC_1, 8, -1, -1, MSM8916_PNOC_INT_1);
 DEFINE_QNODE(mas_pcnoc_sdcc_2, MSM8916_MASTER_SDCC_2, 8, -1, -1, MSM8916_PNOC_INT_1);
-DEFINE_QNODE(mas_qdss_bam, MSM8916_MASTER_QDSS_BAM, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_qdss_etr, MSM8916_MASTER_QDSS_ETR, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
+DEFINE_QNODE_AP(mas_qdss_bam, MSM8916_MASTER_QDSS_BAM, 8, -1, -1, NOC_QOS_MODE_FIXED, 1, 11, MSM8916_SNOC_QDSS_INT);
+DEFINE_QNODE_AP(mas_qdss_etr, MSM8916_MASTER_QDSS_ETR, 8, -1, -1, NOC_QOS_MODE_FIXED, 1, 10, MSM8916_SNOC_QDSS_INT);
 DEFINE_QNODE(mas_snoc_cfg, MSM8916_MASTER_SNOC_CFG, 4, -1, -1, MSM8916_SNOC_QDSS_INT);
 DEFINE_QNODE(mas_spdm, MSM8916_MASTER_SPDM, 4, -1, -1, MSM8916_PNOC_MAS_0);
-DEFINE_QNODE(mas_tcu0, MSM8916_MASTER_TCU0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_tcu1, MSM8916_MASTER_TCU1, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE_AP(mas_tcu0, MSM8916_MASTER_TCU0, 8, -1, -1, NOC_QOS_MODE_FIXED, 2, 5, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE_AP(mas_tcu1, MSM8916_MASTER_TCU1, 8, -1, -1, NOC_QOS_MODE_FIXED, 2, 6, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
 DEFINE_QNODE(mas_usb_hs, MSM8916_MASTER_USB_HS, 4, -1, -1, MSM8916_PNOC_MAS_1);
-DEFINE_QNODE(mas_vfe, MSM8916_MASTER_VFE, 16, -1, -1, MSM8916_SNOC_MM_INT_1, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mas_video, MSM8916_MASTER_VIDEO_P0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mm_int_0, MSM8916_SNOC_MM_INT_0, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
-DEFINE_QNODE(mm_int_1, MSM8916_SNOC_MM_INT_1, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
-DEFINE_QNODE(mm_int_2, MSM8916_SNOC_MM_INT_2, 16, -1, -1, MSM8916_SNOC_INT_0);
-DEFINE_QNODE(mm_int_bimc, MSM8916_SNOC_MM_INT_BIMC, 16, -1, -1, MSM8916_SNOC_BIMC_1_MAS);
+DEFINE_QNODE_AP(mas_vfe, MSM8916_MASTER_VFE, 16, -1, -1, NOC_QOS_MODE_BYPASS, 0, 9, MSM8916_SNOC_MM_INT_1, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE_AP(mas_video, MSM8916_MASTER_VIDEO_P0, 16, -1, -1, NOC_QOS_MODE_BYPASS, 0, 8, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE_AP(mm_int_0, MSM8916_SNOC_MM_INT_0, 16, -1, -1, -1, 0, -1, MSM8916_SNOC_MM_INT_BIMC);
+DEFINE_QNODE_AP(mm_int_1, MSM8916_SNOC_MM_INT_1, 16, -1, -1, -1, 0, -1, MSM8916_SNOC_MM_INT_BIMC);
+DEFINE_QNODE_AP(mm_int_2, MSM8916_SNOC_MM_INT_2, 16, -1, -1, -1, 0, -1, MSM8916_SNOC_INT_0);
+DEFINE_QNODE_AP(mm_int_bimc, MSM8916_SNOC_MM_INT_BIMC, 16, -1, -1, -1, 0, -1, MSM8916_SNOC_BIMC_1_MAS);
 DEFINE_QNODE(pcnoc_int_0, MSM8916_PNOC_INT_0, 8, -1, -1, MSM8916_PNOC_SNOC_MAS, MSM8916_PNOC_SLV_0, MSM8916_PNOC_SLV_1, MSM8916_PNOC_SLV_2, MSM8916_PNOC_SLV_3, MSM8916_PNOC_SLV_4, MSM8916_PNOC_SLV_8, MSM8916_PNOC_SLV_9);
 DEFINE_QNODE(pcnoc_int_1, MSM8916_PNOC_INT_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
 DEFINE_QNODE(pcnoc_m_0, MSM8916_PNOC_MAS_0, 8, -1, -1, MSM8916_PNOC_INT_0);
@@ -143,7 +144,7 @@ DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 4, -1, -1, MSM8916_SLAVE_USB_HS, MSM
 DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 4, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
 DEFINE_QNODE(pcnoc_snoc_mas, MSM8916_PNOC_SNOC_MAS, 8, 29, -1, MSM8916_PNOC_SNOC_SLV);
 DEFINE_QNODE(pcnoc_snoc_slv, MSM8916_PNOC_SNOC_SLV, 8, -1, 45, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC, MSM8916_SNOC_INT_1);
-DEFINE_QNODE(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
+DEFINE_QNODE_AP(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, -1, 0, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
 DEFINE_QNODE(slv_apps_l2, MSM8916_SLAVE_AMPSS_L2, 8, -1, -1, 0);
 DEFINE_QNODE(slv_apss, MSM8916_SLAVE_APSS, 4, -1, -1, 0);
 DEFINE_QNODE(slv_audio, MSM8916_SLAVE_LPASS, 4, -1, -1, 0);
@@ -183,8 +184,8 @@ DEFINE_QNODE(slv_usb_hs, MSM8916_SLAVE_USB_HS, 4, -1, -1, 0);
 DEFINE_QNODE(slv_venus_cfg, MSM8916_SLAVE_VENUS_CFG, 4, -1, -1, 0);
 DEFINE_QNODE(snoc_bimc_0_mas, MSM8916_SNOC_BIMC_0_MAS, 8, 3, -1, MSM8916_SNOC_BIMC_0_SLV);
 DEFINE_QNODE(snoc_bimc_0_slv, MSM8916_SNOC_BIMC_0_SLV, 8, -1, 24, MSM8916_SLAVE_EBI_CH0);
-DEFINE_QNODE(snoc_bimc_1_mas, MSM8916_SNOC_BIMC_1_MAS, 16, -1, -1, MSM8916_SNOC_BIMC_1_SLV);
-DEFINE_QNODE(snoc_bimc_1_slv, MSM8916_SNOC_BIMC_1_SLV, 8, -1, -1, MSM8916_SLAVE_EBI_CH0);
+DEFINE_QNODE_AP(snoc_bimc_1_mas, MSM8916_SNOC_BIMC_1_MAS, 16, -1, -1, -1, 0, -1, MSM8916_SNOC_BIMC_1_SLV);
+DEFINE_QNODE_AP(snoc_bimc_1_slv, MSM8916_SNOC_BIMC_1_SLV, 8, -1, -1, -1, 0, -1, MSM8916_SLAVE_EBI_CH0);
 DEFINE_QNODE(snoc_int_0, MSM8916_SNOC_INT_0, 8, 99, 130, MSM8916_SLAVE_QDSS_STM, MSM8916_SLAVE_IMEM, MSM8916_SNOC_PNOC_MAS);
 DEFINE_QNODE(snoc_int_1, MSM8916_SNOC_INT_1, 8, -1, -1, MSM8916_SLAVE_APSS, MSM8916_SLAVE_CATS_128, MSM8916_SLAVE_OCMEM_64);
 DEFINE_QNODE(snoc_int_bimc, MSM8916_SNOC_INT_BIMC, 8, 101, 132, MSM8916_SNOC_BIMC_0_MAS);
@@ -220,9 +221,19 @@ static struct qcom_icc_node *msm8916_snoc_nodes[] = {
 	[SNOC_QDSS_INT] = &qdss_int,
 };
 
+static const struct regmap_config msm8916_snoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x14000,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8916_snoc = {
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+	.regmap_cfg = &msm8916_snoc_regmap_config,
+	.qos_offset = 0x7000,
 };
 
 static struct qcom_icc_node *msm8916_bimc_nodes[] = {
@@ -237,9 +248,20 @@ static struct qcom_icc_node *msm8916_bimc_nodes[] = {
 	[SNOC_BIMC_1_SLV] = &snoc_bimc_1_slv,
 };
 
+static const struct regmap_config msm8916_bimc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x62000,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8916_bimc = {
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+	.is_bimc_node = true,
+	.regmap_cfg = &msm8916_bimc_regmap_config,
+	.qos_offset = 0x8000,
 };
 
 static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
@@ -295,9 +317,19 @@ static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
 	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
 };
 
+static const struct regmap_config msm8916_pcnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x11000,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8916_pcnoc = {
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+	.regmap_cfg = &msm8916_pcnoc_regmap_config,
+	.qos_offset = 0x7000,
 };
 
 static const struct of_device_id msm8916_noc_of_match[] = {
-- 
2.32.0

