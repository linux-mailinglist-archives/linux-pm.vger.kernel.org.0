Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304742443F7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 05:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHNDtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 23:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 23:49:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A16C061757;
        Thu, 13 Aug 2020 20:49:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mt12so3778442pjb.4;
        Thu, 13 Aug 2020 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DLfzJVrBSOZWmYXjqG2fAv5M0QawyCzsLKQxAdZ2PQ=;
        b=GLo2AdQdNI/G3osOfYAUnskpbAu2Z1grvhWQ1jjXxh5bWl0TuundBkJvYMgrxBpsgh
         sS9xg7bLsHVfRFYauOVhBeDLNEc+bVVprC86ZbmlnH7dCvYI1x4foccQWixLoOyAiXyK
         lxQS1xf1kLpHcOETUjUezf/cOO+aeeHWlQrax+o/356idgz57bFeqjZxQz5/oR7jjD5Z
         SB0iXYFM5Io9bKit83v8FY2ixH+V5xwxhYK6nS7oOl15SubAbtxFM9cThvUPQWML9+FV
         qwXOZMZHvDsoxYcXO2B3RpSzBX8+JHQUBRPhaF4OHZpo+qMwpiYJaqgGTZ3iHwY+KIS8
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DLfzJVrBSOZWmYXjqG2fAv5M0QawyCzsLKQxAdZ2PQ=;
        b=mBmYD8TClVva8xJSdvBpVcPtP3pwWmjaVBJSYATZttfjJzbcg+mvuaxrr+HYsBuey6
         p+nbVPhP6gGn4UXfLPK64YVPF02miPAO++CxhGgiI8APUMlrhdQ7L8aW3CxiemX4CK7g
         ur3cHg9wpvLqheNsL+FLGXx4DUBcmG/6RX8+nZqIBUy9ZzVrUtPw76aonx+zdEqkw1kU
         KjgjcoM99qVVEt0waDj8ywF4QBfugKrm4JS0JaL1Lnuy05c3e1ZkN8nKjpF9k6DKROx2
         1ciZJUE6YRBQsMq9C8kvtkEmJws1YNmcPnSGi5JCDgJED0YeCQTYDiuTaWVXTwvliOrk
         FOwA==
X-Gm-Message-State: AOAM530NEAU2bQXBFdlRzhomOr+NWuLuKwCNyY5VxxNdYdHcxd1JJ0CR
        8HMYfb45iEC/CdBefUOXFudeC9BaVXU=
X-Google-Smtp-Source: ABdhPJwMIbJH2G/JXMjdI4pnmUNbXPctvOPt5tw4dWRd9qzf8TSL2rV/Mo4dCc56OztiCYWSO6092Q==
X-Received: by 2002:a17:90a:c693:: with SMTP id n19mr704616pjt.53.1597376952252;
        Thu, 13 Aug 2020 20:49:12 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id n26sm7253385pff.30.2020.08.13.20.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:49:11 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v8 1/4] power: supply: core: add quick charge type property
Date:   Fri, 14 Aug 2020 11:46:54 +0800
Message-Id: <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597376585.git.huangqiwu@xiaomi.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
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
 Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
 include/linux/power_supply.h                | 14 ++++++
 4 files changed, 87 insertions(+)

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
index c890e1cec720..afd38cf38832 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -485,6 +485,53 @@ static const struct smbb_irq {
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
@@ -505,6 +552,9 @@ static int smbb_usbin_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
 		val->intval = 2500000;
 		break;
+	case POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE:
+		val->intval = get_quick_charge_type(chg);
+		break;
 	default:
 		rc = -EINVAL;
 		break;
@@ -695,6 +745,7 @@ static enum power_supply_property smbb_charger_properties[] = {
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

