Return-Path: <linux-pm+bounces-9031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF89059B0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 19:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60151C20C88
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D58181BAA;
	Wed, 12 Jun 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kN37nwj9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmJN45tk"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5816C84F
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212345; cv=none; b=ZjWJYd4WpdDQPllkUDZPNzGtH+5rIetrDfSyJr2VIeTmxRKFJ1UJf4NK+JF/VMf+INMP8PzIKmTgpZVMavq/8Y0fcxwsX4c1YBfGgN6102kP3CK4Ha36O3KGIX4WgiFWh1siGaCxQQCoOHDCtwKhAeKRzRwEy1UX9xe6JkgZYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212345; c=relaxed/simple;
	bh=Nt/AcKOWat+ZmW7/AcMDxs2p2wprNAUZJSENab+C0pQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VcaC7I6Jv1/n+mn3RTtB7agtqa1y86rbF4Nh3Ek3+ykNvw3BGslTg3c4BiXDnwwqenq5hYaeqR8nFySYzxqGfgYHo/HtpKTnyDDwGf1ng6vao/f1etTKMGkXRiJL27HSNITJ70hdQvAG0ons7iIV3fQ0BQlfXxUP+c8hXTe6ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kN37nwj9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmJN45tk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 17:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718212342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPNxzdbhHg0XDq1AB54iwK5MpRCcIQyy9UCsg7KK418=;
	b=kN37nwj9Jppbsl2ETEmm75B9LTP11j5AU9H75HELVo+QZl30J7UiXtRn+bD4ovfsd1oK82
	OxP+nwbeBYVluGt04Lcf6Kh3cXDT1o7UMVP9Zv+X0MkIk9fp5rpz2bOv5KemHn5KjenGU0
	9VgyE3N9qiH3VYR5WntLuxbA2WpvpoP6cGpndaMOdtNMphggSM5KTr84qBoHWhcrwHbF2x
	x6ERUartoffa+BKlCUMXSeM/+8ERdaRNp14LBp48TshGCZwCl8Uj8xG0shjUyCvS12HqL2
	25YjR1qlcABGtoi7HhHvcdjnYTtNOMOn5sYW1cqFcyanndcqUJeLFB4KOqjpeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718212342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPNxzdbhHg0XDq1AB54iwK5MpRCcIQyy9UCsg7KK418=;
	b=wmJN45tksWe+08HDH8rp1vuIW1Zc1m+/Z9EPNDee95dp/bWpZIny9kgUCN/ICs1HkHdFOW
	Pi1m4UN6ADe+c1BQ==
From: "thermal-bot for Julien Panis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal:
 Return error in case of invalid efuse data
Cc: Julien Panis <jpanis@baylibre.com>, Nicolas Pitre <npitre@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171821234190.10875.1852169724815566067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     72cacd06e47d86d89b0e7179fbc9eb3a0f39cd93
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//72cacd06e47d86d89b0e7179fbc9eb3a0f39cd93
Author:        Julien Panis <jpanis@baylibre.com>
AuthorDate:    Tue, 04 Jun 2024 18:46:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 12 Jun 2024 19:07:34 +02:00

thermal/drivers/mediatek/lvts_thermal: Return error in case of invalid efuse data

This patch prevents from registering thermal entries and letting the
driver misbehave if efuse data is invalid. A device is not properly
calibrated if the golden temperature is zero.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 82c355c..819ed01 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	 */
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
-	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+	/* A zero value for gt means that device has invalid efuse data */
+	if (!gt)
+		return -ENODATA;
+
+	if (gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;

