Return-Path: <linux-pm+bounces-7815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE768C4F61
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08D11C2083F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E388612E;
	Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1Blf9nG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rThBAkE5"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96984DFD
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681941; cv=none; b=o+MmlITbtqkbW5wSaGvmqxdkPLd4duautASDN3y/Q8Ta5M8reRZE3KrQ1KXnzVZnsea6ZL6jeMF8cfF7J8t0j5AzszoYIIYKKxeLlc3a0MWpiLTYf6aC8KaN2FLaIUNd85xh9Vu/Q5XC/AjINLEnuoaD9e8KNn5n9phzY2/OK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681941; c=relaxed/simple;
	bh=HyCYB3x3uiB+HkUAxxXiRCyBIFfGmU8/1s2qFCvUc7s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aawZTCb8gOcv2z6JR6x1Lu0mGRJ6Ao9Jso67vZrIZ0ytDjXElj5Cxn6gb/VTjRKocPEI6IFXaWqyPS4dNLtb+P9jIaPGYXZo6/KteY3MA2XDqeh/1T63lEwoyoAhZRW+E7GTFS/eK2OJKHwwEvkEHGXfcZ83KIhbbJpp5subwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1Blf9nG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rThBAkE5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skfK60GLVDoJAl1ByTiNSu50LPZmAz43qbxSE9GRf9U=;
	b=A1Blf9nGrDUi01n8nifANFbLF/jTf5BqcrQrastRNOO8rLRdot4HNq/WExG0MHP5N2SzNQ
	WIfVurwbVA+hligCiks/UQFPKdI13wFN6EGwPFUEpKl3Mu1r6F0Ggr01bMcIwyKenCNZuE
	YqWXqTxiIt470Pq57c4qYk3Xu+z8bZJHO2w9sjd1gl4ipQkL8haaHDToDXHNiQn9ZFLRxj
	CKuxSe46tdOfbeSnkVvw324jpI9LMfHtcIdD7xbMf96OU8K/XWbcZa2wizXR80k3UNZgIu
	+V1wydprh/1s5/b4YtK2N8rk2AcptrNwKgcdJtrjorLqZn+/AGVzzu9UQXeXnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skfK60GLVDoJAl1ByTiNSu50LPZmAz43qbxSE9GRf9U=;
	b=rThBAkE5HxR+dN3cxd5lqi7Vry0umTISGKJ79My+mOgx9ryovDeESQQTFIXGBHxLInpi7x
	mIV9fZ7B3zWWfsCg==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Use
 offsets for every calibration byte
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-5-nico@fluxnic.net>
References: <20240402032729.2736685-5-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193413.10875.7813116617054289650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     5b3367e28a2c47d74bd566b96854ef0de3caa6d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5b3367e28a2c47d74bd566b96854ef0de3caa6d7
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:38 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Use offsets for every calibration byte

Current code assumes calibration values are always stored contiguously
in host endian order. A future patch will prove this wrong.

Let's specify the offset for each calibration byte instead.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-5-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 164 +++++++++++++----------
 1 file changed, 99 insertions(+), 65 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 08cf379..9e6ed8b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -100,6 +100,7 @@ static int golden_temp_offset;
 
 struct lvts_sensor_data {
 	int dt_id;
+	u8 cal_offsets[3];
 };
 
 struct lvts_ctrl_data {
@@ -665,8 +666,9 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
  *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
- * The data description gives the offset of the calibration data in
- * this bytes stream for each sensor.
+ * Note: In some cases, values don't strictly follow a little endian ordering.
+ * The data description gives byte offsets constituting each calibration value
+ * for each sensor.
  */
 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data,
@@ -674,9 +676,15 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 {
 	int i;
 
-	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
-		memcpy(&lvts_ctrl->calibration[i],
-		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 3);
+	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+		const struct lvts_sensor_data *sensor =
+					&lvts_ctrl_data->lvts_sensor[i];
+
+		lvts_ctrl->calibration[i] =
+			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
+			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
+			(efuse_calibration[sensor->cal_offsets[2]] << 16);
+	}
 
 	return 0;
 }
@@ -1299,23 +1307,29 @@ static void lvts_remove(struct platform_device *pdev)
 
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 	{
-		.cal_offset = { 0x00, 0x04, 0x08, 0x0c },
 		.lvts_sensor = {
-			{ .dt_id = MT7988_CPU_0 },
-			{ .dt_id = MT7988_CPU_1 },
-			{ .dt_id = MT7988_ETH2P5G_0 },
-			{ .dt_id = MT7988_ETH2P5G_1 }
+			{ .dt_id = MT7988_CPU_0,
+			  .cal_offsets = { 0x00, 0x01, 0x02 } },
+			{ .dt_id = MT7988_CPU_1,
+			  .cal_offsets = { 0x04, 0x05, 0x06 } },
+			{ .dt_id = MT7988_ETH2P5G_0,
+			  .cal_offsets = { 0x08, 0x09, 0x0a } },
+			{ .dt_id = MT7988_ETH2P5G_1,
+			  .cal_offsets = { 0x0c, 0x0d, 0x0e } }
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x0,
 	},
 	{
-		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
 		.lvts_sensor = {
-			{ .dt_id = MT7988_TOPS_0},
-			{ .dt_id = MT7988_TOPS_1},
-			{ .dt_id = MT7988_ETHWARP_0},
-			{ .dt_id = MT7988_ETHWARP_1}
+			{ .dt_id = MT7988_TOPS_0,
+			   .cal_offsets = { 0x14, 0x15, 0x16 } },
+			{ .dt_id = MT7988_TOPS_1,
+			   .cal_offsets = { 0x18, 0x19, 0x1a } },
+			{ .dt_id = MT7988_ETHWARP_0,
+			   .cal_offsets = { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id = MT7988_ETHWARP_1,
+			   .cal_offsets = { 0x20, 0x21, 0x22 } }
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x100,
@@ -1356,32 +1370,37 @@ static int lvts_resume(struct device *dev)
 
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 	{
-		.cal_offset = { 0x04, 0x08 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_MCU_BIG_CPU0 },
-			{ .dt_id = MT8192_MCU_BIG_CPU1 }
+			{ .dt_id = MT8192_MCU_BIG_CPU0,
+			  .cal_offsets = { 0x04, 0x05, 0x06 } },
+			{ .dt_id = MT8192_MCU_BIG_CPU1,
+			  .cal_offsets = { 0x08, 0x09, 0x0a } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
-		.cal_offset = { 0x0c, 0x10 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_MCU_BIG_CPU2 },
-			{ .dt_id = MT8192_MCU_BIG_CPU3 }
+			{ .dt_id = MT8192_MCU_BIG_CPU2,
+			  .cal_offsets = { 0x0c, 0x0d, 0x0e } },
+			{ .dt_id = MT8192_MCU_BIG_CPU3,
+			  .cal_offsets = { 0x10, 0x11, 0x12 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
-		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
-			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
-			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
-			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
+			{ .dt_id = MT8192_MCU_LITTLE_CPU0,
+			  .cal_offsets = { 0x14, 0x15, 0x16 } },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU1,
+			  .cal_offsets = { 0x18, 0x19, 0x1a } },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU2,
+			  .cal_offsets = { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU3,
+			  .cal_offsets = { 0x20, 0x21, 0x22 } }
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x200,
@@ -1390,39 +1409,44 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 };
 
 static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
-		{
-		.cal_offset = { 0x24, 0x28 },
+	{
 		.lvts_sensor = {
-			{ .dt_id = MT8192_AP_VPU0 },
-			{ .dt_id = MT8192_AP_VPU1 }
+			{ .dt_id = MT8192_AP_VPU0,
+			  .cal_offsets = { 0x24, 0x25, 0x26 } },
+			{ .dt_id = MT8192_AP_VPU1,
+			  .cal_offsets = { 0x28, 0x29, 0x2a } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
 	},
 	{
-		.cal_offset = { 0x2c, 0x30 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_AP_GPU0 },
-			{ .dt_id = MT8192_AP_GPU1 }
+			{ .dt_id = MT8192_AP_GPU0,
+			  .cal_offsets = { 0x2c, 0x2d, 0x2e } },
+			{ .dt_id = MT8192_AP_GPU1,
+			  .cal_offsets = { 0x30, 0x31, 0x32 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
 	},
 	{
-		.cal_offset = { 0x34, 0x38 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_AP_INFRA },
-			{ .dt_id = MT8192_AP_CAM },
+			{ .dt_id = MT8192_AP_INFRA,
+			  .cal_offsets = { 0x34, 0x35, 0x36 } },
+			{ .dt_id = MT8192_AP_CAM,
+			  .cal_offsets = { 0x38, 0x39, 0x3a } },
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x200,
 	},
 	{
-		.cal_offset = { 0x3c, 0x40, 0x44 },
 		.lvts_sensor = {
-			{ .dt_id = MT8192_AP_MD0 },
-			{ .dt_id = MT8192_AP_MD1 },
-			{ .dt_id = MT8192_AP_MD2 }
+			{ .dt_id = MT8192_AP_MD0,
+			  .cal_offsets = { 0x3c, 0x3d, 0x3e } },
+			{ .dt_id = MT8192_AP_MD1,
+			  .cal_offsets = { 0x40, 0x41, 0x42 } },
+			{ .dt_id = MT8192_AP_MD2,
+			  .cal_offsets = { 0x44, 0x45, 0x46 } }
 		},
 		.num_lvts_sensor = 3,
 		.offset = 0x300,
@@ -1431,30 +1455,35 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
-		.cal_offset = { 0x04, 0x07 },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_MCU_BIG_CPU0 },
-			{ .dt_id = MT8195_MCU_BIG_CPU1 }
+			{ .dt_id = MT8195_MCU_BIG_CPU0,
+			  .cal_offsets = { 0x04, 0x05, 0x06 } },
+			{ .dt_id = MT8195_MCU_BIG_CPU1,
+			  .cal_offsets = { 0x07, 0x08, 0x09 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
 	},
 	{
-		.cal_offset = { 0x0d, 0x10 },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_MCU_BIG_CPU2 },
-			{ .dt_id = MT8195_MCU_BIG_CPU3 }
+			{ .dt_id = MT8195_MCU_BIG_CPU2,
+			  .cal_offsets = { 0x0d, 0x0e, 0x0f } },
+			{ .dt_id = MT8195_MCU_BIG_CPU3,
+			  .cal_offsets = { 0x10, 0x11, 0x12 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
 	},
 	{
-		.cal_offset = { 0x16, 0x19, 0x1c, 0x1f },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_MCU_LITTLE_CPU0 },
-			{ .dt_id = MT8195_MCU_LITTLE_CPU1 },
-			{ .dt_id = MT8195_MCU_LITTLE_CPU2 },
-			{ .dt_id = MT8195_MCU_LITTLE_CPU3 }
+			{ .dt_id = MT8195_MCU_LITTLE_CPU0,
+			  .cal_offsets = { 0x16, 0x17, 0x18 } },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU1,
+			  .cal_offsets = { 0x19, 0x1a, 0x1b } },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU2,
+			  .cal_offsets = { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU3,
+			  .cal_offsets = { 0x1f, 0x20, 0x21 } }
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x200,
@@ -1462,39 +1491,44 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 };
 
 static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
-		{
-		.cal_offset = { 0x25, 0x28 },
+	{
 		.lvts_sensor = {
-			{ .dt_id = MT8195_AP_VPU0 },
-			{ .dt_id = MT8195_AP_VPU1 }
+			{ .dt_id = MT8195_AP_VPU0,
+			  .cal_offsets = { 0x25, 0x26, 0x27 } },
+			{ .dt_id = MT8195_AP_VPU1,
+			  .cal_offsets = { 0x28, 0x29, 0x2a } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
 	},
 	{
-		.cal_offset = { 0x2e, 0x31 },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_AP_GPU0 },
-			{ .dt_id = MT8195_AP_GPU1 }
+			{ .dt_id = MT8195_AP_GPU0,
+			  .cal_offsets = { 0x2e, 0x2f, 0x30 } },
+			{ .dt_id = MT8195_AP_GPU1,
+			  .cal_offsets = { 0x31, 0x32, 0x33 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
 	},
 	{
-		.cal_offset = { 0x37, 0x3a, 0x3d },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_AP_VDEC },
-			{ .dt_id = MT8195_AP_IMG },
-			{ .dt_id = MT8195_AP_INFRA },
+			{ .dt_id = MT8195_AP_VDEC,
+			  .cal_offsets = { 0x37, 0x38, 0x39 } },
+			{ .dt_id = MT8195_AP_IMG,
+			  .cal_offsets = { 0x3a, 0x3b, 0x3c } },
+			{ .dt_id = MT8195_AP_INFRA,
+			  .cal_offsets = { 0x3d, 0x3e, 0x3f } }
 		},
 		.num_lvts_sensor = 3,
 		.offset = 0x200,
 	},
 	{
-		.cal_offset = { 0x43, 0x46 },
 		.lvts_sensor = {
-			{ .dt_id = MT8195_AP_CAM0 },
-			{ .dt_id = MT8195_AP_CAM1 }
+			{ .dt_id = MT8195_AP_CAM0,
+			  .cal_offsets = { 0x43, 0x44, 0x45 } },
+			{ .dt_id = MT8195_AP_CAM1,
+			  .cal_offsets = { 0x46, 0x47, 0x48 } }
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x300,

