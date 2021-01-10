Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4842F097E
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbhAJTzc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:32 -0500
Received: from muru.com ([72.249.23.125]:42504 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbhAJTzc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:32 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5364388B3;
        Sun, 10 Jan 2021 19:54:20 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 07/15] power: supply: cpcap-charger: Drop internal state and use generic stats
Date:   Sun, 10 Jan 2021 21:53:55 +0200
Message-Id: <20210110195403.13758-8-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We currently have both state and status, get rid of state and use
generic status instead.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 81 ++++++++++++++--------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -140,7 +140,6 @@ struct cpcap_charger_ddata {
 	atomic_t active;
 
 	int status;
-	int state;
 	int voltage;
 	int limit_current;
 };
@@ -386,6 +385,39 @@ static void cpcap_charger_set_inductive_path(struct cpcap_charger_ddata *ddata,
 	gpiod_set_value(ddata->gpio[1], enabled);
 }
 
+static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
+				       int state)
+{
+	const char *status;
+
+	if (state > POWER_SUPPLY_STATUS_FULL) {
+		dev_warn(ddata->dev, "unknown state: %i\n", state);
+
+		return;
+	}
+
+	ddata->status = state;
+
+	switch (state) {
+	case POWER_SUPPLY_STATUS_DISCHARGING:
+		status = "DISCONNECTED";
+		break;
+	case POWER_SUPPLY_STATUS_NOT_CHARGING:
+		status = "DETECTING";
+		break;
+	case POWER_SUPPLY_STATUS_CHARGING:
+		status = "CHARGING";
+		break;
+	case POWER_SUPPLY_STATUS_FULL:
+		status = "DONE";
+		break;
+	default:
+		return;
+	}
+
+	dev_dbg(ddata->dev, "state: %s\n", status);
+}
+
 static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 				   int max_voltage, int charge_current,
 				   int trickle_current)
@@ -402,11 +434,13 @@ static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 					   CPCAP_REG_CRM_FET_OVRD |
 					   CPCAP_REG_CRM_FET_CTRL);
 		if (error) {
-			ddata->status = POWER_SUPPLY_STATUS_UNKNOWN;
+			cpcap_charger_update_state(ddata,
+						   POWER_SUPPLY_STATUS_UNKNOWN);
 			goto out_err;
 		}
 
-		ddata->status = POWER_SUPPLY_STATUS_DISCHARGING;
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_DISCHARGING);
 
 		return 0;
 	}
@@ -419,11 +453,13 @@ static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 				   max_voltage |
 				   charge_current);
 	if (error) {
-		ddata->status = POWER_SUPPLY_STATUS_UNKNOWN;
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_UNKNOWN);
 		goto out_err;
 	}
 
-	ddata->status = POWER_SUPPLY_STATUS_CHARGING;
+	cpcap_charger_update_state(ddata,
+				   POWER_SUPPLY_STATUS_CHARGING);
 
 	return 0;
 
@@ -555,39 +591,6 @@ static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
 	return 0;
 }
 
-static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
-				       int state)
-{
-	const char *status;
-
-	if (state > POWER_SUPPLY_STATUS_FULL) {
-		dev_warn(ddata->dev, "unknown state: %i\n", state);
-
-		return;
-	}
-
-	ddata->state = state;
-
-	switch (state) {
-	case POWER_SUPPLY_STATUS_DISCHARGING:
-		status = "DISCONNECTED";
-		break;
-	case POWER_SUPPLY_STATUS_NOT_CHARGING:
-		status = "DETECTING";
-		break;
-	case POWER_SUPPLY_STATUS_CHARGING:
-		status = "CHARGING";
-		break;
-	case POWER_SUPPLY_STATUS_FULL:
-		status = "DONE";
-		break;
-	default:
-		return;
-	}
-
-	dev_dbg(ddata->dev, "state: %s\n", status);
-}
-
 static int cpcap_charger_voltage_to_regval(int voltage)
 {
 	int offset;
@@ -662,7 +665,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 	}
 
 	/* Throttle chrgcurr2 interrupt for charger done and retry */
-	switch (ddata->state) {
+	switch (ddata->status) {
 	case POWER_SUPPLY_STATUS_CHARGING:
 		if (s.chrgcurr2)
 			break;
-- 
2.30.0
