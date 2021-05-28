Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAC394859
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhE1Vbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE1Vbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 17:31:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E94C061760;
        Fri, 28 May 2021 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HWVwP5ooJ1imwSBIdPcFDTfrbTd9vBy5EFvBDkKcBQw=; b=duKg0vM8Irlo2QkUFXuzlEoud4
        nBUAkLVCrbzPQiEy2CoiQNCn6ZDcDiqajQYD4pVhb1Jx1ggXYQLuorXb4XRaotkAujOzl7DOI9jdA
        Jddy+Jot46gQHxVBQtnNczbu3mHmOmHPJZBJ5NFuLhEiFcsSUqSmBW8FgYJEcNkp1fl8=;
Received: from p200300ccff0cdc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3U-00005o-Jh; Fri, 28 May 2021 23:30:09 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3U-0000yb-AI; Fri, 28 May 2021 23:30:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] power: supply: rn5t618: Add input current limit
Date:   Fri, 28 May 2021 23:30:06 +0200
Message-Id: <20210528213006.3695-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210528213006.3695-1-andreas@kemnade.info>
References: <20210528213006.3695-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adds properties for setting the maximum current to USB, ADP and Battery
supplies. USB and ADP limits are reset to OTP values upon replugging.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/rn5t618_power.c | 188 +++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index f8f00f67ce4c..819061918b2a 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -44,6 +44,20 @@
 
 #define FG_ENABLE 1
 
+/*
+ * Formula seems accurate for battery current, but for USB current around 70mA
+ * per step was seen on Kobo Clara HD but all sources show the same formula
+ * also fur USB current. To avoid accidentially unwanted high currents we stick
+ * to that formula
+ */
+#define TO_CUR_REG(x) ((x) / 100000 - 1)
+#define FROM_CUR_REG(x) ((((x) & 0x1f) + 1) * 100000)
+#define CHG_MIN_CUR 100000
+#define CHG_MAX_CUR 1800000
+#define ADP_MAX_CUR 2500000
+#define USB_MAX_CUR 1400000
+
+
 struct rn5t618_power_info {
 	struct rn5t618 *rn5t618;
 	struct platform_device *pdev;
@@ -61,12 +75,16 @@ static enum power_supply_usb_type rn5t618_usb_types[] = {
 };
 
 static enum power_supply_property rn5t618_usb_props[] = {
+	/* input current limit is not very accurate */
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
 static enum power_supply_property rn5t618_adp_props[] = {
+	/* input current limit is not very accurate */
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 };
@@ -82,6 +100,7 @@ static enum power_supply_property rn5t618_battery_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 };
@@ -271,6 +290,36 @@ static int rn5t618_battery_ttf(struct rn5t618_power_info *info,
 	return 0;
 }
 
+static int rn5t618_battery_set_current_limit(struct rn5t618_power_info *info,
+				const union power_supply_propval *val)
+{
+	if (val->intval < CHG_MIN_CUR)
+		return -EINVAL;
+
+	if (val->intval >= CHG_MAX_CUR)
+		return -EINVAL;
+
+	return regmap_update_bits(info->rn5t618->regmap,
+				  RN5T618_CHGISET,
+				  0x1F, TO_CUR_REG(val->intval));
+}
+
+static int rn5t618_battery_get_current_limit(struct rn5t618_power_info *info,
+					     union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGISET,
+			  &regval);
+	if (ret < 0)
+		return ret;
+
+	val->intval = FROM_CUR_REG(regval);
+
+	return 0;
+}
+
 static int rn5t618_battery_charge_full(struct rn5t618_power_info *info,
 				       union power_supply_propval *val)
 {
@@ -336,6 +385,9 @@ static int rn5t618_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		ret = rn5t618_battery_get_current_limit(info, val);
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = rn5t618_battery_charge_full(info, val);
 		break;
@@ -349,12 +401,38 @@ static int rn5t618_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int rn5t618_battery_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		return rn5t618_battery_set_current_limit(info, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rn5t618_battery_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int rn5t618_adp_get_property(struct power_supply *psy,
 				    enum power_supply_property psp,
 				    union power_supply_propval *val)
 {
 	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
 	unsigned int chgstate;
+	unsigned int regval;
 	bool online;
 	int ret;
 
@@ -377,6 +455,14 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
 		if (val->intval != POWER_SUPPLY_STATUS_CHARGING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(info->rn5t618->regmap,
+				  RN5T618_REGISET1, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = FROM_CUR_REG(regval);
 		break;
 	default:
 		return -EINVAL;
@@ -385,6 +471,45 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int rn5t618_adp_set_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    const union power_supply_propval *val)
+{
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval > ADP_MAX_CUR)
+			return -EINVAL;
+
+		if (val->intval < CHG_MIN_CUR)
+			return -EINVAL;
+
+		ret = regmap_write(info->rn5t618->regmap, RN5T618_REGISET1,
+				   TO_CUR_REG(val->intval));
+		if (ret < 0)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rn5t618_adp_property_is_writeable(struct power_supply *psy,
+					     enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int rc5t619_usb_get_type(struct rn5t618_power_info *info,
 				union power_supply_propval *val)
 {
@@ -418,6 +543,7 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 {
 	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
 	unsigned int chgstate;
+	unsigned int regval;
 	bool online;
 	int ret;
 
@@ -446,6 +572,23 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 			return -ENODATA;
 
 		return rc5t619_usb_get_type(info, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGCTL1,
+				  &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = 0;
+		if (regval & 2) {
+			ret = regmap_read(info->rn5t618->regmap,
+					  RN5T618_REGISET2,
+					  &regval);
+			if (ret < 0)
+				return ret;
+
+			val->intval = FROM_CUR_REG(regval);
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -453,12 +596,53 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int rn5t618_usb_set_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    const union power_supply_propval *val)
+{
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval > USB_MAX_CUR)
+			return -EINVAL;
+
+		if (val->intval < CHG_MIN_CUR)
+			return -EINVAL;
+
+		ret = regmap_write(info->rn5t618->regmap, RN5T618_REGISET2,
+				   0xE0 | TO_CUR_REG(val->intval));
+		if (ret < 0)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rn5t618_usb_property_is_writeable(struct power_supply *psy,
+					     enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct power_supply_desc rn5t618_battery_desc = {
 	.name                   = "rn5t618-battery",
 	.type                   = POWER_SUPPLY_TYPE_BATTERY,
 	.properties             = rn5t618_battery_props,
 	.num_properties         = ARRAY_SIZE(rn5t618_battery_props),
 	.get_property           = rn5t618_battery_get_property,
+	.set_property           = rn5t618_battery_set_property,
+	.property_is_writeable  = rn5t618_battery_property_is_writeable,
 };
 
 static const struct power_supply_desc rn5t618_adp_desc = {
@@ -467,6 +651,8 @@ static const struct power_supply_desc rn5t618_adp_desc = {
 	.properties             = rn5t618_adp_props,
 	.num_properties         = ARRAY_SIZE(rn5t618_adp_props),
 	.get_property           = rn5t618_adp_get_property,
+	.set_property           = rn5t618_adp_set_property,
+	.property_is_writeable  = rn5t618_adp_property_is_writeable,
 };
 
 static const struct power_supply_desc rn5t618_usb_desc = {
@@ -477,6 +663,8 @@ static const struct power_supply_desc rn5t618_usb_desc = {
 	.properties             = rn5t618_usb_props,
 	.num_properties         = ARRAY_SIZE(rn5t618_usb_props),
 	.get_property           = rn5t618_usb_get_property,
+	.set_property           = rn5t618_usb_set_property,
+	.property_is_writeable  = rn5t618_usb_property_is_writeable,
 };
 
 static irqreturn_t rn5t618_charger_irq(int irq, void *data)
-- 
2.29.2

