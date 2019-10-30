Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68DE9F3D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJ3PjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:39:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43286 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfJ3PjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:39:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1so2819595wra.10
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6B8z8FZSuakJRvDyyuoSvenJy3Pl3QdEtS9LwPo4pp8=;
        b=l1M/YY436G3MBpFxUpK7Rti7Jr2p9qdxbiBkOgByrUsPDtvS4413vVHHAEt6EkRu0g
         MhH9OttgD22TcnrsO7moamisDETrlnAAVBhFTqTMB3y5Nb7FLlkhpujRdMENyKzhyAJ3
         ykoXmEHt86B8t+iqaHr3CTcE/d4E6VlNnRxFsdwkQ9DdqdLi5Ut8Fm3QaiBeZ1u56HTn
         Pqd62qn/R+sKU0FxlL4DzGN0rvsOET6CP4LD275zLA5bPVbiZBtU4xmvHtn7y1zwaoFZ
         Askjrpish/4/jRC8YtoQqr18yb+COfAoYZ89h0bn9F9GF6IoVSdRxdXMnEKbsXscDXRg
         iPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6B8z8FZSuakJRvDyyuoSvenJy3Pl3QdEtS9LwPo4pp8=;
        b=BIiBUzOYHqkCZHahwvCMbfmizVWqtokZuKIK3dokuMdueTibSrrmmwvDvOcBIyqG13
         pAhrZPV9BLm9P0MRPDCOnH1suN8ZRKZn+1+w1+BiEBXn1euYUyYjEnSA9x2kGvODedbN
         hKehpkt0DoaMnsDoM6hgRUKA8rty9pqXGd1xvK38/KD4qHzDk7WHTeZjPMKgFGsjgvQ2
         HUWrmGGZJt/9kOd++9QbzGb9qLco9zptuGEMa356CMJfMmJYNQeK5RgXTq1rsSn2bXCg
         TH/xsTQylHv1S45qFxbuZYKwLjyBjrh05m7DQMzvn+EO1NeszAw1CG/svFIfyUPn7g13
         kI6A==
X-Gm-Message-State: APjAAAWT79MR0iWKP6mKuGY54Jyxi/pjAMyA1ORaIC/1mkFhMU90AW0f
        N7ydehwl5N6Y9R/cOg98hduO/A==
X-Google-Smtp-Source: APXvYqw1lnZmmlJ5zvi3An7Ev+pRtDTsLeuLnwhtWgb7PfOYQm457K3GhctAeMkYvmDCppBHcyfcpA==
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr492316wru.224.1572449948191;
        Wed, 30 Oct 2019 08:39:08 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o25sm725524wro.21.2019.10.30.08.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 08:39:07 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 2/3] interconnect: qcom: Add MSM8916 interconnect provider driver
Date:   Wed, 30 Oct 2019 17:39:03 +0200
Message-Id: <20191030153904.8715-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030153904.8715-1-georgi.djakov@linaro.org>
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in MSM8916 based
platforms. The topology consists of three NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/Kconfig   |   9 +
 drivers/interconnect/qcom/Makefile  |   2 +
 drivers/interconnect/qcom/msm8916.c | 572 ++++++++++++++++++++++++++++
 3 files changed, 583 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8916.c

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index ecf057d7e240..aa395733613e 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -5,6 +5,15 @@ config INTERCONNECT_QCOM
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
+config INTERCONNECT_QCOM_MSM8916
+	tristate "Qualcomm MSM8916 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
+	  platforms.
+
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 9adf9e380545..e8271575e3d8 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
+qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8974-objs			:= msm8974.o
 qnoc-qcs404-objs			:= qcs404.o
 qnoc-sdm845-objs			:= sdm845.o
 icc-smd-rpm-objs			:= smd-rpm.o
 
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
new file mode 100644
index 000000000000..752012c87e63
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <dt-bindings/interconnect/qcom,msm8916.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "smd-rpm.h"
+
+#define RPM_BUS_MASTER_REQ      0x73616d62
+#define RPM_BUS_SLAVE_REQ       0x766c7362
+
+enum {
+	MSM8916_BIMC_SNOC_MAS = 1,
+	MSM8916_BIMC_SNOC_SLV,
+	MSM8916_MASTER_AMPSS_M0,
+	MSM8916_MASTER_LPASS,
+	MSM8916_MASTER_BLSP_1,
+	MSM8916_MASTER_DEHR,
+	MSM8916_MASTER_GRAPHICS_3D,
+	MSM8916_MASTER_JPEG,
+	MSM8916_MASTER_MDP_PORT0,
+	MSM8916_MASTER_CRYPTO_CORE0,
+	MSM8916_MASTER_SDCC_1,
+	MSM8916_MASTER_SDCC_2,
+	MSM8916_MASTER_QDSS_BAM,
+	MSM8916_MASTER_QDSS_ETR,
+	MSM8916_MASTER_SNOC_CFG,
+	MSM8916_MASTER_SPDM,
+	MSM8916_MASTER_TCU0,
+	MSM8916_MASTER_TCU1,
+	MSM8916_MASTER_USB_HS,
+	MSM8916_MASTER_VFE,
+	MSM8916_MASTER_VIDEO_P0,
+	MSM8916_SNOC_MM_INT_0,
+	MSM8916_SNOC_MM_INT_1,
+	MSM8916_SNOC_MM_INT_2,
+	MSM8916_SNOC_MM_INT_BIMC,
+	MSM8916_PNOC_INT_0,
+	MSM8916_PNOC_INT_1,
+	MSM8916_PNOC_MAS_0,
+	MSM8916_PNOC_MAS_1,
+	MSM8916_PNOC_SLV_0,
+	MSM8916_PNOC_SLV_1,
+	MSM8916_PNOC_SLV_2,
+	MSM8916_PNOC_SLV_3,
+	MSM8916_PNOC_SLV_4,
+	MSM8916_PNOC_SLV_8,
+	MSM8916_PNOC_SLV_9,
+	MSM8916_PNOC_SNOC_MAS,
+	MSM8916_PNOC_SNOC_SLV,
+	MSM8916_SNOC_QDSS_INT,
+	MSM8916_SLAVE_AMPSS_L2,
+	MSM8916_SLAVE_APSS,
+	MSM8916_SLAVE_LPASS,
+	MSM8916_SLAVE_BIMC_CFG,
+	MSM8916_SLAVE_BLSP_1,
+	MSM8916_SLAVE_BOOT_ROM,
+	MSM8916_SLAVE_CAMERA_CFG,
+	MSM8916_SLAVE_CATS_128,
+	MSM8916_SLAVE_OCMEM_64,
+	MSM8916_SLAVE_CLK_CTL,
+	MSM8916_SLAVE_CRYPTO_0_CFG,
+	MSM8916_SLAVE_DEHR_CFG,
+	MSM8916_SLAVE_DISPLAY_CFG,
+	MSM8916_SLAVE_EBI_CH0,
+	MSM8916_SLAVE_GRAPHICS_3D_CFG,
+	MSM8916_SLAVE_IMEM_CFG,
+	MSM8916_SLAVE_IMEM,
+	MSM8916_SLAVE_MPM,
+	MSM8916_SLAVE_MSG_RAM,
+	MSM8916_SLAVE_MSS,
+	MSM8916_SLAVE_PDM,
+	MSM8916_SLAVE_PMIC_ARB,
+	MSM8916_SLAVE_PNOC_CFG,
+	MSM8916_SLAVE_PRNG,
+	MSM8916_SLAVE_QDSS_CFG,
+	MSM8916_SLAVE_QDSS_STM,
+	MSM8916_SLAVE_RBCPR_CFG,
+	MSM8916_SLAVE_SDCC_1,
+	MSM8916_SLAVE_SDCC_2,
+	MSM8916_SLAVE_SECURITY,
+	MSM8916_SLAVE_SNOC_CFG,
+	MSM8916_SLAVE_SPDM,
+	MSM8916_SLAVE_SRVC_SNOC,
+	MSM8916_SLAVE_TCSR,
+	MSM8916_SLAVE_TLMM,
+	MSM8916_SLAVE_USB_HS,
+	MSM8916_SLAVE_VENUS_CFG,
+	MSM8916_SNOC_BIMC_0_MAS,
+	MSM8916_SNOC_BIMC_0_SLV,
+	MSM8916_SNOC_BIMC_1_MAS,
+	MSM8916_SNOC_BIMC_1_SLV,
+	MSM8916_SNOC_INT_0,
+	MSM8916_SNOC_INT_1,
+	MSM8916_SNOC_INT_BIMC,
+	MSM8916_SNOC_PNOC_MAS,
+	MSM8916_SNOC_PNOC_SLV,
+};
+
+#define to_qcom_provider(_provider) \
+	container_of(_provider, struct qcom_icc_provider, provider)
+
+static const struct clk_bulk_data bus_clocks[] = {
+	{ .id = "bus" },
+	{ .id = "bus_a" },
+};
+
+/**
+ * struct qcom_icc_provider - Qualcomm specific interconnect provider
+ * @provider: generic interconnect provider
+ * @bus_clks: the clk_bulk_data table of bus clocks
+ * @num_clks: the total number of clk_bulk_data entries
+ */
+struct qcom_icc_provider {
+	struct icc_provider provider;
+	struct clk_bulk_data *bus_clks;
+	int num_clks;
+};
+
+#define MSM8916_MAX_LINKS	8
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @mas_rpm_id:	RPM id for devices that are bus masters
+ * @slv_rpm_id:	RPM id for devices that are bus slaves
+ * @rate: current bus clock rate in Hz
+ */
+struct qcom_icc_node {
+	unsigned char *name;
+	u16 id;
+	u16 links[MSM8916_MAX_LINKS];
+	u16 num_links;
+	u16 buswidth;
+	int mas_rpm_id;
+	int slv_rpm_id;
+	u64 rate;
+};
+
+struct qcom_icc_desc {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
+					...)				\
+		static struct qcom_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.buswidth = _buswidth,					\
+		.mas_rpm_id = _mas_rpm_id,				\
+		.slv_rpm_id = _slv_rpm_id,				\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+	}
+
+DEFINE_QNODE(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, MSM8916_BIMC_SNOC_SLV);
+DEFINE_QNODE(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
+DEFINE_QNODE(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE(mas_audio, MSM8916_MASTER_LPASS, 4, -1, -1, MSM8916_PNOC_MAS_0);
+DEFINE_QNODE(mas_blsp_1, MSM8916_MASTER_BLSP_1, 4, -1, -1, MSM8916_PNOC_MAS_1);
+DEFINE_QNODE(mas_dehr, MSM8916_MASTER_DEHR, 4, -1, -1, MSM8916_PNOC_MAS_0);
+DEFINE_QNODE(mas_gfx, MSM8916_MASTER_GRAPHICS_3D, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE(mas_jpeg, MSM8916_MASTER_JPEG, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE(mas_mdp, MSM8916_MASTER_MDP_PORT0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE(mas_pcnoc_crypto_0, MSM8916_MASTER_CRYPTO_CORE0, 8, -1, -1, MSM8916_PNOC_INT_1);
+DEFINE_QNODE(mas_pcnoc_sdcc_1, MSM8916_MASTER_SDCC_1, 8, -1, -1, MSM8916_PNOC_INT_1);
+DEFINE_QNODE(mas_pcnoc_sdcc_2, MSM8916_MASTER_SDCC_2, 8, -1, -1, MSM8916_PNOC_INT_1);
+DEFINE_QNODE(mas_qdss_bam, MSM8916_MASTER_QDSS_BAM, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
+DEFINE_QNODE(mas_qdss_etr, MSM8916_MASTER_QDSS_ETR, 8, -1, -1, MSM8916_SNOC_QDSS_INT);
+DEFINE_QNODE(mas_snoc_cfg, MSM8916_MASTER_SNOC_CFG, 4, 20, -1, MSM8916_SNOC_QDSS_INT);
+DEFINE_QNODE(mas_spdm, MSM8916_MASTER_SPDM, 4, -1, -1, MSM8916_PNOC_MAS_0);
+DEFINE_QNODE(mas_tcu0, MSM8916_MASTER_TCU0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE(mas_tcu1, MSM8916_MASTER_TCU1, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
+DEFINE_QNODE(mas_usb_hs, MSM8916_MASTER_USB_HS, 4, -1, -1, MSM8916_PNOC_MAS_1);
+DEFINE_QNODE(mas_vfe, MSM8916_MASTER_VFE, 16, -1, -1, MSM8916_SNOC_MM_INT_1, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE(mas_video, MSM8916_MASTER_VIDEO_P0, 16, -1, -1, MSM8916_SNOC_MM_INT_0, MSM8916_SNOC_MM_INT_2);
+DEFINE_QNODE(mm_int_0, MSM8916_SNOC_MM_INT_0, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
+DEFINE_QNODE(mm_int_1, MSM8916_SNOC_MM_INT_1, 16, -1, -1, MSM8916_SNOC_MM_INT_BIMC);
+DEFINE_QNODE(mm_int_2, MSM8916_SNOC_MM_INT_2, 16, -1, -1, MSM8916_SNOC_INT_0);
+DEFINE_QNODE(mm_int_bimc, MSM8916_SNOC_MM_INT_BIMC, 16, -1, -1, MSM8916_SNOC_BIMC_1_MAS);
+DEFINE_QNODE(pcnoc_int_0, MSM8916_PNOC_INT_0, 8, -1, -1, MSM8916_PNOC_SNOC_MAS, MSM8916_PNOC_SLV_0, MSM8916_PNOC_SLV_1, MSM8916_PNOC_SLV_2, MSM8916_PNOC_SLV_3, MSM8916_PNOC_SLV_4, MSM8916_PNOC_SLV_8, MSM8916_PNOC_SLV_9);
+DEFINE_QNODE(pcnoc_int_1, MSM8916_PNOC_INT_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
+DEFINE_QNODE(pcnoc_m_0, MSM8916_PNOC_MAS_0, 8, -1, -1, MSM8916_PNOC_INT_0);
+DEFINE_QNODE(pcnoc_m_1, MSM8916_PNOC_MAS_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
+DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 8, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
+DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 8, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
+DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 8, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
+DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 8, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
+DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 8, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
+DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 8, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
+DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 8, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
+DEFINE_QNODE(pcnoc_snoc_mas, MSM8916_PNOC_SNOC_MAS, 8, 29, -1, MSM8916_PNOC_SNOC_SLV);
+DEFINE_QNODE(pcnoc_snoc_slv, MSM8916_PNOC_SNOC_SLV, 8, -1, 45, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC, MSM8916_SNOC_INT_1);
+DEFINE_QNODE(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
+DEFINE_QNODE(slv_apps_l2, MSM8916_SLAVE_AMPSS_L2, 8, -1, -1, 0);
+DEFINE_QNODE(slv_apss, MSM8916_SLAVE_APSS, 4, -1, 20, 0);
+DEFINE_QNODE(slv_audio, MSM8916_SLAVE_LPASS, 4, -1, -1, 0);
+DEFINE_QNODE(slv_bimc_cfg, MSM8916_SLAVE_BIMC_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_blsp_1, MSM8916_SLAVE_BLSP_1, 4, -1, -1, 0);
+DEFINE_QNODE(slv_boot_rom, MSM8916_SLAVE_BOOT_ROM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_camera_cfg, MSM8916_SLAVE_CAMERA_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_cats_0, MSM8916_SLAVE_CATS_128, 16, -1, 106, 0);
+DEFINE_QNODE(slv_cats_1, MSM8916_SLAVE_OCMEM_64, 8, -1, 107, 0);
+DEFINE_QNODE(slv_clk_ctl, MSM8916_SLAVE_CLK_CTL, 4, -1, -1, 0);
+DEFINE_QNODE(slv_crypto_0_cfg, MSM8916_SLAVE_CRYPTO_0_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_dehr_cfg, MSM8916_SLAVE_DEHR_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_display_cfg, MSM8916_SLAVE_DISPLAY_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_ebi_ch0, MSM8916_SLAVE_EBI_CH0, 8, -1, 0, 0);
+DEFINE_QNODE(slv_gfx_cfg, MSM8916_SLAVE_GRAPHICS_3D_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_imem_cfg, MSM8916_SLAVE_IMEM_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_imem, MSM8916_SLAVE_IMEM, 8, -1, 26, 0);
+DEFINE_QNODE(slv_mpm, MSM8916_SLAVE_MPM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_msg_ram, MSM8916_SLAVE_MSG_RAM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_mss, MSM8916_SLAVE_MSS, 4, -1, -1, 0);
+DEFINE_QNODE(slv_pdm, MSM8916_SLAVE_PDM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_pmic_arb, MSM8916_SLAVE_PMIC_ARB, 4, -1, -1, 0);
+DEFINE_QNODE(slv_pcnoc_cfg, MSM8916_SLAVE_PNOC_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_prng, MSM8916_SLAVE_PRNG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_qdss_cfg, MSM8916_SLAVE_QDSS_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_qdss_stm, MSM8916_SLAVE_QDSS_STM, 4, -1, 30, 0);
+DEFINE_QNODE(slv_rbcpr_cfg, MSM8916_SLAVE_RBCPR_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_sdcc_1, MSM8916_SLAVE_SDCC_1, 4, -1, -1, 0);
+DEFINE_QNODE(slv_sdcc_2, MSM8916_SLAVE_SDCC_2, 4, -1, -1, 0);
+DEFINE_QNODE(slv_security, MSM8916_SLAVE_SECURITY, 4, -1, -1, 0);
+DEFINE_QNODE(slv_snoc_cfg, MSM8916_SLAVE_SNOC_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(slv_spdm, MSM8916_SLAVE_SPDM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_srvc_snoc, MSM8916_SLAVE_SRVC_SNOC, 8, -1, 29, 0);
+DEFINE_QNODE(slv_tcsr, MSM8916_SLAVE_TCSR, 4, -1, -1, 0);
+DEFINE_QNODE(slv_tlmm, MSM8916_SLAVE_TLMM, 4, -1, -1, 0);
+DEFINE_QNODE(slv_usb_hs, MSM8916_SLAVE_USB_HS, 4, -1, -1, 0);
+DEFINE_QNODE(slv_venus_cfg, MSM8916_SLAVE_VENUS_CFG, 4, -1, -1, 0);
+DEFINE_QNODE(snoc_bimc_0_mas, MSM8916_SNOC_BIMC_0_MAS, 8, 3, -1, MSM8916_SNOC_BIMC_0_SLV);
+DEFINE_QNODE(snoc_bimc_0_slv, MSM8916_SNOC_BIMC_0_SLV, 8, -1, 24, MSM8916_SLAVE_EBI_CH0);
+DEFINE_QNODE(snoc_bimc_1_mas, MSM8916_SNOC_BIMC_1_MAS, 16, -1, -1, MSM8916_SNOC_BIMC_1_SLV);
+DEFINE_QNODE(snoc_bimc_1_slv, MSM8916_SNOC_BIMC_1_SLV, 8, -1, -1, MSM8916_SLAVE_EBI_CH0);
+DEFINE_QNODE(snoc_int_0, MSM8916_SNOC_INT_0, 8, 99, 130, MSM8916_SLAVE_QDSS_STM, MSM8916_SLAVE_IMEM, MSM8916_SNOC_PNOC_MAS);
+DEFINE_QNODE(snoc_int_1, MSM8916_SNOC_INT_1, 8, 100, 131, MSM8916_SLAVE_APSS, MSM8916_SLAVE_CATS_128, MSM8916_SLAVE_OCMEM_64);
+DEFINE_QNODE(snoc_int_bimc, MSM8916_SNOC_INT_BIMC, 8, 101, 132, MSM8916_SNOC_BIMC_0_MAS);
+DEFINE_QNODE(snoc_pcnoc_mas, MSM8916_SNOC_PNOC_MAS, 8, -1, -1, MSM8916_SNOC_PNOC_SLV);
+DEFINE_QNODE(snoc_pcnoc_slv, MSM8916_SNOC_PNOC_SLV, 8, -1, -1, MSM8916_PNOC_INT_0);
+
+static struct qcom_icc_node *msm8916_snoc_nodes[] = {
+	[BIMC_SNOC_SLV] = &bimc_snoc_slv,
+	[MASTER_JPEG] = &mas_jpeg,
+	[MASTER_MDP_PORT0] = &mas_mdp,
+	[MASTER_QDSS_BAM] = &mas_qdss_bam,
+	[MASTER_QDSS_ETR] = &mas_qdss_etr,
+	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
+	[MASTER_VFE] = &mas_vfe,
+	[MASTER_VIDEO_P0] = &mas_video,
+	[SNOC_MM_INT_0] = &mm_int_0,
+	[SNOC_MM_INT_1] = &mm_int_1,
+	[SNOC_MM_INT_2] = &mm_int_2,
+	[SNOC_MM_INT_BIMC] = &mm_int_bimc,
+	[PCNOC_SNOC_SLV] = &pcnoc_snoc_slv,
+	[SLAVE_APSS] = &slv_apss,
+	[SLAVE_CATS_128] = &slv_cats_0,
+	[SLAVE_OCMEM_64] = &slv_cats_1,
+	[SLAVE_IMEM] = &slv_imem,
+	[SLAVE_QDSS_STM] = &slv_qdss_stm,
+	[SLAVE_SRVC_SNOC] = &slv_srvc_snoc,
+	[SNOC_BIMC_0_MAS] = &snoc_bimc_0_mas,
+	[SNOC_BIMC_1_MAS] = &snoc_bimc_1_mas,
+	[SNOC_INT_0] = &snoc_int_0,
+	[SNOC_INT_1] = &snoc_int_1,
+	[SNOC_INT_BIMC] = &snoc_int_bimc,
+	[SNOC_PCNOC_MAS] = &snoc_pcnoc_mas,
+	[SNOC_QDSS_INT] = &qdss_int,
+};
+
+static struct qcom_icc_desc msm8916_snoc = {
+	.nodes = msm8916_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+};
+
+static struct qcom_icc_node *msm8916_bimc_nodes[] = {
+	[BIMC_SNOC_MAS] = &bimc_snoc_mas,
+	[MASTER_AMPSS_M0] = &mas_apss,
+	[MASTER_GRAPHICS_3D] = &mas_gfx,
+	[MASTER_TCU0] = &mas_tcu0,
+	[MASTER_TCU1] = &mas_tcu1,
+	[SLAVE_AMPSS_L2] = &slv_apps_l2,
+	[SLAVE_EBI_CH0] = &slv_ebi_ch0,
+	[SNOC_BIMC_0_SLV] = &snoc_bimc_0_slv,
+	[SNOC_BIMC_1_SLV] = &snoc_bimc_1_slv,
+};
+
+static struct qcom_icc_desc msm8916_bimc = {
+	.nodes = msm8916_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+};
+
+static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
+	[MASTER_BLSP_1] = &mas_blsp_1,
+	[MASTER_DEHR] = &mas_dehr,
+	[MASTER_LPASS] = &mas_audio,
+	[MASTER_CRYPTO_CORE0] = &mas_pcnoc_crypto_0,
+	[MASTER_SDCC_1] = &mas_pcnoc_sdcc_1,
+	[MASTER_SDCC_2] = &mas_pcnoc_sdcc_2,
+	[MASTER_SPDM] = &mas_spdm,
+	[MASTER_USB_HS] = &mas_usb_hs,
+	[PCNOC_INT_0] = &pcnoc_int_0,
+	[PCNOC_INT_1] = &pcnoc_int_1,
+	[PCNOC_MAS_0] = &pcnoc_m_0,
+	[PCNOC_MAS_1] = &pcnoc_m_1,
+	[PCNOC_SLV_0] = &pcnoc_s_0,
+	[PCNOC_SLV_1] = &pcnoc_s_1,
+	[PCNOC_SLV_2] = &pcnoc_s_2,
+	[PCNOC_SLV_3] = &pcnoc_s_3,
+	[PCNOC_SLV_4] = &pcnoc_s_4,
+	[PCNOC_SLV_8] = &pcnoc_s_8,
+	[PCNOC_SLV_9] = &pcnoc_s_9,
+	[PCNOC_SNOC_MAS] = &pcnoc_snoc_mas,
+	[SLAVE_BIMC_CFG] = &slv_bimc_cfg,
+	[SLAVE_BLSP_1] = &slv_blsp_1,
+	[SLAVE_BOOT_ROM] = &slv_boot_rom,
+	[SLAVE_CAMERA_CFG] = &slv_camera_cfg,
+	[SLAVE_CLK_CTL] = &slv_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
+	[SLAVE_DEHR_CFG] = &slv_dehr_cfg,
+	[SLAVE_DISPLAY_CFG] = &slv_display_cfg,
+	[SLAVE_GRAPHICS_3D_CFG] = &slv_gfx_cfg,
+	[SLAVE_IMEM_CFG] = &slv_imem_cfg,
+	[SLAVE_LPASS] = &slv_audio,
+	[SLAVE_MPM] = &slv_mpm,
+	[SLAVE_MSG_RAM] = &slv_msg_ram,
+	[SLAVE_MSS] = &slv_mss,
+	[SLAVE_PDM] = &slv_pdm,
+	[SLAVE_PMIC_ARB] = &slv_pmic_arb,
+	[SLAVE_PCNOC_CFG] = &slv_pcnoc_cfg,
+	[SLAVE_PRNG] = &slv_prng,
+	[SLAVE_QDSS_CFG] = &slv_qdss_cfg,
+	[SLAVE_RBCPR_CFG] = &slv_rbcpr_cfg,
+	[SLAVE_SDCC_1] = &slv_sdcc_1,
+	[SLAVE_SDCC_2] = &slv_sdcc_2,
+	[SLAVE_SECURITY] = &slv_security,
+	[SLAVE_SNOC_CFG] = &slv_snoc_cfg,
+	[SLAVE_SPDM] = &slv_spdm,
+	[SLAVE_TCSR] = &slv_tcsr,
+	[SLAVE_TLMM] = &slv_tlmm,
+	[SLAVE_USB_HS] = &slv_usb_hs,
+	[SLAVE_VENUS_CFG] = &slv_venus_cfg,
+	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
+};
+
+static struct qcom_icc_desc msm8916_pcnoc = {
+	.nodes = msm8916_pcnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+};
+
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	struct icc_provider *provider;
+	struct icc_node *n;
+	u64 sum_bw;
+	u64 max_peak_bw;
+	u64 rate;
+	u32 agg_avg = 0;
+	u32 agg_peak = 0;
+	int ret, i;
+
+	qn = src->data;
+	provider = src->provider;
+	qp = to_qcom_provider(provider);
+
+	list_for_each_entry(n, &provider->nodes, node_list)
+		qcom_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
+				   &agg_avg, &agg_peak);
+
+	sum_bw = icc_units_to_bps(agg_avg);
+	max_peak_bw = icc_units_to_bps(agg_peak);
+
+	/* send bandwidth request message to the RPM processor */
+	if (qn->mas_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_MASTER_REQ,
+					    qn->mas_rpm_id,
+					    sum_bw);
+		if (ret) {
+			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
+			       qn->mas_rpm_id, ret);
+			return ret;
+		}
+	}
+
+	if (qn->slv_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_SLAVE_REQ,
+					    qn->slv_rpm_id,
+					    sum_bw);
+		if (ret) {
+			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
+			       ret);
+			return ret;
+		}
+	}
+
+	rate = max(sum_bw, max_peak_bw);
+
+	do_div(rate, qn->buswidth);
+
+	if (qn->rate == rate)
+		return 0;
+
+	for (i = 0; i < qp->num_clks; i++) {
+		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
+		if (ret) {
+			pr_err("%s clk_set_rate error: %d\n",
+			       qp->bus_clks[i].id, ret);
+			return ret;
+		}
+	}
+
+	qn->rate = rate;
+
+	return 0;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+	struct icc_provider *provider = &qp->provider;
+	struct icc_node *n;
+
+	list_for_each_entry(n, &provider->nodes, node_list) {
+		icc_node_del(n);
+		icc_node_destroy(n->id);
+	}
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+
+	return icc_provider_del(provider);
+}
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct qcom_icc_desc *desc;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node **qnodes;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i;
+	int ret;
+
+	/* wait for the RPM proxy */
+	if (!qcom_icc_rpm_smd_available())
+		return -EPROBE_DEFER;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
+				    GFP_KERNEL);
+	if (!qp->bus_clks)
+		return -ENOMEM;
+
+	qp->num_clks = ARRAY_SIZE(bus_clocks);
+	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	provider = &qp->provider;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->dev = dev;
+	provider->set = qcom_icc_set;
+	provider->aggregate = qcom_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	provider->data = data;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
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
+		dev_dbg(dev, "registered node %s\n", node->name);
+
+		/* populate links */
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
+	qnoc_remove(pdev);
+
+	return ret;
+}
+
+static const struct of_device_id msm8916_noc_of_match[] = {
+	{ .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
+	{ .compatible = "qcom,msm8916-pcnoc", .data = &msm8916_pcnoc },
+	{ .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, msm8916_noc_of_match);
+
+static struct platform_driver msm8916_noc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-msm8916",
+		.of_match_table = msm8916_noc_of_match,
+	},
+};
+module_platform_driver(msm8916_noc_driver);
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm MSM8916 NoC driver");
+MODULE_LICENSE("GPL v2");
