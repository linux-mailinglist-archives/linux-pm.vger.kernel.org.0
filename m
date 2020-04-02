Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818C019C529
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbgDBO6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:39 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36003 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389058AbgDBO6i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:38 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5m5G7TzHd;
        Thu,  2 Apr 2020 16:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839516; bh=NtMCc186Ug9cBLzwsJyjA0kM4Gsfruxf11Rj7KVafeI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=KfaNHBU3d1npBIHJjyQTNrCNQ3KQkTDOztK0zUrUTz6ZFiLDYk0aJiqOB6/Icguh5
         4GaL3VEq1Vw2KH0sUvy7Bpxt8SymotQsXqS4Xsmp5eK1H67X6F8MAQ5RSO1CSHk/NF
         Bo6yhIVoBJjWg9ECvjllRTkWJNzjlzz5dbX56GqUTsXKYvy9KvYZ9+7mIxbQYv3zFl
         T1/BfWyf2CLsqKfxy8ywMg6AiTqBpYJyE32E4NpRmJZpysbWv0JVm16k3yckeRmyfE
         YG4ZOFZ9SgPDrZLvTjcR0xtheqZpitJvr0RsprnkTGYBijRUaIPNlRJUUSkG0X7/aG
         1JcD4K0FKZdyw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:36 +0200
Message-Id: <695c9066c94ce73ffe9330e0342194980d581122.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 13/14] power: supply: bq25890: show VBAT as VOLTAGE_NOW
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONSTANT_CHARGE_VOLTAGE is a currently programmed CC voltage limit
and not instaneous reading of a VBAT. Move the measurement to correct
property. !online check is removed, as it is useful to read the voltage
when not charging.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 6c277f2dbae2..a61eab6a4552 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -472,20 +472,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
 		break;
 
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		if (!state.online) {
-			val->intval = 0;
-			break;
-		}
-
-		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
-		if (ret < 0)
-			return ret;
-
-		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
-		val->intval = 2304000 + ret * 20000;
-		break;
-
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
 		break;
@@ -537,6 +523,15 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.sysvmin, TBL_SYSVMIN);
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
+		val->intval = 2304000 + ret * 20000;
+		break;
+
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
 		if (ret < 0)
@@ -722,7 +717,6 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
@@ -730,6 +724,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
-- 
2.20.1

