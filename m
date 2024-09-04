Return-Path: <linux-pm+bounces-13617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4396C77A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502181C20F04
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E31E8B8A;
	Wed,  4 Sep 2024 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Jx/VexhN"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA21E7665;
	Wed,  4 Sep 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477957; cv=none; b=dPIwcCaN3e5hqLSoYBhxvWiDHS7PP06GyQ60eRsryWdwOw4sZ8hkHn6nKa6lUokuj6hvPB0OfOXI7dUo4ItJ5lX2crtXUfjJ4ReKGILBmxRH69ex6j2YX/+TWb7fuNVVO6sBUo/RsTPH5sHZ87TQT4c7ymOYsNTfu/oBCtZHeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477957; c=relaxed/simple;
	bh=X7lrjE7x1vAygc53rzcx7av5ytjIigJ+NYfn3S4SJ4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvuewoTBHCbcym67NQVZp7H1LdMcM9GAczd7qXgpLVBUYt5AiKhfyF7vQr3FAYSis/gufm/TDglEaIdfvhffpgJPuapN3nYi8z02aRvkpS0mioZNHRNu/0TOJJLE+48rhBUBQJ4AdUvBDgl1UlkTQlNRtYyIX8h9lTAzDQm66W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Jx/VexhN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477950;
	bh=X7lrjE7x1vAygc53rzcx7av5ytjIigJ+NYfn3S4SJ4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jx/VexhNKkiGnsolG8rjeSiBr7Irw/YxP8gy/7S/pgwWwny5e2IJ296vj8A/rERoU
	 zPWlMMUZJn5HvxpoxIyczJx46Mx+Fm/GdqKlxAeNbqfL8TFPNLNLOgyewFl2YtsDXy
	 GJrapuGVkR8nsTzh4MQ1EUwAMzSf+w8BgafNVYXg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:38 +0200
Subject: [PATCH RFC v3 5/9] power: supply: sysfs: rework uevent property
 loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-5-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=2599;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=X7lrjE7x1vAygc53rzcx7av5ytjIigJ+NYfn3S4SJ4A=;
 b=1vjSgYQ94s1oECkeX/DTp6kXRi0vegsS8A+3bSox8QyG7q4IaF/lpF7hURPFC3nBLw0Ur+J7R
 zd4tZe3Y7+6BNHlv0Pp71iL610FFS1nFBH1ULfOTpYmNT6sdr6Q6ObY
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
---
 drivers/power/supply/power_supply_sysfs.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4ab08386bcb7..915a4ba62258 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -290,6 +290,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				dev_dbg_ratelimited(dev,
 					"driver has no data for `%s' property\n",
 					attr->attr.name);
+			else if (ret == -EINVAL) /* property is not supported */
+				return -ENODATA;
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
 					"driver failed to report `%s' property: %zd\n",
@@ -451,11 +453,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 
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
 
@@ -483,22 +481,8 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
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
2.46.0


