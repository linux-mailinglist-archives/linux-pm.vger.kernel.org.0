Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC56211634
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfEBJMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 05:12:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45929 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBJMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:12:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so1296260lfl.12;
        Thu, 02 May 2019 02:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCotCnuEgN6SHIykHRh7vsXKjnpDUqVREHXaBRYEKys=;
        b=uJooS0J1pZ/gF2WDMRnQ+DVq5O8hi7gZLtn/tUxAUOIJ8XuptFOMrEO+i7yktk06wR
         bqq8Bia7mrDaLT+1T8OYe1GV6WcKQZHQITI9LDgCTCv3hSsdoyKnlS1wMvqB7vlxf/tn
         yad32uGd31Aiz1nTyhGqkTEzLrZ+twCBtBXnb4+n62Fsgiqys76ad/th0aRICFXAocib
         8ysL6XKnSJo3dudP1Zl2OIw1PFwwxh3ddxKirEqs/0EUg+VxZi5se9l1B0QwZlHkN9wb
         8tMKOG5/GA2d0gv6tf49/3XmcqOS7lhC/78TNbHGqqJO7xGF2Az4HdJwAlE2fwoABqDJ
         t28A==
X-Gm-Message-State: APjAAAVvNHMTL5Nbden30v17A2Ny/9CmNlmfNndyDXCNUYyt/5eUR6Np
        17R8OEnrC42spc4GbT5U/zNG2NZo
X-Google-Smtp-Source: APXvYqwWMHUjuBJFTexJ/OsKSfFDS0zijFdLPtpygoJy3kbB7P9GvXZQ26iII0dFZ3qfs8FpaRUjuA==
X-Received: by 2002:ac2:54a1:: with SMTP id w1mr1493214lfk.46.1556788368211;
        Thu, 02 May 2019 02:12:48 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id i66sm8688820lji.43.2019.05.02.02.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 02:12:47 -0700 (PDT)
Date:   Thu, 2 May 2019 12:12:39 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH v14 1/8] mfd: regulator: clk: split rohm-bd718x7.h
Message-ID: <f545d8dc79d4e6ae4f882ffaa0d9d9b146f58d2b.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Split the bd718x7.h to ROHM common and bd718x7 specific parts
so that we do not need to add same things in every new ROHM
PMIC header. Please note that this change requires changes also
in bd718x7 sub-device drivers for regulators and clk.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changelog v14: No changes

 drivers/clk/clk-bd718x7.c             |  6 +++---
 drivers/mfd/rohm-bd718x7.c            | 23 ++++++++++++-----------
 drivers/regulator/bd718x7-regulator.c | 25 +++++++++++++------------
 include/linux/mfd/rohm-bd718x7.h      | 22 ++++++++--------------
 include/linux/mfd/rohm-generic.h      | 20 ++++++++++++++++++++
 5 files changed, 56 insertions(+), 40 deletions(-)
 create mode 100644 include/linux/mfd/rohm-generic.h

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 60422c72d142..461228ebf703 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -17,7 +17,7 @@ struct bd718xx_clk {
 	u8 reg;
 	u8 mask;
 	struct platform_device *pdev;
-	struct bd718xx *mfd;
+	struct rohm_regmap_dev *mfd;
 };
 
 static int bd71837_clk_set(struct clk_hw *hw, int status)
@@ -68,7 +68,7 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	int rval = -ENOMEM;
 	const char *parent_clk;
 	struct device *parent = pdev->dev.parent;
-	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct rohm_regmap_dev *mfd = dev_get_drvdata(parent);
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
@@ -119,5 +119,5 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_DESCRIPTION("BD71837/BD71847 chip clk driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index a29d529a96f4..7beb444a57cb 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,18 +98,19 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)(uintptr_t)
+	bd718xx->chip.chip_type = (unsigned int)(uintptr_t)
 				of_device_get_match_data(&i2c->dev);
-	bd718xx->dev = &i2c->dev;
+	bd718xx->chip.dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
 
-	bd718xx->regmap = devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
-	if (IS_ERR(bd718xx->regmap)) {
+	bd718xx->chip.regmap = devm_regmap_init_i2c(i2c,
+						    &bd718xx_regmap_config);
+	if (IS_ERR(bd718xx->chip.regmap)) {
 		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(bd718xx->regmap);
+		return PTR_ERR(bd718xx->chip.regmap);
 	}
 
-	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->regmap,
+	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->chip.regmap,
 				       bd718xx->chip_irq, IRQF_ONESHOT, 0,
 				       &bd718xx_irq_chip, &bd718xx->irq_data);
 	if (ret) {
@@ -118,7 +119,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure short press to 10 milliseconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG0,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
@@ -129,7 +130,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure long press to 10 seconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG1,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_LONG_PRESS_10S);
@@ -149,7 +150,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 
 	button.irq = ret;
 
-	ret = devm_mfd_add_devices(bd718xx->dev, PLATFORM_DEVID_AUTO,
+	ret = devm_mfd_add_devices(bd718xx->chip.dev, PLATFORM_DEVID_AUTO,
 				   bd718xx_mfd_cells,
 				   ARRAY_SIZE(bd718xx_mfd_cells), NULL, 0,
 				   regmap_irq_get_domain(bd718xx->irq_data));
@@ -162,11 +163,11 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 static const struct of_device_id bd718xx_of_match[] = {
 	{
 		.compatible = "rohm,bd71837",
-		.data = (void *)BD718XX_TYPE_BD71837,
+		.data = (void *)ROHM_CHIP_TYPE_BD71837,
 	},
 	{
 		.compatible = "rohm,bd71847",
-		.data = (void *)BD718XX_TYPE_BD71847,
+		.data = (void *)ROHM_CHIP_TYPE_BD71847,
 	},
 	{ }
 };
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b2191be49670..1c8c8497ac0a 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1152,12 +1152,12 @@ static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
-	struct bd718xx_pmic_inits pmic_regulators[] = {
-		[BD718XX_TYPE_BD71837] = {
+	struct bd718xx_pmic_inits pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] = {
+		[ROHM_CHIP_TYPE_BD71837] = {
 			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
-		[BD718XX_TYPE_BD71847] = {
+		[ROHM_CHIP_TYPE_BD71847] = {
 			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
@@ -1173,15 +1173,15 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip_type].r_datas) {
+	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
+	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
 	}
 
 	/* Register LOCK release */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
@@ -1200,7 +1200,8 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * bit allowing HW defaults for power rails to be used
 	 */
 	if (!use_snvs) {
-		err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+		err = regmap_update_bits(mfd->chip.regmap,
+					 BD718XX_REG_TRANS_COND1,
 					 BD718XX_ON_REQ_POWEROFF_MASK |
 					 BD718XX_SWRESET_POWEROFF_MASK |
 					 BD718XX_WDOG_POWEROFF_MASK |
@@ -1215,17 +1216,17 @@ static int bd718xx_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
+	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip_type].r_datas[i];
+		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-		config.regmap = mfd->regmap;
+		config.regmap = mfd->chip.regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -1254,7 +1255,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 */
 		if (!use_snvs || !rdev->constraints->always_on ||
 		    !rdev->constraints->boot_on) {
-			err = regmap_update_bits(mfd->regmap, r->init.reg,
+			err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
 						 r->init.mask, r->init.val);
 			if (err) {
 				dev_err(&pdev->dev,
@@ -1264,7 +1265,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 			}
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(mfd->regmap,
+			err = regmap_update_bits(mfd->chip.regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index fd194bfc836f..7f2dbde402a1 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -4,14 +4,9 @@
 #ifndef __LINUX_MFD_BD718XX_H__
 #define __LINUX_MFD_BD718XX_H__
 
+#include <linux/mfd/rohm-generic.h>
 #include <linux/regmap.h>
 
-enum {
-	BD718XX_TYPE_BD71837 = 0,
-	BD718XX_TYPE_BD71847,
-	BD718XX_TYPE_AMOUNT
-};
-
 enum {
 	BD718XX_BUCK1 = 0,
 	BD718XX_BUCK2,
@@ -321,18 +316,17 @@ enum {
 	BD718XX_PWRBTN_LONG_PRESS_15S
 };
 
-struct bd718xx_clk;
-
 struct bd718xx {
-	unsigned int chip_type;
-	struct device *dev;
-	struct regmap *regmap;
-	unsigned long int id;
+	/*
+	 * Please keep this as the first member here as some
+	 * drivers (clk) supporting more than one chip may only know this
+	 * generic struct 'struct rohm_regmap_dev' and assume it is
+	 * the first chunk of parent device's private data.
+	 */
+	struct rohm_regmap_dev chip;
 
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
-
-	struct bd718xx_clk *clk;
 };
 
 #endif /* __LINUX_MFD_BD718XX_H__ */
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
new file mode 100644
index 000000000000..bff15ac26f2c
--- /dev/null
+++ b/include/linux/mfd/rohm-generic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2018 ROHM Semiconductors */
+
+#ifndef __LINUX_MFD_ROHM_H__
+#define __LINUX_MFD_ROHM_H__
+
+enum {
+	ROHM_CHIP_TYPE_BD71837 = 0,
+	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD70528,
+	ROHM_CHIP_TYPE_AMOUNT
+};
+
+struct rohm_regmap_dev {
+	unsigned int chip_type;
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
