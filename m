Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C533BAF90
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGDW6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhGDW6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35368C061574;
        Sun,  4 Jul 2021 15:56:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id k21so22062335ljh.2;
        Sun, 04 Jul 2021 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5DXCJ4TGIghBr5tKB7RBQAGB0HsPXVJ3LIrt5+RqZ0=;
        b=ptFOsTOI3Ct++plBlK7C1HWYYDPjIVfW8kgxF01A58pgCViZ4IWOY1Q6icf3l0k/+R
         nRzwQIn6Pxuoje3WAGUGpJC+OKL2lOUailZFzeiVpvLw7gy+BMd8xPmxWoEC38VMvdWW
         Muhm5zT/3kCGVJLHqK8gfRvePZQ/FokwBQIsWC6ODBEhFGPDOHFFPRQGpDsaiDeFHKbV
         0w2ul6gsmrLevXEjwtBuIUSQIdNED7/tAI6v7iUdvWdHVxmI9bH6YMC7gI9x8IjERFD+
         H46x3zSBW99QRmbLEda3eSGX3qCeCIQawcqsASnJx6+GzWhR5ots5I6KWgHytczUU20G
         ScjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5DXCJ4TGIghBr5tKB7RBQAGB0HsPXVJ3LIrt5+RqZ0=;
        b=moecYhm6WZg3cVAyx3CDCgQ+sBfItwtCHRVCzvHg5t+mcO+lNNb3fqoOmmBWqYta9A
         N/GqbbSkT1AQN6XcPnjjJtqh31ZMo7oWlQnd+nPAwmwcua5zknJW8dDSeccfNqIAVE7G
         tNl6gCgEk0CgW5Ab3tzUpGojw72W8SgRs7f3Z9aPAWJSv8CbRhKg+ckhQ8SmducTBxUM
         Y22rvbCb3vT4hsDCUzxlNOE0fMi+45CkEsV8YDnH04081LNS65G7+lXLxvTCCNGNRk/V
         risCBDsAy8uN6kk/28AvB0DcqFniormQyaNr9P1aNj5+4nRku9jRQEOb5n+cbMbGwT5k
         Z+3A==
X-Gm-Message-State: AOAM531JByDXoTI1l1UyMx8BwqXKPZCGrDeXqj2CzGYcVxn89eWcPC4U
        lWfc7xCHjj7UN3q4bunerIM=
X-Google-Smtp-Source: ABdhPJwMmoHJYjNoOCOfT96GCowUZxfjFlQWkn9tMvxoNyc0spY6aa9I+db6vI/EZLGugnszW9xOew==
X-Received: by 2002:a2e:151e:: with SMTP id s30mr5102998ljd.106.1625439366566;
        Sun, 04 Jul 2021 15:56:06 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 09/12] power: supply: smb347-charger: Implement USB VBUS regulator
Date:   Mon,  5 Jul 2021 01:54:30 +0300
Message-Id: <20210704225433.32029-10-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SMB347 can supply power to USB VBUS, implement the USB VBUS regulator.
USB VBUS needs to be powered for switching OTG-cable USB port into host
mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/Kconfig          |   1 +
 drivers/power/supply/smb347-charger.c | 219 ++++++++++++++++++++++++++
 2 files changed, 220 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 832190743e00..5a4f82ba9375 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -688,6 +688,7 @@ config CHARGER_BQ256XX
 config CHARGER_SMB347
 	tristate "Summit Microelectronics SMB3XX Battery Charger"
 	depends on I2C
+	depends on REGULATOR
 	select REGMAP_I2C
 	help
 	  Say Y to include support for Summit Microelectronics SMB345,
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index f81c60c679a0..330f1cd40e5e 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -18,6 +18,7 @@
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/driver.h>
 
 #include <dt-bindings/power/summit,smb347-charger.h>
 
@@ -62,12 +63,15 @@
 #define CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT	2
 #define CFG_THERM_MONITOR_DISABLED		BIT(4)
 #define CFG_SYSOK				0x08
+#define CFG_SYSOK_INOK_ACTIVE_HIGH		BIT(0)
 #define CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED	BIT(2)
 #define CFG_OTHER				0x09
 #define CFG_OTHER_RID_MASK			0xc0
 #define CFG_OTHER_RID_ENABLED_AUTO_OTG		0xc0
 #define CFG_OTG					0x0a
 #define CFG_OTG_TEMP_THRESHOLD_MASK		0x30
+#define CFG_OTG_CURRENT_LIMIT_250mA		BIT(2)
+#define CFG_OTG_CURRENT_LIMIT_750mA		BIT(3)
 #define CFG_OTG_TEMP_THRESHOLD_SHIFT		4
 #define CFG_OTG_CC_COMPENSATION_MASK		0xc0
 #define CFG_OTG_CC_COMPENSATION_SHIFT		6
@@ -91,6 +95,7 @@
 #define CMD_A					0x30
 #define CMD_A_CHG_ENABLED			BIT(1)
 #define CMD_A_SUSPEND_ENABLED			BIT(2)
+#define CMD_A_OTG_ENABLED			BIT(4)
 #define CMD_A_ALLOW_WRITE			BIT(7)
 #define CMD_B					0x31
 #define CMD_C					0x33
@@ -132,10 +137,12 @@
  * @regmap: pointer to driver regmap
  * @mains: power_supply instance for AC/DC power
  * @usb: power_supply instance for USB power
+ * @usb_rdev: USB VBUS regulator device
  * @id: SMB charger ID
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
  * @irq_unsupported: is interrupt unsupported by SMB hardware
+ * @usb_vbus_enabled: is USB VBUS powered by SMB charger
  * @max_charge_current: maximum current (in uA) the battery can be charged
  * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
  * @pre_charge_current: current (in uA) to use in pre-charging phase
@@ -166,6 +173,8 @@
  * @use_usb_otg: USB OTG output can be used (not implemented yet)
  * @enable_control: how charging enable/disable is controlled
  *		    (driver/pin controls)
+ * @inok_polarity: polarity of INOK signal which denotes presence of external
+ *		   power supply
  *
  * @use_main, @use_usb, and @use_usb_otg are means to enable/disable
  * hardware support for these. This is useful when we want to have for
@@ -188,10 +197,12 @@ struct smb347_charger {
 	struct regmap		*regmap;
 	struct power_supply	*mains;
 	struct power_supply	*usb;
+	struct regulator_dev	*usb_rdev;
 	unsigned int		id;
 	bool			mains_online;
 	bool			usb_online;
 	bool			irq_unsupported;
+	bool			usb_vbus_enabled;
 
 	unsigned int		max_charge_current;
 	unsigned int		max_charge_voltage;
@@ -212,6 +223,7 @@ struct smb347_charger {
 	bool			use_usb;
 	bool			use_usb_otg;
 	unsigned int		enable_control;
+	unsigned int		inok_polarity;
 };
 
 enum smb_charger_chipid {
@@ -361,6 +373,11 @@ static int smb347_charging_set(struct smb347_charger *smb, bool enable)
 		return 0;
 	}
 
+	if (enable && smb->usb_vbus_enabled) {
+		dev_dbg(smb->dev, "charging not enabled because USB is in host mode\n");
+		return 0;
+	}
+
 	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
 				  enable ? CMD_A_CHG_ENABLED : 0);
 }
@@ -1243,6 +1260,13 @@ static void smb347_dt_parse_dev_info(struct smb347_charger *smb)
 	/* Select charging control */
 	device_property_read_u32(dev, "summit,enable-charge-control",
 				 &smb->enable_control);
+
+	/*
+	 * Polarity of INOK signal indicating presence of external power
+	 * supply connected to the charger.
+	 */
+	device_property_read_u32(dev, "summit,inok-polarity",
+				 &smb->inok_polarity);
 }
 
 static int smb347_get_battery_info(struct smb347_charger *smb)
@@ -1294,6 +1318,160 @@ static int smb347_get_battery_info(struct smb347_charger *smb)
 	return 0;
 }
 
+static int smb347_usb_vbus_get_current_limit(struct regulator_dev *rdev)
+{
+	struct smb347_charger *smb = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(smb->regmap, CFG_OTG, &val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * It's unknown what happens if this bit is unset due to lack of
+	 * access to the datasheet, assume it's limit-enable.
+	 */
+	if (!(val & CFG_OTG_CURRENT_LIMIT_250mA))
+		return 0;
+
+	return val & CFG_OTG_CURRENT_LIMIT_750mA ? 750000 : 250000;
+}
+
+static int smb347_usb_vbus_set_new_current_limit(struct smb347_charger *smb,
+						 int max_uA)
+{
+	const unsigned int mask = CFG_OTG_CURRENT_LIMIT_750mA |
+				  CFG_OTG_CURRENT_LIMIT_250mA;
+	unsigned int val = CFG_OTG_CURRENT_LIMIT_250mA;
+	int ret;
+
+	if (max_uA >= 750000)
+		val |= CFG_OTG_CURRENT_LIMIT_750mA;
+
+	ret = regmap_update_bits(smb->regmap, CFG_OTG, mask, val);
+	if (ret < 0)
+		dev_err(smb->dev, "failed to change USB current limit\n");
+
+	return ret;
+}
+
+static int smb347_usb_vbus_set_current_limit(struct regulator_dev *rdev,
+					     int min_uA, int max_uA)
+{
+	struct smb347_charger *smb = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = smb347_set_writable(smb, true, true);
+	if (ret < 0)
+		return ret;
+
+	ret = smb347_usb_vbus_set_new_current_limit(smb, max_uA);
+	smb347_set_writable(smb, false, true);
+
+	return ret;
+}
+
+static int smb347_usb_vbus_regulator_enable(struct regulator_dev *rdev)
+{
+	struct smb347_charger *smb = rdev_get_drvdata(rdev);
+	int ret, max_uA;
+
+	ret = smb347_set_writable(smb, true, true);
+	if (ret < 0)
+		return ret;
+
+	smb347_charging_disable(smb);
+
+	if (device_property_read_bool(&rdev->dev, "summit,needs-inok-toggle")) {
+		unsigned int sysok = 0;
+
+		if (smb->inok_polarity == SMB3XX_SYSOK_INOK_ACTIVE_LOW)
+			sysok = CFG_SYSOK_INOK_ACTIVE_HIGH;
+
+		/*
+		 * VBUS won't be powered if INOK is active, so we need to
+		 * manually disable INOK on some platforms.
+		 */
+		ret = regmap_update_bits(smb->regmap, CFG_SYSOK,
+					 CFG_SYSOK_INOK_ACTIVE_HIGH, sysok);
+		if (ret < 0) {
+			dev_err(smb->dev, "failed to disable INOK\n");
+			goto done;
+		}
+	}
+
+	ret = smb347_usb_vbus_get_current_limit(rdev);
+	if (ret < 0) {
+		dev_err(smb->dev, "failed to get USB VBUS current limit\n");
+		goto done;
+	}
+
+	max_uA = ret;
+
+	ret = smb347_usb_vbus_set_new_current_limit(smb, 250000);
+	if (ret < 0) {
+		dev_err(smb->dev, "failed to preset USB VBUS current limit\n");
+		goto done;
+	}
+
+	ret = regmap_set_bits(smb->regmap, CMD_A, CMD_A_OTG_ENABLED);
+	if (ret < 0) {
+		dev_err(smb->dev, "failed to enable USB VBUS\n");
+		goto done;
+	}
+
+	smb->usb_vbus_enabled = true;
+
+	ret = smb347_usb_vbus_set_new_current_limit(smb, max_uA);
+	if (ret < 0) {
+		dev_err(smb->dev, "failed to restore USB VBUS current limit\n");
+		goto done;
+	}
+done:
+	smb347_set_writable(smb, false, true);
+
+	return ret;
+}
+
+static int smb347_usb_vbus_regulator_disable(struct regulator_dev *rdev)
+{
+	struct smb347_charger *smb = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = smb347_set_writable(smb, true, true);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_clear_bits(smb->regmap, CMD_A, CMD_A_OTG_ENABLED);
+	if (ret < 0) {
+		dev_err(smb->dev, "failed to disable USB VBUS\n");
+		goto done;
+	}
+
+	smb->usb_vbus_enabled = false;
+
+	if (device_property_read_bool(&rdev->dev, "summit,needs-inok-toggle")) {
+		unsigned int sysok = 0;
+
+		if (smb->inok_polarity == SMB3XX_SYSOK_INOK_ACTIVE_HIGH)
+			sysok = CFG_SYSOK_INOK_ACTIVE_HIGH;
+
+		ret = regmap_update_bits(smb->regmap, CFG_SYSOK,
+					 CFG_SYSOK_INOK_ACTIVE_HIGH, sysok);
+		if (ret < 0) {
+			dev_err(smb->dev, "failed to enable INOK\n");
+			goto done;
+		}
+	}
+
+	smb347_start_stop_charging(smb);
+done:
+	smb347_set_writable(smb, false, true);
+
+	return ret;
+}
+
 static const struct regmap_config smb347_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -1302,6 +1480,14 @@ static const struct regmap_config smb347_regmap = {
 	.readable_reg	= smb347_readable_reg,
 };
 
+static const struct regulator_ops smb347_usb_vbus_regulator_ops = {
+	.is_enabled	= regulator_is_enabled_regmap,
+	.enable		= smb347_usb_vbus_regulator_enable,
+	.disable	= smb347_usb_vbus_regulator_disable,
+	.get_current_limit = smb347_usb_vbus_get_current_limit,
+	.set_current_limit = smb347_usb_vbus_set_current_limit,
+};
+
 static const struct power_supply_desc smb347_mains_desc = {
 	.name		= "smb347-mains",
 	.type		= POWER_SUPPLY_TYPE_MAINS,
@@ -1318,10 +1504,24 @@ static const struct power_supply_desc smb347_usb_desc = {
 	.num_properties	= ARRAY_SIZE(smb347_properties),
 };
 
+static const struct regulator_desc smb347_usb_vbus_regulator_desc = {
+	.name		= "smb347-usb-vbus",
+	.of_match	= of_match_ptr("usb-vbus"),
+	.ops		= &smb347_usb_vbus_regulator_ops,
+	.type		= REGULATOR_VOLTAGE,
+	.owner		= THIS_MODULE,
+	.enable_reg	= CMD_A,
+	.enable_mask	= CMD_A_OTG_ENABLED,
+	.enable_val	= CMD_A_OTG_ENABLED,
+	.fixed_uV	= 5000000,
+	.n_voltages	= 1,
+};
+
 static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct power_supply_config mains_usb_cfg = {};
+	struct regulator_config usb_rdev_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
@@ -1369,6 +1569,18 @@ static int smb347_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	usb_rdev_cfg.dev = dev;
+	usb_rdev_cfg.driver_data = smb;
+	usb_rdev_cfg.regmap = smb->regmap;
+
+	smb->usb_rdev = devm_regulator_register(dev,
+						&smb347_usb_vbus_regulator_desc,
+						&usb_rdev_cfg);
+	if (IS_ERR(smb->usb_rdev)) {
+		smb347_irq_disable(smb);
+		return PTR_ERR(smb->usb_rdev);
+	}
+
 	return 0;
 }
 
@@ -1376,11 +1588,17 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
+	smb347_usb_vbus_regulator_disable(smb->usb_rdev);
 	smb347_irq_disable(smb);
 
 	return 0;
 }
 
+static void smb347_shutdown(struct i2c_client *client)
+{
+	smb347_remove(client);
+}
+
 static const struct i2c_device_id smb347_id[] = {
 	{ "smb345", SMB345 },
 	{ "smb347", SMB347 },
@@ -1404,6 +1622,7 @@ static struct i2c_driver smb347_driver = {
 	},
 	.probe = smb347_probe,
 	.remove = smb347_remove,
+	.shutdown = smb347_shutdown,
 	.id_table = smb347_id,
 };
 module_i2c_driver(smb347_driver);
-- 
2.32.0

