Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF178244090
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHMVer (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgHMVei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125FC061757;
        Thu, 13 Aug 2020 14:34:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so7789232ljj.5;
        Thu, 13 Aug 2020 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vvax3w5zuK8UPtDnqtBVJ1VxyZp9PqB+NM2Rb701YK0=;
        b=MAkX+Ug+p6CdPoSe37XJnbgQmX3yCBW0vfji9BV1ZddlQDEkqnFtQaX5TqYk/lLza7
         7vx/NXmOcKxs4Vv5XcPlcS2O6TOoF/AtrOmZxY2JJtPROV3BCZblv8V9axRTYef7ZIPa
         q9M472RZHBn56UIHEBEjDDG2RbmhfKyAO/BRbAVyJP89adlVwo4FPXPzSRk6aOW+HVZk
         FwZPcMpsPG2/wfjDc1pwJWKFSGSNXFow9kf6AZf2nHLMmKoRhxkhcCUI2/NCMpgdR2F2
         ID8JgVyYUR8bDN5XM3uIu7edtxahpeAxuyS2U4aaKfuNp0tfRS10wqqQLS1oRkwM1Dsp
         j+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vvax3w5zuK8UPtDnqtBVJ1VxyZp9PqB+NM2Rb701YK0=;
        b=Jfox2gQD62z9H3plcHZZcqeHngfmqpudKx82tnu5g23Iyv63XRabyc9HpYcxqpeqSz
         VeoaXh6YWYo+QIcZYU3rhznRGNoZ77B9Sm3sutMw80tsTjSRZ6m1B45ZWTRLRGQ1qtkc
         4th+0B727GCXReSnu6RFlW+titxghKDr+lz1pShsklso0CF/lpNGPVmTGWyYmd7BtbE5
         o08PzEgg18v+XtgUapHwocwYvHsXlSjens7a27ZGac0op1gimnvc619nPXw3S0fkgZUd
         ZveELUpxpjpoj+64VVT7xSHeNWaeOXMQwGUl1aYYxv17dsRxfVpLCP81Nbz4S6HktHj2
         t9UA==
X-Gm-Message-State: AOAM530THPhK/77qCGznFyyr4DQY35f6M7BHztW5ds7o6zcPN2odxf41
        3GNQWIgqGj0NKTCBg/AAGoA=
X-Google-Smtp-Source: ABdhPJzGLtS2jY3MI09apEoWdHFhx8OTfB1O7Fyu1ptGmy1FdOFZAYc7hVKGoGLnrpo+ae0daHUNpQ==
X-Received: by 2002:a05:651c:1293:: with SMTP id 19mr334463ljc.427.1597354476417;
        Thu, 13 Aug 2020 14:34:36 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 05/10] power: supply: smb347-charger: Implement device-tree support
Date:   Fri, 14 Aug 2020 00:34:04 +0300
Message-Id: <20200813213409.24222-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

This patch adds device-tree support to the SMB347 charger driver. All
legacy platform data now can be parsed from DT. Because of that and since
SMB347 is an I2C client driver, the IRQ number can be passed automatically
through client's IRQ variable if it's defined in DT. There is no need to
map GPIO to IRQ manually in the case of DT.

This patch is based on the original work made by:
Jonghwa Lee <jonghwa3.lee@samsung.com>
Link: https://patchwork.kernel.org/patch/4284731/

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 151 +++++++++++++++++++++++---
 1 file changed, 137 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 60894105fcbd..da2c337107bf 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1180,6 +1180,119 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	return smb347_volatile_reg(dev, reg);
 }
 
+static void smb347_dt_parse_pdata(struct device_node *np,
+				  struct smb347_charger_platform_data *pdata)
+{
+	pdata->soft_temp_limit_compensation =
+					SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
+	/*
+	 * These properties come from the battery info, still we need to
+	 * pre-initialize the values. See smb347_get_battery_info() below.
+	 */
+	pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	pdata->soft_hot_temp_limit  = SMB347_TEMP_USE_DEFAULT;
+	pdata->hard_hot_temp_limit  = SMB347_TEMP_USE_DEFAULT;
+
+	/* Charging constraints */
+	of_property_read_u32(np, "summit,fast-voltage-threshold-microvolt",
+			     &pdata->pre_to_fast_voltage);
+	of_property_read_u32(np, "summit,mains-current-limit-microamp",
+			     &pdata->mains_current_limit);
+	of_property_read_u32(np, "summit,usb-current-limit-microamp",
+			     &pdata->usb_hc_current_limit);
+
+	/* For thermometer monitoring */
+	of_property_read_u32(np, "summit,chip-temperature-threshold-celsius",
+			     &pdata->chip_temp_threshold);
+	of_property_read_u32(np, "summit,soft-compensation-method",
+			     &pdata->soft_temp_limit_compensation);
+	of_property_read_u32(np, "summit,charge-current-compensation-microamp",
+			     &pdata->charge_current_compensation);
+
+	/* Supported charging mode */
+	pdata->use_mains =
+		of_property_read_bool(np, "summit,enable-mains-charging");
+	pdata->use_usb =
+		of_property_read_bool(np, "summit,enable-usb-charging");
+	pdata->use_usb_otg =
+		of_property_read_bool(np, "summit,enable-otg-charging");
+
+	/* Select charging control */
+	of_property_read_u32(np, "summit,enable-charge-control",
+			     &pdata->enable_control);
+
+	/* Interrupt support is optional */
+	if (!of_find_property(np, "interrupts", NULL))
+		pdata->irq_gpio = -1;
+}
+
+static int smb347_get_battery_info(struct smb347_charger *smb)
+{
+	struct smb347_charger_platform_data *pdata = (void *)smb->pdata;
+	struct power_supply_battery_info info = {};
+	struct power_supply *supply;
+	int err;
+
+	if (smb->mains)
+		supply = smb->mains;
+	else
+		supply = smb->usb;
+
+	err = power_supply_get_battery_info(supply, &info);
+	if (err == -ENXIO || err == -ENODEV)
+		return 0;
+	if (err)
+		return err;
+
+	if (info.constant_charge_current_max_ua != -EINVAL)
+		pdata->max_charge_current = info.constant_charge_current_max_ua;
+
+	if (info.constant_charge_voltage_max_uv != -EINVAL)
+		pdata->max_charge_voltage = info.constant_charge_voltage_max_uv;
+
+	if (info.precharge_current_ua != -EINVAL)
+		pdata->pre_charge_current = info.precharge_current_ua;
+
+	if (info.charge_term_current_ua != -EINVAL)
+		pdata->termination_current = info.charge_term_current_ua;
+
+	if (info.temp_alert_min != INT_MIN)
+		pdata->soft_cold_temp_limit = info.temp_alert_min;
+
+	if (info.temp_alert_max != INT_MAX)
+		pdata->soft_hot_temp_limit = info.temp_alert_max;
+
+	if (info.temp_min != INT_MIN)
+		pdata->hard_cold_temp_limit = info.temp_min;
+
+	if (info.temp_max != INT_MAX)
+		pdata->hard_hot_temp_limit = info.temp_max;
+
+	/* Suspend when battery temperature is outside hard limits */
+	if (pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT ||
+	    pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT)
+		pdata->suspend_on_hard_temp_limit = true;
+
+	return 0;
+}
+
+static struct smb347_charger_platform_data
+			*smb347_get_platdata(struct device *dev)
+{
+	struct smb347_charger_platform_data *pdata;
+
+	if (dev->of_node) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (pdata)
+			smb347_dt_parse_pdata(dev->of_node, pdata);
+	} else {
+		pdata = dev_get_platdata(dev);
+	}
+
+	return pdata;
+}
+
 static const struct regmap_config smb347_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -1216,40 +1329,35 @@ static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	static char *battery[] = { "smb347-battery" };
-	const struct smb347_charger_platform_data *pdata;
 	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
 
-	pdata = dev->platform_data;
-	if (!pdata)
-		return -EINVAL;
-
-	if (!pdata->use_mains && !pdata->use_usb)
-		return -EINVAL;
-
 	smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
 	if (!smb)
 		return -ENOMEM;
 
+	smb->pdata = smb347_get_platdata(dev);
+	if (!smb->pdata)
+		return -ENODEV;
+
+	if (!smb->pdata->use_mains && !smb->pdata->use_usb)
+		return -EINVAL;
+
 	i2c_set_clientdata(client, smb);
 
 	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
-	smb->pdata = pdata;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
 		return PTR_ERR(smb->regmap);
 
-	ret = smb347_hw_init(smb);
-	if (ret < 0)
-		return ret;
-
 	mains_usb_cfg.supplied_to = battery;
 	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
+	mains_usb_cfg.of_node = dev->of_node;
 	if (smb->pdata->use_mains) {
 		smb->mains = devm_power_supply_register(dev, &smb347_mains_desc,
 							&mains_usb_cfg);
@@ -1270,11 +1378,19 @@ static int smb347_probe(struct i2c_client *client,
 	if (IS_ERR(smb->battery))
 		return PTR_ERR(smb->battery);
 
+	ret = smb347_get_battery_info(smb);
+	if (ret)
+		return ret;
+
+	ret = smb347_hw_init(smb);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
 	 */
-	if (pdata->irq_gpio >= 0) {
+	if (smb->pdata->irq_gpio >= 0) {
 		ret = smb347_irq_init(smb, client);
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
@@ -1302,9 +1418,16 @@ static const struct i2c_device_id smb347_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
+static const struct of_device_id smb3xx_of_match[] = {
+	{ .compatible = "summit,smb347" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, smb3xx_of_match);
+
 static struct i2c_driver smb347_driver = {
 	.driver = {
 		.name = "smb347",
+		.of_match_table = smb3xx_of_match,
 	},
 	.probe        = smb347_probe,
 	.remove       = smb347_remove,
-- 
2.27.0

