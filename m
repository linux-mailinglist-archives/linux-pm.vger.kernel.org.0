Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378BCA40FE
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfH3XXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 19:23:22 -0400
Received: from muru.com ([72.249.23.125]:59318 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfH3XXW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Aug 2019 19:23:22 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 40C1D80D4;
        Fri, 30 Aug 2019 23:23:50 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] power: supply: cpcap-charger: Enable vbus boost voltage
Date:   Fri, 30 Aug 2019 16:23:16 -0700
Message-Id: <20190830232316.53750-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are currently not enabling VBUS boost for cpcap when in host mode.
This means the VBUS is fed at the battery voltage level, which can cause
flakeyness enumerating devices.

Looks like the boost control for VBUS is CPCAP_BIT_VBUS_SWITCH that we
must enable in the charger for nice 4.92 V VBUS output. And looks like
we must not use the STBY pin enabling but must instead use manual VBUS
control in phy-cpcap-usb.

We want to do this in cpcap_charger_vbus_work() and also set a flag for
feeding_vbus to avoid races between USB detection and charger detection,
and disable charging if feeding_vbus is set.

Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c |  8 +++++---
 drivers/power/supply/cpcap-charger.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -231,8 +231,9 @@ static void cpcap_usb_detect(struct work_struct *work)
 			goto out_err;
 
 		error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
-					   CPCAP_BIT_VBUSSTBY_EN,
-					   CPCAP_BIT_VBUSSTBY_EN);
+					   CPCAP_BIT_VBUSSTBY_EN |
+					   CPCAP_BIT_VBUSEN_SPI,
+					   CPCAP_BIT_VBUSEN_SPI);
 		if (error)
 			goto out_err;
 
@@ -240,7 +241,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 	}
 
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
-				   CPCAP_BIT_VBUSSTBY_EN, 0);
+				   CPCAP_BIT_VBUSSTBY_EN |
+				   CPCAP_BIT_VBUSEN_SPI, 0);
 	if (error)
 		goto out_err;
 
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -108,6 +108,9 @@
 #define CPCAP_REG_CRM_ICHRG_1A596	CPCAP_REG_CRM_ICHRG(0xe)
 #define CPCAP_REG_CRM_ICHRG_NO_LIMIT	CPCAP_REG_CRM_ICHRG(0xf)
 
+/* CPCAP_REG_VUSBC register bits needed for VBUS */
+#define CPCAP_BIT_VBUS_SWITCH		BIT(0)	/* VBUS boost to 5V */
+
 enum {
 	CPCAP_CHARGER_IIO_BATTDET,
 	CPCAP_CHARGER_IIO_VOLTAGE,
@@ -130,7 +133,8 @@ struct cpcap_charger_ddata {
 	struct power_supply *usb;
 
 	struct phy_companion comparator;	/* For USB VBUS */
-	bool vbus_enabled;
+	unsigned int vbus_enabled:1;
+	unsigned int feeding_vbus:1;
 	atomic_t active;
 
 	int status;
@@ -325,7 +329,6 @@ static bool cpcap_charger_vbus_valid(struct cpcap_charger_ddata *ddata)
 }
 
 /* VBUS control functions for the USB PHY companion */
-
 static void cpcap_charger_vbus_work(struct work_struct *work)
 {
 	struct cpcap_charger_ddata *ddata;
@@ -343,6 +346,7 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 			return;
 		}
 
+		ddata->feeding_vbus = true;
 		cpcap_charger_set_cable_path(ddata, false);
 		cpcap_charger_set_inductive_path(ddata, false);
 
@@ -350,12 +354,23 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 		if (error)
 			goto out_err;
 
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_VUSBC,
+					   CPCAP_BIT_VBUS_SWITCH,
+					   CPCAP_BIT_VBUS_SWITCH);
+		if (error)
+			goto out_err;
+
 		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
 					   CPCAP_REG_CRM_RVRSMODE,
 					   CPCAP_REG_CRM_RVRSMODE);
 		if (error)
 			goto out_err;
 	} else {
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_VUSBC,
+					   CPCAP_BIT_VBUS_SWITCH, 0);
+		if (error)
+			goto out_err;
+
 		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
 					   CPCAP_REG_CRM_RVRSMODE, 0);
 		if (error)
@@ -363,6 +378,7 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 
 		cpcap_charger_set_cable_path(ddata, true);
 		cpcap_charger_set_inductive_path(ddata, true);
+		ddata->feeding_vbus = false;
 	}
 
 	return;
@@ -431,7 +447,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (error)
 		return;
 
-	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
+	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
+	    s.chrgcurr1) {
 		int max_current;
 
 		if (cpcap_charger_battery_found(ddata))
-- 
2.23.0
