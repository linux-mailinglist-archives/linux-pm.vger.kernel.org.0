Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37537394D
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhEELaB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 07:30:01 -0400
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:45457 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhEELaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 May 2021 07:30:00 -0400
X-IPAS-Result: =?us-ascii?q?A2A8AACOgJJg/1BqzoFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBRgMBAQELAYMMa2uERK0MgXMBAQEBAQEBAQEJMQECBAEBhFCBfwIlN?=
 =?us-ascii?q?wYOAgQBAQEDAgMBAQEBAQYBAQEBAQYEgQSFXYZFBiMEUhAlAh8HAgIUKCETh?=
 =?us-ascii?q?XmpBX8zgQGIMoELI4EQKgGLOYJNgieBFYNgg38JHDuCejaCKwSCQAdZNb4zB?=
 =?us-ascii?q?6AxAg4nlEuQVwEtkimhJIVAgWqBfTM+gzhQGQ6OVo4YQi84AgYKAQEDCVkBA?=
 =?us-ascii?q?Yw0AQE?=
IronPort-HdrOrdr: A9a23:+CXIA62CXSC8racTdty7aQqjBfd2eYIsi2QD101hICF9Wvez0+
 izgfUW0gL1gj4NWHcm3euNIrWEXGm0z+8W3aA4Bp3neAX9omOnIMVZ7YXkyyD9ACGWzJ8/6Y
 5JSII7MtH5CDFB7frSyAOzH888hPyO9661jenTpk0dMz1CQadm8gt/F0K/Gkp5WAFJCfMCZe
 uhz+BAoCetfmlSU9SjChA+Lqn+jvDCiZ6OW299OzcJ8w+L5AnYj4LSMx/d5RsGViMK/LFKyx
 m7ryXY/aOliveh11vn+lS71f9rsf/A7vcGO8CWkMgSLVzX+0aVTaBsQaeLsjxwgMzH0idWrP
 D2rx0tP9t+5hrqFwnYznWNqmyQtAoG0HPsxUSVhnHuu6XCNU4HIvFMmJ5DdV/h41cg1esMip
 5j5X6TtJZcEHr77V3AzuXITB1jmw6VpncvgIco/gdieLYec7NYoMgj+lpUGv47bVrHwb0ged
 Meav301bJ3alWcVnbDoy1G/7WXNEgbL1OjbGBHoNCf1zhNhnB+yCIjqfA3rzMlztYQWpNE7+
 PLPuBDj7dVVPIbaqp7GaMoXda3Inale2OODEuiZXDcUI0XMXPErJD6pJ8v4vuxRZAOxJwu3L
 zcTVJjs3IocU6GM7zN4LR7tjT2BEmtVzXkzc9To7JjvKfnebbtOSqfDHcjjtWnuPdaJsHAQf
 68NNZ3DpbYXC7TMLcM+ze7d4hZKHEYXsFQkM08QUiyrsXCLZCvuffcdPrVObrxATcpUm7yGR
 I4LX/ODfQFynrudm7zgRDXVX+oUFf454hMHK/T+PVWyIVlDPwLjiElzXCCou2bIzxLtaI7OG
 FkJqn8r6+9rW6quWLB72BjPAtBHl9YiY+QCk9ilEsvCQfZYLwDs9KQdSR5x32cPCJySMvQDU
 pYvFR4+aW+KpSK3iA8A9e7MmaX5kFj4E6iftM5oOmu9M3lcpQ3AtINQ6pqDzjGEBRzhEJ3sm
 tZcRQFQUXeDzvqjq2ggPUvdbniXug5pD3uDd9fqHrZu0nZmNomQWEDWSWyFeSNhxw1ejZSjl
 pt0qMWjbaagwyzIW8njOlQCiwWVE2nRJZ9SCWMfsF9h63icgAYdxb7uRWqzzUIPlfM22pXrG
 r7NiGQcezMGTNmywNl+5ev1kh1eGWbd193cVZgv+RGZDj7k0c27MvOXI2P6S+qTmY6q9ttbQ
 3taScOIw9o2tC83AOUnjHHDnk92pAyJIXmfcYeWqCW1XW3JIKSk6YaW/dS4ZZ+Ldjr9vQGSO
 SFZmauXX/FIvJs3wyevXA+PiZo7HEijPPzwRXghVLIlkIXEL7XIF58QascLMzZ52/4R+yQ2J
 E8id4up+O/PiHwbdGBoJunIgJrO1fWoWSsSfsvpo0RtaUutKFrF52eSCDWzhh8rVwDBdaxkF
 lbTLVw4bjHNIMqd8sOezhB9l5skNiUNkMkvgH/H+dWRyBjs1bLe9eSp7bYo7smBUOM4BH9Pl
 SS6CVR9fbIVSnr789QN4sgZWBNLEQs4nVr++2PM5DKAAKxbudZ4R60NGS+fLI1ctnKJZwA6h
 Jhp9eGkO+ce3CmhETevT5nLrlP9GjiS8WoGw6IEfNJ9dv/OVnkuNrc3OejyDPsDT28YAAEgI
 cAc0oaZMFKkCMjg406yTLacN2+nms1119FpSh6nVvs0JW86GjVHUtaIRTU668mKQV7IzyNl4
 DZ6uCW23T2/Shd1ZTCHElWeMtSG9J4dPmAEw5+bc4KvLCp+KIzgiNMJBc2ZlRM/QzA4w==
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 May 2021 13:29:03 +0200
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1leFiA-0001eS-H6; Wed, 05 May 2021 13:29:02 +0200
Date:   Wed, 5 May 2021 13:29:02 +0200
From:   Hermann.Lauer@uni-heidelberg.de
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp20x_battery: implement writeable status to
 enable/disable battery charging
Message-ID: <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Maintainers,

this patch allows enabling/disabling charging for the axp209 PMIC through a
writeable status property.

This works on the axp209 of Banana {Pi M1+,Pro}. I have no access to
the other chips the driver deals with.

Thanks to ChenYu for the idea and greetings
  Hermann

Signed-off-by: Hermann.Lauer@uni-heidelberg.de
---
 drivers/power/supply/axp20x_battery.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -40,6 +40,7 @@
 #define AXP209_FG_PERCENT		GENMASK(6, 0)
 #define AXP22X_FG_VALID			BIT(7)
 
+#define AXP20X_CHRG_CTRL1_ENABLE	BIT(7)
 #define AXP20X_CHRG_CTRL1_TGT_VOLT	GENMASK(6, 5)
 #define AXP20X_CHRG_CTRL1_TGT_4_1V	(0 << 5)
 #define AXP20X_CHRG_CTRL1_TGT_4_15V	(1 << 5)
@@ -468,7 +469,17 @@
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		return axp20x_set_max_constant_charge_current(axp20x_batt,
 							      val->intval);
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (val->intval) {
+		case POWER_SUPPLY_STATUS_CHARGING:
+			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
+				AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
 
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+		case POWER_SUPPLY_STATUS_NOT_CHARGING:
+			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
+				AXP20X_CHRG_CTRL1_ENABLE, 0);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -491,7 +502,8 @@
 static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
+	return psp == POWER_SUPPLY_PROP_STATUS ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
 	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
