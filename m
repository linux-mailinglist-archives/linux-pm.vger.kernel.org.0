Return-Path: <linux-pm+bounces-19971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A91A01B22
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F055162E69
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741C1C68A3;
	Sun,  5 Jan 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moz5IHtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84184194A74;
	Sun,  5 Jan 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099096; cv=none; b=XeHzI+tH90epCxr/gQ77MRqCqjjSnNYh8Mn0dLp1uHoLDQmbP4WUdSXpG9BCsXEzxQqefJriEiZHJpQobHKfKlHfms0K0PbBxIael+QHtg2xT9eYJgmZ690p604YRljhy1fs8DiPdXiotmOKpkVdL7h7MGWVYgaRFe6hldE2+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099096; c=relaxed/simple;
	bh=xVHeUc/C4u1daGbrWuogd81/0rcQNKbsMESLSlYwRl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrBOfIGZ3mtJ7H6HyY5uazaxi/7w17RQPy9vL/eyvCR2G3Hjb16p6Dt39MUH0/F7jPQkESx+AIPTA82x1xcavt3vp0u+S5UXTNijgSxclrpOpZMq68EppCO6seyD4JlTKYGV7KtF5Tg8x0+4oTpoGDgbbMrkTHNZax/wz3F50lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moz5IHtl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21649a7bcdcso187913385ad.1;
        Sun, 05 Jan 2025 09:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099094; x=1736703894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZLsaP+3GWbBerxQUrnDJSoxZwCUOex2k8o1U+GPlvY=;
        b=moz5IHtlkDYRhfwS6lUc9LzmsXgDHPR1gOxvBr3YB5row0Md0rsoOoPZvyiiVP36Xo
         6ohMi7/Duljy4iAF8RwTVgMdEXh+hJ+/gh3t8MrYWR1MsGnI3tx0Fp84v4p+rXUr/frZ
         mREvPa15j024IsM42C6QUzRZlZLnrQbf+fEGpPLLlMnkssHbRjCW9OLxBPvSvCxsm6/u
         /Dnx5Rez85/SxZHuOljK8QA7QptvDO7mEs9fRg5tzF5d5+X03HoQGfTgHo8TOedUtyud
         VlgRMgHjFOmTJ9ihpDuKbGkcd2YSac/YuEHlyFKAH34X+AlW/i2SQH2Nv5GsDX3Pe4CY
         HGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099094; x=1736703894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZLsaP+3GWbBerxQUrnDJSoxZwCUOex2k8o1U+GPlvY=;
        b=k5T8xvaN0GvPeZKEnmGBB+PrsXPAMQf3dHBHnEcwDVSneskV4YnIvnlSny8DrYtDZY
         TrzJ+GnajZBdCp0WE6T2vZRQed0Dm8MdiYg4PUOQzRkSeI/dGdj2A2a94rjB0XFqJ4JW
         Pge52BB4wNR9RIt9H3XsQWhAszZbVrhlLvxpxRjjJhTWBivYusiRCo2GD08haOfSzpRh
         1BqsESBIgu5hWwlg1kK9anfwX+irb79VZmQX+DSAZFDkeJ0bUD1K1+RvOBdfFwhrWy41
         wWKFUuy2Bc2OpLSPYpuQdb1636/aQDF/yuf8XT+oW4JZfqfjgud/KyPpU9fTG6U7DCdu
         7YBg==
X-Forwarded-Encrypted: i=1; AJvYcCV2/FJwuQEqR90HwAeMEG3FcXqgaxxdSEmKkeDRSwf9g7NTrPe6QWvZBNhikdJSS4/a+uLm+wRoq5smzSU=@vger.kernel.org, AJvYcCVWf/bJ5wECdYcncX+c3iRrry/LU3amYDAEuj9m+3x2Y7D6scUzzrNVRXszEpkaEuS+ncKp9ZLYsXGq@vger.kernel.org, AJvYcCWTKT9BppjgEl9A0hcG0uElEJm73w91piXs8xJVxZ5xarAQK7DysvLbm66B1SobyzIDlON1370DRhw=@vger.kernel.org, AJvYcCWXhqsAJgvpsZOiYks9DMXWTB1OzEsUShY/+Y3UNEnHKb97B197Azs/Qz7j3SaF8EuSU8+wJmz3shVM0a2wVIXWobvibA==@vger.kernel.org, AJvYcCWhDPFILInRcYXtjFNq3bHIZMLQrueGtglQNEDhbMOkaSeUwyEqF60DDjkSGC0LkubVfWBLJF2d2giW0oua@vger.kernel.org, AJvYcCXG7WMQHz4/BHIGOu1vYxNG5NJcONEKcs76bPlgVaYIlyzdX5ArB4pan9XBKNYos+wuvUmSYBECLy6mEXlq@vger.kernel.org
X-Gm-Message-State: AOJu0YybTc/vq7SeANI77MSUqzO8owyLIXFBofDb1T7C/kpy3LTzsRqi
	w2ciVNvZ2N9Fe5aSlyaWjFee9aAcf6lmlZHSohKVuU++i1x8DPLI
X-Gm-Gg: ASbGncs0H5Y8PxH+okYOwRikCzk3huzyAVVRn8n2CI9SxcnYZXlfp4rW8ge2vnNwCD1
	o0qbQ6+muYCjKlCr6z73euzobf3J70sZqUFppWpQKFLjQmzBXqXrfBiC9+kNBPtOzYPyYvEsKVx
	uzCpOGkcH2dqWIRQo96VR+cMqBUYvewhqtLjem4d4rh+pmPdTFIqwqv3IBPGR7fS1sNf9M2Ba96
	RuIYGusz47uJduUftSH3h8pdVsrld3cdZMrwn8lhd40H4ebJ+V0fdI=
X-Google-Smtp-Source: AGHT+IEIGhhwGKeXdLbTeAZmLA4GuhP9OQ+KHuIuhth4AjtsuC0yDQQ/THKrMFqO/AogEJjkKic9Fw==
X-Received: by 2002:a05:6a20:7f99:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e5e0470226mr81719777637.16.1736099093722;
        Sun, 05 Jan 2025 09:44:53 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5927fsm27375046a12.10.2025.01.05.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:44:52 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 4/5] power: supply: add Huawei Matebook E Go psy driver
Date: Mon,  6 Jan 2025 01:41:58 +0800
Message-ID: <20250105174159.227831-5-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105174159.227831-1-mitltlatltl@gmail.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
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
index 9f2eef678..f00983186 100644
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
index 59c4a9f40..c0941a832 100644
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


