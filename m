Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B220185DE2
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgCOPOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so17742196wrc.2;
        Sun, 15 Mar 2020 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fOEz6aZDrZFHHHa5AM3closKBpa5Nsq+Hwyn3tGe+Lw=;
        b=JiJyJXqZ32FusFx8+3ZU7Xr93OLwjb0MgoHiGl+r1V9HoHvpHsK3Up9YTzjIUH38aw
         yfTWDD3G/o5IJ+CRLe5IQwuu6NaRppPMuZmlHWMUOnnMG2r+USqfOi6K1r8hjdI0ybEm
         4SF1b07LIuZm7PMTDG0y54iFbyNNUwSIG/st2Lu4EkAflDCydseqLgyE6F659fPWXfgx
         z8smGCKkRr4+KRMVqSKDvD+LfUq32Z6kio1sWRly3W7t1txptdfBCG775z8dg7MVfyDe
         6dCr7CLs/6Q7ByETbivSyzpLMvYMUKFPJe9Pj688HSnecXNf+1qiWH6QxyGjcQIlOKpD
         tR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fOEz6aZDrZFHHHa5AM3closKBpa5Nsq+Hwyn3tGe+Lw=;
        b=C3P9DzfQIDC2w/sSiKMIYqXUQXsKsE/5zd75I3gcpnBSqNjwr8M9t7OMgq0oppy1ms
         t3BDLa+jPQJ8LPhVNc6g5mk9P4o+dOrjsN5wtUKTkK5ga7BpF8rNJYSBHKqGUPRYOaZJ
         QXOJHhGrKCER10sR4IUCr3G8M72vZaJvcK6xKLCNUBdog7uLrj4SeB4D00GeUU9gN1R/
         zulRPfwNGRWh434IPmmQLKt1CHqZ1fQzIhqmEzbSv7mb/YYwzA5KbHYAty1nuzHCYZjn
         y0Ix0ogwQBLXYDgoVY6gzTiUoZk8Ses2k69sRBqMcnZLwYWVQmlnpEhu2Oykmh2Il5Ee
         Sz8A==
X-Gm-Message-State: ANhLgQ3EHSF+HKO9tZh9E/SoiKK2ApBXrmquKMkeVQA1J5rESwxAnkCE
        POcEix5VYidF+A43Qdv65Qk=
X-Google-Smtp-Source: ADFU+vu8emjyc30P+CNeBZzNm2q+Vs5G3iN3yO3IGNBjlGUxX2/LIocbc3RSR3ISZSwQMZee0fSGdw==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr14057038wrp.129.1584285285030;
        Sun, 15 Mar 2020 08:14:45 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:44 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 11/15] power: supply: cpcap-battery: Rename properties, variables and functions
Date:   Sun, 15 Mar 2020 18:12:02 +0300
Message-Id: <20200315151206.30909-11-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a preparation for the following change which will stabilize
battery full charge value when calibrating.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 75 ++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 6205a5e43a32..66ea1a718e02 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -110,8 +110,8 @@ struct cpcap_coulomb_counter_data {
 enum cpcap_battery_state {
 	CPCAP_BATTERY_STATE_PREVIOUS,
 	CPCAP_BATTERY_STATE_LATEST,
-	CPCAP_BATTERY_STATE_LOW,
-	CPCAP_BATTERY_STATE_HIGH,
+	CPCAP_BATTERY_STATE_EMPTY,
+	CPCAP_BATTERY_STATE_FULL,
 	CPCAP_BATTERY_STATE_NR,
 };
 
@@ -185,15 +185,15 @@ cpcap_battery_previous(struct cpcap_battery_ddata *ddata)
 }
 
 static struct cpcap_battery_state_data *
-cpcap_battery_get_lowest(struct cpcap_battery_ddata *ddata)
+cpcap_battery_get_empty(struct cpcap_battery_ddata *ddata)
 {
-	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_LOW);
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_EMPTY);
 }
 
 static struct cpcap_battery_state_data *
-cpcap_battery_get_highest(struct cpcap_battery_ddata *ddata)
+cpcap_battery_get_full(struct cpcap_battery_ddata *ddata)
 {
-	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_HIGH);
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_FULL);
 }
 
 static int cpcap_charger_battery_temperature(struct cpcap_battery_ddata *ddata,
@@ -436,7 +436,8 @@ static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
 
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 {
-	struct cpcap_battery_state_data state, *latest, *previous, *low, *high;
+	struct cpcap_battery_state_data state, *latest, *previous,
+					*empty, *full;
 	ktime_t now;
 	int error;
 
@@ -466,39 +467,39 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	memcpy(latest, &state, sizeof(*latest));
 
 	if (cpcap_battery_full(ddata)) {
-		high = cpcap_battery_get_highest(ddata);
-		/* Update highest charge seen? */
-		if (latest->counter_uah <= high->counter_uah ||
-		    !high->voltage) {
-			memcpy(high, latest, sizeof(*high));
-
-			low = cpcap_battery_get_lowest(ddata);
-			if (low->voltage && low->voltage != -1)
+		full = cpcap_battery_get_full(ddata);
+		/* Update full state value? */
+		if (latest->counter_uah <= full->counter_uah ||
+		    !full->voltage) {
+			memcpy(full, latest, sizeof(*full));
+
+			empty = cpcap_battery_get_empty(ddata);
+			if (empty->voltage && empty->voltage != -1)
 				ddata->charge_full =
-					low->counter_uah - high->counter_uah;
+					empty->counter_uah - full->counter_uah;
 			else if (ddata->charge_full) {
 				/* Initialize with user provided data */
-				low->counter_uah =
-					high->counter_uah + ddata->charge_full;
+				empty->counter_uah =
+					full->counter_uah + ddata->charge_full;
 				/* Mark it as initialized */
-				low->voltage = -1;
+				empty->voltage = -1;
 			}
 		}
 	} else if (cpcap_battery_low(ddata)) {
-		low = cpcap_battery_get_lowest(ddata);
-		/* Update lowest charge seen? */
-		if (latest->counter_uah >= low->counter_uah ||
-		    !low->voltage) {
-			memcpy(low, latest, sizeof(*low));
-
-			high = cpcap_battery_get_highest(ddata);
-			if (high->voltage)
+		empty = cpcap_battery_get_empty(ddata);
+		/* Update empty state value? */
+		if (latest->counter_uah >= empty->counter_uah ||
+		    !empty->voltage) {
+			memcpy(empty, latest, sizeof(*empty));
+
+			full = cpcap_battery_get_full(ddata);
+			if (full->voltage)
 				ddata->charge_full =
-					low->counter_uah - high->counter_uah;
+					empty->counter_uah - full->counter_uah;
 			else if (ddata->charge_full)
 				/* Initialize with user provided data */
-				high->counter_uah =
-					low->counter_uah - ddata->charge_full;
+				full->counter_uah =
+					empty->counter_uah - ddata->charge_full;
 		}
 	}
 
@@ -553,7 +554,7 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 				      union power_supply_propval *val)
 {
 	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
-	struct cpcap_battery_state_data *latest, *previous, *low;
+	struct cpcap_battery_state_data *latest, *previous, *empty;
 	u32 sample;
 	s32 accumulator;
 	int cached;
@@ -634,10 +635,10 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = div64_s64(tmp, 100);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		low = cpcap_battery_get_lowest(ddata);
-		if (!low->voltage || !ddata->charge_full)
+		empty = cpcap_battery_get_empty(ddata);
+		if (!empty->voltage || !ddata->charge_full)
 			return -ENODATA;
-		val->intval = (low->counter_uah -
+		val->intval = (empty->counter_uah -
 			       latest->counter_uah) * 100;
 		val->intval /= ddata->charge_full;
 		break;
@@ -645,10 +646,10 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = cpcap_battery_get_capacity_level(ddata);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		low = cpcap_battery_get_lowest(ddata);
-		if (!low->voltage)
+		empty = cpcap_battery_get_empty(ddata);
+		if (!empty->voltage)
 			return -ENODATA;
-		val->intval = low->counter_uah - latest->counter_uah;
+		val->intval = empty->counter_uah - latest->counter_uah;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (!ddata->charge_full)
-- 
2.11.0

