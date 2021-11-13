Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78B44F285
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhKMKpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 05:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhKMKpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 05:45:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF7C061766;
        Sat, 13 Nov 2021 02:42:38 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636800156;
        bh=lvDFqz8JQafjLCe0upSmVTphFfWrJ150vakiSDVAzYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwPKh/IdeXu+QB2HHcfkpAfzWuPP+y1Ib58MrL8VbVeNvup4p64u26JA/B4JNs+Kf
         TXe4Y7Hy5hAFxRaBtX/JN4M9G5HOEmGc0LmdNMFDbwWy73sFfRPhoQfo0KGLmC3fIt
         PV10+saopaxxtLr8Ok356oXV/tVE+f2kvENgYi4E=
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: [PATCH 4/4] platform/x86: thinkpad_acpi: support inhibit-charge
Date:   Sat, 13 Nov 2021 11:42:25 +0100
Message-Id: <20211113104225.141333-5-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113104225.141333-1-linux@weissschuh.net>
References: <20211113104225.141333-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for the inhibit-charge charge_behaviour through the
embedded controller of ThinkPads.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/
---
 drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e8c98e9aff71..7cd6475240b2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
 #define SET_STOP	"BCSS"
 #define GET_DISCHARGE	"BDSG"
 #define SET_DISCHARGE	"BDSS"
+#define GET_INHIBIT	"PSSG"
+#define SET_INHIBIT	"BICS"
 
 enum {
 	BAT_ANY = 0,
@@ -9338,6 +9340,7 @@ enum {
 	THRESHOLD_START,
 	THRESHOLD_STOP,
 	FORCE_DISCHARGE,
+	INHIBIT_CHARGE,
 };
 
 struct tpacpi_battery_data {
@@ -9409,6 +9412,13 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
 		/* The force discharge status is in bit 0 */
 		*ret = *ret & 0x01;
 		return 0;
+	case INHIBIT_CHARGE:
+		/* This is actually reading peak shift state, like tpacpi-bat does */
+		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
+			return -ENODEV;
+		/* The inhibit charge status is in bit 0 */
+		*ret = *ret & 0x01;
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9447,6 +9457,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
 			return -ENODEV;
 		}
 		return 0;
+	case INHIBIT_CHARGE:
+		/* When setting inhibit charge, we set a default value of
+		 * always breaking on AC detach and the effective time is set to
+		 * be permanent.
+		 * The battery ID is in bits 4-5, 2 bits,
+		 * the effective time is in bits 8-23, 2 bytes.
+		 * A time of FFFF indicates forever.
+		 */
+		param = value;
+		param |= battery << 4;
+		param |= 0xFFFF << 8;
+		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param))) {
+			pr_err("failed to set inhibit charge on %d", battery);
+			return -ENODEV;
+		}
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9467,6 +9493,8 @@ static int tpacpi_battery_probe(int battery)
 	 * 4) Check for support
 	 * 5) Get the current force discharge status
 	 * 6) Check for support
+	 * 7) Get the current inhibit charge status
+	 * 8) Check for support
 	 */
 	if (acpi_has_method(hkey_handle, GET_START)) {
 		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
@@ -9513,6 +9541,16 @@ static int tpacpi_battery_probe(int battery)
 			battery_info.batteries[battery].charge_behaviours |=
 				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
 	}
+	if (acpi_has_method(hkey_handle, GET_INHIBIT)) {
+		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, battery))) {
+			pr_err("Error probing battery inhibit charge; %d\n", battery);
+			return -ENODEV;
+		}
+		/* Support is marked in bit 5 */
+		if (ret & BIT(5))
+			battery_info.batteries[battery].charge_behaviours |=
+				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
+	}
 
 	battery_info.batteries[battery].charge_behaviours |=
 		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
@@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
 			return -ENODEV;
 		if (ret)
 			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
+		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
+			return -ENODEV;
+		if (ret)
+			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
 	}
 
 	return power_supply_charge_behaviour_show(dev, available, active, buf);
@@ -9710,12 +9753,20 @@ static ssize_t charge_behaviour_store(struct device *dev,
 	switch (selected) {
 	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
 		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
-		if (ret < 0)
+		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
+		if (ret)
 			return ret;
 		break;
 	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
 		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
-		if (ret < 0)
+		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
+		if (ret)
+			return ret;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
+		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 1) || ret;
+		if (ret)
 			return ret;
 		break;
 	default:
-- 
2.33.1

