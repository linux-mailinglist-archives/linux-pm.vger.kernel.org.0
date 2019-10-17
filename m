Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F3DA39A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405786AbfJQCVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:21:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394411AbfJQCVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:21:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFD8D60953; Thu, 17 Oct 2019 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278871;
        bh=mjtL8Xl4myOor8vU4ozb+K8DHEniNWCHlBPhFU1Kl9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwpS9byMa43tFCItWEn7kxnhFqd8lHE/f4Nap9wWNrNs9G6WbdNgB86XuW4EODwI6
         1z9AFmKzVW305wqJkNFNpUR3UVnlzb+HWn1NFB/cJ0DcPEYPPjtIliXH2fAsOzcxO5
         xUg3K/cHAeMXM0IW1xUiBsb56I7piuTigGDA+EXM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C532B60931;
        Thu, 17 Oct 2019 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278869;
        bh=mjtL8Xl4myOor8vU4ozb+K8DHEniNWCHlBPhFU1Kl9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VT1FyE4TXRJ9uWEEjnwJQ7HxH5ALVqbcRFaeiJ9NTrQfZqJP3wJw8m0uVJY1R7+H0
         m/OTG49Uwfmp0mO5fHOr+gXVpzFQ7Vham8nspd3OgNro8cRfq83cfbVDIYpOzffJjj
         mwDmolZPXeZbssY7DE0ANKzTIrVsHY4AAlfNxsA0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C532B60931
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 4/4] interconnect: qcom: sdm845: Split qnodes into their respective NoCs
Date:   Wed, 16 Oct 2019 19:20:52 -0700
Message-Id: <1571278852-8023-5-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to better represent the hardware and its different Network-On-Chip
devices, split the sdm845 provider driver into NoC specific providers.
Remove duplicate functionality already provided by the icc rpmh and
bcm voter drivers to calculate and commit bandwidth requests to hardware.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 drivers/interconnect/qcom/sdm845.c | 727 +++++++++++--------------------------
 1 file changed, 206 insertions(+), 521 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 502a6c2..a731f4d 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -16,133 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 
-#include <soc/qcom/cmd-db.h>
-#include <soc/qcom/rpmh.h>
-#include <soc/qcom/tcs.h>
-
-#define to_qcom_provider(_provider) \
-	container_of(_provider, struct qcom_icc_provider, provider)
-
-struct qcom_icc_provider {
-	struct icc_provider provider;
-	struct device *dev;
-	struct qcom_icc_bcm **bcms;
-	size_t num_bcms;
-};
-
-/**
- * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
- * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
- * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
- * @vcd: virtual clock domain that this bcm belongs to
- * @reserved: reserved field
- */
-struct bcm_db {
-	__le32 unit;
-	__le16 width;
-	u8 vcd;
-	u8 reserved;
-};
-
-#define SDM845_MAX_LINKS	43
-#define SDM845_MAX_BCMS		30
-#define SDM845_MAX_BCM_PER_NODE	2
-#define SDM845_MAX_VCD		10
-
-/*
- * The AMC bucket denotes constraints that are applied to hardware when
- * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
- * when the execution environment transitions between active and low power mode.
- */
-#define QCOM_ICC_BUCKET_AMC		0
-#define QCOM_ICC_BUCKET_WAKE		1
-#define QCOM_ICC_BUCKET_SLEEP		2
-#define QCOM_ICC_NUM_BUCKETS		3
-#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
-#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
-#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
-#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
-#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
-					 QCOM_ICC_TAG_SLEEP)
-
-/**
- * struct qcom_icc_node - Qualcomm specific interconnect nodes
- * @name: the node name used in debugfs
- * @links: an array of nodes where we can go next while traversing
- * @id: a unique node identifier
- * @num_links: the total number of @links
- * @channels: num of channels at this node
- * @buswidth: width of the interconnect between a node and the bus
- * @sum_avg: current sum aggregate value of all avg bw requests
- * @max_peak: current max aggregate value of all peak bw requests
- * @bcms: list of bcms associated with this logical node
- * @num_bcms: num of @bcms
- */
-struct qcom_icc_node {
-	const char *name;
-	u16 links[SDM845_MAX_LINKS];
-	u16 id;
-	u16 num_links;
-	u16 channels;
-	u16 buswidth;
-	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
-	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
-	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
-	size_t num_bcms;
-};
-
-/**
- * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
- * known as Bus Clock Manager (BCM)
- * @name: the bcm node name used to fetch BCM data from command db
- * @type: latency or bandwidth bcm
- * @addr: address offsets used when voting to RPMH
- * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
- * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
- * @dirty: flag used to indicate whether the bcm needs to be committed
- * @keepalive: flag used to indicate whether a keepalive is required
- * @aux_data: auxiliary data used when calculating threshold values and
- * communicating with RPMh
- * @list: used to link to other bcms when compiling lists for commit
- * @num_nodes: total number of @num_nodes
- * @nodes: list of qcom_icc_nodes that this BCM encapsulates
- */
-struct qcom_icc_bcm {
-	const char *name;
-	u32 type;
-	u32 addr;
-	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
-	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
-	bool dirty;
-	bool keepalive;
-	struct bcm_db aux_data;
-	struct list_head list;
-	size_t num_nodes;
-	struct qcom_icc_node *nodes[];
-};
-
-struct qcom_icc_fabric {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
-};
-
-struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
-	struct qcom_icc_bcm **bcms;
-	size_t num_bcms;
-};
-
-#define DEFINE_QNODE(_name, _id, _channels, _buswidth,			\
-			_numlinks, ...)					\
-		static struct qcom_icc_node _name = {			\
-		.id = _id,						\
-		.name = #_name,						\
-		.channels = _channels,					\
-		.buswidth = _buswidth,					\
-		.num_links = _numlinks,					\
-		.links = { __VA_ARGS__ },				\
-	}
+#include "icc-rpmh.h"
+#include "bcm-voter.h"
 
 DEFINE_QNODE(qhm_a1noc_cfg, MASTER_A1NOC_CFG, 1, 4, 1, SLAVE_SERVICE_A1NOC);
 DEFINE_QNODE(qhm_qup1, MASTER_BLSP_1, 1, 4, 1, SLAVE_A1NOC_SNOC);
@@ -275,14 +150,6 @@ struct qcom_icc_desc {
 DEFINE_QNODE(xs_qdss_stm, SLAVE_QDSS_STM, 1, 4, 0);
 DEFINE_QNODE(xs_sys_tcu_cfg, SLAVE_TCU, 1, 8, 0);
 
-#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)	\
-		static struct qcom_icc_bcm _name = {			\
-		.name = _bcmname,					\
-		.keepalive = _keepalive,				\
-		.num_nodes = _numnodes,					\
-		.nodes = { __VA_ARGS__ },				\
-	}
-
 DEFINE_QBCM(bcm_acv, "ACV", false, 1, &ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", true, 1, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, 1, &qns_llcc);
@@ -312,68 +179,70 @@ struct qcom_icc_desc {
 DEFINE_QBCM(bcm_sn14, "SN14", false, 1, &qnm_pcie_anoc);
 DEFINE_QBCM(bcm_sn15, "SN15", false, 1, &qnm_memnoc);
 
-static struct qcom_icc_node *rsc_hlos_nodes[] = {
-	[MASTER_APPSS_PROC] = &acm_l3,
-	[MASTER_TCU_0] = &acm_tcu,
-	[MASTER_LLCC] = &llcc_mc,
-	[MASTER_GNOC_CFG] = &pm_gnoc_cfg,
+static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
+	[MASTER_TSIF] = &qhm_tsif,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_CARD] = &xm_ufs_card,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_PCIE_0] = &xm_pcie_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
+	[SLAVE_ANOC_PCIE_A1NOC_SNOC] = &qns_pcie_a1noc_snoc,
+};
+
+static struct qcom_icc_desc sdm845_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_sn11,
+};
+
+static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
-	[MASTER_CNOC_DC_NOC] = &qhm_cnoc,
-	[MASTER_MEM_NOC_CFG] = &qhm_memnoc_cfg,
-	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
-	[MASTER_BLSP_1] = &qhm_qup1,
-	[MASTER_BLSP_2] = &qhm_qup2,
-	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
-	[MASTER_SPDM] = &qhm_spdm,
-	[MASTER_TIC] = &qhm_tic,
-	[MASTER_TSIF] = &qhm_tsif,
-	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
-	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
-	[MASTER_GNOC_MEM_NOC] = &qnm_apps,
 	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
-	[MASTER_GNOC_SNOC] = &qnm_gladiator_sodv,
-	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
-	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
-	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
-	[MASTER_ANOC_PCIE_SNOC] = &qnm_pcie_anoc,
-	[MASTER_SNOC_CNOC] = &qnm_snoc,
-	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
-	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
-	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
-	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
-	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
-	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
-	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
-	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
 	[MASTER_CRYPTO] = &qxm_crypto,
-	[MASTER_GFX3D] = &qxm_gpu,
 	[MASTER_IPA] = &qxm_ipa,
-	[MASTER_MDP0] = &qxm_mdp0,
-	[MASTER_MDP1] = &qxm_mdp1,
-	[MASTER_PIMEM] = &qxm_pimem,
-	[MASTER_ROTATOR] = &qxm_rot,
-	[MASTER_VIDEO_P0] = &qxm_venus0,
-	[MASTER_VIDEO_P1] = &qxm_venus1,
-	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
-	[MASTER_GIC] = &xm_gic,
 	[MASTER_PCIE_1] = &xm_pcie3_1,
-	[MASTER_PCIE_0] = &xm_pcie_0,
-	[MASTER_QDSS_DAP] = &xm_qdss_dap,
 	[MASTER_QDSS_ETR] = &xm_qdss_etr,
-	[MASTER_SDCC_2] = &xm_sdc2,
-	[MASTER_SDCC_4] = &xm_sdc4,
-	[MASTER_UFS_CARD] = &xm_ufs_card,
-	[MASTER_UFS_MEM] = &xm_ufs_mem,
 	[MASTER_USB3_0] = &xm_usb3_0,
 	[MASTER_USB3_1] = &xm_usb3_1,
-	[SLAVE_EBI1] = &ebi,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_SNOC] = &qns_pcie_snoc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static struct qcom_icc_desc sdm845_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] = {
+	[MASTER_SPDM] = &qhm_spdm,
+	[MASTER_TIC] = &qhm_tic,
+	[MASTER_SNOC_CNOC] = &qnm_snoc,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
 	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
 	[SLAVE_A2NOC_CFG] = &qhs_a2_noc_cfg,
 	[SLAVE_AOP] = &qhs_aop,
 	[SLAVE_AOSS] = &qhs_aoss,
-	[SLAVE_APPSS] = &qhs_apss,
 	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
 	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
 	[SLAVE_CDSP_CFG] = &qhs_compute_dsp_cfg,
@@ -386,9 +255,6 @@ struct qcom_icc_desc {
 	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
 	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
 	[SLAVE_IPA_CFG] = &qhs_ipa,
-	[SLAVE_LLCC_CFG] = &qhs_llcc,
-	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
-	[SLAVE_MEM_NOC_CFG] = &qhs_memnoc,
 	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
 	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
 	[SLAVE_PCIE_1_CFG] = &qhs_pcie_gen3_cfg,
@@ -414,53 +280,122 @@ struct qcom_icc_desc {
 	[SLAVE_USB3_1] = &qhs_usb3_1,
 	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
 	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
-	[SLAVE_MNOC_SF_MEM_NOC] = &qns2_mem_noc,
-	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
-	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
-	[SLAVE_MEM_NOC_GNOC] = &qns_apps_io,
-	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
-	[SLAVE_SNOC_CNOC] = &qns_cnoc,
 	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
+};
+
+static struct qcom_icc_desc sdm845_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm *dc_noc_bcms[] = {
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qhm_cnoc,
+	[SLAVE_LLCC_CFG] = &qhs_llcc,
+	[SLAVE_MEM_NOC_CFG] = &qhs_memnoc,
+};
+
+static struct qcom_icc_desc sdm845_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+	.bcms = dc_noc_bcms,
+	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm *gladiator_noc_bcms[] = {
+};
+
+static struct qcom_icc_node *gladiator_noc_nodes[] = {
+	[MASTER_APPSS_PROC] = &acm_l3,
+	[MASTER_GNOC_CFG] = &pm_gnoc_cfg,
 	[SLAVE_GNOC_SNOC] = &qns_gladiator_sodv,
 	[SLAVE_GNOC_MEM_NOC] = &qns_gnoc_memnoc,
-	[SLAVE_LLCC] = &qns_llcc,
-	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
-	[SLAVE_SNOC_MEM_NOC_GC] = &qns_memnoc_gc,
-	[SLAVE_SNOC_MEM_NOC_SF] = &qns_memnoc_sf,
-	[SLAVE_MEM_NOC_SNOC] = &qns_memnoc_snoc,
-	[SLAVE_ANOC_PCIE_A1NOC_SNOC] = &qns_pcie_a1noc_snoc,
-	[SLAVE_ANOC_PCIE_SNOC] = &qns_pcie_snoc,
-	[SLAVE_IMEM] = &qxs_imem,
-	[SLAVE_PCIE_0] = &qxs_pcie,
-	[SLAVE_PCIE_1] = &qxs_pcie_gen3,
-	[SLAVE_PIMEM] = &qxs_pimem,
-	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
-	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
-	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
 	[SLAVE_SERVICE_GNOC] = &srvc_gnoc,
-	[SLAVE_SERVICE_MEM_NOC] = &srvc_memnoc,
-	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
-	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
-	[SLAVE_QDSS_STM] = &xs_qdss_stm,
-	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_bcm *rsc_hlos_bcms[] = {
-	&bcm_acv,
+static struct qcom_icc_desc sdm845_gladiator_noc = {
+	.nodes = gladiator_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
+	.bcms = gladiator_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gladiator_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mem_noc_bcms[] = {
 	&bcm_mc0,
+	&bcm_acv,
 	&bcm_sh0,
-	&bcm_mm0,
 	&bcm_sh1,
-	&bcm_mm1,
 	&bcm_sh2,
-	&bcm_mm2,
 	&bcm_sh3,
-	&bcm_mm3,
 	&bcm_sh5,
+};
+
+static struct qcom_icc_node *mem_noc_nodes[] = {
+	[MASTER_TCU_0] = &acm_tcu,
+	[MASTER_MEM_NOC_CFG] = &qhm_memnoc_cfg,
+	[MASTER_GNOC_MEM_NOC] = &qnm_apps,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GFX3D] = &qxm_gpu,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_MEM_NOC_GNOC] = &qns_apps_io,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_SNOC] = &qns_memnoc_snoc,
+	[SLAVE_SERVICE_MEM_NOC] = &srvc_memnoc,
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static struct qcom_icc_desc sdm845_mem_noc = {
+	.nodes = mem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
+	.bcms = mem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] = {
+	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
+	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
+	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
+	[MASTER_MDP0] = &qxm_mdp0,
+	[MASTER_MDP1] = &qxm_mdp1,
+	[MASTER_ROTATOR] = &qxm_rot,
+	[MASTER_VIDEO_P0] = &qxm_venus0,
+	[MASTER_VIDEO_P1] = &qxm_venus1,
+	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns2_mem_noc,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
+	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
+};
+
+static struct qcom_icc_desc sdm845_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] = {
 	&bcm_sn0,
-	&bcm_ce0,
-	&bcm_cn0,
-	&bcm_qup0,
 	&bcm_sn1,
 	&bcm_sn2,
 	&bcm_sn3,
@@ -476,297 +411,34 @@ struct qcom_icc_desc {
 	&bcm_sn15,
 };
 
-static struct qcom_icc_desc sdm845_rsc_hlos = {
-	.nodes = rsc_hlos_nodes,
-	.num_nodes = ARRAY_SIZE(rsc_hlos_nodes),
-	.bcms = rsc_hlos_bcms,
-	.num_bcms = ARRAY_SIZE(rsc_hlos_bcms),
+static struct qcom_icc_node *system_noc_nodes[] = {
+	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_GNOC_SNOC] = &qnm_gladiator_sodv,
+	[MASTER_MEM_NOC_SNOC] = &qnm_memnoc,
+	[MASTER_ANOC_PCIE_SNOC] = &qnm_pcie_anoc,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_SNOC_CNOC] = &qns_cnoc,
+	[SLAVE_SNOC_MEM_NOC_GC] = &qns_memnoc_gc,
+	[SLAVE_SNOC_MEM_NOC_SF] = &qns_memnoc_sf,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PCIE_0] = &qxs_pcie,
+	[SLAVE_PCIE_1] = &qxs_pcie_gen3,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
-{
-	struct qcom_icc_node *qn;
-	const struct bcm_db *data;
-	size_t data_count;
-	int i;
-
-	bcm->addr = cmd_db_read_addr(bcm->name);
-	if (!bcm->addr) {
-		dev_err(dev, "%s could not find RPMh address\n",
-			bcm->name);
-		return -EINVAL;
-	}
-
-	data = cmd_db_read_aux_data(bcm->name, &data_count);
-	if (IS_ERR(data)) {
-		dev_err(dev, "%s command db read error (%ld)\n",
-			bcm->name, PTR_ERR(data));
-		return PTR_ERR(data);
-	}
-	if (!data_count) {
-		dev_err(dev, "%s command db missing or partial aux data\n",
-			bcm->name);
-		return -EINVAL;
-	}
-
-	bcm->aux_data.unit = le32_to_cpu(data->unit);
-	bcm->aux_data.width = le16_to_cpu(data->width);
-	bcm->aux_data.vcd = data->vcd;
-	bcm->aux_data.reserved = data->reserved;
-
-	/*
-	 * Link Qnodes to their respective BCMs
-	 */
-	for (i = 0; i < bcm->num_nodes; i++) {
-		qn = bcm->nodes[i];
-		qn->bcms[qn->num_bcms] = bcm;
-		qn->num_bcms++;
-	}
-
-	return 0;
-}
-
-inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
-			u32 addr, bool commit)
-{
-	bool valid = true;
-
-	if (!cmd)
-		return;
-
-	if (vote_x == 0 && vote_y == 0)
-		valid = false;
-
-	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
-		vote_x = BCM_TCS_CMD_VOTE_MASK;
-
-	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
-		vote_y = BCM_TCS_CMD_VOTE_MASK;
-
-	cmd->addr = addr;
-	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
-
-	/*
-	 * Set the wait for completion flag on command that need to be completed
-	 * before the next command.
-	 */
-	if (commit)
-		cmd->wait = true;
-}
-
-static void tcs_list_gen(struct list_head *bcm_list, int bucket,
-			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
-			 int n[SDM845_MAX_VCD])
-{
-	struct qcom_icc_bcm *bcm;
-	bool commit;
-	size_t idx = 0, batch = 0, cur_vcd_size = 0;
-
-	memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
-
-	list_for_each_entry(bcm, bcm_list, list) {
-		commit = false;
-		cur_vcd_size++;
-		if ((list_is_last(&bcm->list, bcm_list)) ||
-		    bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
-			commit = true;
-			cur_vcd_size = 0;
-		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
-			    bcm->vote_y[bucket], bcm->addr, commit);
-		idx++;
-		n[batch]++;
-		/*
-		 * Batch the BCMs in such a way that we do not split them in
-		 * multiple payloads when they are under the same VCD. This is
-		 * to ensure that every BCM is committed since we only set the
-		 * commit bit on the last BCM request of every VCD.
-		 */
-		if (n[batch] >= MAX_RPMH_PAYLOAD) {
-			if (!commit) {
-				n[batch] -= cur_vcd_size;
-				n[batch + 1] = cur_vcd_size;
-			}
-			batch++;
-		}
-	}
-}
-
-static void bcm_aggregate(struct qcom_icc_bcm *bcm)
-{
-	size_t i, bucket;
-	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
-	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
-	u64 temp;
-
-	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
-		for (i = 0; i < bcm->num_nodes; i++) {
-			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-			agg_avg[bucket] = max(agg_avg[bucket], temp);
-
-			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth);
-			agg_peak[bucket] = max(agg_peak[bucket], temp);
-		}
-
-		temp = agg_avg[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_x[bucket] = temp;
-
-		temp = agg_peak[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_y[bucket] = temp;
-	}
-
-	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
-	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] == 0) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
-	}
-
-	bcm->dirty = false;
-}
-
-static void qcom_icc_pre_aggregate(struct icc_node *node)
-{
-	size_t i;
-	struct qcom_icc_node *qn;
-
-	qn = node->data;
-
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-		qn->sum_avg[i] = 0;
-		qn->max_peak[i] = 0;
-	}
-}
-
-static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	size_t i;
-	struct qcom_icc_node *qn;
-
-	qn = node->data;
-
-	if (!tag)
-		tag = QCOM_ICC_TAG_ALWAYS;
-
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-		if (tag & BIT(i)) {
-			qn->sum_avg[i] += avg_bw;
-			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
-		}
-	}
-
-	*agg_avg += avg_bw;
-	*agg_peak = max_t(u32, *agg_peak, peak_bw);
-
-	for (i = 0; i < qn->num_bcms; i++)
-		qn->bcms[i]->dirty = true;
-
-	return 0;
-}
-
-static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
-{
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	struct tcs_cmd cmds[SDM845_MAX_BCMS];
-	struct list_head commit_list;
-	int commit_idx[SDM845_MAX_VCD];
-	int ret = 0, i;
-
-	if (!src)
-		node = dst;
-	else
-		node = src;
-
-	qp = to_qcom_provider(node->provider);
-
-	INIT_LIST_HEAD(&commit_list);
-
-	for (i = 0; i < qp->num_bcms; i++) {
-		if (qp->bcms[i]->dirty) {
-			bcm_aggregate(qp->bcms[i]);
-			list_add_tail(&qp->bcms[i]->list, &commit_list);
-		}
-	}
-
-	/*
-	 * Construct the command list based on a pre ordered list of BCMs
-	 * based on VCD.
-	 */
-	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
-
-	if (!commit_idx[0])
-		return ret;
-
-	ret = rpmh_invalidate(qp->dev);
-	if (ret) {
-		pr_err("Error invalidating RPMH client (%d)\n", ret);
-		return ret;
-	}
-
-	ret = rpmh_write_batch(qp->dev, RPMH_ACTIVE_ONLY_STATE,
-			       cmds, commit_idx);
-	if (ret) {
-		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
-		return ret;
-	}
-
-	INIT_LIST_HEAD(&commit_list);
-
-	for (i = 0; i < qp->num_bcms; i++) {
-		/*
-		 * Only generate WAKE and SLEEP commands if a resource's
-		 * requirements change as the execution environment transitions
-		 * between different power states.
-		 */
-		if (qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_WAKE] !=
-		    qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
-		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_WAKE] !=
-		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_SLEEP]) {
-			list_add_tail(&qp->bcms[i]->list, &commit_list);
-		}
-	}
-
-	if (list_empty(&commit_list))
-		return ret;
-
-	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
-
-	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
-	if (ret) {
-		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
-		return ret;
-	}
-
-	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
-
-	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
-	if (ret) {
-		pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
-static int cmp_vcd(const void *_l, const void *_r)
-{
-	const struct qcom_icc_bcm **l = (const struct qcom_icc_bcm **)_l;
-	const struct qcom_icc_bcm **r = (const struct qcom_icc_bcm **)_r;
-
-	if (l[0]->aux_data.vcd < r[0]->aux_data.vcd)
-		return -1;
-	else if (l[0]->aux_data.vcd == r[0]->aux_data.vcd)
-		return 0;
-	else
-		return 1;
-}
+static struct qcom_icc_desc sdm845_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
 
 static int qnoc_probe(struct platform_device *pdev)
 {
@@ -808,6 +480,12 @@ static int qnoc_probe(struct platform_device *pdev)
 	qp->bcms = desc->bcms;
 	qp->num_bcms = desc->num_bcms;
 
+	qp->voter = of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter)) {
+		dev_err(&pdev->dev, "bcm_voter err:%d\n", PTR_ERR(qp->voter));
+		return PTR_ERR(qp->voter);
+	}
+
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(&pdev->dev, "error adding interconnect provider\n");
@@ -817,6 +495,9 @@ static int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
+		if (!qnodes[i])
+			continue;
+
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
@@ -827,9 +508,6 @@ static int qnoc_probe(struct platform_device *pdev)
 		node->data = qnodes[i];
 		icc_node_add(node, provider);
 
-		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
-			qnodes[i]->name, node->id);
-
 		/* populate links */
 		for (j = 0; j < qnodes[i]->num_links; j++)
 			icc_link_create(node, qnodes[i]->links[j]);
@@ -841,14 +519,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
 
-	/*
-	 * Pre sort the BCMs based on VCD for ease of generating a command list
-	 * that groups the BCMs with the same VCD together. VCDs are numbered
-	 * with lowest being the most expensive time wise, ensuring that
-	 * those commands are being sent the earliest in the queue.
-	 */
-	sort(qp->bcms, qp->num_bcms, sizeof(*qp->bcms), cmp_vcd, NULL);
-
 	platform_set_drvdata(pdev, qp);
 
 	dev_dbg(&pdev->dev, "Registered SDM845 ICC\n");
@@ -879,7 +549,22 @@ static int qnoc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qnoc_of_match[] = {
-	{ .compatible = "qcom,sdm845-rsc-hlos", .data = &sdm845_rsc_hlos },
+	{ .compatible = "qcom,sdm845-aggre1-noc",
+	  .data = &sdm845_aggre1_noc},
+	{ .compatible = "qcom,sdm845-aggre2-noc",
+	  .data = &sdm845_aggre2_noc},
+	{ .compatible = "qcom,sdm845-config-noc",
+	  .data = &sdm845_config_noc},
+	{ .compatible = "qcom,sdm845-dc-noc",
+	  .data = &sdm845_dc_noc},
+	{ .compatible = "qcom,sdm845-gladiator-noc",
+	  .data = &sdm845_gladiator_noc},
+	{ .compatible = "qcom,sdm845-mem-noc",
+	  .data = &sdm845_mem_noc},
+	{ .compatible = "qcom,sdm845-mmss-noc",
+	  .data = &sdm845_mmss_noc},
+	{ .compatible = "qcom,sdm845-system-noc",
+	  .data = &sdm845_system_noc},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

