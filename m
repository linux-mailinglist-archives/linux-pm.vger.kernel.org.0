Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E171F0C05
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgFGOpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFGOp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB12C08C5C4;
        Sun,  7 Jun 2020 07:45:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so8647179lfd.1;
        Sun, 07 Jun 2020 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dnm55LPV4I5FaW0ETeal110l8gkWvJ9UEI6lX4aXrUQ=;
        b=QpYBWalfdm5/U6Ur/lcg4N9+sdN7t7fH7BFQEBVN8wsfLfebeL921zAbP0LE9xLf4n
         cfMZ174f7Oe5QgNqy6gAR2ajugQYiPMq/nO1paaqkd8a1rrIaIsBNRj+Q+nffWEs/tO7
         yXb1URlEtuasgwaUttHWeMSMtEDw7U9Ck/chAQ/OGDG1asfUsBUOvvUPZgrl9DvaTwAh
         PzFf4JgqiZvGLrgKXF6TngOiqV8Cb1Cz9fCzy6DvGjv6UjeEY7DPJ051dCuaVFjaHHR3
         PtnAA7xC0C0sM6uDt/1DNLJHSRGo61ZGoTzqaA3SG9pD17E4VXS5MqsGF+8p1fkF8TPK
         58Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dnm55LPV4I5FaW0ETeal110l8gkWvJ9UEI6lX4aXrUQ=;
        b=nDBwiZyWCffl7ebe/2FOFClBc9u7RumNZf1caTofn4/3b+uQg2R0u7UO8jmObDL/B8
         ZYxuavcHOZF/juBzh4LpjdLy8AKm+/8mu9JXzn1H5NlRhVkGZKZbYBla5CHCOWRmqpq5
         QiL8c8i/AGwIIRMws+heeWsBJGaX3XQhc6DDzVg8RuQDYppC6vL7btyxmA9Jug7h+X7v
         HeVhpH6T80OmlTboBYShvviz5NnJEGtg+37vu9lNsfpfYy31AFQWQykpfufZTKGQ+5kH
         gymm5E2clTcNR0iFaOKxyJ55P80fSX90GooeymqXo6z+dp1dsQ0ZwHfhHYHSB2ufgmBq
         lPxw==
X-Gm-Message-State: AOAM53187iGyZHrbIUuh/mTt9cMfAFAsht4NAyu+vK0bXkPdBHj0Pprn
        /4pEJUrYmpGPdM2/DuvvTtw=
X-Google-Smtp-Source: ABdhPJxqCGXwRdxWgmMPXBJqbVQoqQWNpsVdnmWACplaY39+Pj63+V4566bcBdpp1zweqrUMSos6Gg==
X-Received: by 2002:a19:2250:: with SMTP id i77mr10392557lfi.133.1591541125560;
        Sun, 07 Jun 2020 07:45:25 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 8/9] power: supply: smb347-charger: Replace mutex with IRQ disable/enable
Date:   Sun,  7 Jun 2020 17:41:12 +0300
Message-Id: <20200607144113.10202-9-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's simply disable/enable IRQ rather than use a mutex that protects from
racing with the interrupt handler. The result of this patch is that it's a
bit easier now to follow the driver's code.

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 38 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 335b6ee494e4..ec68ab2bce27 100644
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
@@ -1273,7 +1276,6 @@ static int smb347_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, smb);
 
-	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
 	smb->id = id->driver_data;
 
-- 
2.26.0

