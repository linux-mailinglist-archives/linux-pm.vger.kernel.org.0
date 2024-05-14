Return-Path: <linux-pm+bounces-7821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBE08C4F68
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA62282727
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E11292D2;
	Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NG+EK4L7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBxBCk9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646A84D39
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681943; cv=none; b=XstDeKPGfsDZsDIO0dt3IqXYVNgrurWFNmPXT4BMzT275CWPYaLZzjIjmY1C6bf3th8DTP1BHLDVa+4B0tB+q00xN1PAAizUGvN+kNdpSWIE2ho8yT6OUuqqmFEz4Zobpsnx/o0RW5xBW9tgSPs47G33+b3SIIlEQpSIhlHBP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681943; c=relaxed/simple;
	bh=NeWWjY8szsjyOpScvdmBwX3GsAN4Af3RNdvrqD0oYqw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P+O/Qm/XvpIDBjGTGR0kBH/UeR1VEfXWLwj1GVUq9lHsnthmCg7yEdccmIPfvOyhOulEbd+hVUIq4qzgLfBTubj4ynAlaP+aOP5+Emh6V4ptNsff4AqcNtIZoa4Lml/z2qS2dGif1IwZlP2HY7REACG5oQcJQmZ1wOCR1/j52+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NG+EK4L7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mBxBCk9T; arc=none smtp.client-ip=193.142.43.55
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
	bh=D/tI6FjEI6GYRpb1IFzMQbDD44TEtmRgNkidz0RpReM=;
	b=NG+EK4L7io+L+ZRS3W7hjXjkVnEQkemNfVbyvbnNHdfn/srnVRuuyfVdks3sjhkI3x7wLW
	rl6xZsB8XmUfA+oAWIpa5vmguUfQFp3ksc/OCMxxvL5HsCzH54DPhKAFxTJEYSi40uZWmP
	UpwJhlolEu0Q4bDsG0NnFyI6WLSiBVCNsJdkQc+olP6+sIfVlJ9Ra9dWOZv+E0SBLcsbgQ
	9mKUlJfvr6rUqVJdVX9Ucn2KX8f5bi+qEbVyhTKe9FngoSbk6D8uBbDv4f+hThqU7RuuR6
	c+2brhcxEnvrmQ439e5eBNVNCaLpsN2yUaxQEmBJqb+CAXUebYC15gkjGvI4og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/tI6FjEI6GYRpb1IFzMQbDD44TEtmRgNkidz0RpReM=;
	b=mBxBCk9TPNx/b5Vhf0h5uOWsUeQE72cY25o1FHRwCtjUe2snY4vMsuM8bJqL5vQ25TfoeL
	H5nR5zxTndCuD6AA==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Remove .hw_tshut_temp
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-4-nico@fluxnic.net>
References: <20240402032729.2736685-4-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193425.10875.6263582555163051690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     554bca31308ab8234bac505d0b86d9082b549a40
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//554bca31308ab8234bac505d0b86d9082b549a40
Author:        Nicolas Pitre <nico@fluxnic.net>
AuthorDate:    Mon, 01 Apr 2024 23:25:37 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Remove .hw_tshut_temp

All the .hw_tshut_temp instances are initialized with the same value.
Let's remove those and use a common definition instead. If ever a
different value must be used in the future then an override parameter
could be added back.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-4-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0401162..08cf379 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -91,9 +91,7 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
-#define LVTS_HW_SHUTDOWN_MT7988		105000
-#define LVTS_HW_SHUTDOWN_MT8192		105000
-#define LVTS_HW_SHUTDOWN_MT8195		105000
+#define LVTS_HW_TSHUT_TEMP		105000
 
 #define LVTS_MINIMUM_THRESHOLD		20000
 
@@ -107,7 +105,6 @@ struct lvts_sensor_data {
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	int cal_offset[LVTS_SENSOR_MAX];
-	int hw_tshut_temp;
 	int num_lvts_sensor;
 	int offset;
 	int mode;
@@ -801,7 +798,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 * after initializing the calibration.
 		 */
 		lvts_ctrl[i].hw_tshut_raw_temp =
-			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp,
+			lvts_temp_to_raw(LVTS_HW_TSHUT_TEMP,
 					 lvts_data->temp_factor);
 
 		lvts_ctrl[i].low_thresh = INT_MIN;
@@ -1311,7 +1308,6 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x0,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
 	},
 	{
 		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
@@ -1323,7 +1319,6 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x100,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
 	}
 };
 
@@ -1368,7 +1363,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
@@ -1379,7 +1373,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
@@ -1392,7 +1385,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x200,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
@@ -1406,7 +1398,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset = { 0x2c, 0x30 },
@@ -1416,7 +1407,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset = { 0x34, 0x38 },
@@ -1426,7 +1416,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x200,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset = { 0x3c, 0x40, 0x44 },
@@ -1437,7 +1426,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 3,
 		.offset = 0x300,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
 	}
 };
 
@@ -1450,7 +1438,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset = { 0x0d, 0x10 },
@@ -1460,7 +1447,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset = { 0x16, 0x19, 0x1c, 0x1f },
@@ -1472,7 +1458,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 4,
 		.offset = 0x200,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	}
 };
 
@@ -1485,7 +1470,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x0,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset = { 0x2e, 0x31 },
@@ -1495,7 +1479,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x100,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset = { 0x37, 0x3a, 0x3d },
@@ -1506,7 +1489,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 3,
 		.offset = 0x200,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset = { 0x43, 0x46 },
@@ -1516,7 +1498,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 		},
 		.num_lvts_sensor = 2,
 		.offset = 0x300,
-		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
 	}
 };
 

