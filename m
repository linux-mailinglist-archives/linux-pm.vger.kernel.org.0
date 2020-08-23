Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF224ED7D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHWOKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgHWOKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF1C061573;
        Sun, 23 Aug 2020 07:10:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so6748868ljn.2;
        Sun, 23 Aug 2020 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrKpeaWDCIbs0elrD0ervQn0EwoALOJQTmF6gmGudwk=;
        b=A3ankdiXKQcXxNVb464Y9CSK8uZmn/v7wkTOr8ZC32VSlRfBoFrDH9dldQUNZ7q0db
         be4up2EcJQJBIdQQz9wiwmaqw3OWktrzv2EWG6NF8TEhxszYwHIYQHWbNrGRy7yXxsxj
         lwljaYDN0oder2d2R+V/5pkX7BJBeiYRdExzhzeNnEuBvxypdCPmh6zhNzDv1iB5KMHe
         Y9x88UI5AEnSAelmciveimSf60PLvJtOj6Sp40TlaKfppYSiiTU2lNiyyyAVkK+0XMn4
         VX2XrODp+74zcfNE8IdwYMb/Y5OfIBRzLTT3ea1lZxvDnKTMHsQhEBTBBdNZIiwGElyX
         556A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrKpeaWDCIbs0elrD0ervQn0EwoALOJQTmF6gmGudwk=;
        b=eWkZsLwWWhXzjx93r90U9S37Oh1HdLfjisGd3I8WyipTAk1Mzc2XAP1pDzuUHCL5Kl
         9muzBfsqyDMO81MKnlIvCTv0yhkeuq5oKFX+V8HDHs3Grz80JjKEiCtApyUDsZHxmdqb
         3uXdz0AijQgwMfJpS+a4EZ7cu4VWzUy25j3rhdvIb6u6MtXGX/Seb5MDY94HRYg1eULf
         Fb8TLlFrtMYE8Lh4GaWisiqQZ5xxTrw5nOZnJmhqMy4te2Qi2L3+mrIDHX3/649ItmNy
         QUX4unH5bB1AdELWTdp6daBnu1IJNpYXjCSt8RJ//4oaIBuKzLoxBnLd/u7WxCvUDZ/5
         TZlw==
X-Gm-Message-State: AOAM532DiR321wedcAM0wvR+vnKMpQSMpiOgpwuvnGY59vBdp2h4uO1z
        qsbLY1oztMsadOPduU7X7+0=
X-Google-Smtp-Source: ABdhPJwekZiY1NZHt+Cdvdzj6xO2L+gKT49464XJ7ZAmN4KyeCBtxLFZpi+kAiwchVtaC4TrvVludg==
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr626731ljg.95.1598191803007;
        Sun, 23 Aug 2020 07:10:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:10:02 -0700 (PDT)
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
Subject: [PATCH v1 3/6] leds: Add driver for Acer Iconia Tab A500
Date:   Sun, 23 Aug 2020 17:08:43 +0300
Message-Id: <20200823140846.19299-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823140846.19299-1-digetx@gmail.com>
References: <20200823140846.19299-1-digetx@gmail.com>
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
 drivers/leds/leds-acer-a500.c | 121 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
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
index 000000000000..65e69a40a91a
--- /dev/null
+++ b/drivers/leds/leds-acer-a500.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Power button LED driver for Acer Iconia Tab A500.
+ *
+ * Copyright 2020 GRATE-driver project.
+ */
+
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/acer-ec-a500.h>
+
+struct a500_ec_led {
+	struct led_classdev cdev;
+	struct a500_ec_led *other_led;
+	const struct a500_ec_cmd *cmd;
+};
+
+/*					cmd	delay ms */
+A500_EC_COMMAND(RESET_LEDS,		0x40,	100);
+A500_EC_COMMAND(POWER_LED_ON,		0x42,	100);
+A500_EC_COMMAND(CHARGE_LED_ON,		0x43,	100);
+A500_EC_COMMAND(ANDROID_LEDS_OFF,	0x5A,	100);
+
+static int a500_ec_led_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness value)
+{
+	struct device *a500_ec_leds_dev = led_cdev->dev->parent;
+	struct a500_ec *ec_chip = dev_get_drvdata(a500_ec_leds_dev->parent);
+	struct a500_ec_led *led = container_of(led_cdev, struct a500_ec_led,
+					       cdev);
+	int ret;
+
+	a500_ec_lock(ec_chip);
+
+	if (value) {
+		ret = a500_ec_write_locked(ec_chip, led->cmd, 0);
+	} else {
+		/*
+		 * There is no separate controls which can disable LEDs
+		 * individually, there is only RESET_LEDS command that turns
+		 * off both LEDs.
+		 */
+		ret = a500_ec_write_locked(ec_chip, RESET_LEDS, 0);
+		if (ret)
+			goto unlock;
+
+		led = led->other_led;
+
+		/* RESET_LEDS turns off both LEDs, thus restore other LED */
+		if (led->cdev.brightness == LED_ON)
+			ret = a500_ec_write_locked(ec_chip, led->cmd, 0);
+	}
+
+unlock:
+	a500_ec_unlock(ec_chip);
+
+	return ret;
+}
+
+static int a500_ec_leds_probe(struct platform_device *pdev)
+{
+	struct a500_ec *ec_chip = dev_get_drvdata(pdev->dev.parent);
+	struct a500_ec_led *white_led, *orange_led;
+	int err;
+
+	/* reset and turn off all LEDs */
+	a500_ec_write(ec_chip, RESET_LEDS, 0);
+	a500_ec_write(ec_chip, ANDROID_LEDS_OFF, 0);
+
+	white_led = devm_kzalloc(&pdev->dev, sizeof(*white_led), GFP_KERNEL);
+	if (!white_led)
+		return -ENOMEM;
+
+	white_led->cdev.name = "power-button-white";
+	white_led->cdev.brightness_set_blocking = a500_ec_led_brightness_set;
+	white_led->cdev.flags = LED_CORE_SUSPENDRESUME;
+	white_led->cdev.max_brightness = LED_ON;
+	white_led->cmd = &A500_EC_POWER_LED_ON;
+
+	orange_led = devm_kzalloc(&pdev->dev, sizeof(*orange_led), GFP_KERNEL);
+	if (!orange_led)
+		return -ENOMEM;
+
+	orange_led->cdev.name = "power-button-orange";
+	orange_led->cdev.brightness_set_blocking = a500_ec_led_brightness_set;
+	orange_led->cdev.flags = LED_CORE_SUSPENDRESUME;
+	orange_led->cdev.max_brightness = LED_ON;
+	orange_led->cmd = &A500_EC_CHARGE_LED_ON;
+
+	white_led->other_led = orange_led;
+	orange_led->other_led = white_led;
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
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

