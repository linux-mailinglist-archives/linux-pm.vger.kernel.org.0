Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA340084F
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbhICXZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350770AbhICXZd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03708C061760
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so1347409lfu.5
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpmkely3snBZj1eVUyvD0B60pqPU0GFtLzvraxIrCD8=;
        b=RJA8zc7Qm1G1hR0lwds+t5dPjBlhjr9qL6wONe/sDwwA8VmZRXsCcFP3YYifnSnk0g
         cvvS+ZPPtkFXwyFItmXadomofG2s108ZbdSwbxSC2kMY4SkFH9GapF+4DAz1foCb/o7w
         PzZkiw0UK0hxxbX2EhwGdetw9tAOztqb5KyBPdITKsyLCB74lRkscmRN4fgZfPdn6V48
         RyDBsdiBIZjQSlkU87aNDWTCDTxaZ14viUy9szuWBH59+Dkco0bMNvfmTg0OEnYXB014
         8AMqi8q4ASChSU+fxG4QZNJYLt/TCimyRcjnVGW9z0JGJgnJBz0SqnLIyiBCxV52nEjo
         9DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpmkely3snBZj1eVUyvD0B60pqPU0GFtLzvraxIrCD8=;
        b=bap/95jNPOx1BEU3JIoV9XdeVffMoPy7FJIkerHVywDagRU1Zq71BAPdLh7Rkc8ADp
         nXIr5PFT60IfWybA8jroGlGvHILd/M8Qo3cyYXna6zESK68GhOpK0ebhyxt9fPDAv1eE
         8E9J8LP97iG6r0lkJlUNHw6YQzKuPrRt3BkRmWiKQO96gUbmhb5TW+EEd9btMPemJV3W
         zymnMfJ54ccBxTEAnPkgBEVZU4sl/Jg1baGRZ6/VNtyc6rriagqvn2Yq2sSt+kYH9dMN
         FNAnnOXVMDPEyCuAj7CHA5/EIJ7GXvxeaaIHsfgDnh1K44pH1HgNznFefDMWulYkTlsz
         hdhA==
X-Gm-Message-State: AOAM533EDi3qmnXgHoZu+AIGJ8j/E+Zw/lYoUcG4G4GxrMQ9lIXkUtYl
        CLAbGDRA8BS7lERmEs3fw8Z/4Q==
X-Google-Smtp-Source: ABdhPJwMOKh71SjacP6O+Tbk5NzWC4ry8J9Gg8iP1UTtoAwenQ4A2nPZUmCtMghaE1FQ+D22FCYEsg==
X-Received: by 2002:a05:6512:30b:: with SMTP id t11mr978642lfp.166.1630711471362;
        Fri, 03 Sep 2021 16:24:31 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:30 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 09/11] interconnect: msm8939: add support for AP-owned nodes
Date:   Sat,  4 Sep 2021 02:24:19 +0300
Message-Id: <20210903232421.1384199-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Port support for AP-owned nodes from the downstream device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 115 ++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 4671538c8994..16272a477bd8 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/of_device.h>
 
 #include <dt-bindings/interconnect/qcom,msm8939.h>
@@ -120,6 +121,8 @@ static struct qcom_icc_node bimc_snoc_mas = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
 	.links = bimc_snoc_mas_links,
 };
@@ -151,6 +154,11 @@ static struct qcom_icc_node mas_apss = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
 	.num_links = ARRAY_SIZE(mas_apss_links),
 	.links = mas_apss_links,
 };
@@ -209,6 +217,11 @@ static struct qcom_icc_node mas_gfx = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 2,
 	.num_links = ARRAY_SIZE(mas_gfx_links),
 	.links = mas_gfx_links,
 };
@@ -224,6 +237,11 @@ static struct qcom_icc_node mas_jpeg = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 6,
 	.num_links = ARRAY_SIZE(mas_jpeg_links),
 	.links = mas_jpeg_links,
 };
@@ -239,6 +257,11 @@ static struct qcom_icc_node mas_mdp0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 7,
 	.num_links = ARRAY_SIZE(mas_mdp0_links),
 	.links = mas_mdp0_links,
 };
@@ -254,6 +277,11 @@ static struct qcom_icc_node mas_mdp1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 13,
 	.num_links = ARRAY_SIZE(mas_mdp1_links),
 	.links = mas_mdp1_links,
 };
@@ -269,6 +297,11 @@ static struct qcom_icc_node mas_cpp = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 12,
 	.num_links = ARRAY_SIZE(mas_cpp_links),
 	.links = mas_cpp_links,
 };
@@ -325,6 +358,11 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 11,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -339,6 +377,11 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 10,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -383,6 +426,11 @@ static struct qcom_icc_node mas_tcu0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 2,
+	.qos.prio_level = 2,
+	.qos.qos_port = 6,
 	.num_links = ARRAY_SIZE(mas_tcu0_links),
 	.links = mas_tcu0_links,
 };
@@ -426,6 +474,11 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 9,
 	.num_links = ARRAY_SIZE(mas_vfe_links),
 	.links = mas_vfe_links,
 };
@@ -441,6 +494,11 @@ static struct qcom_icc_node mas_video = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 8,
 	.num_links = ARRAY_SIZE(mas_video_links),
 	.links = mas_video_links,
 };
@@ -455,6 +513,8 @@ static struct qcom_icc_node mm_int_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mm_int_0_links),
 	.links = mm_int_0_links,
 };
@@ -469,6 +529,8 @@ static struct qcom_icc_node mm_int_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mm_int_1_links),
 	.links = mm_int_1_links,
 };
@@ -483,6 +545,8 @@ static struct qcom_icc_node mm_int_2 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mm_int_2_links),
 	.links = mm_int_2_links,
 };
@@ -711,6 +775,8 @@ static struct qcom_icc_node qdss_int = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(qdss_int_links),
 	.links = qdss_int_links,
 };
@@ -1029,6 +1095,8 @@ static struct qcom_icc_node snoc_bimc_0_mas = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(snoc_bimc_0_mas_links),
 	.links = snoc_bimc_0_mas_links,
 };
@@ -1043,6 +1111,8 @@ static struct qcom_icc_node snoc_bimc_0_slv = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(snoc_bimc_0_slv_links),
 	.links = snoc_bimc_0_slv_links,
 };
@@ -1085,6 +1155,8 @@ static struct qcom_icc_node snoc_bimc_2_mas = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(snoc_bimc_2_mas_links),
 	.links = snoc_bimc_2_mas_links,
 };
@@ -1099,6 +1171,8 @@ static struct qcom_icc_node snoc_bimc_2_slv = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(snoc_bimc_2_slv_links),
 	.links = snoc_bimc_2_slv_links,
 };
@@ -1199,9 +1273,19 @@ static struct qcom_icc_node *msm8939_snoc_nodes[] = {
 	[SNOC_QDSS_INT] = &qdss_int,
 };
 
+static const struct regmap_config msm8939_snoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x14080,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8939_snoc = {
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
+	.regmap_cfg = &msm8939_snoc_regmap_config,
+	.qos_offset = 0x7000,
 };
 
 static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
@@ -1216,9 +1300,19 @@ static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
 	[SNOC_MM_INT_2] = &mm_int_2,
 };
 
+static const struct regmap_config msm8939_snoc_mm_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x14080,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8939_snoc_mm = {
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
+	.regmap_cfg = &msm8939_snoc_mm_regmap_config,
+	.qos_offset = 0x7000,
 };
 
 static struct qcom_icc_node *msm8939_bimc_nodes[] = {
@@ -1233,9 +1327,20 @@ static struct qcom_icc_node *msm8939_bimc_nodes[] = {
 	[SNOC_BIMC_2_SLV] = &snoc_bimc_2_slv,
 };
 
+static const struct regmap_config msm8939_bimc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x62000,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8939_bimc = {
 	.nodes = msm8939_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
+	.is_bimc_node = true,
+	.regmap_cfg = &msm8939_bimc_regmap_config,
+	.qos_offset = 0x8000,
 };
 
 static struct qcom_icc_node *msm8939_pcnoc_nodes[] = {
@@ -1293,9 +1398,19 @@ static struct qcom_icc_node *msm8939_pcnoc_nodes[] = {
 	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
 };
 
+static const struct regmap_config msm8939_pcnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x11000,
+	.fast_io	= true,
+};
+
 static struct qcom_icc_desc msm8939_pcnoc = {
 	.nodes = msm8939_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
+	.regmap_cfg = &msm8939_pcnoc_regmap_config,
+	.qos_offset = 0x7000,
 };
 
 static const struct of_device_id msm8939_noc_of_match[] = {
-- 
2.33.0

