Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C95FF2EB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJNRYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJNRYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:44 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E712610
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:42 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3458384BEF;
        Fri, 14 Oct 2022 19:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768281;
        bh=pSHsiAWQjte0t9KWE2lb3uDk8o0JetWAI43bTz2KT2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmxUQN/exoPPT5C5nv+8XmNwQMkAaz6mamt71EJzX295LnQqZVPPX0t7eevYGR9Hn
         dWtxy9XizhPKETS1jM5LBNigCr7VR9wWDlP+UpiazCmPDlXjuYlp7N9zr6GshAQU8F
         kNiQE5Br8IEw4WZl2z73ghz1vJypRimBGxX6QDZgSSB7HrWgFpokLaMU3uYTDdXBFP
         w4QHiDy33pM1AWmpf4aUEj9adX5H45+szRno5ePwIX0b3f2yF9qGBQB8icaaZ4WzsA
         IkeR3g1fLgwDjYFvLoRLV23XVtmK1m42rpdcfYHs13h3ZgXbusZdVAv8ovrzsasOsL
         hYz03tYXwXV2g==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 2/7] power: supply: bq25890: Clean up POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
Date:   Fri, 14 Oct 2022 19:24:22 +0200
Message-Id: <20221014172427.128512-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221014172427.128512-1-marex@denx.de>
References: <20221014172427.128512-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Clean up misuse of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX and document what
exactly each value means.

The POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT content is newly read
back from hardware, while POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX
is reported as the maximum value set in DT.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
V2: Add RB from Hans
---
 drivers/power/supply/bq25890_charger.c | 57 ++++++++++++++++++--------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 1298d5720aa4b..5924b036b1588 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -529,22 +529,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
-
-		/* When temperature is too low, charge current is decreased */
-		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
-			ret = bq25890_field_read(bq, F_JEITA_ISET);
-			if (ret < 0)
-				return ret;
-
-			if (ret)
-				val->intval /= 5;
-			else
-				val->intval /= 2;
-		}
-		break;
-
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		if (!state.online) {
 			val->intval = 0;
@@ -604,6 +588,46 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = ret * -50000;
 		break;
 
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:	/* I_BAT user limit */
+		/*
+		 * This is user-configured constant charge current supplied
+		 * from charger to battery in first phase of charging, when
+		 * battery voltage is below constant charge voltage.
+		 *
+		 * This value reflects the current hardware setting.
+		 *
+		 * The POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX is the
+		 * maximum value of this property.
+		 */
+		ret = bq25890_field_read(bq, F_ICHG);
+		if (ret < 0)
+			return ret;
+		val->intval = bq25890_find_val(ret, TBL_ICHG);
+
+		/* When temperature is too low, charge current is decreased */
+		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
+			ret = bq25890_field_read(bq, F_JEITA_ISET);
+			if (ret < 0)
+				return ret;
+
+			if (ret)
+				val->intval /= 5;
+			else
+				val->intval /= 2;
+		}
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:	/* I_BAT max */
+		/*
+		 * This is maximum allowed constant charge current supplied
+		 * from charger to battery in first phase of charging, when
+		 * battery voltage is below constant charge voltage.
+		 *
+		 * This value is constant for each battery and set from DT.
+		 */
+		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+		break;
+
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = bq25890_field_read(bq, F_TSPCT);
 		if (ret < 0)
@@ -887,6 +911,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
-- 
2.35.1

