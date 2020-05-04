Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC61D1C4745
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgEDTrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:47:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:25825 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgEDTrr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:47 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0d0Qz7zGl;
        Mon,  4 May 2020 21:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621665; bh=oH1XIZw4GH2xVUffAb5wzH0/1tJUqjxVsHll5z4vw70=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=pR6G9WK+ablDEAZOMn54aXtJR51oob8GUFXeTcj94gZm3cXJizlzLRKAlXaTXWlTn
         GvQdoXVCODu8A7FAyfGS4L89nTFEoXceREFqjobrMd6psTppSUoCEnXy0Qx+4a4vEC
         mubVZa7NBS/RkR8AzAsGkP/n3epluiNgvg+8mcomV6FQoVpTFSIsbY0FtY2xag2lA9
         4n5v3/9OHu2fcZJcA/4HZq+JzKHAOMScDHPMVJnJUV3Pt82c4lUtWIBphxOubQI0oO
         NqpPB/Ewcdn/BH6soJouOx9VxAjUD541+7JlTroP4VUiqAa2QTD/wDhyBbQcuhIZeL
         BZ72hAqE4nkGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:30 +0200
Message-Id: <95202939328fff79f4bc002be54876cfb38e4f7d.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 1/8] power: bq25890: use proper CURRENT_NOW property for
 I_BAT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Charge Current is more apropriately reflected by CURRENT_NOW property
(measured current) than CONSTANT_CURRENT_VOLTAGE (configured CC-phase
current limit). Fix the reference and make the sign reflect direction
of the current.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 9339e216651f..70ecc38fe772 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -427,15 +427,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
-		if (ret < 0)
-			return ret;
-
-		/* converted_val = ADC_val * 50mA (table 10.3.19) */
-		val->intval = ret * 50000;
-		break;
-
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
 		break;
@@ -471,6 +462,15 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = 2304000 + ret * 20000;
 		break;
 
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = ADC_val * 50mA (table 10.3.19) */
+		val->intval = ret * -50000;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -645,12 +645,12 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static char *bq25890_charger_supplied_to[] = {
-- 
2.20.1

