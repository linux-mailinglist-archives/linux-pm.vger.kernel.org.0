Return-Path: <linux-pm+bounces-28261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14DAD1446
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD021889F9D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B16254876;
	Sun,  8 Jun 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOD4+Jt8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF70224FA
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415230; cv=none; b=fK6gIvnYVPpQ4QqD/y3YMe7aPCtjXVYPT69CCmJ1TeoUs9Cg8RoJUofFhyOFQLDlACQ5kqA9of1kwTNwBVCF6DT5e7tmijV5ckCrZeEdhVf67DNZRn8O3Y3ZU5hLCZk8ZqrXtVvAas12Eyi97De34Mtoys7Gjw2Ys8nvTLj5OO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415230; c=relaxed/simple;
	bh=p5EHmB8KXCz3QZJRZ4egAH/kUseuWnlTXgNyawhegJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBV7nZ2qi239FgQISj1Fg3wuY/uRamsgw4fRpH9h/e2FY0uGKGnIczUJVswrkQmEN1DXFVXhNrycns2iDbtkYXKq89BKRp5CvoLIct4pP5sIDCNZ04IKklAaVvPe5HUIM/2Nzd1ND6u4qBvddZU4Z5Bp1wERBNqbSEV8SMH78As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOD4+Jt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015B9C4CEEE;
	Sun,  8 Jun 2025 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415230;
	bh=p5EHmB8KXCz3QZJRZ4egAH/kUseuWnlTXgNyawhegJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOD4+Jt85GCj9jAkWw5xIp5E8SQnk/AJW8zMt16ajggjpkqQoDiAKoQCwhThrArPp
	 OOFCG7N7sVUxLMr3GJWXn/SQrXwDptQ94rnEfOHUYzluim/XyDuvgKhbAPEntnm0sa
	 tdAQqeausDFRVKE2HZSsULPC7qlHsd3mL7lhHG9xywUSBkUe4cvrKgEXMk3Z2O6hAx
	 WPuw0mpsCOG6OaME/1+03VM0B/VmbkX43wT3OsYvC5+sQI7d5Z3C8dtD9hKJMs2X4O
	 7fGiXc+bB/snuGgxgNkHC8HXt3qWThRPkmViylFx6x7SzoBdgcfYk9gCRZ1uIzkZGu
	 Miq2g9dWeY0RA==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 08/10] power: supply: ug3105_battery: Use psy->battery_info
Date: Sun,  8 Jun 2025 22:40:08 +0200
Message-ID: <20250608204010.37482-9-hansg@kernel.org>
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

For POWER_SUPPLY_TYPE_BATTERY power-supplies the core already
calls power_supply_get_battery_info() and stores the result in
psy->battery_info.

Use psy->battery_info instead of having the driver call
power_supply_get_battery_info() itself.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/ug3105_battery.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 38e23bdd4603..806f6892e189 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -69,7 +69,6 @@
 struct ug3105_chip {
 	struct i2c_client *client;
 	struct power_supply *psy;
-	struct power_supply_battery_info *info;
 	struct delayed_work work;
 	struct mutex lock;
 	int ocv[UG3105_MOV_AVG_WINDOW];		/* micro-volt */
@@ -103,7 +102,8 @@ static int ug3105_read_word(struct i2c_client *client, u8 reg)
 
 static int ug3105_get_status(struct ug3105_chip *chip)
 {
-	int full = chip->info->constant_charge_voltage_max_uv - UG3105_FULL_BAT_HYST_UV;
+	int full = chip->psy->battery_info->constant_charge_voltage_max_uv -
+		   UG3105_FULL_BAT_HYST_UV;
 
 	if (chip->curr > UG3105_CURR_HYST_UA)
 		return POWER_SUPPLY_STATUS_CHARGING;
@@ -164,7 +164,7 @@ static int ug3105_get_capacity(struct ug3105_chip *chip)
 		ocv_diff = ocv_capacity_tbl[i] - chip->ocv_avg;
 		ocv_step = ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
 		/* scale 0-110% down to 0-100% for LiPo HV */
-		if (chip->info->constant_charge_voltage_max_uv >= 4300000)
+		if (chip->psy->battery_info->constant_charge_voltage_max_uv >= 4300000)
 			return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
 		else
 			return i * 5 - ocv_diff * 5 / ocv_step;
@@ -401,12 +401,9 @@ static int ug3105_probe(struct i2c_client *client)
 	if (IS_ERR(psy))
 		return PTR_ERR(psy);
 
-	ret = power_supply_get_battery_info(psy, &chip->info);
-	if (ret)
-		return ret;
-
-	if (chip->info->factory_internal_resistance_uohm == -EINVAL ||
-	    chip->info->constant_charge_voltage_max_uv == -EINVAL) {
+	if (!psy->battery_info ||
+	    psy->battery_info->factory_internal_resistance_uohm == -EINVAL ||
+	    psy->battery_info->constant_charge_voltage_max_uv == -EINVAL) {
 		dev_err(dev, "error required properties are missing\n");
 		return -ENODEV;
 	}
@@ -422,7 +419,7 @@ static int ug3105_probe(struct i2c_client *client)
 	chip->ua_per_unit = 8100000 / curr_sense_res_uohm;
 
 	/* Use provided internal resistance as start point (in milli-ohm) */
-	chip->intern_res_avg = chip->info->factory_internal_resistance_uohm / 1000;
+	chip->intern_res_avg = psy->battery_info->factory_internal_resistance_uohm / 1000;
 	/* Also add it to the internal resistance moving average window */
 	chip->intern_res[0] = chip->intern_res_avg;
 	chip->intern_res_avg_index = 1;
-- 
2.49.0


