Return-Path: <linux-pm+bounces-19064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEEC9ED6DF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAEB163AC7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC420A5D0;
	Wed, 11 Dec 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EFU5YaIn"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344F204F73;
	Wed, 11 Dec 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947083; cv=none; b=BRo4m18BoMFDg3yXcEtd7XEhSCadCby2hYxGqQz3Zn/5l6mbpZPotEs139cW+WTHxppwjJdjGo0+/HkFA+/cbgP9gyhaMZE5Td1IB0Xb2lwoLYCnrMg45hoFj/1KY1uUGZP6CUX3EsoCaa84huqYDVuV1ATDQKvzAV2HhgnJqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947083; c=relaxed/simple;
	bh=qUrg/ybfNAtUsp/bGKltHqittPqxhaqgSFITRZ3BMjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPzQE6F+4xZ0mNd573+6kDbM+4zuYd5hYX7WCl0t4SuIf5qmUL2+2MpG6s6gROV1Dvs3lXTVzBF3dXLwZYb1VgrXwIe2LzEASwySNDR2Z10qglmvHvKI3no7J81n6hPe1v2VhomImPuL8u/bKWx2EErK/n5dikjFnB4+lR0F/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EFU5YaIn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733947079;
	bh=qUrg/ybfNAtUsp/bGKltHqittPqxhaqgSFITRZ3BMjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EFU5YaIn2Kmby/A0VN1oBfSeZJUMzqjA3irlQG3KAOHrP8qe2Lu7HCkjAOWiK0r0R
	 CsZWwAu0TvOa41OtyVQn3bghAxZvgbX1GnN9nusF9A1F8zdqHmLY+f8R/HeN7nxSUC
	 eEYvXwNGSBIMZADXhY76ljNFu900W2jMM/NW0hIs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 20:57:56 +0100
Subject: [PATCH v6 2/4] power: supply: test-power: implement a power supply
 extension
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-power-supply-extensions-v6-2-9d9dc3f3d387@weissschuh.net>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
In-Reply-To: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733947078; l=5682;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qUrg/ybfNAtUsp/bGKltHqittPqxhaqgSFITRZ3BMjU=;
 b=Lt226Y8S97hLQSb/HQUZhs2Z2gU6sSud6UzIqffU1fbyKQzb01AHfdbUStI+1BhXswjGKC+FJ
 bUWn1y8zIaZBwwbpMJe5wTIGXHo/4oRgm6+TLO1CZsXPHflO3HxCub3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Allow easy testing of the new power supply extension functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 111 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 442ceb7795e1d84e34da2801d228d53fb67e08d9..66f9ef52e0f3e6e6e6bebcfd438c2acd421284ec 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -37,6 +37,7 @@ static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
 static enum power_supply_charge_behaviour battery_charge_behaviour =
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+static bool battery_extension;
 
 static bool module_initialized;
 
@@ -238,6 +239,85 @@ static const struct power_supply_config test_power_configs[] = {
 	},
 };
 
+static int test_power_battery_extmanufacture_year = 1234;
+static int test_power_battery_exttemp_max = 1000;
+static const enum power_supply_property test_power_battery_extprops[] = {
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+};
+
+static int test_power_battery_extget_property(struct power_supply *psy,
+					      const struct power_supply_ext *ext,
+					      void *ext_data,
+					      enum power_supply_property psp,
+					      union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = test_power_battery_extmanufacture_year;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		val->intval = test_power_battery_exttemp_max;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int test_power_battery_extset_property(struct power_supply *psy,
+					      const struct power_supply_ext *ext,
+					      void *ext_data,
+					      enum power_supply_property psp,
+					      const union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		test_power_battery_extmanufacture_year = val->intval;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		test_power_battery_exttemp_max = val->intval;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int test_power_battery_extproperty_is_writeable(struct power_supply *psy,
+						       const struct power_supply_ext *ext,
+						       void *ext_data,
+						       enum power_supply_property psp)
+{
+	return true;
+}
+
+static const struct power_supply_ext test_power_battery_ext = {
+	.properties		= test_power_battery_extprops,
+	.num_properties		= ARRAY_SIZE(test_power_battery_extprops),
+	.get_property		= test_power_battery_extget_property,
+	.set_property		= test_power_battery_extset_property,
+	.property_is_writeable	= test_power_battery_extproperty_is_writeable,
+};
+
+static void test_power_configure_battery_extension(bool enable)
+{
+	struct power_supply *psy;
+
+	psy = test_power_supplies[TEST_BATTERY];
+
+	if (enable) {
+		if (power_supply_register_extension(psy, &test_power_battery_ext, NULL)) {
+			pr_err("registering battery extension failed\n");
+			return;
+		}
+	} else {
+		power_supply_unregister_extension(psy, &test_power_battery_ext);
+	}
+
+	battery_extension = enable;
+}
+
 static int __init test_power_init(void)
 {
 	int i;
@@ -258,6 +338,8 @@ static int __init test_power_init(void)
 		}
 	}
 
+	test_power_configure_battery_extension(true);
+
 	module_initialized = true;
 	return 0;
 failed:
@@ -524,6 +606,26 @@ static int param_set_battery_current(const char *key,
 
 #define param_get_battery_current param_get_int
 
+static int param_set_battery_extension(const char *key,
+				       const struct kernel_param *kp)
+{
+	bool prev_battery_extension;
+	int ret;
+
+	prev_battery_extension = battery_extension;
+
+	ret = param_set_bool(key, kp);
+	if (ret)
+		return ret;
+
+	if (prev_battery_extension != battery_extension)
+		test_power_configure_battery_extension(battery_extension);
+
+	return 0;
+}
+
+#define param_get_battery_extension param_get_bool
+
 static const struct kernel_param_ops param_ops_ac_online = {
 	.set = param_set_ac_online,
 	.get = param_get_ac_online,
@@ -574,6 +676,11 @@ static const struct kernel_param_ops param_ops_battery_current = {
 	.get = param_get_battery_current,
 };
 
+static const struct kernel_param_ops param_ops_battery_extension = {
+	.set = param_set_battery_extension,
+	.get = param_get_battery_extension,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -584,6 +691,7 @@ static const struct kernel_param_ops param_ops_battery_current = {
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
 #define param_check_battery_charge_counter(name, p) __param_check(name, p, void);
 #define param_check_battery_current(name, p) __param_check(name, p, void);
+#define param_check_battery_extension(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -621,6 +729,9 @@ MODULE_PARM_DESC(battery_charge_counter,
 module_param(battery_current, battery_current, 0644);
 MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
 
+module_param(battery_extension, battery_extension, 0644);
+MODULE_PARM_DESC(battery_extension, "battery extension");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");

-- 
2.47.1


