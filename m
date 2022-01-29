Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED414A2ABA
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiA2Avw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbiA2Avt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA0C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b9so15010139lfq.6
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crWoqs9TmxfyapEsfu46T1IVD8DYFQBIvK2BY+NoGRE=;
        b=Zb+1pAUZ9aSHboTv1pZxq+lfx0PUuPCxUv1qOVlLzxKYH3M6hH+7HRxz/te4E+539Z
         LExV4d/PtWIUzAUrUu+wviyC552JYhctCmrbmqdVgwKNVieypLFCnVEYd1xEgFNHkTqb
         IlRvFYVCFjmiNAcjqxcMA9nft+GZdN+5KpbcJ03IbUOyBiMJWXU1HJ9M6l42/0yX8KHn
         6LEP4Q5yz3a62f1ECgxz51fWYUtuFq+AUSGTegyPCfVdvXsxX/grrxcrprj1Bs/v4FO4
         Ej0uvyd4mLTA8EzjimXVu0LuOyKmX2hNHKJM9c+Wa0hycYbZx64CofvuFV+148SDhOQq
         b/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crWoqs9TmxfyapEsfu46T1IVD8DYFQBIvK2BY+NoGRE=;
        b=dD0ckNgxm3z4RzYGQDjjwyB/8e9/jKAYzfItQ04RFgvs9opK8WGHsB2pzgCSxfApaV
         XYtysgYciHCnRbe2tvfUKE1BJxx/KKXurxG04sOakNsSt0CPl9ED9c/ogf9YeQc/nwMy
         eUON3xIJoTzPNSQKqrFwZE5ApiFDy/dz0Mg4EPntwE46lDUDQdAm+HEu7QVLDQgyynCT
         bsc6WUJTl1oyvaYbSmpD+uRdpgeSuntA4ZK4baVmVuI4RzzR6vE5wxKqOVIR1gwG4qld
         ljBOeSA2OLZINWQVnC7Hjl7SQAqM0hbRbFuWq7yxHojrt5o3BBzjxJAr9/UNVFzjpmHF
         b7TA==
X-Gm-Message-State: AOAM533obHHzMa8wCbhPbI8XuXYQiY1fBeOveDPfWVcKJq/1tsTSyPxX
        yLi5Kvv8x1swsxqCgG767jVtKw==
X-Google-Smtp-Source: ABdhPJwmvT4/K7M4aTsNpr5LCJuxE7/EGdf1guM8Agi8kBggdw93sJT/8aCo8e5eVVw3qF6blZFSPA==
X-Received: by 2002:a05:6512:3184:: with SMTP id i4mr7694870lfe.293.1643417507109;
        Fri, 28 Jan 2022 16:51:47 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:46 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/11 v2] power: supply: ab8500_chargalg: Drop enable/disable sysfs
Date:   Sat, 29 Jan 2022 01:49:23 +0100
Message-Id: <20220129004925.639684-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a sysfs ABI to enable/disable charging of different
types (AC/USB).

Since we don't have any userspace for this code, this sits
unused and it is not used on production products either.

Drop this code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_chargalg.c | 211 +------------------------
 1 file changed, 6 insertions(+), 205 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 9f9a84ad2da2..b5a3096e78a1 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -77,12 +77,6 @@ struct ab8500_chargalg_charger_info {
 	int ac_iset_ua;
 };
 
-struct ab8500_chargalg_suspension_status {
-	bool suspended_change;
-	bool ac_suspended;
-	bool usb_suspended;
-};
-
 struct ab8500_chargalg_battery_data {
 	int temp;
 	int volt_uv;
@@ -110,8 +104,6 @@ enum ab8500_chargalg_states {
 	STATE_TEMP_UNDEROVER,
 	STATE_TEMP_LOWHIGH_INIT,
 	STATE_TEMP_LOWHIGH,
-	STATE_SUSPENDED_INIT,
-	STATE_SUSPENDED,
 	STATE_OVV_PROTECT_INIT,
 	STATE_OVV_PROTECT,
 	STATE_SAFETY_TIMER_EXPIRED_INIT,
@@ -141,8 +133,6 @@ static const char * const states[] = {
 	"TEMP_UNDEROVER",
 	"TEMP_LOWHIGH_INIT",
 	"TEMP_LOWHIGH",
-	"SUSPENDED_INIT",
-	"SUSPENDED",
 	"OVV_PROTECT_INIT",
 	"OVV_PROTECT",
 	"SAFETY_TIMER_EXPIRED_INIT",
@@ -216,7 +206,6 @@ enum maxim_ret {
  * @ccm			charging current maximization parameters
  * @chg_info:		information about connected charger types
  * @batt_data:		data of the battery
- * @susp_status:	current charger suspension status
  * @bm:           	Platform specific battery management information
  * @parent:		pointer to the struct ab8500
  * @chargalg_psy:	structure that holds the battery properties exposed by
@@ -241,7 +230,6 @@ struct ab8500_chargalg {
 	struct ab8500_charge_curr_maximization ccm;
 	struct ab8500_chargalg_charger_info chg_info;
 	struct ab8500_chargalg_battery_data batt_data;
-	struct ab8500_chargalg_suspension_status susp_status;
 	struct ab8500 *parent;
 	struct ab8500_bm_data *bm;
 	struct power_supply *chargalg_psy;
@@ -372,37 +360,24 @@ static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
  */
 static int ab8500_chargalg_check_charger_connection(struct ab8500_chargalg *di)
 {
-	if (di->chg_info.conn_chg != di->chg_info.prev_conn_chg ||
-		di->susp_status.suspended_change) {
-		/*
-		 * Charger state changed or suspension
-		 * has changed since last update
-		 */
-		if ((di->chg_info.conn_chg & AC_CHG) &&
-			!di->susp_status.ac_suspended) {
-			dev_dbg(di->dev, "Charging source is AC\n");
+	if (di->chg_info.conn_chg != di->chg_info.prev_conn_chg) {
+		/* Charger state changed since last update */
+		if (di->chg_info.conn_chg & AC_CHG) {
+			dev_info(di->dev, "Charging source is AC\n");
 			if (di->chg_info.charger_type != AC_CHG) {
 				di->chg_info.charger_type = AC_CHG;
 				ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 			}
-		} else if ((di->chg_info.conn_chg & USB_CHG) &&
-			!di->susp_status.usb_suspended) {
-			dev_dbg(di->dev, "Charging source is USB\n");
+		} else if (di->chg_info.conn_chg & USB_CHG) {
+			dev_info(di->dev, "Charging source is USB\n");
 			di->chg_info.charger_type = USB_CHG;
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
-		} else if (di->chg_info.conn_chg &&
-			(di->susp_status.ac_suspended ||
-			di->susp_status.usb_suspended)) {
-			dev_dbg(di->dev, "Charging is suspended\n");
-			di->chg_info.charger_type = NO_CHG;
-			ab8500_chargalg_state_to(di, STATE_SUSPENDED_INIT);
 		} else {
 			dev_dbg(di->dev, "Charging source is OFF\n");
 			di->chg_info.charger_type = NO_CHG;
 			ab8500_chargalg_state_to(di, STATE_HANDHELD_INIT);
 		}
 		di->chg_info.prev_conn_chg = di->chg_info.conn_chg;
-		di->susp_status.suspended_change = false;
 	}
 	return di->chg_info.conn_chg;
 }
@@ -1281,12 +1256,6 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		}
 	}
 
-	/* If suspended, we should not continue checking the flags */
-	else if (di->charge_state == STATE_SUSPENDED_INIT ||
-		di->charge_state == STATE_SUSPENDED) {
-		/* We don't do anything here, just don,t continue */
-	}
-
 	/* Safety timer expiration */
 	else if (di->events.safety_timer_expired) {
 		if (di->charge_state != STATE_SAFETY_TIMER_EXPIRED)
@@ -1384,23 +1353,6 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	case STATE_HANDHELD:
 		break;
 
-	case STATE_SUSPENDED_INIT:
-		if (di->susp_status.ac_suspended)
-			ab8500_chargalg_ac_en(di, false, 0, 0);
-		if (di->susp_status.usb_suspended)
-			ab8500_chargalg_usb_en(di, false, 0, 0);
-		ab8500_chargalg_stop_safety_timer(di);
-		ab8500_chargalg_stop_maintenance_timer(di);
-		di->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		di->maintenance_chg = false;
-		ab8500_chargalg_state_to(di, STATE_SUSPENDED);
-		power_supply_changed(di->chargalg_psy);
-		fallthrough;
-
-	case STATE_SUSPENDED:
-		/* CHARGING is suspended */
-		break;
-
 	case STATE_BATT_REMOVED_INIT:
 		ab8500_chargalg_stop_charging(di);
 		ab8500_chargalg_state_to(di, STATE_BATT_REMOVED);
@@ -1684,144 +1636,6 @@ static int ab8500_chargalg_get_property(struct power_supply *psy,
 	return 0;
 }
 
-/* Exposure to the sysfs interface */
-
-static ssize_t ab8500_chargalg_en_show(struct ab8500_chargalg *di,
-				       char *buf)
-{
-	return sprintf(buf, "%d\n",
-		       di->susp_status.ac_suspended &&
-		       di->susp_status.usb_suspended);
-}
-
-static ssize_t ab8500_chargalg_en_store(struct ab8500_chargalg *di,
-	const char *buf, size_t length)
-{
-	long param;
-	int ac_usb;
-	int ret;
-
-	ret = kstrtol(buf, 10, &param);
-	if (ret < 0)
-		return ret;
-
-	ac_usb = param;
-	switch (ac_usb) {
-	case 0:
-		/* Disable charging */
-		di->susp_status.ac_suspended = true;
-		di->susp_status.usb_suspended = true;
-		di->susp_status.suspended_change = true;
-		/* Trigger a state change */
-		queue_work(di->chargalg_wq,
-			&di->chargalg_work);
-		break;
-	case 1:
-		/* Enable AC Charging */
-		di->susp_status.ac_suspended = false;
-		di->susp_status.suspended_change = true;
-		/* Trigger a state change */
-		queue_work(di->chargalg_wq,
-			&di->chargalg_work);
-		break;
-	case 2:
-		/* Enable USB charging */
-		di->susp_status.usb_suspended = false;
-		di->susp_status.suspended_change = true;
-		/* Trigger a state change */
-		queue_work(di->chargalg_wq,
-			&di->chargalg_work);
-		break;
-	default:
-		dev_info(di->dev, "Wrong input\n"
-			"Enter 0. Disable AC/USB Charging\n"
-			"1. Enable AC charging\n"
-			"2. Enable USB Charging\n");
-	}
-	return strlen(buf);
-}
-
-static struct ab8500_chargalg_sysfs_entry ab8500_chargalg_en_charger =
-	__ATTR(chargalg, 0644, ab8500_chargalg_en_show,
-				ab8500_chargalg_en_store);
-
-static ssize_t ab8500_chargalg_sysfs_show(struct kobject *kobj,
-	struct attribute *attr, char *buf)
-{
-	struct ab8500_chargalg_sysfs_entry *entry = container_of(attr,
-		struct ab8500_chargalg_sysfs_entry, attr);
-
-	struct ab8500_chargalg *di = container_of(kobj,
-		struct ab8500_chargalg, chargalg_kobject);
-
-	if (!entry->show)
-		return -EIO;
-
-	return entry->show(di, buf);
-}
-
-static ssize_t ab8500_chargalg_sysfs_charger(struct kobject *kobj,
-	struct attribute *attr, const char *buf, size_t length)
-{
-	struct ab8500_chargalg_sysfs_entry *entry = container_of(attr,
-		struct ab8500_chargalg_sysfs_entry, attr);
-
-	struct ab8500_chargalg *di = container_of(kobj,
-		struct ab8500_chargalg, chargalg_kobject);
-
-	if (!entry->store)
-		return -EIO;
-
-	return entry->store(di, buf, length);
-}
-
-static struct attribute *ab8500_chargalg_chg[] = {
-	&ab8500_chargalg_en_charger.attr,
-	NULL,
-};
-
-static const struct sysfs_ops ab8500_chargalg_sysfs_ops = {
-	.show = ab8500_chargalg_sysfs_show,
-	.store = ab8500_chargalg_sysfs_charger,
-};
-
-static struct kobj_type ab8500_chargalg_ktype = {
-	.sysfs_ops = &ab8500_chargalg_sysfs_ops,
-	.default_attrs = ab8500_chargalg_chg,
-};
-
-/**
- * ab8500_chargalg_sysfs_exit() - de-init of sysfs entry
- * @di:                pointer to the struct ab8500_chargalg
- *
- * This function removes the entry in sysfs.
- */
-static void ab8500_chargalg_sysfs_exit(struct ab8500_chargalg *di)
-{
-	kobject_del(&di->chargalg_kobject);
-}
-
-/**
- * ab8500_chargalg_sysfs_init() - init of sysfs entry
- * @di:                pointer to the struct ab8500_chargalg
- *
- * This function adds an entry in sysfs.
- * Returns error code in case of failure else 0(on success)
- */
-static int ab8500_chargalg_sysfs_init(struct ab8500_chargalg *di)
-{
-	int ret = 0;
-
-	ret = kobject_init_and_add(&di->chargalg_kobject,
-		&ab8500_chargalg_ktype,
-		NULL, "ab8500_chargalg");
-	if (ret < 0)
-		dev_err(di->dev, "failed to create sysfs entry\n");
-
-	return ret;
-}
-/* Exposure to the sysfs interface <<END>> */
-
 static int __maybe_unused ab8500_chargalg_resume(struct device *dev)
 {
 	struct ab8500_chargalg *di = dev_get_drvdata(dev);
@@ -1911,7 +1725,6 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct power_supply_config psy_cfg = {};
 	struct ab8500_chargalg *di;
-	int ret = 0;
 
 	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
@@ -1959,26 +1772,14 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, di);
 
-	/* sysfs interface to enable/disable charging from user space */
-	ret = ab8500_chargalg_sysfs_init(di);
-	if (ret) {
-		dev_err(di->dev, "failed to create sysfs entry\n");
-		return ret;
-	}
-
 	dev_info(di->dev, "probe success\n");
 	return component_add(dev, &ab8500_chargalg_component_ops);
 }
 
 static int ab8500_chargalg_remove(struct platform_device *pdev)
 {
-	struct ab8500_chargalg *di = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &ab8500_chargalg_component_ops);
 
-	/* sysfs interface to enable/disable charging from user space */
-	ab8500_chargalg_sysfs_exit(di);
-
 	return 0;
 }
 
-- 
2.34.1

