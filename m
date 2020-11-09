Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D274F2AB775
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKILqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 06:46:44 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43987 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgKILqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 06:46:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436324|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.119563-0.00233504-0.878102;FP=10095001690009343397|2|2|8|0|-1|-1|-1;HT=ay29a033018047187;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.IuV3ekO_1604922387;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuV3ekO_1604922387)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 09 Nov 2020 19:46:37 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mripard@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v2] thermal: sun8i: Use bitmap API instead of open code
Date:   Mon,  9 Nov 2020 19:46:24 +0800
Message-Id: <20201109114624.23035-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The bitmap_* API is the standard way to access data in the bitfield.
So convert irq_ack to return an unsigned long, and make things to use
bitmap API.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
v2:
Make irq_ack to return an unsigned long
---
 drivers/thermal/sun8i_thermal.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f8b13071a6f4..8c80bd06dd9f 100644
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
-- 
2.28.0

