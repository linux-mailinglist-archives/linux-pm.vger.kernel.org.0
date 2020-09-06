Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8325F052
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 21:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIFTv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIFTva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 15:51:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB277C061755;
        Sun,  6 Sep 2020 12:51:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so762947lff.3;
        Sun, 06 Sep 2020 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPl0RuRyAddcYtgA2PYbH+dGQ9rcZfnkqx62zbHZNDs=;
        b=WzGqMuizkdqv3LcT5H63qtHW6T+SWVN5iMJYSnKfpGJKHZ6JFdbUlE4pithhF9HeDW
         2+fDs80rbAlpi+NTZ2EMlAAxI5ftTiHKhYKBgc/if6aCKKn9qz/EJfqa3SkKtWxjBPW9
         3uO80FLONaltAFu9LMZbqrSNa3zTifRV+1L5vhe++y5E+C5rY41sWTNRsLqlV/dcEQfA
         4DaX26o7OJknIUW4UXcf0rK4PEt4cu8rriqdxEgcK0K7zzrMPNrjSOCz+FOkjIKhPLtJ
         7FJyDHMynhxSFTdCb0rm9GuKeJBy1zMZwf14d8vvJH4MCKp30WOtm6INubpcHKiYVNBn
         saLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPl0RuRyAddcYtgA2PYbH+dGQ9rcZfnkqx62zbHZNDs=;
        b=oNZS+pC66MIfUAVRxkvUwTSV/Z4ZhmbKsLng0aDRa/do+kXaD4OHf4L9kgQSOLXiHF
         iieQ1FJmWAsd63bHrc42VR6j0X0pSjVDpKfuPGNrPehAH78HLGxoxnzSWLaEg8eqy8mv
         mvFQmc3X40GUUX1RXTcHqYxIvAxye9beDlaVmuAhIVCjwb2nIp199+jrA9zJ+MeYyB+U
         iJyRtEJ96iQyBNOX2U5pFb4ExqLCKCbpd/yvF6BDM7M4qa2Ps9g0r85qmefs0/pn13FB
         z8LljYVqDgFBLBCf22L3MlksWwdoyZYNSIQFzdBoudefV24lekESA6M5ns68xQBuYb0w
         rUPw==
X-Gm-Message-State: AOAM532RTAYXlOivzmuLjCY9B1e9TTq23OWuV9UydVkJL5j1Ic5JONR0
        CzMnQ9M+EZvDw9LF/mlfh+w=
X-Google-Smtp-Source: ABdhPJwlcl+hj+WdN2P9rse3UxNapsut1UgP1VUvsdjpVIHzLYNPmHLImAIpWUZ2Wyzeu+YVorEOMw==
X-Received: by 2002:a19:f513:: with SMTP id j19mr8572603lfb.174.1599421886018;
        Sun, 06 Sep 2020 12:51:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b7sm4942574lfq.36.2020.09.06.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:51:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] leds: Add driver for Acer Iconia Tab A500
Date:   Sun,  6 Sep 2020 22:51:02 +0300
Message-Id: <20200906195103.1347-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200906195103.1347-1-digetx@gmail.com>
References: <20200906195103.1347-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Acer Iconia Tab A500 is an Android tablet device which has two LEDs
embedded into the Power Button. Orange LED indicates "battery charging"
status and white LED indicates "wake-up/charge-done" status. The new LED
driver provides control over both LEDs to userspace.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/leds/Kconfig          |   7 ++
 drivers/leds/Makefile         |   1 +
 drivers/leds/leds-acer-a500.c | 129 ++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/leds/leds-acer-a500.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 4f6464a169d5..4c39b53bcf1f 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -921,6 +921,13 @@ config LEDS_SGM3140
 	  This option enables support for the SGM3140 500mA Buck/Boost Charge
 	  Pump LED Driver.
 
+config LEDS_ACER_A500
+	tristate "Power button LED support for Acer Iconia Tab A500"
+	depends on LEDS_CLASS && MFD_ACER_A500_EC
+	help
+	  This option enables support for the Power Button LED of
+	  Acer Iconia Tab A500.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 778cb4bb8c52..73e603e1727e 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
 # LED Platform Drivers (keep this sorted, M-| sort)
 obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
 obj-$(CONFIG_LEDS_AAT1290)		+= leds-aat1290.o
+obj-$(CONFIG_LEDS_ACER_A500)		+= leds-acer-a500.o
 obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
diff --git a/drivers/leds/leds-acer-a500.c b/drivers/leds/leds-acer-a500.c
new file mode 100644
index 000000000000..8cf0b11f4390
--- /dev/null
+++ b/drivers/leds/leds-acer-a500.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define A500_EC_LED_DELAY_USEC	(100 * 1000)
+
+enum {
+	REG_RESET_LEDS = 0x40,
+	REG_POWER_LED_ON = 0x42,
+	REG_CHARGE_LED_ON = 0x43,
+	REG_ANDROID_LEDS_OFF = 0x5a,
+};
+
+struct a500_led {
+	struct led_classdev cdev;
+	const struct reg_sequence *enable_seq;
+	struct a500_led *other;
+	struct regmap *rmap;
+};
+
+static const struct reg_sequence a500_ec_leds_reset_seq[] = {
+	REG_SEQ(REG_RESET_LEDS, 0x0, A500_EC_LED_DELAY_USEC),
+	REG_SEQ(REG_ANDROID_LEDS_OFF, 0x0, A500_EC_LED_DELAY_USEC),
+};
+
+static const struct reg_sequence a500_ec_white_led_enable_seq[] = {
+	REG_SEQ(REG_POWER_LED_ON, 0x0, A500_EC_LED_DELAY_USEC),
+};
+
+static const struct reg_sequence a500_ec_orange_led_enable_seq[] = {
+	REG_SEQ(REG_CHARGE_LED_ON, 0x0, A500_EC_LED_DELAY_USEC),
+};
+
+static int a500_ec_led_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness value)
+{
+	struct a500_led *led = container_of(led_cdev, struct a500_led, cdev);
+	struct reg_sequence control_seq[2];
+	unsigned int num_regs = 1;
+
+	if (value) {
+		control_seq[0] = led->enable_seq[0];
+	} else {
+		/*
+		 * There is no separate controls which can disable LEDs
+		 * individually, there is only RESET_LEDS command that turns
+		 * off both LEDs.
+		 *
+		 * RESET_LEDS turns off both LEDs, thus restore other LED if
+		 * it's turned ON.
+		 */
+		if (led->other->cdev.brightness)
+			num_regs = 2;
+
+		control_seq[0] = a500_ec_leds_reset_seq[0];
+		control_seq[1] = led->other->enable_seq[0];
+	}
+
+	return regmap_multi_reg_write(led->rmap, control_seq, num_regs);
+}
+
+static int a500_ec_leds_probe(struct platform_device *pdev)
+{
+	struct a500_led *white_led, *orange_led;
+	struct regmap *rmap;
+	int err;
+
+	rmap = dev_get_regmap(pdev->dev.parent, "KB930");
+	if (!rmap)
+		return -EINVAL;
+
+	/* reset and turn off LEDs */
+	regmap_multi_reg_write(rmap, a500_ec_leds_reset_seq, 2);
+
+	white_led = devm_kzalloc(&pdev->dev, sizeof(*white_led), GFP_KERNEL);
+	if (!white_led)
+		return -ENOMEM;
+
+	white_led->cdev.name = "power:white";
+	white_led->cdev.brightness_set_blocking = a500_ec_led_brightness_set;
+	white_led->cdev.flags = LED_CORE_SUSPENDRESUME;
+	white_led->cdev.max_brightness = 1;
+	white_led->enable_seq = a500_ec_white_led_enable_seq;
+	white_led->rmap = rmap;
+
+	orange_led = devm_kzalloc(&pdev->dev, sizeof(*orange_led), GFP_KERNEL);
+	if (!orange_led)
+		return -ENOMEM;
+
+	orange_led->cdev.name = "power:orange";
+	orange_led->cdev.brightness_set_blocking = a500_ec_led_brightness_set;
+	orange_led->cdev.flags = LED_CORE_SUSPENDRESUME;
+	orange_led->cdev.max_brightness = 1;
+	orange_led->enable_seq = a500_ec_orange_led_enable_seq;
+	orange_led->rmap = rmap;
+
+	white_led->other = orange_led;
+	orange_led->other = white_led;
+
+	err = devm_led_classdev_register(&pdev->dev, &white_led->cdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register white LED\n");
+		return err;
+	}
+
+	err = devm_led_classdev_register(&pdev->dev, &orange_led->cdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register orange LED\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver a500_ec_leds_driver = {
+	.driver = {
+		.name = "acer-a500-iconia-leds",
+	},
+	.probe = a500_ec_leds_probe,
+};
+module_platform_driver(a500_ec_leds_driver);
+
+MODULE_DESCRIPTION("LED driver for Acer Iconia Tab A500 Power Button");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_ALIAS("platform:acer-a500-iconia-leds");
+MODULE_LICENSE("GPL");
-- 
2.27.0

