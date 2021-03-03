Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97332C309
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbhCDAAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:07 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:57782 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351218AbhCCKrU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614768438; x=1646304438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/eBxFNvHkWfvpD/x1JUCWE9AtSrYkLy7jW7mmfiJ+Q=;
  b=BezmD5wx/Sp7RF8F+/GWdLEquPN6AsnaXyWqdvR8AlWdBC+DKZOi0Ell
   35WepEJT2HN0Xuuk4H+9XKpE9D6MI8lz47a/fFQ941coWQBljkU/7UpLk
   zeG/H0TYLrrT02IQhAyBJVMXzUQKf2IZJoC0m/BZwaxa/SXhhquTkI4IA
   gxy/hbI/+FkHFm9t1+K51zDf59z2ursV0iO5g21Ay/h25+2AsDUB0YdSQ
   VQ6d7A4itDUjyof+Tmaugppb2AHKBAsNeC/sYxKDDSxn7HyCroGzV0ANA
   6lLSU/a8eBev1iyDyr6CJ3q0w9GGbQJGV4Icisa0Y1LRIEfSzOHqObpPr
   A==;
IronPort-SDR: HJUV1r9+560nIN+napc/LNEX4rqGHnr7R3eseFh8knHX/E2L5Uc+mne05SaXn34mP4QEuFaxb3
 REHstigocbt3ePkH8AFgX0ij1MABQ6gWYUQJ/006igtRObccuV4/uROtT0SUIkuE8nb3DsQxQR
 chG9cs1TrqOXCAL/9Iz50zTaZ+a1UCOE0IcH/Nc/UBg7BzwuQbWFGMlTt+OM15iwFi69jtnr3w
 SrVXSwTKgNDmbZzSRjbhB131yt0wp3LRnLJbGhuXclTSpEB0qRQbuRZiDn+JiVMt3muKr/0Kyi
 OKU=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258535"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Mar 2021 10:54:40 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Mar 2021 10:54:40 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Mar 2021 10:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614765280; x=1646301280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/eBxFNvHkWfvpD/x1JUCWE9AtSrYkLy7jW7mmfiJ+Q=;
  b=XbT1OYa5/Kju5b14y69fCDuulFR/uGZTbMxbVst4wSFn3eVaolUmnL80
   zCd1kd3tJSnPfhTnI0TwCNT3LLSCsR9tLH8ULm5WWsDUl24wcCUf5FiSm
   lEvI4Q6F6JSWc5vVpZ+rB8jHkgzwHf+VTAPDKAUZS4zRs2NKSqZeFJ9+V
   ETwOFnKxwMv1jy+SFX5cKi4HwgaDYzNPTLjJ8ulX/5dP3IXCIIq1e8spT
   xzLNygPNNyYM7DUnE1nNPWrwYnNlfZY6FC5F7eUNDKlKXE26CAkjOdnyb
   hzE82hqF8hefxv97IZWOkeeG4O6ttYalU7U8cgfxqQ4xtuMnD4EJmW1Yq
   w==;
IronPort-SDR: 7Thl3oQlb4EyH44AZq+pVX3hdsQIVB9QhQbf6mhgqEWltKWq1FTLIjjkaig3HfoXd5kFrRZTHL
 X/p3jGvd3oeA51RkZ+0g8uQlpzlbQW1iqs0F1n59l71vzf7qQN/n6redZKVElptrUvTftefu6p
 QLVV1/KfCAOMBkHiy/WHWlowWzEQzZ+Qv9vIc/GR982o6j0LoyofPycTTtUiZ+TNSge35GcBSm
 hK/Ie+uPTAcLM0E9QQWttGuyhhnYeeUkzpwVn32GYGHlb+SBPQ/MeTNNeinltkExrPM6rKVHMS
 G2U=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258534"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Mar 2021 10:54:40 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 78377280070;
        Wed,  3 Mar 2021 10:54:40 +0100 (CET)
X-CheckPoint: {603F5CDC-2-6615631E-D10D9432}
X-MAIL-CPID: 4A5C15D4C25CD22AB3AB32338ED60BA4_2
X-Control-Analysis: str=0001.0A782F1F.603F5CE0.00CA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/3] power: supply: bq27xxx: make status more robust
Date:   Wed,  3 Mar 2021 10:54:20 +0100
Message-Id: <20210303095420.29054-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
References: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
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

v2: no changes

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

