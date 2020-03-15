Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA3185F83
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 20:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgCOTTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 15:19:37 -0400
Received: from muru.com ([72.249.23.125]:60520 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgCOTTe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 15:19:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 57F6381D5;
        Sun, 15 Mar 2020 19:20:18 +0000 (UTC)
Date:   Sun, 15 Mar 2020 12:19:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
Message-ID: <20200315191929.GJ37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315185857.GA4914@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200315185857.GA4914@amd>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200315 18:59]:
> Hi!
> 
> > Don't report that the battery is fully charged if the charging current
> > exceeds 100 mA.
> 
> Could you merge patches together for possibility of reasonable review?
> 
> > @@ -408,7 +408,8 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
> >  	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
> >  
> >  	if (state->voltage >=
> > -	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
> > +	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000) &&
> > +		state->current_ua > -100000)
> 
> It seems that this 100mA threshold is changed about 3 times in the
> series :-(.
> 
> Plus, it might be better to place booleans into struct, rather than
> using "static bool" inside a function.
> 
> Could we get some kind of explanations for the whole series? 100mA is
> rather high current for end of charge. If you stop updating
> full capacity when "your" end of charge is met, you'll have battery
> charged to more than 100%. I... don't think that makes sense.

Yeh please compress out the unncessary parts of my RFC patches :)

For reference only, below is a diff of all the changes for
cpcap-battery.c against v5.6-rc5.

I applied this series on top of a droid4-pending-v5.6 based branch
that has the earlier RFC changes applied.

Regards,

Tony

8< -----------------
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -110,6 +110,8 @@ struct cpcap_coulomb_counter_data {
 enum cpcap_battery_state {
 	CPCAP_BATTERY_STATE_PREVIOUS,
 	CPCAP_BATTERY_STATE_LATEST,
+	CPCAP_BATTERY_STATE_EMPTY,
+	CPCAP_BATTERY_STATE_FULL,
 	CPCAP_BATTERY_STATE_NR,
 };
 
@@ -132,10 +134,32 @@ struct cpcap_battery_ddata {
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
 	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
+	int charge_full;
 	int status;
 	u16 vendor;
 };
 
+struct cpcap_battery_capacity {
+	int capacity;
+	int voltage;
+};
+
+#define CPCAP_CAP(l, v)				\
+{						\
+	.capacity = (l),			\
+	.voltage = (v),				\
+},
+
+/* Pessimistic battery capacity mapping before high or low value is seen */
+static const struct cpcap_battery_capacity cpcap_battery_cap[] = {
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN,        0)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL, 3100000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_LOW,      3300000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,   3700000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_HIGH,     4000000)
+	CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL,     4200000 - 18000)
+};
+
 #define CPCAP_NO_BATTERY	-400
 
 static struct cpcap_battery_state_data *
@@ -160,6 +184,18 @@ cpcap_battery_previous(struct cpcap_battery_ddata *ddata)
 	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_PREVIOUS);
 }
 
+static struct cpcap_battery_state_data *
+cpcap_battery_get_empty(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_EMPTY);
+}
+
+static struct cpcap_battery_state_data *
+cpcap_battery_get_full(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_FULL);
+}
+
 static int cpcap_charger_battery_temperature(struct cpcap_battery_ddata *ddata,
 					     int *value)
 {
@@ -369,17 +405,39 @@ static int cpcap_battery_cc_get_avg_current(struct cpcap_battery_ddata *ddata)
 static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	static bool is_full;
+
+	if (state->voltage <
+	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000)) {
+		is_full = false;
+	} else if (is_full) {
+		if (state->current_ua < -170000)
+			is_full = false;
+	} else if (state->current_ua >= -170000 &&
+		   cpcap_battery_cc_get_avg_current(ddata) >= -112000) {
+		is_full = true;
+	}
+
+	return is_full;
+}
 
-	if (state->voltage >=
-	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
-		return true;
+static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
+{
+	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	static bool is_low;
 
-	return false;
+	if (state->current_ua > 0 && (state->voltage <= 3350000 || is_low))
+		is_low = true;
+	else
+		is_low = false;
+
+	return is_low;
 }
 
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 {
-	struct cpcap_battery_state_data state, *latest, *previous;
+	struct cpcap_battery_state_data state, *latest, *previous,
+					*empty, *full;
 	ktime_t now;
 	int error;
 
@@ -408,9 +466,56 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	memcpy(previous, latest, sizeof(*previous));
 	memcpy(latest, &state, sizeof(*latest));
 
+	if (cpcap_battery_full(ddata)) {
+		full = cpcap_battery_get_full(ddata);
+		memcpy(full, latest, sizeof(*full));
+
+		empty = cpcap_battery_get_empty(ddata);
+		if (empty->voltage && empty->voltage != -1) {
+			empty->voltage = -1;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
+		} else if (ddata->charge_full) {
+			empty->voltage = -1;
+			empty->counter_uah =
+				full->counter_uah + ddata->charge_full;
+		}
+	} else if (cpcap_battery_low(ddata)) {
+		empty = cpcap_battery_get_empty(ddata);
+		memcpy(empty, latest, sizeof(*empty));
+
+		full = cpcap_battery_get_full(ddata);
+		if (full->voltage) {
+			full->voltage = 0;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
+		}
+	}
+
 	return 0;
 }
 
+static int cpcap_battery_get_capacity_level(struct cpcap_battery_ddata *ddata)
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
+		return 0;
+
+	return cap->capacity;
+}
+
 static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -421,10 +526,13 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_TEMP,
@@ -435,7 +543,7 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 				      union power_supply_propval *val)
 {
 	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
-	struct cpcap_battery_state_data *latest, *previous;
+	struct cpcap_battery_state_data *latest, *previous, *empty;
 	u32 sample;
 	s32 accumulator;
 	int cached;
@@ -515,19 +623,33 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		tmp *= ((latest->voltage + previous->voltage) / 20000);
 		val->intval = div64_s64(tmp, 100);
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		empty = cpcap_battery_get_empty(ddata);
+		if (!empty->voltage || !ddata->charge_full)
+			return -ENODATA;
+		/* (ddata->charge_full / 200) is needed for rounding */
+		val->intval = empty->counter_uah - latest->counter_uah +
+			ddata->charge_full / 200;
+		val->intval = clamp(val->intval, 0, ddata->charge_full);
+		val->intval = val->intval * 100 / ddata->charge_full;
+		break;
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
+		val->intval = cpcap_battery_get_capacity_level(ddata);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		empty = cpcap_battery_get_empty(ddata);
+		if (!empty->voltage)
+			return -ENODATA;
+		val->intval = empty->counter_uah - latest->counter_uah;
+		if (val->intval < 0)
+			val->intval = 0;
+		else if (ddata->charge_full && ddata->charge_full < val->intval)
+			val->intval = ddata->charge_full;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (!ddata->charge_full)
+			return -ENODATA;
+		val->intval = ddata->charge_full;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = ddata->config.info.charge_full_design;
@@ -590,6 +712,15 @@ static int cpcap_battery_set_property(struct power_supply *psy,
 		ddata->config.bat.constant_charge_voltage_max_uv = val->intval;
 
 		return cpcap_battery_update_charger(ddata, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (val->intval < 0)
+			return -EINVAL;
+		if (val->intval > ddata->config.info.charge_full_design)
+			return -EINVAL;
+
+		ddata->charge_full = val->intval;
+
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -602,6 +733,7 @@ static int cpcap_battery_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		return 1;
 	default:
 		return 0;
