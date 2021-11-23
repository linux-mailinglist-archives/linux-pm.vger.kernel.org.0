Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C930345B017
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 00:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhKWXa0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 18:30:26 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:48181 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240231AbhKWXaY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 18:30:24 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637710029;
        bh=qU9W2kmHIbsmZrsfsVtyjLYvoHKferUQSNYZI6CIAs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQQfHok7cpILqH8Ek2abRVvBX9IuxjCTbszBlViHa9ibngmrD1hm0cnIkG+PgaLbx
         BktxrK0jsBJc3CCzpye3UQUJ7sjNMqK2bhVp9+8gwezeY/4RxIxIXpUOktorljvK/g
         mKZb1hL4LEViC75sEj2o8nq9co9tDXdfnm8a32W0=
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
Subject: [PATCH v2 4/4] platform/x86: thinkpad_acpi: support inhibit-charge
Date:   Wed, 24 Nov 2021 00:27:04 +0100
Message-Id: <20211123232704.25394-5-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
References: <20211123232704.25394-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637710019; l=5442; s=20211113; h=from:subject; bh=qU9W2kmHIbsmZrsfsVtyjLYvoHKferUQSNYZI6CIAs4=; b=ksoSvuT62RgYUS1iFKYKmvHRymOwZNCvPjLR9hfbyGS2g0nIP1vRZzThFutfXDQyTMXSTP125f6P /Z9LcK5TB9W77YtfUFazqgccF6hkT5AoaP4if7su7J+B47lSAf4j
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for the inhibit-charge charge_behaviour through the
embedded controller of ThinkPads.

Co-developed-by: Thomas Koch <linrunner@gmx.net>
Signed-off-by: Thomas Koch <linrunner@gmx.net>
Co-developed-by: Nicolò Piazzalunga <nicolopiazzalunga@gmail.com>
Signed-off-by: Nicolò Piazzalunga <nicolopiazzalunga@gmail.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/
---
 drivers/platform/x86/thinkpad_acpi.c | 64 +++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e3567cc686fa..7f2f46c71482 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
 #define SET_STOP	"BCSS"
 #define GET_DISCHARGE	"BDSG"
 #define SET_DISCHARGE	"BDSS"
+#define GET_INHIBIT	"BICG"
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
@@ -9409,6 +9412,12 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
 		/* The force discharge status is in bit 0 */
 		*ret = *ret & 0x01;
 		return 0;
+	case INHIBIT_CHARGE:
+		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
+			return -ENODEV;
+		/* The inhibit charge status is in bit 0 */
+		*ret = *ret & 0x01;
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9447,6 +9456,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
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
@@ -9494,6 +9519,8 @@ static int tpacpi_battery_probe(int battery)
 	 * 4) Check for support
 	 * 5) Get the current force discharge status
 	 * 6) Check for support
+	 * 7) Get the current inhibit charge status
+	 * 8) Check for support
 	 */
 	if (acpi_has_method(hkey_handle, GET_START)) {
 		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
@@ -9540,6 +9567,16 @@ static int tpacpi_battery_probe(int battery)
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
@@ -9698,10 +9735,22 @@ static ssize_t charge_behaviour_show(struct device *dev,
 	if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE)) {
 		if (tpacpi_battery_get(FORCE_DISCHARGE, battery, &ret))
 			return -ENODEV;
-		if (ret)
+		if (ret) {
 			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+			goto out;
+		}
+	}
+
+	if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
+		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
+			return -ENODEV;
+		if (ret) {
+			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+			goto out;
+		}
 	}
 
+out:
 	return power_supply_charge_behaviour_show(dev, available, active, buf);
 }
 
@@ -9738,11 +9787,22 @@ static ssize_t charge_behaviour_store(struct device *dev,
 	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
 		if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
 			ret = tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 0);
+		if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
+			ret = min(ret, tpacpi_battery_set_validate(INHIBIT_CHARGE, battery, 0));
 		if (ret < 0)
 			return ret;
 		break;
 	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
-		ret = tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 1);
+		if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
+			ret = tpacpi_battery_set_validate(INHIBIT_CHARGE, battery, 0);
+		ret = min(ret, tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 1));
+		if (ret < 0)
+			return ret;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
+			ret = tpacpi_battery_set_validate(FORCE_DISCHARGE, battery, 0);
+		ret = min(ret, tpacpi_battery_set_validate(INHIBIT_CHARGE, battery, 1));
 		if (ret < 0)
 			return ret;
 		break;
-- 
2.34.0

