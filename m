Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9898911B504
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfLKPu4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:50:56 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46536 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbfLKPuz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576079439; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAVv3nHLEk4RhtK2wNxT3ZoIYEuNj+Sa4a9OHRLEg+4=;
        b=fcYbF9M0WWNNHOSZVEr3yqqvshp+T3gCdnENeCtOquVxjdmey5y+VHle0wEGjpGppX80go
        ytchmUZhOsAk5z08V62GwKywziD1nubcqX2VJ+IfojC7sWs4dfbKsUhSpLQjIfodugtKkW
        WSRYcQ/Cofy4OltczOiUYW03O5aevxY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Date:   Wed, 11 Dec 2019 16:50:32 +0100
Message-Id: <20191211155032.167032-3-paul@crapouillou.net>
In-Reply-To: <20191211155032.167032-1-paul@crapouillou.net>
References: <20191211155032.167032-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This simple charger driver uses the USB role switch framework to detect
the presence of a charger. The USB charger will report as online when
the USB role is set to device, and offline otherwise.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Instead of detecting charger state from USB PHY, we detect it from the
        USB role in use.

 drivers/power/supply/Kconfig               |   8 ++
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/generic-usb-charger.c | 124 +++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/power/supply/generic-usb-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c..c4221bcabee4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -51,6 +51,14 @@ config GENERIC_ADC_BATTERY
 	  Say Y here to enable support for the generic battery driver
 	  which uses IIO framework to read adc.
 
+config GENERIC_USB_CHARGER
+	tristate "Generic USB charger"
+	depends on USB_SUPPORT
+	select USB_ROLE_SWITCH
+	help
+	  Say Y here to enable a generic USB charger driver which uses
+	  the USB role switch framework to detect the presence of the charger.
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
index 000000000000..0493fafbd4c0
--- /dev/null
+++ b/drivers/power/supply/generic-usb-charger.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple USB charger driver
+ * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/usb/role.h>
+
+struct usb_charger {
+	struct notifier_block nb;
+	struct usb_role_switch *role;
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
+	enum usb_role role;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		role = usb_role_switch_get_role(charger->role);
+		val->intval = role == USB_ROLE_DEVICE;
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
+static void usb_charger_unregister(void *data)
+{
+	struct usb_charger *charger = data;
+
+	usb_role_switch_unregister_notifier(charger->role, &charger->nb);
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
+	cfg.drv_data = charger;
+	charger->nb.notifier_call = usb_charger_event;
+
+	charger->role = usb_role_switch_get(dev);
+	if (IS_ERR(charger->role)) {
+		if (PTR_ERR(charger->role) != -EPROBE_DEFER)
+			dev_err(dev, "Unable to get USB role");
+		return PTR_ERR(charger->role);
+	}
+
+	desc = &charger->desc;
+	desc->name = "usb-charger";
+	desc->properties = usb_charger_properties;
+	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+	desc->get_property = usb_charger_get_property;
+	desc->type = POWER_SUPPLY_TYPE_USB;
+
+	charger->charger = devm_power_supply_register(dev, desc, &cfg);
+	if (IS_ERR(charger->charger)) {
+		dev_err(dev, "Unable to register charger");
+		return PTR_ERR(charger->charger);
+	}
+
+	err = usb_role_switch_register_notifier(charger->role, &charger->nb);
+	if (err) {
+		dev_err(dev, "Unable to register USB role switch notifier");
+		return err;
+	}
+
+	return devm_add_action_or_reset(dev, usb_charger_unregister, charger);
+}
+
+static const struct of_device_id usb_charger_of_match[] = {
+	{ .compatible = "usb-charger" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, usb_charger_of_match);
+
+static struct platform_driver usb_charger_driver = {
+	.driver = {
+		.name = "usb-charger",
+		.of_match_table = of_match_ptr(usb_charger_of_match),
+	},
+	.probe = usb_charger_probe,
+};
+module_platform_driver(usb_charger_driver);
+
+MODULE_DESCRIPTION("Simple USB charger driver");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL");
-- 
2.24.0

