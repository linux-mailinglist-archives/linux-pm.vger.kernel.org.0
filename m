Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D260127E3F4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgI3Ikw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 04:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Ikw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 04:40:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD2C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:40:51 -0700 (PDT)
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kNXfN-0002og-61; Wed, 30 Sep 2020 10:40:50 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de,
        Kevin Benson <kevin_simona@hotmail.com>,
        Chris Healy <cphealy@gmail.com>
Date:   Wed, 30 Sep 2020 10:40:47 +0200
Message-Id: <20200930084047.2927163-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.2
Subject: [PATCH] power: supply: ucs1002: fix some health status issues
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some fault events like the over-current condition will get resolved
by the hardware, by e.g. disabling the port. As the status in the
interrupt status register is cleared on read when the fault is resolved,
the sysfs health property will only contain the correct health status
for the first time it is read after such an event, even if the actual
fault condition (like a VBUS short) still persists. To reflect this
properly in the property we cache the last health status and only update
the cache when a actual change happens, i.e. the ERR bit in the status
register flips, as this one properly reflects a continued fault condition.

The ALERT pin however, is not driven by the ERR status, but by the actual
fault status, so the pin will change back to it's default state when the
hardware has automatically resolved the fault by cutting the power. Thus
we never get an IRQ when the actual fault condition has been resolved and
the ERR status bit has been cleared in auto-recovery mode. To get this
information we need to poll the interrupt status register after some time
to see if the fault is gone and update our cache in that case.

To avoid any additional locking, we handle both paths (IRQ firing and
delayed polling) through the same single-threaded delayed work.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/power/supply/ucs1002_power.c | 75 ++++++++++++++++------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index cdb9a23d825f..ef673ec3db56 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -38,6 +38,7 @@
 
 /* Interrupt Status */
 #define UCS1002_REG_INTERRUPT_STATUS	0x10
+#  define F_ERR				BIT(7)
 #  define F_DISCHARGE_ERR		BIT(6)
 #  define F_RESET			BIT(5)
 #  define F_MIN_KEEP_OUT		BIT(4)
@@ -103,6 +104,9 @@ struct ucs1002_info {
 	struct regulator_dev *rdev;
 	bool present;
 	bool output_disable;
+	struct delayed_work health_poll;
+	int health;
+
 };
 
 static enum power_supply_property ucs1002_props[] = {
@@ -362,32 +366,6 @@ static int ucs1002_get_usb_type(struct ucs1002_info *info,
 	return 0;
 }
 
-static int ucs1002_get_health(struct ucs1002_info *info,
-			      union power_supply_propval *val)
-{
-	unsigned int reg;
-	int ret, health;
-
-	ret = regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS, &reg);
-	if (ret)
-		return ret;
-
-	if (reg & F_TSD)
-		health = POWER_SUPPLY_HEALTH_OVERHEAT;
-	else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
-		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-	else if (reg & F_OVER_ILIM)
-		health = POWER_SUPPLY_HEALTH_OVERCURRENT;
-	else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
-		health = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
-	else
-		health = POWER_SUPPLY_HEALTH_GOOD;
-
-	val->intval = health;
-
-	return 0;
-}
-
 static int ucs1002_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
@@ -406,7 +384,7 @@ static int ucs1002_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return ucs1002_get_usb_type(info, val);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return ucs1002_get_health(info, val);
+		return val->intval = info->health;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = info->present;
 		return 0;
@@ -458,6 +436,38 @@ static const struct power_supply_desc ucs1002_charger_desc = {
 	.num_properties		= ARRAY_SIZE(ucs1002_props),
 };
 
+static void ucs1002_health_poll(struct work_struct *work)
+{
+	struct ucs1002_info *info = container_of(work, struct ucs1002_info,
+						 health_poll.work);
+	int ret;
+	u32 reg;
+
+	ret = regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS, &reg);
+	if (ret)
+		return;
+
+	/* bad health and no status change, just schedule us again in a while */
+	if ((reg & F_ERR) && info->health != POWER_SUPPLY_HEALTH_GOOD) {
+		schedule_delayed_work(&info->health_poll,
+				      msecs_to_jiffies(2000));
+		return;
+	}
+
+	if (reg & F_TSD)
+		info->health = POWER_SUPPLY_HEALTH_OVERHEAT;
+	else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
+		info->health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	else if (reg & F_OVER_ILIM)
+		info->health = POWER_SUPPLY_HEALTH_OVERCURRENT;
+	else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
+		info->health = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+	else
+		info->health = POWER_SUPPLY_HEALTH_GOOD;
+
+	sysfs_notify(&info->charger->dev.kobj, NULL, "health");
+}
+
 static irqreturn_t ucs1002_charger_irq(int irq, void *data)
 {
 	int ret, regval;
@@ -484,7 +494,7 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
 {
 	struct ucs1002_info *info = data;
 
-	power_supply_changed(info->charger);
+	mod_delayed_work(system_wq, &info->health_poll, 0);
 
 	return IRQ_HANDLED;
 }
@@ -632,6 +642,9 @@ static int ucs1002_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	info->health = POWER_SUPPLY_HEALTH_GOOD;
+	INIT_DELAYED_WORK(&info->health_poll, ucs1002_health_poll);
+
 	if (irq_a_det > 0) {
 		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
 						ucs1002_charger_irq,
@@ -645,10 +658,8 @@ static int ucs1002_probe(struct i2c_client *client,
 	}
 
 	if (irq_alert > 0) {
-		ret = devm_request_threaded_irq(dev, irq_alert, NULL,
-						ucs1002_alert_irq,
-						IRQF_ONESHOT,
-						"ucs1002-alert", info);
+		ret = devm_request_irq(dev, irq_alert, ucs1002_alert_irq,
+				       0,"ucs1002-alert", info);
 		if (ret) {
 			dev_err(dev, "Failed to request ALERT threaded irq: %d\n",
 				ret);
-- 
2.20.1

