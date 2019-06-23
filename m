Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA74FCD1
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfFWQm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34774 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfFWQm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so6126297pfc.1;
        Sun, 23 Jun 2019 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wEqIKiIjMDW4aKJ2RgXaFik3U88pUoE48jM/nfBTuhA=;
        b=OvgjTayEeWn9V1P+UsSgcRUgHzKlA20WHH1U2kasI2U4zb1dZGsyz8z+mFheACxqL1
         kPQOapIXQt8yaWoIMb9oE6e8TmtvbvSh0mKDrymGbV6gADJwZzIR14jVItFURLk/R1O4
         +GScwEEjNqEtdFG/g4cvA6puWFeFqK8UA8P6UhcnIk1zjq0E2eP5akr8PRqW2ZIUSbTx
         1ltLgVyXxvuDz8eJtBiiJtFFEgqCocluxqoAs7ahM06e73JXU346rRymL3oOaaneDdSB
         GguJpVfIgppIARigTk4XyddmTJ6SS8LyjzNMqcjcAQpIDW4PpUFX5jAPUxqtvjAC9y5x
         +blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wEqIKiIjMDW4aKJ2RgXaFik3U88pUoE48jM/nfBTuhA=;
        b=EOxzDmNofYvxZMSiUAXRHhW4lcG1FJ5j1LpYHY6TFOtLarWrJH271FtqJvMqK58SqG
         X3jSQ2lEbSuKiPXTIhX3PgEwj/1itG4I2ZoD6+35M3f2x5DXjYWPIhw98yoL35neFats
         Crz/OABFwe2onOfIRFaVUr985qYwrKbF9oNWopTAAw79QsjohjDoPC6tfBWZWfbcRv34
         RW1FkgL5E6N3tjpq1AuJsadYILnEmNpGKFii7GVa48c0ETi2CJxvUrhpWtpOAoGeNg6V
         /ASp69pAlwK0h6Jes0SmOLD2emEeEPhjFHcorEzMLldtCTiqXmtPIyJ3R18EkREjOhSl
         0Zcw==
X-Gm-Message-State: APjAAAX6LmksPcNcy8Yvay3u7vYbnrDhsqeZetQmynzMZJLYcrzfxfTC
        LawVSVLW7ILDATcIiWfhhrY=
X-Google-Smtp-Source: APXvYqzqdPeNJDKT2GHT0UxSYGePTtYbn2c7WuA7YrqBRcCXj1cMwuqZDcNhsdj2Me9OR655VE0O4g==
X-Received: by 2002:a63:a046:: with SMTP id u6mr12950599pgn.122.1561308146440;
        Sun, 23 Jun 2019 09:42:26 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a3sm9503098pfo.49.2019.06.23.09.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:25 -0700 (PDT)
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
Subject: [PATCH v4 07/11] thermal: sun8i: rework for ths irq handler func
Date:   Sun, 23 Jun 2019 12:42:02 -0400
Message-Id: <20190623164206.7467-8-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here, we do something to prepare for the subsequent
support of multiple platforms.

1) rename sun50i_h6_irq_thread to sun8i_irq_thread, because
   this function should be suitable for all platforms.

2) introduce irq_ack callback to mask interrupt register
   differences.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 59acbbac76e4..ed1c19bb27cf 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -60,6 +60,7 @@ struct ths_thermal_chip {
 	int		ft_deviation;
 	int		temp_data_base;
 	int		(*init)(struct ths_device *tmdev);
+	int             (*irq_ack)(struct ths_device *tmdev);
 };
 
 struct ths_device {
@@ -116,23 +117,34 @@ static const struct regmap_config config = {
 	.fast_io = true,
 };
 
-static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
+static int sun50i_h6_irq_ack(struct ths_device *tmdev)
 {
-	struct ths_device *tmdev = data;
-	int i, state;
+	int i, state, ret = 0;
 
 	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-
 		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
-			/* clear data irq pending */
 			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
 				     SUN50I_H6_THS_DATA_IRQ_STS(i));
+			ret |= BIT(i);
+		}
+	}
+
+	return ret;
+}
 
+static irqreturn_t sun8i_irq_thread(int irq, void *data)
+{
+	struct ths_device *tmdev = data;
+	int i, state;
+
+	state = tmdev->chip->irq_ack(tmdev);
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		if (state & BIT(i))
 			thermal_zone_device_update(tmdev->sensor[i].tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
-		}
 	}
 
 	return IRQ_HANDLED;
@@ -377,7 +389,7 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	 * the end.
 	 */
 	ret = devm_request_threaded_irq(dev, irq, NULL,
-					sun50i_h6_irq_thread,
+					sun8i_irq_thread,
 					IRQF_ONESHOT, "ths", tmdev);
 	if (ret)
 		return ret;
@@ -402,6 +414,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.ft_deviation = SUN50I_H6_FT_DEVIATION,
 	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
 	.init = sun50i_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

