Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11C4196E66
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgC2QXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:23:06 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52632 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgC2QXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:23:06 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 50CB9249A1;
        Sun, 29 Mar 2020 18:23:04 +0200 (CEST)
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
Subject: [PATCH 8/9] power: supply: smb347-charger: Replace mutex with IRQ disable/enable
Date:   Sun, 29 Mar 2020 18:21:27 +0200
Message-Id: <20200329162128.218584-9-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Rather properly disable/enable IRQ than use mutex.
This patch makes code easier to follow.

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 38 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index ce2ebfe601d6..60a0ca2d6d74 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/power/smb347-charger.h>
 #include <linux/regmap.h>
@@ -122,7 +121,6 @@
 
 /**
  * struct smb347_charger - smb347 charger instance
- * @lock: protects concurrent access to online variables
  * @dev: pointer to device
  * @regmap: pointer to driver regmap
  * @mains: power_supply instance for AC/DC power
@@ -134,7 +132,6 @@
  * @pdata: pointer to platform data
  */
 struct smb347_charger {
-	struct mutex		lock;
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct power_supply	*mains;
@@ -243,11 +240,9 @@ static int smb347_update_ps_status(struct smb347_charger *smb)
 	if (smb->pdata->use_usb)
 		usb = !(val & IRQSTAT_E_USBIN_UV_STAT);
 
-	mutex_lock(&smb->lock);
 	ret = smb->mains_online != dc || smb->usb_online != usb;
 	smb->mains_online = dc;
 	smb->usb_online = usb;
-	mutex_unlock(&smb->lock);
 
 	return ret;
 }
@@ -263,13 +258,7 @@ static int smb347_update_ps_status(struct smb347_charger *smb)
  */
 static bool smb347_is_ps_online(struct smb347_charger *smb)
 {
-	bool ret;
-
-	mutex_lock(&smb->lock);
-	ret = smb->usb_online || smb->mains_online;
-	mutex_unlock(&smb->lock);
-
-	return ret;
+	return smb->usb_online || smb->mains_online;
 }
 
 /**
@@ -303,14 +292,13 @@ static int smb347_charging_set(struct smb347_charger *smb, bool enable)
 		return 0;
 	}
 
-	mutex_lock(&smb->lock);
 	if (smb->charging_enabled != enable) {
 		ret = regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
 					 enable ? CMD_A_CHG_ENABLED : 0);
 		if (!ret)
 			smb->charging_enabled = enable;
 	}
-	mutex_unlock(&smb->lock);
+
 	return ret;
 }
 
@@ -995,9 +983,9 @@ static int smb347_get_charging_status(struct smb347_charger *smb,
 	return status;
 }
 
-static int smb347_get_property(struct power_supply *psy,
-			       enum power_supply_property prop,
-			       union power_supply_propval *val)
+static int smb347_get_property_locked(struct power_supply *psy,
+				      enum power_supply_property prop,
+				      union power_supply_propval *val)
 {
 	struct smb347_charger *smb = power_supply_get_drvdata(psy);
 	int ret;
@@ -1064,6 +1052,21 @@ static int smb347_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int smb347_get_property(struct power_supply *psy,
+			       enum power_supply_property prop,
+			       union power_supply_propval *val)
+{
+	struct smb347_charger *smb = power_supply_get_drvdata(psy);
+	struct i2c_client *client = to_i2c_client(smb->dev);
+	int ret;
+
+	disable_irq(client->irq);
+	ret = smb347_get_property_locked(psy, prop, val);
+	enable_irq(client->irq);
+
+	return ret;
+}
+
 static enum power_supply_property smb347_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
@@ -1241,7 +1244,6 @@ static int smb347_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, smb);
 
-	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
 	smb->id = id->driver_data;
 
-- 
2.25.0

