Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2821945B01E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 00:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhKWXa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 18:30:28 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:41009 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240215AbhKWXaY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 18:30:24 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637710029;
        bh=pszJ8TGazGuvxexqpltLSJ+3bJo+VwdtuFcNULoFLfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/yQm2GufR400nhnNbaNAILFGeznccogxSFIBwXL8dyiEb/rnxraSYiWAK6lr3YFd
         3gmFR2lCXMVV+l9hj5H7tVW0hFw+YfPnGNxo6IpWofovRVsJ/RdOBRIIjmjGn6zpBz
         b448HfK3eJ9nKUvfFT5QG9Ftqnv7wEzt8lvzrgh8=
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: [PATCH v2 3/4] platform/x86: thinkpad_acpi: support force-discharge
Date:   Wed, 24 Nov 2021 00:27:03 +0100
Message-Id: <20211123232704.25394-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
References: <20211123232704.25394-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637710019; l=7259; s=20211113; h=from:subject; bh=pszJ8TGazGuvxexqpltLSJ+3bJo+VwdtuFcNULoFLfw=; b=HntqHGVYa0z8SXeBLoU7xPhQqyep59YGddMAxVfR3x02Iw4UZD/I7l+gYBx56ghAcUjKJXgZT/JO Nou86YocBy+iNRbb8MMXAP1FWsiIicHV9ipAtpjGvN/ql1CSu/2Z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for the force-discharge charge_behaviour through the
embedded controller of ThinkPads.

Co-developed-by: Thomas Koch <linrunner@gmx.net>
Signed-off-by: Thomas Koch <linrunner@gmx.net>
Co-developed-by: Nicolò Piazzalunga <nicolopiazzalunga@gmail.com>
Signed-off-by: Nicolò Piazzalunga <nicolopiazzalunga@gmail.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

This patch is based on https://lore.kernel.org/platform-driver-x86/c2504700-06e9-e7d8-80f7-de90b0b6dfb5@gmail.com/
---
 drivers/platform/x86/thinkpad_acpi.c | 131 ++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c632df734bb..e3567cc686fa 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9319,6 +9319,8 @@ static struct ibm_struct mute_led_driver_data = {
 #define SET_START	"BCCS"
 #define GET_STOP	"BCSG"
 #define SET_STOP	"BCSS"
+#define GET_DISCHARGE	"BDSG"
+#define SET_DISCHARGE	"BDSS"
 
 enum {
 	BAT_ANY = 0,
@@ -9335,6 +9337,7 @@ enum {
 	/* This is used in the get/set helpers */
 	THRESHOLD_START,
 	THRESHOLD_STOP,
+	FORCE_DISCHARGE,
 };
 
 struct tpacpi_battery_data {
@@ -9342,6 +9345,7 @@ struct tpacpi_battery_data {
 	int start_support;
 	int charge_stop;
 	int stop_support;
+	unsigned int charge_behaviours;
 };
 
 struct tpacpi_battery_driver_data {
@@ -9399,6 +9403,12 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
 		if (*ret == 0)
 			*ret = 100;
 		return 0;
+	case FORCE_DISCHARGE:
+		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, ret, battery))
+			return -ENODEV;
+		/* The force discharge status is in bit 0 */
+		*ret = *ret & 0x01;
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9427,12 +9437,49 @@ static int tpacpi_battery_set(int what, int battery, int value)
 			return -ENODEV;
 		}
 		return 0;
+	case FORCE_DISCHARGE:
+		/* Force discharge is in bit 0,
+		 * break on AC attach is in bit 1 (won't work on some ThinkPads),
+		 * battery ID is in bits 8-9, 2 bits.
+		 */
+		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_DISCHARGE, &ret, param))) {
+			pr_err("failed to set force discharge on %d", battery);
+			return -ENODEV;
+		}
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
 	}
 }
 
+static int tpacpi_battery_set_validate(int what, int battery, int value)
+{
+	int ret, v;
+
+	ret = tpacpi_battery_set(what, battery, value);
+	if (ret < 0)
+		return ret;
+
+	ret = tpacpi_battery_get(what, battery, &v);
+	if (ret < 0)
+		return ret;
+
+	if (v == value)
+		return 0;
+
+	msleep(500);
+
+	ret = tpacpi_battery_get(what, battery, &v);
+	if (ret < 0)
+		return ret;
+
+	if (v == value)
+		return 0;
+
+	return -EIO;
+}
+
 static int tpacpi_battery_probe(int battery)
 {
 	int ret = 0;
@@ -9445,6 +9492,8 @@ static int tpacpi_battery_probe(int battery)
 	 * 2) Check for support
 	 * 3) Get the current stop threshold
 	 * 4) Check for support
+	 * 5) Get the current force discharge status
+	 * 6) Check for support
 	 */
 	if (acpi_has_method(hkey_handle, GET_START)) {
 		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
@@ -9481,10 +9530,25 @@ static int tpacpi_battery_probe(int battery)
 			return -ENODEV;
 		}
 	}
-	pr_info("battery %d registered (start %d, stop %d)",
-			battery,
-			battery_info.batteries[battery].charge_start,
-			battery_info.batteries[battery].charge_stop);
+	if (acpi_has_method(hkey_handle, GET_DISCHARGE)) {
+		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, &ret, battery))) {
+			pr_err("Error probing battery discharge; %d\n", battery);
+			return -ENODEV;
+		}
+		/* Support is marked in bit 8 */
+		if (ret & BIT(8))
+			battery_info.batteries[battery].charge_behaviours |=
+				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
+	}
+
+	battery_info.batteries[battery].charge_behaviours |=
+		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
+
+	pr_info("battery %d registered (start %d, stop %d, behaviours: 0x%x)\n",
+		battery,
+		battery_info.batteries[battery].charge_start,
+		battery_info.batteries[battery].charge_stop,
+		battery_info.batteries[battery].charge_behaviours);
 
 	return 0;
 }
@@ -9619,6 +9683,28 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
 }
 
+static ssize_t charge_behaviour_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	enum power_supply_charge_behaviour active = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+	struct power_supply *supply = to_power_supply(dev);
+	unsigned int available;
+	int ret, battery;
+
+	battery = tpacpi_battery_get_id(supply->desc->name);
+	available = battery_info.batteries[battery].charge_behaviours;
+
+	if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE)) {
+		if (tpacpi_battery_get(FORCE_DISCHARGE, battery, &ret))
+			return -ENODEV;
+		if (ret)
+			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+	}
+
+	return power_supply_charge_behaviour_show(dev, available, active, buf);
+}
+
 static ssize_t charge_control_start_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
@@ -9633,8 +9719,44 @@ static ssize_t charge_control_end_threshold_store(struct device *dev,
 	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
 }
 
+static ssize_t charge_behaviour_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct power_supply *supply = to_power_supply(dev);
+	int selected, battery, ret = 0;
+	unsigned int available;
+
+	battery = tpacpi_battery_get_id(supply->desc->name);
+	available = battery_info.batteries[battery].charge_behaviours;
+	selected = power_supply_charge_behaviour_parse(available, buf);
+
+	if (selected < 0)
+		return selected;
+
+	switch (selected) {
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+		if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
+			ret = tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 0);
+		if (ret < 0)
+			return ret;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+		ret = tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 1);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		dev_err(dev, "Unexpected charge behaviour: %d\n", selected);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(charge_control_start_threshold);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
+static DEVICE_ATTR_RW(charge_behaviour);
 static struct device_attribute dev_attr_charge_start_threshold = __ATTR(
 	charge_start_threshold,
 	0644,
@@ -9653,6 +9775,7 @@ static struct attribute *tpacpi_battery_attrs[] = {
 	&dev_attr_charge_control_end_threshold.attr,
 	&dev_attr_charge_start_threshold.attr,
 	&dev_attr_charge_stop_threshold.attr,
+	&dev_attr_charge_behaviour.attr,
 	NULL,
 };
 
-- 
2.34.0

