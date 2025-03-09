Return-Path: <linux-pm+bounces-23694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC9A583A8
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9193016DDC4
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE31CEAC2;
	Sun,  9 Mar 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="iJk8E7z4"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99171CAA98;
	Sun,  9 Mar 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519294; cv=none; b=AEk5WiMinV4nymOFXsxgpKFKJO2oDUKfQGicwKvflQrIJ8dhSBOcpOo3ATrcxheyk/idICIybUOeuQJqi5gyrWNq9xRvNaHE2dUg2qzVMO/VDvICPyOGPEUEillB/gOd92X8X0Gw3XuXR5vawm+z0I5cEaLWwkLgaJllCquhACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519294; c=relaxed/simple;
	bh=Ug79/OXwOQHrm9aZTD36Yod53SGh0yWBMgUvopRFg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIzr6h4O2nrmjfLU+ojVGsDJbTn1hc7YxymvJcMEdWJSfeSv5Lq/pfDXkeBUKK+3fevfLmHD3Ro3ZudqQKl5MB4CChUzJtQpyZsM+Rgdji/SDgK4n3V0L0tlqCtLD7VywELU/YNB7HTOmBUPi9C8mhTthu0PDTZTztqqmxXkf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=iJk8E7z4; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9B5BE2E07CCC;
	Sun,  9 Mar 2025 13:21:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519290;
	bh=PlY6B1S6QWUFUUcrzvGOL8SXVEcUvd/BxLCk3RZCf4U=; h=From:To:Subject;
	b=iJk8E7z4XIe5T48yYbi6CqAQKANMf+e/RwbHjnHF6f+027XvKcazoQ0g6jHUPe3DX
	 tikFg75xTJoV6P0tl7txKALp30tFcJpmHTwK7+/lrkmzIiAb1QmBr9UvYG0meRh0bf
	 PJbw+fqrFQUfzstdi4LbB3dkO5lWTTiddmT4mjHM=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 06/12] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Date: Sun,  9 Mar 2025 12:21:07 +0100
Message-ID: <20250309112114.1177361-7-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151928989.28954.558980766949484739@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
their devices. Charge limit allows for choosing an arbitrary battery
charge setpoint in percentages. Charge bypass allows to instruct the
device to stop charging either when it is in s0 or always.

This feature was then extended for the F1Pro as well. OneXPlayer also
released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
add support for this feature. Therefore, enable it for all F1 and
X1 devices.

Add both of these under the standard sysfs battery endpoints for them,
by looking for the battery. OneXPlayer devices have a single battery.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index dc3a0871809c..dd6d333ebcfa 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/processor.h>
+#include <acpi/battery.h>
 
 /* Handle ACPI lock mechanism */
 static u32 oxp_mutex;
@@ -87,6 +88,24 @@ static enum oxp_board board;
 
 #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
 
+/* Battery bypass settings */
+#define EC_CHARGE_CONTROL_BEHAVIOURS_X1	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0))
+
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
+#define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 | \
+	OXP_X1_CHARGE_BYPASS_MASK_S3S5)
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -434,6 +453,194 @@ static ssize_t tt_toggle_show(struct device *dev,
 
 static DEVICE_ATTR_RW(tt_toggle);
 
+/* Callbacks for turbo toggle attribute */
+static bool charge_behaviour_supported(void)
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
+static ssize_t charge_behaviour_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	int ret;
+	u8 reg;
+	long val, s0, always;
+	unsigned int available;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
+		always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
+		reg = OXP_X1_CHARGE_BYPASS_REG;
+		available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = power_supply_charge_behaviour_parse(available, buf);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+		val = 0;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0:
+		val = s0;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		val = always;
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
+static ssize_t charge_behaviour_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u8 reg;
+	long val, s0, always, sel;
+	unsigned int available;
+
+	switch (board) {
+	case oxp_x1:
+	case oxp_fly:
+		s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
+		always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
+		reg = OXP_X1_CHARGE_BYPASS_REG;
+		available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = read_from_ec(reg, 1, &val);
+	if (ret < 0)
+		return ret;
+
+	if ((val & always) == always)
+		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+	else if ((val & s0) == s0)
+		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0;
+	else
+		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+
+	return power_supply_charge_behaviour_show(dev, available, sel, buf);
+}
+
+static DEVICE_ATTR_RW(charge_behaviour);
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
+	    &dev_attr_charge_behaviour)) {
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
+			   &dev_attr_charge_behaviour);
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
@@ -716,15 +923,25 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
+	if (charge_behaviour_supported())
+		battery_hook_register(&battery_hook);
+
 	return PTR_ERR_OR_ZERO(hwdev);
 }
 
+static void oxp_platform_remove(struct platform_device *device)
+{
+	if (charge_behaviour_supported())
+		battery_hook_unregister(&battery_hook);
+}
+
 static struct platform_driver oxp_platform_driver = {
 	.driver = {
 		.name = "oxp-platform",
 		.dev_groups = oxp_ec_groups,
 	},
 	.probe = oxp_platform_probe,
+	.remove = oxp_platform_remove,
 };
 
 static struct platform_device *oxp_platform_device;
-- 
2.48.1


