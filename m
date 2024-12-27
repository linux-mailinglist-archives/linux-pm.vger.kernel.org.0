Return-Path: <linux-pm+bounces-19781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC499FD67F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEDD3A14EC
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A561F8EF5;
	Fri, 27 Dec 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVm9kqmc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CF1F8EE5;
	Fri, 27 Dec 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319747; cv=none; b=LuwOcMyv2zAuGVCeEiWmVTK/IMVc3/76ZTG5pS6iZf48tgyLFoALDlNEtnAd4ugu9qpuwUQ9NAjjApKqUfCnAhfFSuOSqXAvZ1K+FlwDJeug/sALDoHVOrHhB3hSciG1rQDp0Fh+1tXm6T4hBQCz8KtYzRd/ooswJirVz+QiaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319747; c=relaxed/simple;
	bh=YvZ1udbrnlOWcIdwccWk3kbVRXaPgho8vin+AH8oEOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJFs1TAhaIELVwSGEyzG7GwFCUB/evCPz2EtpdJXKERDMcU+MXmyAbdSN3I5PjN2z2bc8HDKdaR2gQMRU0LdRqsOgV8jPw2FzWHA5DevRhKMLKKc72XCgRyCfdhH/CmZRnzy334K79fAuQhLLKkabdGznjrTUvxutXvzlfXNiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVm9kqmc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so80310645ad.2;
        Fri, 27 Dec 2024 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319745; x=1735924545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIgahqD8dOxceMTBQ2yzR9/z6Uf8j6EmUz8qtqg4rF4=;
        b=CVm9kqmc2vzP4AX2GOlgqCC5s0Tqr7GH5kbEM7OHlWeUflGMmYKSuVO65gmtlsLIWZ
         EbPahCxvAuTfnx/BSZcInAk/t3B9M4vzbruhujri2ukzjEF85MTOfP4QgbaXvVRFMPn/
         4G8IGp4YJEUONNnKhncCSZBtK0aY9y+NU9LMMUOqUQ04mxWaRWsvBLYpMbaq87Vekzol
         I4+QvDgAb2p2fzxDpF9aVkJBHaGUL6i90lW4YXNeXBtT9eXXyiK343cH9t3nnDz97Img
         3HpkGyGGJH2zwWadq375LiklAiCu1oJg6XZVY9qNRJtMJTPX0ANi7RPrYb24XJWnOOrV
         5qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319745; x=1735924545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIgahqD8dOxceMTBQ2yzR9/z6Uf8j6EmUz8qtqg4rF4=;
        b=Kb3Rn1nE5kxVPcjJy6df+vfvY8qILgoAOqB9wDVv7nSfoe5ExUMK6aQLVS4Vg05B//
         4Zf6kQoUGxNyJodJCKoonWn6hQSOuLvOZy/U0YQy5Er9F0CYDBdtLgQEhjueyrn4X/3f
         LMEOA5ZX/O19FTvNzL0swIPYn/guaCt8OPMoFmWoNIVAV0gT4Zd9vbtzdN9N+tIN0Mfv
         BnHH1BMNMxiPaYqqWIph/AQlut8Z/o8GZHumJWCWIxZQIxXSCDkDtbvkyPIMpmCNomfA
         ruN2v2aPuASnJGr/VJG9c3LME7Ks3usBROatBm3duOnq0MXE2u8QyE1D8p3nOpt+5gRD
         7DDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCw1raHN2tp/YCQIVHJHTcLTF6DICR/Xhx+CnO/uaXnAR186/2K1o4WfyVj7x1k51BEr1/B/Nk9bHd@vger.kernel.org, AJvYcCUEK54kRrzYZPKhZvgr65nMFU09D/FW+L8lxgFNPgCYVT/EuSTWWI7KjLNH0Kc11rt6Bug3qoURxGsRgfYZc3aHSP5Nqw==@vger.kernel.org, AJvYcCUh6sIkih4qLUeQLI/BElFlGTbuXxLCBDKAtqW2KlNrPvGgVjbJGv0eTmZZpurWK7w79EwZtj7E9Ws=@vger.kernel.org, AJvYcCV0FoS2TH/zCq5Z/GXR3Y7qJcEyzaDJKPB+rmxAasIavlbjdn2qR/gyLvfVkRfjErYUAKXa09Qzt8aOv76L@vger.kernel.org, AJvYcCXwhcElniihQw7fPghl2K2BnHYCuo8h9xi7YfS2MXL5UmaiuSTMnOIrwZeBSLrY5ryyxL9LMFgU0SJK83Lg@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYANOema/zYmvDwJxkJSJaxSiMbBpN6Jb/avwmRAlGsL4U7qY
	gTdjzOTpeSftf4ykGJ/sHdYQBrWcPLiZSW8vQeRt1q5tuVQa1EbU
X-Gm-Gg: ASbGncvWLP975ur7FcNBDFu2kycvq5z4t2NsoEwy/lryd4gAmzd4JtDKGiczimOzcr4
	P2uh5lHTyzjg5dqi9wLtW8mczJjS3z32338uBmSKWfpuMpENEMEglZRtJeSApO+3LPpR1Wa1KBk
	XuB90l4BMXchAQ0hvgdfKApwgtvhXNunjanF05R8BoLyUz1BV2M4foOCFkoq8pzAgP0vsYf8x0I
	aEoWX56NMW/0J8v3dkIAzJ9qqym8ikPJENNF9N3Z54=
X-Google-Smtp-Source: AGHT+IEslKCQhnGVqgguMQn4QHUQQkjvu7L+U09f7U0flvlralBjCACdSBh87D6Vnr8VuJCk32SEHg==
X-Received: by 2002:a17:902:d502:b0:216:31c2:3db8 with SMTP id d9443c01a7336-219e70c01admr381981125ad.37.1735319744634;
        Fri, 27 Dec 2024 09:15:44 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:44 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 4/5] power: supply: add Huawei Matebook E Go (sc8280xp) psy driver
Date: Sat, 28 Dec 2024 01:13:52 +0800
Message-ID: <20241227171353.404432-5-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227171353.404432-1-mitltlatltl@gmail.com>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Huawei Matebook E Go (sc8280xp) tablet the EC provides access
to the adapter and battery status. Add the driver to read power supply
status on the tablet.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/power/supply/Kconfig                 |   9 +
 drivers/power/supply/Makefile                |   1 +
 drivers/power/supply/huawei-gaokun-battery.c | 446 +++++++++++++++++++
 3 files changed, 456 insertions(+)
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef678..e385d0a1f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -161,6 +161,15 @@ config BATTERY_DS2782
 	  Say Y here to enable support for the DS2782/DS2786 standalone battery
 	  gas-gauge.
 
+config BATTERY_HUAWEI_GAOKUN
+	tristate "Huawei Matebook E Go (sc8280xp) battery"
+	depends on EC_HUAWEI_GAOKUN
+	help
+	  This driver enables battery support on the Huawei Matebook E Go.
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
index 000000000..40141b59e
--- /dev/null
+++ b/drivers/power/supply/huawei-gaokun-battery.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * gaokun-battery - A power supply driver for HUAWEI Matebook E Go (sc8280xp)
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
+#include <linux/power_supply.h>
+#include <linux/sprintf.h>
+
+#include <linux/platform_data/huawei-gaokun-ec.h>
+
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
+#define CACHE_TIME		5000 /* cache time in milliseconds */
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
+	u8 online = 0;
+
+	ret = gaokun_ec_psy_read_byte(ecbat->ec, EC_ADP_STATUS, &online);
+	ecbat->online = !!(online & EC_AC_STATUS);
+
+	return ret;
+}
+
+static int gaokun_psy_get_adp_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+
+	if (gaokun_psy_get_adp_status(ecbat))
+		return -EIO;
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
+static inline void gaokun_psy_update_bat_charge(struct gaokun_psy *ecbat)
+{
+	u8 charge = 0;
+
+	gaokun_ec_psy_read_byte(ecbat->ec, EC_BAT_STATUS, &charge);
+
+	 charge = (charge == EC_BAT_CHARGING) * POWER_SUPPLY_STATUS_CHARGING
+		+ (charge == EC_BAT_DISCHARGING) * POWER_SUPPLY_STATUS_DISCHARGING
+		+ (charge == EC_BAT_FULL) * POWER_SUPPLY_STATUS_FULL;
+
+	ecbat->charge_now = charge;
+}
+
+static int gaokun_psy_get_bat_status(struct gaokun_psy *ecbat)
+{
+	/* _BST */
+	int ret;
+
+	if (time_before(jiffies, ecbat->update_time +
+		msecs_to_jiffies(CACHE_TIME)))
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
+static inline void gaokun_psy_init(struct gaokun_psy *ecbat)
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
+static int gaokun_psy_notify(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct gaokun_psy *ecbat = container_of(nb, struct gaokun_psy, nb);
+
+	switch (action) {
+	case EC_EVENT_BAT_A2:
+	case EC_EVENT_BAT_B1:
+		gaokun_psy_get_bat_info(ecbat);
+		break;
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
+		break;
+	}
+
+	return NOTIFY_OK;
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
+	ecbat->bat_psy = devm_power_supply_register(dev, &gaokun_psy_bat_desc,
+						    &psy_cfg);
+	if (IS_ERR(ecbat->bat_psy))
+		return dev_err_probe(dev, PTR_ERR(ecbat->bat_psy),
+				     "Failed to register battery power supply\n");
+
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


