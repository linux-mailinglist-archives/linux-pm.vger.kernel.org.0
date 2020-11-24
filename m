Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB922C2197
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgKXJgq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgKXJgl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02925C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:36:41 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNlFZCEV9vHuzyBDPDF80McHvHB0YadK7F/rDVCN6Hw=;
        b=2i4LyS/sUDL/ydQ1f+WmZj9c0XoQQTIwVucLYiY52AzlT7u1/WhYyTFImsHJ3/+FgJcdI8
        I8QwvEhoBfnv9d6sXN+Mvxv/vhs09ST76LdzLItPePvRcRdgGoN6XWcu9xs/6pDikjcPhR
        FAR5YxBTSx9FRUdszR5/BZAMy0xz/fAnmtuT8d7pKqMgfwAqaS3zMbHfUze/l2qnxYfqO4
        x5CLVhP5LT/uqo5GbIvTAWGHc/HEtBQO+s3BPd4vrKKpsAb8DbVQG3/Co0PLIt9q+EQhTm
        orkp5Pfo60sxrHF/ZhXmEt7+mAbzFVu4a4FESDegXiuGlhA22QFSRZYWiGJ76g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNlFZCEV9vHuzyBDPDF80McHvHB0YadK7F/rDVCN6Hw=;
        b=NbxiB3IC31zzJwEFY5fmT2XGerdC4b+LbdD257UfNi/ZlbB4bGdJ5ohCdNaPAZ6aww5G7g
        wGhqHgZOMZLuBRAg==
From:   "thermal-bot for Yangtao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: sun8i: Use bitmap API instead of open code
Cc:     Yangtao Li <frank@allwinnertech.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201109114624.23035-1-frank@allwinnertech.com>
References: <20201109114624.23035-1-frank@allwinnertech.com>
MIME-Version: 1.0
Message-ID: <160621059850.11115.4933980390217289137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e01aac535353e013f9a5c9675232458906b895da
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e01aac535353e013f9a5c9675232458906b895da
Author:        Yangtao Li <frank@allwinnertech.com>
AuthorDate:    Mon, 09 Nov 2020 19:46:24 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 12 Nov 2020 11:05:12 +01:00

thermal: sun8i: Use bitmap API instead of open code

The bitmap_* API is the standard way to access data in the bitfield.
So convert irq_ack to return an unsigned long, and make things to use
bitmap API.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201109114624.23035-1-frank@allwinnertech.com
---
 drivers/thermal/sun8i_thermal.c | 33 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f8b1307..8c80bd0 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -8,6 +8,7 @@
  * Based on the work of Josef Gajdusek <atx@atx.name>
  */
 
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -74,7 +75,7 @@ struct ths_thermal_chip {
 	int		(*calibrate)(struct ths_device *tmdev,
 				     u16 *caldata, int callen);
 	int		(*init)(struct ths_device *tmdev);
-	int             (*irq_ack)(struct ths_device *tmdev);
+	unsigned long	(*irq_ack)(struct ths_device *tmdev);
 	int		(*calc_temp)(struct ths_device *tmdev,
 				     int id, int reg);
 };
@@ -146,9 +147,10 @@ static const struct regmap_config config = {
 	.max_register = 0xfc,
 };
 
-static int sun8i_h3_irq_ack(struct ths_device *tmdev)
+static unsigned long sun8i_h3_irq_ack(struct ths_device *tmdev)
 {
-	int i, state, ret = 0;
+	unsigned long irq_bitmap = 0;
+	int i, state;
 
 	regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
 
@@ -156,16 +158,17 @@ static int sun8i_h3_irq_ack(struct ths_device *tmdev)
 		if (state & SUN8I_THS_DATA_IRQ_STS(i)) {
 			regmap_write(tmdev->regmap, SUN8I_THS_IS,
 				     SUN8I_THS_DATA_IRQ_STS(i));
-			ret |= BIT(i);
+			bitmap_set(&irq_bitmap, i, 1);
 		}
 	}
 
-	return ret;
+	return irq_bitmap;
 }
 
-static int sun50i_h6_irq_ack(struct ths_device *tmdev)
+static unsigned long sun50i_h6_irq_ack(struct ths_device *tmdev)
 {
-	int i, state, ret = 0;
+	unsigned long irq_bitmap = 0;
+	int i, state;
 
 	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
 
@@ -173,24 +176,22 @@ static int sun50i_h6_irq_ack(struct ths_device *tmdev)
 		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
 			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
 				     SUN50I_H6_THS_DATA_IRQ_STS(i));
-			ret |= BIT(i);
+			bitmap_set(&irq_bitmap, i, 1);
 		}
 	}
 
-	return ret;
+	return irq_bitmap;
 }
 
 static irqreturn_t sun8i_irq_thread(int irq, void *data)
 {
 	struct ths_device *tmdev = data;
-	int i, state;
-
-	state = tmdev->chip->irq_ack(tmdev);
+	unsigned long irq_bitmap = tmdev->chip->irq_ack(tmdev);
+	int i;
 
-	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		if (state & BIT(i))
-			thermal_zone_device_update(tmdev->sensor[i].tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
+	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
+		thermal_zone_device_update(tmdev->sensor[i].tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
 	}
 
 	return IRQ_HANDLED;
