Return-Path: <linux-pm+bounces-7810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27418C4F5D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B6AB2098F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8F6D1D7;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBcOVm06";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmDlrtqi"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710684A5B
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681940; cv=none; b=oUGk9BkBSoJYQfvlfntO/+1cE2T4JvnuOlqfWujOfTgjDFe3mBb3ehiag5CzDKB32fUFsdpIDPiBYMzeLhX2sjoEmRIiDEsduNmngbICpkY7SBhFNpkMZgc8UC2zJDC+0qzOR8nOlbLE0VZQx8T/0Ochx3BUg14OHaebVE7KMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681940; c=relaxed/simple;
	bh=aCBGYLvyFOTOBYeW0ZnZyXJDXnuVybQve6izeafgqFw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rWT6oMRVZ5vsmgnvMAYPC1LaaPi/ucZHq/xueonBk5tVkt1SxfjR8DNTVAmJcEV3I5MB21BukaF2KSuss0cmdghef7WegkU1T4H00ZQQX8uPow2ho+b95UV5Ecv0PulWEdHRVuzOCnmfIm2DgmG+RQeCCW1Cif7588fSmL58vLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBcOVm06; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZmDlrtqi; arc=none smtp.client-ip=193.142.43.55
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
	bh=9byDshZaxp6zWvCvHM9nFp2Ud6lIKLiAketIXYFpQSs=;
	b=qBcOVm06QXC2fx8GXn+eWT4KBtHRd2DC9jXyN0PGV9xLhBFcnCj+HeqMpusr8yHi1Ckq8e
	zicVcDaataHjbbXRDJOZy4HKUiop/LeXzTEtk0S8mbg2EwXuoZHUOf+mw2Lm5o3X7i9XH8
	GnlvT1Fg5tcDesF5AMoRg4w6GN6I9MuO+JuDvI1joBqmNLF486E1qIs0sZSBqgnZFaDqrM
	YEPmfzk32mpW2OaGnPCiFwAa9NDbrMWLGgThk0r4nnwXHxYN8cfWgsrG6g50St1n36U+7g
	IRHs1AJCBD/ltEVQvXOKmDi0X4hefX6WTDu8SA58uRl1uQYniD14h7G6D6eXgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9byDshZaxp6zWvCvHM9nFp2Ud6lIKLiAketIXYFpQSs=;
	b=ZmDlrtqixpa+YKlIo0Bsbi13LYIAK4KulHn7mCFiYo1PZLQ+kWSUFbWLetDRwPBNBZ23a3
	SYo+wDSsOiSa1uDg==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Provision for gt variable location
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-11-nico@fluxnic.net>
References: <20240402032729.2736685-11-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193361.10875.5307231842748230325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     684cbb49f9ceed6be0f33dac9d62089e7cd1c032
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//684cbb49f9ceed6be0f33dac9d62089e7cd1c032
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:44 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/mediatek/lvts_thermal: Provision for gt variable location

The golden temperature calibration value in nvram is not always the
3rd byte. A future commit will prove this assumption wrong.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-11-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 6f711ae..34f5a81 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -116,6 +116,7 @@ struct lvts_data {
 	int num_lvts_ctrl;
 	int temp_factor;
 	int temp_offset;
+	int gt_calib_bit_offset;
 };
 
 struct lvts_sensor {
@@ -745,20 +746,21 @@ static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td
 	return 0;
 }
 
-static int lvts_golden_temp_init(struct device *dev, u8 *calib, int temp_offset)
+static int lvts_golden_temp_init(struct device *dev, u8 *calib,
+				 const struct lvts_data *lvts_data)
 {
 	u32 gt;
 
 	/*
-	 * The golden temp information is contained in the 4th byte (index = 3)
-	 * of efuse data.
+	 * The golden temp information is contained in the first 32-bit
+	 * word  of efuse data at a specific bit offset.
 	 */
-	gt = calib[3];
+	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
 	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
-	golden_temp_offset = golden_temp * 500 + temp_offset;
+	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
 
 	return 0;
 }
@@ -777,7 +779,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 	if (ret)
 		return ret;
 
-	ret = lvts_golden_temp_init(dev, lvts_td->calib, lvts_data->temp_offset);
+	ret = lvts_golden_temp_init(dev, lvts_td->calib, lvts_data);
 	if (ret)
 		return ret;
 
@@ -1600,6 +1602,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1607,6 +1610,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8186_lvts_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1614,6 +1618,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1621,6 +1626,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1628,6 +1634,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1635,6 +1642,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset = 24,
 };
 
 static const struct of_device_id lvts_of_match[] = {

