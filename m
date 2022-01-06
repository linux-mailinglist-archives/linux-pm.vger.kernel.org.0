Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC2486377
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiAFLHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238272AbiAFLHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qkTNmWnc3phfhbRg8XjDjwjKrFAyQoXk8W3qfdXeSI=;
        b=NneY50esMyg4HUoS7RbP/eREu/s9Emi2l8bwHH8+UW4a86ltQefEBiBkwDcYxoeWpqFP/6
        1g2y10p2gQnAWKFeC2SRJiNUWryavr9NFXviel4kWP8ohVMC/Dc8SZ4lMB6gSRQQ+Df1KT
        Un4GWDRZyfuMsbY6PrypRhizfrnBEZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-FiGWTnIgPZK_3Kw3CLWIEw-1; Thu, 06 Jan 2022 06:06:47 -0500
X-MC-Unique: FiGWTnIgPZK_3Kw3CLWIEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3712F2C;
        Thu,  6 Jan 2022 11:06:46 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D97F0752AE;
        Thu,  6 Jan 2022 11:06:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 7/7] power: supply: axp288_fuel_gauge: Add a no_current_sense_res module_param
Date:   Thu,  6 Jan 2022 12:06:08 +0100
Message-Id: <20220106110608.66231-7-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some boards with an AXP288 fuel-gauge appear to have a broken (approx.
2 milli-ohm instead of 10) current sense resistor.

This makes the coulomb-counter part of the fuel-gauge useless, but the
OCV based capacity reporting is still working. Add a no_current_sense_res
module_param to disable use of the coulomb-counter using parts of the
fuel-gauge to allow users to work around this.

Note this is a module parameter and not done through DMI quirks, since
this seems to be a defect on some boards, not something which all boards
of the same model share.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 33 +++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 53d0e82bbb3e..dcedbc59732d 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -88,6 +88,11 @@
 
 #define AXP288_REG_UPDATE_INTERVAL		(60 * HZ)
 #define AXP288_FG_INTR_NUM			6
+
+static bool no_current_sense_res;
+module_param(no_current_sense_res, bool, 0444);
+MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resisitor");
+
 enum {
 	QWBTU_IRQ = 0,
 	WBTU_IRQ,
@@ -137,12 +142,13 @@ static enum power_supply_property fuel_gauge_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	/* The 3 props below are not used when no_current_sense_res is set */
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
@@ -224,7 +230,10 @@ static int fuel_gauge_update_registers(struct axp288_fg_info *info)
 		goto out;
 	info->pwr_stat = ret;
 
-	ret = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
+	if (no_current_sense_res)
+		ret = fuel_gauge_reg_readb(info, AXP288_FG_OCV_CAP_REG);
+	else
+		ret = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
 	if (ret < 0)
 		goto out;
 	info->fg_res = ret;
@@ -233,6 +242,14 @@ static int fuel_gauge_update_registers(struct axp288_fg_info *info)
 	if (ret < 0)
 		goto out;
 
+	ret = fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG);
+	if (ret < 0)
+		goto out;
+	info->ocv = ret;
+
+	if (no_current_sense_res)
+		goto out_no_current_sense_res;
+
 	if (info->pwr_stat & PS_STAT_BAT_CHRG_DIR) {
 		info->d_curr = 0;
 		ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &info->c_curr);
@@ -245,11 +262,6 @@ static int fuel_gauge_update_registers(struct axp288_fg_info *info)
 			goto out;
 	}
 
-	ret = fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG);
-	if (ret < 0)
-		goto out;
-	info->ocv = ret;
-
 	ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
 	if (ret < 0)
 		goto out;
@@ -260,6 +272,7 @@ static int fuel_gauge_update_registers(struct axp288_fg_info *info)
 		goto out;
 	info->fg_des_cap1 = ret;
 
+out_no_current_sense_res:
 	info->last_updated = jiffies;
 	info->valid = 1;
 	ret = 0;
@@ -292,7 +305,7 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 	 * When this happens the AXP288 reports a not-charging status and
 	 * 0 mA discharge current.
 	 */
-	if (fg_res < 90 || (pwr_stat & PS_STAT_BAT_CHRG_DIR))
+	if (fg_res < 90 || (pwr_stat & PS_STAT_BAT_CHRG_DIR) || no_current_sense_res)
 		goto not_full;
 
 	if (curr == 0) {
@@ -494,7 +507,7 @@ static void fuel_gauge_external_power_changed(struct power_supply *psy)
 	power_supply_changed(info->bat);
 }
 
-static const struct power_supply_desc fuel_gauge_desc = {
+static struct power_supply_desc fuel_gauge_desc = {
 	.name			= DEV_NAME,
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.properties		= fuel_gauge_props,
@@ -719,6 +732,8 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		return ret;
 
 	psy_cfg.drv_data = info;
+	if (no_current_sense_res)
+		fuel_gauge_desc.num_properties = ARRAY_SIZE(fuel_gauge_props) - 3;
 	info->bat = devm_power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
 		ret = PTR_ERR(info->bat);
-- 
2.33.1

