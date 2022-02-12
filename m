Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DEE4B3695
	for <lists+linux-pm@lfdr.de>; Sat, 12 Feb 2022 17:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiBLQs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 11:48:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiBLQs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 11:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E954513F68
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644684503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRRkibeH07wILx8KGIFNrxG+OQELEnH9cLHCPVOxDsc=;
        b=jLEi2ZxcmLMWIGZd4/cj8AuxBciD6SjQO9aMEcq9sFjnk7+qeG9W22Z69ScSFxqBwWeafE
        5kDtm3d8zS/KUvluqY/WOvAJKMqWlUGiWNzzOf5VqftYtfApA/MQ20dd1zrAy39ZtLFiwK
        QmEmmCHW81OAOb3iAiWbXDogQzD7YSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-sSYjVZBfMtaarbaFOJuFyA-1; Sat, 12 Feb 2022 11:48:21 -0500
X-MC-Unique: sSYjVZBfMtaarbaFOJuFyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B23B21091DA1;
        Sat, 12 Feb 2022 16:48:20 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BECCC753EB;
        Sat, 12 Feb 2022 16:48:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] power: supply: bq24190_charger: Delay applying charge_type changes when OTG 5V Vbus boost is on
Date:   Sat, 12 Feb 2022 17:48:17 +0100
Message-Id: <20220212164817.204323-2-hdegoede@redhat.com>
In-Reply-To: <20220212164817.204323-1-hdegoede@redhat.com>
References: <20220212164817.204323-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recently userspace has started switching power_supply class devices with
a charge_type psy-property between fast and trickle charge mode, see:
https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/85

Before this patch bq24190_charger_set_charge_type() would unconditionally
write charging or none to the BQ24190_REG_POC_CHG_CONFIG bits, replacing
the otg setting of those bits when the OTG 5V Vbus boost converter was on,
turning the 5V Vbus off, removing the power from any attached peripherals.

This fixes this by keeping track of otg_vbus_enabled and the requested
charger_type settings and when otg_vbus_enabled is true, delay applying
the charger_type until the 5V boost converter is turned off.

Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 41 +++++++++++++++++++-------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index dcbfd97a55be..aa1a589eb9f2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -163,6 +163,8 @@ struct bq24190_dev_info {
 	char				model_name[I2C_NAME_SIZE];
 	bool				initialized;
 	bool				irq_event;
+	bool				otg_vbus_enabled;
+	int				charge_type;
 	u16				sys_min;
 	u16				iprechg;
 	u16				iterm;
@@ -176,6 +178,9 @@ struct bq24190_dev_info {
 	u8				watchdog;
 };
 
+static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
+					   const union power_supply_propval *val);
+
 static const unsigned int bq24190_usb_extcon_cable[] = {
 	EXTCON_USB,
 	EXTCON_NONE,
@@ -502,8 +507,9 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 }
 #endif
 
-static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
+static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 {
+	union power_supply_propval val = { .intval = bdi->charge_type };
 	int ret;
 
 	ret = pm_runtime_get_sync(bdi->dev);
@@ -513,9 +519,14 @@ static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
 		return ret;
 	}
 
-	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
-				 BQ24190_REG_POC_CHG_CONFIG_MASK,
-				 BQ24190_REG_POC_CHG_CONFIG_SHIFT, val);
+	bdi->otg_vbus_enabled = enable;
+	if (enable)
+		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					 BQ24190_REG_POC_CHG_CONFIG_MASK,
+					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+					 BQ24190_REG_POC_CHG_CONFIG_OTG);
+	else
+		ret = bq24190_charger_set_charge_type(bdi, &val);
 
 	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
@@ -526,14 +537,12 @@ static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 val)
 #ifdef CONFIG_REGULATOR
 static int bq24190_vbus_enable(struct regulator_dev *dev)
 {
-	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
-				       BQ24190_REG_POC_CHG_CONFIG_OTG);
+	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), true);
 }
 
 static int bq24190_vbus_disable(struct regulator_dev *dev)
 {
-	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
-				       BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), false);
 }
 
 static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
@@ -559,8 +568,9 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	if (ret)
 		return ret;
 
-	return (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
-		val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
+	bdi->otg_vbus_enabled = (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
+				 val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
+	return bdi->otg_vbus_enabled;
 }
 
 static const struct regulator_ops bq24190_vbus_ops = {
@@ -807,6 +817,14 @@ static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
 		return -EINVAL;
 	}
 
+	bdi->charge_type = val->intval;
+	/*
+	 * If the 5V Vbus boost regulator is enabled delay setting
+	 * the charge-type until its gets disabled.
+	 */
+	if (bdi->otg_vbus_enabled)
+		return 0;
+
 	if (chg_config) { /* Enabling the charger */
 		ret = bq24190_write_mask(bdi, BQ24190_REG_CCC,
 				BQ24190_REG_CCC_FORCE_20PCT_MASK,
@@ -1788,6 +1806,7 @@ static int bq24190_probe(struct i2c_client *client,
 	bdi->dev = dev;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
+	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
@@ -1925,7 +1944,7 @@ static void bq24190_shutdown(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
 	/* Turn off 5V boost regulator on shutdown */
-	bq24190_set_charge_mode(bdi, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+	bq24190_set_otg_vbus(bdi, false);
 }
 
 static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
-- 
2.33.1

