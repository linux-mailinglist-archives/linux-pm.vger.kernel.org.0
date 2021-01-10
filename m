Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69D2F0984
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhAJTzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:35 -0500
Received: from muru.com ([72.249.23.125]:42512 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbhAJTzf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:35 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 99F4188D7;
        Sun, 10 Jan 2021 19:54:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 11/15] power: supply: cpcap-battery: Add charge_full property
Date:   Sun, 10 Jan 2021 21:53:59 +0200
Message-Id: <20210110195403.13758-12-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arthur Demchenkov <spinal.by@gmail.com>

Add charge_full property and let user update it. This is needed for
capacity reporting in the following patches.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -133,6 +133,7 @@ struct cpcap_battery_ddata {
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
 	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
+	int charge_full;
 	int status;
 	u16 vendor;
 	unsigned int is_full:1;
@@ -486,6 +487,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
@@ -594,6 +596,11 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		else
 			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (!ddata->charge_full)
+			return -ENODATA;
+		val->intval = ddata->charge_full;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = ddata->config.info.charge_full_design;
 		break;
@@ -661,6 +668,15 @@ static int cpcap_battery_set_property(struct power_supply *psy,
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
@@ -673,6 +689,7 @@ static int cpcap_battery_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		return 1;
 	default:
 		return 0;
-- 
2.30.0
