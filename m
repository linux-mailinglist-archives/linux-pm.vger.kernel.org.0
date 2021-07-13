Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0203C7338
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhGMPcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhGMPcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 11:32:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF8C0613DD
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t17so51035550lfq.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRIkBor+dLf/mXS62PVv67j2O2Wnf6OkbnjKlx3XXVo=;
        b=oVPWOqKw+Wy9M6QCBRdxdqvcOU1ZDZbNWQGySUk9lsGLZvXYhsa7UIywgupIf5OKIA
         PP2UPzDVUy96ygQnJMfShjtI122oiH6XS3AMbZY2XNaFJ6re7yCisYQr/cWYT45I8YPg
         hOUrAbYRgEaoC1devemv8Ep3eMOEw+1+e/tRBIwPpFND3zdLsFQC3KMzFctmCooM+9DV
         zIo3m2vGwSIgoG2OJgwlioiRYXpMJ9iKYZ6tN009V7XUvkhcDLT1X7RDoyRlQsv4bxA9
         mPvUUIedW27UN4Kffc4f/X3gQPt82lx9R73T6kjpa+MgfQoMcNJYLVXrdK4uO8ZdBfzb
         EtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRIkBor+dLf/mXS62PVv67j2O2Wnf6OkbnjKlx3XXVo=;
        b=WByqU41dYiYR91iHgJgtdnADhSiBlmxKCbRSSX0nEZqXtbOMC6NUBtWzBVHNA5fztb
         067Ir9y99BiahzMU2+PpeOgS6JZiRBJeAAtYwdqaWodpytPC3qjts/tHkYAPueeeNMa/
         lx/Y/FNdV66L4ntCBcCYY2m6HIP6a62w+/Yfz329HgQQHbiZxRKZOUpc+8o4eYwIpFp/
         PbUi8BCPDIoPaPV55vJvzcoI5OmLFL2oXxlqerjO6hSyIlvnh8oG8TE1rHRdtmyO8N63
         4gW8og9KHRZClQyArcbX4wVmgv6sUaoBQheOohN8vqF6c9PNwQ17LvB1qRmOqJrVBA3/
         igKA==
X-Gm-Message-State: AOAM532L/gqozzk9fK0n+sPUIEpY6weTD8qVecFFQrXM+YgdEOhAX1kd
        7fJozKSkVyqZMAJjk/nGfZqf0g==
X-Google-Smtp-Source: ABdhPJyo61+aH2VYH0ZkT33XBM7CgPycwMOF+g6EI+dotHnIO7HBj40ZJE/cxrQvol9KTyMcbn6mvw==
X-Received: by 2002:ac2:5d2f:: with SMTP id i15mr3936072lfb.134.1626190158108;
        Tue, 13 Jul 2021 08:29:18 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d8sm827395ljg.86.2021.07.13.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:29:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] power: supply: ab8500: Rename charging algorithm symbols
Date:   Tue, 13 Jul 2021 17:27:06 +0200
Message-Id: <20210713152709.871833-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713152709.871833-1-linus.walleij@linaro.org>
References: <20210713152709.871833-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "abx500" name on the charging algorithm stems from the ambition
to produce a series of these analog basebands, re-using the same
charging algorithm driver. No ASICs beside AB8500 and AB8505 were
ever produced so this terminology is confusing. Rename the
algorithm file and symbols to reflect the more narrow scope.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/Makefile                 |   2 +-
 drivers/power/supply/ab8500-bm.h              |   2 +-
 .../{abx500_chargalg.c => ab8500_chargalg.c}  | 576 +++++++++---------
 drivers/power/supply/ab8500_charger.c         |   2 +-
 4 files changed, 291 insertions(+), 291 deletions(-)
 rename drivers/power/supply/{abx500_chargalg.c => ab8500_chargalg.c} (75%)

diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 33059a91f60c..dde138bc1591 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
-obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o
+obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
 obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
 obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
 obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 0c940571e5b0..4e417fbae60c 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -729,6 +729,6 @@ int ab8500_bm_of_probe(struct device *dev,
 
 extern struct platform_driver ab8500_fg_driver;
 extern struct platform_driver ab8500_btemp_driver;
-extern struct platform_driver abx500_chargalg_driver;
+extern struct platform_driver ab8500_chargalg_driver;
 
 #endif /* _AB8500_CHARGER_H_ */
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
similarity index 75%
rename from drivers/power/supply/abx500_chargalg.c
rename to drivers/power/supply/ab8500_chargalg.c
index a17849bfacbf..b0bbb1c4b83a 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -3,7 +3,7 @@
  * Copyright (C) ST-Ericsson SA 2012
  * Copyright (c) 2012 Sony Mobile Communications AB
  *
- * Charging algorithm driver for abx500 variants
+ * Charging algorithm driver for AB8500
  *
  * Authors:
  *	Johan Palsson <johan.palsson@stericsson.com>
@@ -49,18 +49,18 @@
 #define CHARGALG_CURR_STEP_LOW		0
 #define CHARGALG_CURR_STEP_HIGH	100
 
-enum abx500_chargers {
+enum ab8500_chargers {
 	NO_CHG,
 	AC_CHG,
 	USB_CHG,
 };
 
-struct abx500_chargalg_charger_info {
-	enum abx500_chargers conn_chg;
-	enum abx500_chargers prev_conn_chg;
-	enum abx500_chargers online_chg;
-	enum abx500_chargers prev_online_chg;
-	enum abx500_chargers charger_type;
+struct ab8500_chargalg_charger_info {
+	enum ab8500_chargers conn_chg;
+	enum ab8500_chargers prev_conn_chg;
+	enum ab8500_chargers online_chg;
+	enum ab8500_chargers prev_online_chg;
+	enum ab8500_chargers charger_type;
 	bool usb_chg_ok;
 	bool ac_chg_ok;
 	int usb_volt;
@@ -73,18 +73,18 @@ struct abx500_chargalg_charger_info {
 	int ac_iset;
 };
 
-struct abx500_chargalg_suspension_status {
+struct ab8500_chargalg_suspension_status {
 	bool suspended_change;
 	bool ac_suspended;
 	bool usb_suspended;
 };
 
-struct abx500_chargalg_current_step_status {
+struct ab8500_chargalg_current_step_status {
 	bool curr_step_change;
 	int curr_step;
 };
 
-struct abx500_chargalg_battery_data {
+struct ab8500_chargalg_battery_data {
 	int temp;
 	int volt;
 	int avg_curr;
@@ -92,7 +92,7 @@ struct abx500_chargalg_battery_data {
 	int percent;
 };
 
-enum abx500_chargalg_states {
+enum ab8500_chargalg_states {
 	STATE_HANDHELD_INIT,
 	STATE_HANDHELD,
 	STATE_CHG_NOT_OK_INIT,
@@ -154,7 +154,7 @@ static const char *states[] = {
 	"WD_EXPIRED",
 };
 
-struct abx500_chargalg_events {
+struct ab8500_chargalg_events {
 	bool batt_unknown;
 	bool mainextchnotok;
 	bool batt_ovv;
@@ -176,7 +176,7 @@ struct abx500_chargalg_events {
 };
 
 /**
- * struct abx500_charge_curr_maximization - Charger maximization parameters
+ * struct ab8500_charge_curr_maximization - Charger maximization parameters
  * @original_iset:	the non optimized/maximised charger current
  * @current_iset:	the charging current used at this moment
  * @test_delta_i:	the delta between the current we want to charge and the
@@ -190,7 +190,7 @@ struct abx500_chargalg_events {
  * @level:		tells in how many steps the charging current has been
 			increased
  */
-struct abx500_charge_curr_maximization {
+struct ab8500_charge_curr_maximization {
 	int original_iset;
 	int current_iset;
 	int test_delta_i;
@@ -207,7 +207,7 @@ enum maxim_ret {
 };
 
 /**
- * struct abx500_chargalg - abx500 Charging algorithm device information
+ * struct ab8500_chargalg - ab8500 Charging algorithm device information
  * @dev:		pointer to the structure device
  * @charge_status:	battery operating status
  * @eoc_cnt:		counter used to determine end-of_charge
@@ -223,7 +223,7 @@ enum maxim_ret {
  * @susp_status:	current charger suspension status
  * @bm:           	Platform specific battery management information
  * @curr_status:	Current step status for over-current protection
- * @parent:		pointer to the struct abx500
+ * @parent:		pointer to the struct ab8500
  * @chargalg_psy:	structure that holds the battery properties exposed by
  *			the charging algorithm
  * @events:		structure for information about events triggered
@@ -235,25 +235,25 @@ enum maxim_ret {
  * @maintenance_timer:		maintenance charging timer
  * @chargalg_kobject:		structure of type kobject
  */
-struct abx500_chargalg {
+struct ab8500_chargalg {
 	struct device *dev;
 	int charge_status;
 	int eoc_cnt;
 	bool maintenance_chg;
 	int t_hyst_norm;
 	int t_hyst_lowhigh;
-	enum abx500_chargalg_states charge_state;
-	struct abx500_charge_curr_maximization ccm;
-	struct abx500_chargalg_charger_info chg_info;
-	struct abx500_chargalg_battery_data batt_data;
-	struct abx500_chargalg_suspension_status susp_status;
+	enum ab8500_chargalg_states charge_state;
+	struct ab8500_charge_curr_maximization ccm;
+	struct ab8500_chargalg_charger_info chg_info;
+	struct ab8500_chargalg_battery_data batt_data;
+	struct ab8500_chargalg_suspension_status susp_status;
 	struct ab8500 *parent;
-	struct abx500_chargalg_current_step_status curr_status;
+	struct ab8500_chargalg_current_step_status curr_status;
 	struct abx500_bm_data *bm;
 	struct power_supply *chargalg_psy;
 	struct ux500_charger *ac_chg;
 	struct ux500_charger *usb_chg;
-	struct abx500_chargalg_events events;
+	struct ab8500_chargalg_events events;
 	struct workqueue_struct *chargalg_wq;
 	struct delayed_work chargalg_periodic_work;
 	struct delayed_work chargalg_wd_work;
@@ -267,28 +267,28 @@ struct abx500_chargalg {
 BLOCKING_NOTIFIER_HEAD(charger_notifier_list);
 
 /* Main battery properties */
-static enum power_supply_property abx500_chargalg_props[] = {
+static enum power_supply_property ab8500_chargalg_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
 };
 
-struct abx500_chargalg_sysfs_entry {
+struct ab8500_chargalg_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct abx500_chargalg *, char *);
-	ssize_t (*store)(struct abx500_chargalg *, const char *, size_t);
+	ssize_t (*show)(struct ab8500_chargalg *, char *);
+	ssize_t (*store)(struct ab8500_chargalg *, const char *, size_t);
 };
 
 /**
- * abx500_chargalg_safety_timer_expired() - Expiration of the safety timer
+ * ab8500_chargalg_safety_timer_expired() - Expiration of the safety timer
  * @timer:     pointer to the hrtimer structure
  *
  * This function gets called when the safety timer for the charger
  * expires
  */
 static enum hrtimer_restart
-abx500_chargalg_safety_timer_expired(struct hrtimer *timer)
+ab8500_chargalg_safety_timer_expired(struct hrtimer *timer)
 {
-	struct abx500_chargalg *di = container_of(timer, struct abx500_chargalg,
+	struct ab8500_chargalg *di = container_of(timer, struct ab8500_chargalg,
 						  safety_timer);
 	dev_err(di->dev, "Safety timer expired\n");
 	di->events.safety_timer_expired = true;
@@ -300,7 +300,7 @@ abx500_chargalg_safety_timer_expired(struct hrtimer *timer)
 }
 
 /**
- * abx500_chargalg_maintenance_timer_expired() - Expiration of
+ * ab8500_chargalg_maintenance_timer_expired() - Expiration of
  * the maintenance timer
  * @timer:     pointer to the timer structure
  *
@@ -308,10 +308,10 @@ abx500_chargalg_safety_timer_expired(struct hrtimer *timer)
  * expires
  */
 static enum hrtimer_restart
-abx500_chargalg_maintenance_timer_expired(struct hrtimer *timer)
+ab8500_chargalg_maintenance_timer_expired(struct hrtimer *timer)
 {
 
-	struct abx500_chargalg *di = container_of(timer, struct abx500_chargalg,
+	struct ab8500_chargalg *di = container_of(timer, struct ab8500_chargalg,
 						  maintenance_timer);
 
 	dev_dbg(di->dev, "Maintenance timer expired\n");
@@ -324,13 +324,13 @@ abx500_chargalg_maintenance_timer_expired(struct hrtimer *timer)
 }
 
 /**
- * abx500_chargalg_state_to() - Change charge state
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_state_to() - Change charge state
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This function gets called when a charge state change should occur
  */
-static void abx500_chargalg_state_to(struct abx500_chargalg *di,
-	enum abx500_chargalg_states state)
+static void ab8500_chargalg_state_to(struct ab8500_chargalg *di,
+	enum ab8500_chargalg_states state)
 {
 	dev_dbg(di->dev,
 		"State changed: %s (From state: [%d] %s =to=> [%d] %s )\n",
@@ -343,7 +343,7 @@ static void abx500_chargalg_state_to(struct abx500_chargalg *di,
 	di->charge_state = state;
 }
 
-static int abx500_chargalg_check_charger_enable(struct abx500_chargalg *di)
+static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 {
 	switch (di->charge_state) {
 	case STATE_NORMAL:
@@ -368,13 +368,13 @@ static int abx500_chargalg_check_charger_enable(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_check_charger_connection() - Check charger connection change
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_check_charger_connection() - Check charger connection change
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This function will check if there is a change in the charger connection
  * and change charge state accordingly. AC has precedence over USB.
  */
-static int abx500_chargalg_check_charger_connection(struct abx500_chargalg *di)
+static int ab8500_chargalg_check_charger_connection(struct ab8500_chargalg *di)
 {
 	if (di->chg_info.conn_chg != di->chg_info.prev_conn_chg ||
 		di->susp_status.suspended_change) {
@@ -387,23 +387,23 @@ static int abx500_chargalg_check_charger_connection(struct abx500_chargalg *di)
 			dev_dbg(di->dev, "Charging source is AC\n");
 			if (di->chg_info.charger_type != AC_CHG) {
 				di->chg_info.charger_type = AC_CHG;
-				abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+				ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 			}
 		} else if ((di->chg_info.conn_chg & USB_CHG) &&
 			!di->susp_status.usb_suspended) {
 			dev_dbg(di->dev, "Charging source is USB\n");
 			di->chg_info.charger_type = USB_CHG;
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		} else if (di->chg_info.conn_chg &&
 			(di->susp_status.ac_suspended ||
 			di->susp_status.usb_suspended)) {
 			dev_dbg(di->dev, "Charging is suspended\n");
 			di->chg_info.charger_type = NO_CHG;
-			abx500_chargalg_state_to(di, STATE_SUSPENDED_INIT);
+			ab8500_chargalg_state_to(di, STATE_SUSPENDED_INIT);
 		} else {
 			dev_dbg(di->dev, "Charging source is OFF\n");
 			di->chg_info.charger_type = NO_CHG;
-			abx500_chargalg_state_to(di, STATE_HANDHELD_INIT);
+			ab8500_chargalg_state_to(di, STATE_HANDHELD_INIT);
 		}
 		di->chg_info.prev_conn_chg = di->chg_info.conn_chg;
 		di->susp_status.suspended_change = false;
@@ -412,29 +412,29 @@ static int abx500_chargalg_check_charger_connection(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_check_current_step_status() - Check charging current
+ * ab8500_chargalg_check_current_step_status() - Check charging current
  * step status.
- * @di:		pointer to the abx500_chargalg structure
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This function will check if there is a change in the charging current step
  * and change charge state accordingly.
  */
-static void abx500_chargalg_check_current_step_status
-	(struct abx500_chargalg *di)
+static void ab8500_chargalg_check_current_step_status
+	(struct ab8500_chargalg *di)
 {
 	if (di->curr_status.curr_step_change)
-		abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+		ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 	di->curr_status.curr_step_change = false;
 }
 
 /**
- * abx500_chargalg_start_safety_timer() - Start charging safety timer
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_start_safety_timer() - Start charging safety timer
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * The safety timer is used to avoid overcharging of old or bad batteries.
  * There are different timers for AC and USB
  */
-static void abx500_chargalg_start_safety_timer(struct abx500_chargalg *di)
+static void ab8500_chargalg_start_safety_timer(struct ab8500_chargalg *di)
 {
 	/* Charger-dependent expiration time in hours*/
 	int timer_expiration = 0;
@@ -461,27 +461,27 @@ static void abx500_chargalg_start_safety_timer(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_stop_safety_timer() - Stop charging safety timer
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_stop_safety_timer() - Stop charging safety timer
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * The safety timer is stopped whenever the NORMAL state is exited
  */
-static void abx500_chargalg_stop_safety_timer(struct abx500_chargalg *di)
+static void ab8500_chargalg_stop_safety_timer(struct ab8500_chargalg *di)
 {
 	if (hrtimer_try_to_cancel(&di->safety_timer) >= 0)
 		di->events.safety_timer_expired = false;
 }
 
 /**
- * abx500_chargalg_start_maintenance_timer() - Start charging maintenance timer
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_start_maintenance_timer() - Start charging maintenance timer
+ * @di:		pointer to the ab8500_chargalg structure
  * @duration:	duration of ther maintenance timer in hours
  *
  * The maintenance timer is used to maintain the charge in the battery once
  * the battery is considered full. These timers are chosen to match the
  * discharge curve of the battery
  */
-static void abx500_chargalg_start_maintenance_timer(struct abx500_chargalg *di,
+static void ab8500_chargalg_start_maintenance_timer(struct ab8500_chargalg *di,
 	int duration)
 {
 	hrtimer_set_expires_range(&di->maintenance_timer,
@@ -492,26 +492,26 @@ static void abx500_chargalg_start_maintenance_timer(struct abx500_chargalg *di,
 }
 
 /**
- * abx500_chargalg_stop_maintenance_timer() - Stop maintenance timer
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_stop_maintenance_timer() - Stop maintenance timer
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * The maintenance timer is stopped whenever maintenance ends or when another
  * state is entered
  */
-static void abx500_chargalg_stop_maintenance_timer(struct abx500_chargalg *di)
+static void ab8500_chargalg_stop_maintenance_timer(struct ab8500_chargalg *di)
 {
 	if (hrtimer_try_to_cancel(&di->maintenance_timer) >= 0)
 		di->events.maintenance_timer_expired = false;
 }
 
 /**
- * abx500_chargalg_kick_watchdog() - Kick charger watchdog
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_kick_watchdog() - Kick charger watchdog
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * The charger watchdog have to be kicked periodically whenever the charger is
  * on, else the ABB will reset the system
  */
-static int abx500_chargalg_kick_watchdog(struct abx500_chargalg *di)
+static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
 {
 	/* Check if charger exists and kick watchdog if charging */
 	if (di->ac_chg && di->ac_chg->ops.kick_wd &&
@@ -535,8 +535,8 @@ static int abx500_chargalg_kick_watchdog(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_ac_en() - Turn on/off the AC charger
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_ac_en() - Turn on/off the AC charger
+ * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
  * @vset:	requested charger output voltage
  * @iset:	requested charger output current
@@ -544,10 +544,10 @@ static int abx500_chargalg_kick_watchdog(struct abx500_chargalg *di)
  * The AC charger will be turned on/off with the requested charge voltage and
  * current
  */
-static int abx500_chargalg_ac_en(struct abx500_chargalg *di, int enable,
+static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 	int vset, int iset)
 {
-	static int abx500_chargalg_ex_ac_enable_toggle;
+	static int ab8500_chargalg_ex_ac_enable_toggle;
 
 	if (!di->ac_chg || !di->ac_chg->ops.enable)
 		return -ENXIO;
@@ -563,18 +563,18 @@ static int abx500_chargalg_ac_en(struct abx500_chargalg *di, int enable,
 
 	/* Enable external charger */
 	if (enable && di->ac_chg->external &&
-	    !abx500_chargalg_ex_ac_enable_toggle) {
+	    !ab8500_chargalg_ex_ac_enable_toggle) {
 		blocking_notifier_call_chain(&charger_notifier_list,
 					     0, di->dev);
-		abx500_chargalg_ex_ac_enable_toggle++;
+		ab8500_chargalg_ex_ac_enable_toggle++;
 	}
 
 	return di->ac_chg->ops.enable(di->ac_chg, enable, vset, iset);
 }
 
 /**
- * abx500_chargalg_usb_en() - Turn on/off the USB charger
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_usb_en() - Turn on/off the USB charger
+ * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
  * @vset:	requested charger output voltage
  * @iset:	requested charger output current
@@ -582,7 +582,7 @@ static int abx500_chargalg_ac_en(struct abx500_chargalg *di, int enable,
  * The USB charger will be turned on/off with the requested charge voltage and
  * current
  */
-static int abx500_chargalg_usb_en(struct abx500_chargalg *di, int enable,
+static int ab8500_chargalg_usb_en(struct ab8500_chargalg *di, int enable,
 	int vset, int iset)
 {
 	if (!di->usb_chg || !di->usb_chg->ops.enable)
@@ -601,14 +601,14 @@ static int abx500_chargalg_usb_en(struct abx500_chargalg *di, int enable,
 }
 
 /**
- * abx500_chargalg_update_chg_curr() - Update charger current
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_update_chg_curr() - Update charger current
+ * @di:		pointer to the ab8500_chargalg structure
  * @iset:	requested charger output current
  *
  * The charger output current will be updated for the charger
  * that is currently in use
  */
-static int abx500_chargalg_update_chg_curr(struct abx500_chargalg *di,
+static int ab8500_chargalg_update_chg_curr(struct ab8500_chargalg *di,
 		int iset)
 {
 	/* Check if charger exists and update current if charging */
@@ -642,19 +642,19 @@ static int abx500_chargalg_update_chg_curr(struct abx500_chargalg *di,
 }
 
 /**
- * abx500_chargalg_stop_charging() - Stop charging
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_stop_charging() - Stop charging
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This function is called from any state where charging should be stopped.
  * All charging is disabled and all status parameters and timers are changed
  * accordingly
  */
-static void abx500_chargalg_stop_charging(struct abx500_chargalg *di)
+static void ab8500_chargalg_stop_charging(struct ab8500_chargalg *di)
 {
-	abx500_chargalg_ac_en(di, false, 0, 0);
-	abx500_chargalg_usb_en(di, false, 0, 0);
-	abx500_chargalg_stop_safety_timer(di);
-	abx500_chargalg_stop_maintenance_timer(di);
+	ab8500_chargalg_ac_en(di, false, 0, 0);
+	ab8500_chargalg_usb_en(di, false, 0, 0);
+	ab8500_chargalg_stop_safety_timer(di);
+	ab8500_chargalg_stop_maintenance_timer(di);
 	di->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	di->maintenance_chg = false;
 	cancel_delayed_work(&di->chargalg_wd_work);
@@ -662,19 +662,19 @@ static void abx500_chargalg_stop_charging(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_hold_charging() - Pauses charging
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_hold_charging() - Pauses charging
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This function is called in the case where maintenance charging has been
  * disabled and instead a battery voltage mode is entered to check when the
  * battery voltage has reached a certain recharge voltage
  */
-static void abx500_chargalg_hold_charging(struct abx500_chargalg *di)
+static void ab8500_chargalg_hold_charging(struct ab8500_chargalg *di)
 {
-	abx500_chargalg_ac_en(di, false, 0, 0);
-	abx500_chargalg_usb_en(di, false, 0, 0);
-	abx500_chargalg_stop_safety_timer(di);
-	abx500_chargalg_stop_maintenance_timer(di);
+	ab8500_chargalg_ac_en(di, false, 0, 0);
+	ab8500_chargalg_usb_en(di, false, 0, 0);
+	ab8500_chargalg_stop_safety_timer(di);
+	ab8500_chargalg_stop_maintenance_timer(di);
 	di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	di->maintenance_chg = false;
 	cancel_delayed_work(&di->chargalg_wd_work);
@@ -682,30 +682,30 @@ static void abx500_chargalg_hold_charging(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_start_charging() - Start the charger
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_start_charging() - Start the charger
+ * @di:		pointer to the ab8500_chargalg structure
  * @vset:	requested charger output voltage
  * @iset:	requested charger output current
  *
  * A charger will be enabled depending on the requested charger type that was
  * detected previously.
  */
-static void abx500_chargalg_start_charging(struct abx500_chargalg *di,
+static void ab8500_chargalg_start_charging(struct ab8500_chargalg *di,
 	int vset, int iset)
 {
 	switch (di->chg_info.charger_type) {
 	case AC_CHG:
 		dev_dbg(di->dev,
 			"AC parameters: Vset %d, Ich %d\n", vset, iset);
-		abx500_chargalg_usb_en(di, false, 0, 0);
-		abx500_chargalg_ac_en(di, true, vset, iset);
+		ab8500_chargalg_usb_en(di, false, 0, 0);
+		ab8500_chargalg_ac_en(di, true, vset, iset);
 		break;
 
 	case USB_CHG:
 		dev_dbg(di->dev,
 			"USB parameters: Vset %d, Ich %d\n", vset, iset);
-		abx500_chargalg_ac_en(di, false, 0, 0);
-		abx500_chargalg_usb_en(di, true, vset, iset);
+		ab8500_chargalg_ac_en(di, false, 0, 0);
+		ab8500_chargalg_usb_en(di, true, vset, iset);
 		break;
 
 	default:
@@ -715,13 +715,13 @@ static void abx500_chargalg_start_charging(struct abx500_chargalg *di,
 }
 
 /**
- * abx500_chargalg_check_temp() - Check battery temperature ranges
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_check_temp() - Check battery temperature ranges
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * The battery temperature is checked against the predefined limits and the
  * charge state is changed accordingly
  */
-static void abx500_chargalg_check_temp(struct abx500_chargalg *di)
+static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
 {
 	if (di->batt_data.temp > (di->bm->temp_low + di->t_hyst_norm) &&
 		di->batt_data.temp < (di->bm->temp_high - di->t_hyst_norm)) {
@@ -760,12 +760,12 @@ static void abx500_chargalg_check_temp(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_check_charger_voltage() - Check charger voltage
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_check_charger_voltage() - Check charger voltage
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * Charger voltage is checked against maximum limit
  */
-static void abx500_chargalg_check_charger_voltage(struct abx500_chargalg *di)
+static void ab8500_chargalg_check_charger_voltage(struct ab8500_chargalg *di)
 {
 	if (di->chg_info.usb_volt > di->bm->chg_params->usb_volt_max)
 		di->chg_info.usb_chg_ok = false;
@@ -780,14 +780,14 @@ static void abx500_chargalg_check_charger_voltage(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_end_of_charge() - Check if end-of-charge criteria is fulfilled
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_end_of_charge() - Check if end-of-charge criteria is fulfilled
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * End-of-charge criteria is fulfilled when the battery voltage is above a
  * certain limit and the battery current is below a certain limit for a
  * predefined number of consecutive seconds. If true, the battery is full
  */
-static void abx500_chargalg_end_of_charge(struct abx500_chargalg *di)
+static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 {
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
@@ -815,7 +815,7 @@ static void abx500_chargalg_end_of_charge(struct abx500_chargalg *di)
 	}
 }
 
-static void init_maxim_chg_curr(struct abx500_chargalg *di)
+static void init_maxim_chg_curr(struct ab8500_chargalg *di)
 {
 	di->ccm.original_iset =
 		di->bm->bat_type[di->bm->batt_id].normal_cur_lvl;
@@ -828,15 +828,15 @@ static void init_maxim_chg_curr(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_chg_curr_maxim - increases the charger current to
+ * ab8500_chargalg_chg_curr_maxim - increases the charger current to
  *			compensate for the system load
- * @di		pointer to the abx500_chargalg structure
+ * @di		pointer to the ab8500_chargalg structure
  *
  * This maximization function is used to raise the charger current to get the
  * battery current as close to the optimal value as possible. The battery
  * current during charging is affected by the system load
  */
-static enum maxim_ret abx500_chargalg_chg_curr_maxim(struct abx500_chargalg *di)
+static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 {
 	int delta_i;
 
@@ -908,21 +908,21 @@ static enum maxim_ret abx500_chargalg_chg_curr_maxim(struct abx500_chargalg *di)
 	}
 }
 
-static void handle_maxim_chg_curr(struct abx500_chargalg *di)
+static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 {
 	enum maxim_ret ret;
 	int result;
 
-	ret = abx500_chargalg_chg_curr_maxim(di);
+	ret = ab8500_chargalg_chg_curr_maxim(di);
 	switch (ret) {
 	case MAXIM_RET_CHANGE:
-		result = abx500_chargalg_update_chg_curr(di,
+		result = ab8500_chargalg_update_chg_curr(di,
 			di->ccm.current_iset);
 		if (result)
 			dev_err(di->dev, "failed to set chg curr\n");
 		break;
 	case MAXIM_RET_IBAT_TOO_HIGH:
-		result = abx500_chargalg_update_chg_curr(di,
+		result = ab8500_chargalg_update_chg_curr(di,
 			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
 		if (result)
 			dev_err(di->dev, "failed to set chg curr\n");
@@ -935,12 +935,12 @@ static void handle_maxim_chg_curr(struct abx500_chargalg *di)
 	}
 }
 
-static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
+static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 {
 	struct power_supply *psy;
 	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
-	struct abx500_chargalg *di;
+	struct ab8500_chargalg *di;
 	union power_supply_propval ret;
 	int j;
 	bool capacity_updated = false;
@@ -1259,7 +1259,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 }
 
 /**
- * abx500_chargalg_external_power_changed() - callback for power supply changes
+ * ab8500_chargalg_external_power_changed() - callback for power supply changes
  * @psy:       pointer to the structure power_supply
  *
  * This function is the entry point of the pointer external_power_changed
@@ -1267,9 +1267,9 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
  * This function gets executed when there is a change in any external power
  * supply that this driver needs to be notified of.
  */
-static void abx500_chargalg_external_power_changed(struct power_supply *psy)
+static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
 {
-	struct abx500_chargalg *di = power_supply_get_drvdata(psy);
+	struct ab8500_chargalg *di = power_supply_get_drvdata(psy);
 
 	/*
 	 * Trigger execution of the algorithm instantly and read
@@ -1279,14 +1279,14 @@ static void abx500_chargalg_external_power_changed(struct power_supply *psy)
 }
 
 /**
- * abx500_chargalg_algorithm() - Main function for the algorithm
- * @di:		pointer to the abx500_chargalg structure
+ * ab8500_chargalg_algorithm() - Main function for the algorithm
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This is the main control function for the charging algorithm.
  * It is called periodically or when something happens that will
  * trigger a state change
  */
-static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
+static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 {
 	int charger_status;
 	int ret;
@@ -1294,17 +1294,17 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 
 	/* Collect data from all power_supply class devices */
 	class_for_each_device(power_supply_class, NULL,
-		di->chargalg_psy, abx500_chargalg_get_ext_psy_data);
+		di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
 
-	abx500_chargalg_end_of_charge(di);
-	abx500_chargalg_check_temp(di);
-	abx500_chargalg_check_charger_voltage(di);
+	ab8500_chargalg_end_of_charge(di);
+	ab8500_chargalg_check_temp(di);
+	ab8500_chargalg_check_charger_voltage(di);
 
-	charger_status = abx500_chargalg_check_charger_connection(di);
-	abx500_chargalg_check_current_step_status(di);
+	charger_status = ab8500_chargalg_check_charger_connection(di);
+	ab8500_chargalg_check_current_step_status(di);
 
 	if (is_ab8500(di->parent)) {
-		ret = abx500_chargalg_check_charger_enable(di);
+		ret = ab8500_chargalg_check_charger_enable(di);
 		if (ret < 0)
 			dev_err(di->dev, "Checking charger is enabled error"
 					": Returned Value %d\n", ret);
@@ -1319,7 +1319,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		(di->events.batt_unknown && !di->bm->chg_unknown_bat)) {
 		if (di->charge_state != STATE_HANDHELD) {
 			di->events.safety_timer_expired = false;
-			abx500_chargalg_state_to(di, STATE_HANDHELD_INIT);
+			ab8500_chargalg_state_to(di, STATE_HANDHELD_INIT);
 		}
 	}
 
@@ -1332,7 +1332,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 	/* Safety timer expiration */
 	else if (di->events.safety_timer_expired) {
 		if (di->charge_state != STATE_SAFETY_TIMER_EXPIRED)
-			abx500_chargalg_state_to(di,
+			ab8500_chargalg_state_to(di,
 				STATE_SAFETY_TIMER_EXPIRED_INIT);
 	}
 	/*
@@ -1343,7 +1343,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 	/* Battery removed */
 	else if (di->events.batt_rem) {
 		if (di->charge_state != STATE_BATT_REMOVED)
-			abx500_chargalg_state_to(di, STATE_BATT_REMOVED_INIT);
+			ab8500_chargalg_state_to(di, STATE_BATT_REMOVED_INIT);
 	}
 	/* Main or USB charger not ok. */
 	else if (di->events.mainextchnotok || di->events.usbchargernotok) {
@@ -1353,7 +1353,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		 */
 		if (di->charge_state != STATE_CHG_NOT_OK &&
 				!di->events.vbus_collapsed)
-			abx500_chargalg_state_to(di, STATE_CHG_NOT_OK_INIT);
+			ab8500_chargalg_state_to(di, STATE_CHG_NOT_OK_INIT);
 	}
 	/* VBUS, Main or VBAT OVV. */
 	else if (di->events.vbus_ovv ||
@@ -1362,31 +1362,31 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 			!di->chg_info.usb_chg_ok ||
 			!di->chg_info.ac_chg_ok) {
 		if (di->charge_state != STATE_OVV_PROTECT)
-			abx500_chargalg_state_to(di, STATE_OVV_PROTECT_INIT);
+			ab8500_chargalg_state_to(di, STATE_OVV_PROTECT_INIT);
 	}
 	/* USB Thermal, stop charging */
 	else if (di->events.main_thermal_prot ||
 		di->events.usb_thermal_prot) {
 		if (di->charge_state != STATE_HW_TEMP_PROTECT)
-			abx500_chargalg_state_to(di,
+			ab8500_chargalg_state_to(di,
 				STATE_HW_TEMP_PROTECT_INIT);
 	}
 	/* Battery temp over/under */
 	else if (di->events.btemp_underover) {
 		if (di->charge_state != STATE_TEMP_UNDEROVER)
-			abx500_chargalg_state_to(di,
+			ab8500_chargalg_state_to(di,
 				STATE_TEMP_UNDEROVER_INIT);
 	}
 	/* Watchdog expired */
 	else if (di->events.ac_wd_expired ||
 		di->events.usb_wd_expired) {
 		if (di->charge_state != STATE_WD_EXPIRED)
-			abx500_chargalg_state_to(di, STATE_WD_EXPIRED_INIT);
+			ab8500_chargalg_state_to(di, STATE_WD_EXPIRED_INIT);
 	}
 	/* Battery temp high/low */
 	else if (di->events.btemp_lowhigh) {
 		if (di->charge_state != STATE_TEMP_LOWHIGH)
-			abx500_chargalg_state_to(di, STATE_TEMP_LOWHIGH_INIT);
+			ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH_INIT);
 	}
 
 	dev_dbg(di->dev,
@@ -1418,9 +1418,9 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 
 	switch (di->charge_state) {
 	case STATE_HANDHELD_INIT:
-		abx500_chargalg_stop_charging(di);
+		ab8500_chargalg_stop_charging(di);
 		di->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
-		abx500_chargalg_state_to(di, STATE_HANDHELD);
+		ab8500_chargalg_state_to(di, STATE_HANDHELD);
 		fallthrough;
 
 	case STATE_HANDHELD:
@@ -1428,14 +1428,14 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 
 	case STATE_SUSPENDED_INIT:
 		if (di->susp_status.ac_suspended)
-			abx500_chargalg_ac_en(di, false, 0, 0);
+			ab8500_chargalg_ac_en(di, false, 0, 0);
 		if (di->susp_status.usb_suspended)
-			abx500_chargalg_usb_en(di, false, 0, 0);
-		abx500_chargalg_stop_safety_timer(di);
-		abx500_chargalg_stop_maintenance_timer(di);
+			ab8500_chargalg_usb_en(di, false, 0, 0);
+		ab8500_chargalg_stop_safety_timer(di);
+		ab8500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		di->maintenance_chg = false;
-		abx500_chargalg_state_to(di, STATE_SUSPENDED);
+		ab8500_chargalg_state_to(di, STATE_SUSPENDED);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
 
@@ -1444,29 +1444,29 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		break;
 
 	case STATE_BATT_REMOVED_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_BATT_REMOVED);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_BATT_REMOVED);
 		fallthrough;
 
 	case STATE_BATT_REMOVED:
 		if (!di->events.batt_rem)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_HW_TEMP_PROTECT_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_HW_TEMP_PROTECT);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_HW_TEMP_PROTECT);
 		fallthrough;
 
 	case STATE_HW_TEMP_PROTECT:
 		if (!di->events.main_thermal_prot &&
 				!di->events.usb_thermal_prot)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_OVV_PROTECT_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_OVV_PROTECT);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_OVV_PROTECT);
 		fallthrough;
 
 	case STATE_OVV_PROTECT:
@@ -1475,23 +1475,23 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 				!di->events.batt_ovv &&
 				di->chg_info.usb_chg_ok &&
 				di->chg_info.ac_chg_ok)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_CHG_NOT_OK_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_CHG_NOT_OK);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_CHG_NOT_OK);
 		fallthrough;
 
 	case STATE_CHG_NOT_OK:
 		if (!di->events.mainextchnotok &&
 				!di->events.usbchargernotok)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_SAFETY_TIMER_EXPIRED_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_SAFETY_TIMER_EXPIRED);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_SAFETY_TIMER_EXPIRED);
 		fallthrough;
 
 	case STATE_SAFETY_TIMER_EXPIRED:
@@ -1500,20 +1500,20 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 
 	case STATE_NORMAL_INIT:
 		if (di->curr_status.curr_step == CHARGALG_CURR_STEP_LOW)
-			abx500_chargalg_stop_charging(di);
+			ab8500_chargalg_stop_charging(di);
 		else {
 			curr_step_lvl = di->bm->bat_type[
 				di->bm->batt_id].normal_cur_lvl
 				* di->curr_status.curr_step
 				/ CHARGALG_CURR_STEP_HIGH;
-			abx500_chargalg_start_charging(di,
+			ab8500_chargalg_start_charging(di,
 				di->bm->bat_type[di->bm->batt_id]
 				.normal_vol_lvl, curr_step_lvl);
 		}
 
-		abx500_chargalg_state_to(di, STATE_NORMAL);
-		abx500_chargalg_start_safety_timer(di);
-		abx500_chargalg_stop_maintenance_timer(di);
+		ab8500_chargalg_state_to(di, STATE_NORMAL);
+		ab8500_chargalg_start_safety_timer(di);
+		ab8500_chargalg_stop_maintenance_timer(di);
 		init_maxim_chg_curr(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		di->eoc_cnt = 0;
@@ -1527,104 +1527,104 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		if (di->charge_status == POWER_SUPPLY_STATUS_FULL &&
 			di->maintenance_chg) {
 			if (di->bm->no_maintenance)
-				abx500_chargalg_state_to(di,
+				ab8500_chargalg_state_to(di,
 					STATE_WAIT_FOR_RECHARGE_INIT);
 			else
-				abx500_chargalg_state_to(di,
+				ab8500_chargalg_state_to(di,
 					STATE_MAINTENANCE_A_INIT);
 		}
 		break;
 
 	/* This state will be used when the maintenance state is disabled */
 	case STATE_WAIT_FOR_RECHARGE_INIT:
-		abx500_chargalg_hold_charging(di);
-		abx500_chargalg_state_to(di, STATE_WAIT_FOR_RECHARGE);
+		ab8500_chargalg_hold_charging(di);
+		ab8500_chargalg_state_to(di, STATE_WAIT_FOR_RECHARGE);
 		fallthrough;
 
 	case STATE_WAIT_FOR_RECHARGE:
 		if (di->batt_data.percent <=
 		    di->bm->bat_type[di->bm->batt_id].
 		    recharge_cap)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_MAINTENANCE_A_INIT:
-		abx500_chargalg_stop_safety_timer(di);
-		abx500_chargalg_start_maintenance_timer(di,
+		ab8500_chargalg_stop_safety_timer(di);
+		ab8500_chargalg_start_maintenance_timer(di,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_a_chg_timer_h);
-		abx500_chargalg_start_charging(di,
+		ab8500_chargalg_start_charging(di,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_a_vol_lvl,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_a_cur_lvl);
-		abx500_chargalg_state_to(di, STATE_MAINTENANCE_A);
+		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_A);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
 
 	case STATE_MAINTENANCE_A:
 		if (di->events.maintenance_timer_expired) {
-			abx500_chargalg_stop_maintenance_timer(di);
-			abx500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
+			ab8500_chargalg_stop_maintenance_timer(di);
+			ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
 		}
 		break;
 
 	case STATE_MAINTENANCE_B_INIT:
-		abx500_chargalg_start_maintenance_timer(di,
+		ab8500_chargalg_start_maintenance_timer(di,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_b_chg_timer_h);
-		abx500_chargalg_start_charging(di,
+		ab8500_chargalg_start_charging(di,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_b_vol_lvl,
 			di->bm->bat_type[
 				di->bm->batt_id].maint_b_cur_lvl);
-		abx500_chargalg_state_to(di, STATE_MAINTENANCE_B);
+		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
 
 	case STATE_MAINTENANCE_B:
 		if (di->events.maintenance_timer_expired) {
-			abx500_chargalg_stop_maintenance_timer(di);
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_stop_maintenance_timer(di);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		}
 		break;
 
 	case STATE_TEMP_LOWHIGH_INIT:
-		abx500_chargalg_start_charging(di,
+		ab8500_chargalg_start_charging(di,
 			di->bm->bat_type[
 				di->bm->batt_id].low_high_vol_lvl,
 			di->bm->bat_type[
 				di->bm->batt_id].low_high_cur_lvl);
-		abx500_chargalg_stop_maintenance_timer(di);
+		ab8500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
-		abx500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
+		ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
 
 	case STATE_TEMP_LOWHIGH:
 		if (!di->events.btemp_lowhigh)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_WD_EXPIRED_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_WD_EXPIRED);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_WD_EXPIRED);
 		fallthrough;
 
 	case STATE_WD_EXPIRED:
 		if (!di->events.ac_wd_expired &&
 				!di->events.usb_wd_expired)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_TEMP_UNDEROVER_INIT:
-		abx500_chargalg_stop_charging(di);
-		abx500_chargalg_state_to(di, STATE_TEMP_UNDEROVER);
+		ab8500_chargalg_stop_charging(di);
+		ab8500_chargalg_state_to(di, STATE_TEMP_UNDEROVER);
 		fallthrough;
 
 	case STATE_TEMP_UNDEROVER:
 		if (!di->events.btemp_underover)
-			abx500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 	}
 
@@ -1636,17 +1636,17 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 }
 
 /**
- * abx500_chargalg_periodic_work() - Periodic work for the algorithm
+ * ab8500_chargalg_periodic_work() - Periodic work for the algorithm
  * @work:	pointer to the work_struct structure
  *
  * Work queue function for the charging algorithm
  */
-static void abx500_chargalg_periodic_work(struct work_struct *work)
+static void ab8500_chargalg_periodic_work(struct work_struct *work)
 {
-	struct abx500_chargalg *di = container_of(work,
-		struct abx500_chargalg, chargalg_periodic_work.work);
+	struct ab8500_chargalg *di = container_of(work,
+		struct ab8500_chargalg, chargalg_periodic_work.work);
 
-	abx500_chargalg_algorithm(di);
+	ab8500_chargalg_algorithm(di);
 
 	/*
 	 * If a charger is connected then the battery has to be monitored
@@ -1663,20 +1663,20 @@ static void abx500_chargalg_periodic_work(struct work_struct *work)
 }
 
 /**
- * abx500_chargalg_wd_work() - periodic work to kick the charger watchdog
+ * ab8500_chargalg_wd_work() - periodic work to kick the charger watchdog
  * @work:	pointer to the work_struct structure
  *
  * Work queue function for kicking the charger watchdog
  */
-static void abx500_chargalg_wd_work(struct work_struct *work)
+static void ab8500_chargalg_wd_work(struct work_struct *work)
 {
 	int ret;
-	struct abx500_chargalg *di = container_of(work,
-		struct abx500_chargalg, chargalg_wd_work.work);
+	struct ab8500_chargalg *di = container_of(work,
+		struct ab8500_chargalg, chargalg_wd_work.work);
 
-	dev_dbg(di->dev, "abx500_chargalg_wd_work\n");
+	dev_dbg(di->dev, "ab8500_chargalg_wd_work\n");
 
-	ret = abx500_chargalg_kick_watchdog(di);
+	ret = ab8500_chargalg_kick_watchdog(di);
 	if (ret < 0)
 		dev_err(di->dev, "failed to kick watchdog\n");
 
@@ -1685,21 +1685,21 @@ static void abx500_chargalg_wd_work(struct work_struct *work)
 }
 
 /**
- * abx500_chargalg_work() - Work to run the charging algorithm instantly
+ * ab8500_chargalg_work() - Work to run the charging algorithm instantly
  * @work:	pointer to the work_struct structure
  *
  * Work queue function for calling the charging algorithm
  */
-static void abx500_chargalg_work(struct work_struct *work)
+static void ab8500_chargalg_work(struct work_struct *work)
 {
-	struct abx500_chargalg *di = container_of(work,
-		struct abx500_chargalg, chargalg_work);
+	struct ab8500_chargalg *di = container_of(work,
+		struct ab8500_chargalg, chargalg_work);
 
-	abx500_chargalg_algorithm(di);
+	ab8500_chargalg_algorithm(di);
 }
 
 /**
- * abx500_chargalg_get_property() - get the chargalg properties
+ * ab8500_chargalg_get_property() - get the chargalg properties
  * @psy:	pointer to the power_supply structure
  * @psp:	pointer to the power_supply_property structure
  * @val:	pointer to the power_supply_propval union
@@ -1710,11 +1710,11 @@ static void abx500_chargalg_work(struct work_struct *work)
  * health:     health of the battery
  * Returns error code in case of failure else 0 on success
  */
-static int abx500_chargalg_get_property(struct power_supply *psy,
+static int ab8500_chargalg_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
 {
-	struct abx500_chargalg *di = power_supply_get_drvdata(psy);
+	struct ab8500_chargalg *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1743,13 +1743,13 @@ static int abx500_chargalg_get_property(struct power_supply *psy,
 
 /* Exposure to the sysfs interface */
 
-static ssize_t abx500_chargalg_curr_step_show(struct abx500_chargalg *di,
+static ssize_t ab8500_chargalg_curr_step_show(struct ab8500_chargalg *di,
 					      char *buf)
 {
 	return sprintf(buf, "%d\n", di->curr_status.curr_step);
 }
 
-static ssize_t abx500_chargalg_curr_step_store(struct abx500_chargalg *di,
+static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *di,
 					       const char *buf, size_t length)
 {
 	long int param;
@@ -1774,7 +1774,7 @@ static ssize_t abx500_chargalg_curr_step_store(struct abx500_chargalg *di,
 }
 
 
-static ssize_t abx500_chargalg_en_show(struct abx500_chargalg *di,
+static ssize_t ab8500_chargalg_en_show(struct ab8500_chargalg *di,
 				       char *buf)
 {
 	return sprintf(buf, "%d\n",
@@ -1782,7 +1782,7 @@ static ssize_t abx500_chargalg_en_show(struct abx500_chargalg *di,
 		       di->susp_status.usb_suspended);
 }
 
-static ssize_t abx500_chargalg_en_store(struct abx500_chargalg *di,
+static ssize_t ab8500_chargalg_en_store(struct ab8500_chargalg *di,
 	const char *buf, size_t length)
 {
 	long int param;
@@ -1829,22 +1829,22 @@ static ssize_t abx500_chargalg_en_store(struct abx500_chargalg *di,
 	return strlen(buf);
 }
 
-static struct abx500_chargalg_sysfs_entry abx500_chargalg_en_charger =
-	__ATTR(chargalg, 0644, abx500_chargalg_en_show,
-				abx500_chargalg_en_store);
+static struct ab8500_chargalg_sysfs_entry ab8500_chargalg_en_charger =
+	__ATTR(chargalg, 0644, ab8500_chargalg_en_show,
+				ab8500_chargalg_en_store);
 
-static struct abx500_chargalg_sysfs_entry abx500_chargalg_curr_step =
-	__ATTR(chargalg_curr_step, 0644, abx500_chargalg_curr_step_show,
-					abx500_chargalg_curr_step_store);
+static struct ab8500_chargalg_sysfs_entry ab8500_chargalg_curr_step =
+	__ATTR(chargalg_curr_step, 0644, ab8500_chargalg_curr_step_show,
+					ab8500_chargalg_curr_step_store);
 
-static ssize_t abx500_chargalg_sysfs_show(struct kobject *kobj,
+static ssize_t ab8500_chargalg_sysfs_show(struct kobject *kobj,
 	struct attribute *attr, char *buf)
 {
-	struct abx500_chargalg_sysfs_entry *entry = container_of(attr,
-		struct abx500_chargalg_sysfs_entry, attr);
+	struct ab8500_chargalg_sysfs_entry *entry = container_of(attr,
+		struct ab8500_chargalg_sysfs_entry, attr);
 
-	struct abx500_chargalg *di = container_of(kobj,
-		struct abx500_chargalg, chargalg_kobject);
+	struct ab8500_chargalg *di = container_of(kobj,
+		struct ab8500_chargalg, chargalg_kobject);
 
 	if (!entry->show)
 		return -EIO;
@@ -1852,14 +1852,14 @@ static ssize_t abx500_chargalg_sysfs_show(struct kobject *kobj,
 	return entry->show(di, buf);
 }
 
-static ssize_t abx500_chargalg_sysfs_charger(struct kobject *kobj,
+static ssize_t ab8500_chargalg_sysfs_charger(struct kobject *kobj,
 	struct attribute *attr, const char *buf, size_t length)
 {
-	struct abx500_chargalg_sysfs_entry *entry = container_of(attr,
-		struct abx500_chargalg_sysfs_entry, attr);
+	struct ab8500_chargalg_sysfs_entry *entry = container_of(attr,
+		struct ab8500_chargalg_sysfs_entry, attr);
 
-	struct abx500_chargalg *di = container_of(kobj,
-		struct abx500_chargalg, chargalg_kobject);
+	struct ab8500_chargalg *di = container_of(kobj,
+		struct ab8500_chargalg, chargalg_kobject);
 
 	if (!entry->store)
 		return -EIO;
@@ -1867,47 +1867,47 @@ static ssize_t abx500_chargalg_sysfs_charger(struct kobject *kobj,
 	return entry->store(di, buf, length);
 }
 
-static struct attribute *abx500_chargalg_chg[] = {
-	&abx500_chargalg_en_charger.attr,
-	&abx500_chargalg_curr_step.attr,
+static struct attribute *ab8500_chargalg_chg[] = {
+	&ab8500_chargalg_en_charger.attr,
+	&ab8500_chargalg_curr_step.attr,
 	NULL,
 };
 
-static const struct sysfs_ops abx500_chargalg_sysfs_ops = {
-	.show = abx500_chargalg_sysfs_show,
-	.store = abx500_chargalg_sysfs_charger,
+static const struct sysfs_ops ab8500_chargalg_sysfs_ops = {
+	.show = ab8500_chargalg_sysfs_show,
+	.store = ab8500_chargalg_sysfs_charger,
 };
 
-static struct kobj_type abx500_chargalg_ktype = {
-	.sysfs_ops = &abx500_chargalg_sysfs_ops,
-	.default_attrs = abx500_chargalg_chg,
+static struct kobj_type ab8500_chargalg_ktype = {
+	.sysfs_ops = &ab8500_chargalg_sysfs_ops,
+	.default_attrs = ab8500_chargalg_chg,
 };
 
 /**
- * abx500_chargalg_sysfs_exit() - de-init of sysfs entry
- * @di:                pointer to the struct abx500_chargalg
+ * ab8500_chargalg_sysfs_exit() - de-init of sysfs entry
+ * @di:                pointer to the struct ab8500_chargalg
  *
  * This function removes the entry in sysfs.
  */
-static void abx500_chargalg_sysfs_exit(struct abx500_chargalg *di)
+static void ab8500_chargalg_sysfs_exit(struct ab8500_chargalg *di)
 {
 	kobject_del(&di->chargalg_kobject);
 }
 
 /**
- * abx500_chargalg_sysfs_init() - init of sysfs entry
- * @di:                pointer to the struct abx500_chargalg
+ * ab8500_chargalg_sysfs_init() - init of sysfs entry
+ * @di:                pointer to the struct ab8500_chargalg
  *
  * This function adds an entry in sysfs.
  * Returns error code in case of failure else 0(on success)
  */
-static int abx500_chargalg_sysfs_init(struct abx500_chargalg *di)
+static int ab8500_chargalg_sysfs_init(struct ab8500_chargalg *di)
 {
 	int ret = 0;
 
 	ret = kobject_init_and_add(&di->chargalg_kobject,
-		&abx500_chargalg_ktype,
-		NULL, "abx500_chargalg");
+		&ab8500_chargalg_ktype,
+		NULL, "ab8500_chargalg");
 	if (ret < 0)
 		dev_err(di->dev, "failed to create sysfs entry\n");
 
@@ -1915,9 +1915,9 @@ static int abx500_chargalg_sysfs_init(struct abx500_chargalg *di)
 }
 /* Exposure to the sysfs interface <<END>> */
 
-static int __maybe_unused abx500_chargalg_resume(struct device *dev)
+static int __maybe_unused ab8500_chargalg_resume(struct device *dev)
 {
-	struct abx500_chargalg *di = dev_get_drvdata(dev);
+	struct ab8500_chargalg *di = dev_get_drvdata(dev);
 
 	/* Kick charger watchdog if charging (any charger online) */
 	if (di->chg_info.online_chg)
@@ -1932,9 +1932,9 @@ static int __maybe_unused abx500_chargalg_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused abx500_chargalg_suspend(struct device *dev)
+static int __maybe_unused ab8500_chargalg_suspend(struct device *dev)
 {
-	struct abx500_chargalg *di = dev_get_drvdata(dev);
+	struct ab8500_chargalg *di = dev_get_drvdata(dev);
 
 	if (di->chg_info.online_chg)
 		cancel_delayed_work_sync(&di->chargalg_wd_work);
@@ -1948,22 +1948,22 @@ static char *supply_interface[] = {
 	"ab8500_fg",
 };
 
-static const struct power_supply_desc abx500_chargalg_desc = {
+static const struct power_supply_desc ab8500_chargalg_desc = {
 	.name			= "abx500_chargalg",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
-	.properties		= abx500_chargalg_props,
-	.num_properties		= ARRAY_SIZE(abx500_chargalg_props),
-	.get_property		= abx500_chargalg_get_property,
-	.external_power_changed	= abx500_chargalg_external_power_changed,
+	.properties		= ab8500_chargalg_props,
+	.num_properties		= ARRAY_SIZE(ab8500_chargalg_props),
+	.get_property		= ab8500_chargalg_get_property,
+	.external_power_changed	= ab8500_chargalg_external_power_changed,
 };
 
-static int abx500_chargalg_bind(struct device *dev, struct device *master,
+static int ab8500_chargalg_bind(struct device *dev, struct device *master,
 				void *data)
 {
-	struct abx500_chargalg *di = dev_get_drvdata(dev);
+	struct ab8500_chargalg *di = dev_get_drvdata(dev);
 
 	/* Create a work queue for the chargalg */
-	di->chargalg_wq = alloc_ordered_workqueue("abx500_chargalg_wq",
+	di->chargalg_wq = alloc_ordered_workqueue("ab8500_chargalg_wq",
 						  WQ_MEM_RECLAIM);
 	if (di->chargalg_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
@@ -1976,10 +1976,10 @@ static int abx500_chargalg_bind(struct device *dev, struct device *master,
 	return 0;
 }
 
-static void abx500_chargalg_unbind(struct device *dev, struct device *master,
+static void ab8500_chargalg_unbind(struct device *dev, struct device *master,
 				   void *data)
 {
-	struct abx500_chargalg *di = dev_get_drvdata(dev);
+	struct ab8500_chargalg *di = dev_get_drvdata(dev);
 
 	/* Stop all timers and work */
 	hrtimer_cancel(&di->safety_timer);
@@ -1994,16 +1994,16 @@ static void abx500_chargalg_unbind(struct device *dev, struct device *master,
 	flush_scheduled_work();
 }
 
-static const struct component_ops abx500_chargalg_component_ops = {
-	.bind = abx500_chargalg_bind,
-	.unbind = abx500_chargalg_unbind,
+static const struct component_ops ab8500_chargalg_component_ops = {
+	.bind = ab8500_chargalg_bind,
+	.unbind = ab8500_chargalg_unbind,
 };
 
-static int abx500_chargalg_probe(struct platform_device *pdev)
+static int ab8500_chargalg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct power_supply_config psy_cfg = {};
-	struct abx500_chargalg *di;
+	struct ab8500_chargalg *di;
 	int ret = 0;
 
 	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
@@ -2022,28 +2022,28 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 
 	/* Initilialize safety timer */
 	hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	di->safety_timer.function = abx500_chargalg_safety_timer_expired;
+	di->safety_timer.function = ab8500_chargalg_safety_timer_expired;
 
 	/* Initilialize maintenance timer */
 	hrtimer_init(&di->maintenance_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	di->maintenance_timer.function =
-		abx500_chargalg_maintenance_timer_expired;
+		ab8500_chargalg_maintenance_timer_expired;
 
 	/* Init work for chargalg */
 	INIT_DEFERRABLE_WORK(&di->chargalg_periodic_work,
-		abx500_chargalg_periodic_work);
+		ab8500_chargalg_periodic_work);
 	INIT_DEFERRABLE_WORK(&di->chargalg_wd_work,
-		abx500_chargalg_wd_work);
+		ab8500_chargalg_wd_work);
 
 	/* Init work for chargalg */
-	INIT_WORK(&di->chargalg_work, abx500_chargalg_work);
+	INIT_WORK(&di->chargalg_work, ab8500_chargalg_work);
 
 	/* To detect charger at startup */
 	di->chg_info.prev_conn_chg = -1;
 
 	/* Register chargalg power supply class */
 	di->chargalg_psy = devm_power_supply_register(di->dev,
-						 &abx500_chargalg_desc,
+						 &ab8500_chargalg_desc,
 						 &psy_cfg);
 	if (IS_ERR(di->chargalg_psy)) {
 		dev_err(di->dev, "failed to register chargalg psy\n");
@@ -2053,7 +2053,7 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	/* sysfs interface to enable/disable charging from user space */
-	ret = abx500_chargalg_sysfs_init(di);
+	ret = ab8500_chargalg_sysfs_init(di);
 	if (ret) {
 		dev_err(di->dev, "failed to create sysfs entry\n");
 		return ret;
@@ -2061,38 +2061,38 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	di->curr_status.curr_step = CHARGALG_CURR_STEP_HIGH;
 
 	dev_info(di->dev, "probe success\n");
-	return component_add(dev, &abx500_chargalg_component_ops);
+	return component_add(dev, &ab8500_chargalg_component_ops);
 }
 
-static int abx500_chargalg_remove(struct platform_device *pdev)
+static int ab8500_chargalg_remove(struct platform_device *pdev)
 {
-	struct abx500_chargalg *di = platform_get_drvdata(pdev);
+	struct ab8500_chargalg *di = platform_get_drvdata(pdev);
 
-	component_del(&pdev->dev, &abx500_chargalg_component_ops);
+	component_del(&pdev->dev, &ab8500_chargalg_component_ops);
 
 	/* sysfs interface to enable/disable charging from user space */
-	abx500_chargalg_sysfs_exit(di);
+	ab8500_chargalg_sysfs_exit(di);
 
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(abx500_chargalg_pm_ops, abx500_chargalg_suspend, abx500_chargalg_resume);
+static SIMPLE_DEV_PM_OPS(ab8500_chargalg_pm_ops, ab8500_chargalg_suspend, ab8500_chargalg_resume);
 
 static const struct of_device_id ab8500_chargalg_match[] = {
 	{ .compatible = "stericsson,ab8500-chargalg", },
 	{ },
 };
 
-struct platform_driver abx500_chargalg_driver = {
-	.probe = abx500_chargalg_probe,
-	.remove = abx500_chargalg_remove,
+struct platform_driver ab8500_chargalg_driver = {
+	.probe = ab8500_chargalg_probe,
+	.remove = ab8500_chargalg_remove,
 	.driver = {
-		.name = "ab8500-chargalg",
+		.name = "ab8500_chargalg",
 		.of_match_table = ab8500_chargalg_match,
-		.pm = &abx500_chargalg_pm_ops,
+		.pm = &ab8500_chargalg_pm_ops,
 	},
 };
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski");
-MODULE_ALIAS("platform:abx500-chargalg");
-MODULE_DESCRIPTION("abx500 battery charging algorithm");
+MODULE_ALIAS("platform:ab8500-chargalg");
+MODULE_DESCRIPTION("ab8500 battery charging algorithm");
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index fa49e12e5a60..e0d3d6bd8b8c 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3388,7 +3388,7 @@ static const struct component_master_ops ab8500_charger_comp_ops = {
 static struct platform_driver *const ab8500_charger_component_drivers[] = {
 	&ab8500_fg_driver,
 	&ab8500_btemp_driver,
-	&abx500_chargalg_driver,
+	&ab8500_chargalg_driver,
 };
 
 static int ab8500_charger_compare_dev(struct device *dev, void *data)
-- 
2.31.1

