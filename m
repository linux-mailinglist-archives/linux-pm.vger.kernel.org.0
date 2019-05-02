Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E722911672
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEBJSB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 05:18:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43719 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBJSB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:18:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id t1so1482900lje.10;
        Thu, 02 May 2019 02:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epSl3spZqeI9f2/hoVfacEbUpMIwis87JJi4pAjJQUQ=;
        b=oFhCafDwq5px2QK/xaJF3qEFbRXds0f0R3hKTpcQwTKgWJz8FVfMiWBt9LIdrDD6rW
         QHo3sN5T2SdJsdlyoiclEw6g190ELeAIHlzoQLAiKtoJ+bW7tIiUmYtrJHaXdU4erriC
         utWbWlEqe2GWDVTHbtSGo9vE4LMMeOIud9y9+/JKcA0dZe1aggAIOGj8FUyJ2mPBrXt6
         OlrJkoRfyRRiLMbI+vroKgJHo3qJuAcTA/Iu5z5JikNhoQ8QaLAABuWbyN8LSSWP+4UM
         H9HGRp1YowiwWXQUiJxiFjej484RWSU9Mw71ubxlcqOxei3l1v7zzjaVwgybu9CQ7581
         S8/Q==
X-Gm-Message-State: APjAAAW/TCkjy/RW4xIlV5++gJuap/UWRqhHbOStaqT4lFJ3aaq2bRCc
        UV72wA9kSHIQ66pd52Ps+bM=
X-Google-Smtp-Source: APXvYqzPfePhmFLT/N5FxZs3+1PD4QytqMuMlpR+YU610lSb/N9Xrmm3OFp3P6uXBA5myO/DpE/l8A==
X-Received: by 2002:a2e:92ce:: with SMTP id k14mr1285784ljh.83.1556788676829;
        Thu, 02 May 2019 02:17:56 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y20sm9372507lfe.8.2019.05.02.02.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 02:17:56 -0700 (PDT)
Date:   Thu, 2 May 2019 12:17:43 +0300
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
Subject: [PATCH v14 8/8] watchdog: bd70528: Initial support for ROHM BD70528
 watchdog block
Message-ID: <d30a0c4e66ba6e88877814f34260e89bd8cf54d6.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
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

Initial support for watchdog block included in ROHM BD70528
power management IC.

Configurations for low power states are still to be checked.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changelog v14: No changes

 drivers/watchdog/Kconfig       |  12 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd70528_wdt.c | 290 +++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/watchdog/bd70528_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea859637..a00bf649d7f0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
 	  watchdog. Be aware that governors might affect the watchdog because it
 	  is purely software, e.g. the panic governor will stall it!
 
+config BD70528_WATCHDOG
+	tristate "ROHM BD70528 PMIC Watchdog"
+	depends on MFD_ROHM_BD70528
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
+	  cause system reset.
+
+	  Say Y here to include support for the ROHM BD70528 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called bd70528_wdt.
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052 || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ba930e464657..3985922c440a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -205,6 +205,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
+obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
new file mode 100644
index 000000000000..b0152fef4fc7
--- /dev/null
+++ b/drivers/watchdog/bd70528_wdt.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// ROHM BD70528MWV watchdog driver
+
+#include <linux/bcd.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+/*
+ * Max time we can set is 1 hour, 59 minutes and 59 seconds
+ * and Minimum time is 1 second
+ */
+#define WDT_MAX_MS	((2 * 60 * 60 - 1) * 1000)
+#define WDT_MIN_MS	1000
+#define DEFAULT_TIMEOUT	60
+
+#define WD_CTRL_MAGIC1 0x55
+#define WD_CTRL_MAGIC2 0xAA
+
+struct wdtbd70528 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct rohm_regmap_dev *mfd;
+	struct watchdog_device wdt;
+};
+
+/**
+ * bd70528_wdt_set - arm or disarm watchdog timer
+ *
+ * @data:	device data for the PMIC instance we want to operate on
+ * @enable:	new state of WDT. zero to disable, non zero to enable
+ * @old_state:	previous state of WDT will be filled here
+ *
+ * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
+ * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
+ * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
+ */
+int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state)
+{
+	int ret, i;
+	unsigned int tmp;
+	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
+						 chip);
+	u8 wd_ctrl_arr[3] = { WD_CTRL_MAGIC1, WD_CTRL_MAGIC2, 0 };
+	u8 *wd_ctrl = &wd_ctrl_arr[2];
+
+	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
+	if (ret)
+		return ret;
+
+	*wd_ctrl = (u8)tmp;
+
+	if (old_state) {
+		if (*wd_ctrl & BD70528_MASK_WDT_EN)
+			*old_state |= BD70528_WDT_STATE_BIT;
+		else
+			*old_state &= ~BD70528_WDT_STATE_BIT;
+		if ((!enable) == (!(*old_state & BD70528_WDT_STATE_BIT)))
+			return 0;
+	}
+
+	if (enable) {
+		if (*wd_ctrl & BD70528_MASK_WDT_EN)
+			return 0;
+		*wd_ctrl |= BD70528_MASK_WDT_EN;
+	} else {
+		if (*wd_ctrl & BD70528_MASK_WDT_EN)
+			*wd_ctrl &= ~BD70528_MASK_WDT_EN;
+		else
+			return 0;
+	}
+
+	for (i = 0; i < 3; i++) {
+		ret = regmap_write(bd70528->chip.regmap, BD70528_REG_WDT_CTRL,
+				   wd_ctrl_arr[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
+	if ((tmp & BD70528_MASK_WDT_EN) != (*wd_ctrl & BD70528_MASK_WDT_EN)) {
+		dev_err(bd70528->chip.dev,
+			"Watchdog ctrl mismatch (hw) 0x%x (set) 0x%x\n",
+			tmp, *wd_ctrl);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(bd70528_wdt_set);
+
+/**
+ * bd70528_wdt_lock - take WDT lock
+ *
+ * @bd70528:	device data for the PMIC instance we want to operate on
+ *
+ * Lock WDT for arming/disarming in order to avoid race condition caused
+ * by WDT state changes initiated by WDT and RTC drivers.
+ */
+void bd70528_wdt_lock(struct rohm_regmap_dev *data)
+{
+	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
+						 chip);
+
+	mutex_lock(&bd70528->rtc_timer_lock);
+}
+EXPORT_SYMBOL(bd70528_wdt_lock);
+
+/**
+ * bd70528_wdt_unlock - unlock WDT lock
+ *
+ * @bd70528:	device data for the PMIC instance we want to operate on
+ *
+ * Unlock WDT lock which has previously been taken by call to
+ * bd70528_wdt_lock.
+ */
+void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
+{
+	struct bd70528_data *bd70528 = container_of(data, struct bd70528_data,
+						 chip);
+
+	mutex_unlock(&bd70528->rtc_timer_lock);
+}
+EXPORT_SYMBOL(bd70528_wdt_unlock);
+
+static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
+{
+	return bd70528_wdt_set(w->mfd, enable, NULL);
+}
+
+static int bd70528_wdt_change(struct wdtbd70528 *w, int enable)
+{
+	int ret;
+
+	bd70528_wdt_lock(w->mfd);
+	ret = bd70528_wdt_set_locked(w, enable);
+	bd70528_wdt_unlock(w->mfd);
+
+	return ret;
+}
+
+static int bd70528_wdt_start(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT ping...\n");
+	return bd70528_wdt_change(w, 1);
+}
+
+static int bd70528_wdt_stop(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT stopping...\n");
+	return bd70528_wdt_change(w, 0);
+}
+
+static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
+{
+	unsigned int hours;
+	unsigned int minutes;
+	unsigned int seconds;
+	int ret;
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	seconds = timeout;
+	hours = timeout / (60 * 60);
+	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
+	if (hours)
+		seconds -= (60 * 60);
+	minutes = seconds / 60;
+	seconds = seconds % 60;
+
+	bd70528_wdt_lock(w->mfd);
+
+	ret = bd70528_wdt_set_locked(w, 0);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
+				 BD70528_MASK_WDT_HOUR, hours);
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT hours\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
+				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT minutes\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
+				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
+	if (ret)
+		dev_err(w->dev, "Failed to set WDT seconds\n");
+	else
+		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
+
+out_en_unlock:
+	ret = bd70528_wdt_set_locked(w, 1);
+out_unlock:
+	bd70528_wdt_unlock(w->mfd);
+
+	return ret;
+}
+
+static const struct watchdog_info bd70528_wdt_info = {
+	.identity = "bd70528-wdt",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops bd70528_wdt_ops = {
+	.start		= bd70528_wdt_start,
+	.stop		= bd70528_wdt_stop,
+	.set_timeout	= bd70528_wdt_set_timeout,
+};
+
+static int bd70528_wdt_probe(struct platform_device *pdev)
+{
+	struct rohm_regmap_dev *bd70528;
+	struct wdtbd70528 *w;
+	int ret;
+	unsigned int reg;
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	w->regmap = bd70528->regmap;
+	w->mfd = bd70528;
+	w->dev = &pdev->dev;
+
+	w->wdt.info = &bd70528_wdt_info;
+	w->wdt.ops =  &bd70528_wdt_ops;
+	w->wdt.min_hw_heartbeat_ms = WDT_MIN_MS;
+	w->wdt.max_hw_heartbeat_ms = WDT_MAX_MS;
+	w->wdt.parent = pdev->dev.parent;
+	w->wdt.timeout = DEFAULT_TIMEOUT;
+	watchdog_set_drvdata(&w->wdt, w);
+	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
+
+	ret = bd70528_wdt_set_timeout(&w->wdt, w->wdt.timeout);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
+		return ret;
+	}
+
+	bd70528_wdt_lock(w->mfd);
+	ret = regmap_read(w->regmap, BD70528_REG_WDT_CTRL, &reg);
+	bd70528_wdt_unlock(w->mfd);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
+		return ret;
+	}
+	if (reg & BD70528_MASK_WDT_EN) {
+		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
+		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
+	}
+
+	ret = devm_watchdog_register_device(&pdev->dev, &w->wdt);
+	if (ret < 0)
+		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver bd70528_wdt = {
+	.driver = {
+		.name = "bd70528-wdt"
+	},
+	.probe = bd70528_wdt_probe,
+};
+
+module_platform_driver(bd70528_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
