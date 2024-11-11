Return-Path: <linux-pm+bounces-17346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307089C4859
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB23B25E89
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853941C3F28;
	Mon, 11 Nov 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FAhjT9se"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAC1BD9EB;
	Mon, 11 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361216; cv=none; b=aZ1+UuKZRhVCdHu4uQmLt5QV3KGYrpEGUYEecYQ496ISK9gvl0WUeBrgxq1ZOuan+hR3i1TLcEUrlT7J6VkVUQEDcv3Gp3GqKPbSNMCMpyz2Tw2RkLXMvDS1mhhypT9OAluwxdXrjgqoHhOLH6Pu3yPqdyH6QJmLpkVr4CpR4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361216; c=relaxed/simple;
	bh=4iqMRN7FLf79GTyhGQg8fs3vEjA1Cjx5IA5RBAJpeNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2XEp1aDqLwMt+kfvwjNdyWEuNx7csd71Udz/qfsFb52HE+EC+9E0pkmI+e7EnKRar8Hs38ZJj6zbviU4PHklu5rRc2XcvuOEyRAULp5HgBYqkGtFBzZYJevFaZtw6WwXa97AVI4f2SLpXfodDZfyHMFTQL8Pu8qVg1CDvRXEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FAhjT9se; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361209;
	bh=4iqMRN7FLf79GTyhGQg8fs3vEjA1Cjx5IA5RBAJpeNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FAhjT9seLAlGjv9MlySWrI6zADUyVqwPgt6HWlgLhrJa8vijAWtFnAHvN1NvV4xPH
	 sB02gIMa2JpUe5inHQWXB6ZMYZd2YJGSI67VEpFlQG5mQ6GEMhupOyMLdk7ghigN+i
	 Hu8fh87768RwbxUsk0JR5Z8O2Pov/NcXggJNkYdY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:10 +0100
Subject: [PATCH v4 8/9] power: supply: test-power: implement a power supply
 extension
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-8-7240144daa8e@weissschuh.net>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
In-Reply-To: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=5131;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4iqMRN7FLf79GTyhGQg8fs3vEjA1Cjx5IA5RBAJpeNE=;
 b=j+0NvPWfNwUgib4IBnuOML8UBCcjtjCQp7YlMLj0w6JjYY8Mc7us5tlUh0byu2FELhtpW8rhH
 r7J3pl69Aw3AUogOXzuvteKz8EdrVDGKkUO3yEi81p0k5AK4GSJjhX6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Allow easy testing of the new power supply extension functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 442ceb7795e1d84e34da2801d228d53fb67e08d9..af05f3c5c292fd5702109df7dfa177d85c9d18c9 100644
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
+static const enum power_supply_property power_supply_ext_props[] = {
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+};
+
+static int power_supply_ext_get_property(struct power_supply *psy,
+					 const struct power_supply_ext *ext,
+					 void *ext_data,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = power_supply_ext_manufacture_year;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int power_supply_ext_set_property(struct power_supply *psy,
+					 const struct power_supply_ext *ext,
+					 void *ext_data,
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
+						  const struct power_supply_ext *ext,
+						  void *ext_data,
+						  enum power_supply_property psp)
+{
+	return true;
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
+		if (power_supply_register_extension(psy, &power_supply_ext, NULL)) {
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
2.47.0


