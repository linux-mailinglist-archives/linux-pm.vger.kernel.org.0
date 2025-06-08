Return-Path: <linux-pm+bounces-28262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286FAD1447
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C586116888E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29E254876;
	Sun,  8 Jun 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIPH8USX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6B224FA
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415232; cv=none; b=pPd2hWYh0UEk6i+QZ4vpCYLHt3wpQgowJ7xtD5NuHnpIznCoo4jZuRgsOR3HwMwE2+Z8WLEkj5pbq18B3pYSZ1MGOJ7V0BoLDVxtJvzSkYpsyB6KwmFaHOeBQ+qt1uDpUqLGR4DVocOXXOkpYqt0C8nK0+bzZMlnwoNgeyocLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415232; c=relaxed/simple;
	bh=fbl7SlM7GIRGQUhir4c7sfNxmoDHDR/ccZ6G/rhifCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpKBfqBDzGj30nEWEKmKuVNVUmHAQ4C5eV7qPjK4+qqsVtzh1/dmvrOqMV3cjH3XlcFtVqhJQPUuinglfioprE2/1Hs/hQ7tGkxqbKn0EfJCMeI1PlonuZ4CyFC8l/2+seJKx+erlpWcqlhDOv2ct175wPxxTIFoK0ntJQ4bOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIPH8USX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEFBC4CEEE;
	Sun,  8 Jun 2025 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415232;
	bh=fbl7SlM7GIRGQUhir4c7sfNxmoDHDR/ccZ6G/rhifCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIPH8USX9T55gnud2trwuCqEn8/MiAUtBgXmMMvgvyg2o3tTlICQ5AhwzG5rh+UXp
	 c+CidRMya0k79kVfmvb/tZYoK3gAyQ5TxcPcp9m6pF+LIi4b8bUr3m7ccp6FvEJUSy
	 CbtMQPvmxaP8cLcGNIYvo1gsFOAQ6k8+GQyAxLCULaYSpOK7k+hqbF8bXX9xGKAJ4F
	 8PfBg9Hdf84KIPJHTGOded+cEOESc/M9n9SB7YstjJ3TkKxXKQH7uvL71weusofRVf
	 0PX/g1H7ye0PPWE6lxxodLibA+tS4Zt2HUqFkCHhzG3+33l2EX/5ehkwx29PH94BuA
	 qQEy9dczmTaAw==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 09/10] power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv2cap()
Date: Sun,  8 Jun 2025 22:40:09 +0200
Message-ID: <20250608204010.37482-10-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608204010.37482-1-hansg@kernel.org>
References: <20250608204010.37482-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded ocv -> capacity table and the ug3105_get_capacity()
helper with using the generic power_supply_batinfo_ocv2cap() function.

Note this relies on the battery fwnode providing at least 1
"ocv-capacity-table", if that is missing probe() will now fail with EINVAL.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/ug3105_battery.c | 68 ++++-----------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 806f6892e189..e8a1de7cade0 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -66,6 +66,8 @@
 #define UG3105_LOW_BAT_UV					3700000
 #define UG3105_FULL_BAT_HYST_UV					38000
 
+#define AMBIENT_TEMP_CELCIUS					25
+
 struct ug3105_chip {
 	struct i2c_client *client;
 	struct power_supply *psy;
@@ -117,62 +119,6 @@ static int ug3105_get_status(struct ug3105_chip *chip)
 	return POWER_SUPPLY_STATUS_NOT_CHARGING;
 }
 
-static int ug3105_get_capacity(struct ug3105_chip *chip)
-{
-	/*
-	 * OCV voltages in uV for 0-110% in 5% increments, the 100-110% is
-	 * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
-	 * instead of the usual 4.2V.
-	 */
-	static const int ocv_capacity_tbl[23] = {
-		3350000,
-		3610000,
-		3690000,
-		3710000,
-		3730000,
-		3750000,
-		3770000,
-		3786667,
-		3803333,
-		3820000,
-		3836667,
-		3853333,
-		3870000,
-		3907500,
-		3945000,
-		3982500,
-		4020000,
-		4075000,
-		4110000,
-		4150000,
-		4200000,
-		4250000,
-		4300000,
-	};
-	int i, ocv_diff, ocv_step;
-
-	if (chip->ocv_avg < ocv_capacity_tbl[0])
-		return 0;
-
-	if (chip->status == POWER_SUPPLY_STATUS_FULL)
-		return 100;
-
-	for (i = 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
-		if (chip->ocv_avg > ocv_capacity_tbl[i])
-			continue;
-
-		ocv_diff = ocv_capacity_tbl[i] - chip->ocv_avg;
-		ocv_step = ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
-		/* scale 0-110% down to 0-100% for LiPo HV */
-		if (chip->psy->battery_info->constant_charge_voltage_max_uv >= 4300000)
-			return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
-		else
-			return i * 5 - ocv_diff * 5 / ocv_step;
-	}
-
-	return 100;
-}
-
 static void ug3105_work(struct work_struct *work)
 {
 	struct ug3105_chip *chip = container_of(work, struct ug3105_chip,
@@ -231,7 +177,12 @@ static void ug3105_work(struct work_struct *work)
 
 	chip->supplied = power_supply_am_i_supplied(psy);
 	chip->status = ug3105_get_status(chip);
-	chip->capacity = ug3105_get_capacity(chip);
+	if (chip->status == POWER_SUPPLY_STATUS_FULL)
+		chip->capacity = 100;
+	else
+		chip->capacity = power_supply_batinfo_ocv2cap(chip->psy->battery_info,
+							      chip->ocv_avg,
+							      AMBIENT_TEMP_CELCIUS);
 
 	/*
 	 * Skip internal resistance calc on charger [un]plug and
@@ -403,7 +354,8 @@ static int ug3105_probe(struct i2c_client *client)
 
 	if (!psy->battery_info ||
 	    psy->battery_info->factory_internal_resistance_uohm == -EINVAL ||
-	    psy->battery_info->constant_charge_voltage_max_uv == -EINVAL) {
+	    psy->battery_info->constant_charge_voltage_max_uv == -EINVAL ||
+	    !psy->battery_info->ocv_table[0]) {
 		dev_err(dev, "error required properties are missing\n");
 		return -ENODEV;
 	}
-- 
2.49.0


