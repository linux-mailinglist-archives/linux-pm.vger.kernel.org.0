Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5262F098A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAJTzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:37 -0500
Received: from muru.com ([72.249.23.125]:42516 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbhAJTzg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:36 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 39B608931;
        Sun, 10 Jan 2021 19:54:31 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 13/15] power: supply: cpcap-battery: Implement capacity reporting
Date:   Sun, 10 Jan 2021 21:54:01 +0200
Message-Id: <20210110195403.13758-14-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arthur Demchenkov <spinal.by@gmail.com>

Calculate percentage using charge_full value provided.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
[tony@atomide.com: updated to apply after dropping my earlier patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -546,6 +546,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_TEMP,
@@ -556,7 +557,7 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 				      union power_supply_propval *val)
 {
 	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
-	struct cpcap_battery_state_data *latest, *previous;
+	struct cpcap_battery_state_data *latest, *previous, *empty;
 	u32 sample;
 	s32 accumulator;
 	int cached;
@@ -636,6 +637,16 @@ static int cpcap_battery_get_property(struct power_supply *psy,
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
 		if (cpcap_battery_full(ddata))
 			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-- 
2.30.0
