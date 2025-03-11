Return-Path: <linux-pm+bounces-23870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72434A5CB49
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F11C3B86BC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E3926159A;
	Tue, 11 Mar 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BnOThUWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972B260A2A;
	Tue, 11 Mar 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712065; cv=none; b=rlCCYKovKq1gFcns9ONLklKjUJ8BsjMSmxwEAxsj+CQFUg7974avgUXDf7ngyJv940KvvqB0pcarU+5M5CP2Iid+3VjotNVWhZU/3+efVHa5IKGnuK4/3dz53X0yKT2pL2hTYGWqgw9yG2XLLsRVEj5u1+S0Ax+ojvoiTOlDITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712065; c=relaxed/simple;
	bh=ZK2HpsbmFShU2nGbLiIOCea32AqrBAJovHE8yN48dIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbYF7wgBmLxGLu7JiU+N3hGwCQwozHtKmJ3QlpvtBSa904fEW6GHg98pOeizrWbW8ZQUk+nwaGyFkk6c7sO3yLIagnCjM9ho8mCWZbtdFAKaUlZZcnPr9kqM2TpEEesmPLIH8T3dp2Y9pZJXJjWuYfLHab9AHaoXG2ai6q0Opgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BnOThUWP; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id B28622E09231;
	Tue, 11 Mar 2025 18:54:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741712061;
	bh=wc0qaUpzAbsHBiAfZpuSOeNyD+N9aLV5rkQuKVNRAcA=; h=From:To:Subject;
	b=BnOThUWP1SVHGPsAKSfEGVUuL0zPN4e4jYcseOW8UkmyeLUsmSm8XrtdNrUSPg9md
	 281GOAA26vplqtGNnqWniGS8axr2KJ0bOCfPYYDU1lFOUu5DlIFQ1vnElNxViDegh/
	 7cXNwmuwRB+jS5Y21jUlfN1CXke0sth9KNFVMnDM=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v4 06/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Date: Tue, 11 Mar 2025 17:53:58 +0100
Message-ID: <20250311165406.331046-7-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311165406.331046-1-lkml@antheas.dev>
References: <20250311165406.331046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174171206097.19543.13894957518655427827@linux1587.grserver.gr>
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
 drivers/platform/x86/Kconfig |   1 +
 drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 82cfc76bc5c9..f4d993658c01 100644
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
index dc3a0871809c..d73a10598d8f 100644
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
 
+/* Callbacks for charge behaviour attributes */
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
+	unsigned int available;
+	long val, s0, always;
+	int ret;
+	u8 reg;
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
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t charge_behaviour_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	long val, s0, always, sel;
+	unsigned int available;
+	int ret;
+	u8 reg;
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
+	if (ret)
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
+	if (ret)
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
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	long val;
+	int ret;
+	u8 reg;
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
+	if (ret)
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


