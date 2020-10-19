Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47C2926DC
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgJSL6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 07:58:51 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:36308 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgJSL6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 07:58:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07483579|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0805089-0.00178873-0.917702;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.IlUILxe_1603108718;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IlUILxe_1603108718)
          by smtp.aliyun-inc.com(10.147.41.120);
          Mon, 19 Oct 2020 19:58:43 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mripard@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH] thermal: sun8i: Use bitmap API instead of open code
Date:   Mon, 19 Oct 2020 19:58:36 +0800
Message-Id: <20201019115836.13982-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Thw bitmap_* API is the standard way to access data in the bitfield.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/thermal/sun8i_thermal.c | 35 +++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f8b13071a6f4..f2e4a4f18101 100644
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
+	void		(*irq_ack)(struct ths_device *tmdev);
 	int		(*calc_temp)(struct ths_device *tmdev,
 				     int id, int reg);
 };
@@ -82,6 +83,7 @@ struct ths_thermal_chip {
 struct ths_device {
 	const struct ths_thermal_chip		*chip;
 	struct device				*dev;
+	DECLARE_BITMAP(irq_bitmap, MAX_SENSOR_NUM);
 	struct regmap				*regmap;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
@@ -146,9 +148,11 @@ static const struct regmap_config config = {
 	.max_register = 0xfc,
 };
 
-static int sun8i_h3_irq_ack(struct ths_device *tmdev)
+static void sun8i_h3_irq_ack(struct ths_device *tmdev)
 {
-	int i, state, ret = 0;
+	int i, state;
+
+	bitmap_zero(tmdev->irq_bitmap, tmdev->chip->sensor_num);
 
 	regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
 
@@ -156,16 +160,16 @@ static int sun8i_h3_irq_ack(struct ths_device *tmdev)
 		if (state & SUN8I_THS_DATA_IRQ_STS(i)) {
 			regmap_write(tmdev->regmap, SUN8I_THS_IS,
 				     SUN8I_THS_DATA_IRQ_STS(i));
-			ret |= BIT(i);
+			bitmap_set(tmdev->irq_bitmap, i, 1);
 		}
 	}
-
-	return ret;
 }
 
-static int sun50i_h6_irq_ack(struct ths_device *tmdev)
+static void sun50i_h6_irq_ack(struct ths_device *tmdev)
 {
-	int i, state, ret = 0;
+	int i, state;
+
+	bitmap_zero(tmdev->irq_bitmap, tmdev->chip->sensor_num);
 
 	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
 
@@ -173,24 +177,21 @@ static int sun50i_h6_irq_ack(struct ths_device *tmdev)
 		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
 			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
 				     SUN50I_H6_THS_DATA_IRQ_STS(i));
-			ret |= BIT(i);
+			bitmap_set(tmdev->irq_bitmap, i, 1);
 		}
 	}
-
-	return ret;
 }
 
 static irqreturn_t sun8i_irq_thread(int irq, void *data)
 {
 	struct ths_device *tmdev = data;
-	int i, state;
+	int i;
 
-	state = tmdev->chip->irq_ack(tmdev);
+	tmdev->chip->irq_ack(tmdev);
 
-	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		if (state & BIT(i))
-			thermal_zone_device_update(tmdev->sensor[i].tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
+	for_each_set_bit(i, tmdev->irq_bitmap, tmdev->chip->sensor_num) {
+		thermal_zone_device_update(tmdev->sensor[i].tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
 	}
 
 	return IRQ_HANDLED;
-- 
2.28.0

