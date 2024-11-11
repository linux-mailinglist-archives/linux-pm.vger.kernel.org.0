Return-Path: <linux-pm+bounces-17347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5049C484A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9012840E2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54E1C3F3B;
	Mon, 11 Nov 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dHbKomXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2F155A30;
	Mon, 11 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361216; cv=none; b=SJ2byz+wcvPdFsUW1zi5j339UJtUT5+z0WIybH6X6r76JXWFo4LYswtmqLmMEBFYQm8PRmFl9YvwnOsZjGhCiGG4gUvHVgZkHZHJ9r/T2l32aNs7wdRpJ07etIsBPu9E+/JNMSY2AopXZahCF01xISvRUxcWOPlKP2Wc+8/EF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361216; c=relaxed/simple;
	bh=xPxtcrDyr6tHzIlAClodERcs8bwCHKUIZ8Uk9sumlJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4M7Bi2KklQbgjyT38EAb3gz/fObKOA/IaupZkiRDJOMfwaIgCX0d5Qzi+yWPzc6ZWomJIRWkE0U+b02nbYSel+GKyLEJgv4bHTFfHx7ThORlZ23EqyzsnfX5z+pzUeTu15DRj8yJdVfzNwWUGu2iQSOPD0TpRkaNZ9aRn6MZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dHbKomXx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361208;
	bh=xPxtcrDyr6tHzIlAClodERcs8bwCHKUIZ8Uk9sumlJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHbKomXxc9choKCT/sCmkR9He7ArmIIUvGmB7caxFx08lxPAcg1ec1susUTVA1uBe
	 ygEPPTojRMGMMPvRg6xmR/rg1ve+fgbsdZJ+n1tABX2TZ0bgRGVoOubFB0m3ixsM7G
	 GW1lTZ5Y8ZVUieGv/mds9MtlvJXIjCh9HOSVOhoY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:04 +0100
Subject: [PATCH v4 2/9] power: supply: core: rename psy_has_property() to
 psy_desc_has_property()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-2-7240144daa8e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=1924;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xPxtcrDyr6tHzIlAClodERcs8bwCHKUIZ8Uk9sumlJ0=;
 b=yrvnvdOsKSW70kihrdE3Z8H47tI7CuaFJWj2ZAfnCDMhEOmszqWNdVBClLvJaCbGjPAh/VXDz
 ZzV3WBwrMs4BCBfeFX3K06vCCIhKNy6exf4ip41JWAWSTKlXnTtDQWe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The function only takes a desc as parameter, align the naming.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 16085eff008442ecd04016cd12c2854a0230d9c6..2f61f6b90b99f40ee04a6d63ebc20036f0447102 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1180,8 +1180,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
+static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
+				  enum power_supply_property psp)
 {
 	bool found = false;
 	int i;
@@ -1206,7 +1206,7 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	if (psy_has_property(psy->desc, psp))
+	if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1300,7 +1300,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)

-- 
2.47.0


