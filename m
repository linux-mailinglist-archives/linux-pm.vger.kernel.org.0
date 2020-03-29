Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9527196E61
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgC2QWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:22:35 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52564 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgC2QWf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:22:35 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2E41C2499B;
        Sun, 29 Mar 2020 18:22:32 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 5/9] power: supply: smb347-charger: Implement device-tree support
Date:   Sun, 29 Mar 2020 18:21:24 +0200
Message-Id: <20200329162128.218584-6-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch makes smb347 charger driver to support dt binding. All legacy
platform data now can be parsed from dt.
Because of that smb347 is i2c client driver, IRQ number can be passed
automatically through client's irq variable if it is defined in dt.
No more to use requesting gpio to irq manually in dt-way.

Based on: https://patchwork.kernel.org/patch/4284731/
Original author: Jonghwa Lee <jonghwa3.lee@samsung.com>

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 107 +++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 4add9f64ba90..852d2ab566e0 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1180,6 +1180,87 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	return smb347_volatile_reg(dev, reg);
 }
 
+static void smb347_dt_parse_pdata(struct device_node *np,
+				  struct smb347_charger_platform_data *pdata)
+{
+	/* Charging constraints */
+	of_property_read_u32(np, "summit,max-chg-curr",
+			     &pdata->max_charge_current);
+	of_property_read_u32(np, "summit,max-chg-volt",
+			     &pdata->max_charge_voltage);
+	of_property_read_u32(np, "summit,pre-chg-curr",
+			     &pdata->pre_charge_current);
+	of_property_read_u32(np, "summit,term-curr",
+			     &pdata->termination_current);
+	of_property_read_u32(np, "summit,fast-volt-threshold",
+			     &pdata->pre_to_fast_voltage);
+	of_property_read_u32(np, "summit,mains-curr-limit",
+			     &pdata->mains_current_limit);
+	of_property_read_u32(np, "summit,usb-curr-limit",
+			     &pdata->usb_hc_current_limit);
+
+	/* For thermometer monitoring */
+	of_property_read_u32(np, "summit,chip-temp-threshold",
+			     &pdata->chip_temp_threshold);
+	if (of_property_read_u32(np, "summit,soft-cold-temp-limit",
+				 &pdata->soft_cold_temp_limit))
+		pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "summit,soft-hot-temp-limit",
+				 &pdata->soft_hot_temp_limit))
+		pdata->soft_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "summit,hard-cold-temp-limit",
+				 &pdata->hard_cold_temp_limit))
+		pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "summit,hard-hot-temp-limit",
+				 &pdata->hard_hot_temp_limit))
+		pdata->hard_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+
+	/* Suspend when battery temperature is outside hard limits */
+	if (pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT ||
+	    pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT)
+		pdata->suspend_on_hard_temp_limit = true;
+
+	if (of_property_read_u32(np, "summit,soft-comp-method",
+				 &pdata->soft_temp_limit_compensation))
+		pdata->soft_temp_limit_compensation =
+				SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
+
+	of_property_read_u32(np, "summit,chg-curr-comp",
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
+	/* Enable charging method */
+	of_property_read_u32(np, "summit,enable-chg-ctrl",
+			     &pdata->enable_control);
+
+	/* If IRQ is enabled or not */
+	if (!of_find_property(np, "interrupts", NULL))
+		pdata->irq_gpio = -1;
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
@@ -1216,28 +1297,26 @@ static int smb347_probe(struct i2c_client *client,
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
@@ -1250,6 +1329,7 @@ static int smb347_probe(struct i2c_client *client,
 	mains_usb_cfg.supplied_to = battery;
 	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
+	mains_usb_cfg.of_node = dev->of_node;
 	if (smb->pdata->use_mains) {
 		smb->mains = power_supply_register(dev, &smb347_mains_desc,
 						   &mains_usb_cfg);
@@ -1282,7 +1362,7 @@ static int smb347_probe(struct i2c_client *client,
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
 	 */
-	if (pdata->irq_gpio >= 0) {
+	if (smb->pdata->irq_gpio >= 0) {
 		ret = smb347_irq_init(smb, client);
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
@@ -1316,9 +1396,16 @@ static const struct i2c_device_id smb347_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
+static const struct of_device_id smb3xx_of_match[] = {
+	{ .compatible = "summit,smb347" },
+	{},
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
2.25.0

