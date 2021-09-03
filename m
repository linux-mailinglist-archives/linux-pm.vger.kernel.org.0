Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E3400840
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbhICXZ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350743AbhICXZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBEC061757
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq28so1327613lfb.7
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aI8o2oPgEEMzxMibNBY+GnQvGWahR2uE+yIXUCRBH2Y=;
        b=kjjFvnPRiZ0fcWMlEaStGo+/LTspupWwmcgvhCoRCXNWemupcRaFp1s/IyTyPSzYH1
         Jwp2BFmxSG2bWl2C1bmzOditpPzbbiy/urfgx+ygE2vATPr3MVuze2Te5LBwLIH6hLOC
         J1kt19yPviTRlCFa572W/t4rhlrUaI2wt8Gt6RyCMUrFL9XxTIS+9Aq/bwq3mBtMy/Wc
         kiOCUWXg8c6tRPTuyeYgYVdR96ZeeUB9lb2l1ZrgeRWOFmrsYSwLeHWmiuOmNuv8q9xw
         QGD1ydHZHZa04WJavM05IiMZz2rmrAU+pNr51SQDW+p02c2KGjVo6+5S7PnWasxtawSM
         zmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aI8o2oPgEEMzxMibNBY+GnQvGWahR2uE+yIXUCRBH2Y=;
        b=b5ZKeDO1exTL0RVmqwipXzivvS2dTGWMft/6Qm4p0n7dR60Q73k/t+fR3pMVbiUUdm
         M/JH1L4DKWO4yVPY1aAQLHUxAEKcEchAgTsTVIKdgk4bd5CvKNMR1Y8qa5j1z4tMGKMI
         hZtIUiBHsPxmDiHzNCzDWMcKkGCi1CZ32pdymHIBYWc+GNLmg0EwRJQ00agCQbVn2doo
         To59lLkgI3EoluIZiOR05xCYoMA2+7LlmsH/OoJsqDpAGI372aYFAudlqvDYQOzFffdz
         dh5nYL/njHiyM9ifWmRM+Tu7JT+cqdOpTIS0iqoH7lj97KAPCeVmE8kGrS1baaxoW+Mx
         WuGQ==
X-Gm-Message-State: AOAM531SnNLgQ6UlesigDPNHdoK6w0xrSU2Cia0HwCS60gtNv9dqrlyU
        xIRc0Y1FxpC347eTwT9z3wrjbw==
X-Google-Smtp-Source: ABdhPJwYpTkkwH6SIFIcaJQhvs5WOL9iZpJCvwADVf+uVE01wyaWkb6QtsAZfyYSHkPD5+EsT+ZjiQ==
X-Received: by 2002:a05:6512:e89:: with SMTP id bi9mr904779lfb.95.1630711465760;
        Fri, 03 Sep 2021 16:24:25 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 02/11] interconnect: sdm660: expand DEFINE_QNODE macros
Date:   Sat,  4 Sep 2021 02:24:12 +0300
Message-Id: <20210903232421.1384199-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expand DEFINE_QNODE macros, which with an addition of QoS become an ugly
beast with tons of different arguments. While we are at it also move
links lists to separate arrays.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 1742 ++++++++++++++++++++++++++--
 1 file changed, 1626 insertions(+), 116 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index fb23a5b780a4..652f7cc9cad6 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -201,8 +201,6 @@ struct qcom_icc_provider {
 	void __iomem *mmio;
 };
 
-#define SDM660_MAX_LINKS	34
-
 /**
  * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
  * @areq_prio: node requests priority
@@ -236,7 +234,7 @@ struct qcom_icc_qos {
 struct qcom_icc_node {
 	unsigned char *name;
 	u16 id;
-	u16 links[SDM660_MAX_LINKS];
+	const u16 *links;
 	u16 num_links;
 	u16 buswidth;
 	int mas_rpm_id;
@@ -251,120 +249,1632 @@ struct qcom_icc_desc {
 	const struct regmap_config *regmap_cfg;
 };
 
-#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-		     _ap_owned, _qos_mode, _qos_prio, _qos_port, ...)	\
-		static struct qcom_icc_node _name = {			\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.mas_rpm_id = _mas_rpm_id,				\
-		.slv_rpm_id = _slv_rpm_id,				\
-		.qos.ap_owned = _ap_owned,				\
-		.qos.qos_mode = _qos_mode,				\
-		.qos.areq_prio = _qos_prio,				\
-		.qos.prio_level = _qos_prio,				\
-		.qos.qos_port = _qos_port,				\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
+static const u16 mas_ipa_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_ipa = {
+	.name = "mas_ipa",
+	.id = SDM660_MASTER_IPA,
+	.buswidth = 8,
+	.mas_rpm_id = 59,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 3,
+	.num_links = ARRAY_SIZE(mas_ipa_links),
+	.links = mas_ipa_links,
+};
+
+static const u16 mas_cnoc_a2noc_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_cnoc_a2noc = {
+	.name = "mas_cnoc_a2noc",
+	.id = SDM660_MASTER_CNOC_A2NOC,
+	.buswidth = 8,
+	.mas_rpm_id = 146,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_cnoc_a2noc_links),
+	.links = mas_cnoc_a2noc_links,
+};
+
+static const u16 mas_sdcc_1_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_sdcc_1 = {
+	.name = "mas_sdcc_1",
+	.id = SDM660_MASTER_SDCC_1,
+	.buswidth = 8,
+	.mas_rpm_id = 33,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
+	.links = mas_sdcc_1_links,
+};
+
+static const u16 mas_sdcc_2_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_sdcc_2 = {
+	.name = "mas_sdcc_2",
+	.id = SDM660_MASTER_SDCC_2,
+	.buswidth = 8,
+	.mas_rpm_id = 35,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
+	.links = mas_sdcc_2_links,
+};
+
+static const u16 mas_blsp_1_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_blsp_1 = {
+	.name = "mas_blsp_1",
+	.id = SDM660_MASTER_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = 41,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_1_links),
+	.links = mas_blsp_1_links,
+};
+
+static const u16 mas_blsp_2_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_blsp_2 = {
+	.name = "mas_blsp_2",
+	.id = SDM660_MASTER_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = 39,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_2_links),
+	.links = mas_blsp_2_links,
+};
+
+static const u16 mas_ufs_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_ufs = {
+	.name = "mas_ufs",
+	.id = SDM660_MASTER_UFS,
+	.buswidth = 8,
+	.mas_rpm_id = 68,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 4,
+	.num_links = ARRAY_SIZE(mas_ufs_links),
+	.links = mas_ufs_links,
+};
+
+static const u16 mas_usb_hs_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_usb_hs = {
+	.name = "mas_usb_hs",
+	.id = SDM660_MASTER_USB_HS,
+	.buswidth = 8,
+	.mas_rpm_id = 42,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
+	.num_links = ARRAY_SIZE(mas_usb_hs_links),
+	.links = mas_usb_hs_links,
+};
+
+static const u16 mas_usb3_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_usb3 = {
+	.name = "mas_usb3",
+	.id = SDM660_MASTER_USB3,
+	.buswidth = 8,
+	.mas_rpm_id = 32,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 2,
+	.num_links = ARRAY_SIZE(mas_usb3_links),
+	.links = mas_usb3_links,
+};
+
+static const u16 mas_crypto_links[] = {
+	SDM660_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_crypto = {
+	.name = "mas_crypto",
+	.id = SDM660_MASTER_CRYPTO_C0,
+	.buswidth = 8,
+	.mas_rpm_id = 23,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 11,
+	.num_links = ARRAY_SIZE(mas_crypto_links),
+	.links = mas_crypto_links,
+};
+
+static const u16 mas_gnoc_bimc_links[] = {
+	SDM660_SLAVE_EBI
+};
+
+static struct qcom_icc_node mas_gnoc_bimc = {
+	.name = "mas_gnoc_bimc",
+	.id = SDM660_MASTER_GNOC_BIMC,
+	.buswidth = 4,
+	.mas_rpm_id = 144,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
+	.num_links = ARRAY_SIZE(mas_gnoc_bimc_links),
+	.links = mas_gnoc_bimc_links,
+};
+
+static const u16 mas_oxili_links[] = {
+	SDM660_SLAVE_HMSS_L3,
+	SDM660_SLAVE_EBI,
+	SDM660_SLAVE_BIMC_SNOC
+};
+
+static struct qcom_icc_node mas_oxili = {
+	.name = "mas_oxili",
+	.id = SDM660_MASTER_OXILI,
+	.buswidth = 4,
+	.mas_rpm_id = 6,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 1,
+	.num_links = ARRAY_SIZE(mas_oxili_links),
+	.links = mas_oxili_links,
+};
+
+static const u16 mas_mnoc_bimc_links[] = {
+	SDM660_SLAVE_HMSS_L3,
+	SDM660_SLAVE_EBI,
+	SDM660_SLAVE_BIMC_SNOC
+};
+
+static struct qcom_icc_node mas_mnoc_bimc = {
+	.name = "mas_mnoc_bimc",
+	.id = SDM660_MASTER_MNOC_BIMC,
+	.buswidth = 4,
+	.mas_rpm_id = 2,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 2,
+	.num_links = ARRAY_SIZE(mas_mnoc_bimc_links),
+	.links = mas_mnoc_bimc_links,
+};
+
+static const u16 mas_snoc_bimc_links[] = {
+	SDM660_SLAVE_HMSS_L3,
+	SDM660_SLAVE_EBI
+};
+
+static struct qcom_icc_node mas_snoc_bimc = {
+	.name = "mas_snoc_bimc",
+	.id = SDM660_MASTER_SNOC_BIMC,
+	.buswidth = 4,
+	.mas_rpm_id = 3,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
+	.links = mas_snoc_bimc_links,
+};
+
+static const u16 mas_pimem_links[] = {
+	SDM660_SLAVE_HMSS_L3,
+	SDM660_SLAVE_EBI
+};
+
+static struct qcom_icc_node mas_pimem = {
+	.name = "mas_pimem",
+	.id = SDM660_MASTER_PIMEM,
+	.buswidth = 4,
+	.mas_rpm_id = 113,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 4,
+	.num_links = ARRAY_SIZE(mas_pimem_links),
+	.links = mas_pimem_links,
+};
+
+static const u16 mas_snoc_cnoc_links[] = {
+	SDM660_SLAVE_CLK_CTL,
+	SDM660_SLAVE_QDSS_CFG,
+	SDM660_SLAVE_QM_CFG,
+	SDM660_SLAVE_SRVC_CNOC,
+	SDM660_SLAVE_UFS_CFG,
+	SDM660_SLAVE_TCSR,
+	SDM660_SLAVE_A2NOC_SMMU_CFG,
+	SDM660_SLAVE_SNOC_CFG,
+	SDM660_SLAVE_TLMM_SOUTH,
+	SDM660_SLAVE_MPM,
+	SDM660_SLAVE_CNOC_MNOC_MMSS_CFG,
+	SDM660_SLAVE_SDCC_2,
+	SDM660_SLAVE_SDCC_1,
+	SDM660_SLAVE_SPDM,
+	SDM660_SLAVE_PMIC_ARB,
+	SDM660_SLAVE_PRNG,
+	SDM660_SLAVE_MSS_CFG,
+	SDM660_SLAVE_GPUSS_CFG,
+	SDM660_SLAVE_IMEM_CFG,
+	SDM660_SLAVE_USB3_0,
+	SDM660_SLAVE_A2NOC_CFG,
+	SDM660_SLAVE_TLMM_NORTH,
+	SDM660_SLAVE_USB_HS,
+	SDM660_SLAVE_PDM,
+	SDM660_SLAVE_TLMM_CENTER,
+	SDM660_SLAVE_AHB2PHY,
+	SDM660_SLAVE_BLSP_2,
+	SDM660_SLAVE_BLSP_1,
+	SDM660_SLAVE_PIMEM_CFG,
+	SDM660_SLAVE_GLM,
+	SDM660_SLAVE_MESSAGE_RAM,
+	SDM660_SLAVE_BIMC_CFG,
+	SDM660_SLAVE_CNOC_MNOC_CFG
+};
+
+static struct qcom_icc_node mas_snoc_cnoc = {
+	.name = "mas_snoc_cnoc",
+	.id = SDM660_MASTER_SNOC_CNOC,
+	.buswidth = 8,
+	.mas_rpm_id = 52,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
+	.links = mas_snoc_cnoc_links,
+};
+
+static const u16 mas_qdss_dap_links[] = {
+	SDM660_SLAVE_CLK_CTL,
+	SDM660_SLAVE_QDSS_CFG,
+	SDM660_SLAVE_QM_CFG,
+	SDM660_SLAVE_SRVC_CNOC,
+	SDM660_SLAVE_UFS_CFG,
+	SDM660_SLAVE_TCSR,
+	SDM660_SLAVE_A2NOC_SMMU_CFG,
+	SDM660_SLAVE_SNOC_CFG,
+	SDM660_SLAVE_TLMM_SOUTH,
+	SDM660_SLAVE_MPM,
+	SDM660_SLAVE_CNOC_MNOC_MMSS_CFG,
+	SDM660_SLAVE_SDCC_2,
+	SDM660_SLAVE_SDCC_1,
+	SDM660_SLAVE_SPDM,
+	SDM660_SLAVE_PMIC_ARB,
+	SDM660_SLAVE_PRNG,
+	SDM660_SLAVE_MSS_CFG,
+	SDM660_SLAVE_GPUSS_CFG,
+	SDM660_SLAVE_IMEM_CFG,
+	SDM660_SLAVE_USB3_0,
+	SDM660_SLAVE_A2NOC_CFG,
+	SDM660_SLAVE_TLMM_NORTH,
+	SDM660_SLAVE_USB_HS,
+	SDM660_SLAVE_PDM,
+	SDM660_SLAVE_TLMM_CENTER,
+	SDM660_SLAVE_AHB2PHY,
+	SDM660_SLAVE_BLSP_2,
+	SDM660_SLAVE_BLSP_1,
+	SDM660_SLAVE_PIMEM_CFG,
+	SDM660_SLAVE_GLM,
+	SDM660_SLAVE_MESSAGE_RAM,
+	SDM660_SLAVE_CNOC_A2NOC,
+	SDM660_SLAVE_BIMC_CFG,
+	SDM660_SLAVE_CNOC_MNOC_CFG
+};
+
+static struct qcom_icc_node mas_qdss_dap = {
+	.name = "mas_qdss_dap",
+	.id = SDM660_MASTER_QDSS_DAP,
+	.buswidth = 8,
+	.mas_rpm_id = 49,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
+	.links = mas_qdss_dap_links,
+};
+
+static const u16 mas_apss_proc_links[] = {
+	SDM660_SLAVE_GNOC_SNOC,
+	SDM660_SLAVE_GNOC_BIMC
+};
+
+static struct qcom_icc_node mas_apss_proc = {
+	.name = "mas_apss_proc",
+	.id = SDM660_MASTER_APPS_PROC,
+	.buswidth = 16,
+	.mas_rpm_id = 0,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_apss_proc_links),
+	.links = mas_apss_proc_links,
+};
+
+static const u16 mas_cnoc_mnoc_mmss_cfg_links[] = {
+	SDM660_SLAVE_VENUS_THROTTLE_CFG,
+	SDM660_SLAVE_VENUS_CFG,
+	SDM660_SLAVE_CAMERA_THROTTLE_CFG,
+	SDM660_SLAVE_SMMU_CFG,
+	SDM660_SLAVE_CAMERA_CFG,
+	SDM660_SLAVE_CSI_PHY_CFG,
+	SDM660_SLAVE_DISPLAY_THROTTLE_CFG,
+	SDM660_SLAVE_DISPLAY_CFG,
+	SDM660_SLAVE_MMSS_CLK_CFG,
+	SDM660_SLAVE_MNOC_MPU_CFG,
+	SDM660_SLAVE_MISC_CFG,
+	SDM660_SLAVE_MMSS_CLK_XPU_CFG
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg = {
+	.name = "mas_cnoc_mnoc_mmss_cfg",
+	.id = SDM660_MASTER_CNOC_MNOC_MMSS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = 4,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_mmss_cfg_links),
+	.links = mas_cnoc_mnoc_mmss_cfg_links,
+};
+
+static const u16 mas_cnoc_mnoc_cfg_links[] = {
+	SDM660_SLAVE_SRVC_MNOC
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_cfg = {
+	.name = "mas_cnoc_mnoc_cfg",
+	.id = SDM660_MASTER_CNOC_MNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = 5,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_cfg_links),
+	.links = mas_cnoc_mnoc_cfg_links,
+};
+
+static const u16 mas_cpp_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_cpp = {
+	.name = "mas_cpp",
+	.id = SDM660_MASTER_CPP,
+	.buswidth = 16,
+	.mas_rpm_id = 115,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 4,
+	.num_links = ARRAY_SIZE(mas_cpp_links),
+	.links = mas_cpp_links,
+};
+
+static const u16 mas_jpeg_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_jpeg = {
+	.name = "mas_jpeg",
+	.id = SDM660_MASTER_JPEG,
+	.buswidth = 16,
+	.mas_rpm_id = 7,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 6,
+	.num_links = ARRAY_SIZE(mas_jpeg_links),
+	.links = mas_jpeg_links,
+};
+
+static const u16 mas_mdp_p0_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_mdp_p0 = {
+	.name = "mas_mdp_p0",
+	.id = SDM660_MASTER_MDP_P0,
+	.buswidth = 16,
+	.mas_rpm_id = 8,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
+	.num_links = ARRAY_SIZE(mas_mdp_p0_links),
+	.links = mas_mdp_p0_links,
+};
+
+static const u16 mas_mdp_p1_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_mdp_p1 = {
+	.name = "mas_mdp_p1",
+	.id = SDM660_MASTER_MDP_P1,
+	.buswidth = 16,
+	.mas_rpm_id = 61,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 1,
+	.num_links = ARRAY_SIZE(mas_mdp_p1_links),
+	.links = mas_mdp_p1_links,
+};
+
+static const u16 mas_venus_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_venus = {
+	.name = "mas_venus",
+	.id = SDM660_MASTER_VENUS,
+	.buswidth = 16,
+	.mas_rpm_id = 9,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 1,
+	.num_links = ARRAY_SIZE(mas_venus_links),
+	.links = mas_venus_links,
+};
+
+static const u16 mas_vfe_links[] = {
+	SDM660_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_vfe = {
+	.name = "mas_vfe",
+	.id = SDM660_MASTER_VFE,
+	.buswidth = 16,
+	.mas_rpm_id = 11,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 5,
+	.num_links = ARRAY_SIZE(mas_vfe_links),
+	.links = mas_vfe_links,
+};
+
+static const u16 mas_qdss_etr_links[] = {
+	SDM660_SLAVE_PIMEM,
+	SDM660_SLAVE_IMEM,
+	SDM660_SLAVE_SNOC_CNOC,
+	SDM660_SLAVE_SNOC_BIMC
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.name = "mas_qdss_etr",
+	.id = SDM660_MASTER_QDSS_ETR,
+	.buswidth = 8,
+	.mas_rpm_id = 31,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
+	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
+	.links = mas_qdss_etr_links,
+};
+
+static const u16 mas_qdss_bam_links[] = {
+	SDM660_SLAVE_PIMEM,
+	SDM660_SLAVE_IMEM,
+	SDM660_SLAVE_SNOC_CNOC,
+	SDM660_SLAVE_SNOC_BIMC
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.name = "mas_qdss_bam",
+	.id = SDM660_MASTER_QDSS_BAM,
+	.buswidth = 4,
+	.mas_rpm_id = 19,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 0,
+	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
+	.links = mas_qdss_bam_links,
+};
+
+static const u16 mas_snoc_cfg_links[] = {
+	SDM660_SLAVE_SRVC_SNOC
+};
+
+static struct qcom_icc_node mas_snoc_cfg = {
+	.name = "mas_snoc_cfg",
+	.id = SDM660_MASTER_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = 20,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
+	.links = mas_snoc_cfg_links,
+};
+
+static const u16 mas_bimc_snoc_links[] = {
+	SDM660_SLAVE_PIMEM,
+	SDM660_SLAVE_IPA,
+	SDM660_SLAVE_QDSS_STM,
+	SDM660_SLAVE_LPASS,
+	SDM660_SLAVE_HMSS,
+	SDM660_SLAVE_CDSP,
+	SDM660_SLAVE_SNOC_CNOC,
+	SDM660_SLAVE_WLAN,
+	SDM660_SLAVE_IMEM
+};
+
+static struct qcom_icc_node mas_bimc_snoc = {
+	.name = "mas_bimc_snoc",
+	.id = SDM660_MASTER_BIMC_SNOC,
+	.buswidth = 8,
+	.mas_rpm_id = 21,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_bimc_snoc_links),
+	.links = mas_bimc_snoc_links,
+};
+
+static const u16 mas_gnoc_snoc_links[] = {
+	SDM660_SLAVE_PIMEM,
+	SDM660_SLAVE_IPA,
+	SDM660_SLAVE_QDSS_STM,
+	SDM660_SLAVE_LPASS,
+	SDM660_SLAVE_HMSS,
+	SDM660_SLAVE_CDSP,
+	SDM660_SLAVE_SNOC_CNOC,
+	SDM660_SLAVE_WLAN,
+	SDM660_SLAVE_IMEM
+};
+
+static struct qcom_icc_node mas_gnoc_snoc = {
+	.name = "mas_gnoc_snoc",
+	.id = SDM660_MASTER_GNOC_SNOC,
+	.buswidth = 8,
+	.mas_rpm_id = 150,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_gnoc_snoc_links),
+	.links = mas_gnoc_snoc_links,
+};
+
+static const u16 mas_a2noc_snoc_links[] = {
+	SDM660_SLAVE_PIMEM,
+	SDM660_SLAVE_IPA,
+	SDM660_SLAVE_QDSS_STM,
+	SDM660_SLAVE_LPASS,
+	SDM660_SLAVE_HMSS,
+	SDM660_SLAVE_SNOC_BIMC,
+	SDM660_SLAVE_CDSP,
+	SDM660_SLAVE_SNOC_CNOC,
+	SDM660_SLAVE_WLAN,
+	SDM660_SLAVE_IMEM
+};
+
+static struct qcom_icc_node mas_a2noc_snoc = {
+	.name = "mas_a2noc_snoc",
+	.id = SDM660_MASTER_A2NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = 112,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_a2noc_snoc_links),
+	.links = mas_a2noc_snoc_links,
+};
+
+static const u16 slv_a2noc_snoc_links[] = {
+	SDM660_MASTER_A2NOC_SNOC
+};
+
+static struct qcom_icc_node slv_a2noc_snoc = {
+	.name = "slv_a2noc_snoc",
+	.id = SDM660_SLAVE_A2NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 143,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_a2noc_snoc_links),
+	.links = slv_a2noc_snoc_links,
+};
+
+static struct qcom_icc_node slv_ebi = {
+	.name = "slv_ebi",
+	.id = SDM660_SLAVE_EBI,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_hmss_l3 = {
+	.name = "slv_hmss_l3",
+	.id = SDM660_SLAVE_HMSS_L3,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 160,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_bimc_snoc_links[] = {
+	SDM660_MASTER_BIMC_SNOC
+};
+
+static struct qcom_icc_node slv_bimc_snoc = {
+	.name = "slv_bimc_snoc",
+	.id = SDM660_SLAVE_BIMC_SNOC,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 2,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_bimc_snoc_links),
+	.links = slv_bimc_snoc_links,
+};
+
+static const u16 slv_cnoc_a2noc_links[] = {
+	SDM660_MASTER_CNOC_A2NOC
+};
+
+static struct qcom_icc_node slv_cnoc_a2noc = {
+	.name = "slv_cnoc_a2noc",
+	.id = SDM660_SLAVE_CNOC_A2NOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 208,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_cnoc_a2noc_links),
+	.links = slv_cnoc_a2noc_links,
+};
+
+static struct qcom_icc_node slv_mpm = {
+	.name = "slv_mpm",
+	.id = SDM660_SLAVE_MPM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 62,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slv_pmic_arb",
+	.id = SDM660_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 59,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_tlmm_north = {
+	.name = "slv_tlmm_north",
+	.id = SDM660_SLAVE_TLMM_NORTH,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 214,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slv_tcsr",
+	.id = SDM660_SLAVE_TCSR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 50,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pimem_cfg = {
+	.name = "slv_pimem_cfg",
+	.id = SDM660_SLAVE_PIMEM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 167,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_imem_cfg = {
+	.name = "slv_imem_cfg",
+	.id = SDM660_SLAVE_IMEM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 54,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_message_ram = {
+	.name = "slv_message_ram",
+	.id = SDM660_SLAVE_MESSAGE_RAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 55,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_glm = {
+	.name = "slv_glm",
+	.id = SDM660_SLAVE_GLM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 209,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_bimc_cfg = {
+	.name = "slv_bimc_cfg",
+	.id = SDM660_SLAVE_BIMC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 56,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slv_prng",
+	.id = SDM660_SLAVE_PRNG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 44,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_spdm = {
+	.name = "slv_spdm",
+	.id = SDM660_SLAVE_SPDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 60,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_qdss_cfg = {
+	.name = "slv_qdss_cfg",
+	.id = SDM660_SLAVE_QDSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 63,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_cnoc_mnoc_cfg_links[] = {
+	SDM660_MASTER_CNOC_MNOC_CFG
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_cfg = {
+	.name = "slv_cnoc_mnoc_cfg",
+	.id = SDM660_SLAVE_CNOC_MNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 66,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
+	.links = slv_cnoc_mnoc_cfg_links,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slv_snoc_cfg",
+	.id = SDM660_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 70,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_qm_cfg = {
+	.name = "slv_qm_cfg",
+	.id = SDM660_SLAVE_QM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 212,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_clk_ctl = {
+	.name = "slv_clk_ctl",
+	.id = SDM660_SLAVE_CLK_CTL,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 47,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_mss_cfg = {
+	.name = "slv_mss_cfg",
+	.id = SDM660_SLAVE_MSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 48,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_tlmm_south = {
+	.name = "slv_tlmm_south",
+	.id = SDM660_SLAVE_TLMM_SOUTH,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 217,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_ufs_cfg = {
+	.name = "slv_ufs_cfg",
+	.id = SDM660_SLAVE_UFS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 92,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_a2noc_cfg = {
+	.name = "slv_a2noc_cfg",
+	.id = SDM660_SLAVE_A2NOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 150,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_a2noc_smmu_cfg = {
+	.name = "slv_a2noc_smmu_cfg",
+	.id = SDM660_SLAVE_A2NOC_SMMU_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 152,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_gpuss_cfg = {
+	.name = "slv_gpuss_cfg",
+	.id = SDM660_SLAVE_GPUSS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 11,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_ahb2phy = {
+	.name = "slv_ahb2phy",
+	.id = SDM660_SLAVE_AHB2PHY,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 163,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_blsp_1 = {
+	.name = "slv_blsp_1",
+	.id = SDM660_SLAVE_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 39,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_sdcc_1 = {
+	.name = "slv_sdcc_1",
+	.id = SDM660_SLAVE_SDCC_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 31,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slv_sdcc_2",
+	.id = SDM660_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 33,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_tlmm_center = {
+	.name = "slv_tlmm_center",
+	.id = SDM660_SLAVE_TLMM_CENTER,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 218,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_blsp_2 = {
+	.name = "slv_blsp_2",
+	.id = SDM660_SLAVE_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 37,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slv_pdm",
+	.id = SDM660_SLAVE_PDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 41,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_cnoc_mnoc_mmss_cfg_links[] = {
+	SDM660_MASTER_CNOC_MNOC_MMSS_CFG
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg = {
+	.name = "slv_cnoc_mnoc_mmss_cfg",
+	.id = SDM660_SLAVE_CNOC_MNOC_MMSS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 58,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_mmss_cfg_links),
+	.links = slv_cnoc_mnoc_mmss_cfg_links,
+};
+
+static struct qcom_icc_node slv_usb_hs = {
+	.name = "slv_usb_hs",
+	.id = SDM660_SLAVE_USB_HS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 40,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_usb3_0 = {
+	.name = "slv_usb3_0",
+	.id = SDM660_SLAVE_USB3_0,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 22,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_srvc_cnoc = {
+	.name = "slv_srvc_cnoc",
+	.id = SDM660_SLAVE_SRVC_CNOC,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 76,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_gnoc_bimc_links[] = {
+	SDM660_MASTER_GNOC_BIMC
+};
+
+static struct qcom_icc_node slv_gnoc_bimc = {
+	.name = "slv_gnoc_bimc",
+	.id = SDM660_SLAVE_GNOC_BIMC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 210,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_gnoc_bimc_links),
+	.links = slv_gnoc_bimc_links,
+};
+
+static const u16 slv_gnoc_snoc_links[] = {
+	SDM660_MASTER_GNOC_SNOC
+};
+
+static struct qcom_icc_node slv_gnoc_snoc = {
+	.name = "slv_gnoc_snoc",
+	.id = SDM660_SLAVE_GNOC_SNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 211,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_gnoc_snoc_links),
+	.links = slv_gnoc_snoc_links,
+};
+
+static struct qcom_icc_node slv_camera_cfg = {
+	.name = "slv_camera_cfg",
+	.id = SDM660_SLAVE_CAMERA_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 3,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_camera_throttle_cfg = {
+	.name = "slv_camera_throttle_cfg",
+	.id = SDM660_SLAVE_CAMERA_THROTTLE_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 154,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_misc_cfg = {
+	.name = "slv_misc_cfg",
+	.id = SDM660_SLAVE_MISC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
 
-DEFINE_QNODE(mas_ipa, SDM660_MASTER_IPA, 8, 59, -1, true, NOC_QOS_MODE_FIXED, 1, 3, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_cnoc_a2noc, SDM660_MASTER_CNOC_A2NOC, 8, 146, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 35, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MODE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, true, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, true, NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
-DEFINE_QNODE(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, true, NOC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
-DEFINE_QNODE(mas_snoc_bimc, SDM660_MASTER_SNOC_BIMC, 4, 3, -1, false, -1, 0, -1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_pimem, SDM660_MASTER_PIMEM, 4, 113, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_snoc_cnoc, SDM660_MASTER_SNOC_CNOC, 8, 52, -1, true, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
-DEFINE_QNODE(mas_qdss_dap, SDM660_MASTER_QDSS_DAP, 8, 49, -1, true, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_CNOC_A2NOC, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
-DEFINE_QNODE(mas_apss_proc, SDM660_MASTER_APPS_PROC, 16, 0, -1, true, -1, 0, -1, SDM660_SLAVE_GNOC_SNOC, SDM660_SLAVE_GNOC_BIMC);
-DEFINE_QNODE(mas_cnoc_mnoc_mmss_cfg, SDM660_MASTER_CNOC_MNOC_MMSS_CFG, 8, 4, -1, true, -1, 0, -1, SDM660_SLAVE_VENUS_THROTTLE_CFG, SDM660_SLAVE_VENUS_CFG, SDM660_SLAVE_CAMERA_THROTTLE_CFG, SDM660_SLAVE_SMMU_CFG, SDM660_SLAVE_CAMERA_CFG, SDM660_SLAVE_CSI_PHY_CFG, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, SDM660_SLAVE_DISPLAY_CFG, SDM660_SLAVE_MMSS_CLK_CFG, SDM660_SLAVE_MNOC_MPU_CFG, SDM660_SLAVE_MISC_CFG, SDM660_SLAVE_MMSS_CLK_XPU_CFG);
-DEFINE_QNODE(mas_cnoc_mnoc_cfg, SDM660_MASTER_CNOC_MNOC_CFG, 4, 5, -1, true, -1, 0, -1, SDM660_SLAVE_SRVC_MNOC);
-DEFINE_QNODE(mas_cpp, SDM660_MASTER_CPP, 16, 115, -1, true, NOC_QOS_MODE_BYPASS, 0, 4, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_jpeg, SDM660_MASTER_JPEG, 16, 7, -1, true, NOC_QOS_MODE_BYPASS, 0, 6, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_mdp_p0, SDM660_MASTER_MDP_P0, 16, 8, -1, true, NOC_QOS_MODE_BYPASS, 0, 0, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp???? */
-DEFINE_QNODE(mas_mdp_p1, SDM660_MASTER_MDP_P1, 16, 61, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp??? */
-DEFINE_QNODE(mas_venus, SDM660_MASTER_VENUS, 16, 9, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_vfe, SDM660_MASTER_VFE, 16, 11, -1, true, NOC_QOS_MODE_BYPASS, 0, 5, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_qdss_etr, SDM660_MASTER_QDSS_ETR, 8, 31, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
-DEFINE_QNODE(mas_qdss_bam, SDM660_MASTER_QDSS_BAM, 4, 19, -1, true, NOC_QOS_MODE_FIXED, 1, 0, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
-DEFINE_QNODE(mas_snoc_cfg, SDM660_MASTER_SNOC_CFG, 4, 20, -1, false, -1, 0, -1, SDM660_SLAVE_SRVC_SNOC);
-DEFINE_QNODE(mas_bimc_snoc, SDM660_MASTER_BIMC_SNOC, 8, 21, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(mas_gnoc_snoc, SDM660_MASTER_GNOC_SNOC, 8, 150, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(mas_a2noc_snoc, SDM660_MASTER_A2NOC_SNOC, 16, 112, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_SNOC_BIMC, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(slv_a2noc_snoc, SDM660_SLAVE_A2NOC_SNOC, 16, -1, 143, false, -1, 0, -1, SDM660_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(slv_ebi, SDM660_SLAVE_EBI, 4, -1, 0, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_hmss_l3, SDM660_SLAVE_HMSS_L3, 4, -1, 160, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_bimc_snoc, SDM660_SLAVE_BIMC_SNOC, 4, -1, 2, false, -1, 0, -1, SDM660_MASTER_BIMC_SNOC);
-DEFINE_QNODE(slv_cnoc_a2noc, SDM660_SLAVE_CNOC_A2NOC, 8, -1, 208, true, -1, 0, -1, SDM660_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(slv_mpm, SDM660_SLAVE_MPM, 4, -1, 62, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pmic_arb, SDM660_SLAVE_PMIC_ARB, 4, -1, 59, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_north, SDM660_SLAVE_TLMM_NORTH, 8, -1, 214, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tcsr, SDM660_SLAVE_TCSR, 4, -1, 50, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pimem_cfg, SDM660_SLAVE_PIMEM_CFG, 4, -1, 167, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_imem_cfg, SDM660_SLAVE_IMEM_CFG, 4, -1, 54, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_message_ram, SDM660_SLAVE_MESSAGE_RAM, 4, -1, 55, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_glm, SDM660_SLAVE_GLM, 4, -1, 209, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_bimc_cfg, SDM660_SLAVE_BIMC_CFG, 4, -1, 56, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_prng, SDM660_SLAVE_PRNG, 4, -1, 44, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_spdm, SDM660_SLAVE_SPDM, 4, -1, 60, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qdss_cfg, SDM660_SLAVE_QDSS_CFG, 4, -1, 63, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cnoc_mnoc_cfg, SDM660_SLAVE_CNOC_MNOC_CFG, 4, -1, 66, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(slv_snoc_cfg, SDM660_SLAVE_SNOC_CFG, 4, -1, 70, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qm_cfg, SDM660_SLAVE_QM_CFG, 4, -1, 212, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_clk_ctl, SDM660_SLAVE_CLK_CTL, 4, -1, 47, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mss_cfg, SDM660_SLAVE_MSS_CFG, 4, -1, 48, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_south, SDM660_SLAVE_TLMM_SOUTH, 4, -1, 217, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ufs_cfg, SDM660_SLAVE_UFS_CFG, 4, -1, 92, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_a2noc_cfg, SDM660_SLAVE_A2NOC_CFG, 4, -1, 150, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_a2noc_smmu_cfg, SDM660_SLAVE_A2NOC_SMMU_CFG, 8, -1, 152, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_gpuss_cfg, SDM660_SLAVE_GPUSS_CFG, 8, -1, 11, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ahb2phy, SDM660_SLAVE_AHB2PHY, 4, -1, 163, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_blsp_1, SDM660_SLAVE_BLSP_1, 4, -1, 39, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_sdcc_1, SDM660_SLAVE_SDCC_1, 4, -1, 31, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_sdcc_2, SDM660_SLAVE_SDCC_2, 4, -1, 33, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_center, SDM660_SLAVE_TLMM_CENTER, 4, -1, 218, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_blsp_2, SDM660_SLAVE_BLSP_2, 4, -1, 37, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pdm, SDM660_SLAVE_PDM, 4, -1, 41, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cnoc_mnoc_mmss_cfg, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, 8, -1, 58, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_MMSS_CFG);
-DEFINE_QNODE(slv_usb_hs, SDM660_SLAVE_USB_HS, 4, -1, 40, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_usb3_0, SDM660_SLAVE_USB3_0, 4, -1, 22, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_srvc_cnoc, SDM660_SLAVE_SRVC_CNOC, 4, -1, 76, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_gnoc_bimc, SDM660_SLAVE_GNOC_BIMC, 16, -1, 210, true, -1, 0, -1, SDM660_MASTER_GNOC_BIMC);
-DEFINE_QNODE(slv_gnoc_snoc, SDM660_SLAVE_GNOC_SNOC, 8, -1, 211, true, -1, 0, -1, SDM660_MASTER_GNOC_SNOC);
-DEFINE_QNODE(slv_camera_cfg, SDM660_SLAVE_CAMERA_CFG, 4, -1, 3, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_camera_throttle_cfg, SDM660_SLAVE_CAMERA_THROTTLE_CFG, 4, -1, 154, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_misc_cfg, SDM660_SLAVE_MISC_CFG, 4, -1, 8, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_venus_throttle_cfg, SDM660_SLAVE_VENUS_THROTTLE_CFG, 4, -1, 178, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_venus_cfg, SDM660_SLAVE_VENUS_CFG, 4, -1, 10, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mmss_clk_xpu_cfg, SDM660_SLAVE_MMSS_CLK_XPU_CFG, 4, -1, 13, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mmss_clk_cfg, SDM660_SLAVE_MMSS_CLK_CFG, 4, -1, 12, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mnoc_mpu_cfg, SDM660_SLAVE_MNOC_MPU_CFG, 4, -1, 14, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_display_cfg, SDM660_SLAVE_DISPLAY_CFG, 4, -1, 4, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_csi_phy_cfg, SDM660_SLAVE_CSI_PHY_CFG, 4, -1, 224, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_display_throttle_cfg, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, 4, -1, 156, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_smmu_cfg, SDM660_SLAVE_SMMU_CFG, 8, -1, 205, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mnoc_bimc, SDM660_SLAVE_MNOC_BIMC, 16, -1, 16, true, -1, 0, -1, SDM660_MASTER_MNOC_BIMC);
-DEFINE_QNODE(slv_srvc_mnoc, SDM660_SLAVE_SRVC_MNOC, 8, -1, 17, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_hmss, SDM660_SLAVE_HMSS, 8, -1, 20, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_lpass, SDM660_SLAVE_LPASS, 4, -1, 21, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_wlan, SDM660_SLAVE_WLAN, 4, -1, 206, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cdsp, SDM660_SLAVE_CDSP, 4, -1, 221, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ipa, SDM660_SLAVE_IPA, 4, -1, 183, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_snoc_bimc, SDM660_SLAVE_SNOC_BIMC, 16, -1, 24, false, -1, 0, -1, SDM660_MASTER_SNOC_BIMC);
-DEFINE_QNODE(slv_snoc_cnoc, SDM660_SLAVE_SNOC_CNOC, 8, -1, 25, false, -1, 0, -1, SDM660_MASTER_SNOC_CNOC);
-DEFINE_QNODE(slv_imem, SDM660_SLAVE_IMEM, 8, -1, 26, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pimem, SDM660_SLAVE_PIMEM, 8, -1, 166, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qdss_stm, SDM660_SLAVE_QDSS_STM, 4, -1, 30, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_srvc_snoc, SDM660_SLAVE_SRVC_SNOC, 16, -1, 29, false, -1, 0, -1, 0);
+static struct qcom_icc_node slv_venus_throttle_cfg = {
+	.name = "slv_venus_throttle_cfg",
+	.id = SDM660_SLAVE_VENUS_THROTTLE_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 178,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_venus_cfg = {
+	.name = "slv_venus_cfg",
+	.id = SDM660_SLAVE_VENUS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 10,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
+	.name = "slv_mmss_clk_xpu_cfg",
+	.id = SDM660_SLAVE_MMSS_CLK_XPU_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 13,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_mmss_clk_cfg = {
+	.name = "slv_mmss_clk_cfg",
+	.id = SDM660_SLAVE_MMSS_CLK_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 12,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_mnoc_mpu_cfg = {
+	.name = "slv_mnoc_mpu_cfg",
+	.id = SDM660_SLAVE_MNOC_MPU_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 14,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_display_cfg = {
+	.name = "slv_display_cfg",
+	.id = SDM660_SLAVE_DISPLAY_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_csi_phy_cfg = {
+	.name = "slv_csi_phy_cfg",
+	.id = SDM660_SLAVE_CSI_PHY_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 224,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_display_throttle_cfg = {
+	.name = "slv_display_throttle_cfg",
+	.id = SDM660_SLAVE_DISPLAY_THROTTLE_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 156,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_smmu_cfg = {
+	.name = "slv_smmu_cfg",
+	.id = SDM660_SLAVE_SMMU_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 205,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_mnoc_bimc_links[] = {
+	SDM660_MASTER_MNOC_BIMC
+};
+
+static struct qcom_icc_node slv_mnoc_bimc = {
+	.name = "slv_mnoc_bimc",
+	.id = SDM660_SLAVE_MNOC_BIMC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_mnoc_bimc_links),
+	.links = slv_mnoc_bimc_links,
+};
+
+static struct qcom_icc_node slv_srvc_mnoc = {
+	.name = "slv_srvc_mnoc",
+	.id = SDM660_SLAVE_SRVC_MNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 17,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_hmss = {
+	.name = "slv_hmss",
+	.id = SDM660_SLAVE_HMSS,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 20,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_lpass = {
+	.name = "slv_lpass",
+	.id = SDM660_SLAVE_LPASS,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 21,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_wlan = {
+	.name = "slv_wlan",
+	.id = SDM660_SLAVE_WLAN,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 206,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_cdsp = {
+	.name = "slv_cdsp",
+	.id = SDM660_SLAVE_CDSP,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 221,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_ipa = {
+	.name = "slv_ipa",
+	.id = SDM660_SLAVE_IPA,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 183,
+	.qos.ap_owned = true,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_snoc_bimc_links[] = {
+	SDM660_MASTER_SNOC_BIMC
+};
+
+static struct qcom_icc_node slv_snoc_bimc = {
+	.name = "slv_snoc_bimc",
+	.id = SDM660_SLAVE_SNOC_BIMC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 24,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_links),
+	.links = slv_snoc_bimc_links,
+};
+
+static const u16 slv_snoc_cnoc_links[] = {
+	SDM660_MASTER_SNOC_CNOC
+};
+
+static struct qcom_icc_node slv_snoc_cnoc = {
+	.name = "slv_snoc_cnoc",
+	.id = SDM660_SLAVE_SNOC_CNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 25,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_snoc_cnoc_links),
+	.links = slv_snoc_cnoc_links,
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slv_imem",
+	.id = SDM660_SLAVE_IMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pimem = {
+	.name = "slv_pimem",
+	.id = SDM660_SLAVE_PIMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 166,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slv_qdss_stm",
+	.id = SDM660_SLAVE_QDSS_STM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_srvc_snoc = {
+	.name = "slv_srvc_snoc",
+	.id = SDM660_SLAVE_SRVC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 29,
+	.qos.ap_owned = false,
+	.qos.qos_mode = -1,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = -1,
+};
 
 static struct qcom_icc_node *sdm660_a2noc_nodes[] = {
 	[MASTER_IPA] = &mas_ipa,
-- 
2.33.0

