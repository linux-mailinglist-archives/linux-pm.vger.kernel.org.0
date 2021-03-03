Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B132C2FC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhCDAAI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:08 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:51857 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383153AbhCCKup (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Mar 2021 05:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614768644; x=1646304644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azaHBPdSR9XsrLsOMXDwZKPKYOZDJigPiRl/x4XRuFM=;
  b=NJRquCgNTgcNXWwbc8qm4eqI9RTA3OAHwPfjkD2rPJUYXaItSkAm7SFZ
   +XKiwwqMpzZkFQERGfJnQLyK/+CvPRWCG6syVfD9Pkylu4w5DspFA9Qaq
   nIEXmsZiZE7OVUNzKmUUXy2pyYi/ER6rzZLa4/4aHH8cEhlkzfYJNDxYi
   Q9hUFnCH64m56wrRk29+WAVxHzCp0B6ZkkcCtGw6TSl31J2+5WRVZQtby
   7jxavMXK/yeOiaJWoH0z3OqUD05onJlBNKn464kWgsl0yFpJ6docv//I2
   jSvxvhEzwutv+4ysCORKIrrhUxgBNZGpwhnLB8BAZVX69ujGFbYS0Y13+
   A==;
IronPort-SDR: VO0feVYiRybg8IECmie+7Y9CWolSST1NmmL/dYIK9BwEvB4TKWmfnLUEMdZbGhLKfkIB3vp8A4
 r1/Yk6j8pvFGu7SMuVE4covXglpwiQBtNx7AqmqjsF7L4Xnb/lFuDuXfwZI0G8uw3Tj0f0A42/
 FiUO4/BpphPcCNIU1oALXi3D+1R/oyzXNlYUkNRAGBZHUsbOYH41mtC95n329SVExhinVCpO6L
 nKOqUjJk5vS25nxdesOONBKnuLL60xISzuUKMBKCxm8D3iKA1hstvvBVAsQNMA7IgGhI0/4Ifv
 oDI=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258532"
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
  bh=azaHBPdSR9XsrLsOMXDwZKPKYOZDJigPiRl/x4XRuFM=;
  b=Nfa/KDXXjUONFWIKNXMGGGLxtVjFgFfTD6FDwCXqvulLdJ0TUUreGFwp
   akhp25sCbvTByTVm7s6rTslWTYW62edNW5hlzjZOu/x04h/aLRySzhUaR
   +tK7m4NnmfUi3JSWur4kGTuxZHZVaWk8unGG5phWW+LZs5PxpJAgQSWav
   SkpsEvz01XOuKIMZUJN8TzMVNElpn+muVeHAyfYMYZqT2YssCFY+juZry
   jfo8UralPIBndkDC+Yx0hzmZUlrcOOKNVONeAEvvRieG92hMxpDA6aDBg
   eRApX9SJlfS7oq67lKLCHt6EbE0Zp2SEbhmzQbqRZnuP8ePD9CWOSmkcG
   Q==;
IronPort-SDR: VrKeYljV+ZZqi+bj2IU5XhV6CR5yM6jlsFPQQ7KOqlGVX8bGLrL4WxdrFhPheW3ByuBBsSanY2
 sGZC9n291x/JjQhEjk9dRFvlB3zZr2oSUnyIJzeUWcKsZCkKbeg3FqMuvTKXX5U+zYfx0VRW/5
 0kueHW0gYEW+ItCK4O0GnL+XgQqmFntPiO/wvoDNbHIHJt1PzdE9lUNP2NEmuMdO9BmNNyp3qk
 SFkZ68RyBVuv0XTnul1PfKTssRDAVaSKbdiHx6ZPCjAwd1zhDIkcw7AITi4AvWv38EGLIMFMmY
 Isw=
X-IronPort-AV: E=Sophos;i="5.81,219,1610406000"; 
   d="scan'208";a="16258531"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Mar 2021 10:54:40 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2C8AB280075;
        Wed,  3 Mar 2021 10:54:40 +0100 (CET)
X-CheckPoint: {603F5CDC-2-6615631E-D10D9432}
X-MAIL-CPID: 4033F11163CC2B32C94DA1ED6F29E7FF_2
X-Control-Analysis: str=0001.0A782F1F.603F5CE0.006F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/3] power: supply: bq27xxx: fix power_avg for newer ICs
Date:   Wed,  3 Mar 2021 10:54:19 +0100
Message-Id: <20210303095420.29054-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
References: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On all newer bq27xxx ICs, the AveragePower register contains a signed
value; in addition to handling the raw value as unsigned, the driver
code also didn't convert it to µW as expected.

At least for the BQ28Z610, the reference manual incorrectly states that
the value is in units of 1mW and not 10mW. I have no way of knowing
whether the manuals of other supported ICs contain the same error, or if
there are models that actually use 1mW. At least, the new code shouldn't
be *less* correct than the old version for any device.

power_avg is removed from the cache structure, se we don't have to
extend it to store both a signed value and an error code. Always getting
an up-to-date value may be desirable anyways, as it avoids inconsistent
current and power readings when switching between charging and
discharging.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: fixed units in commit message

 drivers/power/supply/bq27xxx_battery.c | 51 ++++++++++++++------------
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index cb6ebd2f905e..20e1dc8a87cf 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1661,27 +1661,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
 	return tval * 60;
 }
 
-/*
- * Read an average power register.
- * Return < 0 if something fails.
- */
-static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
-{
-	int tval;
-
-	tval = bq27xxx_read(di, BQ27XXX_REG_AP, false);
-	if (tval < 0) {
-		dev_err(di->dev, "error reading average power register  %02x: %d\n",
-			BQ27XXX_REG_AP, tval);
-		return tval;
-	}
-
-	if (di->opts & BQ27XXX_O_ZERO)
-		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
-	else
-		return tval;
-}
-
 /*
  * Returns true if a battery over temperature condition is detected
  */
@@ -1769,8 +1748,6 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 		}
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
-		if (di->regs[BQ27XXX_REG_AP] != INVALID_REG_ADDR)
-			cache.power_avg = bq27xxx_battery_read_pwr_avg(di);
 
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <= 0)
@@ -1833,6 +1810,32 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+/*
+ * Get the average power in µW
+ * Return < 0 if something fails.
+ */
+static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
+				   union power_supply_propval *val)
+{
+	int power;
+
+	power = bq27xxx_read(di, BQ27XXX_REG_AP, false);
+	if (power < 0) {
+		dev_err(di->dev,
+			"error reading average power register %02x: %d\n",
+			BQ27XXX_REG_AP, power);
+		return power;
+	}
+
+	if (di->opts & BQ27XXX_O_ZERO)
+		val->intval = (power * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
+	else
+		/* Other gauges return a signed value in units of 10mW */
+		val->intval = (int)((s16)power) * 10000;
+
+	return 0;
+}
+
 static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 				  union power_supply_propval *val)
 {
@@ -2020,7 +2023,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_simple_value(di->cache.energy, val);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
-		ret = bq27xxx_simple_value(di->cache.power_avg, val);
+		ret = bq27xxx_battery_pwr_avg(di, val);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = bq27xxx_simple_value(di->cache.health, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 111a40d0d3d5..8d5f4f40fb41 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -53,7 +53,6 @@ struct bq27xxx_reg_cache {
 	int capacity;
 	int energy;
 	int flags;
-	int power_avg;
 	int health;
 };
 
-- 
2.17.1

