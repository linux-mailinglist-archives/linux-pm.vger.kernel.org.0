Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8239156C2E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBISfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:35:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25961 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727969AbgBISfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:35:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273312; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tG940mtnH8/STfonSOk6n9QyikF1FNOXKrRvQ/jm3/I=; b=aETGUXwTwdJxfGzrxhJL7PTERGTpxy/Wx+CplX44mPL2YETI2I6QSDEh2DNXL1C2JIAvTvF0
 TUoBe1RI9d452U4eFf6XH6JA7uz+XH4jbW2S5yApEpNVBGa1EnuhmaFul5x9F8P/TYxBnB/W
 pF/5pkzUID9Adv3griKikED64qk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050d0.7f0a482b4538-smtp-out-n03;
 Sun, 09 Feb 2020 18:34:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDD60C447A2; Sun,  9 Feb 2020 18:34:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00D01C447A5;
        Sun,  9 Feb 2020 18:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00D01C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 5/6] interconnect: qcom: sdm845: Split qnodes into their respective NoCs
Date:   Mon, 10 Feb 2020 00:04:10 +0530
Message-Id: <20200209183411.17195-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200209183411.17195-1-sibis@codeaurora.org>
References: <20200209183411.17195-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

In order to better represent the hardware and its different Network-On-Chip
devices, split the sdm845 provider driver into NoC specific providers.
Remove duplicate functionality already provided by the icc rpmh and
bcm voter drivers to calculate and commit bandwidth requests to hardware.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/interconnect/qcom/sdm845.c            | 1185 +++++++----------
 .../dt-bindings/interconnect/qcom,sdm845.h    |  263 ++--
 2 files changed, 632 insertions(+), 816 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom=
/sdm845.c
index f078cf0fce563..ab968afeee594 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1,379 +1,377 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- *
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
  */
=20
-#include <asm/div64.h>
-#include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
-#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/sort.h>
-
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
- * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BC=
M)
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
=20
-#define SDM845_MAX_LINKS	43
-#define SDM845_MAX_BCMS		30
-#define SDM845_MAX_BCM_PER_NODE	2
-#define SDM845_MAX_VCD		10
+#include <dt-bindings/interconnect/qcom,sdm845.h>
=20
-/*
- * The AMC bucket denotes constraints that are applied to hardware when
- * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are appl=
ied
- * when the execution environment transitions between active and low power=
 mode.
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
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+enum {
+	SDM845_MASTER_A1NOC_CFG =3D 1,
+	SDM845_MASTER_BLSP_1,
+	SDM845_MASTER_TSIF,
+	SDM845_MASTER_SDCC_2,
+	SDM845_MASTER_SDCC_4,
+	SDM845_MASTER_UFS_CARD,
+	SDM845_MASTER_UFS_MEM,
+	SDM845_MASTER_PCIE_0,
+	SDM845_MASTER_A2NOC_CFG,
+	SDM845_MASTER_QDSS_BAM,
+	SDM845_MASTER_BLSP_2,
+	SDM845_MASTER_CNOC_A2NOC,
+	SDM845_MASTER_CRYPTO,
+	SDM845_MASTER_IPA,
+	SDM845_MASTER_PCIE_1,
+	SDM845_MASTER_QDSS_ETR,
+	SDM845_MASTER_USB3_0,
+	SDM845_MASTER_USB3_1,
+	SDM845_MASTER_CAMNOC_HF0_UNCOMP,
+	SDM845_MASTER_CAMNOC_HF1_UNCOMP,
+	SDM845_MASTER_CAMNOC_SF_UNCOMP,
+	SDM845_MASTER_SPDM,
+	SDM845_MASTER_TIC,
+	SDM845_MASTER_SNOC_CNOC,
+	SDM845_MASTER_QDSS_DAP,
+	SDM845_MASTER_CNOC_DC_NOC,
+	SDM845_MASTER_APPSS_PROC,
+	SDM845_MASTER_GNOC_CFG,
+	SDM845_MASTER_LLCC,
+	SDM845_MASTER_TCU_0,
+	SDM845_MASTER_MEM_NOC_CFG,
+	SDM845_MASTER_GNOC_MEM_NOC,
+	SDM845_MASTER_MNOC_HF_MEM_NOC,
+	SDM845_MASTER_MNOC_SF_MEM_NOC,
+	SDM845_MASTER_SNOC_GC_MEM_NOC,
+	SDM845_MASTER_SNOC_SF_MEM_NOC,
+	SDM845_MASTER_GFX3D,
+	SDM845_MASTER_CNOC_MNOC_CFG,
+	SDM845_MASTER_CAMNOC_HF0,
+	SDM845_MASTER_CAMNOC_HF1,
+	SDM845_MASTER_CAMNOC_SF,
+	SDM845_MASTER_MDP0,
+	SDM845_MASTER_MDP1,
+	SDM845_MASTER_ROTATOR,
+	SDM845_MASTER_VIDEO_P0,
+	SDM845_MASTER_VIDEO_P1,
+	SDM845_MASTER_VIDEO_PROC,
+	SDM845_MASTER_SNOC_CFG,
+	SDM845_MASTER_A1NOC_SNOC,
+	SDM845_MASTER_A2NOC_SNOC,
+	SDM845_MASTER_GNOC_SNOC,
+	SDM845_MASTER_MEM_NOC_SNOC,
+	SDM845_MASTER_ANOC_PCIE_SNOC,
+	SDM845_MASTER_PIMEM,
+	SDM845_MASTER_GIC,
+	SDM845_SLAVE_A1NOC_SNOC,
+	SDM845_SLAVE_SERVICE_A1NOC,
+	SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC,
+	SDM845_SLAVE_A2NOC_SNOC,
+	SDM845_SLAVE_ANOC_PCIE_SNOC,
+	SDM845_SLAVE_SERVICE_A2NOC,
+	SDM845_SLAVE_CAMNOC_UNCOMP,
+	SDM845_SLAVE_A1NOC_CFG,
+	SDM845_SLAVE_A2NOC_CFG,
+	SDM845_SLAVE_AOP,
+	SDM845_SLAVE_AOSS,
+	SDM845_SLAVE_CAMERA_CFG,
+	SDM845_SLAVE_CLK_CTL,
+	SDM845_SLAVE_CDSP_CFG,
+	SDM845_SLAVE_RBCPR_CX_CFG,
+	SDM845_SLAVE_CRYPTO_0_CFG,
+	SDM845_SLAVE_DCC_CFG,
+	SDM845_SLAVE_CNOC_DDRSS,
+	SDM845_SLAVE_DISPLAY_CFG,
+	SDM845_SLAVE_GLM,
+	SDM845_SLAVE_GFX3D_CFG,
+	SDM845_SLAVE_IMEM_CFG,
+	SDM845_SLAVE_IPA_CFG,
+	SDM845_SLAVE_CNOC_MNOC_CFG,
+	SDM845_SLAVE_PCIE_0_CFG,
+	SDM845_SLAVE_PCIE_1_CFG,
+	SDM845_SLAVE_PDM,
+	SDM845_SLAVE_SOUTH_PHY_CFG,
+	SDM845_SLAVE_PIMEM_CFG,
+	SDM845_SLAVE_PRNG,
+	SDM845_SLAVE_QDSS_CFG,
+	SDM845_SLAVE_BLSP_2,
+	SDM845_SLAVE_BLSP_1,
+	SDM845_SLAVE_SDCC_2,
+	SDM845_SLAVE_SDCC_4,
+	SDM845_SLAVE_SNOC_CFG,
+	SDM845_SLAVE_SPDM_WRAPPER,
+	SDM845_SLAVE_SPSS_CFG,
+	SDM845_SLAVE_TCSR,
+	SDM845_SLAVE_TLMM_NORTH,
+	SDM845_SLAVE_TLMM_SOUTH,
+	SDM845_SLAVE_TSIF,
+	SDM845_SLAVE_UFS_CARD_CFG,
+	SDM845_SLAVE_UFS_MEM_CFG,
+	SDM845_SLAVE_USB3_0,
+	SDM845_SLAVE_USB3_1,
+	SDM845_SLAVE_VENUS_CFG,
+	SDM845_SLAVE_VSENSE_CTRL_CFG,
+	SDM845_SLAVE_CNOC_A2NOC,
+	SDM845_SLAVE_SERVICE_CNOC,
+	SDM845_SLAVE_LLCC_CFG,
+	SDM845_SLAVE_MEM_NOC_CFG,
+	SDM845_SLAVE_GNOC_SNOC,
+	SDM845_SLAVE_GNOC_MEM_NOC,
+	SDM845_SLAVE_SERVICE_GNOC,
+	SDM845_SLAVE_EBI1,
+	SDM845_SLAVE_MSS_PROC_MS_MPU_CFG,
+	SDM845_SLAVE_MEM_NOC_GNOC,
+	SDM845_SLAVE_LLCC,
+	SDM845_SLAVE_MEM_NOC_SNOC,
+	SDM845_SLAVE_SERVICE_MEM_NOC,
+	SDM845_SLAVE_MNOC_SF_MEM_NOC,
+	SDM845_SLAVE_MNOC_HF_MEM_NOC,
+	SDM845_SLAVE_SERVICE_MNOC,
+	SDM845_SLAVE_APPSS,
+	SDM845_SLAVE_SNOC_CNOC,
+	SDM845_SLAVE_SNOC_MEM_NOC_GC,
+	SDM845_SLAVE_SNOC_MEM_NOC_SF,
+	SDM845_SLAVE_IMEM,
+	SDM845_SLAVE_PCIE_0,
+	SDM845_SLAVE_PCIE_1,
+	SDM845_SLAVE_PIMEM,
+	SDM845_SLAVE_SERVICE_SNOC,
+	SDM845_SLAVE_QDSS_STM,
+	SDM845_SLAVE_TCU
 };
=20
-/**
- * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
- * known as Bus Clock Manager (BCM)
- * @name: the bcm node name used to fetch BCM data from command db
- * @type: latency or bandwidth bcm
- * @addr: address offsets used when voting to RPMH
- * @vote_x: aggregated threshold values, represents sum_bw when @type is b=
w bcm
- * @vote_y: aggregated threshold values, represents peak_bw when @type is =
bw bcm
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
+DEFINE_QNODE(qhm_a1noc_cfg, SDM845_MASTER_A1NOC_CFG, 1, 4, SDM845_SLAVE_SE=
RVICE_A1NOC);
+DEFINE_QNODE(qhm_qup1, SDM845_MASTER_BLSP_1, 1, 4, SDM845_SLAVE_A1NOC_SNOC=
);
+DEFINE_QNODE(qhm_tsif, SDM845_MASTER_TSIF, 1, 4, SDM845_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(xm_sdc2, SDM845_MASTER_SDCC_2, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(xm_sdc4, SDM845_MASTER_SDCC_4, 1, 8, SDM845_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(xm_ufs_card, SDM845_MASTER_UFS_CARD, 1, 8, SDM845_SLAVE_A1NOC=
_SNOC);
+DEFINE_QNODE(xm_ufs_mem, SDM845_MASTER_UFS_MEM, 1, 8, SDM845_SLAVE_A1NOC_S=
NOC);
+DEFINE_QNODE(xm_pcie_0, SDM845_MASTER_PCIE_0, 1, 8, SDM845_SLAVE_ANOC_PCIE=
_A1NOC_SNOC);
+DEFINE_QNODE(qhm_a2noc_cfg, SDM845_MASTER_A2NOC_CFG, 1, 4, SDM845_SLAVE_SE=
RVICE_A2NOC);
+DEFINE_QNODE(qhm_qdss_bam, SDM845_MASTER_QDSS_BAM, 1, 4, SDM845_SLAVE_A2NO=
C_SNOC);
+DEFINE_QNODE(qhm_qup2, SDM845_MASTER_BLSP_2, 1, 4, SDM845_SLAVE_A2NOC_SNOC=
);
+DEFINE_QNODE(qnm_cnoc, SDM845_MASTER_CNOC_A2NOC, 1, 8, SDM845_SLAVE_A2NOC_=
SNOC);
+DEFINE_QNODE(qxm_crypto, SDM845_MASTER_CRYPTO, 1, 8, SDM845_SLAVE_A2NOC_SN=
OC);
+DEFINE_QNODE(qxm_ipa, SDM845_MASTER_IPA, 1, 8, SDM845_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(xm_pcie3_1, SDM845_MASTER_PCIE_1, 1, 8, SDM845_SLAVE_ANOC_PCI=
E_SNOC);
+DEFINE_QNODE(xm_qdss_etr, SDM845_MASTER_QDSS_ETR, 1, 8, SDM845_SLAVE_A2NOC=
_SNOC);
+DEFINE_QNODE(xm_usb3_0, SDM845_MASTER_USB3_0, 1, 8, SDM845_SLAVE_A2NOC_SNO=
C);
+DEFINE_QNODE(xm_usb3_1, SDM845_MASTER_USB3_1, 1, 8, SDM845_SLAVE_A2NOC_SNO=
C);
+DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SDM845_MASTER_CAMNOC_HF0_UNCOMP, 1, 32=
, SDM845_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SDM845_MASTER_CAMNOC_HF1_UNCOMP, 1, 32=
, SDM845_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qxm_camnoc_sf_uncomp, SDM845_MASTER_CAMNOC_SF_UNCOMP, 1, 32, =
SDM845_SLAVE_CAMNOC_UNCOMP);
+DEFINE_QNODE(qhm_spdm, SDM845_MASTER_SPDM, 1, 4, SDM845_SLAVE_CNOC_A2NOC);
+DEFINE_QNODE(qhm_tic, SDM845_MASTER_TIC, 1, 4, SDM845_SLAVE_A1NOC_CFG, SDM=
845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_SLAVE_CAME=
RA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_RBCPR_CX_=
CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE_CNOC_DDR=
SS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D_CFG, SDM=
845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_CFG, SDM84=
5_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM845_SLAVE=
_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_SLAVE_QDS=
S_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC_2, SDM84=
5_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, SDM845_SL=
AVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_SLAVE_TLMM=
_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE_UFS_MEM_=
CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_CFG, SDM8=
45_SLAVE_VSENSE_CTRL_CFG, SDM845_SLAVE_CNOC_A2NOC, SDM845_SLAVE_SERVICE_CNO=
C);
+DEFINE_QNODE(qnm_snoc, SDM845_MASTER_SNOC_CNOC, 1, 8, SDM845_SLAVE_A1NOC_C=
FG, SDM845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_SLA=
VE_CAMERA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_RB=
CPR_CX_CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE_C=
NOC_DDRSS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D_C=
FG, SDM845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_CFG=
, SDM845_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM84=
5_SLAVE_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_SL=
AVE_QDSS_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC_2=
, SDM845_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, SD=
M845_SLAVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_SLA=
VE_TLMM_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE_U=
FS_MEM_CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_CF=
G, SDM845_SLAVE_VSENSE_CTRL_CFG, SDM845_SLAVE_SERVICE_CNOC);
+DEFINE_QNODE(xm_qdss_dap, SDM845_MASTER_QDSS_DAP, 1, 8, SDM845_SLAVE_A1NOC=
_CFG, SDM845_SLAVE_A2NOC_CFG, SDM845_SLAVE_AOP, SDM845_SLAVE_AOSS, SDM845_S=
LAVE_CAMERA_CFG, SDM845_SLAVE_CLK_CTL, SDM845_SLAVE_CDSP_CFG, SDM845_SLAVE_=
RBCPR_CX_CFG, SDM845_SLAVE_CRYPTO_0_CFG, SDM845_SLAVE_DCC_CFG, SDM845_SLAVE=
_CNOC_DDRSS, SDM845_SLAVE_DISPLAY_CFG, SDM845_SLAVE_GLM, SDM845_SLAVE_GFX3D=
_CFG, SDM845_SLAVE_IMEM_CFG, SDM845_SLAVE_IPA_CFG, SDM845_SLAVE_CNOC_MNOC_C=
FG, SDM845_SLAVE_PCIE_0_CFG, SDM845_SLAVE_PCIE_1_CFG, SDM845_SLAVE_PDM, SDM=
845_SLAVE_SOUTH_PHY_CFG, SDM845_SLAVE_PIMEM_CFG, SDM845_SLAVE_PRNG, SDM845_=
SLAVE_QDSS_CFG, SDM845_SLAVE_BLSP_2, SDM845_SLAVE_BLSP_1, SDM845_SLAVE_SDCC=
_2, SDM845_SLAVE_SDCC_4, SDM845_SLAVE_SNOC_CFG, SDM845_SLAVE_SPDM_WRAPPER, =
SDM845_SLAVE_SPSS_CFG, SDM845_SLAVE_TCSR, SDM845_SLAVE_TLMM_NORTH, SDM845_S=
LAVE_TLMM_SOUTH, SDM845_SLAVE_TSIF, SDM845_SLAVE_UFS_CARD_CFG, SDM845_SLAVE=
_UFS_MEM_CFG, SDM845_SLAVE_USB3_0, SDM845_SLAVE_USB3_1, SDM845_SLAVE_VENUS_=
CFG, SDM845_SLAVE_VSENSE_CTRL_CFG, SDM845_SLAVE_CNOC_A2NOC, SDM845_SLAVE_SE=
RVICE_CNOC);
+DEFINE_QNODE(qhm_cnoc, SDM845_MASTER_CNOC_DC_NOC, 1, 4, SDM845_SLAVE_LLCC_=
CFG, SDM845_SLAVE_MEM_NOC_CFG);
+DEFINE_QNODE(acm_l3, SDM845_MASTER_APPSS_PROC, 1, 16, SDM845_SLAVE_GNOC_SN=
OC, SDM845_SLAVE_GNOC_MEM_NOC, SDM845_SLAVE_SERVICE_GNOC);
+DEFINE_QNODE(pm_gnoc_cfg, SDM845_MASTER_GNOC_CFG, 1, 4, SDM845_SLAVE_SERVI=
CE_GNOC);
+DEFINE_QNODE(llcc_mc, SDM845_MASTER_LLCC, 4, 4, SDM845_SLAVE_EBI1);
+DEFINE_QNODE(acm_tcu, SDM845_MASTER_TCU_0, 1, 8, SDM845_SLAVE_MEM_NOC_GNOC=
, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
+DEFINE_QNODE(qhm_memnoc_cfg, SDM845_MASTER_MEM_NOC_CFG, 1, 4, SDM845_SLAVE=
_MSS_PROC_MS_MPU_CFG, SDM845_SLAVE_SERVICE_MEM_NOC);
+DEFINE_QNODE(qnm_apps, SDM845_MASTER_GNOC_MEM_NOC, 2, 32, SDM845_SLAVE_LLC=
C);
+DEFINE_QNODE(qnm_mnoc_hf, SDM845_MASTER_MNOC_HF_MEM_NOC, 2, 32, SDM845_SLA=
VE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC);
+DEFINE_QNODE(qnm_mnoc_sf, SDM845_MASTER_MNOC_SF_MEM_NOC, 1, 32, SDM845_SLA=
VE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
+DEFINE_QNODE(qnm_snoc_gc, SDM845_MASTER_SNOC_GC_MEM_NOC, 1, 8, SDM845_SLAV=
E_LLCC);
+DEFINE_QNODE(qnm_snoc_sf, SDM845_MASTER_SNOC_SF_MEM_NOC, 1, 16, SDM845_SLA=
VE_MEM_NOC_GNOC, SDM845_SLAVE_LLCC);
+DEFINE_QNODE(qxm_gpu, SDM845_MASTER_GFX3D, 2, 32, SDM845_SLAVE_MEM_NOC_GNO=
C, SDM845_SLAVE_LLCC, SDM845_SLAVE_MEM_NOC_SNOC);
+DEFINE_QNODE(qhm_mnoc_cfg, SDM845_MASTER_CNOC_MNOC_CFG, 1, 4, SDM845_SLAVE=
_SERVICE_MNOC);
+DEFINE_QNODE(qxm_camnoc_hf0, SDM845_MASTER_CAMNOC_HF0, 1, 32, SDM845_SLAVE=
_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(qxm_camnoc_hf1, SDM845_MASTER_CAMNOC_HF1, 1, 32, SDM845_SLAVE=
_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(qxm_camnoc_sf, SDM845_MASTER_CAMNOC_SF, 1, 32, SDM845_SLAVE_M=
NOC_SF_MEM_NOC);
+DEFINE_QNODE(qxm_mdp0, SDM845_MASTER_MDP0, 1, 32, SDM845_SLAVE_MNOC_HF_MEM=
_NOC);
+DEFINE_QNODE(qxm_mdp1, SDM845_MASTER_MDP1, 1, 32, SDM845_SLAVE_MNOC_HF_MEM=
_NOC);
+DEFINE_QNODE(qxm_rot, SDM845_MASTER_ROTATOR, 1, 32, SDM845_SLAVE_MNOC_SF_M=
EM_NOC);
+DEFINE_QNODE(qxm_venus0, SDM845_MASTER_VIDEO_P0, 1, 32, SDM845_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qxm_venus1, SDM845_MASTER_VIDEO_P1, 1, 32, SDM845_SLAVE_MNOC_=
SF_MEM_NOC);
+DEFINE_QNODE(qxm_venus_arm9, SDM845_MASTER_VIDEO_PROC, 1, 8, SDM845_SLAVE_=
MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qhm_snoc_cfg, SDM845_MASTER_SNOC_CFG, 1, 4, SDM845_SLAVE_SERV=
ICE_SNOC);
+DEFINE_QNODE(qnm_aggre1_noc, SDM845_MASTER_A1NOC_SNOC, 1, 16, SDM845_SLAVE=
_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLAVE_=
IMEM, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_aggre2_noc, SDM845_MASTER_A2NOC_SNOC, 1, 16, SDM845_SLAVE=
_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLAVE_=
IMEM, SDM845_SLAVE_PCIE_0, SDM845_SLAVE_PCIE_1, SDM845_SLAVE_PIMEM, SDM845_=
SLAVE_QDSS_STM, SDM845_SLAVE_TCU);
+DEFINE_QNODE(qnm_gladiator_sodv, SDM845_MASTER_GNOC_SNOC, 1, 8, SDM845_SLA=
VE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_IMEM, SDM845_SLAVE_PCIE_0, S=
DM845_SLAVE_PCIE_1, SDM845_SLAVE_PIMEM, SDM845_SLAVE_QDSS_STM, SDM845_SLAVE=
_TCU);
+DEFINE_QNODE(qnm_memnoc, SDM845_MASTER_MEM_NOC_SNOC, 1, 8, SDM845_SLAVE_AP=
PSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_IMEM, SDM845_SLAVE_PIMEM, SDM845_=
SLAVE_QDSS_STM);
+DEFINE_QNODE(qnm_pcie_anoc, SDM845_MASTER_ANOC_PCIE_SNOC, 1, 16, SDM845_SL=
AVE_APPSS, SDM845_SLAVE_SNOC_CNOC, SDM845_SLAVE_SNOC_MEM_NOC_SF, SDM845_SLA=
VE_IMEM, SDM845_SLAVE_QDSS_STM);
+DEFINE_QNODE(qxm_pimem, SDM845_MASTER_PIMEM, 1, 8, SDM845_SLAVE_SNOC_MEM_N=
OC_GC, SDM845_SLAVE_IMEM);
+DEFINE_QNODE(xm_gic, SDM845_MASTER_GIC, 1, 8, SDM845_SLAVE_SNOC_MEM_NOC_GC=
, SDM845_SLAVE_IMEM);
+DEFINE_QNODE(qns_a1noc_snoc, SDM845_SLAVE_A1NOC_SNOC, 1, 16, SDM845_MASTER=
_A1NOC_SNOC);
+DEFINE_QNODE(srvc_aggre1_noc, SDM845_SLAVE_SERVICE_A1NOC, 1, 4, 0);
+DEFINE_QNODE(qns_pcie_a1noc_snoc, SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC, 1, 16=
, SDM845_MASTER_ANOC_PCIE_SNOC);
+DEFINE_QNODE(qns_a2noc_snoc, SDM845_SLAVE_A2NOC_SNOC, 1, 16, SDM845_MASTER=
_A2NOC_SNOC);
+DEFINE_QNODE(qns_pcie_snoc, SDM845_SLAVE_ANOC_PCIE_SNOC, 1, 16, SDM845_MAS=
TER_ANOC_PCIE_SNOC);
+DEFINE_QNODE(srvc_aggre2_noc, SDM845_SLAVE_SERVICE_A2NOC, 1, 4);
+DEFINE_QNODE(qns_camnoc_uncomp, SDM845_SLAVE_CAMNOC_UNCOMP, 1, 32);
+DEFINE_QNODE(qhs_a1_noc_cfg, SDM845_SLAVE_A1NOC_CFG, 1, 4, SDM845_MASTER_A=
1NOC_CFG);
+DEFINE_QNODE(qhs_a2_noc_cfg, SDM845_SLAVE_A2NOC_CFG, 1, 4, SDM845_MASTER_A=
2NOC_CFG);
+DEFINE_QNODE(qhs_aop, SDM845_SLAVE_AOP, 1, 4);
+DEFINE_QNODE(qhs_aoss, SDM845_SLAVE_AOSS, 1, 4);
+DEFINE_QNODE(qhs_camera_cfg, SDM845_SLAVE_CAMERA_CFG, 1, 4);
+DEFINE_QNODE(qhs_clk_ctl, SDM845_SLAVE_CLK_CTL, 1, 4);
+DEFINE_QNODE(qhs_compute_dsp_cfg, SDM845_SLAVE_CDSP_CFG, 1, 4);
+DEFINE_QNODE(qhs_cpr_cx, SDM845_SLAVE_RBCPR_CX_CFG, 1, 4);
+DEFINE_QNODE(qhs_crypto0_cfg, SDM845_SLAVE_CRYPTO_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_dcc_cfg, SDM845_SLAVE_DCC_CFG, 1, 4, SDM845_MASTER_CNOC_D=
C_NOC);
+DEFINE_QNODE(qhs_ddrss_cfg, SDM845_SLAVE_CNOC_DDRSS, 1, 4);
+DEFINE_QNODE(qhs_display_cfg, SDM845_SLAVE_DISPLAY_CFG, 1, 4);
+DEFINE_QNODE(qhs_glm, SDM845_SLAVE_GLM, 1, 4);
+DEFINE_QNODE(qhs_gpuss_cfg, SDM845_SLAVE_GFX3D_CFG, 1, 8);
+DEFINE_QNODE(qhs_imem_cfg, SDM845_SLAVE_IMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_ipa, SDM845_SLAVE_IPA_CFG, 1, 4);
+DEFINE_QNODE(qhs_mnoc_cfg, SDM845_SLAVE_CNOC_MNOC_CFG, 1, 4, SDM845_MASTER=
_CNOC_MNOC_CFG);
+DEFINE_QNODE(qhs_pcie0_cfg, SDM845_SLAVE_PCIE_0_CFG, 1, 4);
+DEFINE_QNODE(qhs_pcie_gen3_cfg, SDM845_SLAVE_PCIE_1_CFG, 1, 4);
+DEFINE_QNODE(qhs_pdm, SDM845_SLAVE_PDM, 1, 4);
+DEFINE_QNODE(qhs_phy_refgen_south, SDM845_SLAVE_SOUTH_PHY_CFG, 1, 4);
+DEFINE_QNODE(qhs_pimem_cfg, SDM845_SLAVE_PIMEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_prng, SDM845_SLAVE_PRNG, 1, 4);
+DEFINE_QNODE(qhs_qdss_cfg, SDM845_SLAVE_QDSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_qupv3_north, SDM845_SLAVE_BLSP_2, 1, 4);
+DEFINE_QNODE(qhs_qupv3_south, SDM845_SLAVE_BLSP_1, 1, 4);
+DEFINE_QNODE(qhs_sdc2, SDM845_SLAVE_SDCC_2, 1, 4);
+DEFINE_QNODE(qhs_sdc4, SDM845_SLAVE_SDCC_4, 1, 4);
+DEFINE_QNODE(qhs_snoc_cfg, SDM845_SLAVE_SNOC_CFG, 1, 4, SDM845_MASTER_SNOC=
_CFG);
+DEFINE_QNODE(qhs_spdm, SDM845_SLAVE_SPDM_WRAPPER, 1, 4);
+DEFINE_QNODE(qhs_spss_cfg, SDM845_SLAVE_SPSS_CFG, 1, 4);
+DEFINE_QNODE(qhs_tcsr, SDM845_SLAVE_TCSR, 1, 4);
+DEFINE_QNODE(qhs_tlmm_north, SDM845_SLAVE_TLMM_NORTH, 1, 4);
+DEFINE_QNODE(qhs_tlmm_south, SDM845_SLAVE_TLMM_SOUTH, 1, 4);
+DEFINE_QNODE(qhs_tsif, SDM845_SLAVE_TSIF, 1, 4);
+DEFINE_QNODE(qhs_ufs_card_cfg, SDM845_SLAVE_UFS_CARD_CFG, 1, 4);
+DEFINE_QNODE(qhs_ufs_mem_cfg, SDM845_SLAVE_UFS_MEM_CFG, 1, 4);
+DEFINE_QNODE(qhs_usb3_0, SDM845_SLAVE_USB3_0, 1, 4);
+DEFINE_QNODE(qhs_usb3_1, SDM845_SLAVE_USB3_1, 1, 4);
+DEFINE_QNODE(qhs_venus_cfg, SDM845_SLAVE_VENUS_CFG, 1, 4);
+DEFINE_QNODE(qhs_vsense_ctrl_cfg, SDM845_SLAVE_VSENSE_CTRL_CFG, 1, 4);
+DEFINE_QNODE(qns_cnoc_a2noc, SDM845_SLAVE_CNOC_A2NOC, 1, 8, SDM845_MASTER_=
CNOC_A2NOC);
+DEFINE_QNODE(srvc_cnoc, SDM845_SLAVE_SERVICE_CNOC, 1, 4);
+DEFINE_QNODE(qhs_llcc, SDM845_SLAVE_LLCC_CFG, 1, 4);
+DEFINE_QNODE(qhs_memnoc, SDM845_SLAVE_MEM_NOC_CFG, 1, 4, SDM845_MASTER_MEM=
_NOC_CFG);
+DEFINE_QNODE(qns_gladiator_sodv, SDM845_SLAVE_GNOC_SNOC, 1, 8, SDM845_MAST=
ER_GNOC_SNOC);
+DEFINE_QNODE(qns_gnoc_memnoc, SDM845_SLAVE_GNOC_MEM_NOC, 2, 32, SDM845_MAS=
TER_GNOC_MEM_NOC);
+DEFINE_QNODE(srvc_gnoc, SDM845_SLAVE_SERVICE_GNOC, 1, 4);
+DEFINE_QNODE(ebi, SDM845_SLAVE_EBI1, 4, 4);
+DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SDM845_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
+DEFINE_QNODE(qns_apps_io, SDM845_SLAVE_MEM_NOC_GNOC, 1, 32);
+DEFINE_QNODE(qns_llcc, SDM845_SLAVE_LLCC, 4, 16, SDM845_MASTER_LLCC);
+DEFINE_QNODE(qns_memnoc_snoc, SDM845_SLAVE_MEM_NOC_SNOC, 1, 8, SDM845_MAST=
ER_MEM_NOC_SNOC);
+DEFINE_QNODE(srvc_memnoc, SDM845_SLAVE_SERVICE_MEM_NOC, 1, 4);
+DEFINE_QNODE(qns2_mem_noc, SDM845_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SDM845_MAS=
TER_MNOC_SF_MEM_NOC);
+DEFINE_QNODE(qns_mem_noc_hf, SDM845_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SDM845_M=
ASTER_MNOC_HF_MEM_NOC);
+DEFINE_QNODE(srvc_mnoc, SDM845_SLAVE_SERVICE_MNOC, 1, 4);
+DEFINE_QNODE(qhs_apss, SDM845_SLAVE_APPSS, 1, 8);
+DEFINE_QNODE(qns_cnoc, SDM845_SLAVE_SNOC_CNOC, 1, 8, SDM845_MASTER_SNOC_CN=
OC);
+DEFINE_QNODE(qns_memnoc_gc, SDM845_SLAVE_SNOC_MEM_NOC_GC, 1, 8, SDM845_MAS=
TER_SNOC_GC_MEM_NOC);
+DEFINE_QNODE(qns_memnoc_sf, SDM845_SLAVE_SNOC_MEM_NOC_SF, 1, 16, SDM845_MA=
STER_SNOC_SF_MEM_NOC);
+DEFINE_QNODE(qxs_imem, SDM845_SLAVE_IMEM, 1, 8);
+DEFINE_QNODE(qxs_pcie, SDM845_SLAVE_PCIE_0, 1, 8);
+DEFINE_QNODE(qxs_pcie_gen3, SDM845_SLAVE_PCIE_1, 1, 8);
+DEFINE_QNODE(qxs_pimem, SDM845_SLAVE_PIMEM, 1, 8);
+DEFINE_QNODE(srvc_snoc, SDM845_SLAVE_SERVICE_SNOC, 1, 4);
+DEFINE_QNODE(xs_qdss_stm, SDM845_SLAVE_QDSS_STM, 1, 4);
+DEFINE_QNODE(xs_sys_tcu_cfg, SDM845_SLAVE_TCU, 1, 8);
+
+DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
+DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
+DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
+DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_apps_io);
+DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1=
_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0=
, &qxm_mdp1);
+DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_memnoc_snoc);
+DEFINE_QBCM(bcm_mm2, "MM2", false, &qns2_mem_noc);
+DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_tcu);
+DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, =
&qxm_venus1, &qxm_venus_arm9);
+DEFINE_QBCM(bcm_sh5, "SH5", false, &qnm_apps);
+DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_memnoc_sf);
+DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
+DEFINE_QBCM(bcm_cn0, "CN0", false, &qhm_spdm, &qhm_tic, &qnm_snoc, &xm_qds=
s_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_aop, &qhs_aoss, &qhs_camera_c=
fg, &qhs_clk_ctl, &qhs_compute_dsp_cfg, &qhs_cpr_cx, &qhs_crypto0_cfg, &qhs=
_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_=
imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_pcie0_cfg, &qhs_pcie_gen3_cfg, &qhs=
_pdm, &qhs_phy_refgen_south, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs=
_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_s=
pdm, &qhs_spss_cfg, &qhs_tcsr, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tsif,=
 &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_=
cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
+DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup1, &qhm_qup2);
+DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
+DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_memnoc_gc);
+DEFINE_QBCM(bcm_sn3, "SN3", false, &qns_cnoc);
+DEFINE_QBCM(bcm_sn4, "SN4", false, &qxm_pimem);
+DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
+DEFINE_QBCM(bcm_sn6, "SN6", false, &qhs_apss, &srvc_snoc, &xs_sys_tcu_cfg);
+DEFINE_QBCM(bcm_sn7, "SN7", false, &qxs_pcie);
+DEFINE_QBCM(bcm_sn8, "SN8", false, &qxs_pcie_gen3);
+DEFINE_QBCM(bcm_sn9, "SN9", false, &srvc_aggre1_noc, &qnm_aggre1_noc);
+DEFINE_QBCM(bcm_sn11, "SN11", false, &srvc_aggre2_noc, &qnm_aggre2_noc);
+DEFINE_QBCM(bcm_sn12, "SN12", false, &qnm_gladiator_sodv, &xm_gic);
+DEFINE_QBCM(bcm_sn14, "SN14", false, &qnm_pcie_anoc);
+DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_memnoc);
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] =3D {
+	&bcm_sn9,
 };
=20
-struct qcom_icc_fabric {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
+static struct qcom_icc_node *aggre1_noc_nodes[] =3D {
+	[MASTER_A1NOC_CFG] =3D &qhm_a1noc_cfg,
+	[MASTER_TSIF] =3D &qhm_tsif,
+	[MASTER_SDCC_2] =3D &xm_sdc2,
+	[MASTER_SDCC_4] =3D &xm_sdc4,
+	[MASTER_UFS_CARD] =3D &xm_ufs_card,
+	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
+	[MASTER_PCIE_0] =3D &xm_pcie_0,
+	[SLAVE_A1NOC_SNOC] =3D &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
+	[SLAVE_ANOC_PCIE_A1NOC_SNOC] =3D &qns_pcie_a1noc_snoc,
 };
=20
-struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
-	struct qcom_icc_bcm **bcms;
-	size_t num_bcms;
+const static struct qcom_icc_desc sdm845_aggre1_noc =3D {
+	.nodes =3D aggre1_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms =3D aggre1_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre1_noc_bcms),
 };
=20
-#define DEFINE_QNODE(_name, _id, _channels, _buswidth,			\
-			_numlinks, ...)					\
-		static struct qcom_icc_node _name =3D {			\
-		.id =3D _id,						\
-		.name =3D #_name,						\
-		.channels =3D _channels,					\
-		.buswidth =3D _buswidth,					\
-		.num_links =3D _numlinks,					\
-		.links =3D { __VA_ARGS__ },				\
-	}
-
-DEFINE_QNODE(qhm_a1noc_cfg, MASTER_A1NOC_CFG, 1, 4, 1, SLAVE_SERVICE_A1NOC=
);
-DEFINE_QNODE(qhm_qup1, MASTER_BLSP_1, 1, 4, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(qhm_tsif, MASTER_TSIF, 1, 4, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc2, MASTER_SDCC_2, 1, 8, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_sdc4, MASTER_SDCC_4, 1, 8, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_card, MASTER_UFS_CARD, 1, 8, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_ufs_mem, MASTER_UFS_MEM, 1, 8, 1, SLAVE_A1NOC_SNOC);
-DEFINE_QNODE(xm_pcie_0, MASTER_PCIE_0, 1, 8, 1, SLAVE_ANOC_PCIE_A1NOC_SNOC=
);
-DEFINE_QNODE(qhm_a2noc_cfg, MASTER_A2NOC_CFG, 1, 4, 1, SLAVE_SERVICE_A2NOC=
);
-DEFINE_QNODE(qhm_qdss_bam, MASTER_QDSS_BAM, 1, 4, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qhm_qup2, MASTER_BLSP_2, 1, 4, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qnm_cnoc, MASTER_CNOC_A2NOC, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_crypto, MASTER_CRYPTO, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_ipa, MASTER_IPA, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_pcie3_1, MASTER_PCIE_1, 1, 8, 1, SLAVE_ANOC_PCIE_SNOC);
-DEFINE_QNODE(xm_qdss_etr, MASTER_QDSS_ETR, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_usb3_0, MASTER_USB3_0, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(xm_usb3_1, MASTER_USB3_1, 1, 8, 1, SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(qxm_camnoc_hf0_uncomp, MASTER_CAMNOC_HF0_UNCOMP, 1, 32, 1, SL=
AVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_hf1_uncomp, MASTER_CAMNOC_HF1_UNCOMP, 1, 32, 1, SL=
AVE_CAMNOC_UNCOMP);
-DEFINE_QNODE(qxm_camnoc_sf_uncomp, MASTER_CAMNOC_SF_UNCOMP, 1, 32, 1, SLAV=
E_CAMNOC_UNCOMP);
-DEFINE_QNODE(qhm_spdm, MASTER_SPDM, 1, 4, 1, SLAVE_CNOC_A2NOC);
-DEFINE_QNODE(qhm_tic, MASTER_TIC, 1, 4, 43, SLAVE_A1NOC_CFG, SLAVE_A2NOC_C=
FG, SLAVE_AOP, SLAVE_AOSS, SLAVE_CAMERA_CFG, SLAVE_CLK_CTL, SLAVE_CDSP_CFG,=
 SLAVE_RBCPR_CX_CFG, SLAVE_CRYPTO_0_CFG, SLAVE_DCC_CFG, SLAVE_CNOC_DDRSS, S=
LAVE_DISPLAY_CFG, SLAVE_GLM, SLAVE_GFX3D_CFG, SLAVE_IMEM_CFG, SLAVE_IPA_CFG=
, SLAVE_CNOC_MNOC_CFG, SLAVE_PCIE_0_CFG, SLAVE_PCIE_1_CFG, SLAVE_PDM, SLAVE=
_SOUTH_PHY_CFG, SLAVE_PIMEM_CFG, SLAVE_PRNG, SLAVE_QDSS_CFG, SLAVE_BLSP_2, =
SLAVE_BLSP_1, SLAVE_SDCC_2, SLAVE_SDCC_4, SLAVE_SNOC_CFG, SLAVE_SPDM_WRAPPE=
R, SLAVE_SPSS_CFG, SLAVE_TCSR, SLAVE_TLMM_NORTH, SLAVE_TLMM_SOUTH, SLAVE_TS=
IF, SLAVE_UFS_CARD_CFG, SLAVE_UFS_MEM_CFG, SLAVE_USB3_0, SLAVE_USB3_1, SLAV=
E_VENUS_CFG, SLAVE_VSENSE_CTRL_CFG, SLAVE_CNOC_A2NOC, SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(qnm_snoc, MASTER_SNOC_CNOC, 1, 8, 42, SLAVE_A1NOC_CFG, SLAVE_=
A2NOC_CFG, SLAVE_AOP, SLAVE_AOSS, SLAVE_CAMERA_CFG, SLAVE_CLK_CTL, SLAVE_CD=
SP_CFG, SLAVE_RBCPR_CX_CFG, SLAVE_CRYPTO_0_CFG, SLAVE_DCC_CFG, SLAVE_CNOC_D=
DRSS, SLAVE_DISPLAY_CFG, SLAVE_GLM, SLAVE_GFX3D_CFG, SLAVE_IMEM_CFG, SLAVE_=
IPA_CFG, SLAVE_CNOC_MNOC_CFG, SLAVE_PCIE_0_CFG, SLAVE_PCIE_1_CFG, SLAVE_PDM=
, SLAVE_SOUTH_PHY_CFG, SLAVE_PIMEM_CFG, SLAVE_PRNG, SLAVE_QDSS_CFG, SLAVE_B=
LSP_2, SLAVE_BLSP_1, SLAVE_SDCC_2, SLAVE_SDCC_4, SLAVE_SNOC_CFG, SLAVE_SPDM=
_WRAPPER, SLAVE_SPSS_CFG, SLAVE_TCSR, SLAVE_TLMM_NORTH, SLAVE_TLMM_SOUTH, S=
LAVE_TSIF, SLAVE_UFS_CARD_CFG, SLAVE_UFS_MEM_CFG, SLAVE_USB3_0, SLAVE_USB3_=
1, SLAVE_VENUS_CFG, SLAVE_VSENSE_CTRL_CFG, SLAVE_SERVICE_CNOC);
-DEFINE_QNODE(xm_qdss_dap, MASTER_QDSS_DAP, 1, 8, 43, SLAVE_A1NOC_CFG, SLAV=
E_A2NOC_CFG, SLAVE_AOP, SLAVE_AOSS, SLAVE_CAMERA_CFG, SLAVE_CLK_CTL, SLAVE_=
CDSP_CFG, SLAVE_RBCPR_CX_CFG, SLAVE_CRYPTO_0_CFG, SLAVE_DCC_CFG, SLAVE_CNOC=
_DDRSS, SLAVE_DISPLAY_CFG, SLAVE_GLM, SLAVE_GFX3D_CFG, SLAVE_IMEM_CFG, SLAV=
E_IPA_CFG, SLAVE_CNOC_MNOC_CFG, SLAVE_PCIE_0_CFG, SLAVE_PCIE_1_CFG, SLAVE_P=
DM, SLAVE_SOUTH_PHY_CFG, SLAVE_PIMEM_CFG, SLAVE_PRNG, SLAVE_QDSS_CFG, SLAVE=
_BLSP_2, SLAVE_BLSP_1, SLAVE_SDCC_2, SLAVE_SDCC_4, SLAVE_SNOC_CFG, SLAVE_SP=
DM_WRAPPER, SLAVE_SPSS_CFG, SLAVE_TCSR, SLAVE_TLMM_NORTH, SLAVE_TLMM_SOUTH,=
 SLAVE_TSIF, SLAVE_UFS_CARD_CFG, SLAVE_UFS_MEM_CFG, SLAVE_USB3_0, SLAVE_USB=
3_1, SLAVE_VENUS_CFG, SLAVE_VSENSE_CTRL_CFG, SLAVE_CNOC_A2NOC, SLAVE_SERVIC=
E_CNOC);
-DEFINE_QNODE(qhm_cnoc, MASTER_CNOC_DC_NOC, 1, 4, 2, SLAVE_LLCC_CFG, SLAVE_=
MEM_NOC_CFG);
-DEFINE_QNODE(acm_l3, MASTER_APPSS_PROC, 1, 16, 3, SLAVE_GNOC_SNOC, SLAVE_G=
NOC_MEM_NOC, SLAVE_SERVICE_GNOC);
-DEFINE_QNODE(pm_gnoc_cfg, MASTER_GNOC_CFG, 1, 4, 1, SLAVE_SERVICE_GNOC);
-DEFINE_QNODE(llcc_mc, MASTER_LLCC, 4, 4, 1, SLAVE_EBI1);
-DEFINE_QNODE(acm_tcu, MASTER_TCU_0, 1, 8, 3, SLAVE_MEM_NOC_GNOC, SLAVE_LLC=
C, SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_memnoc_cfg, MASTER_MEM_NOC_CFG, 1, 4, 2, SLAVE_MSS_PROC_M=
S_MPU_CFG, SLAVE_SERVICE_MEM_NOC);
-DEFINE_QNODE(qnm_apps, MASTER_GNOC_MEM_NOC, 2, 32, 1, SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_hf, MASTER_MNOC_HF_MEM_NOC, 2, 32, 2, SLAVE_MEM_NOC_=
GNOC, SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, MASTER_MNOC_SF_MEM_NOC, 1, 32, 3, SLAVE_MEM_NOC_=
GNOC, SLAVE_LLCC, SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, MASTER_SNOC_GC_MEM_NOC, 1, 8, 1, SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, MASTER_SNOC_SF_MEM_NOC, 1, 16, 2, SLAVE_MEM_NOC_=
GNOC, SLAVE_LLCC);
-DEFINE_QNODE(qxm_gpu, MASTER_GFX3D, 2, 32, 3, SLAVE_MEM_NOC_GNOC, SLAVE_LL=
CC, SLAVE_MEM_NOC_SNOC);
-DEFINE_QNODE(qhm_mnoc_cfg, MASTER_CNOC_MNOC_CFG, 1, 4, 1, SLAVE_SERVICE_MN=
OC);
-DEFINE_QNODE(qxm_camnoc_hf0, MASTER_CAMNOC_HF0, 1, 32, 1, SLAVE_MNOC_HF_ME=
M_NOC);
-DEFINE_QNODE(qxm_camnoc_hf1, MASTER_CAMNOC_HF1, 1, 32, 1, SLAVE_MNOC_HF_ME=
M_NOC);
-DEFINE_QNODE(qxm_camnoc_sf, MASTER_CAMNOC_SF, 1, 32, 1, SLAVE_MNOC_SF_MEM_=
NOC);
-DEFINE_QNODE(qxm_mdp0, MASTER_MDP0, 1, 32, 1, SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, MASTER_MDP1, 1, 32, 1, SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, MASTER_ROTATOR, 1, 32, 1, SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus0, MASTER_VIDEO_P0, 1, 32, 1, SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus1, MASTER_VIDEO_P1, 1, 32, 1, SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_venus_arm9, MASTER_VIDEO_PROC, 1, 8, 1, SLAVE_MNOC_SF_MEM=
_NOC);
-DEFINE_QNODE(qhm_snoc_cfg, MASTER_SNOC_CFG, 1, 4, 1, SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, MASTER_A1NOC_SNOC, 1, 16, 6, SLAVE_APPSS, SLA=
VE_SNOC_CNOC, SLAVE_SNOC_MEM_NOC_SF, SLAVE_IMEM, SLAVE_PIMEM, SLAVE_QDSS_ST=
M);
-DEFINE_QNODE(qnm_aggre2_noc, MASTER_A2NOC_SNOC, 1, 16, 9, SLAVE_APPSS, SLA=
VE_SNOC_CNOC, SLAVE_SNOC_MEM_NOC_SF, SLAVE_IMEM, SLAVE_PCIE_0, SLAVE_PCIE_1=
, SLAVE_PIMEM, SLAVE_QDSS_STM, SLAVE_TCU);
-DEFINE_QNODE(qnm_gladiator_sodv, MASTER_GNOC_SNOC, 1, 8, 8, SLAVE_APPSS, S=
LAVE_SNOC_CNOC, SLAVE_IMEM, SLAVE_PCIE_0, SLAVE_PCIE_1, SLAVE_PIMEM, SLAVE_=
QDSS_STM, SLAVE_TCU);
-DEFINE_QNODE(qnm_memnoc, MASTER_MEM_NOC_SNOC, 1, 8, 5, SLAVE_APPSS, SLAVE_=
SNOC_CNOC, SLAVE_IMEM, SLAVE_PIMEM, SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_pcie_anoc, MASTER_ANOC_PCIE_SNOC, 1, 16, 5, SLAVE_APPSS, =
SLAVE_SNOC_CNOC, SLAVE_SNOC_MEM_NOC_SF, SLAVE_IMEM, SLAVE_QDSS_STM);
-DEFINE_QNODE(qxm_pimem, MASTER_PIMEM, 1, 8, 2, SLAVE_SNOC_MEM_NOC_GC, SLAV=
E_IMEM);
-DEFINE_QNODE(xm_gic, MASTER_GIC, 1, 8, 2, SLAVE_SNOC_MEM_NOC_GC, SLAVE_IME=
M);
-DEFINE_QNODE(qns_a1noc_snoc, SLAVE_A1NOC_SNOC, 1, 16, 1, MASTER_A1NOC_SNOC=
);
-DEFINE_QNODE(srvc_aggre1_noc, SLAVE_SERVICE_A1NOC, 1, 4, 0);
-DEFINE_QNODE(qns_pcie_a1noc_snoc, SLAVE_ANOC_PCIE_A1NOC_SNOC, 1, 16, 1, MA=
STER_ANOC_PCIE_SNOC);
-DEFINE_QNODE(qns_a2noc_snoc, SLAVE_A2NOC_SNOC, 1, 16, 1, MASTER_A2NOC_SNOC=
);
-DEFINE_QNODE(qns_pcie_snoc, SLAVE_ANOC_PCIE_SNOC, 1, 16, 1, MASTER_ANOC_PC=
IE_SNOC);
-DEFINE_QNODE(srvc_aggre2_noc, SLAVE_SERVICE_A2NOC, 1, 4, 0);
-DEFINE_QNODE(qns_camnoc_uncomp, SLAVE_CAMNOC_UNCOMP, 1, 32, 0);
-DEFINE_QNODE(qhs_a1_noc_cfg, SLAVE_A1NOC_CFG, 1, 4, 1, MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SLAVE_A2NOC_CFG, 1, 4, 1, MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_aop, SLAVE_AOP, 1, 4, 0);
-DEFINE_QNODE(qhs_aoss, SLAVE_AOSS, 1, 4, 0);
-DEFINE_QNODE(qhs_camera_cfg, SLAVE_CAMERA_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_clk_ctl, SLAVE_CLK_CTL, 1, 4, 0);
-DEFINE_QNODE(qhs_compute_dsp_cfg, SLAVE_CDSP_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_cpr_cx, SLAVE_RBCPR_CX_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_crypto0_cfg, SLAVE_CRYPTO_0_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_dcc_cfg, SLAVE_DCC_CFG, 1, 4, 1, MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_ddrss_cfg, SLAVE_CNOC_DDRSS, 1, 4, 0);
-DEFINE_QNODE(qhs_display_cfg, SLAVE_DISPLAY_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_glm, SLAVE_GLM, 1, 4, 0);
-DEFINE_QNODE(qhs_gpuss_cfg, SLAVE_GFX3D_CFG, 1, 8, 0);
-DEFINE_QNODE(qhs_imem_cfg, SLAVE_IMEM_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_ipa, SLAVE_IPA_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_mnoc_cfg, SLAVE_CNOC_MNOC_CFG, 1, 4, 1, MASTER_CNOC_MNOC_=
CFG);
-DEFINE_QNODE(qhs_pcie0_cfg, SLAVE_PCIE_0_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_pcie_gen3_cfg, SLAVE_PCIE_1_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_pdm, SLAVE_PDM, 1, 4, 0);
-DEFINE_QNODE(qhs_phy_refgen_south, SLAVE_SOUTH_PHY_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_pimem_cfg, SLAVE_PIMEM_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_prng, SLAVE_PRNG, 1, 4, 0);
-DEFINE_QNODE(qhs_qdss_cfg, SLAVE_QDSS_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_qupv3_north, SLAVE_BLSP_2, 1, 4, 0);
-DEFINE_QNODE(qhs_qupv3_south, SLAVE_BLSP_1, 1, 4, 0);
-DEFINE_QNODE(qhs_sdc2, SLAVE_SDCC_2, 1, 4, 0);
-DEFINE_QNODE(qhs_sdc4, SLAVE_SDCC_4, 1, 4, 0);
-DEFINE_QNODE(qhs_snoc_cfg, SLAVE_SNOC_CFG, 1, 4, 1, MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_spdm, SLAVE_SPDM_WRAPPER, 1, 4, 0);
-DEFINE_QNODE(qhs_spss_cfg, SLAVE_SPSS_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_tcsr, SLAVE_TCSR, 1, 4, 0);
-DEFINE_QNODE(qhs_tlmm_north, SLAVE_TLMM_NORTH, 1, 4, 0);
-DEFINE_QNODE(qhs_tlmm_south, SLAVE_TLMM_SOUTH, 1, 4, 0);
-DEFINE_QNODE(qhs_tsif, SLAVE_TSIF, 1, 4, 0);
-DEFINE_QNODE(qhs_ufs_card_cfg, SLAVE_UFS_CARD_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SLAVE_UFS_MEM_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_usb3_0, SLAVE_USB3_0, 1, 4, 0);
-DEFINE_QNODE(qhs_usb3_1, SLAVE_USB3_1, 1, 4, 0);
-DEFINE_QNODE(qhs_venus_cfg, SLAVE_VENUS_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SLAVE_VSENSE_CTRL_CFG, 1, 4, 0);
-DEFINE_QNODE(qns_cnoc_a2noc, SLAVE_CNOC_A2NOC, 1, 8, 1, MASTER_CNOC_A2NOC);
-DEFINE_QNODE(srvc_cnoc, SLAVE_SERVICE_CNOC, 1, 4, 0);
-DEFINE_QNODE(qhs_llcc, SLAVE_LLCC_CFG, 1, 4, 0);
-DEFINE_QNODE(qhs_memnoc, SLAVE_MEM_NOC_CFG, 1, 4, 1, MASTER_MEM_NOC_CFG);
-DEFINE_QNODE(qns_gladiator_sodv, SLAVE_GNOC_SNOC, 1, 8, 1, MASTER_GNOC_SNO=
C);
-DEFINE_QNODE(qns_gnoc_memnoc, SLAVE_GNOC_MEM_NOC, 2, 32, 1, MASTER_GNOC_ME=
M_NOC);
-DEFINE_QNODE(srvc_gnoc, SLAVE_SERVICE_GNOC, 1, 4, 0);
-DEFINE_QNODE(ebi, SLAVE_EBI1, 4, 4, 0);
-DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4, 0);
-DEFINE_QNODE(qns_apps_io, SLAVE_MEM_NOC_GNOC, 1, 32, 0);
-DEFINE_QNODE(qns_llcc, SLAVE_LLCC, 4, 16, 1, MASTER_LLCC);
-DEFINE_QNODE(qns_memnoc_snoc, SLAVE_MEM_NOC_SNOC, 1, 8, 1, MASTER_MEM_NOC_=
SNOC);
-DEFINE_QNODE(srvc_memnoc, SLAVE_SERVICE_MEM_NOC, 1, 4, 0);
-DEFINE_QNODE(qns2_mem_noc, SLAVE_MNOC_SF_MEM_NOC, 1, 32, 1, MASTER_MNOC_SF=
_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_hf, SLAVE_MNOC_HF_MEM_NOC, 2, 32, 1, MASTER_MNOC_=
HF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SLAVE_SERVICE_MNOC, 1, 4, 0);
-DEFINE_QNODE(qhs_apss, SLAVE_APPSS, 1, 8, 0);
-DEFINE_QNODE(qns_cnoc, SLAVE_SNOC_CNOC, 1, 8, 1, MASTER_SNOC_CNOC);
-DEFINE_QNODE(qns_memnoc_gc, SLAVE_SNOC_MEM_NOC_GC, 1, 8, 1, MASTER_SNOC_GC=
_MEM_NOC);
-DEFINE_QNODE(qns_memnoc_sf, SLAVE_SNOC_MEM_NOC_SF, 1, 16, 1, MASTER_SNOC_S=
F_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SLAVE_IMEM, 1, 8, 0);
-DEFINE_QNODE(qxs_pcie, SLAVE_PCIE_0, 1, 8, 0);
-DEFINE_QNODE(qxs_pcie_gen3, SLAVE_PCIE_1, 1, 8, 0);
-DEFINE_QNODE(qxs_pimem, SLAVE_PIMEM, 1, 8, 0);
-DEFINE_QNODE(srvc_snoc, SLAVE_SERVICE_SNOC, 1, 4, 0);
-DEFINE_QNODE(xs_qdss_stm, SLAVE_QDSS_STM, 1, 4, 0);
-DEFINE_QNODE(xs_sys_tcu_cfg, SLAVE_TCU, 1, 8, 0);
-
-#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)	\
-		static struct qcom_icc_bcm _name =3D {			\
-		.name =3D _bcmname,					\
-		.keepalive =3D _keepalive,				\
-		.num_nodes =3D _numnodes,					\
-		.nodes =3D { __VA_ARGS__ },				\
-	}
+static struct qcom_icc_bcm *aggre2_noc_bcms[] =3D {
+	&bcm_ce0,
+	&bcm_sn11,
+	&bcm_qup0,
+};
=20
-DEFINE_QBCM(bcm_acv, "ACV", false, 1, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, 1, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, 1, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", false, 1, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_sh1, "SH1", false, 1, &qns_apps_io);
-DEFINE_QBCM(bcm_mm1, "MM1", false, 7, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_=
hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_m=
dp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, 1, &qns_memnoc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, 1, &qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, 1, &acm_tcu);
-DEFINE_QBCM(bcm_mm3, "MM3", false, 5, &qxm_camnoc_sf, &qxm_rot, &qxm_venus=
0, &qxm_venus1, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh5, "SH5", false, 1, &qnm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, 1, &qns_memnoc_sf);
-DEFINE_QBCM(bcm_ce0, "CE0", false, 1, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", false, 47, &qhm_spdm, &qhm_tic, &qnm_snoc, &xm=
_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_aop, &qhs_aoss, &qhs_came=
ra_cfg, &qhs_clk_ctl, &qhs_compute_dsp_cfg, &qhs_cpr_cx, &qhs_crypto0_cfg, =
&qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_glm, &qhs_gpuss_cfg, &=
qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_pcie0_cfg, &qhs_pcie_gen3_cfg, =
&qhs_pdm, &qhs_phy_refgen_south, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, =
&qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &q=
hs_spdm, &qhs_spss_cfg, &qhs_tcsr, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_t=
sif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_ve=
nus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, 2, &qhm_qup1, &qhm_qup2);
-DEFINE_QBCM(bcm_sn1, "SN1", false, 1, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, 1, &qns_memnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, 1, &qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, 1, &qxm_pimem);
-DEFINE_QBCM(bcm_sn5, "SN5", false, 1, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn6, "SN6", false, 3, &qhs_apss, &srvc_snoc, &xs_sys_tcu_c=
fg);
-DEFINE_QBCM(bcm_sn7, "SN7", false, 1, &qxs_pcie);
-DEFINE_QBCM(bcm_sn8, "SN8", false, 1, &qxs_pcie_gen3);
-DEFINE_QBCM(bcm_sn9, "SN9", false, 2, &srvc_aggre1_noc, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, 2, &srvc_aggre2_noc, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, 2, &qnm_gladiator_sodv, &xm_gic);
-DEFINE_QBCM(bcm_sn14, "SN14", false, 1, &qnm_pcie_anoc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, 1, &qnm_memnoc);
-
-static struct qcom_icc_node *rsc_hlos_nodes[] =3D {
-	[MASTER_APPSS_PROC] =3D &acm_l3,
-	[MASTER_TCU_0] =3D &acm_tcu,
-	[MASTER_LLCC] =3D &llcc_mc,
-	[MASTER_GNOC_CFG] =3D &pm_gnoc_cfg,
-	[MASTER_A1NOC_CFG] =3D &qhm_a1noc_cfg,
+static struct qcom_icc_node *aggre2_noc_nodes[] =3D {
 	[MASTER_A2NOC_CFG] =3D &qhm_a2noc_cfg,
-	[MASTER_CNOC_DC_NOC] =3D &qhm_cnoc,
-	[MASTER_MEM_NOC_CFG] =3D &qhm_memnoc_cfg,
-	[MASTER_CNOC_MNOC_CFG] =3D &qhm_mnoc_cfg,
 	[MASTER_QDSS_BAM] =3D &qhm_qdss_bam,
-	[MASTER_BLSP_1] =3D &qhm_qup1,
-	[MASTER_BLSP_2] =3D &qhm_qup2,
-	[MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
-	[MASTER_SPDM] =3D &qhm_spdm,
-	[MASTER_TIC] =3D &qhm_tic,
-	[MASTER_TSIF] =3D &qhm_tsif,
-	[MASTER_A1NOC_SNOC] =3D &qnm_aggre1_noc,
-	[MASTER_A2NOC_SNOC] =3D &qnm_aggre2_noc,
-	[MASTER_GNOC_MEM_NOC] =3D &qnm_apps,
 	[MASTER_CNOC_A2NOC] =3D &qnm_cnoc,
-	[MASTER_GNOC_SNOC] =3D &qnm_gladiator_sodv,
-	[MASTER_MEM_NOC_SNOC] =3D &qnm_memnoc,
-	[MASTER_MNOC_HF_MEM_NOC] =3D &qnm_mnoc_hf,
-	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
-	[MASTER_ANOC_PCIE_SNOC] =3D &qnm_pcie_anoc,
-	[MASTER_SNOC_CNOC] =3D &qnm_snoc,
-	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
-	[MASTER_SNOC_SF_MEM_NOC] =3D &qnm_snoc_sf,
-	[MASTER_CAMNOC_HF0] =3D &qxm_camnoc_hf0,
-	[MASTER_CAMNOC_HF0_UNCOMP] =3D &qxm_camnoc_hf0_uncomp,
-	[MASTER_CAMNOC_HF1] =3D &qxm_camnoc_hf1,
-	[MASTER_CAMNOC_HF1_UNCOMP] =3D &qxm_camnoc_hf1_uncomp,
-	[MASTER_CAMNOC_SF] =3D &qxm_camnoc_sf,
-	[MASTER_CAMNOC_SF_UNCOMP] =3D &qxm_camnoc_sf_uncomp,
 	[MASTER_CRYPTO] =3D &qxm_crypto,
-	[MASTER_GFX3D] =3D &qxm_gpu,
 	[MASTER_IPA] =3D &qxm_ipa,
-	[MASTER_MDP0] =3D &qxm_mdp0,
-	[MASTER_MDP1] =3D &qxm_mdp1,
-	[MASTER_PIMEM] =3D &qxm_pimem,
-	[MASTER_ROTATOR] =3D &qxm_rot,
-	[MASTER_VIDEO_P0] =3D &qxm_venus0,
-	[MASTER_VIDEO_P1] =3D &qxm_venus1,
-	[MASTER_VIDEO_PROC] =3D &qxm_venus_arm9,
-	[MASTER_GIC] =3D &xm_gic,
 	[MASTER_PCIE_1] =3D &xm_pcie3_1,
-	[MASTER_PCIE_0] =3D &xm_pcie_0,
-	[MASTER_QDSS_DAP] =3D &xm_qdss_dap,
 	[MASTER_QDSS_ETR] =3D &xm_qdss_etr,
-	[MASTER_SDCC_2] =3D &xm_sdc2,
-	[MASTER_SDCC_4] =3D &xm_sdc4,
-	[MASTER_UFS_CARD] =3D &xm_ufs_card,
-	[MASTER_UFS_MEM] =3D &xm_ufs_mem,
 	[MASTER_USB3_0] =3D &xm_usb3_0,
 	[MASTER_USB3_1] =3D &xm_usb3_1,
-	[SLAVE_EBI1] =3D &ebi,
+	[SLAVE_A2NOC_SNOC] =3D &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_SNOC] =3D &qns_pcie_snoc,
+	[SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
+};
+
+const static struct qcom_icc_desc sdm845_aggre2_noc =3D {
+	.nodes =3D aggre2_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms =3D aggre2_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] =3D {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] =3D {
+	[MASTER_SPDM] =3D &qhm_spdm,
+	[MASTER_TIC] =3D &qhm_tic,
+	[MASTER_SNOC_CNOC] =3D &qnm_snoc,
+	[MASTER_QDSS_DAP] =3D &xm_qdss_dap,
 	[SLAVE_A1NOC_CFG] =3D &qhs_a1_noc_cfg,
 	[SLAVE_A2NOC_CFG] =3D &qhs_a2_noc_cfg,
 	[SLAVE_AOP] =3D &qhs_aop,
 	[SLAVE_AOSS] =3D &qhs_aoss,
-	[SLAVE_APPSS] =3D &qhs_apss,
 	[SLAVE_CAMERA_CFG] =3D &qhs_camera_cfg,
 	[SLAVE_CLK_CTL] =3D &qhs_clk_ctl,
 	[SLAVE_CDSP_CFG] =3D &qhs_compute_dsp_cfg,
@@ -386,9 +384,6 @@ static struct qcom_icc_node *rsc_hlos_nodes[] =3D {
 	[SLAVE_GFX3D_CFG] =3D &qhs_gpuss_cfg,
 	[SLAVE_IMEM_CFG] =3D &qhs_imem_cfg,
 	[SLAVE_IPA_CFG] =3D &qhs_ipa,
-	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
-	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &qhs_mdsp_ms_mpu_cfg,
-	[SLAVE_MEM_NOC_CFG] =3D &qhs_memnoc,
 	[SLAVE_CNOC_MNOC_CFG] =3D &qhs_mnoc_cfg,
 	[SLAVE_PCIE_0_CFG] =3D &qhs_pcie0_cfg,
 	[SLAVE_PCIE_1_CFG] =3D &qhs_pcie_gen3_cfg,
@@ -414,53 +409,122 @@ static struct qcom_icc_node *rsc_hlos_nodes[] =3D {
 	[SLAVE_USB3_1] =3D &qhs_usb3_1,
 	[SLAVE_VENUS_CFG] =3D &qhs_venus_cfg,
 	[SLAVE_VSENSE_CTRL_CFG] =3D &qhs_vsense_ctrl_cfg,
-	[SLAVE_MNOC_SF_MEM_NOC] =3D &qns2_mem_noc,
-	[SLAVE_A1NOC_SNOC] =3D &qns_a1noc_snoc,
-	[SLAVE_A2NOC_SNOC] =3D &qns_a2noc_snoc,
-	[SLAVE_MEM_NOC_GNOC] =3D &qns_apps_io,
-	[SLAVE_CAMNOC_UNCOMP] =3D &qns_camnoc_uncomp,
-	[SLAVE_SNOC_CNOC] =3D &qns_cnoc,
 	[SLAVE_CNOC_A2NOC] =3D &qns_cnoc_a2noc,
+	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
+};
+
+const static struct qcom_icc_desc sdm845_config_noc =3D {
+	.nodes =3D config_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(config_noc_nodes),
+	.bcms =3D config_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm *dc_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] =3D {
+	[MASTER_CNOC_DC_NOC] =3D &qhm_cnoc,
+	[SLAVE_LLCC_CFG] =3D &qhs_llcc,
+	[SLAVE_MEM_NOC_CFG] =3D &qhs_memnoc,
+};
+
+const static struct qcom_icc_desc sdm845_dc_noc =3D {
+	.nodes =3D dc_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(dc_noc_nodes),
+	.bcms =3D dc_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm *gladiator_noc_bcms[] =3D {
+};
+
+static struct qcom_icc_node *gladiator_noc_nodes[] =3D {
+	[MASTER_APPSS_PROC] =3D &acm_l3,
+	[MASTER_GNOC_CFG] =3D &pm_gnoc_cfg,
 	[SLAVE_GNOC_SNOC] =3D &qns_gladiator_sodv,
 	[SLAVE_GNOC_MEM_NOC] =3D &qns_gnoc_memnoc,
-	[SLAVE_LLCC] =3D &qns_llcc,
-	[SLAVE_MNOC_HF_MEM_NOC] =3D &qns_mem_noc_hf,
-	[SLAVE_SNOC_MEM_NOC_GC] =3D &qns_memnoc_gc,
-	[SLAVE_SNOC_MEM_NOC_SF] =3D &qns_memnoc_sf,
-	[SLAVE_MEM_NOC_SNOC] =3D &qns_memnoc_snoc,
-	[SLAVE_ANOC_PCIE_A1NOC_SNOC] =3D &qns_pcie_a1noc_snoc,
-	[SLAVE_ANOC_PCIE_SNOC] =3D &qns_pcie_snoc,
-	[SLAVE_IMEM] =3D &qxs_imem,
-	[SLAVE_PCIE_0] =3D &qxs_pcie,
-	[SLAVE_PCIE_1] =3D &qxs_pcie_gen3,
-	[SLAVE_PIMEM] =3D &qxs_pimem,
-	[SLAVE_SERVICE_A1NOC] =3D &srvc_aggre1_noc,
-	[SLAVE_SERVICE_A2NOC] =3D &srvc_aggre2_noc,
-	[SLAVE_SERVICE_CNOC] =3D &srvc_cnoc,
 	[SLAVE_SERVICE_GNOC] =3D &srvc_gnoc,
-	[SLAVE_SERVICE_MEM_NOC] =3D &srvc_memnoc,
-	[SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
-	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
-	[SLAVE_QDSS_STM] =3D &xs_qdss_stm,
-	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
 };
=20
-static struct qcom_icc_bcm *rsc_hlos_bcms[] =3D {
-	&bcm_acv,
+const static struct qcom_icc_desc sdm845_gladiator_noc =3D {
+	.nodes =3D gladiator_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(gladiator_noc_nodes),
+	.bcms =3D gladiator_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(gladiator_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mem_noc_bcms[] =3D {
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
+static struct qcom_icc_node *mem_noc_nodes[] =3D {
+	[MASTER_TCU_0] =3D &acm_tcu,
+	[MASTER_MEM_NOC_CFG] =3D &qhm_memnoc_cfg,
+	[MASTER_GNOC_MEM_NOC] =3D &qnm_apps,
+	[MASTER_MNOC_HF_MEM_NOC] =3D &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] =3D &qnm_mnoc_sf,
+	[MASTER_SNOC_GC_MEM_NOC] =3D &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] =3D &qnm_snoc_sf,
+	[MASTER_GFX3D] =3D &qxm_gpu,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] =3D &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_MEM_NOC_GNOC] =3D &qns_apps_io,
+	[SLAVE_LLCC] =3D &qns_llcc,
+	[SLAVE_MEM_NOC_SNOC] =3D &qns_memnoc_snoc,
+	[SLAVE_SERVICE_MEM_NOC] =3D &srvc_memnoc,
+	[MASTER_LLCC] =3D &llcc_mc,
+	[SLAVE_EBI1] =3D &ebi,
+};
+
+const static struct qcom_icc_desc sdm845_mem_noc =3D {
+	.nodes =3D mem_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mem_noc_nodes),
+	.bcms =3D mem_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] =3D {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] =3D {
+	[MASTER_CNOC_MNOC_CFG] =3D &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF0] =3D &qxm_camnoc_hf0,
+	[MASTER_CAMNOC_HF1] =3D &qxm_camnoc_hf1,
+	[MASTER_CAMNOC_SF] =3D &qxm_camnoc_sf,
+	[MASTER_MDP0] =3D &qxm_mdp0,
+	[MASTER_MDP1] =3D &qxm_mdp1,
+	[MASTER_ROTATOR] =3D &qxm_rot,
+	[MASTER_VIDEO_P0] =3D &qxm_venus0,
+	[MASTER_VIDEO_P1] =3D &qxm_venus1,
+	[MASTER_VIDEO_PROC] =3D &qxm_venus_arm9,
+	[SLAVE_MNOC_SF_MEM_NOC] =3D &qns2_mem_noc,
+	[SLAVE_MNOC_HF_MEM_NOC] =3D &qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC] =3D &srvc_mnoc,
+	[MASTER_CAMNOC_HF0_UNCOMP] =3D &qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_HF1_UNCOMP] =3D &qxm_camnoc_hf1_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] =3D &qxm_camnoc_sf_uncomp,
+	[SLAVE_CAMNOC_UNCOMP] =3D &qns_camnoc_uncomp,
+};
+
+const static struct qcom_icc_desc sdm845_mmss_noc =3D {
+	.nodes =3D mmss_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(mmss_noc_nodes),
+	.bcms =3D mmss_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] =3D {
 	&bcm_sn0,
-	&bcm_ce0,
-	&bcm_cn0,
-	&bcm_qup0,
 	&bcm_sn1,
 	&bcm_sn2,
 	&bcm_sn3,
@@ -476,297 +540,34 @@ static struct qcom_icc_bcm *rsc_hlos_bcms[] =3D {
 	&bcm_sn15,
 };
=20
-static struct qcom_icc_desc sdm845_rsc_hlos =3D {
-	.nodes =3D rsc_hlos_nodes,
-	.num_nodes =3D ARRAY_SIZE(rsc_hlos_nodes),
-	.bcms =3D rsc_hlos_bcms,
-	.num_bcms =3D ARRAY_SIZE(rsc_hlos_bcms),
+static struct qcom_icc_node *system_noc_nodes[] =3D {
+	[MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
+	[MASTER_A1NOC_SNOC] =3D &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] =3D &qnm_aggre2_noc,
+	[MASTER_GNOC_SNOC] =3D &qnm_gladiator_sodv,
+	[MASTER_MEM_NOC_SNOC] =3D &qnm_memnoc,
+	[MASTER_ANOC_PCIE_SNOC] =3D &qnm_pcie_anoc,
+	[MASTER_PIMEM] =3D &qxm_pimem,
+	[MASTER_GIC] =3D &xm_gic,
+	[SLAVE_APPSS] =3D &qhs_apss,
+	[SLAVE_SNOC_CNOC] =3D &qns_cnoc,
+	[SLAVE_SNOC_MEM_NOC_GC] =3D &qns_memnoc_gc,
+	[SLAVE_SNOC_MEM_NOC_SF] =3D &qns_memnoc_sf,
+	[SLAVE_IMEM] =3D &qxs_imem,
+	[SLAVE_PCIE_0] =3D &qxs_pcie,
+	[SLAVE_PCIE_1] =3D &qxs_pcie_gen3,
+	[SLAVE_PIMEM] =3D &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
+	[SLAVE_QDSS_STM] =3D &xs_qdss_stm,
+	[SLAVE_TCU] =3D &xs_sys_tcu_cfg,
 };
=20
-static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
-{
-	struct qcom_icc_node *qn;
-	const struct bcm_db *data;
-	size_t data_count;
-	int i;
-
-	bcm->addr =3D cmd_db_read_addr(bcm->name);
-	if (!bcm->addr) {
-		dev_err(dev, "%s could not find RPMh address\n",
-			bcm->name);
-		return -EINVAL;
-	}
-
-	data =3D cmd_db_read_aux_data(bcm->name, &data_count);
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
-	bcm->aux_data.unit =3D le32_to_cpu(data->unit);
-	bcm->aux_data.width =3D le16_to_cpu(data->width);
-	bcm->aux_data.vcd =3D data->vcd;
-	bcm->aux_data.reserved =3D data->reserved;
-
-	/*
-	 * Link Qnodes to their respective BCMs
-	 */
-	for (i =3D 0; i < bcm->num_nodes; i++) {
-		qn =3D bcm->nodes[i];
-		qn->bcms[qn->num_bcms] =3D bcm;
-		qn->num_bcms++;
-	}
-
-	return 0;
-}
-
-inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
-			u32 addr, bool commit)
-{
-	bool valid =3D true;
-
-	if (!cmd)
-		return;
-
-	if (vote_x =3D=3D 0 && vote_y =3D=3D 0)
-		valid =3D false;
-
-	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
-		vote_x =3D BCM_TCS_CMD_VOTE_MASK;
-
-	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
-		vote_y =3D BCM_TCS_CMD_VOTE_MASK;
-
-	cmd->addr =3D addr;
-	cmd->data =3D BCM_TCS_CMD(commit, valid, vote_x, vote_y);
-
-	/*
-	 * Set the wait for completion flag on command that need to be completed
-	 * before the next command.
-	 */
-	if (commit)
-		cmd->wait =3D true;
-}
-
-static void tcs_list_gen(struct list_head *bcm_list, int bucket,
-			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
-			 int n[SDM845_MAX_VCD])
-{
-	struct qcom_icc_bcm *bcm;
-	bool commit;
-	size_t idx =3D 0, batch =3D 0, cur_vcd_size =3D 0;
-
-	memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
-
-	list_for_each_entry(bcm, bcm_list, list) {
-		commit =3D false;
-		cur_vcd_size++;
-		if ((list_is_last(&bcm->list, bcm_list)) ||
-		    bcm->aux_data.vcd !=3D list_next_entry(bcm, list)->aux_data.vcd) {
-			commit =3D true;
-			cur_vcd_size =3D 0;
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
-		if (n[batch] >=3D MAX_RPMH_PAYLOAD) {
-			if (!commit) {
-				n[batch] -=3D cur_vcd_size;
-				n[batch + 1] =3D cur_vcd_size;
-			}
-			batch++;
-		}
-	}
-}
-
-static void bcm_aggregate(struct qcom_icc_bcm *bcm)
-{
-	size_t i, bucket;
-	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] =3D {0};
-	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] =3D {0};
-	u64 temp;
-
-	for (bucket =3D 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
-		for (i =3D 0; i < bcm->num_nodes; i++) {
-			temp =3D bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-			agg_avg[bucket] =3D max(agg_avg[bucket], temp);
-
-			temp =3D bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth);
-			agg_peak[bucket] =3D max(agg_peak[bucket], temp);
-		}
-
-		temp =3D agg_avg[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_x[bucket] =3D temp;
-
-		temp =3D agg_peak[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_y[bucket] =3D temp;
-	}
-
-	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] =3D=3D 0 &&
-	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] =3D=3D 0) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] =3D 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] =3D 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] =3D 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] =3D 1;
-	}
-
-	bcm->dirty =3D false;
-}
-
-static void qcom_icc_pre_aggregate(struct icc_node *node)
-{
-	size_t i;
-	struct qcom_icc_node *qn;
-
-	qn =3D node->data;
-
-	for (i =3D 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-		qn->sum_avg[i] =3D 0;
-		qn->max_peak[i] =3D 0;
-	}
-}
-
-static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	size_t i;
-	struct qcom_icc_node *qn;
-
-	qn =3D node->data;
-
-	if (!tag)
-		tag =3D QCOM_ICC_TAG_ALWAYS;
-
-	for (i =3D 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-		if (tag & BIT(i)) {
-			qn->sum_avg[i] +=3D avg_bw;
-			qn->max_peak[i] =3D max_t(u32, qn->max_peak[i], peak_bw);
-		}
-	}
-
-	*agg_avg +=3D avg_bw;
-	*agg_peak =3D max_t(u32, *agg_peak, peak_bw);
-
-	for (i =3D 0; i < qn->num_bcms; i++)
-		qn->bcms[i]->dirty =3D true;
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
-	int ret =3D 0, i;
-
-	if (!src)
-		node =3D dst;
-	else
-		node =3D src;
-
-	qp =3D to_qcom_provider(node->provider);
-
-	INIT_LIST_HEAD(&commit_list);
-
-	for (i =3D 0; i < qp->num_bcms; i++) {
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
-	ret =3D rpmh_invalidate(qp->dev);
-	if (ret) {
-		pr_err("Error invalidating RPMH client (%d)\n", ret);
-		return ret;
-	}
-
-	ret =3D rpmh_write_batch(qp->dev, RPMH_ACTIVE_ONLY_STATE,
-			       cmds, commit_idx);
-	if (ret) {
-		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
-		return ret;
-	}
-
-	INIT_LIST_HEAD(&commit_list);
-
-	for (i =3D 0; i < qp->num_bcms; i++) {
-		/*
-		 * Only generate WAKE and SLEEP commands if a resource's
-		 * requirements change as the execution environment transitions
-		 * between different power states.
-		 */
-		if (qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_WAKE] !=3D
-		    qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
-		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_WAKE] !=3D
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
-	ret =3D rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
-	if (ret) {
-		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
-		return ret;
-	}
-
-	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
-
-	ret =3D rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
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
-	const struct qcom_icc_bcm **l =3D (const struct qcom_icc_bcm **)_l;
-	const struct qcom_icc_bcm **r =3D (const struct qcom_icc_bcm **)_r;
-
-	if (l[0]->aux_data.vcd < r[0]->aux_data.vcd)
-		return -1;
-	else if (l[0]->aux_data.vcd =3D=3D r[0]->aux_data.vcd)
-		return 0;
-	else
-		return 1;
-}
+const static struct qcom_icc_desc sdm845_system_noc =3D {
+	.nodes =3D system_noc_nodes,
+	.num_nodes =3D ARRAY_SIZE(system_noc_nodes),
+	.bcms =3D system_noc_bcms,
+	.num_bcms =3D ARRAY_SIZE(system_noc_bcms),
+};
=20
 static int qnoc_probe(struct platform_device *pdev)
 {
@@ -779,7 +580,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	size_t num_nodes, i;
 	int ret;
=20
-	desc =3D of_device_get_match_data(&pdev->dev);
+	desc =3D device_get_match_data(&pdev->dev);
 	if (!desc)
 		return -EINVAL;
=20
@@ -808,6 +609,12 @@ static int qnoc_probe(struct platform_device *pdev)
 	qp->bcms =3D desc->bcms;
 	qp->num_bcms =3D desc->num_bcms;
=20
+	qp->voter =3D of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter)) {
+		dev_err(&pdev->dev, "bcm_voter err:%ld\n", PTR_ERR(qp->voter));
+		return PTR_ERR(qp->voter);
+	}
+
 	ret =3D icc_provider_add(provider);
 	if (ret) {
 		dev_err(&pdev->dev, "error adding interconnect provider\n");
@@ -817,6 +624,9 @@ static int qnoc_probe(struct platform_device *pdev)
 	for (i =3D 0; i < num_nodes; i++) {
 		size_t j;
=20
+		if (!qnodes[i])
+			continue;
+
 		node =3D icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret =3D PTR_ERR(node);
@@ -827,10 +637,6 @@ static int qnoc_probe(struct platform_device *pdev)
 		node->data =3D qnodes[i];
 		icc_node_add(node, provider);
=20
-		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
-			qnodes[i]->name, node->id);
-
-		/* populate links */
 		for (j =3D 0; j < qnodes[i]->num_links; j++)
 			icc_link_create(node, qnodes[i]->links[j]);
=20
@@ -841,19 +647,9 @@ static int qnoc_probe(struct platform_device *pdev)
 	for (i =3D 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
=20
-	/*
-	 * Pre sort the BCMs based on VCD for ease of generating a command list
-	 * that groups the BCMs with the same VCD together. VCDs are numbered
-	 * with lowest being the most expensive time wise, ensuring that
-	 * those commands are being sent the earliest in the queue.
-	 */
-	sort(qp->bcms, qp->num_bcms, sizeof(*qp->bcms), cmp_vcd, NULL);
-
 	platform_set_drvdata(pdev, qp);
=20
-	dev_dbg(&pdev->dev, "Registered SDM845 ICC\n");
-
-	return ret;
+	return 0;
 err:
 	icc_nodes_remove(provider);
 	icc_provider_del(provider);
@@ -869,8 +665,23 @@ static int qnoc_remove(struct platform_device *pdev)
 }
=20
 static const struct of_device_id qnoc_of_match[] =3D {
-	{ .compatible =3D "qcom,sdm845-rsc-hlos", .data =3D &sdm845_rsc_hlos },
-	{ },
+	{ .compatible =3D "qcom,sdm845-aggre1-noc",
+	  .data =3D &sdm845_aggre1_noc},
+	{ .compatible =3D "qcom,sdm845-aggre2-noc",
+	  .data =3D &sdm845_aggre2_noc},
+	{ .compatible =3D "qcom,sdm845-config-noc",
+	  .data =3D &sdm845_config_noc},
+	{ .compatible =3D "qcom,sdm845-dc-noc",
+	  .data =3D &sdm845_dc_noc},
+	{ .compatible =3D "qcom,sdm845-gladiator-noc",
+	  .data =3D &sdm845_gladiator_noc},
+	{ .compatible =3D "qcom,sdm845-mem-noc",
+	  .data =3D &sdm845_mem_noc},
+	{ .compatible =3D "qcom,sdm845-mmss-noc",
+	  .data =3D &sdm845_mmss_noc},
+	{ .compatible =3D "qcom,sdm845-system-noc",
+	  .data =3D &sdm845_system_noc},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
=20
diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bi=
ndings/interconnect/qcom,sdm845.h
index 7b2393be73619..290be38f40e6b 100644
--- a/include/dt-bindings/interconnect/qcom,sdm845.h
+++ b/include/dt-bindings/interconnect/qcom,sdm845.h
@@ -10,134 +10,139 @@
 #define __DT_BINDINGS_INTERCONNECT_QCOM_SDM845_H
=20
 #define MASTER_A1NOC_CFG		0
-#define MASTER_BLSP_1			1
-#define MASTER_TSIF			2
-#define MASTER_SDCC_2			3
-#define MASTER_SDCC_4			4
-#define MASTER_UFS_CARD			5
-#define MASTER_UFS_MEM			6
-#define MASTER_PCIE_0			7
-#define MASTER_A2NOC_CFG		8
-#define MASTER_QDSS_BAM			9
-#define MASTER_BLSP_2			10
-#define MASTER_CNOC_A2NOC		11
-#define MASTER_CRYPTO			12
-#define MASTER_IPA			13
-#define MASTER_PCIE_1			14
-#define MASTER_QDSS_ETR			15
-#define MASTER_USB3_0			16
-#define MASTER_USB3_1			17
-#define MASTER_CAMNOC_HF0_UNCOMP	18
-#define MASTER_CAMNOC_HF1_UNCOMP	19
-#define MASTER_CAMNOC_SF_UNCOMP		20
-#define MASTER_SPDM			21
-#define MASTER_TIC			22
-#define MASTER_SNOC_CNOC		23
-#define MASTER_QDSS_DAP			24
-#define MASTER_CNOC_DC_NOC		25
-#define MASTER_APPSS_PROC		26
-#define MASTER_GNOC_CFG			27
-#define MASTER_LLCC			28
-#define MASTER_TCU_0			29
-#define MASTER_MEM_NOC_CFG		30
-#define MASTER_GNOC_MEM_NOC		31
-#define MASTER_MNOC_HF_MEM_NOC		32
-#define MASTER_MNOC_SF_MEM_NOC		33
-#define MASTER_SNOC_GC_MEM_NOC		34
-#define MASTER_SNOC_SF_MEM_NOC		35
-#define MASTER_GFX3D			36
-#define MASTER_CNOC_MNOC_CFG		37
-#define MASTER_CAMNOC_HF0		38
-#define MASTER_CAMNOC_HF1		39
-#define MASTER_CAMNOC_SF		40
-#define MASTER_MDP0			41
-#define MASTER_MDP1			42
-#define MASTER_ROTATOR			43
-#define MASTER_VIDEO_P0			44
-#define MASTER_VIDEO_P1			45
-#define MASTER_VIDEO_PROC		46
-#define MASTER_SNOC_CFG			47
-#define MASTER_A1NOC_SNOC		48
-#define MASTER_A2NOC_SNOC		49
-#define MASTER_GNOC_SNOC		50
-#define MASTER_MEM_NOC_SNOC		51
-#define MASTER_ANOC_PCIE_SNOC		52
-#define MASTER_PIMEM			53
-#define MASTER_GIC			54
-#define SLAVE_A1NOC_SNOC		55
-#define SLAVE_SERVICE_A1NOC		56
-#define SLAVE_ANOC_PCIE_A1NOC_SNOC	57
-#define SLAVE_A2NOC_SNOC		58
-#define SLAVE_ANOC_PCIE_SNOC		59
-#define SLAVE_SERVICE_A2NOC		60
-#define SLAVE_CAMNOC_UNCOMP		61
-#define SLAVE_A1NOC_CFG			62
-#define SLAVE_A2NOC_CFG			63
-#define SLAVE_AOP			64
-#define SLAVE_AOSS			65
-#define SLAVE_CAMERA_CFG		66
-#define SLAVE_CLK_CTL			67
-#define SLAVE_CDSP_CFG			68
-#define SLAVE_RBCPR_CX_CFG		69
-#define SLAVE_CRYPTO_0_CFG		70
-#define SLAVE_DCC_CFG			71
-#define SLAVE_CNOC_DDRSS		72
-#define SLAVE_DISPLAY_CFG		73
-#define SLAVE_GLM			74
-#define SLAVE_GFX3D_CFG			75
-#define SLAVE_IMEM_CFG			76
-#define SLAVE_IPA_CFG			77
-#define SLAVE_CNOC_MNOC_CFG		78
-#define SLAVE_PCIE_0_CFG		79
-#define SLAVE_PCIE_1_CFG		80
-#define SLAVE_PDM			81
-#define SLAVE_SOUTH_PHY_CFG		82
-#define SLAVE_PIMEM_CFG			83
-#define SLAVE_PRNG			84
-#define SLAVE_QDSS_CFG			85
-#define SLAVE_BLSP_2			86
-#define SLAVE_BLSP_1			87
-#define SLAVE_SDCC_2			88
-#define SLAVE_SDCC_4			89
-#define SLAVE_SNOC_CFG			90
-#define SLAVE_SPDM_WRAPPER		91
-#define SLAVE_SPSS_CFG			92
-#define SLAVE_TCSR			93
-#define SLAVE_TLMM_NORTH		94
-#define SLAVE_TLMM_SOUTH		95
-#define SLAVE_TSIF			96
-#define SLAVE_UFS_CARD_CFG		97
-#define SLAVE_UFS_MEM_CFG		98
-#define SLAVE_USB3_0			99
-#define SLAVE_USB3_1			100
-#define SLAVE_VENUS_CFG			101
-#define SLAVE_VSENSE_CTRL_CFG		102
-#define SLAVE_CNOC_A2NOC		103
-#define SLAVE_SERVICE_CNOC		104
-#define SLAVE_LLCC_CFG			105
-#define SLAVE_MEM_NOC_CFG		106
-#define SLAVE_GNOC_SNOC			107
-#define SLAVE_GNOC_MEM_NOC		108
-#define SLAVE_SERVICE_GNOC		109
-#define SLAVE_EBI1			110
-#define SLAVE_MSS_PROC_MS_MPU_CFG	111
-#define SLAVE_MEM_NOC_GNOC		112
-#define SLAVE_LLCC			113
-#define SLAVE_MEM_NOC_SNOC		114
-#define SLAVE_SERVICE_MEM_NOC		115
-#define SLAVE_MNOC_SF_MEM_NOC		116
-#define SLAVE_MNOC_HF_MEM_NOC		117
-#define SLAVE_SERVICE_MNOC		118
-#define SLAVE_APPSS			119
-#define SLAVE_SNOC_CNOC			120
-#define SLAVE_SNOC_MEM_NOC_GC		121
-#define SLAVE_SNOC_MEM_NOC_SF		122
-#define SLAVE_IMEM			123
-#define SLAVE_PCIE_0			124
-#define SLAVE_PCIE_1			125
-#define SLAVE_PIMEM			126
-#define SLAVE_SERVICE_SNOC		127
-#define SLAVE_QDSS_STM			128
-#define SLAVE_TCU			129
+#define MASTER_TSIF			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_UFS_CARD			4
+#define MASTER_UFS_MEM			5
+#define MASTER_PCIE_0			6
+#define SLAVE_A1NOC_SNOC		7
+#define SLAVE_SERVICE_A1NOC		8
+#define SLAVE_ANOC_PCIE_A1NOC_SNOC	9
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_CNOC_A2NOC		2
+#define MASTER_CRYPTO			3
+#define MASTER_IPA			4
+#define MASTER_PCIE_1			5
+#define MASTER_QDSS_ETR			6
+#define MASTER_USB3_0			7
+#define MASTER_USB3_1			8
+#define SLAVE_A2NOC_SNOC		9
+#define SLAVE_ANOC_PCIE_SNOC		10
+#define SLAVE_SERVICE_A2NOC		11
+
+#define MASTER_SPDM			0
+#define MASTER_TIC			1
+#define MASTER_SNOC_CNOC		2
+#define MASTER_QDSS_DAP			3
+#define SLAVE_A1NOC_CFG			4
+#define SLAVE_A2NOC_CFG			5
+#define SLAVE_AOP			6
+#define SLAVE_AOSS			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CLK_CTL			9
+#define SLAVE_CDSP_CFG			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_CRYPTO_0_CFG		12
+#define SLAVE_DCC_CFG			13
+#define SLAVE_CNOC_DDRSS		14
+#define SLAVE_DISPLAY_CFG		15
+#define SLAVE_GLM			16
+#define SLAVE_GFX3D_CFG			17
+#define SLAVE_IMEM_CFG			18
+#define SLAVE_IPA_CFG			19
+#define SLAVE_CNOC_MNOC_CFG		20
+#define SLAVE_PCIE_0_CFG		21
+#define SLAVE_PCIE_1_CFG		22
+#define SLAVE_PDM			23
+#define SLAVE_SOUTH_PHY_CFG		24
+#define SLAVE_PIMEM_CFG			25
+#define SLAVE_PRNG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_BLSP_2			28
+#define SLAVE_BLSP_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SDCC_4			31
+#define SLAVE_SNOC_CFG			32
+#define SLAVE_SPDM_WRAPPER		33
+#define SLAVE_SPSS_CFG			34
+#define SLAVE_TCSR			35
+#define SLAVE_TLMM_NORTH		36
+#define SLAVE_TLMM_SOUTH		37
+#define SLAVE_TSIF			38
+#define SLAVE_UFS_CARD_CFG		39
+#define SLAVE_UFS_MEM_CFG		40
+#define SLAVE_USB3_0			41
+#define SLAVE_USB3_1			42
+#define SLAVE_VENUS_CFG			43
+#define SLAVE_VSENSE_CTRL_CFG		44
+#define SLAVE_CNOC_A2NOC		45
+#define SLAVE_SERVICE_CNOC		46
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_MEM_NOC_CFG		2
+
+#define MASTER_APPSS_PROC		0
+#define MASTER_GNOC_CFG			1
+#define SLAVE_GNOC_SNOC			2
+#define SLAVE_GNOC_MEM_NOC		3
+#define SLAVE_SERVICE_GNOC		4
+
+#define MASTER_TCU_0			0
+#define MASTER_MEM_NOC_CFG		1
+#define MASTER_GNOC_MEM_NOC		2
+#define MASTER_MNOC_HF_MEM_NOC		3
+#define MASTER_MNOC_SF_MEM_NOC		4
+#define MASTER_SNOC_GC_MEM_NOC		5
+#define MASTER_SNOC_SF_MEM_NOC		6
+#define MASTER_GFX3D			7
+#define SLAVE_MSS_PROC_MS_MPU_CFG	8
+#define SLAVE_MEM_NOC_GNOC		9
+#define SLAVE_LLCC			10
+#define SLAVE_MEM_NOC_SNOC		11
+#define SLAVE_SERVICE_MEM_NOC		12
+#define MASTER_LLCC			13
+#define SLAVE_EBI1			14
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_HF1		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_MDP0			4
+#define MASTER_MDP1			5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_P1			8
+#define MASTER_VIDEO_PROC		9
+#define SLAVE_MNOC_SF_MEM_NOC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+#define MASTER_CAMNOC_HF0_UNCOMP	13
+#define MASTER_CAMNOC_HF1_UNCOMP	14
+#define MASTER_CAMNOC_SF_UNCOMP		15
+#define SLAVE_CAMNOC_UNCOMP		16
+
+#define MASTER_SNOC_CFG			0
+#define MASTER_A1NOC_SNOC		1
+#define MASTER_A2NOC_SNOC		2
+#define MASTER_GNOC_SNOC		3
+#define MASTER_MEM_NOC_SNOC		4
+#define MASTER_ANOC_PCIE_SNOC		5
+#define MASTER_PIMEM			6
+#define MASTER_GIC			7
+#define SLAVE_APPSS			8
+#define SLAVE_SNOC_CNOC			9
+#define SLAVE_SNOC_MEM_NOC_GC		10
+#define SLAVE_SNOC_MEM_NOC_SF		11
+#define SLAVE_IMEM			12
+#define SLAVE_PCIE_0			13
+#define SLAVE_PCIE_1			14
+#define SLAVE_PIMEM			15
+#define SLAVE_SERVICE_SNOC		16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_TCU			18
=20
 #endif
--=20
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
