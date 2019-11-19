Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75B102A49
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfKSRAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 12:00:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49929 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKSRAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 12:00:06 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iX6rF-0002FQ-0A; Tue, 19 Nov 2019 18:00:05 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH] power: suppy: ucs1002: disable power when max current is 0
Date:   Tue, 19 Nov 2019 18:00:04 +0100
Message-Id: <20191119170004.24533-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For some devices userspace needs the ability to completely cut the power
to the USB devices connected to the charge controller. An easy way to
achieve this is by allowing 0 as a valid max current and forcibly disable
the output in that case, as well as enable it again if the regulator is
in use and a non-0 max current is set.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/power/supply/ucs1002_power.c | 42 +++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 1b80ae479e7d..0ca80d00b80a 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -100,7 +100,9 @@ struct ucs1002_info {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct regulator_desc *regulator_descriptor;
+	struct regulator_dev *rdev;
 	bool present;
+	bool output_disable;
 };
 
 static enum power_supply_property ucs1002_props[] = {
@@ -233,6 +235,11 @@ static int ucs1002_get_max_current(struct ucs1002_info *info,
 	unsigned int reg;
 	int ret;
 
+	if (info->output_disable) {
+		val->intval = 0;
+		return 0;
+	}
+
 	ret = regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
 	if (ret)
 		return ret;
@@ -247,6 +254,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
 	unsigned int reg;
 	int ret, idx;
 
+	if (val == 0) {
+		info->output_disable = true;
+		regulator_disable_regmap(info->rdev);
+		return 0;
+	}
+
 	for (idx = 0; idx < ARRAY_SIZE(ucs1002_current_limit_uA); idx++) {
 		if (val == ucs1002_current_limit_uA[idx])
 			break;
@@ -270,6 +283,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
 	if (reg != idx)
 		return -EINVAL;
 
+	info->output_disable = false;
+
+	if (info->rdev && info->rdev->use_count &&
+	    !regulator_is_enabled_regmap(info->rdev))
+		regulator_enable_regmap(info->rdev);
+
 	return 0;
 }
 
@@ -470,9 +489,24 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+int ucs1002_regulator_enable(struct regulator_dev *rdev)
+{
+	struct ucs1002_info *info = rdev_get_drvdata(rdev);
+
+	/*
+	 * If the output is disabled due to 0 maximum current, just pretend the
+	 * enable did work. The regulator will be enabled as soon as we get a
+	 * a non-zero maximum current budget.
+	 */
+	if (info->output_disable)
+		return 0;
+
+	return regulator_enable_regmap(rdev);
+}
+
 static const struct regulator_ops ucs1002_regulator_ops = {
 	.is_enabled	= regulator_is_enabled_regmap,
-	.enable		= regulator_enable_regmap,
+	.enable		= ucs1002_regulator_enable,
 	.disable	= regulator_disable_regmap,
 };
 
@@ -499,7 +533,6 @@ static int ucs1002_probe(struct i2c_client *client,
 	};
 	struct regulator_config regulator_config = {};
 	int irq_a_det, irq_alert, ret;
-	struct regulator_dev *rdev;
 	struct ucs1002_info *info;
 	unsigned int regval;
 
@@ -589,10 +622,11 @@ static int ucs1002_probe(struct i2c_client *client,
 	regulator_config.dev = dev;
 	regulator_config.of_node = dev->of_node;
 	regulator_config.regmap = info->regmap;
+	regulator_config.driver_data = info;
 
-	rdev = devm_regulator_register(dev, info->regulator_descriptor,
+	info->rdev = devm_regulator_register(dev, info->regulator_descriptor,
 				       &regulator_config);
-	ret = PTR_ERR_OR_ZERO(rdev);
+	ret = PTR_ERR_OR_ZERO(info->rdev);
 	if (ret) {
 		dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
 		return ret;
-- 
2.20.1

