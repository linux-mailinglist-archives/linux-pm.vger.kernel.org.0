Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC702A0550
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3M1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgJ3M07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:26:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D9C0613D4
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 05:26:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v19so1726616lji.5
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9vyRXhA7QUm04cJ+c+59yrdZeMSNND2vqWl4Gn+l6k=;
        b=tAejCbiAXF71AYcGV24Wj8x6RE5rgUofsSSFRnLKzAi5AueGwryTjbPXQEOqDhgH1+
         l+IltCn02h9JluuUqywKU0gW81L87cb0oZv9r1ppNHhVeRYrHFmJ9RNG9WB9qtHLuIzL
         NGqfRGJLCQlMJFYKXpTynqRivwRQh07HHwqy3MNBQ3amJq04QeWLzfJXDq3TYHhauYla
         Qyh/M4L82Ziq2vD6QE8E/+a8yaXMjthaAQ6DnLtolISDCKw9Xl+YFq7Ug6grSu6SVxv5
         VPnGCN8gPVEKGvqC4uTgykWw7C75JKJupZJuwwunAWo3AsvkaDmn9pu01x/M5UrFp6ph
         DTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9vyRXhA7QUm04cJ+c+59yrdZeMSNND2vqWl4Gn+l6k=;
        b=XjKiGAZzSp9JH0xG5mgkuGhn9oddXH7OVZgUpx/LqysrcBJCwTmHvW3TI6nEuaEyYH
         G0ASl0LZ5IVOe2AlrOM58GMQN1PMKyfpJuWsXCpfppt+h58RXc/dujChfuA7OvAblb/y
         DlaN9dxOvD7ILeHyYN97crr8qfLH3AKmJfCqEFeFsmz623wQ3Dy/8xeY9giRGW8lYB49
         E/jfVpaY6YNzhATm8nNEu2RlDQk/xaLkzYZsaXsUD66FdukgmI3ETdXEBjkyWbcBxfoc
         6XZUsZCZcoLE3PW+7UJoigj9EMlkVC/A6kTX8Xs8qYV5E2jBGGMobS6ZHrAWxlE1xBSt
         +0xQ==
X-Gm-Message-State: AOAM5334lPrVCn0jS8zLMS6A6+bJ6hTs1ogWPCj8ToKbrxTtUII34Gur
        eQnr/SVoshmkEBGDTM44fF0Khw==
X-Google-Smtp-Source: ABdhPJx2hs7Z9Qr3bxl/VBChbReY60gqaRepCs+a1l4yKy2NHrOK0P7XvYFQA/58VjvQs/6L0H72dw==
X-Received: by 2002:a2e:7d06:: with SMTP id y6mr894160ljc.431.1604060786808;
        Fri, 30 Oct 2020 05:26:26 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id i6sm218684lfl.7.2020.10.30.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:26:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Anish Kumar <anish198519851985@gmail.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] power: supply: generic-adc-battery: Use GPIO descriptors
Date:   Fri, 30 Oct 2020 13:24:24 +0100
Message-Id: <20201030122424.85686-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver uses platform data to pass GPIO lines using the
deprecated global GPIO numbers. There are no in-tree users
of this platform data.

Any out-of-tree or coming users of this driver can easily be
migrated to use machine descriptor tables as described in
Documentation/driver-api/gpio/board.rst
section "platform data".

Cc: Anish Kumar <anish198519851985@gmail.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/generic-adc-battery.c | 31 ++++++++--------------
 include/linux/power/generic-adc-battery.h  |  4 ---
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index caa829738ef7..0032069fbc2b 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -52,6 +52,7 @@ struct gab {
 	int	level;
 	int	status;
 	bool cable_plugged;
+	struct gpio_desc *charge_finished;
 };
 
 static struct gab *to_generic_bat(struct power_supply *psy)
@@ -91,13 +92,9 @@ static const enum power_supply_property gab_dyn_props[] = {
 
 static bool gab_charge_finished(struct gab *adc_bat)
 {
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	bool ret = gpio_get_value(pdata->gpio_charge_finished);
-	bool inv = pdata->gpio_inverted;
-
-	if (!gpio_is_valid(pdata->gpio_charge_finished))
+	if (!adc_bat->charge_finished)
 		return false;
-	return ret ^ inv;
+	return gpiod_get_value(adc_bat->charge_finished);
 }
 
 static int gab_get_status(struct gab *adc_bat)
@@ -327,18 +324,17 @@ static int gab_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&adc_bat->bat_work, gab_work);
 
-	if (gpio_is_valid(pdata->gpio_charge_finished)) {
+	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev,
+							   "charged", GPIOD_IN);
+	if (adc_bat->charge_finished) {
 		int irq;
-		ret = gpio_request(pdata->gpio_charge_finished, "charged");
-		if (ret)
-			goto gpio_req_fail;
 
-		irq = gpio_to_irq(pdata->gpio_charge_finished);
+		irq = gpiod_to_irq(adc_bat->charge_finished);
 		ret = request_any_context_irq(irq, gab_charged,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"battery charged", adc_bat);
 		if (ret < 0)
-			goto err_gpio;
+			goto gpio_req_fail;
 	}
 
 	platform_set_drvdata(pdev, adc_bat);
@@ -348,8 +344,6 @@ static int gab_probe(struct platform_device *pdev)
 			msecs_to_jiffies(0));
 	return 0;
 
-err_gpio:
-	gpio_free(pdata->gpio_charge_finished);
 gpio_req_fail:
 	power_supply_unregister(adc_bat->psy);
 err_reg_fail:
@@ -367,14 +361,11 @@ static int gab_remove(struct platform_device *pdev)
 {
 	int chan;
 	struct gab *adc_bat = platform_get_drvdata(pdev);
-	struct gab_platform_data *pdata = adc_bat->pdata;
 
 	power_supply_unregister(adc_bat->psy);
 
-	if (gpio_is_valid(pdata->gpio_charge_finished)) {
-		free_irq(gpio_to_irq(pdata->gpio_charge_finished), adc_bat);
-		gpio_free(pdata->gpio_charge_finished);
-	}
+	if (adc_bat->charge_finished)
+		free_irq(gpiod_to_irq(adc_bat->charge_finished), adc_bat);
 
 	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
 		if (adc_bat->channel[chan])
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
index 40f9c7628f7b..c68cbf34cd34 100644
--- a/include/linux/power/generic-adc-battery.h
+++ b/include/linux/power/generic-adc-battery.h
@@ -11,16 +11,12 @@
  * @battery_info:         recommended structure to specify static power supply
  *			   parameters
  * @cal_charge:           calculate charge level.
- * @gpio_charge_finished: gpio for the charger.
- * @gpio_inverted:        Should be 1 if the GPIO is active low otherwise 0
  * @jitter_delay:         delay required after the interrupt to check battery
  *			  status.Default set is 10ms.
  */
 struct gab_platform_data {
 	struct power_supply_info battery_info;
 	int	(*cal_charge)(long value);
-	int	gpio_charge_finished;
-	bool	gpio_inverted;
 	int     jitter_delay;
 };
 
-- 
2.26.2

