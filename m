Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34E43667AC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhDUJL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 05:11:59 -0400
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:1936 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhDUJL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 05:11:59 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 05:11:58 EDT
X-IPAS-Result: =?us-ascii?q?A2BiAABF6n9g/1BqzoFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFSgw1ra4N9RpF2lTmFSoFzAQEBAQEBAQEBCTEBAgQBAYRQg?=
 =?us-ascii?q?XcCJTgTAgMBAQEDAgMBAQEBAQYBAQEBAQYEgQSFXYZuBFI1AiYCFigiEoV5q?=
 =?us-ascii?q?Fh/M4EBiE6BCyOBECoBiV+BT4JNgieBE4Ngg38JHDuCei4IgisEgkAHWTa+C?=
 =?us-ascii?q?gegEAINJZQzkFEBLZIcgleeLYU9NYE2gXwzPoM4UBkOjlaOGEIvOAIGCgEBA?=
 =?us-ascii?q?wlZAQGMNAEB?=
IronPort-HdrOrdr: A9a23:GfVDTaqnIoTMbCle/zNhRZAaV5t1L9V00zAX/kB9WHVpW+afkN
 2jm+le6A/shF8qKQgdsP2jGI3Fe3PT8pZp/ZIcVI3JYCDKsHalRbsSiLfK7CbnH0TFh4xg/I
 dmN5NzEdjhSWV95PyKgzWQN/YF7J25/LuzheHYpk0NcShPZ7t75wl0Tia3e3cGIDVuPpYyGJ
 qC6scvnVPJEkg/Vci1CmIIWOLOvbTw9K7OWwIMBBIs9WC1/FSVwYP9eiLouCs2YndgxfMH/X
 LemwL0op+/u+y2oyWx60bjq7pRntXlxp9vJuypzvIUJDLllxqyaO1aNoGqjXQapueg7Vpvqt
 3QulMbOdhp4X+5RA6IiCqo4AXr3DYw53KK8zGlvUc=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2021 11:03:55 +0200
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1lZ8m2-0005Hc-I3; Wed, 21 Apr 2021 11:03:54 +0200
Date:   Wed, 21 Apr 2021 11:03:54 +0200
From:   Hermann.Lauer@uni-heidelberg.de
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] axp209 PMIC: setting constant_charge_current to 0
 disables battery charging
Message-ID: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Maintainers,

this proposed patch allows setting constant_charge_current to 0 on axp209
PMIC to disable charging. constant_charge_current_max with a value of 0 makes
no sense and should still report the maximum allowed value, so the getter code
is unrolled for the POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT case.

This works on the axp209 of Banana{Pi M1,Pi M1+,Pro}. I have no access to
the other chips the driver deals with.

Thanks for comments and greetings
  Hermann

Signed-off-by: Hermann.Lauer@uni-heidelberg.de
---
 patches/axp209-charge-current0.patchl | 18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

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
@@ -249,11 +250,18 @@
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = axp20x_get_constant_charge_current(axp20x_batt,
-							 &val->intval);
+		ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &val->intval);
 		if (ret)
 			return ret;
-		break;
+
+		if (val->intval & AXP20X_CHRG_CTRL1_ENABLE) {
+			val->intval &= AXP20X_CHRG_CTRL1_TGT_CURR;
+			val->intval = val->intval * axp20x_batt->data->ccc_scale +
+					axp20x_batt->data->ccc_offset;
+		} else
+			val->intval = 0;
+
+		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = axp20x_batt->max_ccc;
@@ -392,6 +400,10 @@
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
+	if (charge_current == 0)
+		return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
+				  AXP20X_CHRG_CTRL1_ENABLE, 0);
+
 	if (charge_current > axp_batt->max_ccc)
 		return -EINVAL;
 
@@ -402,7 +414,8 @@
 		return -EINVAL;
 
 	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
-				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
+				  AXP20X_CHRG_CTRL1_TGT_CURR | AXP20X_CHRG_CTRL1_ENABLE,
+				  charge_current | AXP20X_CHRG_CTRL1_ENABLE);
 }
 
 static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
