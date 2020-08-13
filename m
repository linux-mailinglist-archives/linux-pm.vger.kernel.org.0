Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29F24409A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgHMVeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgHMVen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90E9C061757;
        Thu, 13 Aug 2020 14:34:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so3788310lfe.10;
        Thu, 13 Aug 2020 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VKJz7as6Cnf5+ugS7B5We4tFvmDh5J1LQ5Ei+QN204=;
        b=Mdz7ome6uGBEDSOOYK1DK2qGkJ2LyKmz4CprA4KNemfPR/vk6ZmCuWZkqa595YZzfe
         jAT/sVUAp9PADvR4NTiGN/uTzi4qDigHCn0/13Km49+msRgSlVVeG7ngq563LxXT/x8G
         wOCdx+vBhsF1l2OTpSh4HBUbc6RmpcXspSoXTgPMo56wVA2KGEgqLtxDNkxE4mNB0wkX
         Q6ouuCT+pW8M+ZX9cNkVakyjE9HYnpfLQnfyA9rsEnE22sVxL5Ow5b+3rk3L9WuvwR3i
         WiWuS4c4TktAPdapjBdDosIq1VNKRqk02/Xzpbr8E8y6fHFvgMXkWeMaY40eqwmKR5e5
         QJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VKJz7as6Cnf5+ugS7B5We4tFvmDh5J1LQ5Ei+QN204=;
        b=euIsVOHvsSNbFIonFC+ovGHwD7QUAH9aVHykVbDmrlWcj4guKi/GeuXRvWGcJmqGDn
         vU6vNmXwuv6ZX5U83JPm3JcZSX+xMQyH4pn0ZqIfUgFUBZC1/rhRuAOA+Xx3i8nETOBi
         AtnXE82/Yb+idobRMdNfyJGK09R1RoRojkgxs2ZjkFSUwJ3iHZEaP6z7t16KoV+2xESI
         5NX4bg6lao+8A01Ou9Mmi6fw8MrG0FPDScTmRms9qU7T+hTbm9o78bdERBsnn1r6dMS9
         48B76UAqknrxqSg7tG2BAvfdvXR5Y2iiOhi42o1f+evS5GK/Ghf/Qu7fGdFJHhfhF/p5
         KS0A==
X-Gm-Message-State: AOAM531HaRXijLz+eAVx37PnGRKccE602PmeFZl8dF8i+U+FAPErtlXz
        BVJr2Dx5m+ebUeJ7K8gKkAU=
X-Google-Smtp-Source: ABdhPJw39bedeZ+5oHMO7WQ2X8ddte3dC4UDJEKwhsoj6tIuzTJAAHfXFj8f5zPPVwpuQi3ZMdrYbg==
X-Received: by 2002:ac2:546f:: with SMTP id e15mr3217327lfn.133.1597354480140;
        Thu, 13 Aug 2020 14:34:40 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:39 -0700 (PDT)
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
Subject: [PATCH v3 08/10] power: supply: smb347-charger: Replace mutex with IRQ disable/enable
Date:   Fri, 14 Aug 2020 00:34:07 +0300
Message-Id: <20200813213409.24222-9-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
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
2.27.0

