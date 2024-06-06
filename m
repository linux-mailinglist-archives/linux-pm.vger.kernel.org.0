Return-Path: <linux-pm+bounces-8725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669648FF029
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1204528CAA2
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7481A2FCC;
	Thu,  6 Jun 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iD+avxTO"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18F1A2C1F;
	Thu,  6 Jun 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685471; cv=none; b=kdU8BrH3r1EUkDQphls5vtVSXAZQYL5bkTR8NOmFqrlSpveu+t2kaClolFYvYqHf4a++rfdAZ3nsH2ZhaARNr1nDDUVPQaMKrTQ4qjd3TlpAowi2xns0KXoWyF/olVGAK81zkTdQEfuvNeaG6WAbO3X2yMqAehWTIcO97dil2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685471; c=relaxed/simple;
	bh=6oCvgSdJEOjPdJvKlQS+Pcf8TROEDYKoq83uSRvQjYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HzeWgKMhQHUJMQCFbMgylyIhlR/NRla0GVWSrmbmYTmEVnOm10EGErzMK9V+Y1TChlyfxKg+m5p6itHGABsAUROFh9gJh+NkqZa5+pcUMgwXdSp1xy+KqbYv9J1PSvX/oCe34GlDdzL/idf/BZAZ32QiVxeN7hDjAT0xHPk8rn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iD+avxTO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685464;
	bh=6oCvgSdJEOjPdJvKlQS+Pcf8TROEDYKoq83uSRvQjYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iD+avxTOyvezkn2NIuNNRGxpNT198SQ/GsXArrCi27GBH1qS4bbSiyRPv1RIKGBcl
	 ZHz3aPWz7bXoiV5Ldrc23eV7wdHf6dh8KBxMvS/1LtVyXJeIOggQu2eupd0flzKE1y
	 NlAUwS4Fan7ia5pJkHOjfVAKIiJOku3EQeugW9wc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Jun 2024 16:50:59 +0200
Subject: [PATCH RFC 5/6] power: supply: test-power: implement a power
 supply extension
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-power-supply-extensions-v1-5-b45669290bdc@weissschuh.net>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
In-Reply-To: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=5121;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6oCvgSdJEOjPdJvKlQS+Pcf8TROEDYKoq83uSRvQjYo=;
 b=w1wwY2GFbUQl4dPhZwP0dWiSUEDLObJS+QTaxt9RxLjSEERaVg1beruJFZWQUxRAZgF7Hmxnx
 8MRbOY/b226B94qUAwQdlajMP6wi3HZoOE8bQziuIY/AJmK+MZ804JW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Allow easy testing of the new power supply extension functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 442ceb7795e1..5730cbff6159 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -37,6 +37,7 @@ static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
 static enum power_supply_charge_behaviour battery_charge_behaviour =
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+static bool battery_hook;
 
 static bool module_initialized;
 
@@ -238,6 +239,80 @@ static const struct power_supply_config test_power_configs[] = {
 	},
 };
 
+static int power_supply_ext_manufacture_year = 1234;
+static enum power_supply_property power_supply_ext_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_COUNTER, /* overridden from base supply */
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+};
+
+static int power_supply_ext_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = power_supply_ext_manufacture_year;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		val->intval = 1234;
+		break;
+	default:
+		pr_info("%s: some properties deliberately report errors.\n",
+			__func__);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int power_supply_ext_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		power_supply_ext_manufacture_year = val->intval;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int power_supply_ext_property_is_writeable(struct power_supply *psy,
+						  enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_MANUFACTURE_YEAR;
+}
+
+static const struct power_supply_ext power_supply_ext = {
+	.properties = power_supply_ext_props,
+	.num_properties = ARRAY_SIZE(power_supply_ext_props),
+	.get_property = power_supply_ext_get_property,
+	.set_property = power_supply_ext_set_property,
+	.property_is_writeable = power_supply_ext_property_is_writeable,
+};
+
+static void test_battery_configure_battery_hook(bool enable)
+{
+	struct power_supply *psy;
+
+	if (battery_hook == enable)
+		return;
+
+	psy = test_power_supplies[TEST_BATTERY];
+
+	if (enable) {
+		if (power_supply_register_extension(psy, &power_supply_ext)) {
+			pr_err("registering battery extension failed\n");
+			return;
+		}
+	} else {
+		power_supply_unregister_extension(psy, &power_supply_ext);
+	}
+
+	battery_hook = enable;
+}
+
 static int __init test_power_init(void)
 {
 	int i;
@@ -258,6 +333,8 @@ static int __init test_power_init(void)
 		}
 	}
 
+	test_battery_configure_battery_hook(true);
+
 	module_initialized = true;
 	return 0;
 failed:
@@ -524,6 +601,22 @@ static int param_set_battery_current(const char *key,
 
 #define param_get_battery_current param_get_int
 
+static int param_set_battery_hook(const char *key,
+				  const struct kernel_param *kp)
+{
+	int tmp;
+
+	if (1 != sscanf(key, "%d", &tmp))
+		return -EINVAL;
+	if (tmp != 1 && tmp != 0)
+		return -EINVAL;
+
+	test_battery_configure_battery_hook(tmp);
+	return 0;
+}
+
+#define param_get_battery_hook param_get_int
+
 static const struct kernel_param_ops param_ops_ac_online = {
 	.set = param_set_ac_online,
 	.get = param_get_ac_online,
@@ -574,6 +667,11 @@ static const struct kernel_param_ops param_ops_battery_current = {
 	.get = param_get_battery_current,
 };
 
+static const struct kernel_param_ops param_ops_battery_hook = {
+	.set = param_set_battery_hook,
+	.get = param_get_battery_hook,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -584,6 +682,7 @@ static const struct kernel_param_ops param_ops_battery_current = {
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
 #define param_check_battery_charge_counter(name, p) __param_check(name, p, void);
 #define param_check_battery_current(name, p) __param_check(name, p, void);
+#define param_check_battery_hook(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -621,6 +720,9 @@ MODULE_PARM_DESC(battery_charge_counter,
 module_param(battery_current, battery_current, 0644);
 MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
 
+module_param(battery_hook, battery_hook, 0644);
+MODULE_PARM_DESC(battery_hook, "battery hook");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");

-- 
2.45.2


