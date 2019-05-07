Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15116183
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGJxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 05:53:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEGJxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 05:53:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9EEDA282A09
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-pm@vger.kernel.org, sre@kernel.org
Cc:     Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v4 2/2] power: supply: cros: allow to set input voltage and current limit
Date:   Tue,  7 May 2019 11:52:48 +0200
Message-Id: <20190507095248.17915-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507095248.17915-1-enric.balletbo@collabora.com>
References: <20190507095248.17915-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch allows reading and writing the input voltage and current
limit through the POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT and
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs properties. This allows
userspace to see current values and to re-configure these values at
runtime based on system-level knowledge or user input.

By default there is no limit, this is reported as a -1 when reading from
userspace. Writing a value will set the current or voltage limit in uA
or uV, and writing any negative value will remove that limit.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Fix the upper limit that can be set.
- Remove unnecessary else.

 drivers/power/supply/cros_usbpd-charger.c | 116 ++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 7e9c3984ef6a..3a9ea94c3de3 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -53,6 +53,8 @@ struct charger_data {
 };
 
 static enum power_supply_property cros_usbpd_charger_props[] = {
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
@@ -80,6 +82,10 @@ static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
 };
 
+/* Input voltage/current limit in mV/mA. Default to none. */
+static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
+static u16 input_current_limit = EC_POWER_LIMIT_NONE;
+
 static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
 {
 	return port->port_number >= port->charger->num_usbpd_ports;
@@ -324,6 +330,26 @@ static int cros_usbpd_charger_get_port_status(struct port_data *port,
 	return ret;
 }
 
+static int cros_usbpd_charger_set_ext_power_limit(struct charger_data *charger,
+						  u16 current_lim,
+						  u16 voltage_lim)
+{
+	struct ec_params_external_power_limit_v1 req;
+	int ret;
+
+	req.current_lim = current_lim;
+	req.voltage_lim = voltage_lim;
+
+	ret = cros_usbpd_charger_ec_command(charger, 0,
+					    EC_CMD_EXTERNAL_POWER_LIMIT,
+					    &req, sizeof(req), NULL, 0);
+	if (ret < 0)
+		dev_err(charger->dev,
+			"Unable to set the 'External Power Limit': %d\n", ret);
+
+	return ret;
+}
+
 static void cros_usbpd_charger_power_changed(struct power_supply *psy)
 {
 	struct port_data *port = power_supply_get_drvdata(psy);
@@ -396,6 +422,18 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		val->intval = port->psy_usb_type;
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (input_current_limit == EC_POWER_LIMIT_NONE)
+			val->intval = -1;
+		else
+			val->intval = input_current_limit * 1000;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		if (input_voltage_limit == EC_POWER_LIMIT_NONE)
+			val->intval = -1;
+		else
+			val->intval = input_voltage_limit * 1000;
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = port->model_name;
 		break;
@@ -409,6 +447,81 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 	return 0;
 }
 
+static int cros_usbpd_charger_set_prop(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	struct port_data *port = power_supply_get_drvdata(psy);
+	struct charger_data *charger = port->charger;
+	struct device *dev = charger->dev;
+	u16 intval;
+	int ret;
+
+	/* U16_MAX in mV/mA is the maximum supported value */
+	if (val->intval >= U16_MAX * 1000)
+		return -EINVAL;
+	/* A negative number is used to clear the limit */
+	if (val->intval < 0)
+		intval = EC_POWER_LIMIT_NONE;
+	else	/* Convert from uA/uV to mA/mV */
+		intval = val->intval / 1000;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = cros_usbpd_charger_set_ext_power_limit(charger, intval,
+							input_voltage_limit);
+		if (ret < 0)
+			break;
+
+		input_current_limit = intval;
+		if (input_current_limit == EC_POWER_LIMIT_NONE)
+			dev_info(dev,
+			  "External Current Limit cleared for all ports\n");
+		else
+			dev_info(dev,
+			  "External Current Limit set to %dmA for all ports\n",
+			  input_current_limit);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = cros_usbpd_charger_set_ext_power_limit(charger,
+							input_current_limit,
+							intval);
+		if (ret < 0)
+			break;
+
+		input_voltage_limit = intval;
+		if (input_voltage_limit == EC_POWER_LIMIT_NONE)
+			dev_info(dev,
+			  "External Voltage Limit cleared for all ports\n");
+		else
+			dev_info(dev,
+			  "External Voltage Limit set to %dmV for all ports\n",
+			  input_voltage_limit);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = 1;
+		break;
+	default:
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
 				       unsigned long queued_during_suspend,
 				       void *_notify)
@@ -525,6 +638,9 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 		psy_desc = &port->psy_desc;
 		psy_desc->get_property = cros_usbpd_charger_get_prop;
+		psy_desc->set_property = cros_usbpd_charger_set_prop;
+		psy_desc->property_is_writeable =
+				cros_usbpd_charger_property_is_writeable;
 		psy_desc->external_power_changed =
 					cros_usbpd_charger_power_changed;
 		psy_cfg.drv_data = port;
-- 
2.20.1

