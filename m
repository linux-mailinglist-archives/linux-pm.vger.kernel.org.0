Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBD32E0957
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLVLIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 06:08:43 -0500
Received: from smtp2.axis.com ([195.60.68.18]:19744 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLVLIm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Dec 2020 06:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1608635321;
  x=1640171321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HzirOVZ373wV2sl40bL0BIwHXwwr5TlKszJVV58qQVs=;
  b=Yte/VE5x7hVC/BNn6JuFsQ/l4s9X7rHKIM5/NSHhUjO+qcCigly5laot
   hdcDT8VuMVxGp69IpOw0+lLO7/J7nH/YlJgUgky+EvYSpg1exMRkMeVFl
   HHKvV5KvU2JfehhJ09NGXgkDIHe4zn92cgp5O9bt3wCrpMsSW0d0JpjoR
   ZGA0RuksopQ0kZBR++JR3gN6rM3TWMqP2uVlKw/P9SyKtYeWnu9EYQC7j
   /W1/4dAz5ho1mftJJFVjF+icR0+8yrVyv9rUqFxKhyDGVKUQgdCd25FFI
   4nwhkvzweqsEeow7O328YSxACvqrQImzKCvkrZ8DpZt6YQWkoiMVsWdxu
   Q==;
From:   Hermes Zhang <chenhui.zhang@axis.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] power: supply: bq27xxx: Supporrt CHARGE_NOW for bq27z561/bq28z610/bq34z100
Date:   Tue, 22 Dec 2020 19:07:20 +0800
Message-ID: <20201222110720.20837-1-chenhui.zhang@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The CHARGE_NOW is map to REG_NAC for all the gauge chips beofre. But for
some chips (e.g. bq27z561) which doesn't have the REG_NAC, we use REG_RC
(remaining capacity) for CHARGE_NOW.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    Set correct REG_RC for all the chips if have
    
    keep INVALID_REG_ADDR for bq27521, as we could not find
    the datasheet and seems no one use it now.

 drivers/power/supply/bq27xxx_battery.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 315e0909e6a4..774aa376653e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -110,6 +110,7 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_TTES,	/* Time-to-Empty Standby */
 	BQ27XXX_REG_TTECP,	/* Time-to-Empty at Constant Power */
 	BQ27XXX_REG_NAC,	/* Nominal Available Capacity */
+	BQ27XXX_REG_RC,		/* Remaining Capacity */
 	BQ27XXX_REG_FCC,	/* Full Charge Capacity */
 	BQ27XXX_REG_CYCT,	/* Cycle Count */
 	BQ27XXX_REG_AE,		/* Available Energy */
@@ -145,6 +146,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -169,6 +171,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -193,6 +196,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1a,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -215,6 +219,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -237,6 +242,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1a,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x1e,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -257,6 +263,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -277,6 +284,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -297,6 +305,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = 0x26,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -317,6 +326,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1c,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x1e,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -337,6 +347,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -361,6 +372,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -382,6 +394,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -405,6 +418,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -425,6 +439,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = 0x08,
+		[BQ27XXX_REG_RC] = 0x0c,
 		[BQ27XXX_REG_FCC] = 0x0e,
 		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
@@ -450,6 +465,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -470,6 +486,7 @@ static u8
 		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x10,
 		[BQ27XXX_REG_FCC] = 0x12,
 		[BQ27XXX_REG_CYCT] = 0x2a,
 		[BQ27XXX_REG_AE] = 0x22,
@@ -490,6 +507,7 @@ static u8
 		[BQ27XXX_REG_TTES] = 0x1e,
 		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x04,
 		[BQ27XXX_REG_FCC] = 0x06,
 		[BQ27XXX_REG_CYCT] = 0x2c,
 		[BQ27XXX_REG_AE] = 0x24,
@@ -745,6 +763,7 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
@@ -764,6 +783,7 @@ static enum power_supply_property bq28z610_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
@@ -784,6 +804,7 @@ static enum power_supply_property bq34z100_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
@@ -1518,6 +1539,15 @@ static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
 	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
 }
 
+/*
+ * Return the battery Remaining Capacity in µAh
+ * Or < 0 if something fails.
+ */
+static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info *di)
+{
+	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC);
+}
+
 /*
  * Return the battery Full Charge Capacity in µAh
  * Or < 0 if something fails.
@@ -1965,7 +1995,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
+			ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
+		else
+			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_simple_value(di->cache.charge_full, val);
-- 
2.20.1

