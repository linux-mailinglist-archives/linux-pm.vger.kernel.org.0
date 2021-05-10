Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EC378F71
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhEJNnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 09:43:52 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:17256 "EHLO
        relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352615AbhEJN1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 09:27:02 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 09:27:00 EDT
X-IPAS-Result: =?us-ascii?q?A2BxBAAsMZlg/1BqzoFaHQEBAQEJARIBBQUBQIFXg3hrh?=
 =?us-ascii?q?AFGkXqQC40EAQEBAQEBAQEBCTkBAgQBAYZVAiU4EwIEAQEBAQMCAwEBAQYBA?=
 =?us-ascii?q?QYBAQEBAQYEgQSFXYZFBiMELCYQJQIfBwICFCghE4V5qTh/M4EBiDCBISOBE?=
 =?us-ascii?q?CqOCBCBVUKBFYNgg38lgzWCYQSCQAc9HDWDILp0LAeBdoEhgSkLm3UCDieUU?=
 =?us-ascii?q?pBaLZIqpm+Ba4F8MxokgzhQGQ6OVo4YQi84AgYKAQEDCVkBAYw0AQE?=
IronPort-HdrOrdr: A9a23:1ZLeNK21pC4yD8Aq1sxgiAqjBJ8kLtp133Aq2lEZdPUCSL3+qy
 nIpoV+6faUskd1ZJhEo7vrBEDuex/hHOFOkO8s1NuZMzUO2lHJEGgS1/qB/9SIIUSXygc678
 ldmsNFeb7N5DZB7PrS0U2fFJIqxsWB+qztnuHD0nsoUAcCUcxdBg5Ce3+mLnE=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 May 2021 15:18:06 +0200
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1lg5nR-0003Kr-35; Mon, 10 May 2021 15:18:05 +0200
Date:   Mon, 10 May 2021 15:18:05 +0200
From:   Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] power: supply: axp20x_battery: implement writeable status
 to enable/disable battery charging
Message-ID: <20210510131804.GP11983@lemon.iwr.uni-heidelberg.de>
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
 <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
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
+		fallthrough;
+	}
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
