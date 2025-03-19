Return-Path: <linux-pm+bounces-24320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D08A697D6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776398A5B06
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710621B9F8;
	Wed, 19 Mar 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jlmSt5j0"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1621A45A;
	Wed, 19 Mar 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407914; cv=none; b=ARjE7o7ij2DSxhkdJwOn3zNfMxdP4U5ViVgLYyNW+4Gab/PCO8ttN84fAQD5pdeiGaQlyrt88vYtJUk4zoHh5NkHrjqF8gJ/aeil+pOS0f2pLzmQ1S4ExQQNcxSGVl7XH+B5JGVHFLUX4XTfWGJBImyAB2DtIvsxB7+NEdtJRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407914; c=relaxed/simple;
	bh=2JmBtFbxKKQjNhgOlVG8wfl7nFBIR0TxMAgRZRCiFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHQasTViOVYje1jfehlHmqdMH4MVyTXEppuCSX0McYT+fpggdlE0v78aA7TKYzgp+f6tFpYySYboPcEWASY5Tc16OElhtKcr6uRq4V4kPIVzTxZoNG+ADsa8obVhqpyWlrWPC+nYE0WdV43ljX7w6OrUBEZchlCVH2NOGqijQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jlmSt5j0; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3F57A2E095DB;
	Wed, 19 Mar 2025 20:11:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742407910;
	bh=dWLKrg1FIdgXcQO7bjik/WuI88OIFzXpgBzRQ4lKa5w=; h=From:To:Subject;
	b=jlmSt5j0vQ/1DK57GxGESfdBensyYHh5Ns87Mhp5EjY8ZqhIr9eVFSwOBQrDfroDQ
	 TMDHBKW9acXQyHZmtSUDWMJmxCR7psDmkA+4Yf/je2KcgqmsgPympehYqZxwvDsrbO
	 8FlVROYYObpXNASx6p5IhuCU9wZ5XZP1tmHzHgiw=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v7 14/14] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Date: Wed, 19 Mar 2025 19:10:41 +0100
Message-ID: <20250319181044.392235-15-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319181044.392235-1-lkml@antheas.dev>
References: <20250319181044.392235-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240790985.3578.1398837508702229341@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
feature to their devices. Charge limit allows for choosing an arbitrary
battery charge setpoint in percentages. Charge ihibit allows to instruct
the device to stop charging either when it is awake or always.

This feature was then extended for the F1Pro as well. OneXPlayer also
released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
add support for this feature. Therefore, enable it for all F1 and
X1 devices.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig |   1 +
 drivers/platform/x86/oxpec.c | 160 ++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 82cfc76bc5c9f..f4d993658c01f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1189,6 +1189,7 @@ config SEL3350_PLATFORM
 config OXP_EC
 	tristate "OneXPlayer EC platform control"
 	depends on ACPI_EC
+	depends on ACPI_BATTERY
 	depends on HWMON
 	depends on X86
 	help
diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 2e4c7e6188f08..3c445932fccbb 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/processor.h>
+#include <acpi/battery.h>
 
 /* Handle ACPI lock mechanism */
 static u32 oxp_mutex;
@@ -60,6 +61,7 @@ enum oxp_board {
 };
 
 static enum oxp_board board;
+static struct device *oxp_dev;
 
 /* Fan reading and PWM */
 #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
@@ -93,6 +95,23 @@ static enum oxp_board board;
 #define OXP_X1_TURBO_LED_OFF           0x01
 #define OXP_X1_TURBO_LED_ON            0x02
 
+/* Battery extension settings */
+#define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE))
+
+#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
+#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
+
+#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
+/*
+ * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
+ * but the extra bit on the X1 does nothing.
+ */
+#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
+#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_AWAKE | \
+	OXP_X1_CHARGE_INHIBIT_MASK_OFF)
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -507,6 +526,129 @@ static ssize_t tt_led_show(struct device *dev,
 
 static DEVICE_ATTR_RW(tt_led);
 
+/* Callbacks for charge behaviour attributes */
+static bool oxp_psy_ext_supported(void)
+{
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static int oxp_psy_ext_get_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	long raw_val;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		ret = read_from_ec(OXP_X1_CHARGE_LIMIT_REG, 1, &raw_val);
+		if (ret)
+			return ret;
+		if (raw_val > 100)
+			return -EINVAL;
+		val->intval = raw_val;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = read_from_ec(OXP_X1_CHARGE_INHIBIT_REG, 1, &raw_val);
+		if (ret)
+			return ret;
+		if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS) ==
+		    OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		else if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_AWAKE) ==
+			 OXP_X1_CHARGE_INHIBIT_MASK_AWAKE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int oxp_psy_ext_set_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	long raw_val;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval > 100)
+			return -EINVAL;
+		return write_to_ec(OXP_X1_CHARGE_LIMIT_REG, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch (val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			raw_val = 0;
+			break;
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE:
+			raw_val = OXP_X1_CHARGE_INHIBIT_MASK_AWAKE;
+			break;
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			raw_val = OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return write_to_ec(OXP_X1_CHARGE_INHIBIT_REG, raw_val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int oxp_psy_prop_is_writeable(struct power_supply *psy,
+					    const struct power_supply_ext *ext,
+					    void *data,
+					    enum power_supply_property psp)
+{
+	return true;
+}
+
+static const enum power_supply_property oxp_psy_ext_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+struct power_supply_ext oxp_psy_ext = {
+	.name			= "oxp-charge-control",
+	.properties		= oxp_psy_ext_props,
+	.num_properties		= ARRAY_SIZE(oxp_psy_ext_props),
+	.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS,
+	.get_property		= oxp_psy_ext_get_prop,
+	.set_property		= oxp_psy_ext_set_prop,
+	.property_is_writeable	= oxp_psy_prop_is_writeable,
+};
+
+static int oxp_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	return power_supply_register_extension(battery, &oxp_psy_ext, oxp_dev, NULL);
+}
+
+static int oxp_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	power_supply_unregister_extension(battery, &oxp_psy_ext);
+	return 0;
+}
+
+static struct acpi_battery_hook battery_hook = {
+	.add_battery	= oxp_add_battery,
+	.remove_battery	= oxp_remove_battery,
+	.name		= "OneXPlayer Battery",
+};
+
 /* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
@@ -845,12 +987,22 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
 static int oxp_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device *hwdev;
+	int ret;
+
+	oxp_dev = dev;
+	ret = PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(
+		dev, "oxp_ec", NULL, &oxp_ec_chip_info, NULL));
 
-	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
-						     &oxp_ec_chip_info, NULL);
+	if (ret)
+		return ret;
 
-	return PTR_ERR_OR_ZERO(hwdev);
+	if (oxp_psy_ext_supported()) {
+		ret = devm_battery_hook_register(dev, &battery_hook);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static struct platform_driver oxp_platform_driver = {
-- 
2.48.1


