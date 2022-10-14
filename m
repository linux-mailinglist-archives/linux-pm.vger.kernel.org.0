Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA465FF2EA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJNRYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJNRYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385BE12743
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7DF0B84C4C;
        Fri, 14 Oct 2022 19:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768281;
        bh=kc/nOTBnvKgjkwFhU37dDIuaOU5uxNTq+2XnGJCtEfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXz2KRgylzUGiwgCENAox5Mt6EGKUilHedlNCApEwYbunGQ79MipAcwS6pah4lDqb
         BdpsNIPGXqg0hTGn36ZsVuZlifycsMvaerIYSWS8T36X94ftyqx7EeBjodOLEp0aRk
         ecVB2NU5B1wikjDvojveFlKhbo4YtxC6vGEnSQFpvvZG0GubcL+FDrvt11DAMmX6RD
         IAD9ErviurmUpqhFtOn0j0MKWlaELFgDivdPKjdNBCEllqlfhK6zEmvvKiWxQeeMEe
         zWmFAf5cC/DMZEXLoCP4ZcJ/rwa2hmz/7HakP0x1CQmk28hD3oWims/t1OzL1YrFKb
         qr7Sy/nWqzXpQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 3/7] power: supply: bq25890: Clean up POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
Date:   Fri, 14 Oct 2022 19:24:23 +0200
Message-Id: <20221014172427.128512-3-marex@denx.de>
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

Clean up misuse of POWER_SUPPLY_PROP_VOLTAGE,
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
and POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
and document what exactly each value means.

The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE content is newly read
back from hardware, while POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
is reported as the maximum value set in DT.

The POWER_SUPPLY_PROP_VOLTAGE is newly used to report immediate value
of battery voltage V_BAT, which is what this property was intended to
report and which has been thus far misused to report the charger chip
output voltage V_SYS.

The V_SYS is no longer reported as there is currently no suitable
property to report V_SYS. V_SYS reporting will be reinstated in
subsequent patch.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
V2: Drop the state online check from new POWER_SUPPLY_PROP_VOLTAGE_NOW
    since the VBAT can be measured even when discharging
---
 drivers/power/supply/bq25890_charger.c | 72 ++++++++++++++++----------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 5924b036b1588..050eef2571e8e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -529,24 +529,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
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
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
-		break;
-
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
 		break;
@@ -563,15 +545,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(ret, TBL_IINLIM);
 		break;
 
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
-		if (ret < 0)
-			return ret;
-
-		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
-		val->intval = 2304000 + ret * 20000;
-		break;
-
 	case POWER_SUPPLY_PROP_CURRENT_NOW:	/* I_BAT now */
 		/*
 		 * This is ADC-sampled immediate charge current supplied
@@ -628,6 +601,51 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:	/* V_BAT now */
+		/*
+		 * This is ADC-sampled immediate charge voltage supplied
+		 * from charger to battery. The property name is confusing,
+		 * for clarification refer to:
+		 * Documentation/ABI/testing/sysfs-class-power
+		 * /sys/class/power_supply/<supply_name>/voltage_now
+		 */
+		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
+		val->intval = 2304000 + ret * 20000;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:	/* V_BAT user limit */
+		/*
+		 * This is user-configured constant charge voltage supplied
+		 * from charger to battery in second phase of charging, when
+		 * battery voltage reached constant charge voltage.
+		 *
+		 * This value reflects the current hardware setting.
+		 *
+		 * The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX is the
+		 * maximum value of this property.
+		 */
+		ret = bq25890_field_read(bq, F_VREG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = bq25890_find_val(ret, TBL_VREG);
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:	/* V_BAT max */
+		/*
+		 * This is maximum allowed constant charge voltage supplied
+		 * from charger to battery in second phase of charging, when
+		 * battery voltage reached constant charge voltage.
+		 *
+		 * This value is constant for each battery and set from DT.
+		 */
+		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
+		break;
+
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = bq25890_field_read(bq, F_TSPCT);
 		if (ret < 0)
-- 
2.35.1

