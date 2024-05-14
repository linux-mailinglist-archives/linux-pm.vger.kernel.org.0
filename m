Return-Path: <linux-pm+bounces-7812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEB28C4F60
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC10282040
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916385C4E;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHpkjMTF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jSAzIohU"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B084D39
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681940; cv=none; b=qHh/l+QjiqB0NiuNy9Mm5rK4f9V+vcZmAneT6PKdlkZv8W/B8zUQm4MqOZYKhOMCG2eHnTbc1UVCc3R5ZmDNBtOnuviuUQMRB9cZ8B2F6Ase69fA2KNJtRl4KzQvTbOJchEStiRStB/Y0OZORK/NcPm3jRwaTWT+//0co4hZies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681940; c=relaxed/simple;
	bh=DRzawKCnqp5UD1l7Fu4ozzH9MPbpJsOrwxlxCaDWmbs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cmRRTEeYMwstBd/DKGbTybfPC5CJja/RXztpE5yfi0vYd6GDtxrbO/y8vfFbJWjuCwRLd69pOE+4+2RxJ5T6ZCs6DSm41oZc0cQ3dZkBbkEq0uqrwRnLT833v20f5baiipIKUOVkSMy8kR8Cjgm2CnROK8fAoJMH5UzdEZE23rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHpkjMTF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jSAzIohU; arc=none smtp.client-ip=193.142.43.55
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
	bh=2GWmkZxE56Z924LNU1enmeUi9jnNR9MHZaDt/aLFcyY=;
	b=iHpkjMTF+0B1GyKZyCG4cb+5k00KMnwsOYjQ96t+CTPpRU4DHuJV5sQYZlrLU7T9TkWbQZ
	yg1Ep/dbKyq0uItoQZzZTH/kx2b/HJlMFXIAt9rY9mGq+xHNdqyvHoo80+vGn4wPvlkD5b
	inpjZW5e86U6+uKgS/6UjHwpDOwQx+N3kweJIftY7aW7cFHP6UugMHhspszr4UMrVfUJx3
	eZpLNJxfaw/74Jbr27fSuvU+od1s+Imk4LGwpMDeolD5XdCnCcHN4GFyEvtzeMUJUKpmfG
	sOMov2qtWHfKXEKPskvh+w3wIRzGSwd2f5rkWCSg+8hzE98NxcVeHbQJttg5xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GWmkZxE56Z924LNU1enmeUi9jnNR9MHZaDt/aLFcyY=;
	b=jSAzIohUixF/37Fmsk/OM3Wq3gZ27jNpGgHGNxxJzCH2FCWC8flOjyw/3m4B+LC6GSAcbw
	7Dlyw2ZBoz5UhuBw==
From: "thermal-bot for Nicolas Pitre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Guard
 against efuse data buffer overflow
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240402032729.2736685-6-nico@fluxnic.net>
References: <20240402032729.2736685-6-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193401.10875.1393372785699330172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     2cc0b1a2169b0f4af83cc5a52a1693c8ab2e2f1d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2cc0b1a2169b0f4af83cc5a52a1693c8ab2e2f1d
Author:        Nicolas Pitre <npitre@baylibre.com>
AuthorDate:    Mon, 01 Apr 2024 23:25:39 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/mediatek/lvts_thermal: Guard against efuse data buffer overflow

We don't want to silently fetch garbage past the actual buffer.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240402032729.2736685-6-nico@fluxnic.net
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 9e6ed8b..1467994 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -672,7 +672,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  */
 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data,
-					u8 *efuse_calibration)
+					u8 *efuse_calibration,
+					size_t calib_len)
 {
 	int i;
 
@@ -680,6 +681,11 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 		const struct lvts_sensor_data *sensor =
 					&lvts_ctrl_data->lvts_sensor[i];
 
+		if (sensor->cal_offsets[0] >= calib_len ||
+		    sensor->cal_offsets[1] >= calib_len ||
+		    sensor->cal_offsets[2] >= calib_len)
+			return -EINVAL;
+
 		lvts_ctrl->calibration[i] =
 			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
 			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
@@ -791,7 +797,8 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 
 		ret = lvts_calibration_init(dev, &lvts_ctrl[i],
 					    &lvts_data->lvts_ctrl[i],
-					    lvts_td->calib);
+					    lvts_td->calib,
+					    lvts_td->calib_len);
 		if (ret)
 			return ret;
 

