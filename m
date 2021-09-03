Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7D400848
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350755AbhICXZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350760AbhICXZb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AAAC0613CF
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k13so1357240lfv.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BK0nmG2Nn2tbXUcW+f0zKb3IRo/TN9Pu/HCMinwTCJo=;
        b=YfQ4Q+I9ZUnc6bJsYEPBcQ8oHtCtpqWiVnm+5wCdB+BDNtQPvyZBwZSH9XAjMW0VBo
         xSlA2/0wUchqtfQvS6x3xMx8cV7rWHDhrhqea3IGJB/DqWGLd+8lpDuTmFtDqN7hMzw1
         kPz6ORiyqaRFKoMNfbimugj8qjeppY4b51Lbd/aLtj6EXfvmYARQmuKVFXljYI4HZfRt
         pSJQA3IvPTZky1sD09SR5FFGv3hVbiyM1YYEjztcUedaya2CuFwllXJk+w7IFN4skZXh
         wUDjdUH0ndG//JsnXq2lBhDixAFN0PbxuW1eIEhiTswhB5QAcI/rFwcaMSIOVvq3GLO+
         HCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BK0nmG2Nn2tbXUcW+f0zKb3IRo/TN9Pu/HCMinwTCJo=;
        b=JJHg5VDe+w97EuLRJmIxrTkPKD69H5tqX7uSYlLYkt7OLKHOt+/CaR/2Sf8dfR4fxM
         p7EZ2LkhG64em9us/9PRt1hGsSu61qLzPuq7PzgIJbu20gYY4CTdFJwetQZgX+oqkLNK
         +aRrhFTqVdkTYpKMhjtlqh7OzPQXqUB2CieXcvzW6Hn19P/4hD/J7MbCVW7M1g8n6RcQ
         jMC5aD/5RRjZ9UAT0RtXa//f31/Hq97AzaiZAm56mq9tFFVv99SWsT5CDzTXARYzMR0C
         oTOII7iSlhGubN2XbeP/inNI/6FVCa8v8CUpANKddad8KqapFxvL9sMmrhslpheUqJSg
         W8fQ==
X-Gm-Message-State: AOAM533gYQM8qzW+iS7v5I9zwhmb0Fvp35EPZtqsUV7Ork8AUjXXl7GR
        ARQG2LEQaf3VjoNNIAkWl8Kzag==
X-Google-Smtp-Source: ABdhPJzYq0jstbq4vUkyGh3c4Sh0MZjCRlNXZUsw7hsdBz5qHKlfkAEykQrCSa/HT+b2XGmyM1pHDQ==
X-Received: by 2002:a05:6512:3f90:: with SMTP id x16mr979457lfa.518.1630711468845;
        Fri, 03 Sep 2021 16:24:28 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:28 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 06/11] interconnect: msm8916: expand DEFINE_QNODE macros
Date:   Sat,  4 Sep 2021 02:24:16 +0300
Message-Id: <20210903232421.1384199-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation to adding AP-owned nodes support to msm8916 expand
DEFINE_QNODE macros in the driver.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 1101 ++++++++++++++++++++++++---
 1 file changed, 1016 insertions(+), 85 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index fc0d48d2997a..b7d662875c89 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -105,91 +105,1022 @@ enum {
 	MSM8916_SNOC_PNOC_SLV,
 };
 
-DEFINE_QNODE(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, MSM8916_BIMC_SNOC_SLV);
-DEFINE_QNODE(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
-DEFINE_QNODE(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_audio, MSM8916_MASTER_LPASS, 4, -1, -1, MSM8916_PNOC_MAS_0);
-DEFINE_QNODE(mas_blsp_1, MSM8916_MASTER_BLSP_1, 4, -1, -1, MSM8916_PNOC_MAS_1);
-DEFINE_QNODE(mas_dehr, MSM8916_MASTER_DEHR, 4, -1, -1, MSM8916_PNOC_MAS_0);
-DEFINE_QNODE(mas_gfx, MSM8916_MASTER_GRAPHICS_3D, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_jpeg, MSM8916_MASTER_JPEG, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mas_mdp, MSM8916_MASTER_MDP_PORT0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mas_pcnoc_crypto_0, MSM8916_MASTER_CRYPTO_CORE0, 8, -1, -1, MSM8916_PNOC_INT_1);
-DEFINE_QNODE(mas_pcnoc_sdcc_1, MSM8916_MASTER_SDCC_1, 8, -1, -1, MSM8916_PNOC_INT_1);
-DEFINE_QNODE(mas_pcnoc_sdcc_2, MSM8916_MASTER_SDCC_2, 8, -1, -1, MSM8916_PNOC_INT_1);
-DEFINE_QNODE(mas_qdss_bam, MSM8916_MASTER_QDSS_BAM, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_qdss_etr, MSM8916_MASTER_QDSS_ETR, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_snoc_cfg, MSM8916_MASTER_SNOC_CFG, 4, -1, -1, MSM8916_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_spdm, MSM8916_MASTER_SPDM, 4, -1, -1, MSM8916_PNOC_MAS_0);
-DEFINE_QNODE(mas_tcu0, MSM8916_MASTER_TCU0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_tcu1, MSM8916_MASTER_TCU1, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
-DEFINE_QNODE(mas_usb_hs, MSM8916_MASTER_USB_HS, 4, -1, -1, MSM8916_PNOC_MAS_1);
-DEFINE_QNODE(mas_vfe, MSM8916_MASTER_VFE, 16, -1, -1, MSM8916_SNOC_MM_INT_1, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mas_video, MSM8916_MASTER_VIDEO_P0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
-DEFINE_QNODE(mm_int_0, MSM8916_SNOC_MM_INT_0, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
-DEFINE_QNODE(mm_int_1, MSM8916_SNOC_MM_INT_1, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
-DEFINE_QNODE(mm_int_2, MSM8916_SNOC_MM_INT_2, 16, -1, -1, MSM8916_SNOC_INT_0);
-DEFINE_QNODE(mm_int_bimc, MSM8916_SNOC_MM_INT_BIMC, 16, -1, -1, MSM8916_SNOC_BIMC_1_MAS);
-DEFINE_QNODE(pcnoc_int_0, MSM8916_PNOC_INT_0, 8, -1, -1, MSM8916_PNOC_SNOC_MAS, MSM8916_PNOC_SLV_0, MSM8916_PNOC_SLV_1, MSM8916_PNOC_SLV_2, MSM8916_PNOC_SLV_3, MSM8916_PNOC_SLV_4, MSM8916_PNOC_SLV_8, MSM8916_PNOC_SLV_9);
-DEFINE_QNODE(pcnoc_int_1, MSM8916_PNOC_INT_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
-DEFINE_QNODE(pcnoc_m_0, MSM8916_PNOC_MAS_0, 8, -1, -1, MSM8916_PNOC_INT_0);
-DEFINE_QNODE(pcnoc_m_1, MSM8916_PNOC_MAS_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
-DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 4, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
-DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 4, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
-DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 4, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
-DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 4, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
-DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 4, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
-DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 4, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
-DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 4, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
-DEFINE_QNODE(pcnoc_snoc_mas, MSM8916_PNOC_SNOC_MAS, 8, 29, -1, MSM8916_PNOC_SNOC_SLV);
-DEFINE_QNODE(pcnoc_snoc_slv, MSM8916_PNOC_SNOC_SLV, 8, -1, 45, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC, MSM8916_SNOC_INT_1);
-DEFINE_QNODE(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
-DEFINE_QNODE(slv_apps_l2, MSM8916_SLAVE_AMPSS_L2, 8, -1, -1, 0);
-DEFINE_QNODE(slv_apss, MSM8916_SLAVE_APSS, 4, -1, -1, 0);
-DEFINE_QNODE(slv_audio, MSM8916_SLAVE_LPASS, 4, -1, -1, 0);
-DEFINE_QNODE(slv_bimc_cfg, MSM8916_SLAVE_BIMC_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_blsp_1, MSM8916_SLAVE_BLSP_1, 4, -1, -1, 0);
-DEFINE_QNODE(slv_boot_rom, MSM8916_SLAVE_BOOT_ROM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_camera_cfg, MSM8916_SLAVE_CAMERA_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_cats_0, MSM8916_SLAVE_CATS_128, 16, -1, -1, 0);
-DEFINE_QNODE(slv_cats_1, MSM8916_SLAVE_OCMEM_64, 8, -1, -1, 0);
-DEFINE_QNODE(slv_clk_ctl, MSM8916_SLAVE_CLK_CTL, 4, -1, -1, 0);
-DEFINE_QNODE(slv_crypto_0_cfg, MSM8916_SLAVE_CRYPTO_0_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_dehr_cfg, MSM8916_SLAVE_DEHR_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_display_cfg, MSM8916_SLAVE_DISPLAY_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_ebi_ch0, MSM8916_SLAVE_EBI_CH0, 8, -1, 0, 0);
-DEFINE_QNODE(slv_gfx_cfg, MSM8916_SLAVE_GRAPHICS_3D_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_imem_cfg, MSM8916_SLAVE_IMEM_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_imem, MSM8916_SLAVE_IMEM, 8, -1, 26, 0);
-DEFINE_QNODE(slv_mpm, MSM8916_SLAVE_MPM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_msg_ram, MSM8916_SLAVE_MSG_RAM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_mss, MSM8916_SLAVE_MSS, 4, -1, -1, 0);
-DEFINE_QNODE(slv_pdm, MSM8916_SLAVE_PDM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_pmic_arb, MSM8916_SLAVE_PMIC_ARB, 4, -1, -1, 0);
-DEFINE_QNODE(slv_pcnoc_cfg, MSM8916_SLAVE_PNOC_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_prng, MSM8916_SLAVE_PRNG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_qdss_cfg, MSM8916_SLAVE_QDSS_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_qdss_stm, MSM8916_SLAVE_QDSS_STM, 4, -1, 30, 0);
-DEFINE_QNODE(slv_rbcpr_cfg, MSM8916_SLAVE_RBCPR_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_sdcc_1, MSM8916_SLAVE_SDCC_1, 4, -1, -1, 0);
-DEFINE_QNODE(slv_sdcc_2, MSM8916_SLAVE_SDCC_2, 4, -1, -1, 0);
-DEFINE_QNODE(slv_security, MSM8916_SLAVE_SECURITY, 4, -1, -1, 0);
-DEFINE_QNODE(slv_snoc_cfg, MSM8916_SLAVE_SNOC_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_spdm, MSM8916_SLAVE_SPDM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_srvc_snoc, MSM8916_SLAVE_SRVC_SNOC, 8, -1, -1, 0);
-DEFINE_QNODE(slv_tcsr, MSM8916_SLAVE_TCSR, 4, -1, -1, 0);
-DEFINE_QNODE(slv_tlmm, MSM8916_SLAVE_TLMM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_usb_hs, MSM8916_SLAVE_USB_HS, 4, -1, -1, 0);
-DEFINE_QNODE(slv_venus_cfg, MSM8916_SLAVE_VENUS_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(snoc_bimc_0_mas, MSM8916_SNOC_BIMC_0_MAS, 8, 3, -1, MSM8916_SNOC_BIMC_0_SLV);
-DEFINE_QNODE(snoc_bimc_0_slv, MSM8916_SNOC_BIMC_0_SLV, 8, -1, 24, MSM8916_SLAVE_EBI_CH0);
-DEFINE_QNODE(snoc_bimc_1_mas, MSM8916_SNOC_BIMC_1_MAS, 16, -1, -1, MSM8916_SNOC_BIMC_1_SLV);
-DEFINE_QNODE(snoc_bimc_1_slv, MSM8916_SNOC_BIMC_1_SLV, 8, -1, -1, MSM8916_SLAVE_EBI_CH0);
-DEFINE_QNODE(snoc_int_0, MSM8916_SNOC_INT_0, 8, 99, 130, MSM8916_SLAVE_QDSS_STM, MSM8916_SLAVE_IMEM, MSM8916_SNOC_PNOC_MAS);
-DEFINE_QNODE(snoc_int_1, MSM8916_SNOC_INT_1, 8, -1, -1, MSM8916_SLAVE_APSS, MSM8916_SLAVE_CATS_128, MSM8916_SLAVE_OCMEM_64);
-DEFINE_QNODE(snoc_int_bimc, MSM8916_SNOC_INT_BIMC, 8, 101, 132, MSM8916_SNOC_BIMC_0_MAS);
-DEFINE_QNODE(snoc_pcnoc_mas, MSM8916_SNOC_PNOC_MAS, 8, -1, -1, MSM8916_SNOC_PNOC_SLV);
-DEFINE_QNODE(snoc_pcnoc_slv, MSM8916_SNOC_PNOC_SLV, 8, -1, -1, MSM8916_PNOC_INT_0);
+static const u16 bimc_snoc_mas_links[] = {
+	MSM8916_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node bimc_snoc_mas = {
+	.name = "bimc_snoc_mas",
+	.id = MSM8916_BIMC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
+	.links = bimc_snoc_mas_links,
+};
+
+static const u16 bimc_snoc_slv_links[] = {
+	MSM8916_SNOC_INT_0,
+	MSM8916_SNOC_INT_1
+};
+
+static struct qcom_icc_node bimc_snoc_slv = {
+	.name = "bimc_snoc_slv",
+	.id = MSM8916_BIMC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(bimc_snoc_slv_links),
+	.links = bimc_snoc_slv_links,
+};
+
+static const u16 mas_apss_links[] = {
+	MSM8916_SLAVE_EBI_CH0,
+	MSM8916_BIMC_SNOC_MAS,
+	MSM8916_SLAVE_AMPSS_L2
+};
+
+static struct qcom_icc_node mas_apss = {
+	.name = "mas_apss",
+	.id = MSM8916_MASTER_AMPSS_M0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_apss_links),
+	.links = mas_apss_links,
+};
+
+static const u16 mas_audio_links[] = {
+	MSM8916_PNOC_MAS_0
+};
+
+static struct qcom_icc_node mas_audio = {
+	.name = "mas_audio",
+	.id = MSM8916_MASTER_LPASS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_audio_links),
+	.links = mas_audio_links,
+};
+
+static const u16 mas_blsp_1_links[] = {
+	MSM8916_PNOC_MAS_1
+};
+
+static struct qcom_icc_node mas_blsp_1 = {
+	.name = "mas_blsp_1",
+	.id = MSM8916_MASTER_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_1_links),
+	.links = mas_blsp_1_links,
+};
+
+static const u16 mas_dehr_links[] = {
+	MSM8916_PNOC_MAS_0
+};
+
+static struct qcom_icc_node mas_dehr = {
+	.name = "mas_dehr",
+	.id = MSM8916_MASTER_DEHR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_dehr_links),
+	.links = mas_dehr_links,
+};
+
+static const u16 mas_gfx_links[] = {
+	MSM8916_SLAVE_EBI_CH0,
+	MSM8916_BIMC_SNOC_MAS,
+	MSM8916_SLAVE_AMPSS_L2
+};
+
+static struct qcom_icc_node mas_gfx = {
+	.name = "mas_gfx",
+	.id = MSM8916_MASTER_GRAPHICS_3D,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_gfx_links),
+	.links = mas_gfx_links,
+};
+
+static const u16 mas_jpeg_links[] = {
+	MSM8916_SNOC_MM_INT_0,
+	MSM8916_SNOC_MM_INT_2
+};
+
+static struct qcom_icc_node mas_jpeg = {
+	.name = "mas_jpeg",
+	.id = MSM8916_MASTER_JPEG,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_jpeg_links),
+	.links = mas_jpeg_links,
+};
+
+static const u16 mas_mdp_links[] = {
+	MSM8916_SNOC_MM_INT_0,
+	MSM8916_SNOC_MM_INT_2
+};
+
+static struct qcom_icc_node mas_mdp = {
+	.name = "mas_mdp",
+	.id = MSM8916_MASTER_MDP_PORT0,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_mdp_links),
+	.links = mas_mdp_links,
+};
+
+static const u16 mas_pcnoc_crypto_0_links[] = {
+	MSM8916_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_pcnoc_crypto_0 = {
+	.name = "mas_pcnoc_crypto_0",
+	.id = MSM8916_MASTER_CRYPTO_CORE0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcnoc_crypto_0_links),
+	.links = mas_pcnoc_crypto_0_links,
+};
+
+static const u16 mas_pcnoc_sdcc_1_links[] = {
+	MSM8916_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_pcnoc_sdcc_1 = {
+	.name = "mas_pcnoc_sdcc_1",
+	.id = MSM8916_MASTER_SDCC_1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcnoc_sdcc_1_links),
+	.links = mas_pcnoc_sdcc_1_links,
+};
+
+static const u16 mas_pcnoc_sdcc_2_links[] = {
+	MSM8916_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_pcnoc_sdcc_2 = {
+	.name = "mas_pcnoc_sdcc_2",
+	.id = MSM8916_MASTER_SDCC_2,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcnoc_sdcc_2_links),
+	.links = mas_pcnoc_sdcc_2_links,
+};
+
+static const u16 mas_qdss_bam_links[] = {
+	MSM8916_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.name = "mas_qdss_bam",
+	.id = MSM8916_MASTER_QDSS_BAM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
+	.links = mas_qdss_bam_links,
+};
+
+static const u16 mas_qdss_etr_links[] = {
+	MSM8916_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.name = "mas_qdss_etr",
+	.id = MSM8916_MASTER_QDSS_ETR,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
+	.links = mas_qdss_etr_links,
+};
+
+static const u16 mas_snoc_cfg_links[] = {
+	MSM8916_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_snoc_cfg = {
+	.name = "mas_snoc_cfg",
+	.id = MSM8916_MASTER_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
+	.links = mas_snoc_cfg_links,
+};
+
+static const u16 mas_spdm_links[] = {
+	MSM8916_PNOC_MAS_0
+};
+
+static struct qcom_icc_node mas_spdm = {
+	.name = "mas_spdm",
+	.id = MSM8916_MASTER_SPDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_spdm_links),
+	.links = mas_spdm_links,
+};
+
+static const u16 mas_tcu0_links[] = {
+	MSM8916_SLAVE_EBI_CH0,
+	MSM8916_BIMC_SNOC_MAS,
+	MSM8916_SLAVE_AMPSS_L2
+};
+
+static struct qcom_icc_node mas_tcu0 = {
+	.name = "mas_tcu0",
+	.id = MSM8916_MASTER_TCU0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_tcu0_links),
+	.links = mas_tcu0_links,
+};
+
+static const u16 mas_tcu1_links[] = {
+	MSM8916_SLAVE_EBI_CH0,
+	MSM8916_BIMC_SNOC_MAS,
+	MSM8916_SLAVE_AMPSS_L2
+};
+
+static struct qcom_icc_node mas_tcu1 = {
+	.name = "mas_tcu1",
+	.id = MSM8916_MASTER_TCU1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_tcu1_links),
+	.links = mas_tcu1_links,
+};
+
+static const u16 mas_usb_hs_links[] = {
+	MSM8916_PNOC_MAS_1
+};
+
+static struct qcom_icc_node mas_usb_hs = {
+	.name = "mas_usb_hs",
+	.id = MSM8916_MASTER_USB_HS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_usb_hs_links),
+	.links = mas_usb_hs_links,
+};
+
+static const u16 mas_vfe_links[] = {
+	MSM8916_SNOC_MM_INT_1,
+	MSM8916_SNOC_MM_INT_2
+};
+
+static struct qcom_icc_node mas_vfe = {
+	.name = "mas_vfe",
+	.id = MSM8916_MASTER_VFE,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_vfe_links),
+	.links = mas_vfe_links,
+};
+
+static const u16 mas_video_links[] = {
+	MSM8916_SNOC_MM_INT_0,
+	MSM8916_SNOC_MM_INT_2
+};
+
+static struct qcom_icc_node mas_video = {
+	.name = "mas_video",
+	.id = MSM8916_MASTER_VIDEO_P0,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_video_links),
+	.links = mas_video_links,
+};
+
+static const u16 mm_int_0_links[] = {
+	MSM8916_SNOC_MM_INT_BIMC
+};
+
+static struct qcom_icc_node mm_int_0 = {
+	.name = "mm_int_0",
+	.id = MSM8916_SNOC_MM_INT_0,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mm_int_0_links),
+	.links = mm_int_0_links,
+};
+
+static const u16 mm_int_1_links[] = {
+	MSM8916_SNOC_MM_INT_BIMC
+};
+
+static struct qcom_icc_node mm_int_1 = {
+	.name = "mm_int_1",
+	.id = MSM8916_SNOC_MM_INT_1,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mm_int_1_links),
+	.links = mm_int_1_links,
+};
+
+static const u16 mm_int_2_links[] = {
+	MSM8916_SNOC_INT_0
+};
+
+static struct qcom_icc_node mm_int_2 = {
+	.name = "mm_int_2",
+	.id = MSM8916_SNOC_MM_INT_2,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mm_int_2_links),
+	.links = mm_int_2_links,
+};
+
+static const u16 mm_int_bimc_links[] = {
+	MSM8916_SNOC_BIMC_1_MAS
+};
+
+static struct qcom_icc_node mm_int_bimc = {
+	.name = "mm_int_bimc",
+	.id = MSM8916_SNOC_MM_INT_BIMC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mm_int_bimc_links),
+	.links = mm_int_bimc_links,
+};
+
+static const u16 pcnoc_int_0_links[] = {
+	MSM8916_PNOC_SNOC_MAS,
+	MSM8916_PNOC_SLV_0,
+	MSM8916_PNOC_SLV_1,
+	MSM8916_PNOC_SLV_2,
+	MSM8916_PNOC_SLV_3,
+	MSM8916_PNOC_SLV_4,
+	MSM8916_PNOC_SLV_8,
+	MSM8916_PNOC_SLV_9
+};
+
+static struct qcom_icc_node pcnoc_int_0 = {
+	.name = "pcnoc_int_0",
+	.id = MSM8916_PNOC_INT_0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_int_0_links),
+	.links = pcnoc_int_0_links,
+};
+
+static const u16 pcnoc_int_1_links[] = {
+	MSM8916_PNOC_SNOC_MAS
+};
+
+static struct qcom_icc_node pcnoc_int_1 = {
+	.name = "pcnoc_int_1",
+	.id = MSM8916_PNOC_INT_1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_int_1_links),
+	.links = pcnoc_int_1_links,
+};
+
+static const u16 pcnoc_m_0_links[] = {
+	MSM8916_PNOC_INT_0
+};
+
+static struct qcom_icc_node pcnoc_m_0 = {
+	.name = "pcnoc_m_0",
+	.id = MSM8916_PNOC_MAS_0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_m_0_links),
+	.links = pcnoc_m_0_links,
+};
+
+static const u16 pcnoc_m_1_links[] = {
+	MSM8916_PNOC_SNOC_MAS
+};
+
+static struct qcom_icc_node pcnoc_m_1 = {
+	.name = "pcnoc_m_1",
+	.id = MSM8916_PNOC_MAS_1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_m_1_links),
+	.links = pcnoc_m_1_links,
+};
+
+static const u16 pcnoc_s_0_links[] = {
+	MSM8916_SLAVE_CLK_CTL,
+	MSM8916_SLAVE_TLMM,
+	MSM8916_SLAVE_TCSR,
+	MSM8916_SLAVE_SECURITY,
+	MSM8916_SLAVE_MSS
+};
+
+static struct qcom_icc_node pcnoc_s_0 = {
+	.name = "pcnoc_s_0",
+	.id = MSM8916_PNOC_SLV_0,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_0_links),
+	.links = pcnoc_s_0_links,
+};
+
+static const u16 pcnoc_s_1_links[] = {
+	MSM8916_SLAVE_IMEM_CFG,
+	MSM8916_SLAVE_CRYPTO_0_CFG,
+	MSM8916_SLAVE_MSG_RAM,
+	MSM8916_SLAVE_PDM,
+	MSM8916_SLAVE_PRNG
+};
+
+static struct qcom_icc_node pcnoc_s_1 = {
+	.name = "pcnoc_s_1",
+	.id = MSM8916_PNOC_SLV_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_1_links),
+	.links = pcnoc_s_1_links,
+};
+
+static const u16 pcnoc_s_2_links[] = {
+	MSM8916_SLAVE_SPDM,
+	MSM8916_SLAVE_BOOT_ROM,
+	MSM8916_SLAVE_BIMC_CFG,
+	MSM8916_SLAVE_PNOC_CFG,
+	MSM8916_SLAVE_PMIC_ARB
+};
+
+static struct qcom_icc_node pcnoc_s_2 = {
+	.name = "pcnoc_s_2",
+	.id = MSM8916_PNOC_SLV_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_2_links),
+	.links = pcnoc_s_2_links,
+};
+
+static const u16 pcnoc_s_3_links[] = {
+	MSM8916_SLAVE_MPM,
+	MSM8916_SLAVE_SNOC_CFG,
+	MSM8916_SLAVE_RBCPR_CFG,
+	MSM8916_SLAVE_QDSS_CFG,
+	MSM8916_SLAVE_DEHR_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_3 = {
+	.name = "pcnoc_s_3",
+	.id = MSM8916_PNOC_SLV_3,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_3_links),
+	.links = pcnoc_s_3_links,
+};
+
+static const u16 pcnoc_s_4_links[] = {
+	MSM8916_SLAVE_VENUS_CFG,
+	MSM8916_SLAVE_CAMERA_CFG,
+	MSM8916_SLAVE_DISPLAY_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_4 = {
+	.name = "pcnoc_s_4",
+	.id = MSM8916_PNOC_SLV_4,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_4_links),
+	.links = pcnoc_s_4_links,
+};
+
+static const u16 pcnoc_s_8_links[] = {
+	MSM8916_SLAVE_USB_HS,
+	MSM8916_SLAVE_SDCC_1,
+	MSM8916_SLAVE_BLSP_1
+};
+
+static struct qcom_icc_node pcnoc_s_8 = {
+	.name = "pcnoc_s_8",
+	.id = MSM8916_PNOC_SLV_8,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_8_links),
+	.links = pcnoc_s_8_links,
+};
+
+static const u16 pcnoc_s_9_links[] = {
+	MSM8916_SLAVE_SDCC_2,
+	MSM8916_SLAVE_LPASS,
+	MSM8916_SLAVE_GRAPHICS_3D_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_9 = {
+	.name = "pcnoc_s_9",
+	.id = MSM8916_PNOC_SLV_9,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_9_links),
+	.links = pcnoc_s_9_links,
+};
+
+static const u16 pcnoc_snoc_mas_links[] = {
+	MSM8916_PNOC_SNOC_SLV
+};
+
+static struct qcom_icc_node pcnoc_snoc_mas = {
+	.name = "pcnoc_snoc_mas",
+	.id = MSM8916_PNOC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 29,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(pcnoc_snoc_mas_links),
+	.links = pcnoc_snoc_mas_links,
+};
+
+static const u16 pcnoc_snoc_slv_links[] = {
+	MSM8916_SNOC_INT_0,
+	MSM8916_SNOC_INT_BIMC,
+	MSM8916_SNOC_INT_1
+};
+
+static struct qcom_icc_node pcnoc_snoc_slv = {
+	.name = "pcnoc_snoc_slv",
+	.id = MSM8916_PNOC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 45,
+	.num_links = ARRAY_SIZE(pcnoc_snoc_slv_links),
+	.links = pcnoc_snoc_slv_links,
+};
+
+static const u16 qdss_int_links[] = {
+	MSM8916_SNOC_INT_0,
+	MSM8916_SNOC_INT_BIMC
+};
+
+static struct qcom_icc_node qdss_int = {
+	.name = "qdss_int",
+	.id = MSM8916_SNOC_QDSS_INT,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(qdss_int_links),
+	.links = qdss_int_links,
+};
+
+static struct qcom_icc_node slv_apps_l2 = {
+	.name = "slv_apps_l2",
+	.id = MSM8916_SLAVE_AMPSS_L2,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_apss = {
+	.name = "slv_apss",
+	.id = MSM8916_SLAVE_APSS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_audio = {
+	.name = "slv_audio",
+	.id = MSM8916_SLAVE_LPASS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_bimc_cfg = {
+	.name = "slv_bimc_cfg",
+	.id = MSM8916_SLAVE_BIMC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_blsp_1 = {
+	.name = "slv_blsp_1",
+	.id = MSM8916_SLAVE_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_boot_rom = {
+	.name = "slv_boot_rom",
+	.id = MSM8916_SLAVE_BOOT_ROM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_camera_cfg = {
+	.name = "slv_camera_cfg",
+	.id = MSM8916_SLAVE_CAMERA_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_cats_0 = {
+	.name = "slv_cats_0",
+	.id = MSM8916_SLAVE_CATS_128,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_cats_1 = {
+	.name = "slv_cats_1",
+	.id = MSM8916_SLAVE_OCMEM_64,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_clk_ctl = {
+	.name = "slv_clk_ctl",
+	.id = MSM8916_SLAVE_CLK_CTL,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_crypto_0_cfg = {
+	.name = "slv_crypto_0_cfg",
+	.id = MSM8916_SLAVE_CRYPTO_0_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_dehr_cfg = {
+	.name = "slv_dehr_cfg",
+	.id = MSM8916_SLAVE_DEHR_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_display_cfg = {
+	.name = "slv_display_cfg",
+	.id = MSM8916_SLAVE_DISPLAY_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_ebi_ch0 = {
+	.name = "slv_ebi_ch0",
+	.id = MSM8916_SLAVE_EBI_CH0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+};
+
+static struct qcom_icc_node slv_gfx_cfg = {
+	.name = "slv_gfx_cfg",
+	.id = MSM8916_SLAVE_GRAPHICS_3D_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_imem_cfg = {
+	.name = "slv_imem_cfg",
+	.id = MSM8916_SLAVE_IMEM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slv_imem",
+	.id = MSM8916_SLAVE_IMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+};
+
+static struct qcom_icc_node slv_mpm = {
+	.name = "slv_mpm",
+	.id = MSM8916_SLAVE_MPM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_msg_ram = {
+	.name = "slv_msg_ram",
+	.id = MSM8916_SLAVE_MSG_RAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_mss = {
+	.name = "slv_mss",
+	.id = MSM8916_SLAVE_MSS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slv_pdm",
+	.id = MSM8916_SLAVE_PDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slv_pmic_arb",
+	.id = MSM8916_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_pcnoc_cfg = {
+	.name = "slv_pcnoc_cfg",
+	.id = MSM8916_SLAVE_PNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slv_prng",
+	.id = MSM8916_SLAVE_PRNG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_qdss_cfg = {
+	.name = "slv_qdss_cfg",
+	.id = MSM8916_SLAVE_QDSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slv_qdss_stm",
+	.id = MSM8916_SLAVE_QDSS_STM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+};
+
+static struct qcom_icc_node slv_rbcpr_cfg = {
+	.name = "slv_rbcpr_cfg",
+	.id = MSM8916_SLAVE_RBCPR_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_sdcc_1 = {
+	.name = "slv_sdcc_1",
+	.id = MSM8916_SLAVE_SDCC_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slv_sdcc_2",
+	.id = MSM8916_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_security = {
+	.name = "slv_security",
+	.id = MSM8916_SLAVE_SECURITY,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slv_snoc_cfg",
+	.id = MSM8916_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_spdm = {
+	.name = "slv_spdm",
+	.id = MSM8916_SLAVE_SPDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_srvc_snoc = {
+	.name = "slv_srvc_snoc",
+	.id = MSM8916_SLAVE_SRVC_SNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slv_tcsr",
+	.id = MSM8916_SLAVE_TCSR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_tlmm = {
+	.name = "slv_tlmm",
+	.id = MSM8916_SLAVE_TLMM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_usb_hs = {
+	.name = "slv_usb_hs",
+	.id = MSM8916_SLAVE_USB_HS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static struct qcom_icc_node slv_venus_cfg = {
+	.name = "slv_venus_cfg",
+	.id = MSM8916_SLAVE_VENUS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+};
+
+static const u16 snoc_bimc_0_mas_links[] = {
+	MSM8916_SNOC_BIMC_0_SLV
+};
+
+static struct qcom_icc_node snoc_bimc_0_mas = {
+	.name = "snoc_bimc_0_mas",
+	.id = MSM8916_SNOC_BIMC_0_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 3,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_bimc_0_mas_links),
+	.links = snoc_bimc_0_mas_links,
+};
+
+static const u16 snoc_bimc_0_slv_links[] = {
+	MSM8916_SLAVE_EBI_CH0
+};
+
+static struct qcom_icc_node snoc_bimc_0_slv = {
+	.name = "snoc_bimc_0_slv",
+	.id = MSM8916_SNOC_BIMC_0_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 24,
+	.num_links = ARRAY_SIZE(snoc_bimc_0_slv_links),
+	.links = snoc_bimc_0_slv_links,
+};
+
+static const u16 snoc_bimc_1_mas_links[] = {
+	MSM8916_SNOC_BIMC_1_SLV
+};
+
+static struct qcom_icc_node snoc_bimc_1_mas = {
+	.name = "snoc_bimc_1_mas",
+	.id = MSM8916_SNOC_BIMC_1_MAS,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_bimc_1_mas_links),
+	.links = snoc_bimc_1_mas_links,
+};
+
+static const u16 snoc_bimc_1_slv_links[] = {
+	MSM8916_SLAVE_EBI_CH0
+};
+
+static struct qcom_icc_node snoc_bimc_1_slv = {
+	.name = "snoc_bimc_1_slv",
+	.id = MSM8916_SNOC_BIMC_1_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_bimc_1_slv_links),
+	.links = snoc_bimc_1_slv_links,
+};
+
+static const u16 snoc_int_0_links[] = {
+	MSM8916_SLAVE_QDSS_STM,
+	MSM8916_SLAVE_IMEM,
+	MSM8916_SNOC_PNOC_MAS
+};
+
+static struct qcom_icc_node snoc_int_0 = {
+	.name = "snoc_int_0",
+	.id = MSM8916_SNOC_INT_0,
+	.buswidth = 8,
+	.mas_rpm_id = 99,
+	.slv_rpm_id = 130,
+	.num_links = ARRAY_SIZE(snoc_int_0_links),
+	.links = snoc_int_0_links,
+};
+
+static const u16 snoc_int_1_links[] = {
+	MSM8916_SLAVE_APSS,
+	MSM8916_SLAVE_CATS_128,
+	MSM8916_SLAVE_OCMEM_64
+};
+
+static struct qcom_icc_node snoc_int_1 = {
+	.name = "snoc_int_1",
+	.id = MSM8916_SNOC_INT_1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_int_1_links),
+	.links = snoc_int_1_links,
+};
+
+static const u16 snoc_int_bimc_links[] = {
+	MSM8916_SNOC_BIMC_0_MAS
+};
+
+static struct qcom_icc_node snoc_int_bimc = {
+	.name = "snoc_int_bimc",
+	.id = MSM8916_SNOC_INT_BIMC,
+	.buswidth = 8,
+	.mas_rpm_id = 101,
+	.slv_rpm_id = 132,
+	.num_links = ARRAY_SIZE(snoc_int_bimc_links),
+	.links = snoc_int_bimc_links,
+};
+
+static const u16 snoc_pcnoc_mas_links[] = {
+	MSM8916_SNOC_PNOC_SLV
+};
+
+static struct qcom_icc_node snoc_pcnoc_mas = {
+	.name = "snoc_pcnoc_mas",
+	.id = MSM8916_SNOC_PNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_pcnoc_mas_links),
+	.links = snoc_pcnoc_mas_links,
+};
+
+static const u16 snoc_pcnoc_slv_links[] = {
+	MSM8916_PNOC_INT_0
+};
+
+static struct qcom_icc_node snoc_pcnoc_slv = {
+	.name = "snoc_pcnoc_slv",
+	.id = MSM8916_SNOC_PNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(snoc_pcnoc_slv_links),
+	.links = snoc_pcnoc_slv_links,
+};
 
 static struct qcom_icc_node *msm8916_snoc_nodes[] = {
 	[BIMC_SNOC_SLV] = &bimc_snoc_slv,
-- 
2.33.0

