Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737784FCEA
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFWQmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34698 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFWQmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so5800074pgn.1;
        Sun, 23 Jun 2019 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61YRhTYZzpPAbsdw4ql6MdZ8eDEIqaY2tionq5H4meo=;
        b=Wzrz9SjgCzNqQkzWoSMQqAL1h3gNd+lI94LXDB/ydu9Z8V5mO205tsym53MOSa7sW5
         +6rdMWKOr4rPzevDBAEwwn3hxXiQFvYk7nzcRCamQ4cpeaOe1lTnd39tYp3QLHotHkrf
         H9Gqqwx9cuvPLmydJrXROfFy7XQX4E0veSpIcrt3VPWOIaWnog2/DdVzcC9SoN7Ly/2y
         y6hbEuiD/dwWJZzid73WhW7L5OeZao0Pqcdwye2c8fGjKNNck19ziC0E0bgNsHHxISq8
         pxrC+K9DVFBjw6xaWwof4EPLGizmWrDNoNj4VJC5mOVV8FoklOpLkYrV4791DFZ69Tll
         znPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61YRhTYZzpPAbsdw4ql6MdZ8eDEIqaY2tionq5H4meo=;
        b=VKGW0ebh7HKmJdLlHciWm56ztzL1EW9A1dJ8AwsJXS+CsuodpZK1ODjbFujPELx8jn
         J1vb+sm/JyNYl2sMwsIJjJlD+6jhvbkuegbwQ9PmWApe8i9NCRX7tIUYIDb47MImvkMt
         RWBkhsXTRDqTnvDK9Ap3IJqYNznTlMJJWe9MYR8bM/5u+hJGHht2oU30hd7p/DpX8dRY
         nUQNhT9b5PjMphzdG8sTJkaz0lGekmsETDHm9ahS96QRe5XL+wTU0fHQD71ir9AGLrH/
         mPA2xOAjSi3AwwmxUz5M3hTjRnCJOqnrflRfP+o/vT2wsUDyX/QPpLU79Q4Dn97JjAA1
         AvLQ==
X-Gm-Message-State: APjAAAXxyjpa2+5Io38uwP3tcsMA3ZD6GUAP8zE52HJB/PMZOrm45lH4
        PWZem9qo+k6qpOc3ynI9Tl4=
X-Google-Smtp-Source: APXvYqzRoYiCci88ppuvAJgfSh+3g9qZBEaERQz6llUSQx4SEJvBp6v+YlGwm14rPG59UsiG008gBQ==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr19678268pjd.72.1561308138834;
        Sun, 23 Jun 2019 09:42:18 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k22sm8405914pfk.157.2019.06.23.09.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:18 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 04/11] thermal: sun8i: get ths sensor number from device compatible
Date:   Sun, 23 Jun 2019 12:41:59 -0400
Message-Id: <20190623164206.7467-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For different socs, the number of ths sensors is different.
So we need to do some work in order to support more soc.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d6918c62682b..c37e1c51a543 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -22,7 +22,6 @@
 
 #define MAX_SENSOR_NUM	4
 
-#define SUN50I_H6_SENSOR_NUM	2
 #define SUN50I_H6_OFFSET	-2794
 #define SUN50I_H6_SCALE		-67
 
@@ -57,7 +56,12 @@ struct tsensor {
 	int				id;
 };
 
+struct ths_thermal_chip {
+	int		sensor_num;
+};
+
 struct ths_device {
+	const struct ths_thermal_chip		*chip;
 	struct device				*dev;
 	struct regmap				*regmap;
 	struct reset_control			*reset;
@@ -117,7 +121,7 @@ static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
 
 	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
 
-	for (i = 0; i < SUN50I_H6_SENSOR_NUM; i++) {
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 
 		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
 			/* clear data irq pending */
@@ -167,7 +171,7 @@ static int sun50i_ths_calibrate(struct ths_device *tmdev)
 		goto out;
 	}
 
-	if (!caldata[0] || callen < 2 + 2 * SUN50I_H6_SENSOR_NUM) {
+	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -190,7 +194,7 @@ static int sun50i_ths_calibrate(struct ths_device *tmdev)
 	 */
 	ft_temp = caldata[0] & FT_TEMP_MASK;
 
-	for (i = 0; i < SUN50I_H6_SENSOR_NUM; i++) {
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 		int reg = (int)caldata[i + 1];
 		int sensor_temp = sun8i_ths_reg2temp(tmdev, reg);
 		int delta, cdata, calib_offest;
@@ -303,10 +307,10 @@ static int sun50i_thermal_init(struct ths_device *tmdev)
 	regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
 		     SUN50I_H6_THS_PC_TEMP_PERIOD(58));
 	/* enable sensor */
-	val = GENMASK(SUN50I_H6_SENSOR_NUM - 1, 0);
+	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
 	regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
 	/* thermal data interrupt enable */
-	val = GENMASK(SUN50I_H6_SENSOR_NUM - 1, 0);
+	val = GENMASK(tmdev->chip->sensor_num - 1, 0);
 	regmap_write(tmdev->regmap, SUN50I_H6_THS_DIC, val);
 
 	return 0;
@@ -317,7 +321,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 	struct thermal_zone_device *tzd;
 	int i;
 
-	for (i = 0; i < SUN50I_H6_SENSOR_NUM; i++) {
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
 		tmdev->sensor[i].tzd =
@@ -343,6 +347,10 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tmdev->dev = dev;
+	tmdev->chip = of_device_get_match_data(&pdev->dev);
+	if (!tmdev->chip)
+		return -EINVAL;
+
 	platform_set_drvdata(pdev, tmdev);
 
 	ret = sun8i_ths_resource_init(tmdev);
@@ -385,8 +393,12 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct ths_thermal_chip sun50i_h6_ths = {
+	.sensor_num = 2,
+};
+
 static const struct of_device_id of_ths_match[] = {
-	{ .compatible = "allwinner,sun50i-h6-ths"},
+	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.17.1

