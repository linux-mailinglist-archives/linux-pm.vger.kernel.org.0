Return-Path: <linux-pm+bounces-17348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100F9C4851
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3956C1F21245
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA31C75EC;
	Mon, 11 Nov 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MxfNVAc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBC1BF7E0;
	Mon, 11 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361217; cv=none; b=Iv/6jF3kfinpI2+nM5ZMbiRjNa9yPK6KQbm0Ff2zJ3bM4B8nsQHw6Gj2NA2sPdgSXBuGRJXPxeemqJkCT+I6uSDZb6PBUKjGUp71JbRGM9IvpTouAfj/RZRtA/mGPTvaREg2zZTbLfAG0FTYEc1h850R121rs7hTirU1Puhre9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361217; c=relaxed/simple;
	bh=QYgcF01QtPE15FfXFZBgPtS96Bnv77IqVsOl66BIaxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAxdjLEJw53bTiIyZ8TDnz4Gm4T1SrfY72xou1xoq+0RJLP+pUHI0kAn7ygsuEltWr0uaI66EFO0UFLevvJbXVEL9g+HRsr9DX+UHSajK548DNqV6H+3T78IUye2nlBu3mqwKfVLH7zDwaSvaaLi/y1CjXq7TqPxTVh2H2ndfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MxfNVAc/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361209;
	bh=QYgcF01QtPE15FfXFZBgPtS96Bnv77IqVsOl66BIaxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxfNVAc/LOpZMDoBfMeRLIIt6TY0G81uJHjFXX8ZZZhK9TOD+o1QCD4T2iv/ICdiY
	 w97KBNo4gKfsqbvZaRREaFON3Bor5Axk9o7mbfD9xZ20+xgTDyAvWaS1i3yzcfDe0a
	 9pCbJeRI8EpMo+1s4ji5zF2EWBNBrnKwy00bmR9Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:08 +0100
Subject: [PATCH v4 6/9] power: supply: sysfs: rework uevent property loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-6-7240144daa8e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=3185;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QYgcF01QtPE15FfXFZBgPtS96Bnv77IqVsOl66BIaxM=;
 b=72BLc6lhhG3HHoRzUdq/8DihVQQ6vKjEh+bJHCAOXxq58XnBfX5SPlqkocCnNQnjyWA2TcuFA
 UAtII2hWZfKCGkqcXrY4278etmCj1t8mGTCzsIjgT9wEIWSntu8gINT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of looping through all properties known to be supported by the
psy, loop over all known properties and decide based on the return value
of power_supply_get_property() whether the property existed.

This makes the code shorter now and even more so when power supply
extensions are added.
It also simplifies the locking, as it can all happen inside
power_supply_get_property().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_sysfs.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bfe48fe01a8d03828c2e539e1e6e5e9fc5c60167..99bfe1f03eb8326d38c4e2831c9670313b42e425 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -289,7 +289,7 @@ static ssize_t power_supply_format_property(struct device *dev,
 				dev_dbg_ratelimited(dev,
 					"driver has no data for `%s' property\n",
 					attr->attr.name);
-			else if (ret != -ENODEV && ret != -EAGAIN)
+			else if (ret != -ENODEV && ret != -EAGAIN && ret != -EINVAL)
 				dev_err_ratelimited(dev,
 					"driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
@@ -441,7 +441,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 	dev_attr = &pwr_attr->dev_attr;
 
 	ret = power_supply_format_property((struct device *)dev, true, dev_attr, prop_buf);
-	if (ret == -ENODEV || ret == -ENODATA) {
+	if (ret == -ENODEV || ret == -ENODATA || ret == -EINVAL) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;
 		 * send the uevent with at least the PRESENT=0 property
@@ -462,11 +462,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 
 int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	const struct power_supply *psy = dev_get_drvdata(dev);
-	const enum power_supply_property *battery_props =
-		power_supply_battery_info_properties;
-	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
-					 sizeof(unsigned long) + 1] = {0};
+	struct power_supply *psy = dev_get_drvdata(dev);
 	int ret = 0, j;
 	char *prop_buf;
 
@@ -494,22 +490,8 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		goto out;
 
-	for (j = 0; j < psy->desc->num_properties; j++) {
-		set_bit(psy->desc->properties[j], psy_drv_properties);
-		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
-				      prop_buf);
-		if (ret)
-			goto out;
-	}
-
-	for (j = 0; j < power_supply_battery_info_properties_size; j++) {
-		if (test_bit(battery_props[j], psy_drv_properties))
-			continue;
-		if (!power_supply_battery_info_has_prop(psy->battery_info,
-				battery_props[j]))
-			continue;
-		ret = add_prop_uevent(dev, env, battery_props[j],
-			      prop_buf);
+	for (j = 0; j < POWER_SUPPLY_ATTR_CNT; j++) {
+		ret = add_prop_uevent(dev, env, j, prop_buf);
 		if (ret)
 			goto out;
 	}

-- 
2.47.0


