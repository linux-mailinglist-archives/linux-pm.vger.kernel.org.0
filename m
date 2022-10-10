Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85245FA6D0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJJVDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJJVDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 17:03:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CCBBC
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 14:03:31 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3E5EF84EE8;
        Mon, 10 Oct 2022 23:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665435809;
        bh=ggtIjJzO8HNj3uLkmP6oscqcow8coKscrv4R+3Yb9f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hj4SFbRPP/y7l2+EwH79Uek+MdCCWtdaiO292H8/wX0FL4si2IAE9tC5Ohm3Zy0iA
         glIcX65kQmqbVpojB7ebgsVTTLEVvFnigKqYYgbL+YXzbrr9ft9ALVtx9xCg0aAjha
         b2DdoMBxlwPxMFV7ALgD0NeuCF2B9Uthp37eyjvfjy9r13u4nV4rUiJIlKC3VRaB0h
         ooM5B8nlemJ4M0yIqVGKnHeElFLpSoawgvYBUJjyEdenLkCoOWWxl+nY3ifeuXwKBU
         t9946zZ8ptxzgrTH8JYb1JfV2nqB3caBhDxEzIkMX4sb/LtoGJmW3IjJn9CX9Io8iW
         u8DdNROnhJQAg==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4/7] power: supply: bq25890: Add support for setting user charge current and voltage limit
Date:   Mon, 10 Oct 2022 23:03:07 +0200
Message-Id: <20221010210310.165461-4-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010210310.165461-1-marex@denx.de>
References: <20221010210310.165461-1-marex@denx.de>
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

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7632aad8bf0a1..6cc3c23cd8853 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -671,9 +671,18 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
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
@@ -686,6 +695,8 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
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

