Return-Path: <linux-pm+bounces-7811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584178C4F5E
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510791F22B9C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8585959;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEHgiGuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/TapiAef"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31684D11
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681940; cv=none; b=WaAGIPzv8FXYcwPML6qHTo9wuvyF6WGU75PAD7F8geMY/YW8kFHKJf6tfsua4syL14nyP+ReVTVG6yyH7fW1teat8zntT9xkWx+ij4oxRLASnBREvBfEleXXigN8CwB+cbIm7wGN/c0y7vbYsa1u+g/Ub4bwCulGrQeOx4vq4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681940; c=relaxed/simple;
	bh=3wkZdBd0EXbocWON57QsNyuBq9Ql3drTBvwetcH4nrU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zq5zvpWfMvbhA2dgGw9sltPLYTyzFwkwyugArrigcyslaqCxbOgfBc7VM/5GSiyekEiZLdNlTcV+aj9WbC6tbTO07FE5T8gj1Glv1BdksrqpsrY/IHBB6tMhvbmtWiXkeUgdNyHcjXc8gkqJaIgSkthxNM0YCcs47U3F/UFV798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEHgiGuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/TapiAef; arc=none smtp.client-ip=193.142.43.55
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
	bh=xCfwFXPTcrE6IQmWkzew9yoUIZljlVhQiJhNEAMcW/U=;
	b=gEHgiGuBfOaddHjBi1tm6g/spOQ9ywwr9cVqmozx2CMOF3/JFRiXlOLquU+A49+88kvCfd
	b71YiG9khmN6QpWD8D5iobUZFk1mMHbf0qWTSMAUh/7yhxzN0nJh7nOHKMGHxIX1/OmBNv
	ToxNEa9MDCr5Zx7lUNdgeam6onnITtOOdjHrfRG6oJWnGEkW45SyvG6Bxt10gnfOG9sdz8
	5z6hyf39CjwrdVNs2FSXuo6bJXqCChRjb9IZyH/KdA7F392cJZY3rFzqV2jsajnLVHui5D
	S+4d7/pnjPZpXPDNvxjs3kM0CFxqWDhXncziEWJy3QSfwX+JMf835vaEFm+4UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCfwFXPTcrE6IQmWkzew9yoUIZljlVhQiJhNEAMcW/U=;
	b=/TapiAef6B9tUH7DTTkZgUVoikcpqBm/2KlWSF3Z1bQS3GEtZJ3Ek5NBg96O+u0W8IOlit
	6aYke/+PFVnYa+Dw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Add
 MT8188 support
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-15-nico@fluxnic.net>
References: <20240402032729.2736685-15-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193328.10875.4349064640702480076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     f4745f546e6077e3ed2bab90e931154519e96ae0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f4745f546e6077e3ed2bab90e931154519e96ae0
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:48 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/mediatek/lvts_thermal: Add MT8188 support

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-15-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 96 ++++++++++++++++++++++++-
 1 file changed, 96 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ced4fa8..86b2f44 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1441,6 +1441,84 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8188_MCU_LITTLE_CPU0,
+			  .cal_offsets = { 22, 23, 24 } },
+			{ .dt_id = MT8188_MCU_LITTLE_CPU1,
+			  .cal_offsets = { 25, 26, 27 } },
+			{ .dt_id = MT8188_MCU_LITTLE_CPU2,
+			  .cal_offsets = { 28, 29, 30 } },
+			{ .dt_id = MT8188_MCU_LITTLE_CPU3,
+			  .cal_offsets = { 31, 32, 33 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x0,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8188_MCU_BIG_CPU0,
+			  .cal_offsets = { 34, 35, 36 } },
+			{ .dt_id = MT8188_MCU_BIG_CPU1,
+			  .cal_offsets = { 37, 38, 39 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x100,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+
+			{ /* unused */ },
+			{ .dt_id = MT8188_AP_APU,
+			  .cal_offsets = { 40, 41, 42 } },
+		},
+		VALID_SENSOR_MAP(0, 1, 0, 0),
+		.offset = 0x0,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8188_AP_GPU1,
+			  .cal_offsets = { 43, 44, 45 } },
+			{ .dt_id = MT8188_AP_GPU2,
+			  .cal_offsets = { 46, 47, 48 } },
+			{ .dt_id = MT8188_AP_SOC1,
+			  .cal_offsets = { 49, 50, 51 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 0),
+		.offset = 0x100,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8188_AP_SOC2,
+			  .cal_offsets = { 52, 53, 54 } },
+			{ .dt_id = MT8188_AP_SOC3,
+			  .cal_offsets = { 55, 56, 57 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x200,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8188_AP_CAM1,
+			  .cal_offsets = { 58, 59, 60 } },
+			{ .dt_id = MT8188_AP_CAM2,
+			  .cal_offsets = { 61, 62, 63 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x300,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 	{
 		.lvts_sensor = {
@@ -1624,6 +1702,22 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 };
 
+static const struct lvts_data mt8188_lvts_mcu_data = {
+	.lvts_ctrl	= mt8188_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 20,
+};
+
+static const struct lvts_data mt8188_lvts_ap_data = {
+	.lvts_ctrl	= mt8188_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 20,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1659,6 +1753,8 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
+	{ .compatible = "mediatek,mt8188-lvts-mcu", .data = &mt8188_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8188-lvts-ap", .data = &mt8188_lvts_ap_data },
 	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },

