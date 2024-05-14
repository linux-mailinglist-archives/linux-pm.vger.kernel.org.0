Return-Path: <linux-pm+bounces-7804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAA8C4F58
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8891B20D08
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D337D3F0;
	Tue, 14 May 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDvzQbV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHtqRxGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C776F17
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681937; cv=none; b=Q74+a7fTqIeVVghNF4KJxpV/BsxVo+nW5+4NTJZkSaBNKmS431ttutYbdnC0f0OuUXFFmQhDkx71oKCWvyo4Gu70Su4w/ioKD3rdj+9v8gzJ5GSn/A4gYfg1+vz0dz+SZRgnBBT66teBx17ex8V4lyd+1qO/5dLihnDAvtt4HCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681937; c=relaxed/simple;
	bh=IXDJmYimoDbPpzTUassAK01oL+93AzIM9uv7t6i3+D8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EAMDrBsnkzhreH2mrpQjl+GZZxfqu4AxQAdDe3GD1qF4TK7P9rGi0TNJ/gfQML+R7j0TtzB5TfFIkn//zBFmximftnsplqH/+FCYhxttw3cReK3GTjvou2CnjVa39htOkowHcKlN43c9brxZWoGUi3WQUVbyGoQ2Rx+87Ur2ELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDvzQbV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHtqRxGQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LO808ofUb1V1VCEuHdPv2qYwjmNWx5zGs16ctpIY1E=;
	b=uDvzQbV3hjenWsc8z/VdhLWRHvZPA3rtFC2ifaLkSyy2+WNzBhoX8VGEzAMCmbHUrthD22
	UQFi7fobenmC+PStFPWW0h+zyIQE6HVoZfc3jSDBdL7nm/9zGvddnBshKmtikBzzm2seY0
	a/zl3Yhv5b9yCv4hkhhIirZZco3ORqZIPJRnfySH/F+briAAhuLhKCx7DS/9jEnr5EC0+C
	zpQ0omnWI9pTs6x4WgeZj9XgbjwwqKBSMqd8G20NBOlClYc7z8Y2XtPx7L/XRASK0JMnXM
	rRyOVpWWwyWqAz/yTWm2J9aCDdibcxx7uQZxhplWUcsd/bUApljjA8NlBePeeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LO808ofUb1V1VCEuHdPv2qYwjmNWx5zGs16ctpIY1E=;
	b=KHtqRxGQlC4MC5b8KGxzCj9/+u21zaBrj/PP51gXk4tTL60qcyUMjaPT2CVEaQgCbfF3pq
	bkWq8jrp83yiQICw==
From: "thermal-bot for Julien Panis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/mediatek/lvts_thermal: Fix
 wrong lvts_ctrl index
Cc: Julien Panis <jpanis@baylibre.com>, Nicolas Pitre <npitre@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To:
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
References:
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193217.10875.3440853785686625694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     b66c079aabdff3954e93fdd7f52bd8f9ad6482c7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b66c079aabdff3954e93fdd7f52bd8f9ad6482c7
Author:        Julien Panis <jpanis@baylibre.com>
AuthorDate:    Fri, 03 May 2024 17:35:14 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 06 May 2024 10:33:26 +02:00

thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index

In 'lvts_should_update_thresh()' and 'lvts_ctrl_start()' functions,
the parameter passed to 'lvts_for_each_valid_sensor()' macro is always
'lvts_ctrl->lvts_data->lvts_ctrl'. In other words, the array index 0
is systematically passed as 'struct lvts_ctrl_data' type item, even
when another item should be consumed instead.

Hence, the 'valid_sensor_mask' value which is selected can be wrong
because unrelated to the 'struct lvts_ctrl_data' type item that should
be used. Hence, some thermal zone can be registered for a sensor 'i'
that does not actually exist. Because of the invalid address used
as 'lvts_sensor[i].msr', this situation ends up with a crash in
'lvts_get_temp()' function, where this 'msr' pointer is passed to
'readl_poll_timeout()' function. The following message is output:
"Unable to handle kernel NULL pointer dereference at virtual
address <msr>", with <msr> = 0.

This patch fixes the issue.

Fixes: 11e6f4c31447 ("thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 4fa5e74..0bb3a49 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -116,9 +116,9 @@ struct lvts_ctrl_data {
 			      ((s2) ? BIT(2) : 0) | \
 			      ((s3) ? BIT(3) : 0))
 
-#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
+#define lvts_for_each_valid_sensor(i, lvts_ctrl) \
 	for ((i) = 0; (i) < LVTS_SENSOR_MAX; (i)++) \
-		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
+		if (!((lvts_ctrl)->valid_sensor_mask & BIT(i))) \
 			continue; \
 		else
 
@@ -145,6 +145,7 @@ struct lvts_ctrl {
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u32 hw_tshut_raw_temp;
+	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
 	int low_thresh;
@@ -356,7 +357,7 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
 	if (high > lvts_ctrl->high_thresh)
 		return true;
 
-	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
+	lvts_for_each_valid_sensor(i, lvts_ctrl)
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
 		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
 			return false;
@@ -617,6 +618,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		lvts_sensor[i].high_thresh = INT_MIN;
 	};
 
+	lvts_ctrl->valid_sensor_mask = lvts_ctrl_data->valid_sensor_mask;
+
 	return 0;
 }
 
@@ -1112,7 +1115,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	u32 *sensor_bitmap = lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE ?
 			     sensor_imm_bitmap : sensor_filt_bitmap;
 
-	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl) {
 
 		int dt_id = lvts_sensors[i].dt_id;
 

