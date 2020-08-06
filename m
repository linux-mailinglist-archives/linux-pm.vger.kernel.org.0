Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED623D8F3
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgHFJyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgHFJyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 05:54:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86FFC061757
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 02:54:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so25126298lfp.7
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWIXlHm6dmu3Mr/LjPf41b0etEmQpQFCVPVCIIhmwS0=;
        b=DmPSGxX38caBJtao8oTC6CnQ2I+av7LNktYoZiJkMekE8r3UqSBfWYNjJFRfRD6+6I
         vm1AStMj6YGeon4yH6s1sLF/lkLF3jKlI8IsfACfQcodsXFDxkmGvpMTvlEoe5sg1BkR
         nvKR1N/dHQRcNjpr4IuOrrdo5uynm+eR8pTmrq8jnd1psLUypZVOI3l7udNaaPrz4qjK
         EkLWjCi88aJlbVXHsIjiheUP7XXOXC2nTXmBNE8b0t58CEpdX/QRSo3cJR+Db/GdAZUl
         +BPE+bFgm4CbTUFBR5qh4oqNHwI08pUxmozWz5yneHTCbF/+/VyXSUlADOqVHkFYVj6S
         KAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWIXlHm6dmu3Mr/LjPf41b0etEmQpQFCVPVCIIhmwS0=;
        b=TM9MVAciDmqheJaywkStD74eKw0WdXeVl1Y4INocncZIfF5oh+9XiZfmx9YiKxBMcf
         ZTfK6GSVvnKlWVhLypgitYEasCZW8d6A7qNy5N09FRu0+MaBfb4ELkPGF9/yctyIHfbv
         N6BMO6QQhcWAMPWt5olJvuntjNOmzyZ5cTGhJZ5oTcz4gJ8T5EAdbW5zR4teuZFp4Jua
         P/zABji1J5lLcoLzXRRF6TATOQkJFFGKdy2+D4W9LpZuSQMkWeU/jCjRjKNZoCCPIxCK
         sGjJWi0aG9zsM+TCW2cKLHQxs7MlI5XW9ZfD8pAkCnUngWWv1DOK7H0bkZal2Eq+2OSu
         Np3w==
X-Gm-Message-State: AOAM532/Sv+XqcVF9O4v65nD+vbrODUqt9V1FNtT7nVgDhGl+o2rcxFE
        0KLLz62JQZ4SbchOWUBYwfn/1Q==
X-Google-Smtp-Source: ABdhPJyRckZg3iGftysC6B8sO6exRZsiE7NYykOeFiJ4Tu50Mqt3VkqRlupNkNtoFjGClZ7eW6Tk3A==
X-Received: by 2002:ac2:5f64:: with SMTP id c4mr3673001lfc.170.1596707646207;
        Thu, 06 Aug 2020 02:54:06 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id y19sm2454733lfe.77.2020.08.06.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 02:54:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] power: supply: gpio-charger: Convert to GPIO descriptors
Date:   Thu,  6 Aug 2020 11:54:03 +0200
Message-Id: <20200806095403.974684-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the GPIO charger to use exclusively GPIO
descriptors, moving the two remaining platforms passing
global GPIO numbers over to using a GPIO descriptor table.

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/tosa.c            | 12 ++++++++++--
 arch/arm/mach-sa1100/collie.c       | 14 ++++++++++++--
 drivers/power/supply/gpio-charger.c | 26 +-------------------------
 include/linux/power/gpio-charger.h  |  6 ------
 4 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 3d2c108e911e..431709725d02 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -369,6 +369,15 @@ static struct pxaficp_platform_data tosa_ficp_platform_data = {
 /*
  * Tosa AC IN
  */
+static struct gpiod_lookup_table tosa_power_gpiod_table = {
+	.dev_id = "gpio-charger",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_AC_IN,
+			    NULL, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static char *tosa_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
@@ -378,8 +387,6 @@ static char *tosa_ac_supplied_to[] = {
 static struct gpio_charger_platform_data tosa_power_data = {
 	.name			= "charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.gpio			= TOSA_GPIO_AC_IN,
-	.gpio_active_low	= 1,
 	.supplied_to		= tosa_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(tosa_ac_supplied_to),
 };
@@ -951,6 +958,7 @@ static void __init tosa_init(void)
 	clk_add_alias("CLK_CK3P6MI", tc6393xb_device.name, "GPIO11_CLK", NULL);
 
 	gpiod_add_lookup_table(&tosa_udc_gpiod_table);
+	gpiod_add_lookup_table(&tosa_power_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 3cc2b71e16f0..bd3a52fd09ce 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -30,6 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/power/gpio-charger.h>
 
 #include <video/sa1100fb.h>
@@ -131,16 +132,23 @@ static struct irda_platform_data collie_ir_data = {
 /*
  * Collie AC IN
  */
+static struct gpiod_lookup_table collie_power_gpiod_table = {
+	.dev_id = "gpio-charger",
+	.table = {
+		GPIO_LOOKUP("gpio", COLLIE_GPIO_AC_IN,
+			    NULL, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static char *collie_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
 };
 
-
 static struct gpio_charger_platform_data collie_power_data = {
 	.name			= "charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.gpio			= COLLIE_GPIO_AC_IN,
 	.supplied_to		= collie_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(collie_ac_supplied_to),
 };
@@ -386,6 +394,8 @@ static void __init collie_init(void)
 
 	platform_scoop_config = &collie_pcmcia_config;
 
+	gpiod_add_lookup_table(&collie_power_gpiod_table);
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1b959c7f8b0e..a860d187f718 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/gpio.h> /* For legacy platform data */
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -126,7 +125,6 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct power_supply_desc *charger_desc;
 	struct gpio_desc *charge_status;
 	int charge_status_irq;
-	unsigned long flags;
 	int ret;
 
 	if (!pdata && !dev->of_node) {
@@ -143,29 +141,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
 	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
-
-	/*
-	 * If this fails and we're not using device tree, try the
-	 * legacy platform data method.
-	 */
-	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
-		/* Non-DT: use legacy GPIO numbers */
-		if (!gpio_is_valid(pdata->gpio)) {
-			dev_err(dev, "Invalid gpio pin in pdata\n");
-			return -EINVAL;
-		}
-		flags = GPIOF_IN;
-		if (pdata->gpio_active_low)
-			flags |= GPIOF_ACTIVE_LOW;
-		ret = devm_gpio_request_one(dev, pdata->gpio, flags,
-					    dev_name(dev));
-		if (ret) {
-			dev_err(dev, "Failed to request gpio pin: %d\n", ret);
-			return ret;
-		}
-		/* Then convert this to gpiod for now */
-		gpio_charger->gpiod = gpio_to_desc(pdata->gpio);
-	} else if (IS_ERR(gpio_charger->gpiod)) {
+	if (IS_ERR(gpio_charger->gpiod)) {
 		/* Just try again if this happens */
 		if (PTR_ERR(gpio_charger->gpiod) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
diff --git a/include/linux/power/gpio-charger.h b/include/linux/power/gpio-charger.h
index 5a5a8de98181..c0b7657ac1df 100644
--- a/include/linux/power/gpio-charger.h
+++ b/include/linux/power/gpio-charger.h
@@ -13,18 +13,12 @@
  * struct gpio_charger_platform_data - platform_data for gpio_charger devices
  * @name:		Name for the chargers power_supply device
  * @type:		Type of the charger
- * @gpio:		GPIO which is used to indicate the chargers status
- * @gpio_active_low:	Should be set to 1 if the GPIO is active low otherwise 0
  * @supplied_to:	Array of battery names to which this chargers supplies power
  * @num_supplicants:	Number of entries in the supplied_to array
  */
 struct gpio_charger_platform_data {
 	const char *name;
 	enum power_supply_type type;
-
-	int gpio;
-	int gpio_active_low;
-
 	char **supplied_to;
 	size_t num_supplicants;
 };
-- 
2.26.2

