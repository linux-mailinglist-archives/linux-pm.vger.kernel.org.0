Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5EED60A
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 23:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKCWIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 17:08:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48220 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKCWIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 17:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572818919; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9CTqsD8THptmQCEFpxg/CwZExeN/PvOr/4dsnWEMO0=;
        b=W8pOGWDmj2ldrU84zVPols6Lq75fbS0kom6Io3T7zzw8WUh9SyJTApYIfie4c4p9N9V6dB
        m/ojr+m1ywiEGbSW/s4dnf/ZA17sUGJeHSzuo4KBJp/y8/5FodLw7bzzDsCJ1z5UL60N68
        DzknqJdY3WkAMm+PTcHWaXefp9l86i0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] power/supply: Add generic USB charger driver
Date:   Sun,  3 Nov 2019 23:08:01 +0100
Message-Id: <20191103220801.10666-2-paul@crapouillou.net>
In-Reply-To: <20191103220801.10666-1-paul@crapouillou.net>
References: <20191103220801.10666-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This simple charger driver uses the USB PHY framework to detect the
presence of a charger.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/power/supply/Kconfig               |   7 ++
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/generic-usb-charger.c | 140 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/power/supply/generic-usb-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c84a7b1caeb6..069a91d89a42 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -51,6 +51,13 @@ config GENERIC_ADC_BATTERY
 	  Say Y here to enable support for the generic battery driver
 	  which uses IIO framework to read adc.
 
+config GENERIC_USB_CHARGER
+	tristate "Generic USB charger"
+	depends on USB_PHY
+	help
+	  Say Y here to enable a generic USB charger driver which uses
+	  the USB PHY framework to detect the presence of the charger.
+
 config MAX8925_POWER
 	tristate "MAX8925 battery charger support"
 	depends on MFD_MAX8925
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6c7da920ea83..03f9b553bdfc 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -8,6 +8,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
 obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
 obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
+obj-$(CONFIG_GENERIC_USB_CHARGER)	+= generic-usb-charger.o
 
 obj-$(CONFIG_PDA_POWER)		+= pda_power.o
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
diff --git a/drivers/power/supply/generic-usb-charger.c b/drivers/power/supply/generic-usb-charger.c
new file mode 100644
index 000000000000..d005acfc33c7
--- /dev/null
+++ b/drivers/power/supply/generic-usb-charger.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple USB charger driver
+ * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/usb/phy.h>
+
+struct usb_charger {
+	struct usb_phy *phy;
+	struct notifier_block nb;
+	struct power_supply_desc desc;
+	struct power_supply *charger;
+};
+
+static enum power_supply_property usb_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int usb_charger_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct usb_charger *charger = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = charger->phy->chg_state == USB_CHARGER_PRESENT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int usb_charger_event(struct notifier_block *nb,
+			     unsigned long event, void *d)
+{
+	struct usb_charger *charger = container_of(nb, struct usb_charger, nb);
+
+	power_supply_changed(charger->charger);
+
+	return 0;
+}
+
+static int usb_charger_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct power_supply_desc *desc;
+	struct usb_charger *charger;
+	struct power_supply_config cfg = {
+		.of_node = dev->of_node,
+	};
+	int err;
+
+	charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, charger);
+	charger->nb.notifier_call = usb_charger_event;
+	cfg.drv_data = charger;
+
+	if (dev->of_node)
+		charger->phy = devm_usb_get_phy_by_phandle(dev, "phys", 0);
+	else
+		charger->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (IS_ERR(charger->phy)) {
+		err = PTR_ERR(charger->phy);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "No transceiver configured");
+		return err;
+	}
+
+	desc = &charger->desc;
+	desc->name = "usb-charger";
+	desc->properties = usb_charger_properties;
+	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+	desc->get_property = usb_charger_get_property;
+
+	switch (charger->phy->chg_type) {
+	case SDP_TYPE:
+		desc->type = POWER_SUPPLY_TYPE_USB;
+		break;
+	case DCP_TYPE:
+		desc->type = POWER_SUPPLY_TYPE_USB_DCP;
+		break;
+	case CDP_TYPE:
+		desc->type = POWER_SUPPLY_TYPE_USB_CDP;
+		break;
+	case ACA_TYPE:
+		desc->type = POWER_SUPPLY_TYPE_USB_ACA;
+		break;
+	default:
+		desc->type = POWER_SUPPLY_TYPE_UNKNOWN;
+	}
+
+	charger->charger = devm_power_supply_register(dev, desc, &cfg);
+	if (IS_ERR(charger->charger)) {
+		dev_err(dev, "Unable to register charger");
+		return PTR_ERR(charger->charger);
+	}
+
+	return usb_register_notifier(charger->phy, &charger->nb);
+}
+
+static int usb_charger_remove(struct platform_device *pdev)
+{
+	struct usb_charger *charger = platform_get_drvdata(pdev);
+
+	usb_unregister_notifier(charger->phy, &charger->nb);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id usb_charger_of_match[] = {
+	{ .compatible = "usb-charger" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, usb_charger_of_match);
+#endif
+
+static struct platform_driver usb_charger_driver = {
+	.driver = {
+		.name = "usb-charger",
+		.of_match_table = of_match_ptr(usb_charger_of_match),
+	},
+	.probe = usb_charger_probe,
+	.remove = usb_charger_remove,
+};
+module_platform_driver(usb_charger_driver);
+
+MODULE_DESCRIPTION("Simple USB charger driver");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL");
-- 
2.24.0.rc1

