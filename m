Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3C2F0981
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhAJTzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:33 -0500
Received: from muru.com ([72.249.23.125]:42508 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbhAJTzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:33 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BC42288CC;
        Sun, 10 Jan 2021 19:54:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 10/15] power: supply: cpcap-battery: Use charger status for battery full detection
Date:   Sun, 10 Jan 2021 21:53:58 +0200
Message-Id: <20210110195403.13758-11-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We now get battery full notification from cpcap-charger, so let's use that
for battery full status and charger disconnect.

Note that any current based battery full detection we have tried earlier is
flakey as it won't account for example for CPU load increasing the battery
current. Anyways, if current based battery full detection is also still
needed, we can reconsider adding it in addition to the charger status based
detection.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 56 ++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -135,6 +135,7 @@ struct cpcap_battery_ddata {
 	atomic_t active;
 	int status;
 	u16 vendor;
+	unsigned int is_full:1;
 };
 
 #define CPCAP_NO_BATTERY	-400
@@ -371,15 +372,62 @@ static int cpcap_battery_cc_get_avg_current(struct cpcap_battery_ddata *ddata)
 	return cpcap_battery_cc_to_ua(ddata, sample, acc, offset);
 }
 
+static int cpcap_battery_get_charger_status(struct cpcap_battery_ddata *ddata,
+					    int *val)
+{
+	union power_supply_propval prop;
+	struct power_supply *charger;
+	int error;
+
+	charger = power_supply_get_by_name("usb");
+	if (!charger)
+		return -ENODEV;
+
+	error = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS,
+					  &prop);
+	if (error)
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	else
+		*val = prop.intval;
+
+	power_supply_put(charger);
+
+	return error;
+}
+
 static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	unsigned int vfull;
+	int error, val;
+
+	error = cpcap_battery_get_charger_status(ddata, &val);
+	if (!error) {
+		switch (val) {
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+			dev_dbg(ddata->dev, "charger disconnected\n");
+			ddata->is_full = 0;
+			break;
+		case POWER_SUPPLY_STATUS_FULL:
+			dev_dbg(ddata->dev, "charger full status\n");
+			ddata->is_full = 1;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/*
+	 * The full battery voltage here can be inaccurate, it's used just to
+	 * filter out any trickle charging events. We clear the is_full status
+	 * on charger disconnect above anyways.
+	 */
+	vfull = ddata->config.bat.constant_charge_voltage_max_uv - 120000;
 
-	if (state->voltage >=
-	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
-		return true;
+	if (ddata->is_full && state->voltage < vfull)
+		ddata->is_full = 0;
 
-	return false;
+	return ddata->is_full;
 }
 
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
-- 
2.30.0
