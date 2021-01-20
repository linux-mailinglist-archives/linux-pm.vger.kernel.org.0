Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C251D2FD8AC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbhATSpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404640AbhATSZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 13:25:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E2C0613ED;
        Wed, 20 Jan 2021 10:23:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a10so18242180ejg.10;
        Wed, 20 Jan 2021 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=piJ2WifNK2/64OE6iqYE/GF1H+oJGYHj5IgcljmDyNY=;
        b=ek+HeOVy4sfupZJoD14sCJaf2Ag1fG9Aw4DtSkfrmA3qalMR3e6F8UFJuZgFzyp0DU
         FnXEqjHBlwhvpYZXuK+AA+F35MhAf+AncDGyMmhR90ArVZoIQo2gkyQqhTwuNQic4xse
         TXzUvFeZ33W52bkCH4FgJQTjUDTtl/dviXIVY361IXDV3wWJ/5cGoqVgcSoDKbfyPqdS
         Nzu1ge2Su1kbleB2CU5OXExEIQdnq8UCuFnJe3silF41Xl5EMt9nLtDwDD3gQjWD5h5J
         ZzNreiyFGij3f0v/7hNfPte9v2Fi9+v3CXhQTQLrI1oea7ULL3dV7EzrmPoEqg5Hb2Iv
         x6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=piJ2WifNK2/64OE6iqYE/GF1H+oJGYHj5IgcljmDyNY=;
        b=l9OfZC0npQL96CB4JRBYIzrlqctEZCYsElT2NmnPPedOFeUl8vHdtnc8gT5yEOGqMr
         ldYwNOLlzcEKHMr31oxov8pZw0T468ZO0A1WycgW2iN5JmMi1XmtuMOcnrRmOKNTnVuH
         U85ntnsMFG3Nlslk7g2wXrnlEeAkvXF630ivcgWw/iSfpyegEVdgZgIyci7XxsptfCg7
         VEW1QugH/J5D870tLdraHe5c4YuGBcf6HYe8NIJh1HCpEsRyMhcExcNIvsCEy/4ti0aq
         EgTwRAdbIWXCa/Y5UhfQr+7e1ItE4ZoHJRbjGXbYu3mn0iPO45qqeFRgrN0kRR3LmuW6
         9zBQ==
X-Gm-Message-State: AOAM532ySUFoWbJ2FD/o5Lq5XWZzzHeFY9aqfKSXAqAvLR3UQG3bQ7PY
        QzKC6p1dpC2MOPm5U8kXtP0=
X-Google-Smtp-Source: ABdhPJw4MHBsHDQOgD3y0t/1JOk8eBxapXlZjW/EZIdHazRresOrYDTUHJTpjF8qLxa8H07g/2E1DA==
X-Received: by 2002:a17:906:14d5:: with SMTP id y21mr7044603ejc.410.1611167027836;
        Wed, 20 Jan 2021 10:23:47 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id hr31sm1158332ejc.125.2021.01.20.10.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:23:47 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 6/7] input: atc260x: Add onkey driver for ATC260x PMICs
Date:   Wed, 20 Jan 2021 20:23:31 +0200
Message-Id: <27e90b18fa041dbce50e208a3dacc6da79dddd9c.1611165200.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Actions Semi ATC260x PMICs are able to manage an onkey button.
This driver exposes the ATC260x onkey as an input device. It can also
be configured to force a system reset on a long key-press with an
adjustable duration.

The currently supported chip variants are ATC2603C and ATC2609A.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v6:
 - None

Changes in v5:
 - None

Changes in v4:
 - Added Acked-by from Dmitry

Changes in v3: 
 - Integrated Dmitry's review:
   * Dropped the logic around the check for 'pdev->dev.of_node'
   * Renamed 'ret' variable in 'atc260x_onkey_probe()' to 'error'
   * Used 'dev_dbg' instead of 'dev_info' on status KEY_RESET_DISABLED
   * Dropped 'input_dev->evbit[0] = BIT_MASK(EV_KEY);'
   * Removed IRQF_TRIGGER_HIGH flag on 'devm_request_threaded_irq()'
   * Implemented open/close to mitigate the racing issue in
     'atc260x_onkey_remove()' which has been dropped now
 - Removed the unnecessary driver compatibles
 - Used 'reset-time-sec' property of the parent device instead of
   'actions,reset-time-sec' of now obsolete and removed 'onkey' DT node

 drivers/input/misc/Kconfig         |  11 ++
 drivers/input/misc/Makefile        |   2 +-
 drivers/input/misc/atc260x-onkey.c | 305 +++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/misc/atc260x-onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ad1b6c90bc4d..7237dc440b98 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -94,6 +94,17 @@ config INPUT_ARIZONA_HAPTICS
 	  To compile this driver as a module, choose M here: the
 	  module will be called arizona-haptics.
 
+config INPUT_ATC260X_ONKEY
+	tristate "Actions Semi ATC260x PMIC ONKEY"
+	depends on MFD_ATC260X
+	help
+	  Support the ONKEY of ATC260x PMICs as an input device reporting
+	  power button status. ONKEY can be used to wakeup from low power
+	  modes and force a reset on long press.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atc260x-onkey.
+
 config INPUT_ATMEL_CAPTOUCH
 	tristate "Atmel Capacitive Touch Button Driver"
 	depends on OF || COMPILE_TEST
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 7f202ba8f775..46db664a8bc4 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_INPUT_ADXL34X_SPI)		+= adxl34x-spi.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_ARIEL_PWRBUTTON)	+= ariel-pwrbutton.o
 obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
+obj-$(CONFIG_INPUT_ATC260X_ONKEY)	+= atc260x-onkey.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
@@ -86,4 +87,3 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
-
diff --git a/drivers/input/misc/atc260x-onkey.c b/drivers/input/misc/atc260x-onkey.c
new file mode 100644
index 000000000000..999aabf9dcbd
--- /dev/null
+++ b/drivers/input/misc/atc260x-onkey.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Onkey driver for Actions Semi ATC260x PMICs.
+ *
+ * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/atc260x/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* <2s for short press, >2s for long press */
+#define KEY_PRESS_TIME_SEC	2
+
+/* Driver internals */
+enum atc260x_onkey_reset_status {
+	KEY_RESET_HW_DEFAULT,
+	KEY_RESET_DISABLED,
+	KEY_RESET_USER_SEL,
+};
+
+struct atc260x_onkey_params {
+	u32 reg_int_ctl;
+	u32 kdwn_state_bm;
+	u32 long_int_pnd_bm;
+	u32 short_int_pnd_bm;
+	u32 kdwn_int_pnd_bm;
+	u32 press_int_en_bm;
+	u32 kdwn_int_en_bm;
+	u32 press_time_bm;
+	u32 reset_en_bm;
+	u32 reset_time_bm;
+};
+
+struct atc260x_onkey {
+	struct atc260x *atc260x;
+	const struct atc260x_onkey_params *params;
+	struct input_dev *input_dev;
+	struct delayed_work work;
+	int irq;
+};
+
+static const struct atc260x_onkey_params atc2603c_onkey_params = {
+	.reg_int_ctl		= ATC2603C_PMU_SYS_CTL2,
+	.long_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_LONG_PRESS,
+	.short_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_SHORT_PRESS,
+	.kdwn_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_PD,
+	.press_int_en_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_INT_EN,
+	.kdwn_int_en_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN,
+	.kdwn_state_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS,
+	.press_time_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
+	.reset_en_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_RESET_EN,
+	.reset_time_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
+};
+
+static const struct atc260x_onkey_params atc2609a_onkey_params = {
+	.reg_int_ctl		= ATC2609A_PMU_SYS_CTL2,
+	.long_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_LONG_PRESS,
+	.short_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_SHORT_PRESS,
+	.kdwn_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_PD,
+	.press_int_en_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_LSP_INT_EN,
+	.kdwn_int_en_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN,
+	.kdwn_state_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS,
+	.press_time_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
+	.reset_en_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_EN,
+	.reset_time_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
+};
+
+static int atc2603x_onkey_hw_init(struct atc260x_onkey *onkey,
+				  enum atc260x_onkey_reset_status reset_status,
+				  u32 reset_time, u32 press_time)
+{
+	u32 reg_bm, reg_val;
+
+	reg_bm = onkey->params->long_int_pnd_bm |
+		 onkey->params->short_int_pnd_bm |
+		 onkey->params->kdwn_int_pnd_bm |
+		 onkey->params->press_int_en_bm |
+		 onkey->params->kdwn_int_en_bm;
+
+	reg_val = reg_bm | press_time;
+	reg_bm |= onkey->params->press_time_bm;
+
+	if (reset_status == KEY_RESET_DISABLED) {
+		reg_bm |= onkey->params->reset_en_bm;
+	} else if (reset_status == KEY_RESET_USER_SEL) {
+		reg_bm |= onkey->params->reset_en_bm |
+			  onkey->params->reset_time_bm;
+		reg_val |= onkey->params->reset_en_bm | reset_time;
+	}
+
+	return regmap_update_bits(onkey->atc260x->regmap,
+				  onkey->params->reg_int_ctl, reg_bm, reg_val);
+}
+
+static void atc260x_onkey_query(struct atc260x_onkey *onkey)
+{
+	u32 reg_bits;
+	int ret, key_down;
+
+	ret = regmap_read(onkey->atc260x->regmap,
+			  onkey->params->reg_int_ctl, &key_down);
+	if (ret) {
+		key_down = 1;
+		dev_err(onkey->atc260x->dev,
+			"Failed to read onkey status: %d\n", ret);
+	} else {
+		key_down &= onkey->params->kdwn_state_bm;
+	}
+
+	/*
+	 * The hardware generates interrupt only when the onkey pin is
+	 * asserted. Hence, the deassertion of the pin is simulated through
+	 * work queue.
+	 */
+	if (key_down) {
+		schedule_delayed_work(&onkey->work, msecs_to_jiffies(200));
+		return;
+	}
+
+	/*
+	 * The key-down status bit is cleared when the On/Off button
+	 * is released.
+	 */
+	input_report_key(onkey->input_dev, KEY_POWER, 0);
+	input_sync(onkey->input_dev);
+
+	reg_bits = onkey->params->long_int_pnd_bm |
+		   onkey->params->short_int_pnd_bm |
+		   onkey->params->kdwn_int_pnd_bm |
+		   onkey->params->press_int_en_bm |
+		   onkey->params->kdwn_int_en_bm;
+
+	/* Clear key press pending events and enable key press interrupts. */
+	regmap_update_bits(onkey->atc260x->regmap, onkey->params->reg_int_ctl,
+			   reg_bits, reg_bits);
+}
+
+static void atc260x_onkey_work(struct work_struct *work)
+{
+	struct atc260x_onkey *onkey = container_of(work, struct atc260x_onkey,
+						   work.work);
+	atc260x_onkey_query(onkey);
+}
+
+static irqreturn_t atc260x_onkey_irq(int irq, void *data)
+{
+	struct atc260x_onkey *onkey = data;
+	int ret;
+
+	/* Disable key press interrupts. */
+	ret = regmap_update_bits(onkey->atc260x->regmap,
+				 onkey->params->reg_int_ctl,
+				 onkey->params->press_int_en_bm |
+				 onkey->params->kdwn_int_en_bm, 0);
+	if (ret)
+		dev_err(onkey->atc260x->dev,
+			"Failed to disable interrupts: %d\n", ret);
+
+	input_report_key(onkey->input_dev, KEY_POWER, 1);
+	input_sync(onkey->input_dev);
+
+	atc260x_onkey_query(onkey);
+
+	return IRQ_HANDLED;
+}
+
+static int atc260x_onkey_open(struct input_dev *dev)
+{
+	struct atc260x_onkey *onkey = input_get_drvdata(dev);
+
+	enable_irq(onkey->irq);
+
+	return 0;
+}
+
+static void atc260x_onkey_close(struct input_dev *dev)
+{
+	struct atc260x_onkey *onkey = input_get_drvdata(dev);
+
+	disable_irq(onkey->irq);
+	cancel_delayed_work_sync(&onkey->work);
+}
+
+static int atc260x_onkey_probe(struct platform_device *pdev)
+{
+	struct atc260x *atc260x = dev_get_drvdata(pdev->dev.parent);
+	struct atc260x_onkey *onkey;
+	struct input_dev *input_dev;
+	enum atc260x_onkey_reset_status reset_status;
+	u32 press_time = KEY_PRESS_TIME_SEC, reset_time = 0;
+	int val, error;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	error = device_property_read_u32(pdev->dev.parent,
+					 "reset-time-sec", &val);
+	if (error) {
+		reset_status = KEY_RESET_HW_DEFAULT;
+	} else if (val) {
+		if (val < 6 || val > 12) {
+			dev_err(&pdev->dev, "reset-time-sec out of range\n");
+			return -EINVAL;
+		}
+
+		reset_status = KEY_RESET_USER_SEL;
+		reset_time = (val - 6) / 2;
+	} else {
+		reset_status = KEY_RESET_DISABLED;
+		dev_dbg(&pdev->dev, "Disabled reset on long-press\n");
+	}
+
+	switch (atc260x->ic_type) {
+	case ATC2603C:
+		onkey->params = &atc2603c_onkey_params;
+		press_time = FIELD_PREP(ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
+					press_time);
+		reset_time = FIELD_PREP(ATC2603C_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
+					reset_time);
+		break;
+	case ATC2609A:
+		onkey->params = &atc2609a_onkey_params;
+		press_time = FIELD_PREP(ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
+					press_time);
+		reset_time = FIELD_PREP(ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
+					reset_time);
+		break;
+	default:
+		dev_err(&pdev->dev,
+			"OnKey not supported for ATC260x PMIC type: %u\n",
+			atc260x->ic_type);
+		return -EINVAL;
+	}
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev) {
+		dev_err(&pdev->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	onkey->input_dev = input_dev;
+	onkey->atc260x = atc260x;
+
+	input_dev->name = "atc260x-onkey";
+	input_dev->phys = "atc260x-onkey/input0";
+	input_dev->open = atc260x_onkey_open;
+	input_dev->close = atc260x_onkey_close;
+
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
+	input_set_drvdata(input_dev, onkey);
+
+	INIT_DELAYED_WORK(&onkey->work, atc260x_onkey_work);
+
+	onkey->irq = platform_get_irq(pdev, 0);
+	if (onkey->irq < 0)
+		return onkey->irq;
+
+	error = devm_request_threaded_irq(&pdev->dev, onkey->irq, NULL,
+					  atc260x_onkey_irq, IRQF_ONESHOT,
+					  dev_name(&pdev->dev), onkey);
+	if (error) {
+		dev_err(&pdev->dev,
+			"Failed to register IRQ %d: %d\n", onkey->irq, error);
+		return error;
+	}
+
+	/* Keep IRQ disabled until atc260x_onkey_open() is called. */
+	disable_irq(onkey->irq);
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	error = atc2603x_onkey_hw_init(onkey, reset_status,
+				       reset_time, press_time);
+	if (error)
+		return error;
+
+	device_init_wakeup(&pdev->dev, true);
+
+	return 0;
+}
+
+static struct platform_driver atc260x_onkey_driver = {
+	.probe	= atc260x_onkey_probe,
+	.driver	= {
+		.name = "atc260x-onkey",
+	},
+};
+
+module_platform_driver(atc260x_onkey_driver);
+
+MODULE_DESCRIPTION("Onkey driver for ATC260x PMICs");
+MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.0

