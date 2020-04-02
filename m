Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADDB19C530
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbgDBO65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37958 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388977AbgDBO6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5k5lvLzpX;
        Thu,  2 Apr 2020 16:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839514; bh=kjx6NBawS358bbnB/tg0fAzXbSbFFBICYGk9a+ABk0A=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=rrDhLWwwOv2K3yJ5/l7mfu+jCrprIToh4RnTswITiG4RiatJfxyRHYcWcWp8U9Ya3
         2Y+orVzVVkQORT0M8aVFsD87kjZbxFK/X2fHYe8x6WtOac+8rCt2S07sGJG1Dun6kt
         yo04h7IbG5mqcOuQbt0nT8wE/ysQaEzPhEuoAutbK3aHCiroImlCdZdnyZJoacgTK4
         CPzMYoX0kd9WijF9cbpIl5UhhvDTh7toQp7igMx1EaoYQHkhsVLfnGs1tdpO7BLKdA
         +QAcPRECOUNyXj1gd3HTIutkShoYCHoFyWi+LRwqnwgFl0agPIZY0Ux9Z47lD2ajWV
         un2BiGAbQtzsg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:34 +0200
Message-Id: <2d7728cc62804d0773254337aae8eed9905786b3.1585838679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 10/14] power: supply: bq25890: use proper CURRENT_NOW property
 for I_BAT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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
index 87c5832e23d3..250468f3ff18 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -468,15 +468,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
@@ -524,6 +515,15 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
@@ -699,7 +699,6 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
@@ -707,6 +706,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
 static char *bq25890_charger_supplied_to[] = {
-- 
2.20.1

