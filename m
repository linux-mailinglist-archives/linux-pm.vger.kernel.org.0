Return-Path: <linux-pm+bounces-22735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A5A40A0D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D119C060C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A22066F9;
	Sat, 22 Feb 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="rTALcMsd"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CA18A6A7;
	Sat, 22 Feb 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241811; cv=none; b=CyuKTCEn4ZBkANo4TWee4RlFoj3P6dgA/7Ra8wW8xSujOxWTU3jvKu/BZZ2aV8mVR+HYVuUGg/SoBob6Z1qshnsd0+Cm33GVbL9KVvGAp/vlkPDSUlCTAFeVilgTbbT/PIvJiyY0+vrEOY/1x+zqPjBLUH2Slh+pdsfIoeg9ZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241811; c=relaxed/simple;
	bh=ptD+E28yWj/4kpUnWw3yg8/4hW05MT59Bca0OrS2HaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+5P2KTmF8h9HUFPE7aesRjdji1M1yR3UiNw8yymo+jiogenzCQC2WaqhKfjUb0Lr9kqXILynbZBCo7OCPCdYJU5xDoQVg74i7OmzijndaXzPXI33FQxRLq+6vKU3wzUAjf2sHXDnMsBeK56J1Q/yovc4hSA0v5jdisRG3SLMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=rTALcMsd; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 85F952E08C35;
	Sat, 22 Feb 2025 18:20:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740241231;
	bh=EM2Lq7Ny3PABwKeH6JzcQJhmqKCDaXceVQTUoGmPIOI=; h=From:To:Subject;
	b=rTALcMsdImVr9GmkzhQjr1XLEtS3MbGkF7Rvcg4YVP3KmwdQU2VXFBA9oyeqKv6RH
	 WqPsxrxee0hhWZ8zuekpQ0pXqoZAn/Jhe8Ak/AZE8fZqGwtga0cMwDADbmy6RxZA21
	 7MbzajVZEbFTLSm3HldcUmtG9nubE41kwBkpGiIw=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 04/12] hwmon: (oxp-sensors) Add charge threshold and bypass
 to OneXPlayer
Date: Sat, 22 Feb 2025 17:18:15 +0100
Message-ID: <20250222161824.172511-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222161824.172511-1-lkml@antheas.dev>
References: <20250222161824.172511-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174024123077.13752.16639534968203733499@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
their devices. Charge limit allows for choosing an arbitrary battery
charge setpoint in percentages. Charge bypass allows to instruct the
device to stop charging either when its on or always.

This feature was then extended for the F1Pro as well. OneXPlayer also
released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
add support for this feature. Therefore, enable it for all F1 and
X1 devices.

Add both of these under the standard sysfs battery endpoints for them,
by looking for the battery. OneXPlayer devices have a single battery.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hwmon/oxp-sensors.c | 206 ++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index f7a64fbc8f33..f8ffc78deedd 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/processor.h>
+#include <acpi/battery.h>
 
 /* Handle ACPI lock mechanism */
 static u32 oxp_mutex;
@@ -89,6 +90,35 @@ static enum oxp_board board;
 
 #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
 
+#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
+#define OXP_X1_CHARGE_BYPASS_REG     0xA4 /* X1 bypass charging */
+
+#define OXP_X1_CHARGE_BYPASS_MASK_S0 0x01
+/*
+ * Cannot control S3, S5 individually.
+ * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
+ * but the extra bit on the X1 does nothing.
+ */
+#define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
+
+enum charge_type_value_index {
+	CT_OFF,
+	CT_S0,
+	CT_S5,
+};
+
+static u8 charge_type_values_x1[] = {
+	[CT_OFF] = 0x00,
+	[CT_S0] = OXP_X1_CHARGE_BYPASS_MASK_S0,
+	[CT_S5] = OXP_X1_CHARGE_BYPASS_MASK_S0 | OXP_X1_CHARGE_BYPASS_MASK_S3S5,
+};
+
+static const char * const charge_type_strings[] = {
+	[CT_OFF] = "Standard",
+	[CT_S0] = "BypassS0",
+	[CT_S5] = "Bypass",
+};
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -436,6 +466,177 @@ static ssize_t tt_toggle_show(struct device *dev,
 
 static DEVICE_ATTR_RW(tt_toggle);
 
+/* Callbacks for turbo toggle attribute */
+static bool charge_control_supported(void)
+{
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		return 1;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static ssize_t charge_type_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	u64 val, reg;
+	int ret;
+
+	ret = __sysfs_match_string(charge_type_strings,
+				   ARRAY_SIZE(charge_type_strings), buf);
+	if (ret < 0)
+		return ret;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		val = charge_type_values_x1[ret];
+		reg = OXP_X1_CHARGE_BYPASS_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = write_to_ec(reg, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t charge_type_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u8 reg;
+	long val;
+	const u8 *vals;
+	char *str;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		vals = charge_type_values_x1;
+		reg = OXP_X1_CHARGE_BYPASS_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = read_from_ec(reg, 1, &val);
+	if (ret < 0)
+		return ret;
+
+	str = (char *) charge_type_strings[0];
+	for (ret = 0; ret < ARRAY_SIZE(charge_type_strings); ret++) {
+		if (val == vals[ret]) {
+			str = (char *) charge_type_strings[ret];
+			break;
+		}
+	}
+
+	return sysfs_emit(buf, "%s\n", str);
+}
+
+static DEVICE_ATTR_RW(charge_type);
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	u64 val, reg;
+	int ret;
+
+	ret = kstrtou64(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		reg = OXP_X1_CHARGE_LIMIT_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = write_to_ec(reg, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u8 reg;
+	long val;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		reg = OXP_X1_CHARGE_LIMIT_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = read_from_ec(reg, 1, &val);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%ld\n", val);
+}
+
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+
+static int oxp_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	/* OneXPlayer devices only have one battery. */
+	if (strcmp(battery->desc->name, "BAT0") != 0 &&
+	    strcmp(battery->desc->name, "BAT1") != 0 &&
+	    strcmp(battery->desc->name, "BATC") != 0 &&
+	    strcmp(battery->desc->name, "BATT") != 0)
+		return -ENODEV;
+
+	if (device_create_file(&battery->dev,
+	    &dev_attr_charge_control_end_threshold))
+		return -ENODEV;
+
+	if (device_create_file(&battery->dev,
+	    &dev_attr_charge_type)) {
+		device_remove_file(&battery->dev,
+				&dev_attr_charge_control_end_threshold);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int oxp_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	device_remove_file(&battery->dev,
+			   &dev_attr_charge_control_end_threshold);
+	device_remove_file(&battery->dev,
+			   &dev_attr_charge_type);
+	return 0;
+}
+
+static struct acpi_battery_hook battery_hook = {
+	.add_battery = oxp_battery_add,
+	.remove_battery = oxp_battery_remove,
+	.name = "OneXPlayer Battery",
+};
+
 /* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
@@ -753,6 +954,9 @@ static int __init oxp_platform_init(void)
 		platform_create_bundle(&oxp_platform_driver,
 				       oxp_platform_probe, NULL, 0, NULL, 0);
 
+	if (charge_control_supported())
+		battery_hook_register(&battery_hook);
+
 	return PTR_ERR_OR_ZERO(oxp_platform_device);
 }
 
@@ -760,6 +964,8 @@ static void __exit oxp_platform_exit(void)
 {
 	platform_device_unregister(oxp_platform_device);
 	platform_driver_unregister(&oxp_platform_driver);
+	if (charge_control_supported())
+		battery_hook_unregister(&battery_hook);
 }
 
 MODULE_DEVICE_TABLE(dmi, dmi_table);
-- 
2.48.1


