Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97258886D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfHJF30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46342 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so45751055plz.13;
        Fri, 09 Aug 2019 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+FeoUxxKT842NGkzufNDhEKbfyCpMTH+IlMbjC5ho0=;
        b=pU5BLjCRcTZ/VPToncNLJ17hv0w7PjaSu2tdFCtXRP8nxKDCrIcNTCwadd2D0xijyo
         eAmL5d7fM9Bqj5JMO0bWuRDqTzt6T5w94dx0Rvd5yB8QkKcUkD7wwEMgvuypDPGI2DbN
         Lp5BaEh1H/UzVwo4EPqJ6VDogz1FntOqINDk3/7VQH7a2gfaLodoFbBM8WEKlOpgC3aT
         bXylqnlatMGFvTyNTKD4K5zES0dlkjWV+Zm/hyeoCdpdSJPnT6pU3OGUAgjnG8cHD0/3
         9fNLGFMwdfYY4BDCX1PQM0arHQ+6GkypQd/MPOtgfyvt3/v0pTk9B9t+sgVh0brl7XjX
         S58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+FeoUxxKT842NGkzufNDhEKbfyCpMTH+IlMbjC5ho0=;
        b=AC7tuFLh2MMUTosNsf+tYTIOiFY3/sNogNiF9JWLcuGa7+q825rVDTo4oYC6PlFvOL
         b9Q/bfA4xlJhV+PICJwXS0vwSsG+PDOQWlyXSoHsE9xKUamBIezxgiVwMftB5Na8TLTD
         S9GS1ECvXgUl2+kH9+ciKn9jPzlRyZIeqzZlKHL/INas3nfC9TqhgEt8A4of6X08pt7t
         8TKFYDxzDN8uFAeAKzFQyeHO10M7uMmR7aEZMunHtxpRZ2ZGlSJB48x6/LK27gGosarJ
         PXnYQGSVQqEAYOHdmOE0OGztJCXJB5GOymdfAVp9gCDwB3i+0aJZpLX7PCogf8JHmeYE
         Uqaw==
X-Gm-Message-State: APjAAAXRi+R/YHB8+xLD3p2Au49Sjtem+9e+GvhxfUtT+o7PFSNavikS
        DTgc7OtU+Ws82BJ/D0dnQ80=
X-Google-Smtp-Source: APXvYqxNEyT0QTjr6XVkWXmgzgtE9iVa3pELQsprz/kPLk9VCe/zWE/jEywdQraspTO4ZVuGa/X+oA==
X-Received: by 2002:a17:902:e30d:: with SMTP id cg13mr22644366plb.173.1565414965732;
        Fri, 09 Aug 2019 22:29:25 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id h20sm1062446pfq.156.2019.08.09.22.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:25 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 04/18] thermal: sun8i: get ths sensor number from device compatible
Date:   Sat, 10 Aug 2019 05:28:15 +0000
Message-Id: <20190810052829.6032-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
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
index 2ce36fa3fec3..e9c2acbaac74 100644
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
 		int delta, cdata, offset;
@@ -297,10 +301,10 @@ static int sun50i_h6_thermal_init(struct ths_device *tmdev)
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
@@ -311,7 +315,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 	struct thermal_zone_device *tzd;
 	int i;
 
-	for (i = 0; i < SUN50I_H6_SENSOR_NUM; i++) {
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
 		tmdev->sensor[i].tzd =
@@ -337,6 +341,10 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tmdev->dev = dev;
+	tmdev->chip = of_device_get_match_data(&pdev->dev);
+	if (!tmdev->chip)
+		return -EINVAL;
+
 	platform_set_drvdata(pdev, tmdev);
 
 	ret = sun8i_ths_resource_init(tmdev);
@@ -379,8 +387,12 @@ static int sun8i_ths_remove(struct platform_device *pdev)
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

