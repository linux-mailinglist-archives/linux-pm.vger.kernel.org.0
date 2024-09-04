Return-Path: <linux-pm+bounces-13616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362096C777
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07A81F24ACA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666851E7657;
	Wed,  4 Sep 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rWDxxD1c"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B81E6DC6;
	Wed,  4 Sep 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477955; cv=none; b=gzFxHHNywddLVGhJ8KkLs24nkvIFXlOCAst8oGTfM9n6xh3wSP+8+PRw0zadDoM8KYgXLqgZ8X0OGlDGHijppNIsJSNdxjz0Ygae7D2oeVcMUORI4NEZ1JQKgEIFaxi6DORihNlPD2Tb7r5e81sKo+/tWhoxcwoZqQNd49QFNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477955; c=relaxed/simple;
	bh=hEkSIvpNPK0BIvtwX1OZ+TPL0VX03eyHv0tdX9hn8tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MO0uaJDoeNd7/EWKzCaMllPahEYWG9M976tK3BY6L/6/76TePfvHvaUgFZ8iQx+WCzfgI33MtuoMpKuXK6e6VXEEcVlfUNgHCepOwURQ409mAzTwqRrrZqKkgtjNrYVdHIqMBkVpXjRllSN77G/jW91+ru8WQ7ri/MQzD8U1NcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rWDxxD1c; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477949;
	bh=hEkSIvpNPK0BIvtwX1OZ+TPL0VX03eyHv0tdX9hn8tM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rWDxxD1cEqJOvQSH3Oi50pXPVQhGV1jsErhM3RJaTcyWyAosgb7NIjJ7azy8tTW/y
	 ogslUeQV0VgZVIp4q4hXVRyLdYom3zPBMAuF0kdYiEnLdpp9j8pl0DipPqqS+I6hyi
	 8X7sxzwCbL1wG8zKsCVV0lFakuuTeQ0L+qVYFGZ8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:34 +0200
Subject: [PATCH RFC v3 1/9] power: supply: core: rename psy_has_property()
 to psy_desc_has_property()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=2126;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hEkSIvpNPK0BIvtwX1OZ+TPL0VX03eyHv0tdX9hn8tM=;
 b=8J3gHB8J8fm4jNAYK11JOvww0TkwXNmjViB3VSKQNL9BqdXa40DOmLE7A8PE92Pw8iiBIIn1o
 BXn6dPWCDc8DOKakNyXkC9hhvNYAMw8AYZPAneahEW8/c4enO1tLXsH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The function only takes a desc as parameter, align the naming.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..cff68c4fd63c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
+static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
+				  enum power_supply_property psp)
 {
 	bool found = false;
 	int i;
@@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	if (psy_has_property(psy->desc, psp))
+	if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
@@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
+	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
 	    (!desc->usb_types || !desc->num_usb_types))
 		return ERR_PTR(-EINVAL);
 

-- 
2.46.0


