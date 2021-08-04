Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125D33DFFCC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhHDLD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbhHDLDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:03:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6499C0613D5;
        Wed,  4 Aug 2021 04:03:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so2548308plk.13;
        Wed, 04 Aug 2021 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sa/54MoTBKoG2PK7xRr6gc5uJIE4iaKki/KNCSsDWfk=;
        b=SNDCJuNxfWBvjNS/tc48F3zWKBKQlmZCEI2s1Yd2y/vIlPdS0hl2rfrh6s+PqVtO6N
         gG8j7wDwGPXl8wWYEwgzQ3gUzy/CQp60U8XB3La4Z62vG9TeH+P34Z0aSR2WugyZ1ymL
         ZcFcueb9eOtenc7srxmkbN6QReGUBw/ved35YC/4NEwigGwriT5LhPZDjMDpS2+Mo0hc
         zyAH9FVHVNyOFki9+Q3z52Ct1ZFnn36I75sfUAX2yiT0hc74D1BYqrbkYCr++Rwo95OU
         ueDY31j7VuUvqRC0gn0YICkAoUQg4O5zUj4AyQ8movKFol8I+i0jULSflxZ8RhWVyAZd
         xC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sa/54MoTBKoG2PK7xRr6gc5uJIE4iaKki/KNCSsDWfk=;
        b=jWuvDOjKSsEsCOHgFU5CKvv15mbT5sV+0jQeq+AGmkUjjpfyBxCBY/W/b79OvuGY/y
         ZBLga1pOUdnO4DkX6X4svkCb2y8ujtvqG7OB6zlLNbXMCtQ8qV8rdFUqpcZN0/qEUxIb
         G+0dFCEGakPC54Fa9duIDkCPurN9EWLR0EMziVuSXa0NRLogtu9rexiZG8j3MeMyw7uy
         jKWZfPOJXmQ9bfVIBhUSSpVnY4rQg+EbJDUsjsN8764+4z9W49/dFgcBiFceZ2w9cnCL
         eluLNIiQZiYOyxUWorMIofWn9Cl1ww++Wquc+flzy7yOUb5MMz7f4O6CdPV5YPnJd9Rd
         Xn3g==
X-Gm-Message-State: AOAM530G05bvxoMsJsVSZDvBN123cNFtZzh7eH7EuyVwIfeghzZA6uHR
        ukRI56KQfIA5prj18ygRu4cHoi9fCfnjn6pE
X-Google-Smtp-Source: ABdhPJxxdAYU4W3ViEW5MLSntrSnQRt5V/xWdD14VFDP8jgxSsSftmIVxQiJIAazGaTLywB++nK7Sg==
X-Received: by 2002:a17:90a:cc8:: with SMTP id 8mr28131544pjt.194.1628075022521;
        Wed, 04 Aug 2021 04:03:42 -0700 (PDT)
Received: from wangting-OptiPlex-7050.mioffice.cn ([2408:8607:1b00:7:529a:4cff:fe0e:1dd3])
        by smtp.gmail.com with ESMTPSA id f6sm2306220pfv.69.2021.08.04.04.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:03:42 -0700 (PDT)
From:   Ting Wang <zxc52fgh@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: [PATCH v11 1/4] power: supply: core: add quick charge type property
Date:   Wed,  4 Aug 2021 19:01:58 +0800
Message-Id: <0d7753ae1e908f38a650eb6565de65f9f7c56e28.1627992564.git.wangting11@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: wangting11 <wangting11@xiaomi.com>

Reports the kind of quick charge type based on
different adapter power.

Signed-off-by: wangting11 <wangting11@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 21 ++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 drivers/power/supply/qcom_smbb.c            | 81 ++++++++++++++++++++-
 include/linux/power_supply.h                | 14 ++++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..a49e1049cd9b 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -736,3 +736,24 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/<supply_name>/quick_charge_type
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+		Description:
+		Reports the kind of quick charge type based on different adapter power.
+		Different quick charge type represent different charging power.
+		QUICK_CHARGE_NORMAL : Charging Power <= 10W
+		QUICK_CHARGE_FAST : 10W < Charging Power <= 20W
+		QUICK_CHARGE_FLASH : 20W < Charging Power <= 30W
+		QUICK_CHARGE_TURBE : 30W < Charging Power <= 50W
+		QUICK_CHARGE_SUPER : Charging Power > 50W
+
+		Access: Read-Only
+		Valid values:
+			0: QUICK_CHARGE_NORMAL,
+			1: QUICK_CHARGE_FAST,
+			2: QUICK_CHARGE_FLASH,
+			3: QUICK_CHARGE_TURBE,
+			4: QUICK_CHARGE_SUPER.
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..21f0ab748e5e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -211,6 +211,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 };
 
 static struct attribute *
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec720..21ddfa39f655 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -90,6 +90,12 @@
 #define STATUS_CHG_FAST		BIT(7) /* Fast charging */
 #define STATUS_CHG_GONE		BIT(8) /* No charger is connected */
 
+#define IMAX_NORMAL		2000000
+#define IMAX_FAST		4000000
+#define IMAX_FLASH		6000000
+#define IMAX_TURBE		10000000
+#define IMAX_SUPER		12000000
+
 enum smbb_attr {
 	ATTR_BAT_ISAFE,
 	ATTR_BAT_IMAX,
@@ -111,6 +117,7 @@ struct smbb_charger {
 
 	bool dc_disabled;
 	bool jeita_ext_temp;
+	bool pd_verifed;
 	unsigned long status;
 	struct mutex statlock;
 
@@ -485,6 +492,58 @@ static const struct smbb_irq {
 	{ "dc-valid", smbb_dc_valid_handler },
 };
 
+struct quick_charge {
+	enum power_supply_type adap_type;
+	enum power_supply_quick_charge_type adap_cap;
+};
+
+static struct quick_charge adapter_cap[10] = {
+	{ POWER_SUPPLY_TYPE_USB,		QUICK_CHARGE_NORMAL },
+	{ POWER_SUPPLY_TYPE_USB_DCP,		QUICK_CHARGE_NORMAL },
+	{ POWER_SUPPLY_TYPE_USB_CDP,		QUICK_CHARGE_NORMAL },
+	{ POWER_SUPPLY_TYPE_USB_ACA,		QUICK_CHARGE_NORMAL },
+	{ POWER_SUPPLY_TYPE_USB_FLOAT,		QUICK_CHARGE_NORMAL },
+	{ POWER_SUPPLY_TYPE_USB_PD,		QUICK_CHARGE_FAST },
+	{ POWER_SUPPLY_TYPE_USB_HVDCP,		QUICK_CHARGE_FAST },
+	{ POWER_SUPPLY_TYPE_USB_HVDCP_3,	QUICK_CHARGE_FAST },
+	{ POWER_SUPPLY_TYPE_USB_HVDCP_3P5,	QUICK_CHARGE_FAST },
+	{0, 0},
+};
+
+static int get_quick_charge_type(struct smbb_charger *chg)
+{
+	union power_supply_propval prop = {0, };
+	int charger_type, rc;
+	int i = 0;
+
+	rc = power_supply_get_property(chg->bat_psy,
+			POWER_SUPPLY_PROP_STATUS, &prop);
+	if (rc < 0)
+		return rc;
+	if (prop.intval == POWER_SUPPLY_STATUS_DISCHARGING)
+		return 0;
+
+	rc = power_supply_get_property(chg->usb_psy,
+			POWER_SUPPLY_PROP_USB_TYPE, &prop);
+	if (rc < 0)
+		return rc;
+	charger_type = prop.intval;
+
+	/* when pd adapter is authenticated successfully */
+	if ((charger_type == POWER_SUPPLY_TYPE_USB_PD) && chg->pd_verifed) {
+		return QUICK_CHARGE_TURBE;
+	}
+
+	while (adapter_cap[i].adap_type != 0) {
+		if (charger_type == adapter_cap[i].adap_type) {
+			return adapter_cap[i].adap_cap;
+		}
+		i++;
+	}
+
+	return 0;
+}
+
 static int smbb_usbin_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
@@ -505,6 +564,9 @@ static int smbb_usbin_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
 		val->intval = 2500000;
 		break;
+	case POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE:
+		val->intval = get_quick_charge_type(chg);
+		break;
 	default:
 		rc = -EINVAL;
 		break;
@@ -662,11 +724,27 @@ static int smbb_battery_set_property(struct power_supply *psy,
 		const union power_supply_propval *val)
 {
 	struct smbb_charger *chg = power_supply_get_drvdata(psy);
+	int charger_type, bat_imax;
 	int rc;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		rc = smbb_charger_attr_write(chg, ATTR_BAT_IMAX, val->intval);
+		charger_type = get_quick_charge_type(chg);
+		if (charger_type == QUICK_CHARGE_NORMAL)
+			bat_imax = IMAX_NORMAL;
+		else if (charger_type == QUICK_CHARGE_FAST)
+			bat_imax = IMAX_FAST;
+		else if (charger_type == QUICK_CHARGE_FLASH)
+			bat_imax = IMAX_FLASH;
+		else if (charger_type == QUICK_CHARGE_TURBE)
+			bat_imax = IMAX_TURBE;
+		else if (charger_type == QUICK_CHARGE_SUPER)
+			bat_imax = IMAX_SUPER;
+		else
+			bat_imax = IMAX_NORMAL;
+
+		bat_imax = min(val->intval, bat_imax);
+		rc = smbb_charger_attr_write(chg, ATTR_BAT_IMAX, bat_imax);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		rc = smbb_charger_attr_write(chg, ATTR_BAT_VMAX, val->intval);
@@ -695,6 +773,7 @@ static enum power_supply_property smbb_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 static enum power_supply_property smbb_battery_properties[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index be203985ecdd..3dc3e53c5df1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -171,6 +171,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 enum power_supply_type {
@@ -187,6 +188,10 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_USB_HVDCP,		/* High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_HVDCP_3,		/* Efficient High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_HVDCP_3P5,	/* Efficient High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_FLOAT,		/* Floating charger */
 };
 
 enum power_supply_usb_type {
@@ -202,6 +207,15 @@ enum power_supply_usb_type {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_quick_charge_type {
+	QUICK_CHARGE_NORMAL = 0,		/* Charging Power <= 10W */
+	QUICK_CHARGE_FAST,			/* 10W < Charging Power <= 20W */
+	QUICK_CHARGE_FLASH,			/* 20W < Charging Power <= 30W */
+	QUICK_CHARGE_TURBE,			/* 30W < Charging Power <= 50W */
+	QUICK_CHARGE_SUPER,			/* Charging Power > 50W */
+	QUICK_CHARGE_MAX,
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
-- 
2.17.1

