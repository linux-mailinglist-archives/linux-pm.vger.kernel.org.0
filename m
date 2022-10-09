Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9A95F8DAF
	for <lists+linux-pm@lfdr.de>; Sun,  9 Oct 2022 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJITSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJITSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 15:18:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C202338A
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 12:18:50 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2A5E184DC6;
        Sun,  9 Oct 2022 21:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665343127;
        bh=8U2FdvI/ws05MUXEp0urFmoMrE/dzZDaSYaCFHTQeK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO1mbdbfZQIL65U8Le+DXsiIf2qtae2Mr2XAzKzoeo+a7cGwfMvMgH8tNVu/4/U6m
         qbj1z5GSlcznVg6N2JtrwkCfO07RDh8xYGACj6DCH0SCkMtQjkMNopogi1ZzWwi8vC
         OgXW30ya9Cl7XVFZnKm7p9z6R0dmFW/iqPOxWFoi5v4eW/dhDCZY19Vr6vlvVfyOML
         gxJygbOWwxll9EdlxyBlM4msjI4CssQ89Dlvm5GDIARJbIF5AF5BvcoPN0s2pCT3if
         GoKfli/WyriAECQY12CvAe/rCfV7k08oZKmIMuBOa11gKz+NxEphGroeHnoshtodmW
         JbbwFJTl0Qb0w==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/2] power: supply: bq25890: Rename POWER_SUPPLY_PROP_CURRENT_NOW to CC current
Date:   Sun,  9 Oct 2022 21:18:39 +0200
Message-Id: <20221009191839.102686-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009191839.102686-1-marex@denx.de>
References: <20221009191839.102686-1-marex@denx.de>
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

The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
the immediate power supply input current, however, this driver reports the
immediate battery charge current using that property, i.e. content of REG12
ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
be used to report immediate battery charge voltage.

This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
and the later reports VBAT.

Fixes: 1e4724d0b7d1 ("power: bq25890: use proper CURRENT_NOW property for I_BAT")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 34dbd498f0f51..c4c830247e0e0 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -432,8 +432,8 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_TEMP:
 		return true;
 
@@ -589,7 +589,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = 2304000 + ret * 20000;
 		break;
 
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
 		if (ret < 0)
 			return ret;
@@ -881,6 +881,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
@@ -888,7 +889,6 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TEMP,
 };
 
-- 
2.35.1

