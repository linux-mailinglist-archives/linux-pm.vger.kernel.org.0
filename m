Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF724A2AB9
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbiA2Avs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbiA2Avs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C383C06173B
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x23so15151966lfc.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfNUebLgXiUsvJq5mTXCbhRpZS0m4bvb33T+AXEq+5A=;
        b=FzxXEwD0LJ5wLf25BDrmllOkt3Omzcf4XkMAGY2BvHySAXKGF7Zxj6xF2gdeVZy10n
         WiADPBeBFDncZ/rIixPPRMUNygO4IozRwYA8xg+dpUbztFEDmAk99c4+eIf87bN6Us3/
         YS+kiwtmy1+ju+9WRey+X8UGRCPGgvILgnzUCwL8q9gF1Z50H8S3O20CFpiHj1+S9xby
         K5SmChU8rKtj/9wAOZEpmVXzR7kVFhFA0CkcuB74FL/qhdb6cdePkzPOdVRHNZZKzX4D
         zeT7taMIXoY6fmYA1fUhEoyx2tcMMcAmX1Q97xuc0wR9wc22w8mnjskF1jolnBAXrap8
         w8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfNUebLgXiUsvJq5mTXCbhRpZS0m4bvb33T+AXEq+5A=;
        b=tnAnuLBxhCi5d0ZCRjk0KkWubEyY5ho0NrfGXJdbbkgziWdGnLLtQYrkM8HvFEA4g5
         IXHqvAj91I51oB0rGASHPPm1iLVowXCoYdIXo/EiEd/7h/xgxvZeQUVdnBXTHB00PeXo
         VUqpCdKKIZpfzSZR5GhMIMOLtGBoW9yXkBPyNIhX+U7R16OwMuF4oI/wyARE0qjGdQiO
         +8tbvi+tLu0MnS87n2QBrdqpERK2CawDfYvCpSUgxaz+y3CaL0WWibA1uIcUWF9Tzy7K
         AyAqF45oPdu+wkedjc1zcirfqAt6yR/Zxv4jmuPrj4iZ0lJ4SCzyY21m/ib2Hyxf72mQ
         xijw==
X-Gm-Message-State: AOAM530KPWOii1EPHneiDfRlVB0nGMMM1bKICnZXbRYZcEnlhoR90exT
        KW5jALLBxA+PbKlIXTMburxRFQ==
X-Google-Smtp-Source: ABdhPJye5UwF5tEdsdjqZzsIpQcVIPvxuZSLouBUUL0RvYXTrOuhJAMA109of6uy+EVUOE9JNoN4JQ==
X-Received: by 2002:a05:6512:3404:: with SMTP id i4mr3865638lfr.389.1643417505856;
        Fri, 28 Jan 2022 16:51:45 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/11 v2] power: supply: ab8500_chargalg: Drop charging step
Date:   Sat, 29 Jan 2022 01:49:22 +0100
Message-Id: <20220129004925.639684-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a sysfs ABI to change the "charging step" of the
charger i.e. limit how much we charge from userspace.

Since we don't have any userspace for this code, this sits
unused and it is not used on production products either.

Drop this code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_chargalg.c | 105 ++-----------------------
 1 file changed, 6 insertions(+), 99 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index bcf85ae6828e..9f9a84ad2da2 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -46,9 +46,6 @@
 /* Five minutes expressed in seconds */
 #define FIVE_MINUTES_IN_SECONDS        300
 
-#define CHARGALG_CURR_STEP_LOW_UA	0
-#define CHARGALG_CURR_STEP_HIGH_UA	100000
-
 /*
  * This is the battery capacity limit that will trigger a new
  * full charging cycle in the case where maintenance charging
@@ -86,11 +83,6 @@ struct ab8500_chargalg_suspension_status {
 	bool usb_suspended;
 };
 
-struct ab8500_chargalg_current_step_status {
-	bool curr_step_change;
-	int curr_step_ua;
-};
-
 struct ab8500_chargalg_battery_data {
 	int temp;
 	int volt_uv;
@@ -186,8 +178,6 @@ struct ab8500_chargalg_events {
  * struct ab8500_charge_curr_maximization - Charger maximization parameters
  * @original_iset_ua:	the non optimized/maximised charger current
  * @current_iset_ua:	the charging current used at this moment
- * @test_delta_i_ua:	the delta between the current we want to charge and the
-			current that is really going into the battery
  * @condition_cnt:	number of iterations needed before a new charger current
 			is set
  * @max_current_ua:	maximum charger current
@@ -200,7 +190,6 @@ struct ab8500_chargalg_events {
 struct ab8500_charge_curr_maximization {
 	int original_iset_ua;
 	int current_iset_ua;
-	int test_delta_i_ua;
 	int condition_cnt;
 	int max_current_ua;
 	int wait_cnt;
@@ -229,7 +218,6 @@ enum maxim_ret {
  * @batt_data:		data of the battery
  * @susp_status:	current charger suspension status
  * @bm:           	Platform specific battery management information
- * @curr_status:	Current step status for over-current protection
  * @parent:		pointer to the struct ab8500
  * @chargalg_psy:	structure that holds the battery properties exposed by
  *			the charging algorithm
@@ -255,7 +243,6 @@ struct ab8500_chargalg {
 	struct ab8500_chargalg_battery_data batt_data;
 	struct ab8500_chargalg_suspension_status susp_status;
 	struct ab8500 *parent;
-	struct ab8500_chargalg_current_step_status curr_status;
 	struct ab8500_bm_data *bm;
 	struct power_supply *chargalg_psy;
 	struct ux500_charger *ac_chg;
@@ -420,22 +407,6 @@ static int ab8500_chargalg_check_charger_connection(struct ab8500_chargalg *di)
 	return di->chg_info.conn_chg;
 }
 
-/**
- * ab8500_chargalg_check_current_step_status() - Check charging current
- * step status.
- * @di:		pointer to the ab8500_chargalg structure
- *
- * This function will check if there is a change in the charging current step
- * and change charge state accordingly.
- */
-static void ab8500_chargalg_check_current_step_status
-	(struct ab8500_chargalg *di)
-{
-	if (di->curr_status.curr_step_change)
-		ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
-	di->curr_status.curr_step_change = false;
-}
-
 /**
  * ab8500_chargalg_start_safety_timer() - Start charging safety timer
  * @di:		pointer to the ab8500_chargalg structure
@@ -831,7 +802,6 @@ static void init_maxim_chg_curr(struct ab8500_chargalg *di)
 
 	di->ccm.original_iset_ua = bi->constant_charge_current_max_ua;
 	di->ccm.current_iset_ua = bi->constant_charge_current_max_ua;
-	di->ccm.test_delta_i_ua = di->bm->maxi->charger_curr_step_ua;
 	di->ccm.max_current_ua = di->bm->maxi->chg_curr_ua;
 	di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
 	di->ccm.level = 0;
@@ -862,8 +832,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 			dev_dbg(di->dev, "lowering current\n");
 			di->ccm.wait_cnt++;
 			di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-			di->ccm.max_current_ua =
-				di->ccm.current_iset_ua - di->ccm.test_delta_i_ua;
+			di->ccm.max_current_ua = di->ccm.current_iset_ua;
 			di->ccm.current_iset_ua = di->ccm.max_current_ua;
 			di->ccm.level--;
 			return MAXIM_RET_CHANGE;
@@ -893,29 +862,8 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 		return MAXIM_RET_IBAT_TOO_HIGH;
 	}
 
-	if (delta_i_ua > di->ccm.test_delta_i_ua &&
-		(di->ccm.current_iset_ua + di->ccm.test_delta_i_ua) <
-		di->ccm.max_current_ua) {
-		if (di->ccm.condition_cnt-- == 0) {
-			/* Increse the iset with cco.test_delta_i */
-			di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-			di->ccm.current_iset_ua += di->ccm.test_delta_i_ua;
-			di->ccm.level++;
-			dev_dbg(di->dev, " Maximization needed, increase"
-				" with %d uA to %duA (Optimal ibat: %d uA)"
-				" Level %d\n",
-				di->ccm.test_delta_i_ua,
-				di->ccm.current_iset_ua,
-				di->ccm.original_iset_ua,
-				di->ccm.level);
-			return MAXIM_RET_CHANGE;
-		} else {
-			return MAXIM_RET_NOACTION;
-		}
-	}  else {
-		di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-		return MAXIM_RET_NOACTION;
-	}
+	di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
+	return MAXIM_RET_NOACTION;
 }
 
 static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
@@ -1302,7 +1250,6 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	struct power_supply_battery_info *bi = di->bm->bi;
 	int charger_status;
 	int ret;
-	int curr_step_lvl_ua;
 
 	/* Collect data from all power_supply class devices */
 	class_for_each_device(power_supply_class, NULL,
@@ -1313,7 +1260,6 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	ab8500_chargalg_check_charger_voltage(di);
 
 	charger_status = ab8500_chargalg_check_charger_connection(di);
-	ab8500_chargalg_check_current_step_status(di);
 
 	if (is_ab8500(di->parent)) {
 		ret = ab8500_chargalg_check_charger_enable(di);
@@ -1511,15 +1457,13 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		break;
 
 	case STATE_NORMAL_INIT:
-		if (di->curr_status.curr_step_ua == CHARGALG_CURR_STEP_LOW_UA)
+		if (bi->constant_charge_current_max_ua == 0)
+			/* "charging" with 0 uA */
 			ab8500_chargalg_stop_charging(di);
 		else {
-			curr_step_lvl_ua = bi->constant_charge_current_max_ua
-				* di->curr_status.curr_step_ua
-				/ CHARGALG_CURR_STEP_HIGH_UA;
 			ab8500_chargalg_start_charging(di,
 				bi->constant_charge_voltage_max_uv,
-				curr_step_lvl_ua);
+				bi->constant_charge_current_max_ua);
 		}
 
 		ab8500_chargalg_state_to(di, STATE_NORMAL);
@@ -1742,37 +1686,6 @@ static int ab8500_chargalg_get_property(struct power_supply *psy,
 
 /* Exposure to the sysfs interface */
 
-static ssize_t ab8500_chargalg_curr_step_show(struct ab8500_chargalg *di,
-					      char *buf)
-{
-	return sprintf(buf, "%d\n", di->curr_status.curr_step_ua);
-}
-
-static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *di,
-					       const char *buf, size_t length)
-{
-	long param;
-	int ret;
-
-	ret = kstrtol(buf, 10, &param);
-	if (ret < 0)
-		return ret;
-
-	di->curr_status.curr_step_ua = param;
-	if (di->curr_status.curr_step_ua >= CHARGALG_CURR_STEP_LOW_UA &&
-		di->curr_status.curr_step_ua <= CHARGALG_CURR_STEP_HIGH_UA) {
-		di->curr_status.curr_step_change = true;
-		queue_work(di->chargalg_wq, &di->chargalg_work);
-	} else
-		dev_info(di->dev, "Wrong current step\n"
-			"Enter 0. Disable AC/USB Charging\n"
-			"1--100. Set AC/USB charging current step\n"
-			"100. Enable AC/USB Charging\n");
-
-	return strlen(buf);
-}
-
-
 static ssize_t ab8500_chargalg_en_show(struct ab8500_chargalg *di,
 				       char *buf)
 {
@@ -1832,10 +1745,6 @@ static struct ab8500_chargalg_sysfs_entry ab8500_chargalg_en_charger =
 	__ATTR(chargalg, 0644, ab8500_chargalg_en_show,
 				ab8500_chargalg_en_store);
 
-static struct ab8500_chargalg_sysfs_entry ab8500_chargalg_curr_step =
-	__ATTR(chargalg_curr_step, 0644, ab8500_chargalg_curr_step_show,
-					ab8500_chargalg_curr_step_store);
-
 static ssize_t ab8500_chargalg_sysfs_show(struct kobject *kobj,
 	struct attribute *attr, char *buf)
 {
@@ -1868,7 +1777,6 @@ static ssize_t ab8500_chargalg_sysfs_charger(struct kobject *kobj,
 
 static struct attribute *ab8500_chargalg_chg[] = {
 	&ab8500_chargalg_en_charger.attr,
-	&ab8500_chargalg_curr_step.attr,
 	NULL,
 };
 
@@ -2057,7 +1965,6 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 		dev_err(di->dev, "failed to create sysfs entry\n");
 		return ret;
 	}
-	di->curr_status.curr_step_ua = CHARGALG_CURR_STEP_HIGH_UA;
 
 	dev_info(di->dev, "probe success\n");
 	return component_add(dev, &ab8500_chargalg_component_ops);
-- 
2.34.1

