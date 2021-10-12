Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B915429D55
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 07:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhJLFse (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 01:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232254AbhJLFsd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634017592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KguWvQDYZIA8Q0Omvv5IVY7vWVbGRkWdvLgicv5hIx4=;
        b=AYV0PH4fWyq5Dk1rg4EcOJ7zTOFFAfY08zyt8Ciu7sWwkTvHO7mMEmlxTQ6vrNSvxJmnRm
        FqOm4hjmp0YYZvls8Bg/T0uJEKxw01h7v104i4wFYUPT6EACyGrNp0Wd7uRO0+84t2dYNT
        9gRErII+YPcjTgg95ea8FU0pB+NuAz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-rjpD7aZlOLC4NFoan8mOiA-1; Tue, 12 Oct 2021 01:46:30 -0400
X-MC-Unique: rjpD7aZlOLC4NFoan8mOiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D8A918125C0;
        Tue, 12 Oct 2021 05:46:29 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C514C5F707;
        Tue, 12 Oct 2021 05:46:21 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        hen-Yu Tsai <wens@csie.org>
Cc:     Kate Hsuan <hpa@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp288-charger: Optimize register reading method
Date:   Tue, 12 Oct 2021 13:45:45 +0800
Message-Id: <20211012054545.27314-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The original implementation access the charger the same register value
several times to get the charger status, such as online, enabled, and
bus limits. It takes a long time and bandwidth for every "status get"
operation. 

To reduce the access of the register and save bandwidth, this commit
integrated every read operation into only one "register value get" 
operation and cache them in the variables. Once the "get properties"
is requested from the user space, the cached information can be returned
immediately.

I2C access between Linux kernel and P-Unit is improved by explicitly taking
semaphore once for the entire set of register accesses in the new
axp288_charger_usb_update_property() function. The I2C-Bus to the XPower
AXP288 is shared between the Linux kernel and SoCs P-Unit. The P-Unit
has a semaphore which the kernel must "lock" before it may use the bus.
If not explicitly taken by the I2C-Driver, then this semaphore is
automatically taken by the I2C-bus-driver for each I2C-transfer. In
other words, the semaphore will be locked and released several times for
entire set of register accesses.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 150 +++++++++++++++++---------
 1 file changed, 99 insertions(+), 51 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index b9553be9bed5..fd4983c98fd9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -22,6 +22,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/extcon.h>
 #include <linux/dmi.h>
+#include <asm/iosf_mbi.h>
 
 #define PS_STAT_VBUS_TRIGGER		BIT(0)
 #define PS_STAT_BAT_CHRG_DIR		BIT(2)
@@ -95,6 +96,8 @@
 #define CV_4200MV			4200	/* 4200mV */
 #define CV_4350MV			4350	/* 4350mV */
 
+#define AXP288_REG_UPDATE_INTERVAL	(60 * HZ)
+
 #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
 #define USB_HOST_EXTCON_HID		"INT3496"
 #define USB_HOST_EXTCON_NAME		"INT3496:00"
@@ -118,6 +121,7 @@ struct axp288_chrg_info {
 	struct regmap_irq_chip_data *regmap_irqc;
 	int irq[CHRG_INTR_END];
 	struct power_supply *psy_usb;
+	struct mutex lock;
 
 	/* OTG/Host mode */
 	struct {
@@ -138,6 +142,12 @@ struct axp288_chrg_info {
 	int cv;
 	int max_cc;
 	int max_cv;
+
+	unsigned long last_updated;
+	unsigned int input_status;
+	unsigned int op_mode;
+	unsigned int backend_control;
+	bool valid;
 };
 
 static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, int cc)
@@ -197,11 +207,8 @@ static inline int axp288_charger_set_cv(struct axp288_chrg_info *info, int cv)
 static int axp288_charger_get_vbus_inlmt(struct axp288_chrg_info *info)
 {
 	unsigned int val;
-	int ret;
 
-	ret = regmap_read(info->regmap, AXP20X_CHRG_BAK_CTRL, &val);
-	if (ret < 0)
-		return ret;
+	val = info->backend_control;
 
 	val >>= CHRG_VBUS_ILIM_BIT_POS;
 	switch (val) {
@@ -297,55 +304,34 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 
 static int axp288_charger_is_present(struct axp288_chrg_info *info)
 {
-	int ret, present = 0;
-	unsigned int val;
-
-	ret = regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
-	if (ret < 0)
-		return ret;
+	int present = 0;
 
-	if (val & PS_STAT_VBUS_PRESENT)
+	if (info->input_status & PS_STAT_VBUS_PRESENT)
 		present = 1;
 	return present;
 }
 
 static int axp288_charger_is_online(struct axp288_chrg_info *info)
 {
-	int ret, online = 0;
-	unsigned int val;
-
-	ret = regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
-	if (ret < 0)
-		return ret;
+	int online = 0;
 
-	if (val & PS_STAT_VBUS_VALID)
+	if (info->input_status & PS_STAT_VBUS_VALID)
 		online = 1;
 	return online;
 }
 
 static int axp288_get_charger_health(struct axp288_chrg_info *info)
 {
-	int ret, pwr_stat, chrg_stat;
 	int health = POWER_SUPPLY_HEALTH_UNKNOWN;
-	unsigned int val;
 
-	ret = regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
-	if ((ret < 0) || !(val & PS_STAT_VBUS_PRESENT))
+	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
 		goto health_read_fail;
-	else
-		pwr_stat = val;
 
-	ret = regmap_read(info->regmap, AXP20X_PWR_OP_MODE, &val);
-	if (ret < 0)
-		goto health_read_fail;
-	else
-		chrg_stat = val;
-
-	if (!(pwr_stat & PS_STAT_VBUS_VALID))
+	if (!(info->input_status & PS_STAT_VBUS_VALID))
 		health = POWER_SUPPLY_HEALTH_DEAD;
-	else if (chrg_stat & CHRG_STAT_PMIC_OTP)
+	else if (info->op_mode & CHRG_STAT_PMIC_OTP)
 		health = POWER_SUPPLY_HEALTH_OVERHEAT;
-	else if (chrg_stat & CHRG_STAT_BAT_SAFE_MODE)
+	else if (info->op_mode & CHRG_STAT_BAT_SAFE_MODE)
 		health = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
 	else
 		health = POWER_SUPPLY_HEALTH_GOOD;
@@ -362,30 +348,86 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 	int ret = 0;
 	int scaled_val;
 
+	mutex_lock(&info->lock);
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		scaled_val = min(val->intval, info->max_cc);
 		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
 		ret = axp288_charger_set_cc(info, scaled_val);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(&info->pdev->dev, "set charge current failed\n");
+			goto out;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		scaled_val = min(val->intval, info->max_cv);
 		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
 		ret = axp288_charger_set_cv(info, scaled_val);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
+			goto out;
+		}
 		break;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = axp288_charger_set_vbus_inlmt(info, val->intval);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(&info->pdev->dev, "set input current limit failed\n");
+			goto out;
+		}
+		info->valid = false;
 		break;
 	default:
 		ret = -EINVAL;
 	}
 
+out:
+	mutex_unlock(&info->lock);
+	return ret;
+}
+
+static int axp288_charger_reg_readb(struct axp288_chrg_info *info, int reg, unsigned int *ret_val)
+{
+	int ret;
+
+	ret = regmap_read(info->regmap, reg, ret_val);
+	if (ret < 0) {
+		dev_err(&info->pdev->dev, "Error %d on reading value from register 0x%04x\n",
+			ret,
+			reg);
+		return ret;
+	}
+	return 0;
+}
+
+static int axp288_charger_usb_update_property(struct axp288_chrg_info *info)
+{
+	int ret = 0;
+
+	if (info->valid && time_before(jiffies, info->last_updated + AXP288_REG_UPDATE_INTERVAL))
+		return 0;
+
+	dev_dbg(&info->pdev->dev, "Charger updating register values...\n");
+
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		return ret;
+
+	ret = axp288_charger_reg_readb(info, AXP20X_PWR_INPUT_STATUS, &info->input_status);
+	if (ret < 0)
+		goto out;
+
+	ret = axp288_charger_reg_readb(info, AXP20X_PWR_OP_MODE, &info->op_mode);
+	if (ret < 0)
+		goto out;
+
+	ret = axp288_charger_reg_readb(info, AXP20X_CHRG_BAK_CTRL, &info->backend_control);
+	if (ret < 0)
+		goto out;
+
+	info->last_updated = jiffies;
+	info->valid = true;
+out:
+	iosf_mbi_unblock_punit_i2c_access();
 	return ret;
 }
 
@@ -396,6 +438,11 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 	struct axp288_chrg_info *info = power_supply_get_drvdata(psy);
 	int ret;
 
+	mutex_lock(&info->lock);
+	ret = axp288_charger_usb_update_property(info);
+	if (ret < 0)
+		goto out;
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 		/* Check for OTG case first */
@@ -403,10 +450,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 			val->intval = 0;
 			break;
 		}
-		ret = axp288_charger_is_present(info);
-		if (ret < 0)
-			return ret;
-		val->intval = ret;
+		val->intval = axp288_charger_is_present(info);
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		/* Check for OTG case first */
@@ -414,10 +458,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 			val->intval = 0;
 			break;
 		}
-		ret = axp288_charger_is_online(info);
-		if (ret < 0)
-			return ret;
-		val->intval = ret;
+		val->intval = axp288_charger_is_online(info);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		val->intval = axp288_get_charger_health(info);
@@ -435,16 +476,15 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 		val->intval = info->max_cv * 1000;
 		break;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = axp288_charger_get_vbus_inlmt(info);
-		if (ret < 0)
-			return ret;
-		val->intval = ret;
+		val->intval = axp288_charger_get_vbus_inlmt(info);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&info->lock);
+	return ret;
 }
 
 static int axp288_charger_property_is_writeable(struct power_supply *psy,
@@ -540,7 +580,9 @@ static irqreturn_t axp288_charger_irq_thread_handler(int irq, void *dev)
 		dev_warn(&info->pdev->dev, "Spurious Interrupt!!!\n");
 		goto out;
 	}
-
+	mutex_lock(&info->lock);
+	info->valid = false;
+	mutex_unlock(&info->lock);
 	power_supply_changed(info->psy_usb);
 out:
 	return IRQ_HANDLED;
@@ -613,6 +655,9 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	if (!(val & PS_STAT_VBUS_VALID)) {
 		dev_dbg(&info->pdev->dev, "USB charger disconnected\n");
 		axp288_charger_enable_charger(info, false);
+		mutex_lock(&info->lock);
+		info->valid = false;
+		mutex_unlock(&info->lock);
 		power_supply_changed(info->psy_usb);
 		return;
 	}
@@ -644,6 +689,9 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 		dev_err(&info->pdev->dev,
 			"error setting current limit (%d)\n", ret);
 
+	mutex_lock(&info->lock);
+	info->valid = false;
+	mutex_unlock(&info->lock);
 	power_supply_changed(info->psy_usb);
 }
 
-- 
2.31.1

