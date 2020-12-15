Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666C12DB5FA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgLOVo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 16:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgLOVoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 16:44:07 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A700C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 13:43:27 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id k65so5838232pgk.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FK/Dhl4jOEdFhCBt7KHepEYcFBwWcs3UMMCQSbbGUw=;
        b=CPSZH5yOulKnH9GMvpL5eFw3AOW91JWbsSpd7dPvi6gUtGFSn9r993iW78hHd8qiob
         s02zEhi1/lHe65VHJTwKqAc3dff3OpOyBinrUUQsjQmB4mNXDhuxBEHYvRYOYc9N5N7w
         rcFABqv3Z2ELREFb+pK8LS1fc/+zpdA8lKOtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FK/Dhl4jOEdFhCBt7KHepEYcFBwWcs3UMMCQSbbGUw=;
        b=af1dTIGX3HM/YaqGpD+pKK9IaE+Gigsvz/4eFlbVy7o6UogXRtbfptpfKOBrz52x8M
         z4OXD8YD5Jvldcv317W/1An2QA9bF+5fSlJXOno3irnmtynlwERtepugfJnVzMsyh8Xs
         ipG5jmcOCTY/0UHDXAWA2ZkNQc14MrvOPa3TbAk9AWzYmY8NrsYBFjsRqEHdehVbnYI8
         kJH+TSl/r7K2ot3Y4v+2w4bwH0R0K4YijXB3T8byQtNAnY7KdWkZ10jCnTKqPhW4bc5I
         dSEnbfR5xZsWxs9oHxnOo4CsrXcenY3QoomwBFfz7M2AbszPaZw8VB2ATeeUZMfQP0sv
         awcQ==
X-Gm-Message-State: AOAM531v+t/md7oPZX+u4ylaV8lfLcTRTT6+FPGKSilLEbW+4bnY9l0o
        8PUloQR4DPi75iEIMugmd3y02Q==
X-Google-Smtp-Source: ABdhPJyY2fE0i1TnxuXJ2P1yRSrS9fdA3tk/ATnw/v21BBNPcQd8QK0uZJn6C7jWO1EiebAEUOjEoA==
X-Received: by 2002:a62:ae0c:0:b029:1a5:819d:9ac5 with SMTP id q12-20020a62ae0c0000b02901a5819d9ac5mr11516478pff.26.1608068606871;
        Tue, 15 Dec 2020 13:43:26 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id p16sm50877pju.47.2020.12.15.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:43:26 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alex Levin <levinale@google.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: PCHG: Peripheral device charger
Date:   Tue, 15 Dec 2020 13:43:00 -0800
Message-Id: <20201215214303.2825937-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201215023120.2514920-1-dnojiri@chromium.org>
References: <20201215023120.2514920-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

This driver creates a sysfs node for each peripheral charge port:

	/sys/class/power_supply/PCHGn

where <n> is the index of a charge port.

For example, when a stylus is connected to a NFC/WLC port, the node
prints:

	/sys/class/power_supply/PCHG0/
		capacity=50
		status=Charging
		type=Wireless

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 .../power/supply/cros_peripheral_charger.c    | 346 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  48 +++
 4 files changed, 405 insertions(+)
 create mode 100644 drivers/power/supply/cros_peripheral_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index eec646c568b7be..407f9fbbc2bb50 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -714,6 +714,16 @@ config CHARGER_CROS_USBPD
 	  what is connected to USB PD ports from the EC and converts
 	  that into power_supply properties.
 
+config CHARGER_CROS_PCHG
+	tristate "ChromeOS EC based peripheral charger"
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
+	help
+	  Say Y here to enable ChromeOS EC based peripheral charge driver.
+	  This driver gets various information about the devices connected to
+	  the peripheral charge ports from the EC and converts that into
+	  power_supply properties.
+
 config CHARGER_SC2731
 	tristate "Spreadtrum SC2731 charger driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index dd4b86318cd9bd..5263472a64809b 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
+obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
new file mode 100644
index 00000000000000..db68d3b7c80f32
--- /dev/null
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power supply driver for ChromeOS EC based Peripheral Device Charger.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/stringify.h>
+#include <linux/types.h>
+
+#define DRV_NAME		"cros-ec-pchg"
+#define PCHG_DIR_NAME		"PCHG%d"
+#define PCHG_DIR_NAME_LENGTH	sizeof("PCHG" __stringify(EC_PCHG_MAX_PORTS))
+#define PCHG_CACHE_UPDATE_DELAY	msecs_to_jiffies(500)
+
+struct port_data {
+	int port_number;
+	char name[PCHG_DIR_NAME_LENGTH];
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	int psy_status;
+	int battery_percentage;
+	struct charger_data *charger;
+	unsigned long last_update;
+};
+
+struct charger_data {
+	struct device *dev;
+	struct cros_ec_dev *ec_dev;
+	struct cros_ec_device *ec_device;
+	int num_registered_psy;
+	struct port_data *ports[EC_PCHG_MAX_PORTS];
+	struct notifier_block notifier;
+};
+
+static enum power_supply_property cros_pchg_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	/*
+	 * todo: Add the following.
+	 *
+	 * POWER_SUPPLY_PROP_TECHNOLOGY,
+	 * POWER_SUPPLY_PROP_ERROR,
+	 * POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	 *
+	 * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates the
+	 * system is powered by AC.
+	 */
+};
+
+static int cros_pchg_ec_command(const struct charger_data *charger,
+				unsigned int version,
+				unsigned int command,
+				const void *outdata,
+				unsigned int outsize,
+				void *indata,
+				unsigned int insize)
+{
+	struct cros_ec_dev *ec_dev = charger->ec_dev;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = version;
+	msg->command = ec_dev->cmd_offset + command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outsize)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(charger->ec_device, msg);
+	if (ret >= 0 && insize)
+		memcpy(indata, msg->data, insize);
+
+	kfree(msg);
+	return ret;
+}
+
+static int cros_pchg_port_count(const struct charger_data *charger)
+{
+	struct ec_response_pchg_count rsp;
+	int ret;
+
+	ret = cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
+				   NULL, 0, &rsp, sizeof(rsp));
+	if (ret < 0) {
+		dev_warn(charger->dev,
+			 "Unable to get number or ports (err:%d)\n", ret);
+		return ret;
+	}
+
+	return rsp.port_count;
+}
+
+static int cros_pchg_get_status(struct port_data *port)
+{
+	struct charger_data *charger = port->charger;
+	struct ec_params_pchg req;
+	struct ec_response_pchg rsp;
+	struct device *dev = charger->dev;
+	int ret;
+
+	req.port = port->port_number;
+	ret = cros_pchg_ec_command(charger, 0, EC_CMD_PCHG,
+				   &req, sizeof(req), &rsp, sizeof(rsp));
+	if (ret < 0) {
+		dev_err(dev, "Unable to get port.%d status (err:%d)\n",
+			port->port_number, ret);
+		return ret;
+	}
+
+	switch (rsp.state) {
+	case PCHG_STATE_RESET:
+	case PCHG_STATE_INITIALIZED:
+	case PCHG_STATE_ENABLED:
+	default:
+		port->psy_status = POWER_SUPPLY_STATUS_UNKNOWN;
+		port->battery_percentage = 0;
+		break;
+	case PCHG_STATE_DETECTED:
+		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		port->battery_percentage = rsp.battery_percentage;
+		break;
+	case PCHG_STATE_CHARGING:
+		port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
+		port->battery_percentage = rsp.battery_percentage;
+		break;
+	}
+
+	dev_dbg(dev,
+		"Port %d: state=%d battery=%d%%\n",
+		port->port_number, rsp.state, rsp.battery_percentage);
+
+	return 0;
+}
+
+static int cros_pchg_get_port_status(struct port_data *port, bool ratelimit)
+{
+	int ret;
+
+	if (ratelimit &&
+	    time_is_after_jiffies(port->last_update + PCHG_CACHE_UPDATE_DELAY))
+		return 0;
+
+	ret = cros_pchg_get_status(port);
+	if (ret < 0)
+		return ret;
+
+	port->last_update = jiffies;
+
+	return ret;
+}
+
+static int cros_pchg_get_prop(struct power_supply *psy,
+			      enum power_supply_property psp,
+			      union power_supply_propval *val)
+{
+	struct port_data *port = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_CAPACITY:
+		cros_pchg_get_port_status(port, true);
+		break;
+	default:
+		break;
+	}
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = port->psy_status;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = port->battery_percentage;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cros_pchg_event(const struct charger_data *charger,
+			   unsigned long host_event)
+{
+	int i;
+
+	for (i = 0; i < charger->num_registered_psy; i++)
+		cros_pchg_get_port_status(charger->ports[i], false);
+
+	return NOTIFY_OK;
+}
+
+static u32 cros_get_device_event(const struct charger_data *charger)
+{
+	struct ec_params_device_event req;
+	struct ec_response_device_event rsp;
+	struct device *dev = charger->dev;
+	int ret;
+
+	req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
+	ret = cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
+				   &req, sizeof(req), &rsp, sizeof(rsp));
+	if (ret < 0) {
+		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
+		return 0;
+	}
+
+	return rsp.event_mask;
+}
+
+static int cros_ec_notify(struct notifier_block *nb,
+			  unsigned long queued_during_suspend,
+			  void *data)
+{
+	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+	struct charger_data *charger =
+			container_of(nb, struct charger_data, notifier);
+	u32 device_event_mask;
+
+	if (!host_event)
+		return NOTIFY_BAD;
+
+	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
+		return NOTIFY_DONE;
+
+	/*
+	 * todo: Retrieve device event mask in common place
+	 * (e.g. cros_ec_proto.c).
+	 */
+	device_event_mask = cros_get_device_event(charger);
+	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
+		return NOTIFY_DONE;
+
+	return cros_pchg_event(charger, host_event);
+}
+
+static int cros_pchg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *ec_device = ec_dev->ec_dev;
+	struct power_supply_desc *psy_desc;
+	struct charger_data *charger;
+	struct power_supply *psy;
+	struct port_data *port;
+	struct notifier_block *nb;
+	int num_ports;
+	int ret;
+	int i;
+
+	charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->dev = dev;
+	charger->ec_dev = ec_dev;
+	charger->ec_device = ec_device;
+
+	ret = cros_pchg_port_count(charger);
+	if (ret <= 0) {
+		/*
+		 * This feature is enabled by the EC and the kernel driver is
+		 * included by default for CrOS devices. Don't need to be loud
+		 * since this error can be normal.
+		 */
+		dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
+		return -ENODEV;
+	}
+
+	num_ports = ret;
+	if (num_ports > EC_PCHG_MAX_PORTS) {
+		dev_err(dev, "Too many peripheral charge ports (%d)\n",
+			num_ports);
+		return -ENOBUFS;
+	}
+
+	dev_info(dev, "%d peripheral charge ports found\n", num_ports);
+
+	for (i = 0; i < num_ports; i++) {
+		struct power_supply_config psy_cfg = {};
+
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return -ENOMEM;
+
+		port->charger = charger;
+		port->port_number = i;
+		snprintf(port->name, sizeof(port->name), PCHG_DIR_NAME, i);
+
+		psy_desc = &port->psy_desc;
+		psy_desc->name = port->name;
+		psy_desc->type = POWER_SUPPLY_TYPE_WIRELESS;
+		psy_desc->get_property = cros_pchg_get_prop;
+		psy_desc->external_power_changed = NULL;
+		psy_desc->properties = cros_pchg_props;
+		psy_desc->num_properties = ARRAY_SIZE(cros_pchg_props);
+		psy_cfg.drv_data = port;
+
+		psy = devm_power_supply_register_no_ws(dev, psy_desc, &psy_cfg);
+		if (IS_ERR(psy)) {
+			dev_err(dev, "Failed to register power supply\n");
+			continue;
+		}
+		port->psy = psy;
+
+		charger->ports[charger->num_registered_psy++] = port;
+	}
+
+	if (!charger->num_registered_psy)
+		return -ENODEV;
+
+	nb = &charger->notifier;
+	nb->notifier_call = cros_ec_notify;
+	ret = blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifier,
+					       nb);
+	if (ret < 0)
+		dev_err(dev, "Failed to register notifier (err:%d)\n", ret);
+
+	return 0;
+}
+
+static struct platform_driver cros_pchg_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_pchg_probe
+};
+
+module_platform_driver(cros_pchg_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 58495127dfa656..c0f0a032c8beb6 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4225,6 +4225,7 @@ enum ec_device_event {
 	EC_DEVICE_EVENT_TRACKPAD,
 	EC_DEVICE_EVENT_DSP,
 	EC_DEVICE_EVENT_WIFI,
+	EC_DEVICE_EVENT_WLC,
 };
 
 enum ec_device_event_param {
@@ -5456,6 +5457,53 @@ struct ec_response_rollback_info {
 /* Issue AP reset */
 #define EC_CMD_AP_RESET 0x0125
 
+/**
+ * Get the number of peripheral charge ports
+ */
+#define EC_CMD_PCHG_COUNT 0x0134
+
+#define EC_PCHG_MAX_PORTS 8
+
+struct ec_response_pchg_count {
+	uint8_t port_count;
+} __ec_align1;
+
+/**
+ * Get the status of a peripheral charge port
+ */
+#define EC_CMD_PCHG 0x0135
+
+struct ec_params_pchg {
+	uint8_t port;
+} __ec_align1;
+
+struct ec_response_pchg {
+	uint32_t error; /* enum pchg_error */
+	uint8_t state; /* enum pchg_state state */
+	uint8_t battery_percentage;
+} __ec_align2;
+
+enum pchg_state {
+	/* Charger is reset and not initialized. */
+	PCHG_STATE_RESET = 0,
+	/* Charger is initialized or disabled. */
+	PCHG_STATE_INITIALIZED,
+	/* Charger is enabled and ready to detect a device. */
+	PCHG_STATE_ENABLED,
+	/* Device is detected in proximity. */
+	PCHG_STATE_DETECTED,
+	/* Device is being charged. */
+	PCHG_STATE_CHARGING,
+};
+
+#define EC_PCHG_STATE_TEXT { \
+	[PCHG_STATE_RESET] = "RESET", \
+	[PCHG_STATE_INITIALIZED] = "INITIALIZED", \
+	[PCHG_STATE_ENABLED] = "ENABLED", \
+	[PCHG_STATE_DETECTED] = "DETECTED", \
+	[PCHG_STATE_CHARGING] = "CHARGING", \
+	}
+
 /*****************************************************************************/
 /* Locate peripheral chips
  *
-- 
2.29.2.684.gfbc64c5ab5-goog

