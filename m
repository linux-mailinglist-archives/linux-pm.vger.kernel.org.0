Return-Path: <linux-pm+bounces-27649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D16AC3DDE
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AC4175F04
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0D1F78F2;
	Mon, 26 May 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H4lN3tNM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1731F7075;
	Mon, 26 May 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255413; cv=none; b=V8HT1onuMNASBRph/P12GxRQ3JU4rx1Czbfww9+b7R6+WDQjATCRZmYrUVIf9ZF55RCTPtnIriLdOPrBhmBxN307x+Mq8E+wuGnyTgv4bebwKCE8mGnkZ3F6LhdEKf6B9QARmCWmMUm2vluQpnR2Ts+qCvnuPg6P6CPqzhlIAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255413; c=relaxed/simple;
	bh=xrGv+TnemQ3z7qiBMYovkHGri9FvvPMpHj43X6Wu5Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2rYyT+yOnRIOlvi7YnRGN1/54Wbq5QiSAfkG46NB9Wlf56vnhzbhxFfSf574V+3j9k0/0KF5cSpLr+Oz6pgM+S1J9SiPIWv3kwezD/2aYxgGOuIDUPRRv6sGe3H/9vUFoxlt65+OrRSPgB3W0OKV6lSgk2dqVkFuhIxgyE5nPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H4lN3tNM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6523f2783a1c11f0813e4fe1310efc19-20250526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vWCRULhXd6n3Iop0GzX3f0hianSoviWi0XUW3wTldsI=;
	b=H4lN3tNM94HWMHIyH+q4bQMChEnx3d+lTYwdytvhz1ZRiolFFsgO3hYA1pO/BIoK84LAJ4yo+Lc9F4EQGSnDAFIpNPU/EG+a0UDfNRc3n3dONMZ1Pdq3PGJT0/1u+sZ6cgf5/TECyxGmtm8taBAcbHu7SOqRy545rj6ph36+9Kc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:be72ddf3-9a15-435c-bab9-4b8f02bcc997,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-55
X-CID-META: VersionHash:0ef645f,CLOUDID:de27fc57-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:2,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6523f2783a1c11f0813e4fe1310efc19-20250526
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mason-cw.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1598310443; Mon, 26 May 2025 18:30:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 26 May 2025 18:30:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 26 May 2025 18:30:02 +0800
From: Mason Chang <mason-cw.chang@mediatek.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
	<nfraprado@collabora.com>, Julien Panis <jpanis@baylibre.com>, Nicolas Pitre
	<npitre@baylibre.com>, Colin Ian King <colin.i.king@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Chen-Yu
 Tsai <wenst@chromium.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Frank Wunderlich
	<frank-w@public-files.de>, Daniel Golle <daniel@makrotopia.org>, Steven Liu
	<steven.liu@mediatek.com>, Sam Shih <sam.shih@mediatek.com>
CC: Mason Chang <mason-cw.chang@mediatek.com>
Subject: [PATCH 2/3] thermal/drivers/mediatek/lvts_thermal: add lvts commands and their sizes to driver data
Date: Mon, 26 May 2025 18:26:58 +0800
Message-ID: <20250526102659.30225-3-mason-cw.chang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add LVTS commands and their sizes to driver data in preparation for
adding different commands.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 65 ++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 7e4f56831..5b7bf29a7 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -96,17 +96,6 @@
 
 #define LVTS_MINIMUM_THRESHOLD		20000
 
-static const u32 default_conn_cmds[] = { 0xC103FFFF, 0xC502FF55 };
-/*
- * Write device mask: 0xC1030000
- */
-static const u32 default_init_cmds[] = {
-	0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
-	0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
-	0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
-	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
-};
-
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
 
@@ -136,7 +125,11 @@ struct lvts_ctrl_data {
 
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
+	const u32 *conn_cmd;
+	const u32 *init_cmd;
 	int num_lvts_ctrl;
+	int num_conn_cmd;
+	int num_init_cmd;
 	int temp_factor;
 	int temp_offset;
 	int gt_calib_bit_offset;
@@ -996,9 +989,10 @@ static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
 
 static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	u32 id;
 
-	lvts_write_config(lvts_ctrl, default_conn_cmds, ARRAY_SIZE(default_conn_cmds));
+	lvts_write_config(lvts_ctrl, lvts_data->conn_cmd, lvts_data->num_conn_cmd);
 
 	/*
 	 * LVTS_ID : Get ID and status of the thermal controller
@@ -1017,7 +1011,9 @@ static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 
 static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	lvts_write_config(lvts_ctrl, default_init_cmds, ARRAY_SIZE(default_init_cmds));
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+
+	lvts_write_config(lvts_ctrl, lvts_data->init_cmd, lvts_data->num_init_cmd);
 
 	return 0;
 }
@@ -1446,6 +1442,17 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
 
+static const u32 default_conn_cmds[] = { 0xC103FFFF, 0xC502FF55 };
+/*
+ * Write device mask: 0xC1030000
+ */
+static const u32 default_init_cmds[] = {
+	0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
+	0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
+	0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
+	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
+};
+
 /*
  * The MT8186 calibration data is stored as packed 3-byte little-endian
  * values using a weird layout that makes sense only when viewed as a 32-bit
@@ -1740,7 +1747,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
@@ -1748,7 +1759,11 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 
 static const struct lvts_data mt8186_lvts_data = {
 	.lvts_ctrl	= mt8186_lvts_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
@@ -1757,7 +1772,11 @@ static const struct lvts_data mt8186_lvts_data = {
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
 	.lvts_ctrl	= mt8188_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
@@ -1766,7 +1785,11 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 
 static const struct lvts_data mt8188_lvts_ap_data = {
 	.lvts_ctrl	= mt8188_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
@@ -1775,7 +1798,11 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1784,7 +1811,11 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1793,7 +1824,11 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1802,7 +1837,11 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 
 static const struct lvts_data mt8195_lvts_ap_data = {
 	.lvts_ctrl	= mt8195_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
-- 
2.45.2


