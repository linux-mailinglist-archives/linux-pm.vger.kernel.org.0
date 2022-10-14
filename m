Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB85FF2E9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJNRYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJNRYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:44 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271D12772
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C2C3B84CEC;
        Fri, 14 Oct 2022 19:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768282;
        bh=PhXjV6jN5ijdU5PGjs2wM6ZBulRp6OrVemxvxjFD3gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoLY5ntFphks9Wl4EV8wGSVpiwI2JyYhUBp+r1L6O3fIEwbXXMl5uUZx14vgvKkIG
         Wly8weTmYBfGLbS8R/EkPs42bAoFfG7EEOH0A9XRIW4+PT/+Gy6zPzQZcB27By2nCz
         d/tNH6fIUjc5w/VvC30oUdYqSYvK7ID6CFMSc0VVssx9OHbbTgIlfKF/EiSAXf/OC8
         YyLYZT5S6xrdfJlz0U15m09c0tWIzniwWLd/W7ZvKAtrPgd4doPtYsGPD86g4J0pco
         s8dyEuD4r4TvJBxKrUofDqsIYKTPBw2wAuTB6W/+pNv6cyhOXzQNDZAurgkeUskzST
         bn69D14las9ww==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 4/7] power: supply: bq25890: Add support for setting user charge current and voltage limit
Date:   Fri, 14 Oct 2022 19:24:24 +0200
Message-Id: <20221014172427.128512-4-marex@denx.de>
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

Let user set battery charge current and voltage limit via sysfs. This is
useful in case the user space needs to reduce charge current to keep the
system within thermal limits. The maximum charge current and voltage are
still limited to "ti,charge-current" and "ti,battery-regulation-voltage"
values to avoid damaging the hardware in case too high values are set by
user space.

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
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 050eef2571e8e..95803157ac4af 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -667,9 +667,18 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 					     const union power_supply_propval *val)
 {
 	struct bq25890_device *bq = power_supply_get_drvdata(psy);
+	int maxval;
 	u8 lval;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		maxval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
+		lval = bq25890_find_idx(min(val->intval, maxval), TBL_ICHG);
+		return bq25890_field_write(bq, F_ICHG, lval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		maxval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
+		lval = bq25890_find_idx(min(val->intval, maxval), TBL_VREG);
+		return bq25890_field_write(bq, F_VREG, lval);
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
 		return bq25890_field_write(bq, F_IINLIM, lval);
@@ -682,6 +691,8 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
 						      enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
-- 
2.35.1

