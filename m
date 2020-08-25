Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6C251233
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgHYGkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgHYGkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:40:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6D3C061755;
        Mon, 24 Aug 2020 23:40:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m8so6545626pfh.3;
        Mon, 24 Aug 2020 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNDqjiCIpaut0CuIzazPI/rMTPorZ+MEGeDrCF91VIE=;
        b=NtuL2p2KE/CpmwmHf88kJRdffEWZIUi4VnFkyBFT8zY7prtU/OX4jdfAa6KZIr70N1
         nleJjF/TxFt3Q5w9te6tLtKVXrWsfm9EHwBVHYk5lPtjxr/DDLDBUeO2ePhLBm+f2hOT
         dwNQ5cekSgzy5yx1vIXrSfnEQNd7h5Amt9Jh4gwbDaMqDaYPDln9BFIa5VSAhqxUX3QZ
         wv7eCzwQv8YkmaLIqrElEnJpwPilzQwLhDc+qldEvkocm3OgrcaNjJleTIPwVhHwFoQw
         pyqTF7aU4BmYxwpq3uvrCxStZPk8MNwqNhAPF++lGfT5wJot3sDkpGoytiTeTWunDY34
         RNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNDqjiCIpaut0CuIzazPI/rMTPorZ+MEGeDrCF91VIE=;
        b=mnNdc6lrtRVszQdRryZsqbzvh2c0c7KB2jumrPnLz0e1O8ZNHwjHvDJptEKuw9NB7+
         UFMrQq8MWA3wPdwjRxd+UkW16zv/0rbYqVyV9kU8dOH2pkVkvMocf6XJaywxwJy4OtRQ
         WUNm/K671GY8wzjONAQJiQlbsM5qa7AGjJwlCVkuXXbHp+Py72hI0Z8LXN/PskrPLXxO
         KEnJ6miK5eKNY/ah7BXZJGZY9Z5JXblx0nHHCKdHHXPKkjjkkC0RqbkLlY9XwS0amZ/I
         tHZHfou51PoVtGur0+qP7Dlzf44K2qru+iHXeb0PP3VEXy2w8T3la9vDC5hQSiZ9lnvN
         uMlQ==
X-Gm-Message-State: AOAM530nE04k0KLkKmMxLMd4U5ZyQU1jW1oz7qSXx/yfSW9gluKd7X5m
        CmTEguOwZLJkgncu0+4kjzs=
X-Google-Smtp-Source: ABdhPJyM54lcg3Rsd1ETWjHfIX9hhYqCP+hw3wQAELo7eJhrwYF5hZrKMG6XwB4/uhEH5wAeAQrB9g==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr6258877plr.97.1598337609782;
        Mon, 24 Aug 2020 23:40:09 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z2sm14197283pfq.46.2020.08.24.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:40:09 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v9 1/4] power: supply: core: add quick charge type property
Date:   Tue, 25 Aug 2020 14:37:56 +0800
Message-Id: <eecb88f1b3d7197886ae9c598ef6c05a58916299.1598337073.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598337073.git.huangqiwu@xiaomi.com>
References: <cover.1598337073.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports the kind of quick charge type based on
different adapter power.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 21 ++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 drivers/power/supply/qcom_smbb.c            | 79 +++++++++++++++++++++
 include/linux/power_supply.h                | 14 ++++
 4 files changed, 115 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 216d61a22f1e..dd3773dcf16a 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -708,3 +708,24 @@ Description:
 
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
index bc79560229b5..9554d7907373 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -206,6 +206,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 };
 
 static struct attribute *
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec720..7dbb385531ca 100644
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
@@ -662,10 +724,26 @@ static int smbb_battery_set_property(struct power_supply *psy,
 		const union power_supply_propval *val)
 {
 	struct smbb_charger *chg = power_supply_get_drvdata(psy);
+	int charger_type, bat_imax;
 	int rc;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
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
+		val->intval = min(val->intval, bat_imax)
 		rc = smbb_charger_attr_write(chg, ATTR_BAT_IMAX, val->intval);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
@@ -695,6 +773,7 @@ static enum power_supply_property smbb_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 static enum power_supply_property smbb_battery_properties[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..bd99658c05be 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -167,6 +167,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 };
 
 enum power_supply_type {
@@ -182,6 +183,10 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+	POWER_SUPPLY_TYPE_USB_HVDCP,		/* High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_HVDCP_3,		/* Efficient High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_HVDCP_3P5,	/* Efficient High Voltage DCP */
+	POWER_SUPPLY_TYPE_USB_FLOAT,		/* Floating charger */
 };
 
 enum power_supply_usb_type {
@@ -197,6 +202,15 @@ enum power_supply_usb_type {
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
2.28.0

