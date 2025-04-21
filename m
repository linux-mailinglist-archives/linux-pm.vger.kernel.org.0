Return-Path: <linux-pm+bounces-25811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2FA955C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528EB16E737
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1ED1E990B;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSQpJ7A3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2B1E5B99;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259233; cv=none; b=QpJ2nzsjst7RzeFbd+tuI4Czj3Wuw2l/yjTUKbBaxS2d44OhxZzSjTikzgje9+LE4ajrG5v5MPy3qPfMM3yK6ZxfbZovVQb5OxQCH+tN7U4JyJolooDNxR44OEROuq/FJWNV0cRWh1WKfPI+ucNbFGMbqnD5pubI22EJPedNuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259233; c=relaxed/simple;
	bh=wQyUeSMEJH3kxxBnB719wTNt8wGUOd00qdhNudybJVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLFCJk2GjKliKqf1aWugqOTw5jmYX6Hit2SSGR06sQbGcJfKGTAay9v2Cxpts4xIF4qeqE/AKXp68nBBHjsiDD656nA2pj53S9xy88Sb6techXMB88MKYCTr88c1snWRpb8cBylJXhGzkFbuKgErIjTJq7iaOVnodq1gKxL+e1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSQpJ7A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CA89C4AF0C;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259232;
	bh=wQyUeSMEJH3kxxBnB719wTNt8wGUOd00qdhNudybJVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HSQpJ7A3+w/MZXqTxnu/G225UdqIKtvbNE82PK21uUHOjlxsdm7fttrqJVQXJW1Ss
	 eJFPnahHuXffdaZV1mjwzAwPLJj40gqRYNCF2gJjAR93oWXEAUorhsRGNKVxMBQYXO
	 HZiTtGm8s32iclV1CICPqTMrY0odlaSqYDITsXPdOfr32tFT+4iErVTocZs6A3in6/
	 zIKyj0+UkaiRDEan8wL9Yu0/nV4BlzNirVw0+NNdmZGMYKdIKDJPwwZSWm2tdMcGOe
	 7GXZzxZrREwN4bVpbMaq27POB9KKvbnnE1WOuzGotko0+2uwW9yvU+1fqRF6RRw86v
	 s2OYpWQ75ZkCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8BC369D7;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 21 Apr 2025 20:13:33 +0200
Subject: [PATCH v3 2/5] power: supply: add support for max77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-b4-gs101_max77759_fg-v3-2-50cd8caf9017@uclouvain.be>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
To: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745259219; l=14313;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=ZbjNDwSRJFEoYuWbXrVTfeLtbZ5Ur0LIUfGXzuDBmv8=;
 b=tuTXi5j9wW62WtK/AN7rdXeNwkj/KbvJn0+/ufudihjw8p5z1B4o/rzXOPoGfY+EnlnwtwWfi
 RsyuHKiYll4BoD79HJDp8o+tJj9W6auIPU94lfAhA/MwabYyJGTYpsy
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

The interface of the Maxim MAX77759 fuel gauge has a lot of common with the
Maxim MAX1720x. A major difference is the lack of non-volatile memory
slave address. No slave is available at address 0xb of the i2c bus, which
is coherent with the following driver from google: line 5836 disables
non-volatile memory for m5 gauge.

Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c

Other differences include the lack of V_BATT register to read the battery
level. The voltage must instead be read from V_CELL, the lowest voltage of
all cells. The mask to identify the chip is different. The computation of
the charge must also be changed to take into account TASKPERIOD, which
can add a factor 2 to the result.

Add support for the MAX77759 by taking into account all of those
differences based on chip type.

Do not advertise temp probes using the non-volatile memory as those are
not available.

The regmap was proposed by André Draszik in

Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 drivers/power/supply/max1720x_battery.c | 270 ++++++++++++++++++++++++++++----
 1 file changed, 237 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index cca5f8b5071fb731f9b60420239ea03d46cb1bf3..969d3a7c2baa7e1d23c5175942d975b277c8554c 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -37,6 +37,7 @@
 #define MAX172XX_REPCAP			0x05	/* Average capacity */
 #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
 #define MAX172XX_TEMP			0x08	/* Temperature */
+#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
 #define MAX172XX_CURRENT		0x0A	/* Actual current */
 #define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
 #define MAX172XX_FULL_CAP		0x10	/* Calculated full capacity */
@@ -50,19 +51,32 @@
 #define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
 #define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
 #define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
+#define MAX77759_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
+#define MAX77759_DEV_NAME_TYPE_MAX77759	0x31
 #define MAX172XX_QR_TABLE10		0x22
+#define MAX77759_TASKPERIOD		0x3C
+#define MAX77759_TASKPERIOD_175MS	0x1680
+#define MAX77759_TASKPERIOD_351MS	0x2D00
 #define MAX172XX_BATT			0xDA	/* Battery voltage */
 #define MAX172XX_ATAVCAP		0xDF
 
 static const char *const max1720x_manufacturer = "Maxim Integrated";
 static const char *const max17201_model = "MAX17201";
 static const char *const max17205_model = "MAX17205";
+static const char *const max77759_model = "MAX77759";
+
+enum chip_id {
+	MAX1720X_ID,
+	MAX77759_ID,
+};
 
 struct max1720x_device_info {
 	struct regmap *regmap;
 	struct regmap *regmap_nv;
 	struct i2c_client *ancillary;
 	int rsense;
+	int charge_full_design;
+	enum chip_id id;
 };
 
 /*
@@ -271,6 +285,80 @@ static const enum power_supply_property max1720x_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+/*
+ * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
+ * algorithm (stored in nvmem for the max1720x) are locked. They can
+ * be unlocked by writing 0x59 to 0x62 and 0xc4 to 0x63. They should be
+ * enabled in the regmap if the driver is extended to manage the model.
+ */
+static const struct regmap_range max77759_registers[] = {
+	regmap_reg_range(0x00, 0x4f),
+	regmap_reg_range(0xb0, 0xbf),
+	regmap_reg_range(0xd0, 0xd0),
+	regmap_reg_range(0xdc, 0xdf),
+	regmap_reg_range(0xfb, 0xfb),
+	regmap_reg_range(0xff, 0xff),
+};
+
+static const struct regmap_range max77759_ro_registers[] = {
+	regmap_reg_range(0x3d, 0x3d),
+	regmap_reg_range(0xfb, 0xfb),
+	regmap_reg_range(0xff, 0xff),
+};
+
+static const struct regmap_access_table max77759_write_table = {
+	.no_ranges = max77759_ro_registers,
+	.n_no_ranges = ARRAY_SIZE(max77759_ro_registers),
+};
+
+static const struct regmap_access_table max77759_rd_table = {
+	.yes_ranges = max77759_registers,
+	.n_yes_ranges = ARRAY_SIZE(max77759_registers),
+};
+
+static const struct regmap_config max77759_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+	.wr_table = &max77759_write_table,
+	.rd_table = &max77759_rd_table,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const enum power_supply_property max77759_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_AVG,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+
+struct chip_data {
+	bool has_nvmem;
+	const struct regmap_config *regmap_cfg;
+	enum chip_id id;
+};
+
+static const struct chip_data max1720x_data  = {
+	.has_nvmem = true,
+	.regmap_cfg = &max1720x_regmap_cfg,
+	.id = MAX1720X_ID,
+};
+
+static const struct chip_data max77759_data = {
+	.has_nvmem = false,
+	.regmap_cfg = &max77759_regmap_cfg,
+	.id = MAX77759_ID,
+};
+
 /* Convert regs value to power_supply units */
 
 static int max172xx_time_to_ps(unsigned int reg)
@@ -288,10 +376,36 @@ static int max172xx_voltage_to_ps(unsigned int reg)
 	return reg * 1250;	/* in uV */
 }
 
+static int max172xx_cell_voltage_to_ps(unsigned int reg)
+{
+	return reg * 625 / 8;	/* in uV */
+}
+
 static int max172xx_capacity_to_ps(unsigned int reg,
-				   struct max1720x_device_info *info)
+				   struct max1720x_device_info *info,
+				   int *intval)
 {
-	return reg * (500000 / info->rsense);	/* in uAh */
+	int lsb = 1;
+	int reg_val;
+	int ret;
+
+	if (info->id == MAX77759_ID) {
+		ret = regmap_read(info->regmap, MAX77759_TASKPERIOD, &reg_val);
+		if (ret)
+			return ret;
+
+		switch (reg_val) {
+		case MAX77759_TASKPERIOD_175MS:
+			break;
+		case MAX77759_TASKPERIOD_351MS:
+			lsb = 2;
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
+	*intval = reg * (500000 / info->rsense) * lsb;	/* in uAh */
+	return 0;
 }
 
 /*
@@ -306,6 +420,28 @@ static int max172xx_temperature_to_ps(unsigned int reg)
 	return val * 10 / 256; /* in tenths of deg. C */
 }
 
+static const char *max1720x_devname_to_model(unsigned int reg_val,
+					     union power_supply_propval *val,
+					     struct max1720x_device_info *info)
+{
+	switch (info->id) {
+	case MAX1720X_ID:
+		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
+		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
+			return max17201_model;
+		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
+			return max17205_model;
+		return NULL;
+	case MAX77759_ID:
+		reg_val = FIELD_GET(MAX77759_DEV_NAME_TYPE_MASK, reg_val);
+		if (reg_val == MAX77759_DEV_NAME_TYPE_MAX77759)
+			return max77759_model;
+		return NULL;
+	default:
+		return NULL;
+	}
+}
+
 /*
  * Calculating current registers resolution:
  *
@@ -390,19 +526,31 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		val->intval = max172xx_percent_to_ps(reg_val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
-		val->intval = max172xx_voltage_to_ps(reg_val);
+		if (info->id == MAX1720X_ID) {
+			ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
+			val->intval = max172xx_voltage_to_ps(reg_val);
+		} else if (info->id == MAX77759_ID) {
+			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
+			val->intval = max172xx_cell_voltage_to_ps(reg_val);
+		} else
+			return -ENODEV;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		if (ret)
+			break;
+		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_AVG:
 		ret = regmap_read(info->regmap, MAX172XX_REPCAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		if (ret)
+			break;
+
+		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		ret = regmap_read(info->regmap, MAX172XX_TTE, &reg_val);
+		pr_info("RAW TTE: %d", reg_val);
 		val->intval = max172xx_time_to_ps(reg_val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
@@ -423,17 +571,15 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(info->regmap, MAX172XX_FULL_CAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		if (ret)
+			break;
+		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
-		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
-		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
-			val->strval = max17201_model;
-		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
-			val->strval = max17205_model;
-		else
-			return -ENODEV;
+		val->strval = max1720x_devname_to_model(reg_val, val, info);
+		if (!val->strval)
+			ret = -ENODEV;
 		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = max1720x_manufacturer;
@@ -527,7 +673,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
 		.priv = info,
 	};
 	struct nvmem_device *nvmem;
-	unsigned int val;
 	int ret;
 
 	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
@@ -549,18 +694,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
 		return PTR_ERR(info->regmap_nv);
 	}
 
-	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
-	if (ret < 0) {
-		dev_err(dev, "Failed to read sense resistor value\n");
-		return ret;
-	}
-
-	info->rsense = val;
-	if (!info->rsense) {
-		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
-		info->rsense = 1000; /* in regs in 10^-5 */
-	}
-
 	nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(nvmem)) {
 		dev_err(dev, "Could not register nvmem!");
@@ -570,6 +703,38 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
 	return 0;
 }
 
+static int max1720x_get_rsense(struct device *dev,
+			       struct max1720x_device_info *info,
+			       const struct chip_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	if (data->has_nvmem) {
+		ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
+		if (ret < 0) {
+			dev_err(dev, "Failed to read RSense from nvmem\n");
+			return ret;
+		}
+
+		info->rsense = val;
+		if (!info->rsense) {
+			dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
+			info->rsense = 1000; /* in regs in 10^-5 */
+		}
+	} else {
+		ret = of_property_read_u32(dev->of_node,
+					   "shunt-resistor-micro-ohms", &val);
+		if (ret) {
+			dev_err(dev, "Failed to read RSense from devicetree\n");
+			return ret;
+		}
+		info->rsense = val/10;
+	}
+
+	return 0;
+}
+
 static const struct power_supply_desc max1720x_bat_desc = {
 	.name = "max1720x",
 	.no_thermal = true,
@@ -579,32 +744,70 @@ static const struct power_supply_desc max1720x_bat_desc = {
 	.get_property = max1720x_battery_get_property,
 };
 
+static const struct power_supply_desc max77759_bat_desc = {
+	.name = "max77759-fg",
+	.no_thermal = true,
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max77759_battery_props,
+	.num_properties = ARRAY_SIZE(max77759_battery_props),
+	.get_property = max1720x_battery_get_property,
+};
+
 static int max1720x_probe(struct i2c_client *client)
 {
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &client->dev;
 	struct max1720x_device_info *info;
 	struct power_supply *bat;
+	const struct chip_data *data;
+	const struct power_supply_desc *bat_desc;
 	int ret;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
+
 	psy_cfg.drv_data = info;
 	psy_cfg.fwnode = dev_fwnode(dev);
-	psy_cfg.attr_grp = max1720x_groups;
+	switch (data->id) {
+	case MAX1720X_ID:
+		psy_cfg.attr_grp = max1720x_groups;
+		bat_desc = &max1720x_bat_desc;
+		break;
+	case MAX77759_ID:
+		bat_desc = &max77759_bat_desc;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unsupported chip\n");
+	}
 	i2c_set_clientdata(client, info);
-	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
+
+	info->id = data->id;
+	info->regmap = devm_regmap_init_i2c(client, data->regmap_cfg);
 	if (IS_ERR(info->regmap))
 		return dev_err_probe(dev, PTR_ERR(info->regmap),
 				     "regmap initialization failed\n");
 
-	ret = max1720x_probe_nvmem(client, info);
+	if (data->has_nvmem) {
+		ret = max1720x_probe_nvmem(client, info);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
+	}
+
+	ret = of_property_read_u32(dev->of_node,
+				   "charge-full-design-microamp-hours", &info->charge_full_design);
+	if (ret)
+		info->charge_full_design = 0;
+
+	ret = max1720x_get_rsense(dev, info, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
+		return dev_err_probe(dev, ret, "Failed to get RSense\n");
 
-	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
+	bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
 	if (IS_ERR(bat))
 		return dev_err_probe(dev, PTR_ERR(bat),
 				     "Failed to register power supply\n");
@@ -613,7 +816,8 @@ static int max1720x_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id max1720x_of_match[] = {
-	{ .compatible = "maxim,max17201" },
+	{ .compatible = "maxim,max17201", .data = (void *) &max1720x_data },
+	{ .compatible = "maxim,max77759-fg", .data = (void *) &max77759_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, max1720x_of_match);

-- 
2.49.0



