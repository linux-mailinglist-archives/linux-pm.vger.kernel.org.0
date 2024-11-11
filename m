Return-Path: <linux-pm+bounces-17343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE609C4846
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116922816CB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1641BD032;
	Mon, 11 Nov 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BlrR/K1X"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F21B86CF;
	Mon, 11 Nov 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361213; cv=none; b=nJZVA8gzNLX68GZwozKA5uIlIsRHpGNXz2nlj8nrcyyYuMOoqWq3VBBZShjru7J2axmqgG4qsqlScV88F8oGQcYk60C+PHnVx0IfrStjpVTZ/ajxP4aL/1uG1M79oRCB3R9hGvDzeuFSmPRgCinFAO0x+ZqSCQ507+thEciz+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361213; c=relaxed/simple;
	bh=WoMvZJIJux5dqs2E/f2Vyc4MaZs8AL36MsJXVYFWisU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNk5Buo/CyXeMEfEfgdOanqYCiKumfGThO3cLg/ZmHxcQPMF9cZXs7qrnNAAWFcvnPGJkqOG0pQyXeIxjh3IYWME4Ct8FHfgg05J5OpbSkQaBRHY+9WbjK33G6iibOr2TVXKxq374isPhVyRUNn30wiDOB/D8GMzlQXllsnYPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BlrR/K1X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361208;
	bh=WoMvZJIJux5dqs2E/f2Vyc4MaZs8AL36MsJXVYFWisU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BlrR/K1Xb342Rc1PaIFOcYjyHUUH9PebcSHGGMq0Q3IpyurqrbuGWupI1pT77VYfj
	 eFAtu0BBC5dvKre88yc5JWNkbRIHbtTjhl4E+eUN/1Q1fA6bIAAPLn3I5A+AODMYBv
	 6HEA8VvPNalEHzPeZMtAZDqG/uRGTxsKq9kRMcFQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:06 +0100
Subject: [PATCH v4 4/9] power: supply: hwmon: prepare for power supply
 extensions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-4-7240144daa8e@weissschuh.net>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
In-Reply-To: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=3062;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WoMvZJIJux5dqs2E/f2Vyc4MaZs8AL36MsJXVYFWisU=;
 b=iNSCnaLWGctCjtcixkDpwdJqHaTwvZ7xtoRnT9tiLCkUOR+W545SWEoR/Ces3ouT04VWVjvl7
 g2uEwoAhVRVBNcZq4ano1pNMpoKwlaIhnoWh+5ZVOmmmOpzOxespcNw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming extension API will add properties which are not part of the
the power_supply_desc.
Use power_supply_has_property() so the properties from extensions are
also checked.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_hwmon.c | 50 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 01be04903d7d2465ae2acb9eeb0b55a87868bb87..95245e6a6baa3e85ae8551e71f4f7905639a3325 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -349,9 +349,28 @@ static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
 	.info = power_supply_hwmon_info,
 };
 
+static const enum power_supply_property power_supply_hwmon_props[] = {
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 {
-	const struct power_supply_desc *desc = psy->desc;
 	struct power_supply_hwmon *psyhw;
 	struct device *dev = &psy->dev;
 	struct device *hwmon;
@@ -377,32 +396,11 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	for (i = 0; i < desc->num_properties; i++) {
-		const enum power_supply_property prop = desc->properties[i];
-
-		switch (prop) {
-		case POWER_SUPPLY_PROP_CURRENT_AVG:
-		case POWER_SUPPLY_PROP_CURRENT_MAX:
-		case POWER_SUPPLY_PROP_CURRENT_NOW:
-		case POWER_SUPPLY_PROP_POWER_AVG:
-		case POWER_SUPPLY_PROP_POWER_NOW:
-		case POWER_SUPPLY_PROP_TEMP:
-		case POWER_SUPPLY_PROP_TEMP_MAX:
-		case POWER_SUPPLY_PROP_TEMP_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	for (i = 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
+		const enum power_supply_property prop = power_supply_hwmon_props[i];
+
+		if (power_supply_has_property(psy, prop))
 			set_bit(prop, psyhw->props);
-			break;
-		default:
-			break;
-		}
 	}
 
 	name = psy->desc->name;

-- 
2.47.0


