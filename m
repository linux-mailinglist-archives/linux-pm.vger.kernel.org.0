Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E42141FE9
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgASULg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 15:11:36 -0500
Received: from muru.com ([72.249.23.125]:51796 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASULf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Jan 2020 15:11:35 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CB9FF8132;
        Sun, 19 Jan 2020 20:12:17 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/3] RFC: power: supply: cpcap-battery: Implement capacity percentage
Date:   Sun, 19 Jan 2020 12:11:24 -0800
Message-Id: <20200119201124.29620-3-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119201124.29620-1-tony@atomide.com>
References: <20200119201124.29620-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Based on the saved high and low states, we can estimate battery state
based on the coulomb counter:

# cat /sys/class/power_supply/battery/capacity
...

Note that this too should probably be updated to use ocv-capacity-table.

Also note that I have not verified the shown capacity is very accurate.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Not-yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -504,6 +504,15 @@ static int cpcap_battery_get_rough_capacity(struct cpcap_battery_ddata *ddata)
 	return capacity;
 }
 
+static int cpcap_battery_get_rough_percentage(struct cpcap_battery_ddata *ddata)
+{
+	int percentage = 0;
+
+	cpcap_battery_get_rough(ddata, NULL, &percentage);
+
+	return percentage;
+}
+
 static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -518,6 +527,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_TEMP,
@@ -528,10 +538,10 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 				      union power_supply_propval *val)
 {
 	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
-	struct cpcap_battery_state_data *latest, *previous;
+	struct cpcap_battery_state_data *latest, *previous, *low, *high;
 	u32 sample;
 	s32 accumulator;
-	int cached;
+	int cached, delta, est;
 	s64 tmp;
 
 	cached = cpcap_battery_update_status(ddata);
@@ -608,6 +618,27 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		tmp *= ((latest->voltage + previous->voltage) / 20000);
 		val->intval = div64_s64(tmp, 100);
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		est = cpcap_battery_get_rough_percentage(ddata);
+		high = cpcap_battery_get_highest(ddata);
+		if (high->voltage) {
+			delta = latest->counter_uah - high->counter_uah;
+			val->intval = (ddata->config.info.charge_full_design -
+				       delta) * 100;
+			val->intval /= ddata->config.info.charge_full_design;
+			delta = abs(val->intval - est);
+			break;
+		}
+		low = cpcap_battery_get_lowest(ddata);
+		if (low->voltage) {
+			delta = low->counter_uah - latest->counter_uah;
+			val->intval = (delta * 100) /
+				ddata->config.info.charge_full_design;
+			delta = abs(val->intval - est);
+			break;
+		}
+		val->intval = est;
+		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		val->intval = cpcap_battery_get_rough_capacity(ddata);
 		break;
-- 
2.24.1
