Return-Path: <linux-pm+bounces-20361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55696A0BF4D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D981888E07
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA51C3C15;
	Mon, 13 Jan 2025 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2mRq2AM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3531C3BEB;
	Mon, 13 Jan 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790797; cv=none; b=nThbW4Xifi70R05ExxEvU4LH4WpxgmVqVPIPkUEQ6b1qIu0Jp2SXii61vGYMYxQgsGCzv4yy9PDtM7th71je6N6cEHRQYlaAy9+RVWjBVTkPG9kmy78ELST4sUPMAvO6LY+fVER9eMuKe7pTEPnziCASXjVP2EftP5ZMPo7aMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790797; c=relaxed/simple;
	bh=Z7Yf3vG3X0HIEQyJxY0M/nYDyE1FxGHiiEEW2nSV3GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J18xutaS4QrYm7AwDx/V1KUbZJwemqPybtx0S+VJkj7CSb4Vyb+i2b9qNL/ZOGZXQBEOz9I6uFsTqMCPmgFMfllg5jFUXYxLl5vUKhOiPJQgWeKeXnn6MXp6KpfdGSH2X9aeaSDQSUuMV/nfpZmOFimEX7OYjlIGT55btXyHe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2mRq2AM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216634dd574so52686755ad.2;
        Mon, 13 Jan 2025 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736790795; x=1737395595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54Koe5a+gWOtdEKdOY4nnS3WXiujG9PlJIb3RE5ymgw=;
        b=l2mRq2AMNF6DrmAIZ4YNx1TTvi0A2QZomFsAb7xbs5RqyaDhKESAXYudhPbq3+3E+J
         drFxhjhNjFjkrmtv0Rsziiw2Xvb+Y/pAwa1pVwfGDBOZ1ImnoObHry3dq2lswCVnUmQW
         t89HCUJstGE6tJSZf5bk+G9GAtshag2aQfjFZSAuMBoI7Ga3RisBs7LHX0ny6tZBfopU
         zJAdvGQ+02f7uyJpUDxvVacNpWLZetsvv2opUhF6DvoeGE+MAXvrj3b+hPMcl/CgbNOW
         pBaXl2+23w7M/zlHLlVsxGZEBeVLHxWE4TUSSutwVK0Pb14bv/2oXd77p9vv+O3mvZIz
         LDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790795; x=1737395595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54Koe5a+gWOtdEKdOY4nnS3WXiujG9PlJIb3RE5ymgw=;
        b=cV4MaSQWVEzd8V2P7lv1RER4bo9IR/db1XFRjiHDN/JsmQ0JtfYFIO5htfhXW3VCVT
         dajaA+KV+YESw+yyvQv1Qhmd//8T7dhkYfjAVnuaHTO3A315LJxAYfhyQANx1dGOQThI
         J+jgKU2i0ipmyfbUrv4Q2/6ggYd7e6eWhmkZdWGq5+B9hJT9KIJLt8QlwdqqvJzku5j2
         TJDOUSXplmukoQIVeWYdYpgSSz9U1HkqapKdqZKIgM0gyn9Ux7enGU8Vzh5Nm3uLstfV
         JMNaVPb5A/bIe3hBC0mTZndzECK0WewwJs5IXoH8u7Tk5+bT4+lMfzQHomwgPueoAhMY
         +TMw==
X-Forwarded-Encrypted: i=1; AJvYcCVJj+LBOML5d4vnnT5/5uky8vTV28ARM1TU+0IKcCtjP84uV7XXWvzx7E6ZhN9nk897dj29+3AddXTvZLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEAKAbQsdlxFmwWwMcEo5DSdrX2uGJGewjnIygTHS9xKCm3Xr
	uBsAtNpXAMQe6uF/rtM+834f3J/A+4FbeYtfH/OtEPwGP761jdvI3GX63TfEXqWAcA==
X-Gm-Gg: ASbGncvcM4mYA7Vwk6vRQkrrl18au98KRxOA4TGIc6YrcF58Oj8y61QzUnO6bP8j30v
	18mUMmeDLZl8MtVBKMUat9trrllgIWOKjf9JXsDuwkJx1AIYTQPj2upKLBMDjpyIuJtxub47MnB
	ulEu1NBwQEiF953Oai8Ih7EIcyqbjrjkkzovE7MnWGNjPZNPzYtOOoc9HRY56T9JizSDAlI/06G
	qTDv8W1ZDcDYfTY11W8RrL4MHTzUZ9dvcPWsjCWw6SAW7pO3MKEFPk=
X-Google-Smtp-Source: AGHT+IFIndOtjr/JPFM39/+CTa/zFFxA6cNcxDFj8TMhC3Nfjs8wBdNYGJYiZs9UI0YPslA3gTdqGA==
X-Received: by 2002:a17:903:1c5:b0:216:431b:e577 with SMTP id d9443c01a7336-21a8400afc8mr282811075ad.51.1736790794503;
        Mon, 13 Jan 2025 09:53:14 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0c4sm55724905ad.24.2025.01.13.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:53:14 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Date: Tue, 14 Jan 2025 01:51:27 +0800
Message-ID: <20250113175131.590683-3-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113175131.590683-1-mitltlatltl@gmail.com>
References: <20250113175131.590683-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Huawei Matebook E Go tablet the EC provides access to the adapter
and battery status. Add the driver to read power supply status on the
tablet.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++++++++
 4 files changed, 606 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Documentation/ABI/testing/sysfs-class-power-gaokun
new file mode 100644
index 000000000..b1eb9e8d7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
@@ -0,0 +1,47 @@
+What:		/sys/class/power_supply/gaokun-ec-battery/smart_charge
+Date:		January 2025
+KernelVersion:	6.12
+Contact:	Pengyu Luo <mitltlatltl@gmail.com>
+Description:
+		This entry allows configuration of smart charging behavior with
+		four parameters. The format is: <mode> <delay> <start> <stop>.
+
+		- mode: Defines the charging mode (1 or 4). Mode 4 enables delay,
+			while mode 1 does not.
+		- delay: Specifies the delay in hours (non-negative). This is
+			only used when 'mode' is set to 4.
+		- start: The battery percentage at which charging starts (0-100).
+		- stop: The battery percentage at which charging stops (1-100).
+
+		 When the laptop is connected to a power adapter, it starts
+		 charging if the battery level is below the 'start' value. It
+		 continues charging until the battery reaches the 'stop' level.
+		 If the battery is already above the 'stop' level, charging is
+		 paused.
+
+		 When the power adapter is always connected, charging will
+		 begin if the battery level falls below 'start', and charging
+		 will stop once the battery reaches 'stop'.
+
+		 If mode is set to 4, the above charging mode will only occur
+		 after the specified delay in hours. If mode is 1, there is
+		 no delay.
+
+		Access: Read, Write
+
+		Valid values:
+			- mode: integer value (1 or 4)
+			- delay: integer value, delay in hours (non-negative)
+			- start: integer value, battery percentage (0-100)
+			- stop: integer value, battery percentage (1-100)
+
+What:		/sys/class/power_supply/gaokun-ec-battery/smart_charge_enable
+Date:		January 2025
+KernelVersion:	6.12
+Contact:	Pengyu Luo <mitltlatltl@gmail.com>
+Description:
+		This entry allows enabling smart charging.
+
+		Access: Read, Write
+
+		Valid values: 0 (disabled) or 1 (enabled)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 7b18358f1..556bda9ad 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -161,6 +161,16 @@ config BATTERY_DS2782
 	  Say Y here to enable support for the DS2782/DS2786 standalone battery
 	  gas-gauge.
 
+config BATTERY_HUAWEI_GAOKUN
+	tristate "Huawei Matebook E Go power supply"
+	depends on EC_HUAWEI_GAOKUN
+	help
+	  This driver enables battery and adapter support on the Huawei Matebook
+	  E Go, which is a sc8280xp-based 2-in-1 tablet.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called huawei-gaokun-battery.
+
 config BATTERY_LEGO_EV3
 	tristate "LEGO MINDSTORMS EV3 battery"
 	depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b55cc48a4..796570e7f 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
 obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
+obj-$(CONFIG_BATTERY_HUAWEI_GAOKUN)	+= huawei-gaokun-battery.o
 obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
 obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
diff --git a/drivers/power/supply/huawei-gaokun-battery.c b/drivers/power/supply/huawei-gaokun-battery.c
new file mode 100644
index 000000000..65b617aea
--- /dev/null
+++ b/drivers/power/supply/huawei-gaokun-battery.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * huawei-gaokun-battery - A power supply driver for HUAWEI Matebook E Go
+ *
+ * reference: drivers/power/supply/lenovo_yoga_c630_battery.c
+ *            drivers/platform/arm64/acer-aspire1-ec.c
+ *            drivers/acpi/battery.c
+ *            drivers/acpi/ac.c
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/huawei-gaokun-ec.h>
+#include <linux/power_supply.h>
+#include <linux/sprintf.h>
+
+/* -------------------------------------------------------------------------- */
+/* String Data Reg */
+
+#define EC_BAT_VENDOR		0x01 /* from 0x01 to 0x0F, SUNWODA */
+#define EC_BAT_MODEL		0x11 /* from 0x11 to 0x1F, HB30A8P9ECW-22T */
+
+#define EC_ADP_STATUS		0x81
+#define EC_AC_STATUS		BIT(0)
+#define EC_BAT_PRESENT		BIT(1) /* BATC._STA */
+
+#define EC_BAT_STATUS		0x82 /* _BST */
+#define EC_BAT_DISCHARGING	BIT(0)
+#define EC_BAT_CHARGING		BIT(1)
+#define EC_BAT_CRITICAL		BIT(2) /* Low Battery Level */
+#define EC_BAT_FULL		BIT(3)
+
+/* -------------------------------------------------------------------------- */
+/* Word Data Reg */
+
+/* 0x5A: ?
+ * 0x5C: ?
+ * 0x5E: ?
+ * 0X60: ?
+ * 0x84: ?
+ */
+
+#define EC_BAT_STATUS_START	0x90
+#define EC_BAT_PERCENTAGE	0x90
+#define EC_BAT_VOLTAGE		0x92
+#define EC_BAT_CAPACITY		0x94
+#define EC_BAT_FULL_CAPACITY	0x96
+/* 0x98: ? */
+#define EC_BAT_CURRENT		0x9A
+/* 0x9C: ? */
+
+#define EC_BAT_INFO_START	0xA0
+/* 0xA0: POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT? */
+#define EC_BAT_DESIGN_CAPACITY	0xA2
+#define EC_BAT_DESIGN_VOLTAGE	0xA4
+#define EC_BAT_SERIAL_NUMBER	0xA6
+#define EC_BAT_CYCLE_COUNT	0xAA
+
+/* -------------------------------------------------------------------------- */
+/* Battery Event ID */
+
+#define EC_EVENT_BAT_A0		0xA0
+#define EC_EVENT_BAT_A1		0xA1
+#define EC_EVENT_BAT_A2		0xA2
+#define EC_EVENT_BAT_A3		0xA3
+#define EC_EVENT_BAT_B1		0xB1
+/* EVENT B1 A0 A1 repeat about every 1s 2s 3s respectively */
+
+/* ACPI _BIX field, Min sampling time, the duration between two _BST */
+#define CACHE_TIME		3000 /* cache time in milliseconds */
+
+#define MILLI_TO_MICRO		1000
+
+struct gaokun_psy_bat_status {
+	__le16 percentage_now;	/* 0x90 */
+	__le16 voltage_now;
+	__le16 capacity_now;
+	__le16 full_capacity;
+	__le16 unknown1;
+	__le16 rate_now;
+	__le16 unknown2;	/* 0x9C */
+} __packed;
+
+struct gaokun_psy_bat_info {
+	__le16 unknown3;	/* 0xA0 */
+	__le16 design_capacity;
+	__le16 design_voltage;
+	__le16 serial_number;
+	__le16 padding2;
+	__le16 cycle_count;	/* 0xAA */
+} __packed;
+
+struct gaokun_psy {
+	struct gaokun_ec *ec;
+	struct device *dev;
+	struct notifier_block nb;
+
+	struct power_supply *bat_psy;
+	struct power_supply *adp_psy;
+
+	unsigned long update_time;
+	struct gaokun_psy_bat_status status;
+	struct gaokun_psy_bat_info info;
+
+	char battery_model[0x10]; /* HB30A8P9ECW-22T, the real one is XXX-22A */
+	char battery_serial[0x10];
+	char battery_vendor[0x10];
+
+	int charge_now;
+	int online;
+	int bat_present;
+};
+
+/* -------------------------------------------------------------------------- */
+/* Adapter */
+
+static int gaokun_psy_get_adp_status(struct gaokun_psy *ecbat)
+{
+	/* _PSR */
+	int ret;
+	u8 online;
+
+	ret = gaokun_ec_psy_read_byte(ecbat->ec, EC_ADP_STATUS, &online);
+	if (ret)
+		return ret;
+
+	ecbat->online = !!(online & EC_AC_STATUS);
+
+	return 0;
+}
+
+static int gaokun_psy_get_adp_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	int ret;
+
+	ret = gaokun_psy_get_adp_status(ecbat);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ecbat->online;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property gaokun_psy_adp_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc gaokun_psy_adp_desc = {
+	.name		= "gaokun-ec-adapter",
+	.type		= POWER_SUPPLY_TYPE_USB_TYPE_C,
+	.get_property	= gaokun_psy_get_adp_property,
+	.properties	= gaokun_psy_adp_props,
+	.num_properties	= ARRAY_SIZE(gaokun_psy_adp_props),
+};
+
+/* -------------------------------------------------------------------------- */
+/* Battery */
+
+static inline void gaokun_psy_get_bat_present(struct gaokun_psy *ecbat)
+{
+	int ret;
+	u8 present;
+
+	/* Some kind of initialization */
+	gaokun_ec_write(ecbat->ec, (u8 []){0x02, 0xB2, 1, 0x90});
+
+	ret = gaokun_ec_psy_read_byte(ecbat->ec, EC_ADP_STATUS, &present);
+
+	ecbat->bat_present = ret ? false : !!(present & EC_BAT_PRESENT);
+}
+
+static inline int gaokun_psy_bat_present(struct gaokun_psy *ecbat)
+{
+	return ecbat->bat_present;
+}
+
+static int gaokun_psy_get_bat_info(struct gaokun_psy *ecbat)
+{
+	/* _BIX */
+	if (!gaokun_psy_bat_present(ecbat))
+		return 0;
+
+	return gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_INFO_START,
+					sizeof(ecbat->info), (u8 *)&ecbat->info);
+}
+
+static void gaokun_psy_update_bat_charge(struct gaokun_psy *ecbat)
+{
+	u8 charge;
+
+	gaokun_ec_psy_read_byte(ecbat->ec, EC_BAT_STATUS, &charge);
+
+	switch (charge) {
+	case EC_BAT_CHARGING:
+		ecbat->charge_now = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case EC_BAT_DISCHARGING:
+		ecbat->charge_now = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case EC_BAT_FULL:
+		ecbat->charge_now = POWER_SUPPLY_STATUS_FULL;
+		break;
+	default:
+		dev_warn(ecbat->dev, "unknown charge state %d\n", charge);
+	}
+}
+
+static int gaokun_psy_get_bat_status(struct gaokun_psy *ecbat)
+{
+	/* _BST */
+	int ret;
+
+	if (time_before(jiffies, ecbat->update_time +
+			msecs_to_jiffies(CACHE_TIME)))
+		return 0;
+
+	gaokun_psy_update_bat_charge(ecbat);
+	ret = gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_STATUS_START,
+				       sizeof(ecbat->status), (u8 *)&ecbat->status);
+
+	ecbat->update_time = jiffies;
+
+	return ret;
+}
+
+static void gaokun_psy_init(struct gaokun_psy *ecbat)
+{
+	gaokun_psy_get_bat_present(ecbat);
+	if (!gaokun_psy_bat_present(ecbat))
+		return;
+
+	gaokun_psy_get_bat_info(ecbat);
+
+	snprintf(ecbat->battery_serial, sizeof(ecbat->battery_serial),
+		 "%d", le16_to_cpu(ecbat->info.serial_number));
+
+	gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_VENDOR,
+				 sizeof(ecbat->battery_vendor) - 1,
+				 ecbat->battery_vendor);
+
+	gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_MODEL,
+				 sizeof(ecbat->battery_model) - 1,
+				 ecbat->battery_model);
+
+	ecbat->battery_model[14] = 'A'; /* FIX UP */
+}
+
+static int gaokun_psy_get_bat_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+
+	if (gaokun_psy_bat_present(ecbat))
+		gaokun_psy_get_bat_status(ecbat);
+	else if (psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = ecbat->charge_now;
+		break;
+
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = ecbat->bat_present;
+		break;
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		val->intval = le16_to_cpu(ecbat->info.cycle_count);
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = le16_to_cpu(ecbat->info.design_voltage) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = le16_to_cpu(ecbat->status.voltage_now) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = (s16)le16_to_cpu(ecbat->status.rate_now) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = le16_to_cpu(ecbat->info.design_capacity) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		val->intval = le16_to_cpu(ecbat->status.full_capacity) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		val->intval = le16_to_cpu(ecbat->status.capacity_now) * MILLI_TO_MICRO;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = le16_to_cpu(ecbat->status.percentage_now);
+		break;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = ecbat->battery_model;
+		break;
+
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = ecbat->battery_vendor;
+		break;
+
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = ecbat->battery_serial;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property gaokun_psy_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc gaokun_psy_bat_desc = {
+	.name		= "gaokun-ec-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= gaokun_psy_get_bat_property,
+	.properties	= gaokun_psy_bat_props,
+	.num_properties	= ARRAY_SIZE(gaokun_psy_bat_props),
+};
+
+/* -------------------------------------------------------------------------- */
+/* Sysfs */
+
+/* Smart charge enable */
+static ssize_t smart_charge_enable_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	int ret;
+	bool on;
+
+	ret = gaokun_ec_psy_get_smart_charge_enable(ecbat->ec, &on);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", on);
+}
+
+static ssize_t smart_charge_enable_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t size)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	int ret;
+	bool on;
+
+	if (kstrtobool(buf, &on))
+		return -EINVAL;
+
+	ret = gaokun_ec_psy_set_smart_charge_enable(ecbat->ec, on);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(smart_charge_enable);
+
+/* Smart charge */
+static ssize_t smart_charge_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	int ret;
+
+	ret = gaokun_ec_psy_get_smart_charge(ecbat->ec, bf);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d %d %d %d\n",
+			  bf[0], bf[1], bf[2], bf[3]);
+}
+
+static ssize_t smart_charge_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	int ret;
+
+	if (sscanf(buf, "%hhd %hhd %hhd %hhd", bf, bf + 1, bf + 2, bf + 3) != 4)
+		return -EINVAL;
+
+	if (bf[0] != 1 && bf[0] != 4)
+		return -EINVAL;
+
+	ret = gaokun_ec_psy_set_smart_charge(ecbat->ec, bf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(smart_charge);
+
+static struct attribute *gaokun_psy_features_attrs[] = {
+	&dev_attr_smart_charge_enable.attr,
+	&dev_attr_smart_charge.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gaokun_psy_features);
+
+static int gaokun_psy_notify(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct gaokun_psy *ecbat = container_of(nb, struct gaokun_psy, nb);
+
+	switch (action) {
+	case EC_EVENT_BAT_A2:
+	case EC_EVENT_BAT_B1:
+		gaokun_psy_get_bat_info(ecbat);
+		return NOTIFY_OK;
+
+	case EC_EVENT_BAT_A0:
+		gaokun_psy_get_adp_status(ecbat);
+		power_supply_changed(ecbat->adp_psy);
+		msleep(10);
+		fallthrough;
+
+	case EC_EVENT_BAT_A1:
+	case EC_EVENT_BAT_A3:
+		if (action == EC_EVENT_BAT_A3) {
+			gaokun_psy_get_bat_info(ecbat);
+			msleep(100);
+		}
+		gaokun_psy_get_bat_status(ecbat);
+		power_supply_changed(ecbat->bat_psy);
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int gaokun_psy_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
+{
+	struct gaokun_ec *ec = adev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &adev->dev;
+	struct gaokun_psy *ecbat;
+
+	ecbat = devm_kzalloc(&adev->dev, sizeof(*ecbat), GFP_KERNEL);
+	if (!ecbat)
+		return -ENOMEM;
+
+	ecbat->ec = ec;
+	ecbat->dev = dev;
+	ecbat->nb.notifier_call = gaokun_psy_notify;
+
+	auxiliary_set_drvdata(adev, ecbat);
+
+	psy_cfg.drv_data = ecbat;
+	ecbat->adp_psy = devm_power_supply_register(dev, &gaokun_psy_adp_desc,
+						    &psy_cfg);
+	if (IS_ERR(ecbat->adp_psy))
+		return dev_err_probe(dev, PTR_ERR(ecbat->adp_psy),
+				     "Failed to register AC power supply\n");
+
+	psy_cfg.supplied_to = (char **)&gaokun_psy_bat_desc.name;
+	psy_cfg.num_supplicants = 1;
+	psy_cfg.no_wakeup_source = true;
+	psy_cfg.attr_grp = gaokun_psy_features_groups;
+	ecbat->bat_psy = devm_power_supply_register(dev, &gaokun_psy_bat_desc,
+						    &psy_cfg);
+	if (IS_ERR(ecbat->bat_psy))
+		return dev_err_probe(dev, PTR_ERR(ecbat->bat_psy),
+				     "Failed to register battery power supply\n");
+	gaokun_psy_init(ecbat);
+
+	return gaokun_ec_register_notify(ec, &ecbat->nb);
+}
+
+static void gaokun_psy_remove(struct auxiliary_device *adev)
+{
+	struct gaokun_psy *ecbat = auxiliary_get_drvdata(adev);
+
+	gaokun_ec_unregister_notify(ecbat->ec, &ecbat->nb);
+}
+
+static const struct auxiliary_device_id gaokun_psy_id_table[] = {
+	{ .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_PSY, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, gaokun_psy_id_table);
+
+static struct auxiliary_driver gaokun_psy_driver = {
+	.name = GAOKUN_DEV_PSY,
+	.id_table = gaokun_psy_id_table,
+	.probe = gaokun_psy_probe,
+	.remove = gaokun_psy_remove,
+};
+
+module_auxiliary_driver(gaokun_psy_driver);
+
+MODULE_DESCRIPTION("HUAWEI Matebook E Go psy driver");
+MODULE_LICENSE("GPL");
-- 
2.47.1


