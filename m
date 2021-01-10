Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B332F0979
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAJTza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:30 -0500
Received: from muru.com ([72.249.23.125]:42498 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbhAJTza (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:30 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B53BE8191;
        Sun, 10 Jan 2021 19:54:16 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 05/15] power: supply: cpcap-charger: Use standard enumeration
Date:   Sun, 10 Jan 2021 21:53:53 +0200
Message-Id: <20210110195403.13758-6-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just get rid of the custom enumeration if favor of the standard one.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 39 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -120,13 +120,6 @@ enum {
 	CPCAP_CHARGER_IIO_NR,
 };
 
-enum {
-	CPCAP_CHARGER_DISCONNECTED,
-	CPCAP_CHARGER_DETECTING,
-	CPCAP_CHARGER_CHARGING,
-	CPCAP_CHARGER_DONE,
-};
-
 struct cpcap_charger_ddata {
 	struct device *dev;
 	struct regmap *reg;
@@ -533,7 +526,7 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
 {
 	const char *status;
 
-	if (state > CPCAP_CHARGER_DONE) {
+	if (state > POWER_SUPPLY_STATUS_FULL) {
 		dev_warn(ddata->dev, "unknown state: %i\n", state);
 
 		return;
@@ -542,16 +535,16 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
 	ddata->state = state;
 
 	switch (state) {
-	case CPCAP_CHARGER_DISCONNECTED:
+	case POWER_SUPPLY_STATUS_DISCHARGING:
 		status = "DISCONNECTED";
 		break;
-	case CPCAP_CHARGER_DETECTING:
+	case POWER_SUPPLY_STATUS_NOT_CHARGING:
 		status = "DETECTING";
 		break;
-	case CPCAP_CHARGER_CHARGING:
+	case POWER_SUPPLY_STATUS_CHARGING:
 		status = "CHARGING";
 		break;
-	case CPCAP_CHARGER_DONE:
+	case POWER_SUPPLY_STATUS_FULL:
 		status = "DONE";
 		break;
 	default:
@@ -616,7 +609,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	/* Just init the state if a charger is connected with no chrg_det set */
 	if (!s.chrg_det && s.chrgcurr1 && s.vbusvld) {
-		cpcap_charger_update_state(ddata, CPCAP_CHARGER_DETECTING);
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_NOT_CHARGING);
 
 		return;
 	}
@@ -626,7 +620,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 	 * charged to 4.35V by Android. Try again in 10 minutes.
 	 */
 	if (cpcap_charger_get_charge_voltage(ddata) > ddata->voltage) {
-		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+		cpcap_charger_disconnect(ddata,
+					 POWER_SUPPLY_STATUS_NOT_CHARGING,
 					 HZ * 60 * 10);
 
 		return;
@@ -634,19 +629,21 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	/* Throttle chrgcurr2 interrupt for charger done and retry */
 	switch (ddata->state) {
-	case CPCAP_CHARGER_CHARGING:
+	case POWER_SUPPLY_STATUS_CHARGING:
 		if (s.chrgcurr2)
 			break;
 		if (s.chrgcurr1 && s.vbusvld) {
-			cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DONE,
+			cpcap_charger_disconnect(ddata,
+						 POWER_SUPPLY_STATUS_FULL,
 						 HZ * 5);
 			return;
 		}
 		break;
-	case CPCAP_CHARGER_DONE:
+	case POWER_SUPPLY_STATUS_FULL:
 		if (!s.chrgcurr2)
 			break;
-		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+		cpcap_charger_disconnect(ddata,
+					 POWER_SUPPLY_STATUS_NOT_CHARGING,
 					 HZ * 5);
 		return;
 	default:
@@ -669,12 +666,14 @@ static void cpcap_usb_detect(struct work_struct *work)
 						max_current, 0);
 		if (error)
 			goto out_err;
-		cpcap_charger_update_state(ddata, CPCAP_CHARGER_CHARGING);
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_CHARGING);
 	} else {
 		error = cpcap_charger_set_state(ddata, 0, 0, 0);
 		if (error)
 			goto out_err;
-		cpcap_charger_update_state(ddata, CPCAP_CHARGER_DISCONNECTED);
+		cpcap_charger_update_state(ddata,
+					   POWER_SUPPLY_STATUS_DISCHARGING);
 	}
 
 	power_supply_changed(ddata->usb);
-- 
2.30.0
