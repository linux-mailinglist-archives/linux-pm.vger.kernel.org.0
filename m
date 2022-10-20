Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862B860582F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 09:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJTHQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJTHP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 03:15:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32936161FC3;
        Thu, 20 Oct 2022 00:15:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so19523637plo.3;
        Thu, 20 Oct 2022 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sm2z1ndGFdss1E/5eaCR7bPzKOeKqFx824FfDN5LIXg=;
        b=PkCGhNBri1NurgInvSKkdJ8RaxOUVrib6vJx2wQMjz0TZrMJr9exbWUWjfKeQw5/In
         RIJPOdr2qNf+Xe7fTTZhXw3es3FcL9jDo/qzY8GBuYq1OMjx1Fwmxs6G/KxEF2EUHHiI
         GCgXeclvmdbgi3W99Cvt/if5P2du07M69h85iYZWweezQDouVbh6b6HHw3MZUyKg4WoK
         LUIrebi6G1bFz97oSnx1fkTV8jeybzAn3RxWRwShM+1k+gHho/GxCsC4cjPjAFut4GMN
         dVKqFEgUC+vRIYYmDBfsgcx7gabpsdSRVnDMNtd0OFXUgFD4gHOFI54d+nHzSeKdrfbg
         Lsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm2z1ndGFdss1E/5eaCR7bPzKOeKqFx824FfDN5LIXg=;
        b=RZdoIUA4VRWnGf53yCXk3ihOnOKtYE+xBrbw5SjcnWczPTWwXSJrDHiuM/PPLd8tdR
         BRMs78Y/K9ctHlWXJt2Xxl1nI5zLrRV+kBND9FTDJ6J+3tFHmEQZ6eTiYI11LfLJ4oo8
         Na9EtVVoiIUj5/p25CBjoLurl3n3s6yw069hFwy0fvdS+W8Uko6MGfklJSOrc/ostwe9
         YVIwbVq6Sr/BrYL+cKf8XCuHeb/HjSpYx1axcUV6q9XBoZR03CX5dOZrck5p9SYrFr4z
         w83b9C/us7t2Cb58avJeNpxpeI79CozmHnR2lLFw7IcIJsmvnoz1CgD76bH61znfqmbC
         ERfA==
X-Gm-Message-State: ACrzQf3qAU4NMsGqfoFfOLpWZBzHQJFUeRCETQQYNPSN/UfeoIEZUkR5
        aBB8iH5qV2+azPvcX7yGZxc=
X-Google-Smtp-Source: AMsMyM6crI8zMZztgOgEuMS6nimDTGK605y/+Gk/6VXIhSNF1BTxz7dT1NRdXWYoGgnYm1FTmY3H7g==
X-Received: by 2002:a17:902:d58e:b0:17f:8003:1ceb with SMTP id k14-20020a170902d58e00b0017f80031cebmr12578019plh.54.1666250080579;
        Thu, 20 Oct 2022 00:14:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b0018157b415dbsm12094679plx.63.2022.10.20.00.14.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 00:14:40 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] power: supply: rt9471: Add Richtek RT9759 smart cap divider charger
Date:   Thu, 20 Oct 2022 15:14:20 +0800
Message-Id: <1666250061-18686-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
References: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add support for RT9759 smart cap divider charger.

The RT9759 is a high efficiency and high charge current charger. The
maximum charge current is up to 8A. It integrates a dual-phase charge
pump core with ADC monitoring.

Co-developed-by: Allen Chiang <allen_chiang@richtek.com>
Signed-off-by: Allen Chiang <allen_chiang@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/power/supply/Kconfig  |  15 ++
 drivers/power/supply/Makefile |   1 +
 drivers/power/supply/rt9759.c | 611 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 627 insertions(+)
 create mode 100644 drivers/power/supply/rt9759.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0bbfe6a..2f24f29 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -785,6 +785,21 @@ config BATTERY_RT5033
 	  The fuelgauge calculates and determines the battery state of charge
 	  according to battery open circuit voltage.
 
+config CHARGER_RT9759
+	tristate "Richtek RT9759 smart cap divider charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	select LINEAR_RANGES
+	help
+	  This adds support for Richtek RT9759 smart cap divider charger driver.
+	  It's a high efficiency and high charge current charger. the device
+	  integrates smart cap divider topology with 9-channel high speed
+	  ADCs that can provide input and output voltage, current and
+	  temperature monitoring.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called rt9759.
+
 config CHARGER_RT9455
 	tristate "Richtek RT9455 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 0ee8653..b872c06 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
+obj-$(CONFIG_CHARGER_RT9759)	+= rt9759.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
diff --git a/drivers/power/supply/rt9759.c b/drivers/power/supply/rt9759.c
new file mode 100644
index 00000000..95f2142f
--- /dev/null
+++ b/drivers/power/supply/rt9759.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Authors: Allen Chiang <allen_chiang@richtek.com>
+ *          ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/linear_range.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/util_macros.h>
+
+#define RT9759_REG_VBATOVP	0x00
+#define RT9759_REG_IBATOCP	0x02
+#define RT9759_REG_VBUSOVP	0x06
+#define RT9759_REG_IBUSOCPUCP	0x08
+#define RT9759_REG_CONVST	0x0A
+#define RT9759_REG_CHGCTL0	0x0B
+#define RT9759_REG_CHGCTL1	0x0C
+#define RT9759_REG_FLTFLAG	0x11
+#define RT9759_REG_DEVINFO	0x13
+#define RT9759_REG_ADCCTL	0x14
+#define RT9759_REG_IBUSADC	0x16
+#define RT9759_REG_REGCTL	0x2B
+#define RT9759_REG_OTHER4	0x33
+
+#define RT9759_VBUSUCP_MASK	BIT(4)
+#define RT9759_TDIEOTP_MASK	BIT(7)
+#define RT9759_WDT_MASK		BIT(3)
+#define RT9759_BUSBATOVP_MASK	(BIT(7) | BIT(5))
+#define RT9759_BUSBATOCP_MASK	(BIT(6) | BIT(4))
+#define RT9759_ADCEN_MASK	BIT(7)
+#define RT9759_ADCONCE_MASK	BIT(6)
+
+#define RT9759_DEVID		0x08
+#define RT9759_ADC_CONVTIME	2000
+#define RT9759_ADC_MAXWAIT	16000
+
+enum rt9759_adc_chan {
+	ADC_IBUS = 0,
+	ADC_VBUS,
+	ADC_VAC,
+	ADC_VOUT,
+	ADC_VBAT,
+	ADC_IBAT,
+	ADC_TSBUS,
+	ADC_TSBAT,
+	ADC_TDIE,
+	ADC_MAX_CHANNEL
+};
+
+enum rt9759_fields {
+	F_VBATOVP = 0,
+	F_IBATOCP,
+	F_VBUSOVP,
+	F_IBUSOCP,
+	F_SWITCHING,
+	F_REG_RST,
+	F_WDT_DIS,
+	F_WDT_TMR,
+	F_CHG_EN,
+	F_DEV_ID,
+	F_ADC_EN,
+	F_IBAT_RSEN,
+	F_MAX_FIELD
+};
+
+enum rt9759_ranges {
+	R_VBATOVP = 0,
+	R_IBATOCP,
+	R_VACOVP,
+	R_VBUSOVP,
+	R_IBUSOCP,
+	R_MAX_RANGE
+};
+
+static const struct reg_field rt9759_chg_fields[F_MAX_FIELD] = {
+	[F_VBATOVP]	= REG_FIELD(RT9759_REG_VBATOVP, 0, 5),
+	[F_IBATOCP]	= REG_FIELD(RT9759_REG_IBATOCP, 0, 6),
+	[F_VBUSOVP]	= REG_FIELD(RT9759_REG_VBUSOVP, 0, 6),
+	[F_IBUSOCP]	= REG_FIELD(RT9759_REG_IBUSOCPUCP, 0, 3),
+	[F_SWITCHING]	= REG_FIELD(RT9759_REG_CONVST, 2, 2),
+	[F_REG_RST]	= REG_FIELD(RT9759_REG_CHGCTL0, 7, 7),
+	[F_WDT_DIS]	= REG_FIELD(RT9759_REG_CHGCTL0, 2, 2),
+	[F_WDT_TMR]	= REG_FIELD(RT9759_REG_CHGCTL0, 0, 1),
+	[F_CHG_EN]	= REG_FIELD(RT9759_REG_CHGCTL1, 7, 7),
+	[F_DEV_ID]	= REG_FIELD(RT9759_REG_DEVINFO, 0, 3),
+	[F_ADC_EN]	= REG_FIELD(RT9759_REG_ADCCTL, 7, 7),
+	[F_IBAT_RSEN]	= REG_FIELD(RT9759_REG_REGCTL, 1, 1),
+};
+
+/* All converted to microvolt or microamp */
+static const struct linear_range rt9759_chg_ranges[R_MAX_RANGE] = {
+	LINEAR_RANGE_IDX(R_VBATOVP, 3500000, 0, 63, 25000),
+	LINEAR_RANGE_IDX(R_IBATOCP, 2000000, 0, 80, 100000),
+	LINEAR_RANGE_IDX(R_VBUSOVP, 6000000, 0, 127, 50000),
+	LINEAR_RANGE_IDX(R_IBUSOCP, 1000000, 0, 15, 250000),
+};
+
+struct charger_event {
+	unsigned int ucp_flag;
+	unsigned int conv_flag;
+	unsigned int wdt_flag;
+	unsigned int flt_flag;
+};
+
+struct rt9759_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_field *rm_fields[F_MAX_FIELD];
+	struct power_supply *psy;
+	struct mutex adc_lock;
+	struct power_supply_desc psy_desc;
+	struct charger_event chg_evt;
+	unsigned int rg_resistor;
+	unsigned int real_resistor;
+};
+
+static int rt9759_get_value_by_field_range(struct rt9759_data *data,
+					   enum rt9759_fields field,
+					   enum rt9759_ranges rsel, int *val)
+{
+	const struct linear_range *range = rt9759_chg_ranges + rsel;
+	unsigned int sel;
+	int ret;
+
+	ret = regmap_field_read(data->rm_fields[field], &sel);
+	if (ret)
+		return ret;
+
+	return linear_range_get_value(range, sel, val);
+}
+
+static int rt9759_set_value_by_field_range(struct rt9759_data *data,
+					   enum rt9759_fields field,
+					   enum rt9759_ranges rsel, int val)
+{
+	const struct linear_range *range = rt9759_chg_ranges + rsel;
+	unsigned int sel;
+
+	linear_range_get_selector_within(range, val, &sel);
+	return regmap_field_write(data->rm_fields[field], sel);
+}
+
+static int rt9759_get_adc(struct rt9759_data *data, enum rt9759_adc_chan chan,
+			  int *val)
+{
+	struct regmap *regmap = data->regmap;
+	unsigned int reg_addr = RT9759_REG_IBUSADC + chan * 2;
+	unsigned int mask = RT9759_ADCEN_MASK | RT9759_ADCONCE_MASK;
+	unsigned int adc_cntl;
+	__be16 raws;
+	int scale, ret;
+
+	mutex_lock(&data->adc_lock);
+
+	ret = regmap_update_bits(regmap, RT9759_REG_ADCCTL, mask, mask);
+	if (ret)
+		goto adc_unlock;
+
+	ret = regmap_read_poll_timeout(regmap, RT9759_REG_ADCCTL, adc_cntl,
+				       !(adc_cntl & RT9759_ADCEN_MASK),
+				       RT9759_ADC_CONVTIME, RT9759_ADC_MAXWAIT);
+	if (ret && ret != -ETIMEDOUT)
+		goto adc_unlock;
+
+	ret = regmap_raw_read(regmap, reg_addr, &raws, sizeof(raws));
+	if (ret)
+		goto adc_unlock;
+
+	/*
+	 * TDIE LSB 0.5'c, others LSB 1000uV or 1000uA.
+	 * Rsense ratio is needed for IBAT channel
+	 */
+	if (chan == ADC_TDIE)
+		scale = 5;
+	else if (chan == ADC_IBAT)
+		scale = 1000 * data->rg_resistor / data->real_resistor;
+	else
+		scale = 1000;
+
+
+	*val = be16_to_cpu(raws) * scale;
+
+adc_unlock:
+	regmap_update_bits(regmap, RT9759_REG_ADCCTL, mask, 0);
+
+	mutex_unlock(&data->adc_lock);
+
+	return ret;
+}
+
+static int rt9759_get_switching_state(struct rt9759_data *data, int *status)
+{
+	unsigned int switching_state;
+	int ret;
+
+	ret = regmap_field_read(data->rm_fields[F_SWITCHING], &switching_state);
+	if (ret)
+		return ret;
+
+	if (switching_state)
+		*status = POWER_SUPPLY_STATUS_CHARGING;
+	else
+		*status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	return 0;
+}
+
+static int rt9759_get_charger_health(struct rt9759_data *data)
+{
+	struct charger_event *evt = &data->chg_evt;
+
+	if (evt->ucp_flag & RT9759_VBUSUCP_MASK)
+		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+
+	if (evt->conv_flag & RT9759_TDIEOTP_MASK)
+		return POWER_SUPPLY_HEALTH_OVERHEAT;
+
+	if (evt->wdt_flag & RT9759_WDT_MASK)
+		return POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
+
+	if (evt->flt_flag & RT9759_BUSBATOVP_MASK)
+		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+
+	if (evt->flt_flag & RT9759_BUSBATOCP_MASK)
+		return POWER_SUPPLY_HEALTH_OVERCURRENT;
+
+	return POWER_SUPPLY_HEALTH_GOOD;
+}
+
+static const char * const rt9759_manufacturer	= "Richtek Technology Corp.";
+static const char * const rt9759_model		= "RT9759";
+
+static int rt9759_psy_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	int *pval = &val->intval;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return rt9759_get_switching_state(data, pval);
+	case POWER_SUPPLY_PROP_HEALTH:
+		*pval = rt9759_get_charger_health(data);
+		return 0;
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_field_read(data->rm_fields[F_CHG_EN], pval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return rt9759_get_value_by_field_range(data, F_VBUSOVP, R_VBUSOVP, pval);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return rt9759_get_adc(data, ADC_VBUS, pval);
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return rt9759_get_value_by_field_range(data, F_IBUSOCP, R_IBUSOCP, pval);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return rt9759_get_adc(data, ADC_IBUS, pval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return rt9759_get_value_by_field_range(data, F_VBATOVP, R_VBATOVP, pval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return rt9759_get_value_by_field_range(data, F_IBATOCP, R_IBATOCP, pval);
+	case POWER_SUPPLY_PROP_TEMP:
+		return rt9759_get_adc(data, ADC_TDIE, pval);
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = rt9759_model;
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = rt9759_manufacturer;
+		return 0;
+	default:
+		return -ENODATA;
+	}
+}
+
+static int rt9759_psy_set_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	int intval = val->intval;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		/* Before enabled, clear stored event */
+		if (intval)
+			memset(&data->chg_evt, 0, sizeof(data->chg_evt));
+
+		return regmap_field_write(data->rm_fields[F_CHG_EN], !!intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return rt9759_set_value_by_field_range(data, F_VBUSOVP, R_VBUSOVP, intval);
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return rt9759_set_value_by_field_range(data, F_IBUSOCP, R_IBUSOCP, intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return rt9759_set_value_by_field_range(data, F_VBATOVP, R_VBATOVP, intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return rt9759_set_value_by_field_range(data, F_IBATOCP, R_IBATOCP, intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const enum power_supply_property rt9759_psy_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int rt9759_psy_property_is_writeable(struct power_supply *psy,
+					    enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static const unsigned int rt9759_wdt_millisecond[] = { 500, 1000, 5000, 30000 };
+
+static ssize_t watchdog_timer_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	unsigned int wdt_tmr_now = 0, wdt_sel, wdt_dis;
+	int ret;
+
+	ret = regmap_field_read(data->rm_fields[F_WDT_DIS], &wdt_dis);
+	if (ret)
+		return ret;
+
+	if (!wdt_dis) {
+		ret = regmap_field_read(data->rm_fields[F_WDT_TMR], &wdt_sel);
+		if (ret)
+			return ret;
+
+		wdt_tmr_now = rt9759_wdt_millisecond[wdt_sel];
+	}
+
+	return sysfs_emit(buf, "%d\n", wdt_tmr_now);
+}
+
+static ssize_t watchdog_timer_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	unsigned int wdt_set, wdt_sel;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &wdt_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(data->rm_fields[F_WDT_DIS], 1);
+	if (ret)
+		return ret;
+
+	wdt_sel = find_closest(wdt_set, rt9759_wdt_millisecond,
+			       ARRAY_SIZE(rt9759_wdt_millisecond));
+
+	ret = regmap_field_write(data->rm_fields[F_WDT_TMR], wdt_sel);
+	if (ret)
+		return ret;
+
+	if (wdt_set) {
+		ret = regmap_field_write(data->rm_fields[F_WDT_DIS], 0);
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+
+static ssize_t battery_voltage_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	int vbat_now, ret;
+
+	ret = rt9759_get_adc(data, ADC_VBAT, &vbat_now);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", vbat_now);
+}
+
+static ssize_t battery_current_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct rt9759_data *data = power_supply_get_drvdata(psy);
+	int ibat_now, ret;
+
+	ret = rt9759_get_adc(data, ADC_IBAT, &ibat_now);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", ibat_now);
+}
+
+static DEVICE_ATTR_RW(watchdog_timer);
+static DEVICE_ATTR_RO(battery_voltage);
+static DEVICE_ATTR_RO(battery_current);
+
+static struct attribute *rt9759_sysfs_attrs[] = {
+	&dev_attr_watchdog_timer.attr,
+	&dev_attr_battery_voltage.attr,
+	&dev_attr_battery_current.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(rt9759_sysfs);
+
+static int rt9759_register_psy(struct rt9759_data *data)
+{
+	struct device *dev = data->dev;
+	struct power_supply_desc *desc = &data->psy_desc;
+	struct power_supply_config cfg = {};
+	char *psy_name;
+
+	cfg.drv_data = data;
+	cfg.of_node = dev->of_node;
+	cfg.attr_grp = rt9759_sysfs_groups;
+
+	psy_name = devm_kasprintf(dev, GFP_KERNEL, "rt9759-%s", dev_name(dev));
+	if (!psy_name)
+		return -ENOMEM;
+
+	desc->name = psy_name;
+	desc->type = POWER_SUPPLY_TYPE_USB;
+	desc->properties = rt9759_psy_properties;
+	desc->num_properties = ARRAY_SIZE(rt9759_psy_properties);
+	desc->property_is_writeable = rt9759_psy_property_is_writeable;
+	desc->get_property = rt9759_psy_get_property;
+	desc->set_property = rt9759_psy_set_property;
+
+	data->psy = devm_power_supply_register(dev, desc, &cfg);
+
+	return PTR_ERR_OR_ZERO(data->psy);
+}
+
+static irqreturn_t rt9759_irq_handler(int irq, void *devid)
+{
+	struct rt9759_data *data = devid;
+	struct regmap *regmap = data->regmap;
+	struct charger_event *evt = &data->chg_evt;
+	int ret;
+
+	ret = regmap_read(regmap, RT9759_REG_IBUSOCPUCP, &evt->ucp_flag);
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_read(regmap, RT9759_REG_CONVST, &evt->conv_flag);
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_read(regmap, RT9759_REG_CHGCTL0, &evt->wdt_flag);
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_read(regmap, RT9759_REG_FLTFLAG, &evt->flt_flag);
+	if (ret)
+		return IRQ_NONE;
+
+	power_supply_changed(data->psy);
+
+	return IRQ_HANDLED;
+}
+
+static int rt9759_config_batsense_resistor(struct rt9759_data *data)
+{
+	unsigned int shunt_resistor_uohms = 2000, rsense_sel;
+
+	device_property_read_u32(data->dev, "shunt-resistor-micro-ohms",
+				 &shunt_resistor_uohms);
+
+	if (!shunt_resistor_uohms || shunt_resistor_uohms > 5000)
+		return -EINVAL;
+
+	data->real_resistor = shunt_resistor_uohms;
+
+	if (shunt_resistor_uohms <= 2000) {
+		rsense_sel = 0;
+		data->rg_resistor = 2000;
+	} else {
+		rsense_sel = 1;
+		data->rg_resistor = 5000;
+	}
+
+	return regmap_field_write(data->rm_fields[F_IBAT_RSEN], rsense_sel);
+}
+
+static const struct reg_sequence rt9759_init_regs[] = {
+	REG_SEQ(0x0B, 0x80, 1000), /* REG_RESET */
+	REG_SEQ0(0x05, 0x00), /* VAC_OVP = 11V */
+	REG_SEQ0(0x0B, 0x44), /* WDT_DIS = 1 */
+	REG_SEQ0(0x0C, 0x06), /* TSBUS/TSBAT OTP_DIS = 1 */
+	REG_SEQ0(0x0F, 0xF9), /* DIS ALARM & ADC_DONE */
+	REG_SEQ0(0x14, 0x00), /* IBUS_ADC_DIS = 0 */
+};
+
+static const struct regmap_config rt9759_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT9759_REG_OTHER4,
+};
+
+static int rt9759_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct rt9759_data *data;
+	struct regmap *regmap;
+	unsigned int devid;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	mutex_init(&data->adc_lock);
+	i2c_set_clientdata(i2c, data);
+
+	regmap = devm_regmap_init_i2c(i2c, &rt9759_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	data->regmap = regmap;
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, data->rm_fields,
+					   rt9759_chg_fields,
+					   ARRAY_SIZE(rt9759_chg_fields));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to alloc regmap fields\n");
+
+	ret = regmap_field_read(data->rm_fields[F_DEV_ID], &devid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Filaed to read devid\n");
+
+	if (devid != RT9759_DEVID)
+		return dev_err_probe(dev, -ENODEV, "Incorrect VID 0x%02x\n", devid);
+
+	ret = regmap_register_patch(regmap, rt9759_init_regs,
+				    ARRAY_SIZE(rt9759_init_regs));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init registers\n");
+
+	ret = rt9759_config_batsense_resistor(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to config batsense resistor\n");
+
+	ret = rt9759_register_psy(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init power supply\n");
+
+	return devm_request_threaded_irq(dev, i2c->irq, NULL, rt9759_irq_handler,
+					 IRQF_ONESHOT, dev_name(dev), data);
+}
+
+static void rt9759_shutdown(struct i2c_client *i2c)
+{
+	struct rt9759_data *data = i2c_get_clientdata(i2c);
+
+	regmap_field_write(data->rm_fields[F_REG_RST], 1);
+}
+
+static const struct of_device_id rt9759_device_match_table[] = {
+	{ .compatible = "richtek,rt9759" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt9759_device_match_table);
+
+static struct i2c_driver rt9759_charger_driver = {
+	.driver = {
+		.name = "rt9759",
+		.of_match_table = rt9759_device_match_table,
+	},
+	.probe_new = rt9759_probe,
+	.shutdown = rt9759_shutdown,
+};
+module_i2c_driver(rt9759_charger_driver);
+
+MODULE_DESCRIPTION("Richtek RT9759 charger driver");
+MODULE_AUTHOR("Allen Chiang <allen_chiang@richtek.com>");
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

