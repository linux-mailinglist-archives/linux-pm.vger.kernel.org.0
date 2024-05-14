Return-Path: <linux-pm+bounces-7814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D058C4F62
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0833282C90
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA284D37;
	Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lu36zrPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbfw8vDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299A84D25
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681941; cv=none; b=pcz0aFJfQMKUwzdAowvvyg0smDBQU9sMEOP9btKGLNwFnYsNI1nGm5WzWRaB/B6FSSOHgof1c6p0wloHpPG5HCBzNtxrIns9eycRFLNVBkJiZqXV2BHE4spq0WuYuuP774o+Snk5orNE63GbJwIMt9HJFLE5EVCsAB9860ygE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681941; c=relaxed/simple;
	bh=ryoLJgr9jF2/u3CVMXHVr6/Iq+dhsL710C6OWbJg+vI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gg1qDRLJ+yIE3cPDTa75Dk6N09vpCB5Bfi5UghLMOdW1hD3gwVvd56ByFKbfDwm+6LHv05j8LERNT+1SjIW34pq7iLCGE3O7Qf83bqji2BxIyB95CqtGfb1JKf29C4bESCAPSDgy8biBU5hPKJmMDS3ZDD2OhEYU0uogY8bADvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lu36zrPb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbfw8vDw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7caSRHgbPgfOWPZgYmQvrAUzEY4YmO1mVR/Yvdbthc=;
	b=Lu36zrPb/k4fMeYiVIc6c90Syq+gWqctZHyeVnpU2gGCxSNr28ZJxlsZffGQO+jhwCCmBf
	S1S1N7QtQe1xx0ib21nVFkOgNer156gCd6uzzxkA7Chz+dwxwm7WvVhFOC40Tb2uWgbAzn
	KTf7YoJGbfehpofVxyLxddQ736S44V8aFdDqQXu1e/kwTALU7mEk4cKeHCynj6XV4ilx1e
	dfVnAYkd19wwlsIx0PdpWjgP2ysHOcgCZ34MxqWY47p+yoy6NYEIXP2e7vvyBny3/WeT4y
	QNi4dWO9wZ7zvZZaA/tv9XRjfVepUWkoOpsyBQ+aCo0bIbWjpMlL0cNwOh6wfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7caSRHgbPgfOWPZgYmQvrAUzEY4YmO1mVR/Yvdbthc=;
	b=zbfw8vDw9OhwND30cOXnUmqGXnkZhUcmnPXrg6wRrLDSPgWvIHNmMnDoppz5am+Uya9b8v
	FJ5r+c7keyj0cUDw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Add
 MT8186 support
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-9-nico@fluxnic.net>
References: <20240402032729.2736685-9-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193372.10875.4876434186759300776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     a4c1ab2f4c6c94edfc6481edf37e141079e24f1d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a4c1ab2f4c6c94edfc6481edf37e141079e24f1d
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:42 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/mediatek/lvts_thermal: Add MT8186 support

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-9-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 61 ++++++++++++++++++++++++-
 1 file changed, 61 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1467994..6f711ae 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1375,6 +1375,59 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
 
+/*
+ * The MT8186 calibration data is stored as packed 3-byte little-endian
+ * values using a weird layout that makes sense only when viewed as a 32-bit
+ * hexadecimal word dump. Let's suppose SxBy where x = sensor number and
+ * y = byte number where the LSB is y=0. We then have:
+ *
+ *   [S0B2-S0B1-S0B0-S1B2] [S1B1-S1B0-S2B2-S2B1] [S2B0-S3B2-S3B1-S3B0]
+ *
+ * However, when considering a byte stream, those appear as follows:
+ *
+ *   [S1B2] [S0B0[ [S0B1] [S0B2] [S2B1] [S2B2] [S1B0] [S1B1] [S3B0] [S3B1] [S3B2] [S2B0]
+ *
+ * Hence the rather confusing offsets provided below.
+ */
+static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8186_LITTLE_CPU0,
+			  .cal_offsets = { 5, 6, 7 } },
+			{ .dt_id = MT8186_LITTLE_CPU1,
+			  .cal_offsets = { 10, 11, 4 } },
+			{ .dt_id = MT8186_LITTLE_CPU2,
+			  .cal_offsets = { 15, 8, 9 } },
+			{ .dt_id = MT8186_CAM,
+			  .cal_offsets = { 12, 13, 14 } }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x0,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8186_BIG_CPU0,
+			  .cal_offsets = { 22, 23, 16 } },
+			{ .dt_id = MT8186_BIG_CPU1,
+			  .cal_offsets = { 27, 20, 21 } }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8186_NNA,
+			  .cal_offsets = { 29, 30, 31 } },
+			{ .dt_id = MT8186_ADSP,
+			  .cal_offsets = { 34, 35, 28 } },
+			{ .dt_id = MT8186_MFG,
+			  .cal_offsets = { 39, 32, 33 } }
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x200,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 	{
 		.lvts_sensor = {
@@ -1549,6 +1602,13 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 };
 
+static const struct lvts_data mt8186_lvts_data = {
+	.lvts_ctrl	= mt8186_lvts_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT7988,
+	.temp_offset	= LVTS_COEFF_B_MT7988,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1579,6 +1639,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
+	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
 	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },

