Return-Path: <linux-pm+bounces-16507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27F9B1A7C
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 21:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844A31F21B18
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A91762E0;
	Sat, 26 Oct 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ZfAGugBp"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790616EB76;
	Sat, 26 Oct 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729969234; cv=none; b=VzciwMChgWDz4X9FW6m4DcdGl1aoJjNtEf/zd+B7SFAvdbQtfPJdo8b6nfJLSFm2yepHOPqJw7+5gjbNoeJoogO8rd2FsOu3bC4N4vyYlwtf3F38oFi2iM6QlPVh+ZgxFBC2oF54Px69o760/qx8yOH8kwaDajqk65nGxQDhcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729969234; c=relaxed/simple;
	bh=FecHnuIOicozgGT/J440daLU0wJlBUCYrCyiyTi+WgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ue1yIU0/7m77r1Se54k0hyA9k7XZizV2LFZtoV/MQrnGlK8FROa4l/Sxc4JABlyoV3/QLoL1VTwZixf55MQAuLIz5RjVCkMWbzkCyeaRPKjiHJJ/ZzIjLEm8mZUb1y7r4XK/2diRjQiXdq3pY4Y9Upus8GCLgr86SuV/b52Jc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ZfAGugBp; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D316EA0D5F;
	Sat, 26 Oct 2024 21:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=CfHYg/IZXgqtNshpWZamUX0OubvH1BvT1Tr7tHHxcBQ=; b=
	ZfAGugBpGXn4Ylleu664o2sHHVQ/hK0s4JrDHZXADokAouMB43JALzrouPMzwyD+
	lVmCF8c2dfKCdadkrWhsacMjsm44u1CJCjTa8HQl5mzwUqgHEzlCZU2bhd7O/qLI
	XiQgTeA88gdVr/Up25OFoeDof8v+8JuJi8eLA6Bx1psNvy++1ApH+VDivdf8laNH
	A9kPME/a/u/3r3n05UhspJL8EWq/N7MBBVGBK4Nc/a2plOAYLuaRc7JLy0mQDmwi
	dnY4uo3/UWCGpDy6hLo3FUMtUhP6EtH2rHGqhRyQMKP+CzCT6pPXfj+1KNpYuU0j
	7DLAtXutvrcvCmYpPBmd6X2IUz+oiDfIoYUf0amI8H25EyMzXD53VNK/86t8I7Jz
	eedm8ngSArPDLTl5DUAg85U5Jt7QBRh1+5LGhlJQ/jf8wnkcGA5QRIGX6i4CxMGz
	n3ZOLGBPF5IBxe4pOKkfHkSm3J0NklcVQhuwhsGwLw8qMgdIbTjD9ujhsLuC0hqG
	EIFAeOHetwbldzl7QYX0OB0nHNM7Vhfws620bk31o/qJlyS5UE2EpWAr6dhPueY2
	fZ2A3oLFPiK9fu+uZliCuAkyDzWX5sBA7ajFjQUFcDbrcKQhAhUwcuWKC4UKP3FC
	XcNTRQm/NLRlHOZodPkFed/GkBY8Y3RRpDRtb3vC8aQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] power: ip5xxx_power: Use regmap_field API
Date: Sat, 26 Oct 2024 20:59:29 +0200
Message-ID: <20241026185930.1777100-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729969214;VERSION=7978;MC=106367428;ID=170855;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677D67

The IP53xx series [1] has a much different register
layout than the 51xx/52xx [2] currently supported
by this driver. To accommodate supporting the former,
refactor the code to use the flexible regmap_field API.

[1] https://sharvielectronics.com/wp-content/uploads/2021/07/IP5306-I2C-registers.pdf
[2] https://www.windworkshop.cn/wp-content/uploads/2022/04/IP5209-IP5109-IP5207-IP5108-I2C-registers.pdf

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 445 ++++++++++++++++++----------
 1 file changed, 287 insertions(+), 158 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 82263646ddc6..5ef8562d798f 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -7,76 +7,132 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 
-#define IP5XXX_SYS_CTL0			0x01
-#define IP5XXX_SYS_CTL0_WLED_DET_EN		BIT(4)
-#define IP5XXX_SYS_CTL0_WLED_EN			BIT(3)
-#define IP5XXX_SYS_CTL0_BOOST_EN		BIT(2)
-#define IP5XXX_SYS_CTL0_CHARGER_EN		BIT(1)
-#define IP5XXX_SYS_CTL1			0x02
-#define IP5XXX_SYS_CTL1_LIGHT_SHDN_EN		BIT(1)
-#define IP5XXX_SYS_CTL1_LOAD_PWRUP_EN		BIT(0)
-#define IP5XXX_SYS_CTL2			0x0c
-#define IP5XXX_SYS_CTL2_LIGHT_SHDN_TH		GENMASK(7, 3)
-#define IP5XXX_SYS_CTL3			0x03
-#define IP5XXX_SYS_CTL3_LONG_PRESS_TIME_SEL	GENMASK(7, 6)
-#define IP5XXX_SYS_CTL3_BTN_SHDN_EN		BIT(5)
-#define IP5XXX_SYS_CTL4			0x04
-#define IP5XXX_SYS_CTL4_SHDN_TIME_SEL		GENMASK(7, 6)
-#define IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN	BIT(5)
-#define IP5XXX_SYS_CTL5			0x07
-#define IP5XXX_SYS_CTL5_NTC_DIS			BIT(6)
-#define IP5XXX_SYS_CTL5_WLED_MODE_SEL		BIT(1)
-#define IP5XXX_SYS_CTL5_BTN_SHDN_SEL		BIT(0)
-#define IP5XXX_CHG_CTL1			0x22
-#define IP5XXX_CHG_CTL1_BOOST_UVP_SEL		GENMASK(3, 2)
-#define IP5XXX_CHG_CTL2			0x24
-#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL		GENMASK(6, 5)
-#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V	(0x0 << 5)
-#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V	(0x1 << 5)
-#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V	(0x2 << 5)
-#define IP5XXX_CHG_CTL2_CONST_VOLT_SEL		GENMASK(2, 1)
-#define IP5XXX_CHG_CTL4			0x26
-#define IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN		BIT(6)
-#define IP5XXX_CHG_CTL4A		0x25
-#define IP5XXX_CHG_CTL4A_CONST_CUR_SEL		GENMASK(4, 0)
-#define IP5XXX_MFP_CTL0			0x51
-#define IP5XXX_MFP_CTL1			0x52
-#define IP5XXX_GPIO_CTL2		0x53
-#define IP5XXX_GPIO_CTL2A		0x54
-#define IP5XXX_GPIO_CTL3		0x55
-#define IP5XXX_READ0			0x71
-#define IP5XXX_READ0_CHG_STAT			GENMASK(7, 5)
-#define IP5XXX_READ0_CHG_STAT_IDLE		(0x0 << 5)
-#define IP5XXX_READ0_CHG_STAT_TRICKLE		(0x1 << 5)
-#define IP5XXX_READ0_CHG_STAT_CONST_VOLT	(0x2 << 5)
-#define IP5XXX_READ0_CHG_STAT_CONST_CUR		(0x3 << 5)
-#define IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP	(0x4 << 5)
-#define IP5XXX_READ0_CHG_STAT_FULL		(0x5 << 5)
-#define IP5XXX_READ0_CHG_STAT_TIMEOUT		(0x6 << 5)
-#define IP5XXX_READ0_CHG_OP			BIT(4)
-#define IP5XXX_READ0_CHG_END			BIT(3)
-#define IP5XXX_READ0_CONST_VOLT_TIMEOUT		BIT(2)
-#define IP5XXX_READ0_CHG_TIMEOUT		BIT(1)
-#define IP5XXX_READ0_TRICKLE_TIMEOUT		BIT(0)
-#define IP5XXX_READ0_TIMEOUT			GENMASK(2, 0)
-#define IP5XXX_READ1			0x72
-#define IP5XXX_READ1_WLED_PRESENT		BIT(7)
-#define IP5XXX_READ1_LIGHT_LOAD			BIT(6)
-#define IP5XXX_READ1_VIN_OVERVOLT		BIT(5)
-#define IP5XXX_READ2			0x77
-#define IP5XXX_READ2_BTN_PRESS			BIT(3)
-#define IP5XXX_READ2_BTN_LONG_PRESS		BIT(1)
-#define IP5XXX_READ2_BTN_SHORT_PRESS		BIT(0)
-#define IP5XXX_BATVADC_DAT0		0xa2
-#define IP5XXX_BATVADC_DAT1		0xa3
-#define IP5XXX_BATIADC_DAT0		0xa4
-#define IP5XXX_BATIADC_DAT1		0xa5
-#define IP5XXX_BATOCV_DAT0		0xa8
-#define IP5XXX_BATOCV_DAT1		0xa9
+#define IP5XXX_BAT_TYPE_4_2V			0x0
+#define IP5XXX_BAT_TYPE_4_3V			0x1
+#define IP5XXX_BAT_TYPE_4_35V			0x2
+#define IP5XXX_CHG_STAT_IDLE			0x0
+#define IP5XXX_CHG_STAT_TRICKLE		0x1
+#define IP5XXX_CHG_STAT_CONST_VOLT		0x2
+#define IP5XXX_CHG_STAT_CONST_CUR		0x3
+#define IP5XXX_CHG_STAT_CONST_VOLT_STOP	0x4
+#define IP5XXX_CHG_STAT_FULL			0x5
+#define IP5XXX_CHG_STAT_TIMEOUT		0x6
 
 struct ip5xxx {
 	struct regmap *regmap;
 	bool initialized;
+	struct {
+		struct {
+			/* Charger enable */
+			struct regmap_field *enable;
+			/* Constant voltage value */
+			struct regmap_field *const_volt_sel;
+			/* Constant current value */
+			struct regmap_field *const_curr_sel;
+			/* Charger status */
+			struct regmap_field *status;
+			/* Charging ended flag */
+			struct regmap_field *chg_end;
+			/* Timeout flags (CV, charge, trickle) */
+			struct regmap_field *timeout;
+			/* Overvoltage limit */
+			struct regmap_field *vin_overvolt;
+		} charger;
+		struct {
+			/* Boost converter enable */
+			struct regmap_field *enable;
+			struct {
+				/* Light load shutdown enable */
+				struct regmap_field *enable;
+				/* Light load shutdown current limit */
+				struct regmap_field *i_limit;
+			} light_load_shutdown;
+			/* Automatic powerup on increased load */
+			struct regmap_field *load_powerup_en;
+			/* Automatic powerup on VIN pull-out */
+			struct regmap_field *vin_pullout_en;
+			/* Undervoltage limit */
+			struct regmap_field *undervolt_limit;
+			/* Light load status flag */
+			struct regmap_field *light_load_status;
+		} boost;
+		struct {
+			/* NTC disable */
+			struct regmap_field *ntc_dis;
+			/* Battery voltage type */
+			struct regmap_field *type;
+			/* Battery voltage autoset from Vset pin */
+			struct regmap_field *vset_en;
+			struct {
+				/* Battery measurement registers */
+				struct ip5xxx_battery_adc_regs {
+					struct regmap_field *low;
+					struct regmap_field *high;
+				} volt, curr, open_volt;
+			} adc;
+		} battery;
+		struct {
+			/* Double/long press shutdown enable */
+			struct regmap_field *shdn_enable;
+			/* WLED activation: double press or long press */
+			struct regmap_field *wled_mode;
+			/* Shutdown activation: double press or long press */
+			struct regmap_field *shdn_mode;
+			/* Long press time */
+			struct regmap_field *long_press_time;
+			/* Button pressed */
+			struct regmap_field *pressed;
+			/* Button long-pressed */
+			struct regmap_field *long_pressed;
+			/* Button short-pressed */
+			struct regmap_field *short_pressed;
+		} btn;
+		struct {
+			/* WLED enable */
+			struct regmap_field *enable;
+			/* WLED detect */
+			struct regmap_field *detect_en;
+			/* WLED present */
+			struct regmap_field *present;
+		} wled;
+	} regs;
+};
+
+/* Register fields layout. Unsupported registers marked as { .lsb = 1 } */
+struct ip5xxx_regfield_config {
+	const struct reg_field charger_enable;
+	const struct reg_field charger_const_volt_sel;
+	const struct reg_field charger_const_curr_sel;
+	const struct reg_field charger_status;
+	const struct reg_field charger_chg_end;
+	const struct reg_field charger_timeout;
+	const struct reg_field charger_vin_overvolt;
+	const struct reg_field boost_enable;
+	const struct reg_field boost_llshdn_enable;
+	const struct reg_field boost_llshdn_i_limit;
+	const struct reg_field boost_load_powerup_en;
+	const struct reg_field boost_vin_pullout_en;
+	const struct reg_field boost_undervolt_limit;
+	const struct reg_field boost_light_load_status;
+	const struct reg_field battery_ntc_dis;
+	const struct reg_field battery_type;
+	const struct reg_field battery_vset_en;
+	const struct reg_field battery_adc_volt_low;
+	const struct reg_field battery_adc_volt_high;
+	const struct reg_field battery_adc_curr_low;
+	const struct reg_field battery_adc_curr_high;
+	const struct reg_field battery_adc_ovolt_low;
+	const struct reg_field battery_adc_ovolt_high;
+	const struct reg_field btn_shdn_enable;
+	const struct reg_field btn_wled_mode;
+	const struct reg_field btn_shdn_mode;
+	const struct reg_field btn_long_press_time;
+	const struct reg_field btn_pressed;
+	const struct reg_field btn_long_pressed;
+	const struct reg_field btn_short_pressed;
+	const struct reg_field wled_enable;
+	const struct reg_field wled_detect_en;
+	const struct reg_field wled_present;
 };
 
 /*
@@ -87,24 +143,24 @@ struct ip5xxx {
  *  2) Attempt the initialization sequence on each subsequent register access
  *     until it succeeds.
  */
-static int ip5xxx_read(struct ip5xxx *ip5xxx, unsigned int reg,
+static int ip5xxx_read_field(struct ip5xxx *ip5xxx, struct regmap_field *field,
 		       unsigned int *val)
 {
 	int ret;
 
-	ret = regmap_read(ip5xxx->regmap, reg, val);
+	ret = regmap_field_read(field, val);
 	if (ret)
 		ip5xxx->initialized = false;
 
 	return ret;
 }
 
-static int ip5xxx_update_bits(struct ip5xxx *ip5xxx, unsigned int reg,
-			      unsigned int mask, unsigned int val)
+static int ip5xxx_write(struct ip5xxx *ip5xxx, struct regmap_field *field,
+			      unsigned int val)
 {
 	int ret;
 
-	ret = regmap_update_bits(ip5xxx->regmap, reg, mask, val);
+	ret = regmap_field_write(field, val);
 	if (ret)
 		ip5xxx->initialized = false;
 
@@ -123,28 +179,24 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Disable shutdown under light load.
 	 * Enable power on when under load.
 	 */
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL1,
-				 IP5XXX_SYS_CTL1_LIGHT_SHDN_EN |
-				 IP5XXX_SYS_CTL1_LOAD_PWRUP_EN,
-				 IP5XXX_SYS_CTL1_LOAD_PWRUP_EN);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.boost.light_load_shutdown, 0);
+	if (ret)
+		return ret;
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.boost.load_powerup_en, 1);
 	if (ret)
 		return ret;
 
 	/*
 	 * Enable shutdown after a long button press (as configured below).
 	 */
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL3,
-				 IP5XXX_SYS_CTL3_BTN_SHDN_EN,
-				 IP5XXX_SYS_CTL3_BTN_SHDN_EN);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.btn.shdn_enable, 1);
 	if (ret)
 		return ret;
 
 	/*
 	 * Power on automatically when VIN is removed.
 	 */
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL4,
-				 IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN,
-				 IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.boost.vin_pullout_en, 1);
 	if (ret)
 		return ret;
 
@@ -152,12 +204,13 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Enable the NTC.
 	 * Configure the button for two presses => LED, long press => shutdown.
 	 */
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL5,
-				 IP5XXX_SYS_CTL5_NTC_DIS |
-				 IP5XXX_SYS_CTL5_WLED_MODE_SEL |
-				 IP5XXX_SYS_CTL5_BTN_SHDN_SEL,
-				 IP5XXX_SYS_CTL5_WLED_MODE_SEL |
-				 IP5XXX_SYS_CTL5_BTN_SHDN_SEL);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.battery.ntc_dis, 0);
+	if (ret)
+		return ret;
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.btn.wled_mode, 1);
+	if (ret)
+		return ret;
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.btn.shdn_mode, 1);
 	if (ret)
 		return ret;
 
@@ -186,24 +239,24 @@ static int ip5xxx_battery_get_status(struct ip5xxx *ip5xxx, int *val)
 	unsigned int rval;
 	int ret;
 
-	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.charger.status, &rval);
 	if (ret)
 		return ret;
 
-	switch (rval & IP5XXX_READ0_CHG_STAT) {
-	case IP5XXX_READ0_CHG_STAT_IDLE:
+	switch (rval) {
+	case IP5XXX_CHG_STAT_IDLE:
 		*val = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
-	case IP5XXX_READ0_CHG_STAT_TRICKLE:
-	case IP5XXX_READ0_CHG_STAT_CONST_CUR:
-	case IP5XXX_READ0_CHG_STAT_CONST_VOLT:
+	case IP5XXX_CHG_STAT_TRICKLE:
+	case IP5XXX_CHG_STAT_CONST_CUR:
+	case IP5XXX_CHG_STAT_CONST_VOLT:
 		*val = POWER_SUPPLY_STATUS_CHARGING;
 		break;
-	case IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP:
-	case IP5XXX_READ0_CHG_STAT_FULL:
+	case IP5XXX_CHG_STAT_CONST_VOLT_STOP:
+	case IP5XXX_CHG_STAT_FULL:
 		*val = POWER_SUPPLY_STATUS_FULL;
 		break;
-	case IP5XXX_READ0_CHG_STAT_TIMEOUT:
+	case IP5XXX_CHG_STAT_TIMEOUT:
 		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 	default:
@@ -218,22 +271,22 @@ static int ip5xxx_battery_get_charge_type(struct ip5xxx *ip5xxx, int *val)
 	unsigned int rval;
 	int ret;
 
-	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.charger.status, &rval);
 	if (ret)
 		return ret;
 
-	switch (rval & IP5XXX_READ0_CHG_STAT) {
-	case IP5XXX_READ0_CHG_STAT_IDLE:
-	case IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP:
-	case IP5XXX_READ0_CHG_STAT_FULL:
-	case IP5XXX_READ0_CHG_STAT_TIMEOUT:
+	switch (rval) {
+	case IP5XXX_CHG_STAT_IDLE:
+	case IP5XXX_CHG_STAT_CONST_VOLT_STOP:
+	case IP5XXX_CHG_STAT_FULL:
+	case IP5XXX_CHG_STAT_TIMEOUT:
 		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		break;
-	case IP5XXX_READ0_CHG_STAT_TRICKLE:
+	case IP5XXX_CHG_STAT_TRICKLE:
 		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
 		break;
-	case IP5XXX_READ0_CHG_STAT_CONST_CUR:
-	case IP5XXX_READ0_CHG_STAT_CONST_VOLT:
+	case IP5XXX_CHG_STAT_CONST_CUR:
+	case IP5XXX_CHG_STAT_CONST_VOLT:
 		*val = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 		break;
 	default:
@@ -248,11 +301,11 @@ static int ip5xxx_battery_get_health(struct ip5xxx *ip5xxx, int *val)
 	unsigned int rval;
 	int ret;
 
-	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.charger.timeout, &rval);
 	if (ret)
 		return ret;
 
-	if (rval & IP5XXX_READ0_TIMEOUT)
+	if (rval)
 		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
 	else
 		*val = POWER_SUPPLY_HEALTH_GOOD;
@@ -265,7 +318,7 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	unsigned int rval;
 	int ret;
 
-	ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL2, &rval);
+	ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.battery.type, &rval);
 	if (ret)
 		return ret;
 
@@ -273,14 +326,14 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 	 * It is not clear what this will return if
 	 * IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN is not set...
 	 */
-	switch (rval & IP5XXX_CHG_CTL2_BAT_TYPE_SEL) {
-	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V:
+	switch (rval) {
+	case IP5XXX_BAT_TYPE_4_2V:
 		*val = 4200000;
 		break;
-	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V:
+	case IP5XXX_BAT_TYPE_4_3V:
 		*val = 4300000;
 		break;
-	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V:
+	case IP5XXX_BAT_TYPE_4_35V:
 		*val = 4350000;
 		break;
 	default:
@@ -291,16 +344,16 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
 }
 
 static int ip5xxx_battery_read_adc(struct ip5xxx *ip5xxx,
-				   u8 lo_reg, u8 hi_reg, int *val)
+				   struct ip5xxx_battery_adc_regs *regs, int *val)
 {
 	unsigned int hi, lo;
 	int ret;
 
-	ret = ip5xxx_read(ip5xxx, lo_reg, &lo);
+	ret = ip5xxx_read_field(ip5xxx, regs->low, &lo);
 	if (ret)
 		return ret;
 
-	ret = ip5xxx_read(ip5xxx, hi_reg, &hi);
+	ret = ip5xxx_read_field(ip5xxx, regs->high, &hi);
 	if (ret)
 		return ret;
 
@@ -335,32 +388,28 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 		return ip5xxx_battery_get_voltage_max(ip5xxx, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATVADC_DAT0,
-					      IP5XXX_BATVADC_DAT1, &raw);
+		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.volt, &raw);
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
-		ret = ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATOCV_DAT0,
-					      IP5XXX_BATOCV_DAT1, &raw);
+		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.open_volt, &raw);
 
 		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
 		return 0;
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATIADC_DAT0,
-					      IP5XXX_BATIADC_DAT1, &raw);
+		ret = ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.curr, &raw);
 
 		val->intval = DIV_ROUND_CLOSEST(raw * 149197, 200);
 		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL4A, &rval);
+		ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.charger.const_curr_sel, &rval);
 		if (ret)
 			return ret;
 
-		rval &= IP5XXX_CHG_CTL4A_CONST_CUR_SEL;
 		val->intval = 100000 * rval;
 		return 0;
 
@@ -373,12 +422,11 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL2, &rval);
+		ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.charger.const_volt_sel, &rval);
 		if (ret)
 			return ret;
 
-		rval &= IP5XXX_CHG_CTL2_CONST_VOLT_SEL;
-		val->intval = vmax + 14000 * (rval >> 1);
+		val->intval = vmax + 14000 * rval;
 		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
@@ -401,26 +449,23 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 
 	switch (val) {
 	case 4200000:
-		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V;
+		rval = IP5XXX_BAT_TYPE_4_2V;
 		break;
 	case 4300000:
-		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V;
+		rval = IP5XXX_BAT_TYPE_4_3V;
 		break;
 	case 4350000:
-		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V;
+		rval = IP5XXX_BAT_TYPE_4_35V;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL2,
-				 IP5XXX_CHG_CTL2_BAT_TYPE_SEL, rval);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.battery.type, rval);
 	if (ret)
 		return ret;
 
-	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL4,
-				 IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN,
-				 IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN);
+	ret = ip5xxx_write(ip5xxx, &ip5xxx->regs.battery.vset_en, 1);
 	if (ret)
 		return ret;
 
@@ -443,7 +488,7 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		switch (val->intval) {
 		case POWER_SUPPLY_STATUS_CHARGING:
-			rval = IP5XXX_SYS_CTL0_CHARGER_EN;
+			rval = 1;
 			break;
 		case POWER_SUPPLY_STATUS_DISCHARGING:
 		case POWER_SUPPLY_STATUS_NOT_CHARGING:
@@ -452,25 +497,22 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
 		default:
 			return -EINVAL;
 		}
-		return ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL0,
-					  IP5XXX_SYS_CTL0_CHARGER_EN, rval);
+		return ip5xxx_write(ip5xxx, &ip5xxx->regs.charger.enable, rval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		return ip5xxx_battery_set_voltage_max(ip5xxx, val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		rval = val->intval / 100000;
-		return ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL4A,
-					  IP5XXX_CHG_CTL4A_CONST_CUR_SEL, rval);
+		return ip5xxx_write(ip5xxx, &ip5xxx->charger.const_curr_sel, rval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		ret = ip5xxx_battery_get_voltage_max(ip5xxx, &vmax);
 		if (ret)
 			return ret;
 
-		rval = ((val->intval - vmax) / 14000) << 1;
-		return ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL2,
-					  IP5XXX_CHG_CTL2_CONST_VOLT_SEL, rval);
+		rval = (val->intval - vmax) / 14000;
+		return ip5xxx_write(ip5xxx, &ip5xxx->regs.charger.const_volt_sel, rval);
 
 	default:
 		return -EINVAL;
@@ -515,20 +557,19 @@ static int ip5xxx_boost_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		ret = ip5xxx_read(ip5xxx, IP5XXX_SYS_CTL0, &rval);
+		ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.boost.enable, &rval);
 		if (ret)
 			return ret;
 
-		val->intval = !!(rval & IP5XXX_SYS_CTL0_BOOST_EN);
+		val->intval = !!rval;
 		return 0;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL1, &rval);
+		ret = ip5xxx_read_field(ip5xxx, &ip5xxx->regs.boost.undervolt_limit, &rval);
 		if (ret)
 			return ret;
 
-		rval &= IP5XXX_CHG_CTL1_BOOST_UVP_SEL;
-		val->intval = 4530000 + 100000 * (rval >> 2);
+		val->intval = 4530000 + 100000 * rval;
 		return 0;
 
 	default:
@@ -550,14 +591,11 @@ static int ip5xxx_boost_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		rval = val->intval ? IP5XXX_SYS_CTL0_BOOST_EN : 0;
-		return ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL0,
-					  IP5XXX_SYS_CTL0_BOOST_EN, rval);
+		return ip5xxx_write(ip5xxx, &ip5xxx->regs.boost.enable, !!val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		rval = ((val->intval - 4530000) / 100000) << 2;
-		return ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL1,
-					  IP5XXX_CHG_CTL1_BOOST_UVP_SEL, rval);
+		rval = (val->intval - 4530000) / 100000;
+		return ip5xxx_write(ip5xxx, &ip5xxx->regs.boost.undervolt_limit, rval);
 
 	default:
 		return -EINVAL;
@@ -583,13 +621,99 @@ static const struct power_supply_desc ip5xxx_boost_desc = {
 static const struct regmap_config ip5xxx_regmap_config = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= IP5XXX_BATOCV_DAT1,
+	.max_register		= 0xa9,
+};
+
+static struct ip5xxx_regfield_config ip51xx_fields = {
+	.charger_enable = REG_FIELD(0x01, 1, 1);
+	.charger_const_volt_sel = REG_FIELD(0x24, 2, 1);
+	.charger_const_curr_sel = REG_FIELD(0x25, 4, 0);
+	.charger_status = REG_FIELD(0x71, 7, 5);
+	.charger_chg_end = REG_FIELD(0x71, 3, 3);
+	.charger_timeout = REG_FIELD(0x71, 2, 0);
+	.charger_vin_overvolt = REG_FIELD(0x72, 5, 5);
+	.boost_enable = REG_FIELD(0x01, 2, 2);
+	.boost_llshdn_enable = REG_FIELD(0x02, 1, 1);
+	.boost_llshdn_i_limit = REG_FIELD(0x0c, 7, 3);
+	.boost_load_powerup_en = REG_FIELD(0x02, 0, 0);
+	.boost_vin_pullout_en = REG_FIELD(0x04, 5, 5);
+	.boost_undervolt_limit = REG_FIELD(0x22, 3, 2);
+	.boost_light_load_status = REG_FIELD(0x72, 6, 6);
+	.battery_ntc_dis = REG_FIELD(0x07, 6, 6);
+	.battery_type = REG_FIELD(0x24, 6, 5);
+	.battery_vset_en = REG_FIELD(0x26, 6, 6);
+	.battery_adc_volt_low = REG_FIELD(0xa2, 7, 0);
+	.battery_adc_volt_high = REG_FIELD(0xa3, 5, 0);
+	.battery_adc_curr_low = REG_FIELD(0xa4, 7, 0);
+	.battery_adc_curr_high = REG_FIELD(0xa5, 5, 0);
+	.battery_adc_ovolt_low = REG_FIELD(0xa8, 7, 0);
+	.battery_adc_ovolt_high = REG_FIELD(0xa9, 5, 0);
+	.btn_shdn_enable = REG_FIELD(0x03, 5, 5);
+	.btn_wled_mode = REG_FIELD(0x07, 1, 1);
+	.btn_shdn_mode = REG_FIELD(0x07, 0, 0);
+	.btn_long_press_time = REG_FIELD(0x03, 7, 6);
+	.btn_pressed = REG_FIELD(0x77, 3, 3);
+	.btn_long_pressed = REG_FIELD(0x77, 1, 1);
+	.btn_short_pressed = REG_FIELD(0x77, 0, 0);
+	.wled_enable = REG_FIELD(0x01, 3, 3);
+	.wled_detect_en = REG_FIELD(0x01, 4, 4);
+	.wled_present = REG_FIELD(0x72, 7, 7);
 };
 
+#define ip5xxx_setup_reg(_field, _reg) \
+			do { \
+				if (likely(cfg->_field.lsb <= cfg->_field.msb)) { \
+					struct regmap_field *_tmp = devm_regmap_field_alloc(dev, \
+							ip5xxx->regmap, cfg->_field); \
+					if (!IS_ERR(_tmp)) \
+						ip5xxx->regs._reg = _tmp; \
+				} \
+			} while (0)
+
+static void ip5xxx_setup_regs(struct device *dev, struct ip5xxx *ip5xxx,
+			      const struct ip5xxx_regfield_config *cfg)
+{
+	ip5xxx_setup_reg(charger_enable, charger.enable);
+	ip5xxx_setup_reg(charger_const_volt_sel, charger.const_volt_sel);
+	ip5xxx_setup_reg(charger_const_curr_sel, charger.const_curr_sel);
+	ip5xxx_setup_reg(charger_status, charger.status);
+	ip5xxx_setup_reg(charger_chg_end, charger.chg_end);
+	ip5xxx_setup_reg(charger_timeout, charger.timeout);
+	ip5xxx_setup_reg(charger_vin_overvolt, charger.vin_overvolt);
+	ip5xxx_setup_reg(boost_enable, boost.enable);
+	ip5xxx_setup_reg(boost_llshdn_enable, boost.light_load_shutdown.enable);
+	ip5xxx_setup_reg(boost_llshdn_i_limit, boost.light_load_shutdown.i_limit);
+	ip5xxx_setup_reg(boost_load_powerup_en, boost.load_powerup_en);
+	ip5xxx_setup_reg(boost_vin_pullout_en, boost.vin_pullout_en);
+	ip5xxx_setup_reg(boost_undervolt_limit, boost.undervolt_limit);
+	ip5xxx_setup_reg(boost_light_load_status, boost.light_load_status);
+	ip5xxx_setup_reg(battery_ntc_dis, battery.ntc_dis);
+	ip5xxx_setup_reg(battery_type, battery.type);
+	ip5xxx_setup_reg(battery_vset_en, battery.vset_en);
+	ip5xxx_setup_reg(battery_adc_volt_low, battery.volt.low);
+	ip5xxx_setup_reg(battery_adc_volt_high, battery.volt.high);
+	ip5xxx_setup_reg(battery_adc_curr_low, battery.curr.low);
+	ip5xxx_setup_reg(battery_adc_curr_high, battery.curr.high);
+	ip5xxx_setup_reg(battery_adc_ovolt_low, battery.open_volt.low);
+	ip5xxx_setup_reg(battery_adc_ovolt_high, battery.open_volt.high);
+	ip5xxx_setup_reg(btn_shdn_enable, btn.shdn_enable);
+	ip5xxx_setup_reg(btn_wled_mode, btn.wled_mode);
+	ip5xxx_setup_reg(btn_shdn_mode, btn.shdn_mode);
+	ip5xxx_setup_reg(btn_long_press_time, btn.long_press_time);
+	ip5xxx_setup_reg(btn_pressed, btn.pressed);
+	ip5xxx_setup_reg(btn_long_pressed, btn.long_pressed);
+	ip5xxx_setup_reg(btn_short_pressed, btn.short_pressed);
+	ip5xxx_setup_reg(wled_enable, wled.enable);
+	ip5xxx_setup_reg(wled_detect_en, wled.detect_en);
+	ip5xxx_setup_reg(wled_present, wled.present);
+}
+
 static int ip5xxx_power_probe(struct i2c_client *client)
 {
+	const struct ip5xxx_regfield_config *fields = &ip51xx_fields
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &client->dev;
+	const struct of_device_id *of_id;
 	struct power_supply *psy;
 	struct ip5xxx *ip5xxx;
 
@@ -601,6 +725,11 @@ static int ip5xxx_power_probe(struct i2c_client *client)
 	if (IS_ERR(ip5xxx->regmap))
 		return PTR_ERR(ip5xxx->regmap);
 
+	of_id = i2c_of_match_device(dev->driver->of_match_table, client);
+	if (of_id)
+		fields = (const struct ip5xxx_regfield_config *) of_id->data;
+	ip5xxx_setup_regs(dev, ip5xxx, fields);
+
 	psy_cfg.of_node = dev->of_node;
 	psy_cfg.drv_data = ip5xxx;
 
@@ -616,10 +745,10 @@ static int ip5xxx_power_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ip5xxx_power_of_match[] = {
-	{ .compatible = "injoinic,ip5108" },
-	{ .compatible = "injoinic,ip5109" },
-	{ .compatible = "injoinic,ip5207" },
-	{ .compatible = "injoinic,ip5209" },
+	{ .compatible = "injoinic,ip5108", .data = &ip51xx_fields },
+	{ .compatible = "injoinic,ip5109", .data = &ip51xx_fields },
+	{ .compatible = "injoinic,ip5207", .data = &ip51xx_fields },
+	{ .compatible = "injoinic,ip5209", .data = &ip51xx_fields },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
-- 
2.34.1



