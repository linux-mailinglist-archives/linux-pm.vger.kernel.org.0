Return-Path: <linux-pm+bounces-15828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC89A19C4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5571B24B68
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 04:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E3137C35;
	Thu, 17 Oct 2024 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="V4fh39g1"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA3224CC;
	Thu, 17 Oct 2024 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729139863; cv=none; b=ZdR1cDC09BkY9zxLHk7kKqCIh5crY3owaoT1GbagNSPh6Qmh4xrH6vG96EMCv9xCv2jsK+UWrBxYuOMGFh69dP378qY0PH5Xucv+UNNTvikQegpVIF1P6kf/B0WK9on2PzYre0XoCA8S/r2yQ4E5iAgRsmCpq5DnlFlpYnEJYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729139863; c=relaxed/simple;
	bh=YUHsD/lDDrgd9sojvlDxC4gFmKD8l2JFxw0dminrY/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G+UXDCmnSoeVoMNH1dYanZRlHI2qr/jBMwuTnrKa7lx5xYNFkTep4tTnkx995OtVTJIl7bS4Zh/4OSnw0C5e9kSnGkewqK2JacMBeyP/j4OTHHH3L2oYVs9eLAJC9WMLgCubfqDmhXpNE/2LzlImeLjbhKrocb9kZ7g7vCfcMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=V4fh39g1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1729139854;
	bh=YUHsD/lDDrgd9sojvlDxC4gFmKD8l2JFxw0dminrY/k=;
	h=From:Date:Subject:To:Cc:From;
	b=V4fh39g1i1JJlGF3c2n1Z9Q64U+JUwcQ4b+1hTP1FHviXagK4TZZSAXOxXV8E//JN
	 EvDOeerck1n4DTqTPDUgws5+Yvsux/8ht8froc2rXAiPkvcpD0empXPBE2SiROvSXZ
	 8sifVz/xSK61mNaPhIecIcYEk0QAYewInQxGvzIo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 17 Oct 2024 06:37:33 +0200
Subject: [PATCH v2] power: supply: hwmon: move interface to private header
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-power-supply-cleanups-v2-1-cb0f5deab088@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIyUEGcC/3WNywqDMBBFf0Vm3ZQkxopd+R/FhcaxGZAYMj4q4
 r83dd/lOXDPPYAxEjI8swMirsQ0+QT6loF1rX+joD4xaKmNrLQWYdowCl5CGHdhR2z9EliUFrv
 BPCpVFgbSNkQc6HN1X01iRzxPcb9uVvWzV1FJWfwprkpIYYpc5p3uZWv6ekNiZusWd/c4Q3Oe5
 xfrBuYNvwAAAA==
X-Change-ID: 20240922-power-supply-cleanups-7cebf4691754
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729139853; l=2536;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YUHsD/lDDrgd9sojvlDxC4gFmKD8l2JFxw0dminrY/k=;
 b=KZt2Uy6iPJo3pKM56wyEEPrC28xBiuqB0cF8mCq0Hk6i45FHad8R6EwKlNI6DCeipUbmH30uz
 mXTWhp6rET0DM+4rVQX/hnNhA1KfSgv9LYMtlP6SJpULSe6Twp6Y+Qf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The interface of power_supply_hwmon.c is only meant to be used by the
psy core. Remove it from the public header file and use the private one
instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Avoid duplicate #include "power_supply.h"
- Drop already applied patches
- Link to v1: https://lore.kernel.org/r/20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net
---
 drivers/power/supply/power_supply.h | 17 +++++++++++++++++
 include/linux/power_supply.h        | 13 -------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 4c558fb3db7211a610134960292790ea3584b363..7434a6f2477504ee6c0a3c7420e1444387b41180 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -44,3 +44,20 @@ static inline int power_supply_create_triggers(struct power_supply *psy)
 static inline void power_supply_remove_triggers(struct power_supply *psy) {}
 
 #endif /* CONFIG_LEDS_TRIGGERS */
+
+#ifdef CONFIG_POWER_SUPPLY_HWMON
+
+int power_supply_add_hwmon_sysfs(struct power_supply *psy);
+void power_supply_remove_hwmon_sysfs(struct power_supply *psy);
+
+#else
+
+static inline int power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	return 0;
+}
+
+static inline
+void power_supply_remove_hwmon_sysfs(struct power_supply *psy) {}
+
+#endif /* CONFIG_POWER_SUPPLY_HWMON */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c1d6cb7f4c40e7162948820e824db1ef6df9f315..b98106e1a90f34bce5129317a099f363248342b9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -937,19 +937,6 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
 	return false;
 }
 
-#ifdef CONFIG_POWER_SUPPLY_HWMON
-int power_supply_add_hwmon_sysfs(struct power_supply *psy);
-void power_supply_remove_hwmon_sysfs(struct power_supply *psy);
-#else
-static inline int power_supply_add_hwmon_sysfs(struct power_supply *psy)
-{
-	return 0;
-}
-
-static inline
-void power_supply_remove_hwmon_sysfs(struct power_supply *psy) {}
-#endif
-
 #ifdef CONFIG_SYSFS
 ssize_t power_supply_charge_behaviour_show(struct device *dev,
 					   unsigned int available_behaviours,

---
base-commit: 1e5335d00707220b46c28ab09cd09a1837b84978
change-id: 20240922-power-supply-cleanups-7cebf4691754

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


