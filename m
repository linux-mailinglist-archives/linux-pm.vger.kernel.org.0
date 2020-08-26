Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4540325319E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZOmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHZOmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 10:42:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF685C061756;
        Wed, 26 Aug 2020 07:42:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8655E299F74
Received: by jupiter.universe (Postfix, from userid 1000)
        id 546F948010E; Wed, 26 Aug 2020 16:42:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 1/2] power: supply: smb347-charger: Drop pdata support
Date:   Wed, 26 Aug 2020 16:41:58 +0200
Message-Id: <20200826144159.353837-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826144159.353837-1-sebastian.reichel@collabora.com>
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are no platforms using the pdata support, so let's
drop it to simplify the driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/smb347-charger.c | 287 ++++++++++++++------------
 include/linux/power/smb347-charger.h  | 114 ----------
 2 files changed, 159 insertions(+), 242 deletions(-)
 delete mode 100644 include/linux/power/smb347-charger.h

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index ec68ab2bce27..b182727dfc90 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -17,9 +17,16 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/power_supply.h>
-#include <linux/power/smb347-charger.h>
 #include <linux/regmap.h>
 
+#include <dt-bindings/power/summit,smb347-charger.h>
+
+/* Use the default compensation method */
+#define SMB3XX_SOFT_TEMP_COMPENSATE_DEFAULT -1
+
+/* Use default factory programmed value for hard/soft temperature limit */
+#define SMB3XX_TEMP_USE_DEFAULT		-273
+
 /*
  * Configuration registers. These are mirrored to volatile RAM and can be
  * written once %CMD_A_ALLOW_WRITE is set in %CMD_A register. They will be
@@ -129,7 +136,52 @@
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
  * @charging_enabled: is charging enabled
- * @pdata: pointer to platform data
+ * @max_charge_current: maximum current (in uA) the battery can be charged
+ * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
+ * @pre_charge_current: current (in uA) to use in pre-charging phase
+ * @termination_current: current (in uA) used to determine when the
+ *			 charging cycle terminates
+ * @pre_to_fast_voltage: voltage (in uV) treshold used for transitioning to
+ *			 pre-charge to fast charge mode
+ * @mains_current_limit: maximum input current drawn from AC/DC input (in uA)
+ * @usb_hc_current_limit: maximum input high current (in uA) drawn from USB
+ *			  input
+ * @chip_temp_threshold: die temperature where device starts limiting charge
+ *			 current [%100 - %130] (in degree C)
+ * @soft_cold_temp_limit: soft cold temperature limit [%0 - %15] (in degree C),
+ *			  granularity is 5 deg C.
+ * @soft_hot_temp_limit: soft hot temperature limit [%40 - %55] (in degree  C),
+ *			 granularity is 5 deg C.
+ * @hard_cold_temp_limit: hard cold temperature limit [%-5 - %10] (in degree C),
+ *			  granularity is 5 deg C.
+ * @hard_hot_temp_limit: hard hot temperature limit [%50 - %65] (in degree C),
+ *			 granularity is 5 deg C.
+ * @suspend_on_hard_temp_limit: suspend charging when hard limit is hit
+ * @soft_temp_limit_compensation: compensation method when soft temperature
+ *				  limit is hit
+ * @charge_current_compensation: current (in uA) for charging compensation
+ *				 current when temperature hits soft limits
+ * @use_mains: AC/DC input can be used
+ * @use_usb: USB input can be used
+ * @use_usb_otg: USB OTG output can be used (not implemented yet)
+ * @enable_control: how charging enable/disable is controlled
+ *		    (driver/pin controls)
+ *
+ * @use_main, @use_usb, and @use_usb_otg are means to enable/disable
+ * hardware support for these. This is useful when we want to have for
+ * example OTG charging controlled via OTG transceiver driver and not by
+ * the SMB347 hardware.
+ *
+ * Hard and soft temperature limit values are given as described in the
+ * device data sheet and assuming NTC beta value is %3750. Even if this is
+ * not the case, these values should be used. They can be mapped to the
+ * corresponding NTC beta values with the help of table %2 in the data
+ * sheet. So for example if NTC beta is %3375 and we want to program hard
+ * hot limit to be %53 deg C, @hard_hot_temp_limit should be set to %50.
+ *
+ * If zero value is given in any of the current and voltage values, the
+ * factory programmed default will be used. For soft/hard temperature
+ * values, pass in %SMB3XX_TEMP_USE_DEFAULT instead.
  */
 struct smb347_charger {
 	struct device		*dev;
@@ -140,7 +192,26 @@ struct smb347_charger {
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
-	const struct smb347_charger_platform_data *pdata;
+
+	unsigned int		max_charge_current;
+	unsigned int		max_charge_voltage;
+	unsigned int		pre_charge_current;
+	unsigned int		termination_current;
+	unsigned int		pre_to_fast_voltage;
+	unsigned int		mains_current_limit;
+	unsigned int		usb_hc_current_limit;
+	unsigned int		chip_temp_threshold;
+	int			soft_cold_temp_limit;
+	int			soft_hot_temp_limit;
+	int			hard_cold_temp_limit;
+	int			hard_hot_temp_limit;
+	bool			suspend_on_hard_temp_limit;
+	unsigned int		soft_temp_limit_compensation;
+	unsigned int		charge_current_compensation;
+	bool			use_mains;
+	bool			use_usb;
+	bool			use_usb_otg;
+	unsigned int		enable_control;
 };
 
 enum smb_charger_chipid {
@@ -235,9 +306,9 @@ static int smb347_update_ps_status(struct smb347_charger *smb)
 	 * Dc and usb are set depending on whether they are enabled in
 	 * platform data _and_ whether corresponding undervoltage is set.
 	 */
-	if (smb->pdata->use_mains)
+	if (smb->use_mains)
 		dc = !(val & IRQSTAT_E_DCIN_UV_STAT);
-	if (smb->pdata->use_usb)
+	if (smb->use_usb)
 		usb = !(val & IRQSTAT_E_USBIN_UV_STAT);
 
 	ret = smb->mains_online != dc || smb->usb_online != usb;
@@ -287,7 +358,7 @@ static int smb347_charging_set(struct smb347_charger *smb, bool enable)
 {
 	int ret = 0;
 
-	if (smb->pdata->enable_control != SMB347_CHG_ENABLE_SW) {
+	if (smb->enable_control != SMB3XX_CHG_ENABLE_SW) {
 		dev_dbg(smb->dev, "charging enable/disable in SW disabled\n");
 		return 0;
 	}
@@ -339,9 +410,9 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 	unsigned int id = smb->id;
 	int ret;
 
-	if (smb->pdata->max_charge_current) {
+	if (smb->max_charge_current) {
 		ret = current_to_hw(fcc_tbl[id], ARRAY_SIZE(fcc_tbl[id]),
-				    smb->pdata->max_charge_current);
+				    smb->max_charge_current);
 		if (ret < 0)
 			return ret;
 
@@ -352,9 +423,9 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->pre_charge_current) {
+	if (smb->pre_charge_current) {
 		ret = current_to_hw(pcc_tbl[id], ARRAY_SIZE(pcc_tbl[id]),
-				    smb->pdata->pre_charge_current);
+				    smb->pre_charge_current);
 		if (ret < 0)
 			return ret;
 
@@ -365,9 +436,9 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->termination_current) {
+	if (smb->termination_current) {
 		ret = current_to_hw(tc_tbl[id], ARRAY_SIZE(tc_tbl[id]),
-				    smb->pdata->termination_current);
+				    smb->termination_current);
 		if (ret < 0)
 			return ret;
 
@@ -385,9 +456,9 @@ static int smb347_set_current_limits(struct smb347_charger *smb)
 	unsigned int id = smb->id;
 	int ret;
 
-	if (smb->pdata->mains_current_limit) {
+	if (smb->mains_current_limit) {
 		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
-				    smb->pdata->mains_current_limit);
+				    smb->mains_current_limit);
 		if (ret < 0)
 			return ret;
 
@@ -398,9 +469,9 @@ static int smb347_set_current_limits(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->usb_hc_current_limit) {
+	if (smb->usb_hc_current_limit) {
 		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
-				    smb->pdata->usb_hc_current_limit);
+				    smb->usb_hc_current_limit);
 		if (ret < 0)
 			return ret;
 
@@ -417,8 +488,8 @@ static int smb347_set_voltage_limits(struct smb347_charger *smb)
 {
 	int ret;
 
-	if (smb->pdata->pre_to_fast_voltage) {
-		ret = smb->pdata->pre_to_fast_voltage;
+	if (smb->pre_to_fast_voltage) {
+		ret = smb->pre_to_fast_voltage;
 
 		/* uV */
 		ret = clamp_val(ret, 2400000, 3000000) - 2400000;
@@ -431,8 +502,8 @@ static int smb347_set_voltage_limits(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->max_charge_voltage) {
-		ret = smb->pdata->max_charge_voltage;
+	if (smb->max_charge_voltage) {
+		ret = smb->max_charge_voltage;
 
 		/* uV */
 		ret = clamp_val(ret, 3500000, 4500000) - 3500000;
@@ -454,8 +525,8 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	int ret = 0;
 	int val;
 
-	if (smb->pdata->chip_temp_threshold) {
-		val = smb->pdata->chip_temp_threshold;
+	if (smb->chip_temp_threshold) {
+		val = smb->chip_temp_threshold;
 
 		/* degree C */
 		val = clamp_val(val, 100, 130) - 100;
@@ -468,8 +539,8 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->soft_cold_temp_limit != SMB347_TEMP_USE_DEFAULT) {
-		val = smb->pdata->soft_cold_temp_limit;
+	if (smb->soft_cold_temp_limit != SMB3XX_TEMP_USE_DEFAULT) {
+		val = smb->soft_cold_temp_limit;
 
 		val = clamp_val(val, 0, 15);
 		val /= 5;
@@ -485,8 +556,8 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 		enable_therm_monitor = true;
 	}
 
-	if (smb->pdata->soft_hot_temp_limit != SMB347_TEMP_USE_DEFAULT) {
-		val = smb->pdata->soft_hot_temp_limit;
+	if (smb->soft_hot_temp_limit != SMB3XX_TEMP_USE_DEFAULT) {
+		val = smb->soft_hot_temp_limit;
 
 		val = clamp_val(val, 40, 55) - 40;
 		val /= 5;
@@ -500,8 +571,8 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 		enable_therm_monitor = true;
 	}
 
-	if (smb->pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT) {
-		val = smb->pdata->hard_cold_temp_limit;
+	if (smb->hard_cold_temp_limit != SMB3XX_TEMP_USE_DEFAULT) {
+		val = smb->hard_cold_temp_limit;
 
 		val = clamp_val(val, -5, 10) + 5;
 		val /= 5;
@@ -517,8 +588,8 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 		enable_therm_monitor = true;
 	}
 
-	if (smb->pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT) {
-		val = smb->pdata->hard_hot_temp_limit;
+	if (smb->hard_hot_temp_limit != SMB3XX_TEMP_USE_DEFAULT) {
+		val = smb->hard_hot_temp_limit;
 
 		val = clamp_val(val, 50, 65) - 50;
 		val /= 5;
@@ -549,16 +620,16 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->suspend_on_hard_temp_limit) {
+	if (smb->suspend_on_hard_temp_limit) {
 		ret = regmap_update_bits(smb->regmap, CFG_SYSOK,
 				 CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED, 0);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (smb->pdata->soft_temp_limit_compensation !=
-	    SMB347_SOFT_TEMP_COMPENSATE_DEFAULT) {
-		val = smb->pdata->soft_temp_limit_compensation & 0x3;
+	if (smb->soft_temp_limit_compensation !=
+	    SMB3XX_SOFT_TEMP_COMPENSATE_DEFAULT) {
+		val = smb->soft_temp_limit_compensation & 0x3;
 
 		ret = regmap_update_bits(smb->regmap, CFG_THERM,
 				 CFG_THERM_SOFT_HOT_COMPENSATION_MASK,
@@ -573,9 +644,9 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 			return ret;
 	}
 
-	if (smb->pdata->charge_current_compensation) {
+	if (smb->charge_current_compensation) {
 		val = current_to_hw(ccc_tbl[id], ARRAY_SIZE(ccc_tbl[id]),
-				    smb->pdata->charge_current_compensation);
+				    smb->charge_current_compensation);
 		if (val < 0)
 			return val;
 
@@ -634,7 +705,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 		goto fail;
 
 	/* If USB charging is disabled we put the USB in suspend mode */
-	if (!smb->pdata->use_usb) {
+	if (!smb->use_usb) {
 		ret = regmap_update_bits(smb->regmap, CMD_A,
 					 CMD_A_SUSPEND_ENABLED,
 					 CMD_A_SUSPEND_ENABLED);
@@ -647,7 +718,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	 * support for driving VBUS. Otherwise we disable it.
 	 */
 	ret = regmap_update_bits(smb->regmap, CFG_OTHER, CFG_OTHER_RID_MASK,
-		smb->pdata->use_usb_otg ? CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
+		smb->use_usb_otg ? CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
 	if (ret < 0)
 		goto fail;
 
@@ -656,11 +727,11 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	 * command register unless pin control is specified in the platform
 	 * data.
 	 */
-	switch (smb->pdata->enable_control) {
-	case SMB347_CHG_ENABLE_PIN_ACTIVE_LOW:
+	switch (smb->enable_control) {
+	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW:
 		val = CFG_PIN_EN_CTRL_ACTIVE_LOW;
 		break;
-	case SMB347_CHG_ENABLE_PIN_ACTIVE_HIGH:
+	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH:
 		val = CFG_PIN_EN_CTRL_ACTIVE_HIGH;
 		break;
 	default:
@@ -729,9 +800,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 */
 	if (stat_c & STAT_C_CHARGER_ERROR) {
 		dev_err(smb->dev, "charging stopped due to charger error\n");
-		if (smb->pdata->use_mains)
+		if (smb->use_mains)
 			power_supply_changed(smb->mains);
-		if (smb->pdata->use_usb)
+		if (smb->use_usb)
 			power_supply_changed(smb->usb);
 		handled = true;
 	}
@@ -743,9 +814,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 */
 	if (irqstat_c & (IRQSTAT_C_TERMINATION_IRQ | IRQSTAT_C_TAPER_IRQ)) {
 		if (irqstat_c & IRQSTAT_C_TERMINATION_STAT) {
-			if (smb->pdata->use_mains)
+			if (smb->use_mains)
 				power_supply_changed(smb->mains);
-			if (smb->pdata->use_usb)
+			if (smb->use_usb)
 				power_supply_changed(smb->usb);
 		}
 		dev_dbg(smb->dev, "going to HW maintenance mode\n");
@@ -761,9 +832,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 
 		if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_STAT)
 			dev_warn(smb->dev, "charging stopped due to timeout\n");
-		if (smb->pdata->use_mains)
+		if (smb->use_mains)
 			power_supply_changed(smb->mains);
-		if (smb->pdata->use_usb)
+		if (smb->use_usb)
 			power_supply_changed(smb->usb);
 		handled = true;
 	}
@@ -775,9 +846,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	if (irqstat_e & (IRQSTAT_E_USBIN_UV_IRQ | IRQSTAT_E_DCIN_UV_IRQ)) {
 		if (smb347_update_ps_status(smb) > 0) {
 			smb347_start_stop_charging(smb);
-			if (smb->pdata->use_mains)
+			if (smb->use_mains)
 				power_supply_changed(smb->mains);
-			if (smb->pdata->use_usb)
+			if (smb->use_usb)
 				power_supply_changed(smb->usb);
 		}
 		handled = true;
@@ -832,25 +903,10 @@ static inline int smb347_irq_disable(struct smb347_charger *smb)
 static int smb347_irq_init(struct smb347_charger *smb,
 			   struct i2c_client *client)
 {
-	const struct smb347_charger_platform_data *pdata = smb->pdata;
-	unsigned long irqflags = IRQF_ONESHOT;
 	int ret;
 
-	/* Requesting GPIO for IRQ is only needed in non-DT way */
-	if (!client->irq) {
-		int irq = gpio_to_irq(pdata->irq_gpio);
-
-		ret = devm_gpio_request_one(smb->dev, pdata->irq_gpio,
-					    GPIOF_IN, client->name);
-		if (ret < 0)
-			return ret;
-
-		irqflags |= IRQF_TRIGGER_FALLING;
-		client->irq = irq;
-	}
-
 	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
-					smb347_interrupt, irqflags,
+					smb347_interrupt, IRQF_ONESHOT,
 					client->name, smb);
 	if (ret < 0)
 		return ret;
@@ -1118,56 +1174,52 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	return smb347_volatile_reg(dev, reg);
 }
 
-static void smb347_dt_parse_pdata(struct device_node *np,
-				  struct smb347_charger_platform_data *pdata)
+static void smb347_dt_parse_dev_info(struct smb347_charger *smb)
 {
-	pdata->soft_temp_limit_compensation =
-					SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
+	struct device_node *np = smb->dev->of_node;
+
+	smb->soft_temp_limit_compensation =
+					SMB3XX_SOFT_TEMP_COMPENSATE_DEFAULT;
 	/*
 	 * These properties come from the battery info, still we need to
 	 * pre-initialize the values. See smb347_get_battery_info() below.
 	 */
-	pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
-	pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
-	pdata->soft_hot_temp_limit  = SMB347_TEMP_USE_DEFAULT;
-	pdata->hard_hot_temp_limit  = SMB347_TEMP_USE_DEFAULT;
+	smb->soft_cold_temp_limit = SMB3XX_TEMP_USE_DEFAULT;
+	smb->hard_cold_temp_limit = SMB3XX_TEMP_USE_DEFAULT;
+	smb->soft_hot_temp_limit  = SMB3XX_TEMP_USE_DEFAULT;
+	smb->hard_hot_temp_limit  = SMB3XX_TEMP_USE_DEFAULT;
 
 	/* Charging constraints */
 	of_property_read_u32(np, "summit,fast-voltage-threshold-microvolt",
-			     &pdata->pre_to_fast_voltage);
+			     &smb->pre_to_fast_voltage);
 	of_property_read_u32(np, "summit,mains-current-limit-microamp",
-			     &pdata->mains_current_limit);
+			     &smb->mains_current_limit);
 	of_property_read_u32(np, "summit,usb-current-limit-microamp",
-			     &pdata->usb_hc_current_limit);
+			     &smb->usb_hc_current_limit);
 
 	/* For thermometer monitoring */
 	of_property_read_u32(np, "summit,chip-temperature-threshold-celsius",
-			     &pdata->chip_temp_threshold);
+			     &smb->chip_temp_threshold);
 	of_property_read_u32(np, "summit,soft-compensation-method",
-			     &pdata->soft_temp_limit_compensation);
+			     &smb->soft_temp_limit_compensation);
 	of_property_read_u32(np, "summit,charge-current-compensation-microamp",
-			     &pdata->charge_current_compensation);
+			     &smb->charge_current_compensation);
 
 	/* Supported charging mode */
-	pdata->use_mains =
+	smb->use_mains =
 		of_property_read_bool(np, "summit,enable-mains-charging");
-	pdata->use_usb =
+	smb->use_usb =
 		of_property_read_bool(np, "summit,enable-usb-charging");
-	pdata->use_usb_otg =
+	smb->use_usb_otg =
 		of_property_read_bool(np, "summit,enable-otg-charging");
 
 	/* Select charging control */
 	of_property_read_u32(np, "summit,enable-charge-control",
-			     &pdata->enable_control);
-
-	/* Interrupt support is optional */
-	if (!of_find_property(np, "interrupts", NULL))
-		pdata->irq_gpio = -1;
+			     &smb->enable_control);
 }
 
 static int smb347_get_battery_info(struct smb347_charger *smb)
 {
-	struct smb347_charger_platform_data *pdata = (void *)smb->pdata;
 	struct power_supply_battery_info info = {};
 	struct power_supply *supply;
 	int err;
@@ -1184,53 +1236,37 @@ static int smb347_get_battery_info(struct smb347_charger *smb)
 		return err;
 
 	if (info.constant_charge_current_max_ua != -EINVAL)
-		pdata->max_charge_current = info.constant_charge_current_max_ua;
+		smb->max_charge_current = info.constant_charge_current_max_ua;
 
 	if (info.constant_charge_voltage_max_uv != -EINVAL)
-		pdata->max_charge_voltage = info.constant_charge_voltage_max_uv;
+		smb->max_charge_voltage = info.constant_charge_voltage_max_uv;
 
 	if (info.precharge_current_ua != -EINVAL)
-		pdata->pre_charge_current = info.precharge_current_ua;
+		smb->pre_charge_current = info.precharge_current_ua;
 
 	if (info.charge_term_current_ua != -EINVAL)
-		pdata->termination_current = info.charge_term_current_ua;
+		smb->termination_current = info.charge_term_current_ua;
 
 	if (info.temp_alert_min != INT_MIN)
-		pdata->soft_cold_temp_limit = info.temp_alert_min;
+		smb->soft_cold_temp_limit = info.temp_alert_min;
 
 	if (info.temp_alert_max != INT_MAX)
-		pdata->soft_hot_temp_limit = info.temp_alert_max;
+		smb->soft_hot_temp_limit = info.temp_alert_max;
 
 	if (info.temp_min != INT_MIN)
-		pdata->hard_cold_temp_limit = info.temp_min;
+		smb->hard_cold_temp_limit = info.temp_min;
 
 	if (info.temp_max != INT_MAX)
-		pdata->hard_hot_temp_limit = info.temp_max;
+		smb->hard_hot_temp_limit = info.temp_max;
 
 	/* Suspend when battery temperature is outside hard limits */
-	if (pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT ||
-	    pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT)
-		pdata->suspend_on_hard_temp_limit = true;
+	if (smb->hard_cold_temp_limit != SMB3XX_TEMP_USE_DEFAULT ||
+	    smb->hard_hot_temp_limit != SMB3XX_TEMP_USE_DEFAULT)
+		smb->suspend_on_hard_temp_limit = true;
 
 	return 0;
 }
 
-static struct smb347_charger_platform_data
-			*smb347_get_platdata(struct device *dev)
-{
-	struct smb347_charger_platform_data *pdata;
-
-	if (dev->of_node) {
-		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-		if (pdata)
-			smb347_dt_parse_pdata(dev->of_node, pdata);
-	} else {
-		pdata = dev_get_platdata(dev);
-	}
-
-	return pdata;
-}
-
 static const struct regmap_config smb347_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -1266,18 +1302,13 @@ static int smb347_probe(struct i2c_client *client,
 	smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
 	if (!smb)
 		return -ENOMEM;
-
-	smb->pdata = smb347_get_platdata(dev);
-	if (!smb->pdata)
-		return -ENODEV;
-
-	if (!smb->pdata->use_mains && !smb->pdata->use_usb)
-		return -EINVAL;
-
-	i2c_set_clientdata(client, smb);
-
 	smb->dev = &client->dev;
 	smb->id = id->driver_data;
+	i2c_set_clientdata(client, smb);
+
+	smb347_dt_parse_dev_info(smb);
+	if (!smb->use_mains && !smb->use_usb)
+		return -EINVAL;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
@@ -1285,14 +1316,14 @@ static int smb347_probe(struct i2c_client *client,
 
 	mains_usb_cfg.drv_data = smb;
 	mains_usb_cfg.of_node = dev->of_node;
-	if (smb->pdata->use_mains) {
+	if (smb->use_mains) {
 		smb->mains = devm_power_supply_register(dev, &smb347_mains_desc,
 							&mains_usb_cfg);
 		if (IS_ERR(smb->mains))
 			return PTR_ERR(smb->mains);
 	}
 
-	if (smb->pdata->use_usb) {
+	if (smb->use_usb) {
 		smb->usb = devm_power_supply_register(dev, &smb347_usb_desc,
 						      &mains_usb_cfg);
 		if (IS_ERR(smb->usb))
@@ -1311,7 +1342,7 @@ static int smb347_probe(struct i2c_client *client,
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
 	 */
-	if (smb->pdata->irq_gpio >= 0) {
+	if (client->irq) {
 		ret = smb347_irq_init(smb, client);
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
diff --git a/include/linux/power/smb347-charger.h b/include/linux/power/smb347-charger.h
deleted file mode 100644
index e0b687a4d20c..000000000000
--- a/include/linux/power/smb347-charger.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Summit Microelectronics SMB347 Battery Charger Driver
- *
- * Copyright (C) 2011, Intel Corporation
- *
- * Authors: Bruce E. Robertson <bruce.e.robertson@intel.com>
- *          Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#ifndef SMB347_CHARGER_H
-#define SMB347_CHARGER_H
-
-#include <linux/types.h>
-#include <linux/power_supply.h>
-
-enum {
-	/* use the default compensation method */
-	SMB347_SOFT_TEMP_COMPENSATE_DEFAULT = -1,
-
-	SMB347_SOFT_TEMP_COMPENSATE_NONE,
-	SMB347_SOFT_TEMP_COMPENSATE_CURRENT,
-	SMB347_SOFT_TEMP_COMPENSATE_VOLTAGE,
-};
-
-/* Use default factory programmed value for hard/soft temperature limit */
-#define SMB347_TEMP_USE_DEFAULT		-273
-
-/*
- * Charging enable can be controlled by software (via i2c) by
- * smb347-charger driver or by EN pin (active low/high).
- */
-enum smb347_chg_enable {
-	SMB347_CHG_ENABLE_SW,
-	SMB347_CHG_ENABLE_PIN_ACTIVE_LOW,
-	SMB347_CHG_ENABLE_PIN_ACTIVE_HIGH,
-};
-
-/**
- * struct smb347_charger_platform_data - platform data for SMB347 charger
- * @battery_info: Information about the battery
- * @max_charge_current: maximum current (in uA) the battery can be charged
- * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
- * @pre_charge_current: current (in uA) to use in pre-charging phase
- * @termination_current: current (in uA) used to determine when the
- *			 charging cycle terminates
- * @pre_to_fast_voltage: voltage (in uV) treshold used for transitioning to
- *			 pre-charge to fast charge mode
- * @mains_current_limit: maximum input current drawn from AC/DC input (in uA)
- * @usb_hc_current_limit: maximum input high current (in uA) drawn from USB
- *			  input
- * @chip_temp_threshold: die temperature where device starts limiting charge
- *			 current [%100 - %130] (in degree C)
- * @soft_cold_temp_limit: soft cold temperature limit [%0 - %15] (in degree C),
- *			  granularity is 5 deg C.
- * @soft_hot_temp_limit: soft hot temperature limit [%40 - %55] (in degree  C),
- *			 granularity is 5 deg C.
- * @hard_cold_temp_limit: hard cold temperature limit [%-5 - %10] (in degree C),
- *			  granularity is 5 deg C.
- * @hard_hot_temp_limit: hard hot temperature limit [%50 - %65] (in degree C),
- *			 granularity is 5 deg C.
- * @suspend_on_hard_temp_limit: suspend charging when hard limit is hit
- * @soft_temp_limit_compensation: compensation method when soft temperature
- *				  limit is hit
- * @charge_current_compensation: current (in uA) for charging compensation
- *				 current when temperature hits soft limits
- * @use_mains: AC/DC input can be used
- * @use_usb: USB input can be used
- * @use_usb_otg: USB OTG output can be used (not implemented yet)
- * @irq_gpio: GPIO number used for interrupts (%-1 if not used)
- * @enable_control: how charging enable/disable is controlled
- *		    (driver/pin controls)
- *
- * @use_main, @use_usb, and @use_usb_otg are means to enable/disable
- * hardware support for these. This is useful when we want to have for
- * example OTG charging controlled via OTG transceiver driver and not by
- * the SMB347 hardware.
- *
- * Hard and soft temperature limit values are given as described in the
- * device data sheet and assuming NTC beta value is %3750. Even if this is
- * not the case, these values should be used. They can be mapped to the
- * corresponding NTC beta values with the help of table %2 in the data
- * sheet. So for example if NTC beta is %3375 and we want to program hard
- * hot limit to be %53 deg C, @hard_hot_temp_limit should be set to %50.
- *
- * If zero value is given in any of the current and voltage values, the
- * factory programmed default will be used. For soft/hard temperature
- * values, pass in %SMB347_TEMP_USE_DEFAULT instead.
- */
-struct smb347_charger_platform_data {
-	struct power_supply_info battery_info;
-	unsigned int	max_charge_current;
-	unsigned int	max_charge_voltage;
-	unsigned int	pre_charge_current;
-	unsigned int	termination_current;
-	unsigned int	pre_to_fast_voltage;
-	unsigned int	mains_current_limit;
-	unsigned int	usb_hc_current_limit;
-	unsigned int	chip_temp_threshold;
-	int		soft_cold_temp_limit;
-	int		soft_hot_temp_limit;
-	int		hard_cold_temp_limit;
-	int		hard_hot_temp_limit;
-	bool		suspend_on_hard_temp_limit;
-	unsigned int	soft_temp_limit_compensation;
-	unsigned int	charge_current_compensation;
-	bool		use_mains;
-	bool		use_usb;
-	bool		use_usb_otg;
-	int		irq_gpio;
-	enum smb347_chg_enable enable_control;
-};
-
-#endif /* SMB347_CHARGER_H */
-- 
2.28.0

