Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC3322C20
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhBWOWr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 09:22:47 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:59661 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBWOW3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Feb 2021 09:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614090148; x=1645626148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kfVrHptT2m4Z2h538qhv6uyJzGYhE1c2XuBDP1felc=;
  b=l+iBYJclAT+JIzTUmkMKq06o/eQ5FsfeHsIg9yHyXZk4ratcEUWVkL8H
   J5llvBaPQsocCVheaxTliOTNO3WfmRHXgTGNz56lk4VCu7xhdfKKTNLQ3
   c6aFr1cLGfKq8rwn/6M83Jkyb22QVGTrQA3o8o5r7YN1xA8wKbw8FPr5L
   HdgY4K633WBmbg1GfMl2amByz5VBGsxuVlN38HVZkep10LN1M+Dhnf9YO
   KXl6j1FuhGrDv5NbJsJhxKxlCZctki0lGBUGG37wlADAjsILcS2Nz0T/N
   lLYBdqWSaVAtfLeDrtqJ3COSlt7nPirMeOdc3qKzqni9A90PQXzywy3Ad
   Q==;
IronPort-SDR: M1/PvlMBh2gMIuHLNvgvBF4ASJM0I14XYA/LWQbG7SJrt9ET9klj0RaEP6vOqjk8lHh3tq2q/l
 +CwWwI/+o6Q8stqHl9Rne2NxyvcjXI4Ehw+VrdZuhXMXEz9lzg61QOgpiQ3rrUxy36lR5WErYh
 BBuV4mVgiogma0MHG5d7hUqE3rkHceMIjQLUPu8G3YYsPORh/0KfQfkMonUE8VkmgUJ6gTBcuk
 eZnzwzFRvavGCSwxxk3rBzgL3KR9ZHn9HRQEBNsjV/6dsFcm9B5/ZQ840bTM6UQoEgOaK8dcYb
 eQc=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125542"
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
  bh=6kfVrHptT2m4Z2h538qhv6uyJzGYhE1c2XuBDP1felc=;
  b=QrhqqqWE7afLQWvwVQFWnkXjSrer63JCKrkhdAcxMf2165gIDta/6v3K
   grPCbpDGDmSKWk5ebSWlk58pRHCwRRoZbXBWMp1XsjQdMd6Zn/BSgyK8q
   fob1ZQOO/w4JmaxWNsS089eGUKFQRiP7Oj77/1utclhQMaQ2AhDWPyHHo
   2XWOXKAThlbQilOMSKXdqcSFr+HgtDey0MT7GvlLYxu1KNoeoTxGQ2Tnz
   Vw5tQgwn5V+zHDx2yJ7LBmfh6u87X2TLjLFnuh4bbaUT9cU4KEi+Yvjc2
   fDA8pkbXSwS1++bbHdYMmOzVEeemJbreRx4ewT77sSOFUMTx1BxamlOJ6
   Q==;
IronPort-SDR: Bq8RpNSgEWqrQsHFBFtqK6bAl87zBUprtSqW7+Xi5LLkfouFRtLMYtVHpeXUY+oywJaPqsK6yz
 GmMLMQy/Q99lMmlMhnNOzakII4xHbDbl4ZVsMHfLIGC7ibSdnbug3k1FKSJxtHvXyLvWy5eNdT
 1VZBMqug+m+xfzyfdJifmlb+d28zC/jMeiXa3dAl1LzRp9xi8EF9TIB+7fM2K5E7TA5hjBYL0F
 9Ghpw4GM59Pjy1fiXls7BF21e11PwtPjUC1DCKy/VbRJNK4FVQkYsVdwQPsNeF4O9noiT9+WAk
 2EQ=
X-IronPort-AV: E=Sophos;i="5.81,200,1610406000"; 
   d="scan'208";a="16125541"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Feb 2021 15:12:05 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E1718280075;
        Tue, 23 Feb 2021 15:12:04 +0100 (CET)
X-CheckPoint: {60350D2A-41-8E0BEC96-E002885D}
X-MAIL-CPID: B1860B43A38DFC429C7436A9C70A0ED0_4
X-Control-Analysis: str=0001.0A782F1B.60350D35.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/3] power: supply: bq27xxx: fix power_avg
Date:   Tue, 23 Feb 2021 15:11:21 +0100
Message-Id: <20210223141122.9574-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
References: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
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
the value is in units of 1mA and not 10mA. I have no way of knowing
whether the manuals of other supported ICs contain the same error, or if
there are models that actually use 1mA. At least, the new code shouldn't
be *less* correct than the old version for any device.

power_avg is removed from the cache structure, se we don't have to
extend it to store both a signed value and an error code. Always getting
an up-to-date value may be desirable anyways, as it avoids inconsistent
current and power readings when switching between charging and
discharging.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
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

