Return-Path: <linux-pm+bounces-7813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1088C4F5F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB141C20919
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680A85C5D;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLlzBejb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Cs1CrdT"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502F84D27
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681940; cv=none; b=sI2fL0m2sL2nNwYmHD1x8QrsIqtV+BacIgMwFMm1yA3B8wb3VP+I3sDDxkM7p6U6Zm3GloAgVzSlAiP2AxDzjxE3kVBWjBgJ6zvDwfO18+D1Bavu9skYXtEO/GGI85ibxQDgtL8FIdNU8BFZTMzzFx94N6eDc2UNRxZZ+JLQnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681940; c=relaxed/simple;
	bh=xsXAWB2AsOzg2AnNPeMruuJNyLmg7Thj7wd4to+nF5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKCU+yWMIDbMF6GGZYnopbfM4BWO9/lpDL5uqR5hYKlNPkjUf8eRPhtDtX93F0xxakaBxILdt43hcsmjSlALAE1Rh/7V4bJqZZ+Q8/jZO9o3ONpEdve5UbQ871r68Lpmob12pubOb1pwRFTPeSYrtc3HpTlcTYjMjGFUxXWscto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLlzBejb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Cs1CrdT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLUd7RahDsJZdNNbqZmxrUNlN6eB0kwTYpfV6Kj0YO8=;
	b=OLlzBejbjlp61UcxxG2MEgldiV2pY0v28whCFyeWHkHsvmPI66C8Jz66TjIJbe0Avvur3n
	hM7yZ9g17wRdNBH24fC/+5eqAho87ayqqboonJA4xefdxJKGcawgvC7qsCQ35/UEpW8gNv
	E+4IKFbFkG2z6tybFXQTFnYp5qoI9rqVzYK7gSrrZ0iidLZgoGJA3bpmmq1/AD8/GC/++n
	6yt9A136XFNQRYg638k6V8u7iZR77RPn7Ek/tYDGQXMv6SgPpowl+NMcQaVlWYRWJNVZ0s
	g0CHwdh5WgLwZ9T4C4CCQ+YsbghEFp7gYxSVLMMNt+Q/JDG1Lo+RTveUdE1P7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLUd7RahDsJZdNNbqZmxrUNlN6eB0kwTYpfV6Kj0YO8=;
	b=5Cs1CrdThbLJLY+ACPEfWF0/KKsjM3HxeY63A4jJ4GDaQ6MeztpF0+sQoBHZ+Htf0S8ear
	NxS9o81Ng/WwnCCw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Allow
 early empty sensor slots
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-12-nico@fluxnic.net>
References: <20240402032729.2736685-12-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193349.10875.5550160551234904542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     11e6f4c3144743b2b2c26a5cd58ae3696379b3ab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//11e6f4c3144743b2b2c26a5cd58ae3696379b3ab
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:45 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots

Some systems don't always populate sensor controller slots starting
at slot 0. Use a bitmap instead of a count to indicate valid sensor
slots. Also create a pretty iterator for that.

About that iterator: it causes checkpatch to complain with "ERROR:
Macros with multiple statements should be enclosed in a do - while
loop". However this is not possible here. And many similar iterators
do exist using the same form in the tree already.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-12-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 63 ++++++++++++++----------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 34f5a81..ced4fa8 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -107,10 +107,23 @@ struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	int cal_offset[LVTS_SENSOR_MAX];
 	int num_lvts_sensor;
+	u8 valid_sensor_mask;
 	int offset;
 	int mode;
 };
 
+#define VALID_SENSOR_MAP(s0, s1, s2, s3) \
+	.valid_sensor_mask = (((s0) ? BIT(0) : 0) | \
+			      ((s1) ? BIT(1) : 0) | \
+			      ((s2) ? BIT(2) : 0) | \
+			      ((s3) ? BIT(3) : 0))
+
+#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
+	for ((i) = 0; (i) < LVTS_SENSOR_MAX; (i)++) \
+		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
+			continue; \
+		else
+
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
 	int num_lvts_ctrl;
@@ -134,7 +147,6 @@ struct lvts_ctrl {
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u32 hw_tshut_raw_temp;
-	int num_lvts_sensor;
 	int mode;
 	void __iomem *base;
 	int low_thresh;
@@ -346,7 +358,7 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
 	if (high > lvts_ctrl->high_thresh)
 		return true;
 
-	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++)
+	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
 		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
 			return false;
@@ -550,6 +562,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data)
 {
 	struct lvts_sensor *lvts_sensor = lvts_ctrl->sensors;
+
 	void __iomem *msr_regs[] = {
 		LVTS_MSR0(lvts_ctrl->base),
 		LVTS_MSR1(lvts_ctrl->base),
@@ -566,7 +579,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 
 	int i;
 
-	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 
 		int dt_id = lvts_ctrl_data->lvts_sensor[i].dt_id;
 
@@ -606,8 +619,6 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		lvts_sensor[i].high_thresh = INT_MIN;
 	};
 
-	lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
-
 	return 0;
 }
 
@@ -678,7 +689,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 {
 	int i;
 
-	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =
 					&lvts_ctrl_data->lvts_sensor[i];
 
@@ -1103,7 +1114,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	u32 *sensor_bitmap = lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE ?
 			     sensor_imm_bitmap : sensor_filt_bitmap;
 
-	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
 
 		int dt_id = lvts_sensors[i].dt_id;
 
@@ -1326,7 +1337,7 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT7988_ETH2P5G_1,
 			  .cal_offsets = { 0x0c, 0x0d, 0x0e } }
 		},
-		.num_lvts_sensor = 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x0,
 	},
 	{
@@ -1340,7 +1351,7 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT7988_ETHWARP_1,
 			   .cal_offsets = { 0x20, 0x21, 0x22 } }
 		},
-		.num_lvts_sensor = 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x100,
 	}
 };
@@ -1403,7 +1414,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 			{ .dt_id = MT8186_CAM,
 			  .cal_offsets = { 12, 13, 14 } }
 		},
-		.num_lvts_sensor = 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x0,
 	},
 	{
@@ -1413,7 +1424,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 			{ .dt_id = MT8186_BIG_CPU1,
 			  .cal_offsets = { 27, 20, 21 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
 	},
 	{
@@ -1425,7 +1436,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 			{ .dt_id = MT8186_MFG,
 			  .cal_offsets = { 39, 32, 33 } }
 		},
-		.num_lvts_sensor = 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x200,
 	}
 };
@@ -1438,7 +1449,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8192_MCU_BIG_CPU1,
 			  .cal_offsets = { 0x08, 0x09, 0x0a } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x0,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
@@ -1449,7 +1460,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8192_MCU_BIG_CPU3,
 			  .cal_offsets = { 0x10, 0x11, 0x12 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
@@ -1464,7 +1475,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8192_MCU_LITTLE_CPU3,
 			  .cal_offsets = { 0x20, 0x21, 0x22 } }
 		},
-		.num_lvts_sensor = 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x200,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	}
@@ -1478,7 +1489,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8192_AP_VPU1,
 			  .cal_offsets = { 0x28, 0x29, 0x2a } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x0,
 	},
 	{
@@ -1488,7 +1499,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8192_AP_GPU1,
 			  .cal_offsets = { 0x30, 0x31, 0x32 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
 	},
 	{
@@ -1498,7 +1509,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8192_AP_CAM,
 			  .cal_offsets = { 0x38, 0x39, 0x3a } },
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x200,
 	},
 	{
@@ -1510,7 +1521,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8192_AP_MD2,
 			  .cal_offsets = { 0x44, 0x45, 0x46 } }
 		},
-		.num_lvts_sensor = 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x300,
 	}
 };
@@ -1523,7 +1534,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8195_MCU_BIG_CPU1,
 			  .cal_offsets = { 0x07, 0x08, 0x09 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x0,
 	},
 	{
@@ -1533,7 +1544,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8195_MCU_BIG_CPU3,
 			  .cal_offsets = { 0x10, 0x11, 0x12 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
 	},
 	{
@@ -1547,7 +1558,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 			{ .dt_id = MT8195_MCU_LITTLE_CPU3,
 			  .cal_offsets = { 0x1f, 0x20, 0x21 } }
 		},
-		.num_lvts_sensor = 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x200,
 	}
 };
@@ -1560,7 +1571,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8195_AP_VPU1,
 			  .cal_offsets = { 0x28, 0x29, 0x2a } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x0,
 	},
 	{
@@ -1570,7 +1581,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8195_AP_GPU1,
 			  .cal_offsets = { 0x31, 0x32, 0x33 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
 	},
 	{
@@ -1582,7 +1593,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8195_AP_INFRA,
 			  .cal_offsets = { 0x3d, 0x3e, 0x3f } }
 		},
-		.num_lvts_sensor = 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x200,
 	},
 	{
@@ -1592,7 +1603,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 			{ .dt_id = MT8195_AP_CAM1,
 			  .cal_offsets = { 0x46, 0x47, 0x48 } }
 		},
-		.num_lvts_sensor = 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x300,
 	}
 };

