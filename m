Return-Path: <linux-pm+bounces-23977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86572A5F105
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D777A4635
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB41F0E21;
	Thu, 13 Mar 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJHT8fJm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6F16BE17;
	Thu, 13 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862191; cv=none; b=bWoutUFN8CGz5HYnWo0rnxQi5jHNGpyF3CMNfnJG6huq98YKYdn02dwEpNN4q9lJnWH700d1UjlTSZrl3q9uJjbj2IrOrwjqz6/6pzpAkbzKvv5mKwnIMxdMYJOIC2Jif9IXfhdj22VTIcjswYm1CJfSTRxYPaU3d0wtQlWpGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862191; c=relaxed/simple;
	bh=aQnav6ibWOZzCJLfAo1CdfKRrRK/bVqER8k0eUU5j/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvdBNo4HtKjCuRT1l2A5k5v3Wm/eMrXZ8dYEtOO0+wKoy6nCwp5utCfiFoFcY2jXLoOfJC4tNgyTx1mLRb+EG6MkHZHhCtDfOhcAnGd25QX7GlfWe7KMlm+8D2ts9WakNdKK5nYBcJzEje4/+1TyB+3d0oedzLnj5Ar462pNNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJHT8fJm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224191d92e4so14457885ad.3;
        Thu, 13 Mar 2025 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862189; x=1742466989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvMbeuoHuk2bBLs1B8OQOKJHtHRXww4hjHQGEYqLlY0=;
        b=PJHT8fJmJRo1SapFCExj7WbmwtX/1Mb2tNQwcbYIY+Dd/MrjsEvIbBW5rlaWQahrxe
         0Px/oC+crojP/diYgmsjY2nqB4dS2GRGW9Ccu1498p/4V7B+p1jwWsrEz1mdX2boo3Ld
         +O43sFOveu2ROENMlPobymCEJBwSbDRsVSimk5DhygJ29McJ65VfIbmjoa+C+rocTk8X
         RsuV0dhYFxRkbdkEWjtTfxM+Mx+aKFbR5id64A1JP6CRFgqjUWopqfhiPzHmmUlfzt3W
         3h4NRGdMuIRj/dadYCymS9qzSv2wTbJg9HrnjiUxKcGbND6l2HgytVEAXQ0954tvn2Kq
         7R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862189; x=1742466989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvMbeuoHuk2bBLs1B8OQOKJHtHRXww4hjHQGEYqLlY0=;
        b=OMWEzc7zTRooziD5RtXGAQWkxeCeILwDmhjdOX4bHgHLNrVEU/JYNQoqIIG9SHSeK8
         7La6PljBuOZPseCWGlOaJJ+AXASpF4qmgLzkpMKlPlChUaxsAgDpbgoEfcvQQkIFyxRj
         1uhpM+8cvE962vxXu7GqT9Du6mUQFQWl+jZQMpqXJOnyfF2ZfGUU+0iCQZ3DJ62CFCke
         onpm6wObTKG5FiLqDGoI2AMFZku/dbvfBumhDsZsPxTtEqTIIFWHvhP0OFU1So29y6/5
         yy3qYzxCzyv2YW6Mel+MQYTXHtlpnBj8tuQb3iAzTMWX8O+rovEKzC/dSGa5OJ7jeGcs
         0dgw==
X-Forwarded-Encrypted: i=1; AJvYcCWpoW0pjeaSCle/2kmnWpPntWYM43RtMYrM96vH5B1lbHqxpzJA3mRFoz/j7UE6jxZlOlizvlmPPaOp8ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+C7vapInUdaGXYjcyIuoqmojk8GoO21BVUwWX3kHfoZCpgt1u
	aqXcIiRWITqBrFhhhOBYUuV9w/t4wMpjCCmKipLCYJ4jUxPW9krsva7NebdZUio=
X-Gm-Gg: ASbGncuoGwLsl/diApXIbLwC+00I723CBJe/JUvf6CfYjSfegkRLXlttlhdF5zPb/je
	/ZuM8kMwlpckwt5JpXqIxiPJ2xc8RIqgRBAyNphB0OrpblHy8kct5d/sE2v2TLesB4J+gvjwnST
	PYKRzOAcQDQHS4F5fpHL3o8bDcliQbVDAzT5YkQZxRwQN1lOzIb/U321P6vX14rJVDD22IV4Ou6
	9bjhr8Vy0A8pN5WJMhWxGM1G8/ddoXQRDt4oZX/7ft1nUlFYdxXHPLgh2abTlAJeM/2J9HUtENg
	ucQBEk8/uVM3S1RS4oy1sIEoItu0VlacPGxPIRT8qsM=
X-Google-Smtp-Source: AGHT+IFeA1Qy0mjmDezcfhWNhsina/ps374ocuSlOrnU5rnsL9ZdHMQJ92IktzAGa24Dm9Is6n3gjQ==
X-Received: by 2002:a05:6a00:2351:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-736aaa079e4mr32227845b3a.11.1741862188393;
        Thu, 13 Mar 2025 03:36:28 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167d88fsm1045199b3a.96.2025.03.13.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:36:27 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8] power: supply: add Huawei Matebook E Go psy driver
Date: Thu, 13 Mar 2025 18:34:35 +0800
Message-ID: <20250313103437.108772-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.48.1
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

This driver is inspired by the following drivers:
        drivers/power/supply/lenovo_yoga_c630_battery.c
        drivers/platform/arm64/acer-aspire1-ec.c
        drivers/acpi/battery.c
        drivers/acpi/ac.c

base-commit: 613af589b566093ce7388bf3202fca70d742c166

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v8:
- since the base driver was mergerd by Ilpo, continue the PSY driver
- use correct power_supply_desc.type (Sebastian)
- use .set_property() to set start/end threshold (Sebastian)
- rework smart_charge sysfs and rename to smart_charge_delay, expose delay only (Sebastian)
- rename property smart_charge_enable to battery_adaptive_charge
- rebased on tag next-20250313
- Link to v7: https://lore.kernel.org/linux-arm-msm/20250214180656.28599-1-mitltlatltl@gmail.com

Changes in v7:
- rebased on tag next-20250214
- fix Kconfig, this module depends on HWMON (kernel test robot)
- Link to v6: https://lore.kernel.org/linux-arm-msm/20250123152559.52449-1-mitltlatltl@gmail.com

Changes in v6 RESEND:
- add Reviewed-by tag (Ilpo)
- remove extra line
- rebased on tag next-20250131
- Link to v6: https://lore.kernel.org/linux-arm-msm/20250123152559.52449-1-mitltlatltl@gmail.com

Changes in v6:
- refactor one ternary operator expression (Ilpo)
- replace one expression with &= (Ilpo)
- use devm_mutex_init() instead of mutex_init() (Ilpo)
- add Reviewed-by tag for devicetree (Konrad)
- add explicit cast (void *) to fix warnings when compiling
- rebased on tag next-20250123
- Link to v5: https://lore.kernel.org/linux-arm-msm/20250117140348.180681-1-mitltlatltl@gmail.com

Changes in v5 RESEND:
- rebased on tag next-20250120
- Link to v5: https://lore.kernel.org/linux-arm-msm/20250117140348.180681-1-mitltlatltl@gmail.com

Changes in v5:
- handle return code of i2c_transfer() (Bryan)
- rename threshold validatition function (Bryan)
- add enumerates and defines for registers (Bryan)
- drop extra line in header (Heikki)
- add Reviewed-by tag for devicetree (Krzysztof)
- Link to v4: https://lore.kernel.org/linux-arm-msm/20250116111559.83641-1-mitltlatltl@gmail.com

Changes in v4:
- use new API to register hwmon device instead of the deprecated one. (Guenter)
- add Reviewed-by tag for dt-binding (Krzysztof)
- drop unnecessary header (Ilpo)
- use guard mutex (Ilpo)
- improve comments and naming (Ilpo)
- add a shallow copy version of extr_resp() (Ilpo)
- add functions to handle resp and req whose size is 1
- drop PSY and UCSI subdrivers, commit them once the base driver is upstreamed
- Link to v3: https://lore.kernel.org/linux-arm-msm/20250113175049.590511-1-mitltlatltl@gmail.com

Changes in v3:
- Link to v2: https://lore.kernel.org/linux-arm-msm/20250105174159.227831-1-mitltlatltl@gmail.com

dt-binding:
- drop generic compatibles. (Krzysztof)
- remove '+' to use literal block style. (Krzysztof)

ec:
- take struct gaokun_ucsi_reg as parameter (Heikki)
- add almost all kernel doc comments (Krzysztof, Heikki)

ucsi:
- drop unnecessary ucsi quirks (Dmitry)
- add UCSI v1.0 to ucsi.h (Heikki)
- use gaokun_ucsi_read_cci() to read cci directly (Heikki)
- drop unnecessary gaokun_ucsi_get_port_num (Heikki)
- rename member port_num => num_ports (Heikki)
- fix completion, forgot to signal threads in previous version

dt:
- fix indentation (Konrad)
- add a link between role switch and connector

Changes in v2:
- Link to v1: https://lore.kernel.org/linux-arm-msm/20241227171353.404432-1-mitltlatltl@gmail.com

global:
- drop qcom's products(i.e. sc8180x, sx8280xp) everywhere, use 'product'-based instead(Krzysztof, Bryan)
- drop Cc Nikita Travkin, we had discussed the device in PM.
- add myself to MAINTAINERS

dt-binding:
- fix building (Rob Herring (Arm))
- remove unnecessary code (Krzysztof)
- add bugzilla documentation, insights of gaokun(see [1] or patch[1/5]) (Krzysztof, Aiqun(Maria))
- explain the difference between PMIC GLink and gaokun EC (Aiqun(Maria))

ec:
- use Linux style comments (Krzysztof)
- add a comment for mutex lock (Krzysztof)
- add more kerneldoc for exported functions (Krzysztof)
- eliminate unnecessary conditions (Bryan)
- add a macro for check thresholds (Bryan)
- improve English (Bryan)
- use existing sysfs interface(hwmon, psy) whenever possible (Krzysztof)
- use __le16 and related endianess conversion function for temp data (Ilpo)
- drop alias for packet headers (Ilpo)
- avoid hardcoding i2c msgs size (Aiqun(Maria))
- add a comment for the sleep in critial region (Bryan, Aiqun(Maria))
- use macro to construct packet (Bryan, Aiqun(Maria))

wmi:
- dropped

ucsi:
- reorder headers (Bryan)
- a comment for the orientation map macro (Bryan)
- make mux mode map more explicit(minus six is very clear now) (Bryan, Dmitry)
- handle port update exceptions return (Bryan)
- a comment for the UCSI quirks (Dmitry)
- use the inline hint for the short register function (Dmitry)
- use the API with delay to handle register instead of a direct sleep (Bryan)
- handle unfinished initialization early

psy:
- add charging related sysfs to here (Krzysztof, Dmitry)
- document ABI for power_supply sysfs (Krzysztof)
- drop charging threshold, use smart charging instead

dts:
- correct indentation, properties' order. (Konrad)
---
 .../ABI/testing/sysfs-class-power-gaokun      |  27 +
 MAINTAINERS                                   |   1 +
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/huawei-gaokun-battery.c  | 645 ++++++++++++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Documentation/ABI/testing/sysfs-class-power-gaokun
new file mode 100644
index 000000000..0633aed7b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
@@ -0,0 +1,27 @@
+What:		/sys/class/power_supply/gaokun-ec-battery/smart_charge_delay
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Pengyu Luo <mitltlatltl@gmail.com>
+Description:
+		This entry allows configuration of smart charging delay.
+
+		Smart charging behavior: when the power adapter is connected
+		for delay hours, battery charging will follow the rules of
+		charge_control_start_threshold and charge_control_end_threshold.
+		For more information about charge control, please refer to
+		sysfs-class-power.
+
+		Access: Read, Write
+
+		Valid values: In hours (non-negative)
+
+What:		/sys/class/power_supply/gaokun-ec-battery/battery_adaptive_charge
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Pengyu Luo <mitltlatltl@gmail.com>
+Description:
+		This entry allows enabling battery adaptive charging.
+
+		Access: Read, Write
+
+		Valid values: 0 (disabled) or 1 (enabled)
diff --git a/MAINTAINERS b/MAINTAINERS
index b20efd24a..4ffb27cfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10884,6 +10884,7 @@ M:	Pengyu Luo <mitltlatltl@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
 F:	drivers/platform/arm64/huawei-gaokun-ec.c
+F:	drivers/power/supply/huawei-gaokun-battery.c
 F:	include/linux/platform_data/huawei-gaokun-ec.h
 
 HUGETLB SUBSYSTEM
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index aa569bada..7defd5f2c 100644
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
index eedb00e37..0807725ff 100644
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
index 000000000..9b6900d85
--- /dev/null
+++ b/drivers/power/supply/huawei-gaokun-battery.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * huawei-gaokun-battery - A power supply driver for HUAWEI Matebook E Go
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
+#define CACHE_TIME		2000 /* cache time in milliseconds */
+
+#define MILLI_TO_MICRO		1000
+
+#define SMART_CHARGE_MODE	0
+#define SMART_CHARGE_DELAY	1
+#define SMART_CHARGE_START	2
+#define SMART_CHARGE_END	3
+
+#define NO_DELAY_MODE	1
+#define DELAY_MODE	4
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
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = POWER_SUPPLY_USB_TYPE_C;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property gaokun_psy_adp_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static const struct power_supply_desc gaokun_psy_adp_desc = {
+	.name		= "gaokun-ec-adapter",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.usb_types	= BIT(POWER_SUPPLY_USB_TYPE_C),
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
+	u8 buf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	int ret;
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
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		ret = gaokun_ec_psy_get_smart_charge(ecbat->ec, buf);
+		if (ret)
+			return ret;
+
+		if (psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD)
+			val->intval = buf[SMART_CHARGE_START];
+		else
+			val->intval = buf[SMART_CHARGE_END];
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
+
+	return 0;
+}
+
+static int gaokun_psy_set_bat_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	u8 buf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	int ret;
+
+	if (!gaokun_psy_bat_present(ecbat))
+		return -ENODEV;
+
+	ret = gaokun_ec_psy_get_smart_charge(ecbat->ec, buf);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	/*
+	 * Resetting another thershold makes single thersold setting more likely
+	 * to succeed. But setting start = end makes thing strange(failure).
+	 */
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		buf[SMART_CHARGE_START] = val->intval;
+		if (buf[SMART_CHARGE_START] > buf[SMART_CHARGE_END])
+			buf[SMART_CHARGE_END] = buf[SMART_CHARGE_START] + 1;
+		return gaokun_ec_psy_set_smart_charge(ecbat->ec, buf);
+
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		buf[SMART_CHARGE_END] = val->intval;
+		if (buf[SMART_CHARGE_END] < buf[SMART_CHARGE_START])
+			buf[SMART_CHARGE_START] = buf[SMART_CHARGE_END] - 1;
+		return gaokun_ec_psy_set_smart_charge(ecbat->ec, buf);
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gaokun_psy_is_bat_property_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD ||
+	       psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD;
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
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc gaokun_psy_bat_desc = {
+	.name			= "gaokun-ec-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property		= gaokun_psy_get_bat_property,
+	.set_property		= gaokun_psy_set_bat_property,
+	.property_is_writeable	= gaokun_psy_is_bat_property_writeable,
+	.properties		= gaokun_psy_bat_props,
+	.num_properties		= ARRAY_SIZE(gaokun_psy_bat_props),
+};
+
+/* -------------------------------------------------------------------------- */
+/* Sysfs */
+
+/*
+ * Note that, HUAWEI calls them SBAC/GBAC and SBCM/GBCM in DSDT, they are likely
+ * Set/Get Battery Adaptive Charging and Set/Get Battery Charging Mode.
+ */
+
+/* battery adaptive charge */
+static ssize_t battery_adaptive_charge_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
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
+static ssize_t battery_adaptive_charge_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t size)
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
+static DEVICE_ATTR_RW(battery_adaptive_charge);
+
+static inline int get_charge_delay(u8 buf[GAOKUN_SMART_CHARGE_DATA_SIZE])
+{
+	return buf[SMART_CHARGE_MODE] == NO_DELAY_MODE ? 0 : buf[SMART_CHARGE_DELAY];
+}
+
+static inline void
+set_charge_delay(u8 buf[GAOKUN_SMART_CHARGE_DATA_SIZE], u8 delay)
+{
+	if (delay) {
+		buf[SMART_CHARGE_DELAY] = delay;
+		buf[SMART_CHARGE_MODE] = DELAY_MODE;
+	} else {
+		 /* No writing zero, there is a specific mode for it. */
+		buf[SMART_CHARGE_MODE] = NO_DELAY_MODE;
+	}
+}
+
+/* Smart charge */
+static ssize_t smart_charge_delay_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
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
+	return sysfs_emit(buf, "%d\n", get_charge_delay(bf));
+}
+
+static ssize_t smart_charge_delay_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
+	u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	u8 delay;
+	int ret;
+
+	if (kstrtou8(buf, 10, &delay))
+		return -EINVAL;
+
+	ret = gaokun_ec_psy_get_smart_charge(ecbat->ec, bf);
+	if (ret)
+		return ret;
+
+	set_charge_delay(bf, delay);
+
+	ret = gaokun_ec_psy_set_smart_charge(ecbat->ec, bf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(smart_charge_delay);
+
+static struct attribute *gaokun_psy_features_attrs[] = {
+	&dev_attr_battery_adaptive_charge.attr,
+	&dev_attr_smart_charge_delay.attr,
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
2.48.1


