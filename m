Return-Path: <linux-pm+bounces-36838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9EAC0A6EC
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19EA84E5B2E
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEE227B95;
	Sun, 26 Oct 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="S9ZPujlB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BA18EB0;
	Sun, 26 Oct 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481336; cv=none; b=HJEAgrQSplmQLy/2wxploOdpCKPdIZc2Mf51QELd1xT+9Ft5QBDyg1W78exHBZjIJqtwSmqSkx20gHhZPJLy17isAbklnvC57M3xdnYVIHOsD4QXULhZ8tdRM3UimvjLMp0JR76mj7jOdmOJsW5vC+AjMCd+eaAfHNY4B+bKdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481336; c=relaxed/simple;
	bh=QPZqpmMM53oDlw5RkClpzSB/9haDur+byq04ET34B+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9GfjVdaaqJ3o+0qSUwo6zEaSXa6g1/+sxX9BGUIe3ZKzxKTvdZwdyAh9kvmNRrtngMqPVVpTlUlwbd5z7AYhB96xv4HZhur2h9t0jZMkju23hXjsdzO5ruYelE2r25peVRxdlPF77il8lbmIgUj0rukR0UJFyPGWfflytTqh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=S9ZPujlB; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id EB48A5FF3F;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dY9esegxlxvfveosoEyFChzlWucqwdO0YH5Tj3yiok=;
	b=S9ZPujlBTnCdbMJvrxVvkukT6o+Scd2mNqnGuwjJLvLfi9wnHM9rp6GrqgsyjCpPJh45Nc
	p+OPvrCITAZjf0eqLrD2wAfH2ivXL0E/gBXRRJN1W1lLQ+/csTp3TsaSg9DHF67cLTQCSq
	fjNADBDeAX6F7RcwObO6DONXNNKTmWU=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id AFA1A1226BC;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 5/5] thermal/drivers/mediatek/lvts_thermal: Add mt7987 support
Date: Sun, 26 Oct 2025 13:21:34 +0100
Message-ID: <20251026122143.71100-6-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026122143.71100-1-linux@fw-web.de>
References: <20251026122143.71100-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add support for MT7987.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 544941e8219a..1d800bdf4a24 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -87,6 +87,8 @@
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
 #define LVTS_COEFF_B_MT7988			204650
+#define LVTS_COEFF_A_MT7987			-204650
+#define LVTS_COEFF_B_MT7987			204650
 
 #define LVTS_MSR_IMMEDIATE_MODE		0
 #define LVTS_MSR_FILTERED_MODE		1
@@ -1400,6 +1402,20 @@ static void lvts_remove(struct platform_device *pdev)
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
 }
 
+static const struct lvts_ctrl_data mt7987_lvts_ap_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT7987_CPU,
+			  .cal_offsets = { 0x04, 0x05, 0x06 } },
+			{ .dt_id = MT7987_ETH2P5G,
+			  .cal_offsets = { 0x08, 0x09, 0x0a } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x0,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+};
+
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 	{
 		.lvts_sensor = {
@@ -1482,6 +1498,12 @@ static const u32 default_init_cmds[] = {
 	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
 };
 
+static const u32 mt7987_init_cmds[] = {
+	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC10308C7,
+	0xC103098D, 0xC1030C7C, 0xC1030AA8, 0xC10308CE, 0xC10308C7,
+	0xC1030B04, 0xC1030E01, 0xC10306B8
+};
+
 static const u32 mt7988_init_cmds[] = {
 	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC1030CFC,
 	0xC1030A8C, 0xC103098D, 0xC10308F1, 0xC1030B04, 0xC1030E01,
@@ -1780,6 +1802,21 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt7987_lvts_ap_data = {
+	.lvts_ctrl	= mt7987_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt7987_lvts_ap_data_ctrl),
+	.conn_cmd	= mt7988_conn_cmds,
+	.init_cmd	= mt7987_init_cmds,
+	.num_conn_cmd	= ARRAY_SIZE(mt7988_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(mt7987_init_cmds),
+	.temp_factor	= LVTS_COEFF_A_MT7987,
+	.temp_offset	= LVTS_COEFF_B_MT7987,
+	.golden_temp	= 60,
+	.gt_calib_bit_offset = 32,
+	.def_calibration = 19380,
+	.irq_enable	= false,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1899,6 +1936,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt7987-lvts-ap", .data = &mt7987_lvts_ap_data },
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
 	{ .compatible = "mediatek,mt8188-lvts-mcu", .data = &mt8188_lvts_mcu_data },
-- 
2.43.0


