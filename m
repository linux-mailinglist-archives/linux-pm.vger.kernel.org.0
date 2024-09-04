Return-Path: <linux-pm+bounces-13615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4C96C774
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980171C250A7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982E1E6DFD;
	Wed,  4 Sep 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VichUywS"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C21E6DC2;
	Wed,  4 Sep 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477954; cv=none; b=nI34yeuBHV7M1fXbAgv71tSPJMyR1bLEueSaHfGTwKFTEX1u97EZkwjfRkFrTADIdUFXagITQrD3nnth2blMxV7G34LcmloBIDeHENu/LiIFZTaIoaUGMosE6wv9OjphSRJgydoNxDf0gq/7Rlef1Ysl+J/QT/wmS/dObYuTOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477954; c=relaxed/simple;
	bh=tSi4oRvOGQIXQ7gqeiL+uRkdyJkUIZbA/N22hcgrptg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7WbjSsbsPV8ASJK2Bfi/8NKeko1UTDFJ896aF/8yv/oEBMy1x43i8KRGYO/ScaO3N1Pk3NhKP5hHxuSEdMWA2slJz69XtC/EiUJuQyzGE0ZQpl5JxGZPeI16hoIAym/PxEiGsDr/mX63SJ65yMFOzZRn79MPQiVph6cPoVIA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VichUywS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477949;
	bh=tSi4oRvOGQIXQ7gqeiL+uRkdyJkUIZbA/N22hcgrptg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VichUywSGzWCRvZjoNtUbOcS7cG9+DpFa47j/NUuj0yq9fJxi2M8CrRuwo6p2+Eev
	 uVeYLvufhXDJ0qT1oEsxYMV9GxZHwrFYHss/sMwHfhppvFo+/PIvk0m2KiD/h3luCv
	 na1899RqEQGNmeRn300L8eC4XGXzgyIoUCzKP3mA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:35 +0200
Subject: [PATCH RFC v3 2/9] power: supply: core: register thermal zone for
 battery
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=2347;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tSi4oRvOGQIXQ7gqeiL+uRkdyJkUIZbA/N22hcgrptg=;
 b=BU4CIHCEnBEnvYXSrcqUcr+HQ4oZhPLaoSakctQyipnUOX4vj8oEWk6mBPlRgaVZFOLnfspej
 TerdtMmZzs/B9HsYh55B2wzNiI0WQvkqTXJ5rPVTHKcE/zhvLdYdAhZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

power_supply_read_team() can also read the temperature from the battery.
But currently when registering the thermal zone, the battery is not
checked for POWER_SUPPLY_PROP_TEMP.
Introduce a helper which can check both the desc and the battery info
for property existence and use that.
Export the helper to the rest of the psy core because it will also be
used by different subcomponents.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h      |  3 +++
 drivers/power/supply/power_supply_core.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 3cbafc58bdad..b01faeaf7827 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,6 +13,9 @@ struct device;
 struct device_type;
 struct power_supply;
 
+extern bool power_supply_has_property(struct power_supply *psy,
+				      enum power_supply_property psp);
+
 #ifdef CONFIG_SYSFS
 
 extern void power_supply_init_attrs(void);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index cff68c4fd63c..dcb7e4853030 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1199,6 +1199,18 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
 	return found;
 }
 
+bool power_supply_has_property(struct power_supply *psy,
+			       enum power_supply_property psp)
+{
+	if (psy_desc_has_property(psy->desc, psp))
+		return true;
+
+	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
+		return true;
+
+	return false;
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
@@ -1308,7 +1320,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)

-- 
2.46.0


