Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42E400842
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbhICXZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbhICXZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CEEC061764
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k13so1357127lfv.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2qKNkH9miQwx/yZCrfm0nDrmTjlabC/6w0wRqhqYr4=;
        b=lTDPQ0ihkHV5m2XHhCBrtcMQUd5ouw+RKjMU8v64pkcMT00shLuQO+lVMvuFebBeGv
         uqRDZCbgawMr22ups20hPRpaa3ycgZpS87QcawR6urfKlQESj9FiXpTvWyfmxl8oTQG3
         JfH26pCixCumeFU8RsYs7XzzK6CxgYYsXTHTXFJ7JoVY+d8Vr1jfPUliLwFRTHEpahmh
         abclOitnXPrfqt1zz9nnbl5hhzEnBFTaHcuhEOFnzUEu/b0P6CxH15CMSeMexcjVdQZr
         gyQQfceYHzm2PMSiuiUZ13D4J5Pdx9qjEYbWwCujHxkki7O+NS2C5ovpoUlvtwRTKvVJ
         elXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2qKNkH9miQwx/yZCrfm0nDrmTjlabC/6w0wRqhqYr4=;
        b=g2iyanfAUcfkWVlxaASGss0rhfalRAK1FtaT9VYmpT0Z8ajHjVtVTqZ+Ss85p87Sf5
         EwkMG0N13SDpZXqALlY2ahP6eAAOKH7JnWT0hFkrtgMrH6z3Btsrtf+5yJCzgrc6+Ybu
         xrC4JMtNyhL35ptRQ4h8qCmsRd1c/ru53U6QWhnbWIi9yf8nPy0xrbOOlQ+PTkmK/tZi
         WX7IB1hbLqR9/a2IqARj3ExpriUpeNlyPQL8aC/mzwSN4UJOgp4HEWjL5yWf9uUH52eL
         Sy30aNGl8LNbGBiblsWRJUUBZbxrMOwqwFfIcUJAJwxWeA+SNE3y/lNLgXKLDje9ziAy
         KmjQ==
X-Gm-Message-State: AOAM533cejFoUnCdTHN1+VNYZ1LgyOS7K0wR2JkA+4jOsvBlzCN6lmmV
        niuw8FLtMI0JTyexCDB5sqVVew==
X-Google-Smtp-Source: ABdhPJwsW+9cCf6VdDjmBv3Fi/9bebFcHgRyJipLgNG+VQUPgAhI2GOf9YThz9BR5WE+yfLI+KUQOA==
X-Received: by 2002:a05:6512:388e:: with SMTP id n14mr967256lft.242.1630711466499;
        Fri, 03 Sep 2021 16:24:26 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:26 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 03/11] interconnect: sdm660: drop default/unused values
Date:   Sat,  4 Sep 2021 02:24:13 +0300
Message-Id: <20210903232421.1384199-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify qnode setup by removing unused/default values.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 407 +++++------------------------
 1 file changed, 64 insertions(+), 343 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 652f7cc9cad6..4a72f9677d4e 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -35,6 +35,7 @@
 #define M_BKE_EN_EN_BMASK		0x1
 
 /* Valid for both NoC and BIMC */
+#define NOC_QOS_MODE_INVALID		-1
 #define NOC_QOS_MODE_FIXED		0x0
 #define NOC_QOS_MODE_LIMITER		0x1
 #define NOC_QOS_MODE_BYPASS		0x2
@@ -279,10 +280,7 @@ static struct qcom_icc_node mas_cnoc_a2noc = {
 	.mas_rpm_id = 146,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_cnoc_a2noc_links),
 	.links = mas_cnoc_a2noc_links,
 };
@@ -297,11 +295,6 @@ static struct qcom_icc_node mas_sdcc_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 33,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
 	.links = mas_sdcc_1_links,
 };
@@ -316,11 +309,6 @@ static struct qcom_icc_node mas_sdcc_2 = {
 	.buswidth = 8,
 	.mas_rpm_id = 35,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
 	.links = mas_sdcc_2_links,
 };
@@ -335,11 +323,6 @@ static struct qcom_icc_node mas_blsp_1 = {
 	.buswidth = 4,
 	.mas_rpm_id = 41,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_blsp_1_links),
 	.links = mas_blsp_1_links,
 };
@@ -354,11 +337,6 @@ static struct qcom_icc_node mas_blsp_2 = {
 	.buswidth = 4,
 	.mas_rpm_id = 39,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_blsp_2_links),
 	.links = mas_blsp_2_links,
 };
@@ -511,11 +489,6 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.buswidth = 4,
 	.mas_rpm_id = 3,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
 	.links = mas_snoc_bimc_links,
 };
@@ -583,10 +556,7 @@ static struct qcom_icc_node mas_snoc_cnoc = {
 	.mas_rpm_id = 52,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
 	.links = mas_snoc_cnoc_links,
 };
@@ -635,10 +605,7 @@ static struct qcom_icc_node mas_qdss_dap = {
 	.mas_rpm_id = 49,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
 	.links = mas_qdss_dap_links,
 };
@@ -655,10 +622,7 @@ static struct qcom_icc_node mas_apss_proc = {
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_apss_proc_links),
 	.links = mas_apss_proc_links,
 };
@@ -685,10 +649,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg = {
 	.mas_rpm_id = 4,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_mmss_cfg_links),
 	.links = mas_cnoc_mnoc_mmss_cfg_links,
 };
@@ -704,10 +665,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_cfg = {
 	.mas_rpm_id = 5,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_cfg_links),
 	.links = mas_cnoc_mnoc_cfg_links,
 };
@@ -880,11 +838,6 @@ static struct qcom_icc_node mas_snoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = 20,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
 	.links = mas_snoc_cfg_links,
 };
@@ -907,11 +860,6 @@ static struct qcom_icc_node mas_bimc_snoc = {
 	.buswidth = 8,
 	.mas_rpm_id = 21,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_bimc_snoc_links),
 	.links = mas_bimc_snoc_links,
 };
@@ -934,11 +882,6 @@ static struct qcom_icc_node mas_gnoc_snoc = {
 	.buswidth = 8,
 	.mas_rpm_id = 150,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_gnoc_snoc_links),
 	.links = mas_gnoc_snoc_links,
 };
@@ -962,11 +905,6 @@ static struct qcom_icc_node mas_a2noc_snoc = {
 	.buswidth = 16,
 	.mas_rpm_id = 112,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(mas_a2noc_snoc_links),
 	.links = mas_a2noc_snoc_links,
 };
@@ -981,11 +919,6 @@ static struct qcom_icc_node slv_a2noc_snoc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 143,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(slv_a2noc_snoc_links),
 	.links = slv_a2noc_snoc_links,
 };
@@ -996,11 +929,6 @@ static struct qcom_icc_node slv_ebi = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 0,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node slv_hmss_l3 = {
@@ -1009,11 +937,6 @@ static struct qcom_icc_node slv_hmss_l3 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 160,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static const u16 slv_bimc_snoc_links[] = {
@@ -1026,11 +949,6 @@ static struct qcom_icc_node slv_bimc_snoc = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 2,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(slv_bimc_snoc_links),
 	.links = slv_bimc_snoc_links,
 };
@@ -1046,10 +964,7 @@ static struct qcom_icc_node slv_cnoc_a2noc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 208,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_cnoc_a2noc_links),
 	.links = slv_cnoc_a2noc_links,
 };
@@ -1061,10 +976,7 @@ static struct qcom_icc_node slv_mpm = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 62,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_pmic_arb = {
@@ -1074,10 +986,7 @@ static struct qcom_icc_node slv_pmic_arb = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 59,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_tlmm_north = {
@@ -1087,10 +996,7 @@ static struct qcom_icc_node slv_tlmm_north = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 214,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_tcsr = {
@@ -1100,10 +1006,7 @@ static struct qcom_icc_node slv_tcsr = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 50,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_pimem_cfg = {
@@ -1113,10 +1016,7 @@ static struct qcom_icc_node slv_pimem_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 167,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_imem_cfg = {
@@ -1126,10 +1026,7 @@ static struct qcom_icc_node slv_imem_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 54,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_message_ram = {
@@ -1139,10 +1036,7 @@ static struct qcom_icc_node slv_message_ram = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 55,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_glm = {
@@ -1152,10 +1046,7 @@ static struct qcom_icc_node slv_glm = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 209,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_bimc_cfg = {
@@ -1165,10 +1056,7 @@ static struct qcom_icc_node slv_bimc_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 56,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_prng = {
@@ -1178,10 +1066,7 @@ static struct qcom_icc_node slv_prng = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 44,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_spdm = {
@@ -1191,10 +1076,7 @@ static struct qcom_icc_node slv_spdm = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 60,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_qdss_cfg = {
@@ -1204,10 +1086,7 @@ static struct qcom_icc_node slv_qdss_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 63,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static const u16 slv_cnoc_mnoc_cfg_links[] = {
@@ -1221,10 +1100,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 66,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
 	.links = slv_cnoc_mnoc_cfg_links,
 };
@@ -1236,10 +1112,7 @@ static struct qcom_icc_node slv_snoc_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 70,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_qm_cfg = {
@@ -1249,10 +1122,7 @@ static struct qcom_icc_node slv_qm_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 212,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_clk_ctl = {
@@ -1262,10 +1132,7 @@ static struct qcom_icc_node slv_clk_ctl = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 47,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_mss_cfg = {
@@ -1275,10 +1142,7 @@ static struct qcom_icc_node slv_mss_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 48,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_tlmm_south = {
@@ -1288,10 +1152,7 @@ static struct qcom_icc_node slv_tlmm_south = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 217,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_ufs_cfg = {
@@ -1301,10 +1162,7 @@ static struct qcom_icc_node slv_ufs_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 92,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_a2noc_cfg = {
@@ -1314,10 +1172,7 @@ static struct qcom_icc_node slv_a2noc_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 150,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_a2noc_smmu_cfg = {
@@ -1327,10 +1182,7 @@ static struct qcom_icc_node slv_a2noc_smmu_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 152,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_gpuss_cfg = {
@@ -1340,10 +1192,7 @@ static struct qcom_icc_node slv_gpuss_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 11,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_ahb2phy = {
@@ -1353,10 +1202,7 @@ static struct qcom_icc_node slv_ahb2phy = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 163,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_blsp_1 = {
@@ -1366,10 +1212,7 @@ static struct qcom_icc_node slv_blsp_1 = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 39,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_sdcc_1 = {
@@ -1379,10 +1222,7 @@ static struct qcom_icc_node slv_sdcc_1 = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 31,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_sdcc_2 = {
@@ -1392,10 +1232,7 @@ static struct qcom_icc_node slv_sdcc_2 = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 33,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_tlmm_center = {
@@ -1405,10 +1242,7 @@ static struct qcom_icc_node slv_tlmm_center = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 218,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_blsp_2 = {
@@ -1418,10 +1252,7 @@ static struct qcom_icc_node slv_blsp_2 = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 37,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_pdm = {
@@ -1431,10 +1262,7 @@ static struct qcom_icc_node slv_pdm = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 41,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static const u16 slv_cnoc_mnoc_mmss_cfg_links[] = {
@@ -1448,10 +1276,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 58,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_mmss_cfg_links),
 	.links = slv_cnoc_mnoc_mmss_cfg_links,
 };
@@ -1463,10 +1288,7 @@ static struct qcom_icc_node slv_usb_hs = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 40,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_usb3_0 = {
@@ -1476,10 +1298,7 @@ static struct qcom_icc_node slv_usb3_0 = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 22,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_srvc_cnoc = {
@@ -1489,10 +1308,7 @@ static struct qcom_icc_node slv_srvc_cnoc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 76,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static const u16 slv_gnoc_bimc_links[] = {
@@ -1506,10 +1322,7 @@ static struct qcom_icc_node slv_gnoc_bimc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 210,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_gnoc_bimc_links),
 	.links = slv_gnoc_bimc_links,
 };
@@ -1525,10 +1338,7 @@ static struct qcom_icc_node slv_gnoc_snoc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 211,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_gnoc_snoc_links),
 	.links = slv_gnoc_snoc_links,
 };
@@ -1540,10 +1350,7 @@ static struct qcom_icc_node slv_camera_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 3,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_camera_throttle_cfg = {
@@ -1553,10 +1360,7 @@ static struct qcom_icc_node slv_camera_throttle_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 154,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_misc_cfg = {
@@ -1566,10 +1370,7 @@ static struct qcom_icc_node slv_misc_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 8,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_venus_throttle_cfg = {
@@ -1579,10 +1380,7 @@ static struct qcom_icc_node slv_venus_throttle_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 178,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_venus_cfg = {
@@ -1592,10 +1390,7 @@ static struct qcom_icc_node slv_venus_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 10,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
@@ -1605,10 +1400,7 @@ static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 13,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_mmss_clk_cfg = {
@@ -1618,10 +1410,7 @@ static struct qcom_icc_node slv_mmss_clk_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 12,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_mnoc_mpu_cfg = {
@@ -1631,10 +1420,7 @@ static struct qcom_icc_node slv_mnoc_mpu_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 14,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_display_cfg = {
@@ -1644,10 +1430,7 @@ static struct qcom_icc_node slv_display_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 4,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_csi_phy_cfg = {
@@ -1657,10 +1440,7 @@ static struct qcom_icc_node slv_csi_phy_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 224,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_display_throttle_cfg = {
@@ -1670,10 +1450,7 @@ static struct qcom_icc_node slv_display_throttle_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 156,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_smmu_cfg = {
@@ -1683,10 +1460,7 @@ static struct qcom_icc_node slv_smmu_cfg = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 205,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static const u16 slv_mnoc_bimc_links[] = {
@@ -1700,10 +1474,7 @@ static struct qcom_icc_node slv_mnoc_bimc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 16,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(slv_mnoc_bimc_links),
 	.links = slv_mnoc_bimc_links,
 };
@@ -1715,10 +1486,7 @@ static struct qcom_icc_node slv_srvc_mnoc = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 17,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_hmss = {
@@ -1728,10 +1496,7 @@ static struct qcom_icc_node slv_hmss = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 20,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_lpass = {
@@ -1741,10 +1506,7 @@ static struct qcom_icc_node slv_lpass = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 21,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_wlan = {
@@ -1753,11 +1515,6 @@ static struct qcom_icc_node slv_wlan = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 206,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node slv_cdsp = {
@@ -1767,10 +1524,7 @@ static struct qcom_icc_node slv_cdsp = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 221,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_ipa = {
@@ -1780,10 +1534,7 @@ static struct qcom_icc_node slv_ipa = {
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 183,
 	.qos.ap_owned = true,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static const u16 slv_snoc_bimc_links[] = {
@@ -1796,11 +1547,6 @@ static struct qcom_icc_node slv_snoc_bimc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 24,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(slv_snoc_bimc_links),
 	.links = slv_snoc_bimc_links,
 };
@@ -1815,11 +1561,6 @@ static struct qcom_icc_node slv_snoc_cnoc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 25,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 	.num_links = ARRAY_SIZE(slv_snoc_cnoc_links),
 	.links = slv_snoc_cnoc_links,
 };
@@ -1830,11 +1571,6 @@ static struct qcom_icc_node slv_imem = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 26,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node slv_pimem = {
@@ -1843,11 +1579,6 @@ static struct qcom_icc_node slv_pimem = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 166,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node slv_qdss_stm = {
@@ -1856,11 +1587,6 @@ static struct qcom_icc_node slv_qdss_stm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 30,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node slv_srvc_snoc = {
@@ -1869,11 +1595,6 @@ static struct qcom_icc_node slv_srvc_snoc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 29,
-	.qos.ap_owned = false,
-	.qos.qos_mode = -1,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
 };
 
 static struct qcom_icc_node *sdm660_a2noc_nodes[] = {
@@ -2113,7 +1834,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	/* QoS Priority: The QoS Health parameters are getting considered
@@ -2171,7 +1892,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 		return 0;
 	}
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	if (mode == NOC_QOS_MODE_FIXED) {
@@ -2264,7 +1985,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
 		if (ret)
 			return ret;
-	} else if (qn->qos.qos_mode != -1) {
+	} else if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
 		/* set bandwidth directly from the AP */
 		ret = qcom_icc_qos_set(src, sum_bw);
 		if (ret)
-- 
2.33.0

