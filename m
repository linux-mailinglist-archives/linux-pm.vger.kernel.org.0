Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20C5F8DB1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Oct 2022 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJITVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJITVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 15:21:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01131237E6
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 12:21:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5B76A84D7A;
        Sun,  9 Oct 2022 21:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665343302;
        bh=mGDcs53pujx98pIFSzp4oEsRmQMNU5kMUulWT8jmsG4=;
        h=From:To:Cc:Subject:Date:From;
        b=M2VBSUTUcJNOQHkpTIYd6VP4mYF5bjB8UPGhyy9Dit3TSf1nwclME9HVvzv6IB+z/
         Lq0iqKdoa3+UFOEx8+vmv4AXZt1VLKxDVUOhdOGrhX9d6PDeerk0XKc+rnDgM2EN8p
         YZrdP4l3e6fJxKayDfmoAzeziVqVhC8iPCJyiUfkz3+ZGQKQXhQ3he8RxbLzGoqIlG
         Qmk0i+3Oqu2OaC4JVpt1ChcWp1nY6ruQE83EEb6dPK86sI+wVkPN114xeVZoJmMwOo
         grKT1no6ix6CWAJqhrJt4FniBeFNiSEsVF0w3wMyjm4IhiE4GO4Vzz9YYttieavcpZ
         PYQ5FTET2XMkA==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: bq25890: Add support for setting max CC current and voltage
Date:   Sun,  9 Oct 2022 21:21:36 +0200
Message-Id: <20221009192136.106859-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Let user set battery charge current and voltage limit via sysfs. This is
useful in case the user space needs to reduce charge current to keep the
system within thermal limits. The maximum charge current and voltage are
still limited to "ti,charge-current" and "ti,battery-regulation-voltage"
values to avoid damaging the hardware in case too high values are set by
user space.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c4c830247e0e0..d48c147c8be81 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -531,7 +531,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+		ret = bq25890_field_read(bq, F_ICHG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = bq25890_find_val(ret, TBL_ICHG);
 
 		/* When temperature is too low, charge current is decreased */
 		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
@@ -561,7 +565,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
+		ret = bq25890_field_read(bq, F_VREG);
+		if (ret < 0)
+			return ret;
+
+		val->intval = bq25890_find_val(ret, TBL_VREG);
 		break;
 
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
@@ -619,9 +627,18 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 					     const union power_supply_propval *val)
 {
 	struct bq25890_device *bq = power_supply_get_drvdata(psy);
+	int maxval;
 	u8 lval;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		maxval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+		lval = bq25890_find_idx(min(val->intval, maxval), TBL_ICHG);
+		return bq25890_field_write(bq, F_ICHG, lval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		maxval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
+		lval = bq25890_find_idx(min(val->intval, maxval), TBL_VREG);
+		return bq25890_field_write(bq, F_VREG, lval);
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
 		return bq25890_field_write(bq, F_IINLIM, lval);
@@ -634,6 +651,8 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
 						      enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
-- 
2.35.1

