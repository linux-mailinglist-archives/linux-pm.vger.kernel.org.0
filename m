Return-Path: <linux-pm+bounces-22983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F61A45A3D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3CD7A3785
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51E23816D;
	Wed, 26 Feb 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmW3xftG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB3226D15;
	Wed, 26 Feb 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562657; cv=none; b=CTA5EhCO747niDxB5bJQrGult/tnhchjm5jXA8Qoy6PwvdlokDLDYcr9LVPf7YcEQdPNV2UdzE57t3xvJZZzR2JaEc5gg86uhDW6udoLMPf1cSD+rh5W7HPTOytlsEQ5hM75Vklw3CuDagoWBl3yCcfH0wtvCcjm/yrwxICa32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562657; c=relaxed/simple;
	bh=0bTZFLiv/+Mp2jWwLp0bLYPj+hkH9t9mTj5lYqthOrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plI1rRJGldjU++fTWcbcLVez6pOq+HMlhS6kZHFUyFHsHDc0ToeCJ+pKitZH2hNJLNamPDa93hbYZ/duzdZcMQUIO1HrefPys4WmY2769ReZ19xuv9Z6zCMPiLFZcrCiQGCF6YBhJek2jCnRUBhLSL8bAS4BSC1Y97Xr7rcpuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmW3xftG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abec8b750ebso371557666b.0;
        Wed, 26 Feb 2025 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740562653; x=1741167453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZZawr0EOZz5neVOoTTbf+i1LcZuE+r8bQ2tYc4+r6w=;
        b=XmW3xftGY0P3u8JYkoUcwJ99+ALUxGN9288MVSjHgpbo0Ro3vFFXfAjSKzzQRyc5ht
         Clu6eZIhTyYdFJHDXK747y9Q/yjTY/A9xiAXdZaPEpyyvYzbj9blMBaGjykZ8tumh3Ml
         HolpwuNp9pzyj1VLal7Lp9UJh0Og45JYEftMbflzda0/JzS1mR1WmCgEBgSJJa6N6SkB
         awDi7jzllDXyyJKHYnBPxl4zRfnh9zD8EjtZP6RGiqQRqhTR2KVoVmVcnPwZE3A5UbQk
         0bqN+IEA0lHkflYVBdzttTTVgHSVQhbDaQjRyfQllaHk6ccpt+ZyHfN1fxI4rtAz7xI7
         BeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562653; x=1741167453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZZawr0EOZz5neVOoTTbf+i1LcZuE+r8bQ2tYc4+r6w=;
        b=OYY12QiPwIE3oD/IaJVpLIH7qdAtKOiDXdfip3PrgbWvdcJsXYldJ0gi9fb66SMTvK
         9cyI4OPZIFjI1R4qz6pK4B9R+VQ0bukMJJSADGhVBV5s5JxOVCwBZuOtNFZZezb5Oedr
         GMIyTMUH7vWQAVUlORIWjg8rroIZB8HrEhlnhy5Evnn6jBouuKLiPB5B+d4v8ci+PtK8
         RirEIDcrWt0BwpoH4kD9IkjEhVblM1k0LFhyDR9zm2PdBFIj2Wl4OK68HJ7K2BERKUOi
         DxwycwFK/mlgCjq/zJZBVGoACy3OLb8FV0S6FZwLyE3Z8zvPvTa8k5/XNW4YLOIwEKL4
         jhuw==
X-Forwarded-Encrypted: i=1; AJvYcCVLjGpPP26647RtvAlkGBIUEcYaHVt74Knco/FineoRdDbQr03wXcQ3jxHYIHmHb5CAwD7OxxM+jO3V@vger.kernel.org, AJvYcCXjrAqMLcIaDBCYXGloK5pR0jZuKgTuPeQbUZlLxEAGonrECCetlBn3YH7EZeYurInHjlB2hsJzUUf6qwk0@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUXQoiq0SUajdos1tFPx390tlg8OHApJg5u14Vw2vN5wiTzaD
	1qicneVKzhbr1TmQPXkxHfPNmxorSPpQRlzaWv3P4eNezK+tHubv4cpMng==
X-Gm-Gg: ASbGncu32LhYIHrKqWDcAuxxGLw5+57qdA6KnTyWZp+uBnILigdCzI9cJ3VKHkn/HDE
	Ihp3R0iSt09tAvTdzVIXoD4CT+fBHCqM8AWuve9H7flsZ2p+5xv2mFMtXfGD/Obe7A0jQWgHPT5
	ESudbcLoLBJ4rmPA3H7VQUWWagFsBA5wW/7rN0gKPqDMpBqW/vmKgTSWCzZJL4XTSGHa2Qa82wP
	CY1tL3bntm2w5i7szNe/jRzJypYi+PF2DYnjyAdo5eO5fDLlP8hL91xnAKcGG6Pje1B0UVnZG+V
	EJg7LCQM9n3kgOTEdQ==
X-Google-Smtp-Source: AGHT+IGzS9UyrrxbS4yv5r60fDb3pKChTUtvPd58OhKzkDzT1cpZUL1ZJrNZsJjw1ePK9KYADrUXZA==
X-Received: by 2002:a17:907:8688:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-abc0da3b026mr2136594566b.28.1740562652941;
        Wed, 26 Feb 2025 01:37:32 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdc669sm294366266b.26.2025.02.26.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:37:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] power: supply: Add support for Maxim MAX8971 charger
Date: Wed, 26 Feb 2025 11:37:00 +0200
Message-ID: <20250226093700.44726-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226093700.44726-1-clamor95@gmail.com>
References: <20250226093700.44726-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX8971 is a compact, high-frequency, high-efficiency
switch-mode charger for a one-cell lithium-ion (Li+) battery.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/Kconfig           |  14 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/max8971_charger.c | 690 +++++++++++++++++++++++++
 3 files changed, 705 insertions(+)
 create mode 100644 drivers/power/supply/max8971_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..7c86116c2947 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -595,6 +595,20 @@ config CHARGER_MAX77976
 	  This driver can also be built as a module. If so, the module will be
 	  called max77976_charger.
 
+config CHARGER_MAX8971
+	tristate "Maxim MAX8971 battery charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
+	  charger for a one-cell lithium-ion (Li+) battery. It delivers up to
+	  1.55A of current to the battery from inputs up to 7.5V and withstands
+	  transient inputs up to 22V.
+
+	  Say Y to enable support for the Maxim MAX8971 battery charger.
+	  This driver can also be built as a module. If so, the module will be
+	  called max8971_charger.
+
 config CHARGER_MAX8997
 	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
 	depends on MFD_MAX8997 && REGULATOR_MAX8997
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..8fa051ff87ff 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
+obj-$(CONFIG_CHARGER_MAX8971)	+= max8971_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
 obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
diff --git a/drivers/power/supply/max8971_charger.c b/drivers/power/supply/max8971_charger.c
new file mode 100644
index 000000000000..bb19a2bcbbcd
--- /dev/null
+++ b/drivers/power/supply/max8971_charger.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/devm-helpers.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/extcon.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_graph.h>
+#include <linux/property.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define MAX8971_REG_CHGINT		0x0f
+#define   MAX8971_REG_CHG_RST		BIT(0)
+#define MAX8971_REG_CHGINT_MASK		0x01
+#define   MAX8971_AICL_MASK		BIT(7)
+#define MAX8971_REG_CHG_STAT		0x02
+#define   MAX8971_CHG_MASK		BIT(3)
+#define MAX8971_REG_DETAILS1		0x03
+#define MAX8971_REG_DETAILS2		0x04
+#define MAX8971_REG_CHGCNTL1		0x05
+#define MAX8971_REG_FCHGCRNT		0x06
+#define MAX8971_REG_DCCRNT		0x07
+#define   MAX8971_CHGRSTRT_MASK		BIT(6)
+#define   MAX8971_CHGRSTRT_SHIFT	6
+#define MAX8971_REG_TOPOFF		0x08
+#define MAX8971_REG_TEMPREG		0x09
+#define MAX8971_REG_PROTCMD		0x0a
+#define   MAX8971_CHGPROT_LOCKED	0x00
+#define   MAX8971_CHGPROT_UNLOCKED	0x03
+
+#define MAX8971_CHGCC_DCILMT_DEFAULT	500
+#define MAX8971_FCHGT_DEFAULT		2
+#define MAX8971_TOPOFFT_DEFAULT		3
+
+static const char *max8971_manufacturer	= "Maxim Integrated";
+static const char *max8971_model	= "MAX8971";
+
+enum max8971_charging_state {
+	MAX8971_CHARGING_DEAD_BATTERY,
+	MAX8971_CHARGING_PREQUALIFICATION,
+	MAX8971_CHARGING_FAST_CONST_CURRENT,
+	MAX8971_CHARGING_FAST_CONST_VOLTAGE,
+	MAX8971_CHARGING_TOP_OFF,
+	MAX8971_CHARGING_DONE,
+	MAX8971_CHARGING_TIMER_FAULT,
+	MAX8971_CHARGING_SUSPENDED_THERMAL,
+	MAX8971_CHARGING_OFF,
+	MAX8971_CHARGING_THERMAL_LOOP,
+};
+
+enum max8971_health_state {
+	MAX8971_HEALTH_UNKNOWN,
+	MAX8971_HEALTH_COLD,
+	MAX8971_HEALTH_COOL,
+	MAX8971_HEALTH_WARM,
+	MAX8971_HEALTH_HOT,
+	MAX8971_HEALTH_OVERHEAT,
+};
+
+/* Fast-Charge current limit, 250..1550 mA, 50 mA steps */
+#define MAX8971_CHG_CC_STEP			  50000U
+#define MAX8971_CHG_CC_MIN			 250000U
+#define MAX8971_CHG_CC_MAX			1550000U
+
+/* Input current limit, 250..1500 mA, 25 mA steps */
+#define MAX8971_DCILMT_STEP			  25000U
+#define MAX8971_DCILMT_MIN			 250000U
+#define MAX8971_DCILMT_MAX			1500000U
+
+enum max8971_field_idx {
+	THM_DTLS,		/* DETAILS1 */
+	BAT_DTLS, CHG_DTLS,	/* DETAILS2 */
+	CHG_CC, FCHG_T,		/* FCHGCRNT */
+	DCI_LMT,		/* DCCRNT */
+	TOPOFF_T, CHG_CV,	/* TOPOFF */
+	CPROT,			/* PROTCMD */
+	MAX8971_N_REGMAP_FIELDS
+};
+
+static const struct reg_field max8971_reg_field[MAX8971_N_REGMAP_FIELDS] = {
+	[THM_DTLS] = REG_FIELD(MAX8971_REG_DETAILS1, 0, 2),
+	[BAT_DTLS] = REG_FIELD(MAX8971_REG_DETAILS2, 4, 5),
+	[CHG_DTLS] = REG_FIELD(MAX8971_REG_DETAILS2, 0, 3),
+	[CHG_CC]   = REG_FIELD(MAX8971_REG_FCHGCRNT, 0, 4),
+	[FCHG_T]   = REG_FIELD(MAX8971_REG_FCHGCRNT, 5, 7),
+	[DCI_LMT]  = REG_FIELD(MAX8971_REG_DCCRNT,   0, 5),
+	[TOPOFF_T] = REG_FIELD(MAX8971_REG_TOPOFF,   5, 7),
+	[CHG_CV]   = REG_FIELD(MAX8971_REG_TOPOFF,   2, 3),
+	[CPROT]    = REG_FIELD(MAX8971_REG_PROTCMD,  2, 3),
+};
+
+static const struct regmap_config max8971_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX8971_REG_CHGINT,
+};
+
+struct max8971_config {
+	u32 chgcc;
+	u32 fchgt;
+	u32 chgrstrt;
+	u32 dcilmt;
+	u32 tofft;
+	u32 toffs;
+};
+
+struct max8971_data {
+	struct i2c_client *client;
+	struct device *dev;
+	struct power_supply *psy_mains;
+
+	struct extcon_dev *edev;
+	struct notifier_block extcon_nb;
+	struct delayed_work extcon_work;
+
+	struct regmap *regmap;
+	struct regmap_field *rfield[MAX8971_N_REGMAP_FIELDS];
+
+	struct max8971_config config;
+	enum power_supply_usb_type usb_type;
+
+	u32 chgcc_usb;
+	u32 chgcc_ac;
+	u32 dcilmt_usb;
+	u32 dcilmt_ac;
+
+	bool present;
+};
+
+static int max8971_get_status(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[CHG_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_CHARGING_DEAD_BATTERY:
+	case MAX8971_CHARGING_PREQUALIFICATION:
+	case MAX8971_CHARGING_FAST_CONST_CURRENT:
+	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
+	case MAX8971_CHARGING_TOP_OFF:
+	case MAX8971_CHARGING_THERMAL_LOOP:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case MAX8971_CHARGING_DONE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case MAX8971_CHARGING_TIMER_FAULT:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case MAX8971_CHARGING_OFF:
+	case MAX8971_CHARGING_SUSPENDED_THERMAL:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_charge_type(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[CHG_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_CHARGING_DEAD_BATTERY:
+	case MAX8971_CHARGING_PREQUALIFICATION:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case MAX8971_CHARGING_FAST_CONST_CURRENT:
+	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case MAX8971_CHARGING_TOP_OFF:
+	case MAX8971_CHARGING_THERMAL_LOOP:
+		*val = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+	case MAX8971_CHARGING_DONE:
+	case MAX8971_CHARGING_TIMER_FAULT:
+	case MAX8971_CHARGING_SUSPENDED_THERMAL:
+	case MAX8971_CHARGING_OFF:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_health(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[THM_DTLS], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case MAX8971_HEALTH_COLD:
+		*val = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	case MAX8971_HEALTH_COOL:
+		*val = POWER_SUPPLY_HEALTH_COOL;
+		break;
+	case MAX8971_HEALTH_WARM:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case MAX8971_HEALTH_HOT:
+		*val = POWER_SUPPLY_HEALTH_HOT;
+		break;
+	case MAX8971_HEALTH_OVERHEAT:
+		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	case MAX8971_HEALTH_UNKNOWN:
+	default:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max8971_get_online(struct max8971_data *priv, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_read(priv->regmap, MAX8971_REG_CHG_STAT, &regval);
+	if (err)
+		return err;
+
+	if (priv->present)
+		/* CHG_OK bit is 0 when charger is online */
+		*val = !(regval & MAX8971_CHG_MASK);
+	else
+		*val = priv->present;
+
+	return 0;
+}
+
+static int max8971_get_integer(struct max8971_data *priv, enum max8971_field_idx fidx,
+			       u32 clamp_min, u32 clamp_max, u32 mult, int *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[fidx], &regval);
+	if (err)
+		return err;
+
+	*val = clamp_val(regval * mult, clamp_min, clamp_max);
+
+	return 0;
+}
+
+static int max8971_set_integer(struct max8971_data *priv, enum max8971_field_idx fidx,
+			       u32 clamp_min, u32 clamp_max, u32 div, int val)
+{
+	u32 regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(priv->rfield[fidx], regval);
+}
+
+static int max8971_get_property(struct power_supply *psy, enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = max8971_get_status(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = max8971_get_charge_type(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = priv->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = max8971_get_health(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = max8971_get_online(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = priv->present;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = MAX8971_CHG_CC_MAX;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		ret = max8971_get_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = max8971_get_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max8971_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max8971_manufacturer;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int max8971_set_property(struct power_supply *psy, enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		ret = max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, val->intval);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+};
+
+static int max8971_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property max8971_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct power_supply_desc max8971_charger_desc = {
+	.name = "charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
+	.properties = max8971_properties,
+	.num_properties = ARRAY_SIZE(max8971_properties),
+	.get_property = max8971_get_property,
+	.set_property = max8971_set_property,
+	.property_is_writeable = max8971_property_is_writeable,
+};
+
+static void max8971_extcon_evt_worker(struct work_struct *work)
+{
+	struct max8971_data *priv =
+		container_of(work, struct max8971_data, extcon_work.work);
+	struct device *dev = priv->dev;
+	struct extcon_dev *edev = priv->edev;
+	u32 chgcc, dcilmt;
+
+	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
+		dev_dbg(dev, "USB SDP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = priv->chgcc_usb;
+		dcilmt = priv->dcilmt_usb;
+	} else if (extcon_get_state(edev, EXTCON_USB) > 0) {
+		dev_dbg(dev, "USB charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = priv->chgcc_usb;
+		dcilmt = priv->dcilmt_usb;
+	} else if (extcon_get_state(edev, EXTCON_DISP_MHL) > 0) {
+		dev_dbg(dev, "MHL plug is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = priv->chgcc_usb;
+		dcilmt = priv->dcilmt_usb;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
+		dev_dbg(dev, "USB DCP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		chgcc = priv->chgcc_ac;
+		dcilmt = priv->dcilmt_ac;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
+		dev_dbg(dev, "USB FAST charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = priv->chgcc_ac;
+		dcilmt = priv->dcilmt_ac;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
+		dev_dbg(dev, "USB SLOW charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = priv->chgcc_ac;
+		dcilmt = priv->dcilmt_ac;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
+		dev_dbg(dev, "USB CDP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_CDP;
+		chgcc = priv->chgcc_ac;
+		dcilmt = priv->dcilmt_ac;
+	} else {
+		dev_dbg(dev, "USB state is unknown\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return;
+	}
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
+
+	max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+			    MAX8971_CHG_CC_STEP, chgcc);
+	max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+			    MAX8971_DCILMT_STEP, dcilmt);
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
+}
+
+static int extcon_get_charger_type(struct notifier_block *nb,
+				   unsigned long state, void *data)
+{
+	struct max8971_data *priv =
+		container_of(nb, struct max8971_data, extcon_nb);
+	schedule_delayed_work(&priv->extcon_work, 0);
+	return NOTIFY_OK;
+}
+
+static void max8971_update_config(struct max8971_data *priv)
+{
+	struct max8971_config *config = &priv->config;
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
+
+	/* Construct Fast-Charge Current and Timer Control register */
+	if (config->chgcc != MAX8971_CHGCC_DCILMT_DEFAULT)
+		max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+				    MAX8971_CHG_CC_STEP, config->chgcc);
+
+	if (config->fchgt != MAX8971_FCHGT_DEFAULT)
+		regmap_field_write(priv->rfield[FCHG_T], config->fchgt);
+
+	/* Construct Input-Current Limit and Charger Restart Threshold register */
+	if (config->chgrstrt)
+		regmap_write_bits(priv->regmap, MAX8971_REG_DCCRNT, MAX8971_CHGRSTRT_MASK,
+				  config->chgrstrt << MAX8971_CHGRSTRT_SHIFT);
+
+	if (config->dcilmt != MAX8971_CHGCC_DCILMT_DEFAULT)
+		max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+				    MAX8971_DCILMT_STEP, config->dcilmt);
+
+	/* Construct Done Current, Timer, and Battery Regulation Voltage register */
+	if (config->tofft != MAX8971_TOPOFFT_DEFAULT)
+		regmap_field_write(priv->rfield[TOPOFF_T], config->tofft);
+
+	if (config->toffs)
+		regmap_field_write(priv->rfield[CHG_CV], config->toffs);
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
+}
+
+static irqreturn_t max8971_interrupt(int irq, void *dev_id)
+{
+	struct max8971_data *priv = dev_id;
+	struct device *dev = priv->dev;
+	int ret, state;
+
+	ret = regmap_read(priv->regmap, MAX8971_REG_CHGINT, &state);
+	if (ret)
+		dev_err(dev, "interrupt reg read failed %d\n", ret);
+
+	ret = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK,
+				MAX8971_AICL_MASK, MAX8971_AICL_MASK);
+	if (ret)
+		dev_err(dev, "failed to mask IRQ\n");
+
+	/* set presence prop */
+	priv->present = state & MAX8971_REG_CHG_RST;
+
+	/* on every plug chip resets to default */
+	if (priv->present)
+		max8971_update_config(priv);
+
+	/* update supply status */
+	power_supply_changed(priv->psy_mains);
+
+	return IRQ_HANDLED;
+}
+
+static void max8971_dt_init(struct max8971_data *priv)
+{
+	struct device *dev = priv->dev;
+	struct max8971_config *config = &priv->config;
+
+	/* Construct Fast-Charge Current and Timer Control register */
+	config->chgcc = 500 * 1000;
+	device_property_read_u32(dev, "maxim,fcharge-current-limit-microamp", &config->chgcc);
+
+	config->fchgt = 5;
+	device_property_read_u32(dev, "maxim,fcharge-timer-hours", &config->fchgt);
+	config->fchgt -= 3;
+	if (config->fchgt < 0 || config->fchgt > 7)
+		config->fchgt = 0;
+
+	/* Construct Input-Current Limit and Charger Restart Threshold register */
+	config->chgrstrt = device_property_read_bool(dev, "maxim,fcharge-rst-threshold-high");
+
+	config->dcilmt = 500 * 1000;
+	device_property_read_u32(dev, "maxim,in-current-limit-microamp", &config->dcilmt);
+
+	/* Construct Done Current, Timer, and Battery Regulation Voltage register */
+	config->tofft = 30;
+	device_property_read_u32(dev, "maxim,topoff-timer-minutes", &config->tofft);
+	config->tofft /= 10;
+	if (config->tofft > 7)
+		config->tofft = 7;
+
+	config->toffs = 50 * 1000;
+	device_property_read_u32(dev, "maxim,topoff-current-threshold-microamp", &config->toffs);
+	config->toffs = (config->toffs / 1000 - 50) / 50;
+
+	/* Perform initial setup */
+	max8971_update_config(priv);
+
+	/* Get additional variables */
+	priv->chgcc_usb = 500 * 1000;
+	device_property_read_u32(dev, "maxim,fcharge-usb-current-limit-microamp", &priv->chgcc_usb);
+
+	priv->chgcc_ac = 500 * 1000;
+	device_property_read_u32(dev, "maxim,fcharge-ac-current-limit-microamp", &priv->chgcc_ac);
+
+	priv->dcilmt_usb = 500 * 1000;
+	device_property_read_u32(dev, "maxim,usb-in-current-limit-microamp", &priv->dcilmt_usb);
+
+	priv->dcilmt_ac = 500 * 1000;
+	device_property_read_u32(dev, "maxim,ac-in-current-limit-microamp", &priv->dcilmt_ac);
+}
+
+static char *max8971_supplied_to[] = {
+	"battery",
+};
+
+static int max8971_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max8971_data *priv;
+	struct device_node *extcon;
+	struct power_supply_config cfg = { };
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	priv->dev = dev;
+	priv->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+
+	i2c_set_clientdata(client, priv);
+
+	priv->regmap = devm_regmap_init_i2c(client, &max8971_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "cannot allocate regmap\n");
+
+	for (i = 0; i < MAX8971_N_REGMAP_FIELDS; i++) {
+		priv->rfield[i] = devm_regmap_field_alloc(dev, priv->regmap, max8971_reg_field[i]);
+		if (IS_ERR(priv->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(priv->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
+	max8971_dt_init(priv);
+
+	cfg.of_node = dev->of_node;
+	cfg.drv_data = priv;
+	cfg.supplied_to = max8971_supplied_to;
+	cfg.num_supplicants = ARRAY_SIZE(max8971_supplied_to);
+
+	priv->psy_mains = devm_power_supply_register(dev, &max8971_charger_desc, &cfg);
+	if (IS_ERR(priv->psy_mains))
+		return dev_err_probe(dev, PTR_ERR(priv->psy_mains),
+				     "failed to register mains supply\n");
+
+	ret = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK, MAX8971_AICL_MASK,
+				MAX8971_AICL_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to mask IRQ\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, &max8971_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register IRQ %d\n", client->irq);
+
+	extcon = of_graph_get_remote_node(dev->of_node, -1, -1);
+	if (extcon) {
+		priv->edev = extcon_find_edev_by_node(extcon);
+		of_node_put(extcon);
+		if (IS_ERR(priv->edev))
+			return dev_err_probe(dev, PTR_ERR(priv->edev),
+					     "failed to register extcon\n");
+
+		ret = devm_delayed_work_autocancel(dev, &priv->extcon_work,
+						   max8971_extcon_evt_worker);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to add extcon evt stop action\n");
+
+		priv->extcon_nb.notifier_call = extcon_get_charger_type;
+
+		ret = devm_extcon_register_notifier_all(dev, priv->edev, &priv->extcon_nb);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register notifier\n");
+
+		/* Initial configuration work with 1 sec delay */
+		schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000));
+	}
+
+	return 0;
+}
+
+static int max8971_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max8971_data *priv = i2c_get_clientdata(client);
+
+	irq_wake_thread(client->irq, priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(max8971_pm_ops, NULL, max8971_resume);
+
+static const struct of_device_id max8971_match_ids[] = {
+	{ .compatible = "maxim,max8971" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max8971_match_ids);
+
+static const struct i2c_device_id max8971_i2c_id[] = {
+	{ "max8971" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
+
+static struct i2c_driver max8971_driver = {
+	.driver = {
+		.name = "max8971-charger",
+		.of_match_table = max8971_match_ids,
+		.pm = &max8971_pm_ops,
+	},
+	.probe = max8971_probe,
+	.id_table = max8971_i2c_id,
+};
+module_i2c_driver(max8971_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("MAX8971 Charger Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


