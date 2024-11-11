Return-Path: <linux-pm+bounces-17345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD99C4893
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433D6B2FC0F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9001C3318;
	Mon, 11 Nov 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="q1RVt5c5"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8B1BF328;
	Mon, 11 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361216; cv=none; b=j1Vf3C29ph2GNMOrFrJoY6OBwb142fRP7hY8AMMBEHS5dj8jWNbQg9luBAk3Lorvdi9moqPZru1dJBkEpPcyn/7fjSgMeGvHOisNp2mJqUCmvajtMangj5zLrAUSvtHze9TVWLBUzRlPsW7eZS6j6XeVutbZn0AEWuW7Yj7G/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361216; c=relaxed/simple;
	bh=IK/x/Cq7ZA9U8RzTSdkN5gmLpQF3F49M1qwA6I2D3Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAZU9uhVuIAa/i0BQ+x44fBUeyIBk2B7wwHxp5tE1CenjL4gayV3pqzfZl7DLTyp/+N3QMfPclrdlDVfhLer1N2ZJy8vj5ZbJbsi4KCtubDXQ5QfJkuVtHaDN6d2LoKrBgYMroOTqFWL7bx3C3yiMk7zfu8QqB2xLVaBZqgjF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=q1RVt5c5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361209;
	bh=IK/x/Cq7ZA9U8RzTSdkN5gmLpQF3F49M1qwA6I2D3Ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q1RVt5c52o+1gNm1mnjwFrNl0iRlPy2NF6nGGOy7dth6Z5BkAm1JaxDgI3etvoA/H
	 yScw65Ec9aLPGAaAPRZeRedU0U1YHxYguipFFnqRh+d+xEh7V3Sa3DT5pbj11BW3iv
	 wvLx81i66POc6qLjqvQND97dPWrhVPEMqMvcxTOs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:07 +0100
Subject: [PATCH v4 5/9] power: supply: sysfs: prepare for power supply
 extensions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-5-7240144daa8e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=1743;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IK/x/Cq7ZA9U8RzTSdkN5gmLpQF3F49M1qwA6I2D3Ao=;
 b=OVmbweWyERIkD+3u/cQSsHiAvOSooJ6WsxKcE4WPWREU6O2jUviYpNAQsPOSciqiGJBS2HYWv
 ap6u6k8NtIwDEyFGLSmcgp6qAZ2iCL6hvv/fBayMuPV4A6LCxlfqFwL
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
 drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a7351b9c8fe34a464a4e69b1a1a4a4179c1a4b4f..bfe48fe01a8d03828c2e539e1e6e5e9fc5c60167 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -378,7 +378,6 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = dev_get_drvdata(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
-	int i;
 
 	if (!power_supply_attrs[attrno].prop_name)
 		return 0;
@@ -386,19 +385,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	for (i = 0; i < psy->desc->num_properties; i++) {
-		int property = psy->desc->properties[i];
-
-		if (property == attrno) {
-			if (power_supply_property_is_writeable(psy, property) > 0)
-				mode |= S_IWUSR;
-
-			return mode;
-		}
-	}
-
-	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
+	if (power_supply_has_property(psy, attrno)) {
+		if (power_supply_property_is_writeable(psy, attrno) > 0)
+			mode |= S_IWUSR;
 		return mode;
+	}
 
 	return 0;
 }

-- 
2.47.0


