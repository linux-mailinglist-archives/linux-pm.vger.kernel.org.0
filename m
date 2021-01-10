Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243B52F0972
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhAJTyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:54:52 -0500
Received: from muru.com ([72.249.23.125]:42358 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbhAJTyw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:54:52 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8937C810A;
        Sun, 10 Jan 2021 19:54:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 02/15] power: supply: cpcap-battery: Fix missing power_supply_put()
Date:   Sun, 10 Jan 2021 21:53:50 +0200
Message-Id: <20210110195403.13758-3-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix missing power_supply_put().

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Fixes: b0134cc14b9 ("power: supply: cpcap-battery: Fix handling of lowered charger voltage")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -568,17 +568,21 @@ static int cpcap_battery_update_charger(struct cpcap_battery_ddata *ddata,
 				POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 				&prop);
 	if (error)
-		return error;
+		goto out_put;
 
 	/* Allow charger const voltage lower than battery const voltage */
 	if (const_charge_voltage > prop.intval)
-		return 0;
+		goto out_put;
 
 	val.intval = const_charge_voltage;
 
-	return power_supply_set_property(charger,
+	error = power_supply_set_property(charger,
 			POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 			&val);
+out_put:
+	power_supply_put(charger);
+
+	return error;
 }
 
 static int cpcap_battery_set_property(struct power_supply *psy,
-- 
2.30.0
