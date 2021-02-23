Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7A322C21
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhBWOWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 09:22:54 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:59662 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232953AbhBWOWa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Feb 2021 09:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614090150; x=1645626150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/cvwzPiENcuiFQkDE7FLI/aiD2ywKNBYOLtQc3xtaU=;
  b=iPvL75BfaS0yhn0zCemZDc8hS3uNCODoqu+BJ8A3KCKxsE0BNCWguDWx
   l6AKzfayl9S1/BV9ABhooq23MWrkOFf406SeQt5QOt/YFrAWIvEhVWFrJ
   aVCZiLzA8024IzIGKpxE3guJ7QpsLteAQItjvpDyTSS0GVO3NPBJJiWsP
   wPbo4mHmWMaEnuNIFZxlcb2ICRYgcl2f7KN4WwsSyYAoxGn2DvMgowiMl
   uZkss3EskmeuPu3+wtq1i93yqD20YrPdogOPDnEI8IdzWSWqg5QfgZjqg
   fNPfpKhPasr+AjP6wCGw672c3cX+lDBg/E7ixq7uiGShMSnt/yiqruLfh
   A==;
IronPort-SDR: IBNakK/BJ40GtBtnkTu0Ve7u1D0tf0wkhcSmJwj1IAsZQklzr5M/G6S5ThN6aZcZF4wopdPbi2
 Ns0Q0vrWUH9Bi1b4yTdmfa2skurFeKsUq1d/PgStvj0GGRMRStzjDcRFp8gpIpHi1w9RRGO4rA
 hcFyUKtu1gIkQxx8fgTXKO9uRRlNr5VraDadQew0enR4WRAdCuKenHxRp0by7LWHjDxtIpMAvQ
 1L9jXrDBwooBy8mqvbbZgyYX+QwPp5G3cuwVzcCnp1G3otBl27fmctdpG9Ryq0MVv9m4c1G/Qa
 /FQ=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125544"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Feb 2021 15:12:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 23 Feb 2021 15:12:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 23 Feb 2021 15:12:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614089525; x=1645625525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/cvwzPiENcuiFQkDE7FLI/aiD2ywKNBYOLtQc3xtaU=;
  b=R5U6h0PHCRbvXyORRulvwy+1TZfD+kGXkkZwieEqxAcbv0CaPZT+BVqF
   hUKCwgoCaSlqGtFQ1WGqYpvMKfG1xztpq7JFZ9gJezQwkx/S+//tu5OAW
   dtyFx1eXNspbST0m2nY5wq4yOobqPVmjePtSmZGNbgkCDNB4pb+iHSPRx
   gPS4NEkhu2elWqSjFUWh8mcJlQuwee8qrYYpA6lVTvTaSi+ZyodlSupSF
   cLn8fvbe8gjUMvMF6zuPBkvr+ZULj+3kN13Xw1dpxG3sCAkpH98JocTCQ
   UiZeQ/8NrfcGxYqXnFK1ECFqfd52ZJvHX4R4c2AL8orKxTLpRYTEhyqW9
   w==;
IronPort-SDR: lZSoeLIRuS2ZCkwv55dVPKUBH4vu/bLHV04GVjIIHSwAobNGziiO6iCrND585O7WKgFwx4IW3E
 90nK8mW2uHZbUpAPczNOSNT7e/W454DxklmN3qbUaUNY5gD0SsUZ/QRn/5v2ckF1QtpxFy0ez7
 kVgo781BEuz1ALd2pG1PzhDQgms19DrbOaRxhKNB9nnFvjct1qD+E/FBgHmnV/1wStsFEtsgQS
 QU1qAoLfpZkSiPsXuwdpJRnKV4r34tOkhrzXr52CeQoD/NtB1dLc7wzCu2Ybczwc900UQJMRME
 Aoc=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125543"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Feb 2021 15:12:05 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3EA7D280070;
        Tue, 23 Feb 2021 15:12:05 +0100 (CET)
X-CheckPoint: {60350D2A-41-8E0BEC96-E002885D}
X-MAIL-CPID: 7BD07AB90541B7A6543295B3A68235B4_4
X-Control-Analysis: str=0001.0A782F1B.60350D35.00B3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/3] power: supply: bq27xxx: make status more robust
Date:   Tue, 23 Feb 2021 15:11:22 +0100
Message-Id: <20210223141122.9574-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
References: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are multiple issues in bq27xxx_battery_status():

- On BQ28Q610 is was observed that the "full" flag may be set even while
  the battery is charging or discharging. With the current logic to make
  "full" override everything else, it look a very long time (>20min) for
  the status to change from "full" to "discharging" after unplugging the
  supply on a device with low power consumption
- The POWER_SUPPLY_STATUS_NOT_CHARGING check depends on
  power_supply_am_i_supplied(), which will not work when the supply
  doesn't exist as a separate device known to Linux

We can solve both issues by deriving the status from the current instead
of the flags field. The flags are now only used to distinguish "full"
from "not charging", and to determine the sign of the current on
BQ27XXX_O_ZERO devices.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/power/supply/bq27xxx_battery.c | 88 +++++++++++++-------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 20e1dc8a87cf..b62a8cfd9d09 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1777,14 +1777,27 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
+static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
+{
+	if (di->opts & BQ27XXX_O_ZERO)
+		return (flags & BQ27000_FLAG_FC);
+	else if (di->opts & BQ27Z561_O_BITS)
+		return (flags & BQ27Z561_FLAG_FC);
+	else
+		return (flags & BQ27XXX_FLAG_FC);
+}
+
 /*
- * Return the battery average current in µA
+ * Return the battery average current in µA and the status
  * Note that current can be negative signed as well
  * Or 0 if something fails.
  */
-static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
-				   union power_supply_propval *val)
+static int bq27xxx_battery_current_and_status(
+	struct bq27xxx_device_info *di,
+	union power_supply_propval *val_curr,
+	union power_supply_propval *val_status)
 {
+	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
 	int flags;
 
@@ -1794,17 +1807,39 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 		return curr;
 	}
 
+	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+	if (flags < 0) {
+		dev_err(di->dev, "error reading flags\n");
+		return flags;
+	}
+
 	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
 		if (!(flags & BQ27000_FLAG_CHGS)) {
 			dev_dbg(di->dev, "negative current!\n");
 			curr = -curr;
 		}
 
-		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
+		curr = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
 	} else {
 		/* Other gauges return signed value */
-		val->intval = (int)((s16)curr) * 1000;
+		curr = (int)((s16)curr) * 1000;
+	}
+
+	if (val_curr)
+		val_curr->intval = curr;
+
+	if (val_status) {
+		if (curr > 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_CHARGING;
+		} else if (curr < 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else {
+			if (bq27xxx_battery_is_full(di, flags))
+				val_status->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val_status->intval =
+					POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
 	}
 
 	return 0;
@@ -1836,43 +1871,6 @@ static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
-				  union power_supply_propval *val)
-{
-	int status;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		if (di->cache.flags & BQ27000_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_CHGS)
-			status = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-	} else if (di->opts & BQ27Z561_O_BITS) {
-		if (di->cache.flags & BQ27Z561_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	} else {
-		if (di->cache.flags & BQ27XXX_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	}
-
-	if ((status == POWER_SUPPLY_STATUS_DISCHARGING) &&
-	    (power_supply_am_i_supplied(di->bat) > 0))
-		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	val->intval = status;
-
-	return 0;
-}
-
 static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 					  union power_supply_propval *val)
 {
@@ -1960,7 +1958,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_status(di, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -1969,7 +1967,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current(di, val);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
-- 
2.17.1

