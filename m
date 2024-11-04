Return-Path: <linux-pm+bounces-17010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789409BBED6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 21:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BE1C21F57
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98D1F5851;
	Mon,  4 Nov 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJf5rJYt"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2B1F5847
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752566; cv=none; b=YM0vu4mpLW51oZB5CuFb4w5rvJY7IUwgU/RjxpeLoHiS4jP/UCV+lEW6RrRkOWhD+ET9ptWJVkiA3WsRe0+/jeaPwDG575pcy5V4ZP5kJu5bunp/JH1VJfFVCKDXDlszIKLXAN75k/iDKFVMs+Eyv2782XzmZFSRsdkYtG+7cxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752566; c=relaxed/simple;
	bh=/0cPqiCpFuaNgNsl2UTf4KRjxyQT96G84MVwhoOAHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0oKiq7uNHm29n4TENbR2v3+KeaUv4gjRrTjVCcbmso0T0YkL1HhG/48XHUDfpkFMOnvhfdHrwrC7gGoHFbyWraDTNWvVOAQRodeA/qfvgR0vTNUJFY4dxU1otUSKaccCDQb5n7Hzm7svcakAW03RYeeSrARx0C51pbQPdrVfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJf5rJYt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730752563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xH0t4+nyF9Q5FXWl2SqVt5nxvgzaXqU0aJjMD6PecgM=;
	b=bJf5rJYtBymG1iwvgMY4iNqSZqf8N37+wC81cVoNQ3RUKXYJPmrTYSdDf8iP/gKI0ebYmT
	AnyqaBIaZO9Y7Tn+gzQECBHtFWirWiU6iQFeFADAm7JvH8IRz5OPN+IX2j+00TvwL3s2Bp
	Ke/RDVbn3Z7Hvg0gS/7rdC2hznTLxfs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-0EfoMvDrMIG_zFkINwoD3Q-1; Mon,
 04 Nov 2024 15:36:02 -0500
X-MC-Unique: 0EfoMvDrMIG_zFkINwoD3Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2DCC1956096;
	Mon,  4 Nov 2024 20:36:00 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 125731956046;
	Mon,  4 Nov 2024 20:35:58 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: x86-android-tablets: Add Vexia EDU ATLA 10 EC battery driver
Date: Mon,  4 Nov 2024 21:35:55 +0100
Message-ID: <20241104203555.61104-2-hdegoede@redhat.com>
In-Reply-To: <20241104203555.61104-1-hdegoede@redhat.com>
References: <20241104203555.61104-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The Vexia EDU ATLA 10 tablet has an embedded controller instead of
giving the os direct access to the charger + fuel-gauge ICs as is normal
on tablets designed for Android.

There is ACPI Battery device in the DSDT using the EC which should work
expect that it expects the I2C controller to be enumerated as an ACPI
device and the tablet's BIOS enumerates all LPSS devices as PCI devices
(and changing the LPSS BIOS settings from PCI -> ACPI does not work).

Add a power_supply class driver for the Atla 10 EC to expert battery info
to userspace. This is made part of the x86-android-tablets directory and
Kconfig option because the i2c_client it binds to is instantiated by
the x86-android-tablets kmod.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/Makefile |   1 +
 .../x86/x86-android-tablets/vexia_atla10_ec.c | 264 ++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c

diff --git a/drivers/platform/x86/x86-android-tablets/Makefile b/drivers/platform/x86/x86-android-tablets/Makefile
index 41ece5a37137..bc505ffcd2bf 100644
--- a/drivers/platform/x86/x86-android-tablets/Makefile
+++ b/drivers/platform/x86/x86-android-tablets/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_X86_ANDROID_TABLETS) += x86-android-tablets.o
+obj-$(CONFIG_X86_ANDROID_TABLETS) += vexia_atla10_ec.o
 
 x86-android-tablets-y := core.o dmi.o shared-psy-info.o \
 			 asus.o lenovo.o other.o
diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
new file mode 100644
index 000000000000..c5e6656d24fc
--- /dev/null
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * power_supply class (battery) driver for the I2C attached embedded controller
+ * found on Vexia EDU ATLA 10 (9V version) tablets.
+ *
+ * This is based on the ACPI Battery device in the DSDT which should work
+ * expect that it expects the I2C controller to be enumerated as an ACPI
+ * device and the tablet's BIOS enumerates all LPSS devices as PCI devices
+ * (and changing the LPSS BIOS settings from PCI -> ACPI does not work).
+ *
+ * Copyright (c) 2024 Hans de Goede <hansg@kernel.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <asm/byteorder.h>
+
+/* State field uses ACPI Battery spec status bits */
+#define ACPI_BATTERY_STATE_DISCHARGING		BIT(0)
+#define ACPI_BATTERY_STATE_CHARGING		BIT(1)
+
+#define ATLA10_EC_BATTERY_STATE_COMMAND		0x87
+#define ATLA10_EC_BATTERY_INFO_COMMAND		0x88
+
+/* From broken ACPI battery device in DSDT */
+#define ATLA10_EC_VOLTAGE_MIN_DESIGN		3750000
+
+struct atla10_ec_battery_state {
+	u8 len;				/* Struct length excluding the len field, always 12 */
+	u8 status;			/* Using ACPI Battery spec status bits */
+	u8 capacity;			/* Percent */
+	__le16 charge_now;		/* mAh */
+	__le16 voltage_now;		/* mV */
+	__le16 current_now;		/* mA */
+	__le16 charge_full;		/* mAh */
+	__le16 temp;			/* centi degrees celcius */
+} __packed;
+
+struct atla10_ec_battery_info {
+	u8 len;				/* Struct length excluding the len field, always 6 */
+	__le16 charge_full_design;	/* mAh */
+	__le16 voltage_now;		/* mV, should be design voltage, but is not ? */
+	__le16 charge_full_design2;	/* mAh */
+} __packed;
+
+struct atla10_ec_data {
+	struct i2c_client *client;
+	struct power_supply *psy;
+	struct delayed_work work;
+	struct mutex update_lock;
+	struct atla10_ec_battery_info info;
+	struct atla10_ec_battery_state state;
+	bool valid;			/* true if state is valid */
+	unsigned long last_update;	/* In jiffies */
+};
+
+static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(data->client, cmd, len, values);
+	if (ret != len) {
+		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
+		return -EIO;
+	}
+
+	if (values[0] != (len - 1)) {
+		dev_err(dev, "I2C command 0x%02x header length mismatch expected %u got %u\n",
+			cmd, len - 1, values[0]);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int atla10_ec_update(struct atla10_ec_data *data)
+{
+	int ret;
+
+	/* Cache data for 5 seconds */
+	if (data->valid && time_before(jiffies, data->last_update + 5 * HZ))
+		return 0;
+
+	ret = atla10_ec_cmd(data, ATLA10_EC_BATTERY_STATE_COMMAND,
+			    sizeof(data->state), (u8 *)&data->state);
+	if (ret)
+		return ret;
+
+	data->last_update = jiffies;
+	data->valid = true;
+	return 0;
+}
+
+static int atla10_ec_psy_get_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct atla10_ec_data *data = power_supply_get_drvdata(psy);
+	int charge_now, charge_full, ret;
+
+	guard(mutex)(&data->update_lock);
+
+	ret = atla10_ec_update(data);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->state.status & ACPI_BATTERY_STATE_DISCHARGING)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (data->state.status & ACPI_BATTERY_STATE_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->state.capacity == 100)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->state.capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		/*
+		 * The EC has a bug where it reports charge-full-design as
+		 * charge-now when the battery is full. Clamp charge-now to
+		 * charge-full to workaround this.
+		 */
+		charge_now = le16_to_cpu(data->state.charge_now);
+		charge_full = le16_to_cpu(data->state.charge_full);
+		val->intval = min(charge_now, charge_full) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = le16_to_cpu(data->state.voltage_now) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = le16_to_cpu(data->state.current_now) * 1000;
+		/*
+		 * Documentation/ABI/testing/sysfs-class-power specifies
+		 * negative current for discharing.
+		 */
+		if (data->state.status & ACPI_BATTERY_STATE_DISCHARGING)
+			val->intval = -val->intval;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		val->intval = le16_to_cpu(data->state.charge_full) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = le16_to_cpu(data->state.temp) / 10;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = le16_to_cpu(data->info.charge_full_design) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = ATLA10_EC_VOLTAGE_MIN_DESIGN;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LIPO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void atla10_ec_external_power_changed_work(struct work_struct *work)
+{
+	struct atla10_ec_data *data = container_of(work, struct atla10_ec_data, work.work);
+
+	dev_dbg(&data->client->dev, "External power changed\n");
+	data->valid = false;
+	power_supply_changed(data->psy);
+}
+
+static void atla10_ec_external_power_changed(struct power_supply *psy)
+{
+	struct atla10_ec_data *data = power_supply_get_drvdata(psy);
+
+	/* After charger plug in/out wait 0.5s for things to stabilize */
+	mod_delayed_work(system_wq, &data->work, HZ / 2);
+}
+
+static const enum power_supply_property atla10_ec_psy_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+};
+
+static const struct power_supply_desc atla10_ec_psy_desc = {
+	.name = "atla10_ec_battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = atla10_ec_psy_props,
+	.num_properties = ARRAY_SIZE(atla10_ec_psy_props),
+	.get_property = atla10_ec_psy_get_property,
+	.external_power_changed = atla10_ec_external_power_changed,
+};
+
+static int atla10_ec_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = { };
+	struct device *dev = &client->dev;
+	struct atla10_ec_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	psy_cfg.drv_data = data;
+	data->client = client;
+
+	ret = devm_mutex_init(dev, &data->update_lock);
+	if (ret)
+		return ret;
+
+	ret = devm_delayed_work_autocancel(dev, &data->work,
+					   atla10_ec_external_power_changed_work);
+	if (ret)
+		return ret;
+
+	ret = atla10_ec_cmd(data, ATLA10_EC_BATTERY_INFO_COMMAND,
+			    sizeof(data->info), (u8 *)&data->info);
+	if (ret)
+		return ret;
+
+	data->psy = devm_power_supply_register(dev, &atla10_ec_psy_desc, &psy_cfg);
+	return PTR_ERR_OR_ZERO(data->psy);
+}
+
+static const struct i2c_device_id atla10_ec_id_table[] = {
+	{ "vexia_atla10_ec" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, atla10_ec_id_table);
+
+static struct i2c_driver atla10_ec_driver = {
+	.driver = {
+		.name = "vexia_atla10_ec",
+	},
+	.probe = atla10_ec_probe,
+	.id_table = atla10_ec_id_table,
+};
+module_i2c_driver(atla10_ec_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Battery driver for Vexia EDU ATLA 10 tablet EC");
+MODULE_LICENSE("GPL");
-- 
2.47.0


