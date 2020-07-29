Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECC2319EF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgG2G7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 02:59:32 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:53476 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgG2G7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 02:59:32 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T6q24i019477;
        Wed, 29 Jul 2020 02:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=mWufaI70cGALBLPSJ/ZXV+fdCFfKztKiKT7sZJFua7o=;
 b=W601JMNrSXLZur1VRUEPklmlVEugKQ/xTmuRQMUiwKPpqIHRGvlPkfgQfH/RjlRcJIsz
 FH/GvOGJ7O+5zY25M/VzYmFrQWtc6Rtm9QrDdAqsB+NTny2oRFUI5nt/OsvQFI0yswRB
 5CwZG7RPNntjLAtqMjVCyz5r5vAX7HWgNjFq2/Pwk1pn8LNqvDegrBcqQdoh9hga1TXh
 DC+OKSexHikmesdCyk9JK3SlYxAMIfRFjk/kQkbwAyAQKwVE4k3PIQj0EheW8J5aD1eX
 LAWpi0XwP/nbyRkkURifeWXU2QHIbMJsYcVMYZslO4GYF4wSbP5/anhhaXK4jYN8LNsU Sg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 32jun0sdc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 02:59:31 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T6umvp195214;
        Wed, 29 Jul 2020 02:59:31 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 32k45x0404-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 02:59:30 -0400
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="525546279"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     sre@kernel.org, mjg59@srcf.ucam.org, pali@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        mario.limonciello@dell.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        perry_yuan <Perry.Yuan@dell.com>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Subject: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds and charging mode switch.
Date:   Tue, 28 Jul 2020 23:54:24 -0700
Message-Id: <20200729065424.12851-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_03:2020-07-28,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290045
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290044
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: perry_yuan <perry_yuan@dell.com>

The patch control battery charging thresholds when system is under custom
charging mode through smbios API and driver`s sys attributes.It also set the
percentage bounds for custom charge.
Start value must lie in the range [50, 95],End value must lie in the range
[55, 100],END must be at least (START + 5).

The patch also add the battery charging modes switch support.User can switch
the battery charging mode through the new sysfs entry.

Primary battery charging modes valid choices are:
['primarily_ac', 'adaptive', 'custom', 'standard', 'express']

Signed-off-by: Perry Yuan <perry_yuan@dell.com>
Signed-off-by: Limonciello Mario <Mario_Limonciello@Dell.com>
---
 Documentation/ABI/testing/sysfs-class-power |  23 ++
 drivers/platform/x86/dell-laptop.c          | 344 ++++++++++++++++++++
 drivers/platform/x86/dell-smbios.h          |  26 ++
 3 files changed, 393 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index bf3b48f022dc..a8adc3b0ca4b 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -334,6 +334,29 @@ Description:
 		Access: Read
 		Valid values: Represented in microvolts
 
+What:		/sys/class/power_supply/<supply_name>/charge_control_charging_mode
+Date:		March 2020
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the type of charging modes currently being applied to the
+		battery."Express", "Primarily_ac", "Adaptive", "Custom" and
+		"Standard" all mean different charging speeds.
+
+		1: "Adaptive" means that the charger uses some
+		algorithm to adjust the charge rate dynamically, without
+		any user configuration required.
+		2: "Custom" means that the charger uses the charge_control_*
+		properties to start and stop charging
+		based on user input.
+		3: "Express" means the charger use fast charging technology
+		4: "Primarily_ac" means that users who primarily operate the system
+		while plugged into an external power source.
+		5: "Standard" fully charges the battery at a moderate rate.
+
+		Access: Read, Write
+		Valid values: "Express", "Primarily_ac", "Standard",
+			      "Adaptive", "Custom"
+
 ===== USB Properties =====
 
 What: 		/sys/class/power_supply/<supply_name>/current_avg
diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 74e988f839e8..8e45ce92a2d9 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -28,6 +28,8 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <acpi/video.h>
+#include <acpi/battery.h>
+#include <linux/string.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
 
@@ -90,6 +92,14 @@ static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *wwan_rfkill;
 static bool force_rfkill;
+static enum battery_charging_mode bat_chg_current = BAT_NONE_MODE;
+static const char * const battery_state[BAT_MAX_MODE] = {
+	[BAT_PRIMARILY_AC_MODE] = "primarily_ac",
+	[BAT_ADAPTIVE_MODE] = "adaptive",
+	[BAT_CUSTOM_MODE] = "custom",
+	[BAT_STANDARD_MODE] = "standard",
+	[BAT_EXPRESS_MODE] = "express",
+};
 
 module_param(force_rfkill, bool, 0444);
 MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
@@ -2161,6 +2171,338 @@ static struct led_classdev micmute_led_cdev = {
 	.default_trigger = "audio-micmute",
 };
 
+static int dell_battery_get(int *start, int *end)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+	int ret;
+
+	if (start) {
+		token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_START);
+		if (!token)
+			return -ENODEV;
+		dell_fill_request(&buffer, token->location, 0, 0, 0);
+		ret = dell_send_request(&buffer,
+					CLASS_TOKEN_READ, SELECT_TOKEN_STD);
+		*start = buffer.output[1];
+	}
+
+	if (end) {
+		token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_END);
+		if (!token)
+			return -ENODEV;
+		dell_fill_request(&buffer, token->location, 0, 0, 0);
+		ret = dell_send_request(&buffer,
+					CLASS_TOKEN_READ, SELECT_TOKEN_STD);
+		if (ret)
+			return -EIO;
+		*end = buffer.output[1];
+	}
+
+	return 0;
+}
+
+static int dell_battery_set(int start, int end)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+	int ret;
+
+	if (start < CHARGE_START_MIN || end < CHARGE_START_MAX ||
+		start > CHARGE_END_MIN || end > CHARGE_END_MAX)
+		return -EINVAL;
+
+	token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_START);
+	if (!token)
+		return -ENODEV;
+
+	dell_fill_request(&buffer, token->location, start, 0, 0);
+	ret = dell_send_request(&buffer,
+				CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
+	if (ret)
+		return -EIO;
+
+	token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_END);
+	if (!token)
+		return -ENODEV;
+
+	dell_fill_request(&buffer, token->location, end, 0, 0);
+	ret = dell_send_request(&buffer,
+				CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
+	if (ret)
+		return -EIO;
+
+	return ret;
+}
+
+static int battery_charging_mode_set(enum battery_charging_mode mode)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+	int ret;
+
+	if (mode <= BAT_NONE_MODE || mode >= BAT_MAX_MODE)
+		return -EINVAL;
+
+	switch (mode) {
+	case BAT_STANDARD_MODE:
+		token = dell_smbios_find_token(BAT_STANDARD_MODE_TOKEN);
+		if (!token)
+			return -ENODEV;
+		break;
+	case BAT_EXPRESS_MODE:
+		token = dell_smbios_find_token(BAT_EXPRESS_MODE_TOKEN);
+		if (!token)
+			return -ENODEV;
+		break;
+	case BAT_PRIMARILY_AC_MODE:
+		token = dell_smbios_find_token(BAT_PRIMARILY_AC_MODE_TOKEN);
+		if (!token)
+			return -ENODEV;
+		break;
+	case BAT_CUSTOM_MODE:
+		token = dell_smbios_find_token(BAT_CUSTOM_MODE_TOKEN);
+		if (!token)
+			return -ENODEV;
+		break;
+	case BAT_ADAPTIVE_MODE:
+		token = dell_smbios_find_token(BAT_ADAPTIVE_MODE_TOKEN);
+		if (!token)
+			return -ENODEV;
+		break;
+	default:
+		pr_warn("unspported charging mode!\n");
+		return -EINVAL;
+	}
+
+	dell_fill_request(&buffer, token->location, mode, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
+	if (ret)
+		return -EIO;
+
+	return ret;
+}
+
+static int battery_charging_mode_get(enum battery_charging_mode *mode)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+	int ret;
+
+	token = dell_smbios_find_token(BAT_CUSTOM_MODE_TOKEN);
+	if (!token)
+		return -ENODEV;
+	dell_fill_request(&buffer, token->location, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
+	if (ret)
+		return -EIO;
+	if (ret == 0)
+		*mode = buffer.output[1];
+
+	return ret;
+}
+
+static ssize_t charge_control_charging_mode_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	enum battery_charging_mode mode;
+	char *s = buf;
+
+	for (mode = BAT_STANDARD_MODE; mode < BAT_MAX_MODE; mode++) {
+		if (battery_state[mode]) {
+			if (mode == bat_chg_current)
+				s += sprintf(s, "[%s] ", battery_state[mode]);
+			else
+				s += sprintf(s, "%s ", battery_state[mode]);
+		}
+	}
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s-1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t charge_control_charging_mode_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err;
+	enum battery_charging_mode mode;
+	char *p;
+	int len;
+	const char *label;
+
+	p = memchr(buf, '\n', size);
+	len = p ? p - buf : size;
+
+	for (mode = BAT_STANDARD_MODE; mode < BAT_MAX_MODE; mode++) {
+		label = battery_state[mode];
+		if (label && len == strlen(label) &&
+			!strncmp(buf, label, len)) {
+			bat_chg_current = mode;
+			break;
+		}
+	}
+	if (mode > BAT_NONE_MODE && mode < BAT_MAX_MODE)
+		err = battery_charging_mode_set(mode);
+	else
+		err = -EINVAL;
+
+	return err ? err : size;
+}
+
+static ssize_t charge_control_start_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, start;
+
+	err = dell_battery_get(&start, NULL);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", start);
+}
+
+static ssize_t charge_control_start_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	err = dell_battery_get(NULL, &end);
+	if (err)
+		return err;
+	err = kstrtoint(buf, 10, &start);
+	if (err)
+		return err;
+	err = dell_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, end;
+
+	err = dell_battery_get(NULL, &end);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", end);
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	err = dell_battery_get(&start, NULL);
+	if (err)
+		return err;
+	err = kstrtouint(buf, 10, &end);
+	if (err)
+		return err;
+	err = dell_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_control_thresholds_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, start, end;
+
+	err = dell_battery_get(&start, &end);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d %d\n", start, end);
+}
+
+static ssize_t charge_control_thresholds_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	if (sscanf(buf, "%d %d", &start, &end) != 2)
+		return -EINVAL;
+
+	err = dell_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+static DEVICE_ATTR_RW(charge_control_thresholds);
+static DEVICE_ATTR_RW(charge_control_charging_mode);
+
+static int dell_battery_add(struct power_supply *battery)
+{
+	device_create_file(&battery->dev,
+		&dev_attr_charge_control_start_threshold);
+	device_create_file(&battery->dev,
+		&dev_attr_charge_control_end_threshold);
+	device_create_file(&battery->dev,
+		&dev_attr_charge_control_charging_mode);
+
+	return 0;
+}
+
+static int dell_battery_remove(struct power_supply *battery)
+{
+	device_remove_file(&battery->dev,
+		&dev_attr_charge_control_start_threshold);
+	device_remove_file(&battery->dev,
+		&dev_attr_charge_control_end_threshold);
+	device_remove_file(&battery->dev,
+		&dev_attr_charge_control_charging_mode);
+
+	return 0;
+}
+
+static struct acpi_battery_hook dell_battery_hook = {
+	.add_battery = dell_battery_add,
+	.remove_battery = dell_battery_remove,
+	.name = "Dell Battery Extension"
+};
+
+static void dell_battery_setup(struct device *dev)
+{
+	enum battery_charging_mode current_mode = BAT_NONE_MODE;
+
+	battery_charging_mode_get(&current_mode);
+	if (current_mode) {
+		bat_chg_current = current_mode;
+		pr_debug("battery is present\n");
+	} else {
+		pr_debug("battery is not present\n");
+	}
+	battery_hook_register(&dell_battery_hook);
+	device_create_file(dev, &dev_attr_charge_control_thresholds);
+}
+
+static void dell_battery_exit(struct device *dev)
+{
+	if (bat_chg_current != BAT_NONE_MODE) {
+		battery_hook_unregister(&dell_battery_hook);
+		device_remove_file(dev, &dev_attr_charge_control_thresholds);
+	}
+}
+
 static int __init dell_init(void)
 {
 	struct calling_interface_token *token;
@@ -2197,6 +2539,7 @@ static int __init dell_init(void)
 		touchpad_led_init(&platform_device->dev);
 
 	kbd_led_init(&platform_device->dev);
+	dell_battery_setup(&platform_device->dev);
 
 	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
 	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
@@ -2281,6 +2624,7 @@ static void __exit dell_exit(void)
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
+	dell_battery_exit(&platform_device->dev);
 }
 
 /* dell-rbtn.c driver export functions which will not work correctly (and could
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index a7ff9803f41a..36e6b06a0f47 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -35,6 +35,32 @@
 #define GLOBAL_MIC_MUTE_ENABLE	0x0364
 #define GLOBAL_MIC_MUTE_DISABLE	0x0365
 
+/*Battery Charging Modes Tokens*/
+#define BAT_CUSTOM_MODE_TOKEN		0x343
+#define BAT_PRIMARILY_AC_MODE_TOKEN	0x0341
+#define BAT_ADAPTIVE_MODE_TOKEN		0x0342
+#define BAT_STANDARD_MODE_TOKEN		0x0346
+#define BAT_EXPRESS_MODE_TOKEN		0x0347
+#define BATTERY_CUSTOM_CHARGE_START	0x0349
+#define BATTERY_CUSTOM_CHARGE_END	0x034A
+
+/* percentage bounds for custom charge */
+#define CHARGE_START_MIN	50
+#define CHARGE_START_MAX	95
+#define CHARGE_END_MIN		55
+#define CHARGE_END_MAX		100
+
+/*Battery Charging Modes */
+enum battery_charging_mode {
+	BAT_NONE_MODE = 0,
+	BAT_STANDARD_MODE,
+	BAT_EXPRESS_MODE,
+	BAT_PRIMARILY_AC_MODE,
+	BAT_ADAPTIVE_MODE,
+	BAT_CUSTOM_MODE,
+	BAT_MAX_MODE,
+};
+
 struct notifier_block;
 
 struct calling_interface_token {
-- 
2.27.0

