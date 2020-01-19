Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A6141FE5
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgASULe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 15:11:34 -0500
Received: from muru.com ([72.249.23.125]:51782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASULe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Jan 2020 15:11:34 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8E361804F;
        Sun, 19 Jan 2020 20:12:15 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for rough capacity
Date:   Sun, 19 Jan 2020 12:11:22 -0800
Message-Id: <20200119201124.29620-1-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Get a rough battery charge estimate until we've seen a high or low
battery level. After that we can use the coulomb counter to calculate
the battery capacity.

Note that I should probably update this to support ocv-capacity-table
before this makes sense to apply. With ocv-capacity-table we should be
able to estimate battery state as described in the documentation for
Documentation/devicetree/bindings/power/supply/battery.txt.

We do have some unknown battery data available over 1-wire, but the
format is unkonwn. If somebody ever figures out that format, we can
then switch to use the real battery data instead of ocv-capacity-table.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Not-yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 70 +++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -136,6 +136,29 @@ struct cpcap_battery_ddata {
 	u16 vendor;
 };
 
+struct cpcap_battery_capacity {
+	int capacity;
+	int voltage;
+	int percentage;
+};
+
+#define CPCAP_CAP(l, v, p)			\
+{						\
+	.capacity = (l),			\
+	.voltage = (v),				\
+	.percentage = (p),			\
+},
+
+/* Pessimistic battery capacity mapping before high or low value is seen */
+static const struct cpcap_battery_capacity cpcap_battery_cap[] = {
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN,        0,   0)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL, 3100000,   0)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_LOW,      3300000,   2)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,   3700000,  50)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_HIGH,     4000000,  75)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL,     4200000 - 18000, 100)
+};
+
 #define CPCAP_NO_BATTERY	-400
 
 static struct cpcap_battery_state_data *
@@ -411,6 +434,40 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	return 0;
 }
 
+static void cpcap_battery_get_rough(struct cpcap_battery_ddata *ddata,
+				    int *level, int *percentage)
+{
+	struct cpcap_battery_state_data *latest;
+	const struct cpcap_battery_capacity *cap = NULL;
+	int voltage, i;
+
+	latest = cpcap_battery_latest(ddata);
+	voltage = latest->voltage;
+
+	for (i = ARRAY_SIZE(cpcap_battery_cap) - 1; i >=0; i--) {
+		cap = &cpcap_battery_cap[i];
+		if (voltage >= cap->voltage)
+			break;
+	}
+
+	if (!cap)
+		return;
+
+	if (level)
+		*level = cap->capacity;
+	if (percentage)
+		*percentage = cap->percentage;
+}
+
+static int cpcap_battery_get_rough_capacity(struct cpcap_battery_ddata *ddata)
+{
+	int capacity = 0;
+
+	cpcap_battery_get_rough(ddata, &capacity, NULL);
+
+	return capacity;
+}
+
 static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -516,18 +573,7 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = div64_s64(tmp, 100);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		if (cpcap_battery_full(ddata))
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (latest->voltage >= 3750000)
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
-		else if (latest->voltage >= 3300000)
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
-		else if (latest->voltage > 3100000)
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
-		else if (latest->voltage <= 3100000)
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
-		else
-			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		val->intval = cpcap_battery_get_rough_capacity(ddata);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = ddata->config.info.charge_full_design;
-- 
2.24.1
