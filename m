Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF0131CC6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 01:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAGA3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 19:29:24 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39074 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgAGA3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 19:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578356962; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=nDpaTHAJN6PnaV/NUe5XTLxwtko/PI3XInMzN1gqSog=;
        b=IaTVRP+ZrStoqzsgKqnWJM4j6qwUryJ+LTPdbaYmvcUYcFtj4SnzP1wZdS7bzYGWwiDdAn
        OoYZJoGT2Ue72mMspsDx52CUii50p5BpULeOr+s5TZmHiqsf8EEkWayk9ba0j91xuXOj4k
        +eD9JQroJMh606esKCzzJKnk3Cn+/5k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: common: usb-conn-gpio: Register charger
Date:   Tue,  7 Jan 2020 01:29:01 +0100
Message-Id: <20200107002901.940297-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Register a power supply charger, whose online state depends on whether
the USB role is set to device or not.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/common/usb-conn-gpio.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index ed204cbb63ea..08a411388d3c 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/role.h>
 
@@ -38,6 +39,9 @@ struct usb_conn_info {
 	struct gpio_desc *vbus_gpiod;
 	int id_irq;
 	int vbus_irq;
+
+	struct power_supply_desc desc;
+	struct power_supply *charger;
 };
 
 /**
@@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct work_struct *work)
 		ret = regulator_enable(info->vbus);
 		if (ret)
 			dev_err(info->dev, "enable vbus regulator failed\n");
+	} else {
+		power_supply_changed(info->charger);
 	}
 
 	info->last_role = role;
@@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum power_supply_property usb_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int usb_charger_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct usb_conn_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = info->last_role == USB_ROLE_DEVICE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int usb_conn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct power_supply_desc *desc;
 	struct usb_conn_info *info;
+	struct power_supply_config cfg = {
+		.of_node = dev->of_node,
+	};
 	int ret = 0;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -203,6 +234,20 @@ static int usb_conn_probe(struct platform_device *pdev)
 		}
 	}
 
+	desc = &info->desc;
+	desc->name = "usb-charger";
+	desc->properties = usb_charger_properties;
+	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+	desc->get_property = usb_charger_get_property;
+	desc->type = POWER_SUPPLY_TYPE_USB;
+	cfg.drv_data = info;
+
+	info->charger = devm_power_supply_register(dev, desc, &cfg);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Unable to register charger");
+		return PTR_ERR(info->charger);
+	}
+
 	platform_set_drvdata(pdev, info);
 
 	/* Perform initial detection */
-- 
2.24.1

