Return-Path: <linux-pm+bounces-8062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFD8CC952
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B31C21C41
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA62149C72;
	Wed, 22 May 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpPXnyfY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB780C04;
	Wed, 22 May 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418903; cv=none; b=ICYooj29TVRYnZ34kWHSxL0HToXzkzB/sbFLnMvmOIJHDmJJaSjcxSf42cDM25WRbIrocB5KkTz8kS00D+C0NEZr7PdSZMVZhf1/HapU/xSvxRVmOm2H83hDqYSLIvMbnoaRy3vCekfeBxPg8UxmnGDV9H712ZYtV4XZRh4nX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418903; c=relaxed/simple;
	bh=InqBqLbH3n/AJ0tE4B/mjMRNaXb85H66Zo/dlVxzD7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq/Av7Dh7GEORN54omy+ugouipUkTnwvKwjsCELc3G5kMW+aFvOg+DMId1sTOyXQl+HtzxqwYOy5zA/SMFi4jep5v9/ZDSQeKYEwGnchIKSEU29ZtGLcjjV4p7honWdYSNvJ7aYiIHQIZ4ZjMK/g9Vig4CRlH+1cjYt1hQ9GTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpPXnyfY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f0e4212d5aso3032741a34.3;
        Wed, 22 May 2024 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418900; x=1717023700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tByCviqN7zUdCC9oaXPaphubYoz1pXTVHw9kMt4I1mo=;
        b=OpPXnyfYfOuL16nLG14dhSO+o6OMg4BJJmjoNuOAhDG5KIJ6BgP22+GSRfwXBTlyUE
         RHnGZ31PVH0SGOygV+20Dz6Wh7mgS9QgCl8asmlcqjPsJHQxwxHQEgSk1gu2RQgiegBs
         NVAZN0OM6erjh3H9/v5qmBDbFx6T/E3wiOHMroZC0BzdxRxwgjYeDtkdmmFYlPPima78
         vQ1F2VzZrJbzgae5qEf8VMDLKJP0545+V41SvG+S7sbMHyg+3P+2PL3bHGfh2HRCsUod
         +yLomZbWij2wHaP8atEz9umNZPyveAZZ2d00xHxMnOgxCqaw5dWSkhI+hwN8Z/Sj9GKY
         5CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418900; x=1717023700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tByCviqN7zUdCC9oaXPaphubYoz1pXTVHw9kMt4I1mo=;
        b=uBk6s499aJQroQGY7LVZvsQWaXWj/6AfxHxmGk33MAx431cNSl94Q/GFfqmN7aPAJc
         t2/ZzPbTM4wMFnOr12JqnOTEdr1qhMJEp7Rcm1p4XM70GKRayCH8uYnYL6wETJ9iaptm
         IaFHvyOTlW2+hvq5EtSWs+t2le16m/QiD5uw9EIytkX1DMxpeMl/2Zndm+26j4eHah+p
         46Af5pgf3gNcYDUY995z2Bb6+rF+3LR7e0ymVb5vDNSvRAkGA8QdyeBjwciecNYpVOei
         7QoWbh1JAQdq8Xysy/y7rvjpJ6vsgSKUF20Oko+to50EpznYADKgLYxyyYjNF4QNL9FI
         eH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiw2OVAKpiIDKbWmWVyUJGZRxcRIzpbk06y3Dr8zKmclxpgOIgMmoFpkc/+i2kauaXp3tZKrNIFryFEQpNs+XBGYQuVZAojgQ=
X-Gm-Message-State: AOJu0YxW7KlL1h2E1jwBLLximWVsOAsxiSrrWZJiEp4Hfy3sIa0gJcXC
	8ST5kG3+/IR71xWXZv6rdYoR4ZhL5Uyj/6D9DpHV2StJBip0A3sp
X-Google-Smtp-Source: AGHT+IGI+mRRIbwH6sZww5+pXiaXyqblDhRhEQ+b/bLWyEavBs70WJtQt+va7gj5k4TTpKYvcRxr7A==
X-Received: by 2002:a9d:6319:0:b0:6f0:e4ee:51c with SMTP id 46e09a7af769-6f666c91a89mr3551266a34.21.1716418900311;
        Wed, 22 May 2024 16:01:40 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ff995ccdsm4155936a34.34.2024.05.22.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:01:39 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/4] power: supply: axp20x_usb_power: Add support for AXP717
Date: Wed, 22 May 2024 18:01:31 -0500
Message-Id: <20240522230132.364915-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522230132.364915-1-macroalpha82@gmail.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717. It does USB BC 1.2 detection similar to the
AXP813, however it is otherwise very different from previous AXP
devices.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/axp20x.c                    |  19 ++-
 drivers/power/supply/axp20x_usb_power.c | 216 +++++++++++++++++++++++-
 include/linux/mfd/axp20x.h              |  18 ++
 3 files changed, 248 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 16950c3206d7..d52d0c1c3367 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -209,15 +209,20 @@ static const struct regmap_access_table axp313a_volatile_table = {
 };
 
 static const struct regmap_range axp717_writeable_ranges[] = {
-	regmap_reg_range(AXP717_MODULE_EN_CONTROL_2, AXP717_MODULE_EN_CONTROL_2),
-	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
+	regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
+	regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
+	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
+	regmap_reg_range(AXP717_ADC_DATA_SEL, AXP717_ADC_DATA_SEL),
 };
 
 static const struct regmap_range axp717_volatile_ranges[] = {
+	regmap_reg_range(AXP717_ON_INDICATE, AXP717_BC_DETECT),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_ADC_VBAT_H, AXP717_ADC_ICHG_L),
+	regmap_reg_range(AXP717_ADC_DATA_H, AXP717_ADC_DATA_L),
 };
 
 static const struct regmap_access_table axp717_writeable_table = {
@@ -310,6 +315,11 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
 };
 
+static const struct resource axp717_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+};
+
 /* AXP803 and AXP813/AXP818 share the same interrupts */
 static const struct resource axp803_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
@@ -424,7 +434,7 @@ static const struct regmap_config axp717_regmap_config = {
 	.val_bits = 8,
 	.wr_table = &axp717_writeable_table,
 	.volatile_table = &axp717_volatile_table,
-	.max_register = AXP717_CPUSLDO_CONTROL,
+	.max_register = AXP717_ADC_DATA_L,
 	.cache_type = REGCACHE_MAPLE,
 };
 
@@ -1026,6 +1036,9 @@ static struct mfd_cell axp313a_cells[] = {
 static struct mfd_cell axp717_cells[] = {
 	MFD_CELL_NAME("axp20x-regulator"),
 	MFD_CELL_RES("axp20x-pek", axp717_pek_resources),
+	MFD_CELL_OF("axp717-usb-power-supply",
+		    axp717_usb_power_supply_resources, NULL, 0, 0,
+		    "x-powers,axp717-usb-power-supply"),
 };
 
 static const struct resource axp288_adc_resources[] = {
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dae7e5cfc54e..3d6815bd614b 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2014 Bruno Prémont <bonbons@linux-vserver.org>
  */
 
+#include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/devm-helpers.h>
@@ -30,14 +31,25 @@
 #define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
 #define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
 
+#define AXP717_PWR_STATUS_VBUS_GOOD	BIT(5)
+
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
+#define AXP717_PMU_FAULT_VBUS		BIT(5)
+#define AXP717_PMU_FAULT_VSYS		BIT(3)
+
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
 
-#define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
+#define AXP717_INPUT_VOL_LIMIT_MASK	GENMASK(3, 0)
+#define AXP717_INPUT_CUR_LIMIT_MASK	GENMASK(5, 0)
+
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
+#define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
+
+#define AXP717_ADC_EN_VSYS_VOLT		BIT(3)
+#define AXP717_ADC_EN_VBUS_VOLT		BIT(2)
 
 /*
  * Note do not raise the debounce time, we must report Vusb high within
@@ -45,6 +57,8 @@
  */
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
+struct axp20x_usb_power;
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	const char * const		*irq_names;
@@ -58,6 +72,8 @@ struct axp_data {
 	struct reg_field		usb_bc_det_fld;
 	struct reg_field		vbus_disable_bit;
 	bool				vbus_needs_polling: 1;
+	int (*axp20x_usb_init)(struct axp20x_usb_power *power);
+	void (*axp20x_read_vbus)(struct work_struct *work);
 };
 
 struct axp20x_usb_power {
@@ -136,6 +152,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static void axp717_usb_power_poll_vbus(struct work_struct *work)
+{
+	struct axp20x_usb_power *power =
+		container_of(work, struct axp20x_usb_power, vbus_detect.work);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &val);
+	if (ret)
+		return;
+
+	val &= AXP717_PWR_STATUS_VBUS_GOOD;
+	if (val != power->old_status)
+		power_supply_changed(power->supply);
+
+	power->old_status = val;
+}
+
 static int axp20x_get_usb_type(struct axp20x_usb_power *power,
 			       union power_supply_propval *val)
 {
@@ -281,6 +315,82 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int axp717_usb_power_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+	unsigned int v;
+	u8 bulk_reg[2];
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		ret = regmap_read(power->regmap, AXP717_PMU_FAULT_VBUS, &v);
+		if (ret)
+			return ret;
+
+		v &= (AXP717_PMU_FAULT_VBUS | AXP717_PMU_FAULT_VSYS);
+		if (v) {
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+			regmap_write(power->regmap, AXP717_PMU_FAULT_VBUS, v);
+		}
+
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(power->regmap, AXP717_INPUT_CUR_LIMIT_CTRL, &v);
+		if (ret)
+			return ret;
+
+		v &= AXP717_INPUT_CUR_LIMIT_MASK;
+		val->intval = (v * 50000) + 100000;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &v);
+		if (ret)
+			return ret;
+		val->intval = !!(v & AXP717_PWR_STATUS_VBUS_GOOD);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return axp20x_get_usb_type(power, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(power->regmap, AXP717_INPUT_VOL_LIMIT_CTRL, &v);
+		if (ret)
+			return ret;
+
+		v &= AXP717_INPUT_VOL_LIMIT_MASK;
+		val->intval = (v * 80000) + 3880000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = regmap_bulk_read(power->regmap, AXP717_ADC_VBUS_H, bulk_reg, 2);
+		if (ret)
+			return ret;
+		val->intval = get_unaligned_be16(bulk_reg) * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+
+}
+
+static int axp717_usb_init(struct axp20x_usb_power *power)
+{
+	int ret;
+
+	ret = regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
+				 AXP717_ADC_EN_VSYS_VOLT |
+				 AXP717_ADC_EN_VBUS_VOLT,
+				 AXP717_ADC_EN_VSYS_VOLT |
+				 AXP717_ADC_EN_VBUS_VOLT);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -307,6 +417,20 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	if (intval < 3880000 || intval > 5080000)
+		return -EINVAL;
+
+	val = (intval - 3880000) / 80000;
+	return regmap_update_bits(power->regmap,
+				  AXP717_INPUT_VOL_LIMIT_CTRL,
+				  AXP717_INPUT_VOL_LIMIT_MASK, val);
+}
+
 static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
 						    int intval)
 {
@@ -340,6 +464,20 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 	return regmap_field_write(power->curr_lim_fld, reg);
 }
 
+static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+						    int intval)
+{
+	int val;
+
+	if (intval < 100000 || intval > 3250000)
+		return -EINVAL;
+
+	val = (intval - 100000) / 50000;
+	return regmap_update_bits(power->regmap,
+				  AXP717_INPUT_CUR_LIMIT_CTRL,
+				  AXP717_INPUT_CUR_LIMIT_MASK, val);
+}
+
 static int axp20x_usb_power_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *val)
@@ -366,6 +504,26 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+static int axp717_usb_power_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp717_usb_power_set_input_current_limit(power, val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return axp717_usb_power_set_voltage_min(power, val->intval);
+
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 					   enum power_supply_property psp)
 {
@@ -385,6 +543,13 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
+static int axp717_usb_power_prop_writeable(struct power_supply *psy,
+					   enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
 static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -403,6 +568,16 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static enum power_supply_property axp717_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 static enum power_supply_property axp813_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -439,6 +614,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static const struct power_supply_desc axp717_usb_power_desc = {
+	.name = "axp20x-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = axp717_usb_power_properties,
+	.num_properties = ARRAY_SIZE(axp717_usb_power_properties),
+	.property_is_writeable = axp717_usb_power_prop_writeable,
+	.get_property = axp717_usb_power_get_property,
+	.set_property = axp717_usb_power_set_property,
+	.usb_types = axp813_usb_types,
+	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
+};
+
 static const struct power_supply_desc axp813_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -505,6 +692,7 @@ static const struct axp_data axp192_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
 };
 
 static const struct axp_data axp202_data = {
@@ -516,6 +704,7 @@ static const struct axp_data axp202_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
 };
 
 static const struct axp_data axp221_data = {
@@ -526,6 +715,7 @@ static const struct axp_data axp221_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
 };
 
 static const struct axp_data axp223_data = {
@@ -536,6 +726,18 @@ static const struct axp_data axp223_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+};
+
+static const struct axp_data axp717_data = {
+	.power_desc	= &axp717_usb_power_desc,
+	.irq_names	= axp22x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
+	.curr_lim_fld	= REG_FIELD(AXP717_INPUT_CUR_LIMIT_CTRL, 0, 5),
+	.usb_bc_en_bit	= REG_FIELD(AXP717_MODULE_EN_CONTROL_1, 4, 4),
+	.usb_bc_det_fld = REG_FIELD(AXP717_BC_DETECT, 5, 7),
+	.axp20x_usb_init = &axp717_usb_init,
+	.axp20x_read_vbus = &axp717_usb_power_poll_vbus,
 };
 
 static const struct axp_data axp813_data = {
@@ -549,6 +751,7 @@ static const struct axp_data axp813_data = {
 	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -707,7 +910,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
-					   axp20x_usb_power_poll_vbus);
+					   axp_data->axp20x_read_vbus);
 	if (ret)
 		return ret;
 
@@ -733,6 +936,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (power->axp_data->axp20x_usb_init) {
+		ret = axp_data->axp20x_usb_init(power);
+		if (ret)
+			return ret;
+	}
+
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = power;
 
@@ -778,6 +987,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
 		.data = &axp223_data,
+	}, {
+		.compatible = "x-powers,axp717-usb-power-supply",
+		.data = &axp717_data,
 	}, {
 		.compatible = "x-powers,axp813-usb-power-supply",
 		.data = &axp813_data,
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index e0cd66bd3b6d..107808df33e9 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -115,6 +115,12 @@ enum axp20x_variants {
 #define AXP313A_IRQ_STATE		0x21
 
 #define AXP717_ON_INDICATE		0x00
+#define AXP717_BC_DETECT		0x05
+#define AXP717_PMU_FAULT		0x08
+#define AXP717_MODULE_EN_CONTROL_1	0x0b
+#define AXP717_MIN_SYS_V_CONTROL	0x15
+#define AXP717_INPUT_VOL_LIMIT_CTRL	0x16
+#define AXP717_INPUT_CUR_LIMIT_CTRL	0x17
 #define AXP717_MODULE_EN_CONTROL_2	0x19
 #define AXP717_BOOST_CONTROL		0x1e
 #define AXP717_IRQ0_EN			0x40
@@ -147,6 +153,18 @@ enum axp20x_variants {
 #define AXP717_CLDO3_CONTROL		0x9d
 #define AXP717_CLDO4_CONTROL		0x9e
 #define AXP717_CPUSLDO_CONTROL		0x9f
+#define AXP717_ADC_CH_EN_CONTROL	0xc0
+#define AXP717_ADC_VBAT_H		0xc4
+#define AXP717_ADC_VBAT_L		0xc5
+#define AXP717_ADC_VBUS_H		0xc6
+#define AXP717_ADC_VBUS_L		0xc7
+#define AXP717_ADC_VSYS_H		0xc8
+#define AXP717_ADC_VSYS_L		0xc9
+#define AXP717_ADC_ICHG_H		0xca
+#define AXP717_ADC_ICHG_L		0xcb
+#define AXP717_ADC_DATA_SEL		0xcd
+#define AXP717_ADC_DATA_H		0xce
+#define AXP717_ADC_DATA_L		0xcf
 
 #define AXP806_STARTUP_SRC		0x00
 #define AXP806_CHIP_ID			0x03
-- 
2.34.1


