Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652361CBEDF
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEIIXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 04:23:33 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:35658 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgEIIXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 04:23:33 -0400
Received: from localhost.localdomain ([93.22.149.123])
        by mwinf5d73 with ME
        id cYPT2200N2fyvbx03YPU05; Sat, 09 May 2020 10:23:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 May 2020 10:23:29 +0200
X-ME-IP: 93.22.149.123
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     milo.kim@ti.com, sre@kernel.org, anton.vorontsov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] power: supply: lp8788: Fix an error handling path in 'lp8788_charger_probe()'
Date:   Sat,  9 May 2020 10:23:23 +0200
Message-Id: <20200509082323.223884-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the probe function, in case of error, resources allocated in
'lp8788_setup_adc_channel()' must be released.

This can be achieved easily by using the devm_ variant of
'iio_channel_get()'.
This has the extra benefit to simplify the remove function and to axe the
'lp8788_release_adc_channel()' function which is now useless.

Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
V2: use devm_iio_channel_get instead of iio_channel_get and simplify code
---
 drivers/power/supply/lp8788-charger.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 84a206f42a8e..e7931ffb7151 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -572,27 +572,14 @@ static void lp8788_setup_adc_channel(struct device *dev,
 		return;
 
 	/* ADC channel for battery voltage */
-	chan = iio_channel_get(dev, pdata->adc_vbatt);
+	chan = devm_iio_channel_get(dev, pdata->adc_vbatt);
 	pchg->chan[LP8788_VBATT] = IS_ERR(chan) ? NULL : chan;
 
 	/* ADC channel for battery temperature */
-	chan = iio_channel_get(dev, pdata->adc_batt_temp);
+	chan = devm_iio_channel_get(dev, pdata->adc_batt_temp);
 	pchg->chan[LP8788_BATT_TEMP] = IS_ERR(chan) ? NULL : chan;
 }
 
-static void lp8788_release_adc_channel(struct lp8788_charger *pchg)
-{
-	int i;
-
-	for (i = 0; i < LP8788_NUM_CHG_ADC; i++) {
-		if (!pchg->chan[i])
-			continue;
-
-		iio_channel_release(pchg->chan[i]);
-		pchg->chan[i] = NULL;
-	}
-}
-
 static ssize_t lp8788_show_charger_status(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -735,7 +722,6 @@ static int lp8788_charger_remove(struct platform_device *pdev)
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
 	lp8788_psy_unregister(pchg);
-	lp8788_release_adc_channel(pchg);
 
 	return 0;
 }
-- 
2.25.1

