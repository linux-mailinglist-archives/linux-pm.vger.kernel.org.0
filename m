Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3C25412E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH0Ius (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 04:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0Iur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 04:50:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8BC061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 01:50:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so5495745ljc.8
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQaUG7xBh2HjSNskZY89kjazXkJDEmZNO2sZfI4TKyk=;
        b=QmgdF1iN6lMcE8BhMHvgKf3D4iGv0vkpTtNJ0kwg745FZJp+6w2xLfGFe9m/fUNysY
         EfT8Q8WvMYE8RdPy3xTr4NR9XN0AvFjML9WiNkVYSKucJppc6J2L0XlpJiUgm/Pr8D6s
         V6yzdqaFtKDI6afEQ56fMZH37HlbVmjQ1ZWKNJpLROc5Px6lGs4AQGYBneaOGapObD2B
         whhLHldR1JPp87fw7iHuIJrG/cy9Z3cvePIXZph5hzok/ofYUyOmaQKmr32pyaDAR43L
         cHoo+xZ81AkPtKWIUR/5YaowQgdYjMo2v9UoQ4kIlz30ndoYdUIJhJa6EgSJjQaQYnez
         7acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQaUG7xBh2HjSNskZY89kjazXkJDEmZNO2sZfI4TKyk=;
        b=bM/27AOch9cmrzhnlBXDsWe3DNMVZhz6u8o04pJPGP5n3ABuE799p9oQ7grGIhtlkl
         n/0py6iUlQAZqExFr5WFkRC9CTW2n1XGDK8T/z4a4qQ4W3nkryVORyYlAv05E11vIxhg
         VBOIIESvdQ5PlqZJZbuHH/WUOeiWQs/XfFEORQLHSCkEEBDXbDOWmn14+q1o3cMkmsM7
         mEWHENEgAwiabTZhNEjSuwTR1s0O+tDfpf/W20FotxrnTMSh7g/SlkNqdfEHIcDAcS99
         74sdfLnT40kLkKq8OkFK2w2b0hpYPLqV1jxnKeMnEFmQ/WPU3FmG7rfnnYclEOqn+Qcg
         mnVw==
X-Gm-Message-State: AOAM5313/NSpHdZ5MPQ0lAXJ+zPvrXtEqXB0Xw+I6fQFRDCmmdk4kPu5
        f4UGk1tVSQ94EFaff0Fu0TBIjg==
X-Google-Smtp-Source: ABdhPJwn7lc+guBAZW0Dww4flilB0w432ThtGD3tncScvIOLhOh4qby3fG0+KfltO49dCMTVA5fNpQ==
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr8568440ljh.70.1598518245058;
        Thu, 27 Aug 2020 01:50:45 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id g63sm297611lfd.28.2020.08.27.01.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:50:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v2] power: supply: gpio-charger: Convert to GPIO descriptors
Date:   Thu, 27 Aug 2020 10:48:28 +0200
Message-Id: <20200827084828.190841-1-linus.walleij@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
ChangeLog v1->v2:
- Rebased on v5.9-rc1
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
index 875735d50716..ae778f110101 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/gpio.h> /* For legacy platform data */
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -131,7 +130,6 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct power_supply_desc *charger_desc;
 	struct gpio_desc *charge_status;
 	int charge_status_irq;
-	unsigned long flags;
 	int ret;
 	int num_props = 0;
 
@@ -149,29 +147,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
 	gpio_charger->gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
-
-	/*
-	 * Fallback to legacy platform data method, if no GPIO is specified
-	 * using boardfile descriptor tables.
-	 */
-	if (!gpio_charger->gpiod && pdata) {
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

