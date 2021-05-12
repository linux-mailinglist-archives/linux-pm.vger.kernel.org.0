Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6570537BB61
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhELLAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 07:00:06 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:26941 "EHLO
        relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELLAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 07:00:06 -0400
X-IPAS-Result: =?us-ascii?q?A2B8BACts5tg/1BqzoFaHQEBAQEJARIBBQUBQIFXgw1ra?=
 =?us-ascii?q?4RHkgGQDo0GAQEBAQEBAQEBCTkBAgQBAYZFAiU4EwIEAQEBAQMCAwEBAQYBA?=
 =?us-ascii?q?QYBAQEBAQYEgQSFXYZFBiMELCYQJQIfBwICFCghE4V5qQ1/M4EBiD2BISOBE?=
 =?us-ascii?q?CqOChCBVUSBFYNghAAlgzU2gi0EgkAHPRw1gyC7ACwHgXaBIoEpC5t8Ag4ol?=
 =?us-ascii?q?FaQXi2SLKZ6gWuBfDMaJIM4UBkOjlaOGEIvOAIGCgEBAwlZAQGMNQEB?=
IronPort-HdrOrdr: A9a23:N765kqltNrvazo/zr13/f58lw7TpDfIj3DAbv31ZSRFFG/Fw9v
 rAoB1173/JYVoqMk3I+urvBEDjewK+yXcd2+B4VotKOjOGhILBFvAB0WKI+VDd8kPFmtK0gs
 xbAsxD4YrLfD1HZYKQ2njeL+od
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2021 12:58:57 +0200
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1lgmZs-000465-HE; Wed, 12 May 2021 12:58:56 +0200
Date:   Wed, 12 May 2021 12:58:56 +0200
From:   Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] power: supply: axp20x_battery: implement writeable status
 to enable/disable battery charging
Message-ID: <20210512105856.GA15727@lemon.iwr.uni-heidelberg.de>
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
 <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
 <20210510131804.GP11983@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510131804.GP11983@lemon.iwr.uni-heidelberg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow disabling and reenabling battery charging of an axp209 PMIC through a
writable status property. With the current driver code charging is always on.

This works on the axp209 of Banana {Pi M1+,Pro} and should work on all AXP chips.

Signed-off-by: Hermann.Lauer@uni-heidelberg.de
---
v2: add fallthrough and improve commit message (thanks to Maxime and ChenYu)
v3: fix fallthrough usage

Thanks to ChenYu for the idea and greetings
  Hermann

 drivers/power/supply/axp20x_battery.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

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
@@ -468,7 +469,18 @@
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
+		}
+		fallthrough;
 	default:
 		return -EINVAL;
 	}
@@ -491,7 +503,8 @@
 static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
+	return psp == POWER_SUPPLY_PROP_STATUS ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
 	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
