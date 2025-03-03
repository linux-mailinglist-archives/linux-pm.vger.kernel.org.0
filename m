Return-Path: <linux-pm+bounces-23301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB8A4BF89
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3937A14F3
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CB20E00B;
	Mon,  3 Mar 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e21o/l+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4720B7E6;
	Mon,  3 Mar 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003001; cv=none; b=UWwWhr3qkEzh2BeoKWHzbTsB4OB7gKORV1VW3fKESCvs4/M8dCtWu31e1A4xuDFGyeYywz+SH3pmM9cf36aM11Nt5X1wXCosV4xoVX3z0d+SO6iJorkOG/F4lsHRZG0uRH6k7QIGwN7b5PgRZmVK3HsqNOE7fZbeAYGJxlfPT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003001; c=relaxed/simple;
	bh=yCeY4CFsTpCHlv0QwFoz/4o/S28p4NgUEQiptoMSF/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7mRxEcm1lQ4h21zcgj/F9/zhYXQ8/fKB/wIasHUIB6TJ5l1p1nE1pQ4rtJK1vAbAyqLkAoBnUm4R+j8jVN2bThKonKGlbzc9LuxmX9O94OdOxmHPyCdvUFh+tgmoz3cdgzKyURTEK3rshAyCwQYk1Jd3Fvm90KxDP1iZp9C9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e21o/l+W; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54954fa61c9so3352173e87.1;
        Mon, 03 Mar 2025 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002997; x=1741607797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td20vm33662bJjhGCdOGcms2YDLjYHw3sG2HyR6OOgk=;
        b=e21o/l+WOXuK9+hdTQ34UHPdMARP8vVSnsmeoKwLGa27UQwgCi7Rx6D9jn5V2SWU5N
         fXLMqMQ8mIb2Nj8kmENRRB47srh1Rf7Nf/8x6c6G3NG58+MQlu5LgD1Pxbqm3w2etvuT
         zxDWrNMLbJbMj2jaq0duOs/BAijnYHI67hJAIAXCzrzICMejxscuGbNEugf+pTfmJPC9
         I1oFeu05dPrM2wK3azqLX5QlWEktXfGMzorVyqaNB+X6egogYP6k49eFDqmf4WgV2BNF
         EPAI0WG6bdzlr+bxkhwvF4S9ec3unwdh2qYo4hwE4/ZrZKyLq6H4ArHcUzmjQio9JVrc
         L/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002997; x=1741607797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td20vm33662bJjhGCdOGcms2YDLjYHw3sG2HyR6OOgk=;
        b=tl8X8HWB4/F/G0/05aR+X7HJ7kislsKwHiNsLKVY9Yqua0WhD8wNTG5bH3XwJ++AHw
         7JuI8VwG9CXEIP7raChhHpoZi2Z4nOEuhYNcSfUzMK+80y0ZRKqtegN/2R4r35jzesnz
         fawVRyugbPrEbaYSfSjQU8sB4lHyNMxoZgKgn0tCCr4NHC5jQRnHPxXivGDcIsuQRNps
         jBrlzvcdnU2OLjn55IPs9uP511pm/2e3Cw8bguZYferate4uQ/8ENfGH29kAy1Fuxu9s
         WYmeawnxxTXKmu0P6mbZF8EpL6XIeX/KN4NuLyrjkbWNcFM8kOw5DjYeD+5CjxS+tIZS
         0BYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+1fyyN0gAvNetXh9zl5tz7X+HFynJyuSHQbyqbxiXP21uwJpXQ/qDItvpPvrrOnZQKiLPDLYoYlcLFjGH@vger.kernel.org, AJvYcCXoxrNz5CceAqjiBMAELmK+gOJA8SHgAgkdVHtHvVf8NiD+S52e+kY01vFLIVqLB1rusxmAxGWf10B7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7Tw3TT0h2xl2tjfj95JRhXNCO6aM+YJPM1XlVocGGaXJ0c3F
	hwh0ZPXxiWAs6Kn6o8CudGQ45IW1bjZpCPrzcSiHIwIfKk34Ve3A
X-Gm-Gg: ASbGnctc5p7NSa244nvWGW5bIqUH2dCc8p6B43KhbVgrLi79MVkKHVsZ9pXife3F6UC
	eNDaz4ETeVZSGHzhQJzdetn8UiXxrLe/62X/Gwz29+7Pq33NXjUr6y3W4ee4Q10hed3mrJj8K90
	L/fgxDE9N26SoFMdDJfn8NXqVOrzCY6oYtUPHp39Y2E8tK0jxgT8LnHRmFY6v2tZ6eAHoi3dGev
	v33ZTerhbN6b2cPgcFjJelnrYz8AibD3o88P8kTCYaQLJkNsf/VXmAKOiM/TPICkMucdG70vXaW
	dcux30zBC2yE4NJWxJ4va7fB2SvTDZOMQ5g=
X-Google-Smtp-Source: AGHT+IE+7byxs9Ih5I3G6HdBYSRErQXaJuzACC5Vh94S6iJygz/a8D9s7w7QLFrRc1gjDynx7I70yg==
X-Received: by 2002:a05:6512:3d19:b0:545:62c:4b29 with SMTP id 2adb3069b0e04-5494c122e58mr5328435e87.22.1741002996612;
        Mon, 03 Mar 2025 03:56:36 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f630cb5sm511817e87.212.2025.03.03.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:56:36 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] power: supply: Add support for Maxim MAX8971 charger
Date: Mon,  3 Mar 2025 13:55:02 +0200
Message-ID: <20250303115502.89457-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303115502.89457-1-clamor95@gmail.com>
References: <20250303115502.89457-1-clamor95@gmail.com>
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
 drivers/power/supply/max8971_charger.c | 758 +++++++++++++++++++++++++
 3 files changed, 773 insertions(+)
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
index 000000000000..651852de71f2
--- /dev/null
+++ b/drivers/power/supply/max8971_charger.c
@@ -0,0 +1,758 @@
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
+#include <linux/sysfs.h>
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
+#define MAX8971_REG_TOPOFF		0x08
+#define MAX8971_REG_TEMPREG		0x09
+#define MAX8971_REG_PROTCMD		0x0a
+#define   MAX8971_CHGPROT_LOCKED	0x00
+#define   MAX8971_CHGPROT_UNLOCKED	0x03
+
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
+	TOPOFF_T, TOPOFF_S,	/* TOPOFF */
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
+	[TOPOFF_S] = REG_FIELD(MAX8971_REG_TOPOFF,   2, 3),
+	[CPROT]    = REG_FIELD(MAX8971_REG_PROTCMD,  2, 3),
+};
+
+static const struct regmap_config max8971_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX8971_REG_CHGINT,
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
+	enum power_supply_usb_type usb_type;
+
+	u32 fchgt;
+	u32 tofft;
+	u32 toffs;
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
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		err = max8971_get_status(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		err = max8971_get_charge_type(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = priv->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		err = max8971_get_health(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		err = max8971_get_online(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = priv->present;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = MAX8971_CHG_CC_MAX;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max8971_get_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max8971_get_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max8971_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max8971_manufacturer;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int max8971_set_property(struct power_supply *psy, enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct max8971_data *priv = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MAX,
+					  MAX8971_CHG_CC_STEP, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_MAX,
+					  MAX8971_DCILMT_STEP, val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
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
+static void max8971_update_config(struct max8971_data *priv)
+{
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
+
+	if (priv->fchgt != MAX8971_FCHGT_DEFAULT)
+		regmap_field_write(priv->rfield[FCHG_T], priv->fchgt);
+
+	regmap_write_bits(priv->regmap, MAX8971_REG_DCCRNT, MAX8971_CHGRSTRT_MASK,
+			  MAX8971_CHGRSTRT_MASK);
+
+	if (priv->tofft != MAX8971_TOPOFFT_DEFAULT)
+		regmap_field_write(priv->rfield[TOPOFF_T], priv->tofft);
+
+	if (priv->toffs)
+		regmap_field_write(priv->rfield[TOPOFF_S], priv->toffs);
+
+	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
+}
+
+static ssize_t fast_charge_timer_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[FCHG_T], &regval);
+	if (err)
+		return err;
+
+	switch (regval) {
+	case 0x1 ... 0x7:
+		/* Time if off by 3 hours comparing to value */
+		regval += 3;
+		break;
+	case 0x0:
+	default:
+		regval = 0;
+		break;
+	}
+
+	return sysfs_emit(buf, "%u\n", regval);
+}
+
+static ssize_t fast_charge_timer_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	unsigned long hours;
+	int val, err;
+
+	err = kstrtoul(buf, 10, &hours);
+	if (err)
+		return err;
+
+	val = hours - 3;
+	if (val <= 0 || val > 7)
+		priv->fchgt = 0;
+	else
+		priv->fchgt = val;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static ssize_t top_off_threshold_current_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	u32 regval, val;
+	int err;
+
+	err = regmap_field_read(priv->rfield[TOPOFF_S], &regval);
+	if (err)
+		return err;
+
+	/* 50uA start with 50uA step */
+	val = regval * 50 + 50;
+	val *= 1000;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t top_off_threshold_current_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	unsigned long uamp;
+	int err;
+
+	err = kstrtoul(buf, 10, &uamp);
+	if (err)
+		return err;
+
+	if (uamp < 50000 || uamp > 200000)
+		return -EINVAL;
+
+	priv->toffs = uamp / 50000 - 1;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static ssize_t top_off_timer_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_field_read(priv->rfield[TOPOFF_T], &regval);
+	if (err)
+		return err;
+
+	/* 10 min intervals */
+	regval *= 10;
+
+	return sysfs_emit(buf, "%u\n", regval);
+}
+
+static ssize_t top_off_timer_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct max8971_data *priv = dev_get_drvdata(dev);
+	unsigned long minutes;
+	int err;
+
+	err = kstrtoul(buf, 10, &minutes);
+	if (err)
+		return err;
+
+	if (minutes > 70)
+		return -EINVAL;
+
+	priv->tofft = minutes / 10;
+
+	max8971_update_config(priv);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(fast_charge_timer);
+static DEVICE_ATTR_RW(top_off_threshold_current);
+static DEVICE_ATTR_RW(top_off_timer);
+
+static struct attribute *max8971_attributes[] = {
+	&dev_attr_fast_charge_timer.attr,
+	&dev_attr_top_off_threshold_current.attr,
+	&dev_attr_top_off_timer.attr,
+	NULL
+};
+
+static const struct attribute_group max8971_attr_group = {
+	.attrs = max8971_attributes,
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
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_USB) > 0) {
+		dev_dbg(dev, "USB charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_DISP_MHL) > 0) {
+		dev_dbg(dev, "MHL plug is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		chgcc = 500000;
+		dcilmt = 500000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
+		dev_dbg(dev, "USB DCP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
+		dev_dbg(dev, "USB FAST charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
+		dev_dbg(dev, "USB SLOW charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		chgcc = 900000;
+		dcilmt = 1200000;
+	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
+		dev_dbg(dev, "USB CDP charger is connected\n");
+		priv->usb_type = POWER_SUPPLY_USB_TYPE_CDP;
+		chgcc = 900000;
+		dcilmt = 1200000;
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
+static irqreturn_t max8971_interrupt(int irq, void *dev_id)
+{
+	struct max8971_data *priv = dev_id;
+	struct device *dev = priv->dev;
+	int err, state;
+
+	err = regmap_read(priv->regmap, MAX8971_REG_CHGINT, &state);
+	if (err)
+		dev_err(dev, "interrupt reg read failed %d\n", err);
+
+	err = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK,
+				MAX8971_AICL_MASK, MAX8971_AICL_MASK);
+	if (err)
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
+	int err, i;
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
+	err = regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK, MAX8971_AICL_MASK,
+				MAX8971_AICL_MASK);
+	if (err)
+		return dev_err_probe(dev, err, "failed to mask IRQ\n");
+
+	err = devm_device_add_group(dev, &max8971_attr_group);
+	if (err)
+		return dev_err_probe(dev, err, "failed to create sysfs attributes\n");
+
+	err = devm_request_threaded_irq(dev, client->irq, NULL, &max8971_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
+	if (err)
+		return dev_err_probe(dev, err, "failed to register IRQ %d\n", client->irq);
+
+	extcon = of_graph_get_remote_node(dev->of_node, -1, -1);
+	if (extcon) {
+		priv->edev = extcon_find_edev_by_node(extcon);
+		of_node_put(extcon);
+		if (IS_ERR(priv->edev))
+			return dev_err_probe(dev, PTR_ERR(priv->edev),
+					     "failed to register extcon\n");
+
+		err = devm_delayed_work_autocancel(dev, &priv->extcon_work,
+						   max8971_extcon_evt_worker);
+		if (err)
+			return dev_err_probe(dev, err, "failed to add extcon evt stop action\n");
+
+		priv->extcon_nb.notifier_call = extcon_get_charger_type;
+
+		err = devm_extcon_register_notifier_all(dev, priv->edev, &priv->extcon_nb);
+		if (err)
+			return dev_err_probe(dev, err, "failed to register notifier\n");
+
+		/* Initial configuration work with 1 sec delay */
+		schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000));
+	}
+
+	return 0;
+}
+
+static int __maybe_unused max8971_resume(struct device *dev)
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


