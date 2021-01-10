Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96E2F0983
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAJTze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:34 -0500
Received: from muru.com ([72.249.23.125]:42506 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbhAJTzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:33 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F3F0C88C3;
        Sun, 10 Jan 2021 19:54:23 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 09/15] power: supply: cpcap-charger: Provide state updates for battery from charger
Date:   Sun, 10 Jan 2021 21:53:57 +0200
Message-Id: <20210110195403.13758-10-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We want to have the battery update it's status when the charge is done,
and when the charger is disconnected. Otherwise the battery does not know
when it's full unless there's a userspace app polling the battery status.

To do this, we add supplied_to handling to cpcap-battery, and implement
power_supply_changed() for cpcap-charger. When cpcap-charger calls
power_supply_changed(), cpcap-battery will update it's status.

Let's also use new_state variable for the POWER_SUPPLY_STATUS_CHARGING
case to have unified handling for the switch.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 13 +++++++++++
 drivers/power/supply/cpcap-charger.c | 34 ++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -416,6 +416,18 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	return 0;
 }
 
+/*
+ * Update battery status when cpcap-charger calls power_supply_changed().
+ * This allows us to detect battery full condition before the charger
+ * disconnects.
+ */
+static void cpcap_battery_external_power_changed(struct power_supply *psy)
+{
+	union power_supply_propval prop;
+
+	power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &prop);
+}
+
 static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -914,6 +926,7 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	psy_desc->get_property = cpcap_battery_get_property;
 	psy_desc->set_property = cpcap_battery_set_property;
 	psy_desc->property_is_writeable = cpcap_battery_property_is_writeable;
+	psy_desc->external_power_changed = cpcap_battery_external_power_changed;
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = ddata;
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -613,6 +613,16 @@ static void cpcap_charger_disconnect(struct cpcap_charger_ddata *ddata,
 {
 	int error;
 
+	/* Update battery state before disconnecting the charger */
+	switch (state) {
+	case POWER_SUPPLY_STATUS_DISCHARGING:
+	case POWER_SUPPLY_STATUS_FULL:
+		power_supply_changed(ddata->usb);
+		break;
+	default:
+		break;
+	}
+
 	error = cpcap_charger_disable(ddata);
 	if (error) {
 		cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
@@ -628,7 +638,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 {
 	struct cpcap_charger_ddata *ddata;
 	struct cpcap_charger_ints_state s;
-	int error;
+	int error, new_state;
 
 	ddata = container_of(work, struct cpcap_charger_ddata,
 			     detect_work.work);
@@ -662,19 +672,23 @@ static void cpcap_usb_detect(struct work_struct *work)
 	case POWER_SUPPLY_STATUS_CHARGING:
 		if (s.chrgcurr2)
 			break;
+		new_state = POWER_SUPPLY_STATUS_FULL;
+
 		if (s.chrgcurr1 && s.vbusvld) {
-			cpcap_charger_disconnect(ddata,
-						 POWER_SUPPLY_STATUS_FULL,
-						 HZ * 5);
+			cpcap_charger_disconnect(ddata, new_state, HZ * 5);
 			return;
 		}
 		break;
 	case POWER_SUPPLY_STATUS_FULL:
 		if (!s.chrgcurr2)
 			break;
-		cpcap_charger_disconnect(ddata,
-					 POWER_SUPPLY_STATUS_NOT_CHARGING,
-					 HZ * 5);
+		if (s.vbusvld)
+			new_state = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else
+			new_state = POWER_SUPPLY_STATUS_DISCHARGING;
+
+		cpcap_charger_disconnect(ddata, new_state, HZ * 5);
+
 		return;
 	default:
 		break;
@@ -832,6 +846,10 @@ static int cpcap_charger_init_iio(struct cpcap_charger_ddata *ddata)
 	return error;
 }
 
+static char *cpcap_charger_supplied_to[] = {
+	"battery",
+};
+
 static const struct power_supply_desc cpcap_charger_usb_desc = {
 	.name		= "usb",
 	.type		= POWER_SUPPLY_TYPE_USB,
@@ -889,6 +907,8 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = ddata;
+	psy_cfg.supplied_to = cpcap_charger_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(cpcap_charger_supplied_to),
 
 	ddata->usb = devm_power_supply_register(ddata->dev,
 						&cpcap_charger_usb_desc,
-- 
2.30.0
