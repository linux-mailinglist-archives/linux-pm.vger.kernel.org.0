Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736592F097D
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAJTzc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:32 -0500
Received: from muru.com ([72.249.23.125]:42502 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbhAJTzc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:32 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 26D0E88B4;
        Sun, 10 Jan 2021 19:54:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 08/15] power: supply: cpcap-charger: Simplify things with enable and disable
Date:   Sun, 10 Jan 2021 21:53:56 +0200
Message-Id: <20210110195403.13758-9-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's turn cpcap_charger_set_state() into separate cpcap_charger_enable()
and cpcap_charger_disable() to simplify things, and to allow managing
status separately. This can be then used for the follow-up patches to
make battery full status behave a bit nicer.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 81 ++++++++++++++--------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -418,32 +418,30 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
 	dev_dbg(ddata->dev, "state: %s\n", status);
 }
 
-static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
-				   int max_voltage, int charge_current,
-				   int trickle_current)
+static int cpcap_charger_disable(struct cpcap_charger_ddata *ddata)
 {
-	bool enable;
 	int error;
 
-	enable = (charge_current || trickle_current);
-	dev_dbg(ddata->dev, "%s enable: %i\n", __func__, enable);
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
+				   CPCAP_REG_CRM_FET_OVRD |
+				   CPCAP_REG_CRM_FET_CTRL);
+	if (error)
+		dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
 
-	if (!enable) {
-		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
-					   0x3fff,
-					   CPCAP_REG_CRM_FET_OVRD |
-					   CPCAP_REG_CRM_FET_CTRL);
-		if (error) {
-			cpcap_charger_update_state(ddata,
-						   POWER_SUPPLY_STATUS_UNKNOWN);
-			goto out_err;
-		}
+	return error;
+}
 
-		cpcap_charger_update_state(ddata,
-					   POWER_SUPPLY_STATUS_DISCHARGING);
+static int cpcap_charger_enable(struct cpcap_charger_ddata *ddata,
+				int max_voltage, int charge_current,
+				int trickle_current)
+{
+	int error;
 
-		return 0;
-	}
+	if (!max_voltage || !charge_current)
+		return -EINVAL;
+
+	dev_dbg(ddata->dev, "enable: %i %i %i\n",
+		max_voltage, charge_current, trickle_current);
 
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
 				   CPCAP_REG_CRM_CHRG_LED_EN |
@@ -452,19 +450,8 @@ static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 				   CPCAP_REG_CRM_FET_CTRL |
 				   max_voltage |
 				   charge_current);
-	if (error) {
-		cpcap_charger_update_state(ddata,
-					   POWER_SUPPLY_STATUS_UNKNOWN);
-		goto out_err;
-	}
-
-	cpcap_charger_update_state(ddata,
-				   POWER_SUPPLY_STATUS_CHARGING);
-
-	return 0;
-
-out_err:
-	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
+	if (error)
+		dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
 
 	return error;
 }
@@ -506,10 +493,13 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 		cpcap_charger_set_cable_path(ddata, false);
 		cpcap_charger_set_inductive_path(ddata, false);
 
-		error = cpcap_charger_set_state(ddata, 0, 0, 0);
+		error = cpcap_charger_disable(ddata);
 		if (error)
 			goto out_err;
 
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_DISCHARGING);
+
 		error = regmap_update_bits(ddata->reg, CPCAP_REG_VUSBC,
 					   CPCAP_BIT_VBUS_SWITCH,
 					   CPCAP_BIT_VBUS_SWITCH);
@@ -540,6 +530,7 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 	return;
 
 out_err:
+	cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
 	dev_err(ddata->dev, "%s could not %s vbus: %i\n", __func__,
 		ddata->vbus_enabled ? "enable" : "disable", error);
 }
@@ -622,9 +613,11 @@ static void cpcap_charger_disconnect(struct cpcap_charger_ddata *ddata,
 {
 	int error;
 
-	error = cpcap_charger_set_state(ddata, 0, 0, 0);
-	if (error)
+	error = cpcap_charger_disable(ddata);
+	if (error) {
+		cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
 		return;
+	}
 
 	cpcap_charger_update_state(ddata, state);
 	power_supply_changed(ddata->usb);
@@ -700,15 +693,15 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 		ichrg = cpcap_charger_current_to_regval(max_current);
 		vchrg = cpcap_charger_voltage_to_regval(ddata->voltage);
-		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG(vchrg),
-						ichrg, 0);
+		error = cpcap_charger_enable(ddata,
+					     CPCAP_REG_CRM_VCHRG(vchrg),
+					     ichrg, 0);
 		if (error)
 			goto out_err;
 		cpcap_charger_update_state(ddata,
 					   POWER_SUPPLY_STATUS_CHARGING);
 	} else {
-		error = cpcap_charger_set_state(ddata, 0, 0, 0);
+		error = cpcap_charger_disable(ddata);
 		if (error)
 			goto out_err;
 		cpcap_charger_update_state(ddata,
@@ -719,6 +712,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 	return;
 
 out_err:
+	cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
 	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
 }
 
@@ -936,10 +930,13 @@ static void cpcap_charger_shutdown(struct platform_device *pdev)
 		dev_warn(ddata->dev, "could not clear USB comparator: %i\n",
 			 error);
 
-	error = cpcap_charger_set_state(ddata, 0, 0, 0);
-	if (error)
+	error = cpcap_charger_disable(ddata);
+	if (error) {
+		cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
 		dev_warn(ddata->dev, "could not clear charger: %i\n",
 			 error);
+	}
+	cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_DISCHARGING);
 	cancel_delayed_work_sync(&ddata->vbus_work);
 	cancel_delayed_work_sync(&ddata->detect_work);
 }
-- 
2.30.0
