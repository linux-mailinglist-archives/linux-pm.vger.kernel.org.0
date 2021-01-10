Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A72F0781
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAJOEs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJOEr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 09:04:47 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0118C06179F
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 06:04:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y22so649227ljn.9
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJxGbcjbmcGo2ILU6Odyqaf8smhn9I3k6tIguEbQ+00=;
        b=vueRTA6P8Drg4AEzEVNtEb8ScghBCKL3E95d7DEeYvv95jAPOHgNb9YJf5/sKvad++
         RqpYIaCetI64USPqu/6Cf3Jnd9OIYUThOmBX0jsnwGAAIRK9FJrBrSp0RQlIu4jLRN6Y
         8l92kOQTSmGxSGEQg25FJl49K4Yv7jq08J3CuZyM7UHRJDYwUzaSmaNb84NFC2Zdeg8V
         c06wU/U5Yk2+wx7dqRZ4NfEOdDJ7SuDXHKQoUJ7CbWXM+5AGY2j+myU45/RkrNUmZC7c
         +KoznCjUphP+RsSZ5vXsWAvf2CgVdD28MLcDlPe+kkCAzRCy/lw/qgYzr5+9F4m7ztnr
         b4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJxGbcjbmcGo2ILU6Odyqaf8smhn9I3k6tIguEbQ+00=;
        b=ETI5+9qFIBHlcsterYUNq+9U3y5t9d0c1BwMm92m112IIDEyD3QhUm+alVrkPZpEKb
         3gYgW23/eZaGpfy704ppoi8nZ1eb3U8si/ND66tvFUlPtpZiZtVfbo3EngySFhPtNk4B
         t29/Tjh4ihgrigR7IxspZy1cXV3DZPfL+x9rEH+MtbgWkzIdAHn9xZ3FaepC7hKOm3Jy
         vnI029csMJu/BDu5BXk5mgn7Ji4inUREIQL8wXNYt0r23y3lYRPTuL5843ENAUk2Z24M
         GmZ3a9wLBnYJ7c3JfJy2wsDWP0zZ60S+dkSgSoGtXlA5dkcZQIWqmDEB+wTJMXh3HHBn
         0ujw==
X-Gm-Message-State: AOAM532vHxvICYL54MzrjvT9EFf8ZyWcXUtvffVoM47v51TeLrpp+Sts
        jLc0hDs1PwhvhAAEN9lgKrx/Dw==
X-Google-Smtp-Source: ABdhPJwNHGHzqsiY4Aoo1IY8635BqerXBx4OCoo1OjwY79PclGbrzcOuDvdKvsAVv5RMpQ3J8kDcbQ==
X-Received: by 2002:a05:651c:2045:: with SMTP id t5mr5265284ljo.462.1610287444912;
        Sun, 10 Jan 2021 06:04:04 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id y26sm2981150ljh.63.2021.01.10.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:04:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chris Lapa <chris@lapa.com.au>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 2/2] power: supply: max8903: Convert to GPIO descriptors
Date:   Sun, 10 Jan 2021 15:02:00 +0100
Message-Id: <20210110140200.127123-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110140200.127123-1-linus.walleij@linaro.org>
References: <20210110140200.127123-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MAX8903 uses up to 5 different GPIO lines to control and
monitor charging.

When converting to use GPIO descriptors instead of the old
GPIO numbers the following side-refactorings were done:

- Decomission the platform data container struct as all
  GPIO descriptors are now "live" members of the driver
  state container. The "dc_valid" and "usb_valid" just
  indicate the presence of a DC or USB charger detection
  line, and this can be handled by just checking if
  the optional GPIO descriptor for each is != NULL.

- The gpiolib will now respect the GPIO_ACTIVE_LOW flag
  for each of the lines, meaning gpiod_get_value() for example
  will return 1 (asserted) if a line is flagged as
  active low and is also physically low. The same applies
  to output lines, vice versa mutatis mutandis. The code
  has been augmented to account for this in all sites.

- The terse parenthesis such as this:
    gpio_set_value(pdata->cen, ta_in ? 0 :
                     (data->usb_in ? 0 : 1));
  have been expanded to more readable if / else if / else
  statements that are easier for humans to read.

- Comments were inserted to underscore polarity in each
  case where it could be confusing to users of the old code.

One thing is notable: the device tree bindings does not show
an example of polarity assigned for the line "dcm-gpios"
DC current monitor, is assumed to be flagged GPIO_ACTIVE_HIGH
and driving it high (asserted) will achieve DC charger current
limits and driving it low will achieve USB charger current
limits. Device trees with this (optional) GPIO line defined
should definately be flagged as GPIO_ACTIVE_HIGH.

Cc: Chris Lapa <chris@lapa.com.au>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/max8903_charger.c | 388 +++++++++++--------------
 1 file changed, 168 insertions(+), 220 deletions(-)

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index ab1aa7df985e..54d50b55fbae 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -6,52 +6,32 @@
  * MyungJoo Ham <myungjoo.ham@samsung.com>
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
 
-struct max8903_pdata {
-	/*
-	 * GPIOs
-	 * cen, chg, flt, dcm and usus are optional.
-	 * dok and uok are not optional depending on the status of
-	 * dc_valid and usb_valid.
-	 */
-	int cen;	/* Charger Enable input */
-	int dok;	/* DC(Adapter) Power OK output */
-	int uok;	/* USB Power OK output */
-	int chg;	/* Charger status output */
-	int flt;	/* Fault output */
-	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
-	int usus;	/* USB Suspend Input (1: suspended) */
-
-	/*
-	 * DC(Adapter/TA) is wired
-	 * When dc_valid is true,
-	 *	dok should be valid.
-	 *
-	 * At least one of dc_valid or usb_valid should be true.
-	 */
-	bool dc_valid;
-	/*
-	 * USB is wired
-	 * When usb_valid is true,
-	 *	uok should be valid.
-	 */
-	bool usb_valid;
-};
-
 struct max8903_data {
-	struct max8903_pdata *pdata;
 	struct device *dev;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
+	/*
+	 * GPIOs
+	 * chg, flt, dcm and usus are optional.
+	 * dok or uok must be present.
+	 * If dok is present, cen must be present.
+	 */
+	struct gpio_desc *cen; /* Charger Enable input */
+	struct gpio_desc *dok; /* DC (Adapter) Power OK output */
+	struct gpio_desc *uok; /* USB Power OK output */
+	struct gpio_desc *chg; /* Charger status output */
+	struct gpio_desc *flt; /* Fault output */
+	struct gpio_desc *dcm; /* Current-Limit Mode input (1: DC, 2: USB) */
+	struct gpio_desc *usus; /* USB Suspend Input (1: suspended) */
 	bool fault;
 	bool usb_in;
 	bool ta_in;
@@ -72,8 +52,9 @@ static int max8903_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-		if (gpio_is_valid(data->pdata->chg)) {
-			if (gpio_get_value(data->pdata->chg) == 0)
+		if (data->chg) {
+			if (gpiod_get_value(data->chg))
+				/* CHG asserted */
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
 			else if (data->usb_in || data->ta_in)
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -101,11 +82,17 @@ static int max8903_get_property(struct power_supply *psy,
 static irqreturn_t max8903_dcin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = data->pdata;
 	bool ta_in;
 	enum power_supply_type old_type;
 
-	ta_in = gpio_get_value(pdata->dok) ? false : true;
+	/*
+	 * This means the line is asserted.
+	 *
+	 * The signal is active low, but the inversion is handled in the GPIO
+	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
+	 * tree.
+	 */
+	ta_in = gpiod_get_value(data->dok);
 
 	if (ta_in == data->ta_in)
 		return IRQ_HANDLED;
@@ -113,13 +100,25 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	data->ta_in = ta_in;
 
 	/* Set Current-Limit-Mode 1:DC 0:USB */
-	if (gpio_is_valid(pdata->dcm))
-		gpio_set_value(pdata->dcm, ta_in ? 1 : 0);
-
-	/* Charger Enable / Disable (cen is negated) */
-	if (gpio_is_valid(pdata->cen))
-		gpio_set_value(pdata->cen, ta_in ? 0 :
-				(data->usb_in ? 0 : 1));
+	if (data->dcm)
+		gpiod_set_value(data->dcm, ta_in);
+
+	/* Charger Enable / Disable */
+	if (data->cen) {
+		int val;
+
+		if (ta_in)
+			/* Certainly enable if DOK is asserted */
+			val = 1;
+		else if (data->usb_in)
+			/* Enable if the USB charger is enabled */
+			val = 1;
+		else
+			/* Else default-disable */
+			val = 0;
+
+		gpiod_set_value(data->cen, val);
+	}
 
 	dev_dbg(data->dev, "TA(DC-IN) Charger %s.\n", ta_in ?
 			"Connected" : "Disconnected");
@@ -142,11 +141,17 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 static irqreturn_t max8903_usbin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = data->pdata;
 	bool usb_in;
 	enum power_supply_type old_type;
 
-	usb_in = gpio_get_value(pdata->uok) ? false : true;
+	/*
+	 * This means the line is asserted.
+	 *
+	 * The signal is active low, but the inversion is handled in the GPIO
+	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
+	 * tree.
+	 */
+	usb_in = gpiod_get_value(data->uok);
 
 	if (usb_in == data->usb_in)
 		return IRQ_HANDLED;
@@ -155,10 +160,22 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 
 	/* Do not touch Current-Limit-Mode */
 
-	/* Charger Enable / Disable (cen is negated) */
-	if (gpio_is_valid(pdata->cen))
-		gpio_set_value(pdata->cen, usb_in ? 0 :
-				(data->ta_in ? 0 : 1));
+	/* Charger Enable / Disable */
+	if (data->cen) {
+		int val;
+
+		if (usb_in)
+			/* Certainly enable if UOK is asserted */
+			val = 1;
+		else if (data->ta_in)
+			/* Enable if the DC charger is enabled */
+			val = 1;
+		else
+			/* Else default-disable */
+			val = 0;
+
+		gpiod_set_value(data->cen, val);
+	}
 
 	dev_dbg(data->dev, "USB Charger %s.\n", usb_in ?
 			"Connected" : "Disconnected");
@@ -181,10 +198,16 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 static irqreturn_t max8903_fault(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
-	struct max8903_pdata *pdata = data->pdata;
 	bool fault;
 
-	fault = gpio_get_value(pdata->flt) ? false : true;
+	/*
+	 * This means the line is asserted.
+	 *
+	 * The signal is active low, but the inversion is handled in the GPIO
+	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
+	 * tree.
+	 */
+	fault = gpiod_get_value(data->flt);
 
 	if (fault == data->fault)
 		return IRQ_HANDLED;
@@ -199,159 +222,100 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
-static struct max8903_pdata *max8903_parse_dt_data(struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct max8903_pdata *pdata = NULL;
-
-	if (!np)
-		return NULL;
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return NULL;
-
-	pdata->dc_valid = false;
-	pdata->usb_valid = false;
-
-	pdata->cen = of_get_named_gpio(np, "cen-gpios", 0);
-	if (!gpio_is_valid(pdata->cen))
-		pdata->cen = -EINVAL;
-
-	pdata->chg = of_get_named_gpio(np, "chg-gpios", 0);
-	if (!gpio_is_valid(pdata->chg))
-		pdata->chg = -EINVAL;
-
-	pdata->flt = of_get_named_gpio(np, "flt-gpios", 0);
-	if (!gpio_is_valid(pdata->flt))
-		pdata->flt = -EINVAL;
-
-	pdata->usus = of_get_named_gpio(np, "usus-gpios", 0);
-	if (!gpio_is_valid(pdata->usus))
-		pdata->usus = -EINVAL;
-
-	pdata->dcm = of_get_named_gpio(np, "dcm-gpios", 0);
-	if (!gpio_is_valid(pdata->dcm))
-		pdata->dcm = -EINVAL;
-
-	pdata->dok = of_get_named_gpio(np, "dok-gpios", 0);
-	if (!gpio_is_valid(pdata->dok))
-		pdata->dok = -EINVAL;
-	else
-		pdata->dc_valid = true;
-
-	pdata->uok = of_get_named_gpio(np, "uok-gpios", 0);
-	if (!gpio_is_valid(pdata->uok))
-		pdata->uok = -EINVAL;
-	else
-		pdata->usb_valid = true;
-
-	return pdata;
-}
-
 static int max8903_setup_gpios(struct platform_device *pdev)
 {
 	struct max8903_data *data = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
-	struct max8903_pdata *pdata = pdev->dev.platform_data;
-	int ret = 0;
-	int gpio;
-	int ta_in = 0;
-	int usb_in = 0;
-
-	if (pdata->dc_valid) {
-		if (gpio_is_valid(pdata->dok)) {
-			ret = devm_gpio_request(dev, pdata->dok,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for dok: %d err %d\n",
-					pdata->dok, ret);
-				return ret;
-			}
-
-			gpio = pdata->dok; /* PULL_UPed Interrupt */
-			ta_in = gpio_get_value(gpio) ? 0 : 1;
-		} else {
-			dev_err(dev, "When DC is wired, DOK should be wired as well.\n");
-			return -EINVAL;
-		}
+	bool ta_in = false;
+	bool usb_in = false;
+	enum gpiod_flags flags;
+
+	data->dok = devm_gpiod_get_optional(dev, "dok", GPIOD_IN);
+	if (IS_ERR(data->dok))
+		return dev_err_probe(dev, PTR_ERR(data->dok),
+				     "failed to get DOK GPIO");
+	if (data->dok) {
+		gpiod_set_consumer_name(data->dok, data->psy_desc.name);
+		/*
+		 * The DC OK is pulled up to 1 and goes low when a charger
+		 * is plugged in (active low) but in the device tree the
+		 * line is marked as GPIO_ACTIVE_LOW so we get a 1 (asserted)
+		 * here if the DC charger is plugged in.
+		 */
+		ta_in = gpiod_get_value(data->dok);
 	}
 
-	if (gpio_is_valid(pdata->dcm)) {
-		ret = devm_gpio_request(dev, pdata->dcm, data->psy_desc.name);
-		if (ret) {
-			dev_err(dev,
-				"Failed GPIO request for dcm: %d err %d\n",
-				pdata->dcm, ret);
-			return ret;
-		}
-
-		gpio = pdata->dcm; /* Output */
-		gpio_set_value(gpio, ta_in);
+	data->uok = devm_gpiod_get_optional(dev, "uok", GPIOD_IN);
+	if (IS_ERR(data->uok))
+		return dev_err_probe(dev, PTR_ERR(data->uok),
+				     "failed to get UOK GPIO");
+	if (data->uok) {
+		gpiod_set_consumer_name(data->uok, data->psy_desc.name);
+		/*
+		 * The USB OK is pulled up to 1 and goes low when a USB charger
+		 * is plugged in (active low) but in the device tree the
+		 * line is marked as GPIO_ACTIVE_LOW so we get a 1 (asserted)
+		 * here if the USB charger is plugged in.
+		 */
+		usb_in = gpiod_get_value(data->uok);
 	}
 
-	if (pdata->usb_valid) {
-		if (gpio_is_valid(pdata->uok)) {
-			ret = devm_gpio_request(dev, pdata->uok,
-						data->psy_desc.name);
-			if (ret) {
-				dev_err(dev,
-					"Failed GPIO request for uok: %d err %d\n",
-					pdata->uok, ret);
-				return ret;
-			}
-
-			gpio = pdata->uok;
-			usb_in = gpio_get_value(gpio) ? 0 : 1;
-		} else {
-			dev_err(dev, "When USB is wired, UOK should be wired."
-					"as well.\n");
-			return -EINVAL;
-		}
-	}
-
-	if (gpio_is_valid(pdata->cen)) {
-		ret = devm_gpio_request(dev, pdata->cen, data->psy_desc.name);
-		if (ret) {
-			dev_err(dev,
-				"Failed GPIO request for cen: %d err %d\n",
-				pdata->cen, ret);
-			return ret;
-		}
-
-		gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
-	}
-
-	if (gpio_is_valid(pdata->chg)) {
-		ret = devm_gpio_request(dev, pdata->chg, data->psy_desc.name);
-		if (ret) {
-			dev_err(dev,
-				"Failed GPIO request for chg: %d err %d\n",
-				pdata->chg, ret);
-			return ret;
-		}
+	/* Either DC OK or USB OK must be provided */
+	if (!data->dok && !data->uok) {
+		dev_err(dev, "no valid power source\n");
+		return -EINVAL;
 	}
 
-	if (gpio_is_valid(pdata->flt)) {
-		ret = devm_gpio_request(dev, pdata->flt, data->psy_desc.name);
-		if (ret) {
-			dev_err(dev,
-				"Failed GPIO request for flt: %d err %d\n",
-				pdata->flt, ret);
-			return ret;
-		}
-	}
+	/*
+	 * If either charger is already connected at this point,
+	 * assert the CEN line and enable charging from the start.
+	 *
+	 * The line is active low but also marked with GPIO_ACTIVE_LOW
+	 * in the device tree, so when we assert the line with
+	 * GPIOD_OUT_HIGH the line will be driven low.
+	 */
+	flags = (ta_in || usb_in) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	/*
+	 * If DC OK is provided, Charger Enable CEN is compulsory
+	 * so this is not optional here.
+	 */
+	data->cen = devm_gpiod_get(dev, "cen", flags);
+	if (IS_ERR(data->cen))
+		return dev_err_probe(dev, PTR_ERR(data->cen),
+				     "failed to get CEN GPIO");
+	gpiod_set_consumer_name(data->cen, data->psy_desc.name);
 
-	if (gpio_is_valid(pdata->usus)) {
-		ret = devm_gpio_request(dev, pdata->usus, data->psy_desc.name);
-		if (ret) {
-			dev_err(dev,
-				"Failed GPIO request for usus: %d err %d\n",
-				pdata->usus, ret);
-			return ret;
-		}
-	}
+	/*
+	 * If the DC charger is connected, then select it.
+	 *
+	 * The DCM line should be marked GPIO_ACTIVE_HIGH in the
+	 * device tree. Driving it high will enable the DC charger
+	 * input over the USB charger input.
+	 */
+	flags = ta_in ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	data->dcm = devm_gpiod_get_optional(dev, "dcm", flags);
+	if (IS_ERR(data->dcm))
+		return dev_err_probe(dev, PTR_ERR(data->dcm),
+				     "failed to get DCM GPIO");
+	gpiod_set_consumer_name(data->dcm, data->psy_desc.name);
+
+	data->chg = devm_gpiod_get_optional(dev, "chg", GPIOD_IN);
+	if (IS_ERR(data->chg))
+		return dev_err_probe(dev, PTR_ERR(data->chg),
+				     "failed to get CHG GPIO");
+	gpiod_set_consumer_name(data->chg, data->psy_desc.name);
+
+	data->flt = devm_gpiod_get_optional(dev, "flt", GPIOD_IN);
+	if (IS_ERR(data->flt))
+		return dev_err_probe(dev, PTR_ERR(data->flt),
+				     "failed to get FLT GPIO");
+	gpiod_set_consumer_name(data->flt, data->psy_desc.name);
+
+	data->usus = devm_gpiod_get_optional(dev, "usus", GPIOD_IN);
+	if (IS_ERR(data->usus))
+		return dev_err_probe(dev, PTR_ERR(data->usus),
+				     "failed to get USUS GPIO");
+	gpiod_set_consumer_name(data->usus, data->psy_desc.name);
 
 	data->fault = false;
 	data->ta_in = ta_in;
@@ -364,7 +328,6 @@ static int max8903_probe(struct platform_device *pdev)
 {
 	struct max8903_data *data;
 	struct device *dev = &pdev->dev;
-	struct max8903_pdata *pdata = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 
@@ -372,24 +335,9 @@ static int max8903_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	if (IS_ENABLED(CONFIG_OF) && !pdata && dev->of_node)
-		pdata = max8903_parse_dt_data(dev);
-
-	if (!pdata) {
-		dev_err(dev, "No platform data.\n");
-		return -EINVAL;
-	}
-
-	pdev->dev.platform_data = pdata;
-	data->pdata = pdata;
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
-	if (pdata->dc_valid == false && pdata->usb_valid == false) {
-		dev_err(dev, "No valid power sources.\n");
-		return -EINVAL;
-	}
-
 	ret = max8903_setup_gpios(pdev);
 	if (ret)
 		return ret;
@@ -411,41 +359,41 @@ static int max8903_probe(struct platform_device *pdev)
 		return PTR_ERR(data->psy);
 	}
 
-	if (pdata->dc_valid) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->dok),
+	if (data->dok) {
+		ret = devm_request_threaded_irq(dev, gpiod_to_irq(data->dok),
 					NULL, max8903_dcin,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 DC IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
-					gpio_to_irq(pdata->dok), ret);
+					gpiod_to_irq(data->dok), ret);
 			return ret;
 		}
 	}
 
-	if (pdata->usb_valid) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->uok),
+	if (data->uok) {
+		ret = devm_request_threaded_irq(dev, gpiod_to_irq(data->uok),
 					NULL, max8903_usbin,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 USB IN", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
-					gpio_to_irq(pdata->uok), ret);
+					gpiod_to_irq(data->uok), ret);
 			return ret;
 		}
 	}
 
-	if (gpio_is_valid(pdata->flt)) {
-		ret = devm_request_threaded_irq(dev, gpio_to_irq(pdata->flt),
+	if (data->flt) {
+		ret = devm_request_threaded_irq(dev, gpiod_to_irq(data->flt),
 					NULL, max8903_fault,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 Fault", data);
 		if (ret) {
 			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
-					gpio_to_irq(pdata->flt), ret);
+					gpiod_to_irq(data->flt), ret);
 			return ret;
 		}
 	}
-- 
2.29.2

