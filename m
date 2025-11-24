Return-Path: <linux-pm+bounces-38453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E533C8021F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB9F934629E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F030100E;
	Mon, 24 Nov 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VsGgunsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B63009C0;
	Mon, 24 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982484; cv=pass; b=XcTW86/ydJSzvHfx1FN5O1zXJ3VK4GGliaN/r7uANpgPlDesvrUYKJNO0Knw1VmtJY9XnOBuS7c5sah3V/iHcbi31Mk6dH23ja0+KiwSUxcGJJwVY2pN+sx/NGMfmbkCnPlHQorDHPjdh51/BybIU2FF8YUe7uz22NfaY0M0WGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982484; c=relaxed/simple;
	bh=Nbm0LjUJ9bYWwCAluFgbvjlQ6qTTWggMTbF9jFj41+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X68aQ4qJrtJHwtVdfOrSm39DxBMBDU3oXsvj2XO9xLVYDwE/t6n1T4dp0WkyoXOuxiClWMiqFNRzqx5OWp3XOt9QoVtEurTTEwLS4tSEqSz4QOXtxq6ffTqqazNn6FtoK1usnRsaGTi7AnDC7FJbiz4HrNy1vizGyYfAUxdI5TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=VsGgunsi; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982445; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Quob953s73GUiuQ7CgvCwEEUc379Mua9eNs0ZZmu+R2jxKCigLMJSEU4bzrMFmQsVIssU+8dvvQUVJwmDwp7nxvgnEHLB4NjluQ8AEtKcCvoERDgR5f9ybgb2jS8Nn9m/vuDq4zs2Klpz1e1Hj0Dg5dcWGmxF9V0IphnLR8EKso=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982445; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tntsHTOJbk/7Ofsa7uCJqIORi4NXk3hwDFFtajhXrjs=; 
	b=dBef0eIhuE2R5v40M/qp0WsuRRKRbbgoR2o55JNLPwr0LOA/ssIcZ76oOL2wcT+K9r/57g0EzepqCFmBzATvvHC72/ME8DCz8POG1p5xZa7zRjO9e8LBCLsO5HzIaaOtkVn6MwFNtF6PzrDuiIX5JQYEIiGrI8609wiN2kt4ozU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982445;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=tntsHTOJbk/7Ofsa7uCJqIORi4NXk3hwDFFtajhXrjs=;
	b=VsGgunsidhwqWHoG1ZOxobaFZRTNo19gnCIyakoRqkj7W7tMaOSv60uISNmqazCW
	D3/oVrD16i0oOfzRCl3HdBYzTdNyUyKnhC6KndkFFTaR4dCiP3Toj96KPZdsxIFmyHU
	frI7cX41IT52fvIsAymCUAlbYm0hWLvO8jGAohmE=
Received: by mx.zohomail.com with SMTPS id 1763982443965308.2436263698329;
	Mon, 24 Nov 2025 03:07:23 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:57 +0100
Subject: [PATCH v2 08/13] soc: mediatek: mtk-dvfsrc: Add support for
 DVFSRCv4 and MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-8-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add support for the DVFSRC Version 4 by adding new functions for
vcore/dram levels (in v4, called gears instead), and for readout
of pre-programmed dvfsrc_opp entries, corresponding to each gear.

In the probe function, for v4, the curr_opps is initialized from
the get_hw_opps() function instead of platform data.

In order to make use of the new DVFSRCv4 code, also add support
for the MediaTek MT8196 SoC.

Co-developed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 248 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index bf0e7b01d255..3a83fd4baf54 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -15,11 +15,17 @@
 #include <linux/soc/mediatek/dvfsrc.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 
+/* DVFSRC_BASIC_CONTROL */
+#define DVFSRC_V4_BASIC_CTRL_OPP_COUNT	GENMASK(26, 20)
+
 /* DVFSRC_LEVEL */
 #define DVFSRC_V1_LEVEL_TARGET_LEVEL	GENMASK(15, 0)
 #define DVFSRC_TGT_LEVEL_IDLE		0x00
 #define DVFSRC_V1_LEVEL_CURRENT_LEVEL	GENMASK(31, 16)
 
+#define DVFSRC_V4_LEVEL_TARGET_LEVEL	GENMASK(15, 8)
+#define DVFSRC_V4_LEVEL_TARGET_PRESENT	BIT(16)
+
 /* DVFSRC_SW_REQ, DVFSRC_SW_REQ2 */
 #define DVFSRC_V1_SW_REQ2_DRAM_LEVEL	GENMASK(1, 0)
 #define DVFSRC_V1_SW_REQ2_VCORE_LEVEL	GENMASK(3, 2)
@@ -27,9 +33,23 @@
 #define DVFSRC_V2_SW_REQ_DRAM_LEVEL	GENMASK(3, 0)
 #define DVFSRC_V2_SW_REQ_VCORE_LEVEL	GENMASK(6, 4)
 
+#define DVFSRC_V4_SW_REQ_EMI_LEVEL	GENMASK(3, 0)
+#define DVFSRC_V4_SW_REQ_DRAM_LEVEL	GENMASK(15, 12)
+
 /* DVFSRC_VCORE */
 #define DVFSRC_V2_VCORE_REQ_VSCP_LEVEL	GENMASK(14, 12)
 
+/* DVFSRC_TARGET_GEAR */
+#define DVFSRC_V4_GEAR_TARGET_DRAM	GENMASK(7, 0)
+#define DVFSRC_V4_GEAR_TARGET_VCORE	GENMASK(15, 8)
+
+/* DVFSRC_GEAR_INFO */
+#define DVFSRC_V4_GEAR_INFO_REG_WIDTH	0x4
+#define DVFSRC_V4_GEAR_INFO_REG_LEVELS	64
+#define DVFSRC_V4_GEAR_INFO_VCORE	GENMASK(3, 0)
+#define DVFSRC_V4_GEAR_INFO_EMI		GENMASK(7, 4)
+#define DVFSRC_V4_GEAR_INFO_DRAM	GENMASK(15, 12)
+
 #define DVFSRC_POLL_TIMEOUT_US		1000
 #define STARTUP_TIME_US			1
 
@@ -52,6 +72,7 @@ struct dvfsrc_bw_constraints {
 struct dvfsrc_opp {
 	u32 vcore_opp;
 	u32 dram_opp;
+	u32 emi_opp;
 };
 
 struct dvfsrc_opp_desc {
@@ -72,6 +93,7 @@ struct mtk_dvfsrc {
 
 struct dvfsrc_soc_data {
 	const int *regs;
+	const u8 *bw_units;
 	const bool has_emi_ddr;
 	const struct dvfsrc_opp_desc *opps_desc;
 	u32 (*calc_dram_bw)(struct mtk_dvfsrc *dvfsrc, int type, u64 bw);
@@ -79,6 +101,8 @@ struct dvfsrc_soc_data {
 	u32 (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_vscp_level)(struct mtk_dvfsrc *dvfsrc);
+	u32 (*get_opp_count)(struct mtk_dvfsrc *dvfsrc);
+	int (*get_hw_opps)(struct mtk_dvfsrc *dvfsrc);
 	void (*set_dram_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
 	void (*set_dram_peak_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
 	void (*set_dram_hrt_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
@@ -101,6 +125,7 @@ static void dvfsrc_writel(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
 }
 
 enum dvfsrc_regs {
+	DVFSRC_BASIC_CONTROL,
 	DVFSRC_SW_REQ,
 	DVFSRC_SW_REQ2,
 	DVFSRC_LEVEL,
@@ -110,6 +135,9 @@ enum dvfsrc_regs {
 	DVFSRC_SW_HRT_BW,
 	DVFSRC_SW_EMI_BW,
 	DVFSRC_VCORE,
+	DVFSRC_TARGET_GEAR,
+	DVFSRC_GEAR_INFO_L,
+	DVFSRC_GEAR_INFO_H,
 	DVFSRC_REGS_MAX,
 };
 
@@ -130,6 +158,22 @@ static const int dvfsrc_mt8195_regs[] = {
 	[DVFSRC_TARGET_LEVEL] = 0xd48,
 };
 
+static const int dvfsrc_mt8196_regs[] = {
+	[DVFSRC_BASIC_CONTROL] = 0x0,
+	[DVFSRC_SW_REQ] = 0x18,
+	[DVFSRC_VCORE] = 0x80,
+	[DVFSRC_GEAR_INFO_L] = 0xfc,
+	[DVFSRC_SW_BW] = 0x1e8,
+	[DVFSRC_SW_PEAK_BW] = 0x1f4,
+	[DVFSRC_SW_HRT_BW] = 0x20c,
+	[DVFSRC_LEVEL] = 0x5f0,
+	[DVFSRC_TARGET_LEVEL] = 0x5f0,
+	[DVFSRC_SW_REQ2] = 0x604,
+	[DVFSRC_SW_EMI_BW] = 0x60c,
+	[DVFSRC_TARGET_GEAR] = 0x6ac,
+	[DVFSRC_GEAR_INFO_H] = 0x6b0,
+};
+
 static const struct dvfsrc_opp *dvfsrc_get_current_opp(struct mtk_dvfsrc *dvfsrc)
 {
 	u32 level = dvfsrc->dvd->get_current_level(dvfsrc);
@@ -137,6 +181,20 @@ static const struct dvfsrc_opp *dvfsrc_get_current_opp(struct mtk_dvfsrc *dvfsrc
 	return &dvfsrc->curr_opps->opps[level];
 }
 
+static u32 dvfsrc_get_current_target_vcore_gear(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_TARGET_GEAR);
+
+	return FIELD_GET(DVFSRC_V4_GEAR_TARGET_VCORE, val);
+}
+
+static u32 dvfsrc_get_current_target_dram_gear(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_TARGET_GEAR);
+
+	return FIELD_GET(DVFSRC_V4_GEAR_TARGET_DRAM, val);
+}
+
 static bool dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
 {
 	if (!dvfsrc->dvd->get_target_level)
@@ -193,6 +251,24 @@ static int dvfsrc_wait_for_opp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
 	return 0;
 }
 
+static int dvfsrc_wait_for_vcore_level_v4(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val;
+
+	return readx_poll_timeout_atomic(dvfsrc_get_current_target_vcore_gear,
+					 dvfsrc, val, val >= level,
+					 STARTUP_TIME_US, DVFSRC_POLL_TIMEOUT_US);
+}
+
+static int dvfsrc_wait_for_opp_level_v4(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val;
+
+	return readx_poll_timeout_atomic(dvfsrc_get_current_target_dram_gear,
+					 dvfsrc, val, val >= level,
+					 STARTUP_TIME_US, DVFSRC_POLL_TIMEOUT_US);
+}
+
 static u32 dvfsrc_get_target_level_v1(struct mtk_dvfsrc *dvfsrc)
 {
 	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_LEVEL);
@@ -226,6 +302,27 @@ static u32 dvfsrc_get_current_level_v2(struct mtk_dvfsrc *dvfsrc)
 	return 0;
 }
 
+static u32 dvfsrc_get_target_level_v4(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_TARGET_LEVEL);
+
+	if (val & DVFSRC_V4_LEVEL_TARGET_PRESENT)
+		return FIELD_GET(DVFSRC_V4_LEVEL_TARGET_LEVEL, val) + 1;
+	return 0;
+}
+
+static u32 dvfsrc_get_current_level_v4(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 level = dvfsrc_readl(dvfsrc, DVFSRC_LEVEL) + 1;
+
+	/* Valid levels */
+	if (level < dvfsrc->curr_opps->num_opp)
+		return dvfsrc->curr_opps->num_opp - level;
+
+	/* Zero for level 0 or invalid level */
+	return 0;
+}
+
 static u32 dvfsrc_get_vcore_level_v1(struct mtk_dvfsrc *dvfsrc)
 {
 	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ2);
@@ -277,11 +374,30 @@ static void dvfsrc_set_vscp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
 	dvfsrc_writel(dvfsrc, DVFSRC_VCORE, val);
 }
 
+static u32 dvfsrc_get_opp_count_v4(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_BASIC_CONTROL);
+
+	return FIELD_GET(DVFSRC_V4_BASIC_CTRL_OPP_COUNT, val) + 1;
+}
+
 static u32 dvfsrc_calc_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, int type, u64 bw)
 {
 	return (u32)div_u64(bw, 100 * 1000);
 }
 
+static u32 dvfsrc_calc_dram_bw_v4(struct mtk_dvfsrc *dvfsrc, int type, u64 bw)
+{
+	u8 bw_unit = dvfsrc->dvd->bw_units[type];
+	u64 bw_mbps;
+
+	if (type < DVFSRC_BW_AVG || type >= DVFSRC_BW_MAX)
+		return 0;
+
+	bw_mbps = div_u64(bw, 1000);
+	return (u32)div_u64((bw_mbps + bw_unit - 1), bw_unit);
+}
+
 static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
 				    int type, u16 max_bw, u16 min_bw, u64 bw)
 {
@@ -333,6 +449,100 @@ static void dvfsrc_set_opp_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
 	dvfsrc_writel(dvfsrc, DVFSRC_SW_REQ, val);
 }
 
+static u32 dvfsrc_get_opp_gear(struct mtk_dvfsrc *dvfsrc, u8 level)
+{
+	u32 reg_ofst, val;
+	u8 idx;
+
+	/* Calculate register offset and index for requested gear */
+	if (level < DVFSRC_V4_GEAR_INFO_REG_LEVELS) {
+		reg_ofst = dvfsrc->dvd->regs[DVFSRC_GEAR_INFO_L];
+		idx = level;
+	} else {
+		reg_ofst = dvfsrc->dvd->regs[DVFSRC_GEAR_INFO_H];
+		idx = level - DVFSRC_V4_GEAR_INFO_REG_LEVELS;
+	}
+	reg_ofst += DVFSRC_V4_GEAR_INFO_REG_WIDTH * (level / 2);
+
+	/* Read the corresponding gear register */
+	val = readl(dvfsrc->regs + reg_ofst);
+
+	/* Each register contains two sets of data, 16 bits per gear */
+	val >>= 16 * (idx % 2);
+
+	return val;
+}
+
+static int dvfsrc_get_hw_opps_v4(struct mtk_dvfsrc *dvfsrc)
+{
+	struct dvfsrc_opp *dvfsrc_opps;
+	struct dvfsrc_opp_desc *desc;
+	u32 num_opps, gear_info;
+	u8 num_vcore, num_dram;
+	u8 num_emi;
+	int i;
+
+	num_opps = dvfsrc_get_opp_count_v4(dvfsrc);
+	if (num_opps == 0) {
+		dev_err(dvfsrc->dev, "No OPPs programmed in DVFSRC MCU.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The first 16 bits set in the gear info table says how many OPPs
+	 * and how many vcore, dram and emi table entries are available.
+	 */
+	gear_info = dvfsrc_readl(dvfsrc, DVFSRC_GEAR_INFO_L);
+	if (gear_info == 0) {
+		dev_err(dvfsrc->dev, "No gear info in DVFSRC MCU.\n");
+		return -EINVAL;
+	}
+
+	num_vcore = FIELD_GET(DVFSRC_V4_GEAR_INFO_VCORE, gear_info) + 1;
+	num_dram = FIELD_GET(DVFSRC_V4_GEAR_INFO_DRAM, gear_info) + 1;
+	num_emi = FIELD_GET(DVFSRC_V4_GEAR_INFO_EMI, gear_info) + 1;
+	dev_info(dvfsrc->dev,
+		 "Discovered %u gears and %u vcore, %u dram, %u emi table entries.\n",
+		 num_opps, num_vcore, num_dram, num_emi);
+
+	/* Allocate everything now as anything else after that cannot fail */
+	desc = devm_kzalloc(dvfsrc->dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	dvfsrc_opps = devm_kcalloc(dvfsrc->dev, num_opps + 1,
+				   sizeof(*dvfsrc_opps), GFP_KERNEL);
+	if (!dvfsrc_opps)
+		return -ENOMEM;
+
+	/* Read the OPP table gear indices */
+	for (i = 0; i <= num_opps; i++) {
+		gear_info = dvfsrc_get_opp_gear(dvfsrc, num_opps - i);
+		dvfsrc_opps[i].vcore_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_VCORE, gear_info);
+		dvfsrc_opps[i].dram_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_DRAM, gear_info);
+		dvfsrc_opps[i].emi_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_EMI, gear_info);
+	};
+	desc->num_opp = num_opps + 1;
+	desc->opps = dvfsrc_opps;
+
+	/* Assign to main structure now that everything is done! */
+	dvfsrc->curr_opps = desc;
+
+	return 0;
+}
+
+static void dvfsrc_set_dram_level_v4(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ);
+
+	val &= ~DVFSRC_V4_SW_REQ_DRAM_LEVEL;
+	val |= FIELD_PREP(DVFSRC_V4_SW_REQ_DRAM_LEVEL, level);
+
+	dev_dbg(dvfsrc->dev, "%s level=%u\n", __func__, level);
+
+	dvfsrc_writel(dvfsrc, DVFSRC_SW_REQ, val);
+}
+
 int mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)
 {
 	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
@@ -448,7 +658,14 @@ static int mtk_dvfsrc_probe(struct platform_device *pdev)
 	dvfsrc->dram_type = ares.a1;
 	dev_dbg(&pdev->dev, "DRAM Type: %d\n", dvfsrc->dram_type);
 
-	dvfsrc->curr_opps = &dvfsrc->dvd->opps_desc[dvfsrc->dram_type];
+	/* Newer versions of the DVFSRC MCU have pre-programmed gear tables */
+	if (dvfsrc->dvd->get_hw_opps) {
+		ret = dvfsrc->dvd->get_hw_opps(dvfsrc);
+		if (ret)
+			return ret;
+	} else {
+		dvfsrc->curr_opps = &dvfsrc->dvd->opps_desc[dvfsrc->dram_type];
+	}
 	platform_set_drvdata(pdev, dvfsrc);
 
 	ret = devm_of_platform_populate(&pdev->dev);
@@ -576,10 +793,39 @@ static const struct dvfsrc_soc_data mt8195_data = {
 	.bw_constraints = &dvfsrc_bw_constr_v2,
 };
 
+static const u8 mt8196_bw_units[] = {
+	[DVFSRC_BW_AVG] = 64,
+	[DVFSRC_BW_PEAK] = 64,
+	[DVFSRC_BW_HRT] = 30,
+};
+
+static const struct dvfsrc_soc_data mt8196_data = {
+	.regs = dvfsrc_mt8196_regs,
+	.bw_units = mt8196_bw_units,
+	.has_emi_ddr = true,
+	.get_target_level = dvfsrc_get_target_level_v4,
+	.get_current_level = dvfsrc_get_current_level_v4,
+	.get_vcore_level = dvfsrc_get_vcore_level_v2,
+	.get_vscp_level = dvfsrc_get_vscp_level_v2,
+	.get_opp_count = dvfsrc_get_opp_count_v4,
+	.get_hw_opps = dvfsrc_get_hw_opps_v4,
+	.calc_dram_bw = dvfsrc_calc_dram_bw_v4,
+	.set_dram_bw = dvfsrc_set_dram_bw_v1,
+	.set_dram_peak_bw = dvfsrc_set_dram_peak_bw_v1,
+	.set_dram_hrt_bw = dvfsrc_set_dram_hrt_bw_v1,
+	.set_opp_level = dvfsrc_set_dram_level_v4,
+	.set_vcore_level = dvfsrc_set_vcore_level_v2,
+	.set_vscp_level = dvfsrc_set_vscp_level_v2,
+	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v4,
+	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v4,
+	.bw_constraints = &dvfsrc_bw_constr_v1,
+};
+
 static const struct of_device_id mtk_dvfsrc_of_match[] = {
 	{ .compatible = "mediatek,mt6893-dvfsrc", .data = &mt6893_data },
 	{ .compatible = "mediatek,mt8183-dvfsrc", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8195-dvfsrc", .data = &mt8195_data },
+	{ .compatible = "mediatek,mt8196-dvfsrc", .data = &mt8196_data },
 	{ /* sentinel */ }
 };
 

-- 
2.52.0


