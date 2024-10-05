Return-Path: <linux-pm+bounces-15207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0BC9915D7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBFB283190
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9F14F11E;
	Sat,  5 Oct 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hlwLF6jW"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12A136349;
	Sat,  5 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122794; cv=none; b=HmevpeV1wbwnNQpUM7iwmwUsEtWgjZbwFpwGCyZ2c0/4MGnSnn1/GsbYkxFHKukBxrEFLIpxNvpAJSzWhThz7p0FfPMcYlbyXIgzEO+naxOQrGVRVxjg6c2UGF0WAh4WkjlmzVn/IlDeel19nZEG/GIRMZ8wVWzal1eE8ZswLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122794; c=relaxed/simple;
	bh=bp8YF7paCLm/RvDn/3zn9PMgwl2X0VG26YtAWU1mujA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RABPJ3031J2X/4y5f5hglXdj6oR/xK309CsV3FYHGYzFcwB1qDLFzeD2PGo7bzYuc62G7U8Kx/RctrMr+5qO+1BWbVh4X7BT2rGpC8jCh9Y2CXdC+PdaD2nblgjjmAD1ETbEt7/+V9JPfXJWnNyRNvxhk5ME+aFp8Qdn+WAGK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hlwLF6jW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122791;
	bh=bp8YF7paCLm/RvDn/3zn9PMgwl2X0VG26YtAWU1mujA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hlwLF6jWQlw4oV3ojO3Xn8/kjOpAucA3XhZ1dpgkV2Wu9c0EJ/QDyAcghHeliHVFo
	 81zgu2JFqh11fKzAfDLozLQ6lKbWib5YHcYhNlAAIDmy6IVUnCEMwUaCB/vrMyY7pK
	 fLOl6zjbI5FgOdKo16ccoJgvjD4md8JQZZ07qzgo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:06:18 +0200
Subject: [PATCH 4/4] power: supply: hwmon: move interface to private header
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-cleanups-v1-4-45303b2d0a4d@weissschuh.net>
References: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
In-Reply-To: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122791; l=2714;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bp8YF7paCLm/RvDn/3zn9PMgwl2X0VG26YtAWU1mujA=;
 b=48AkzMo+dKj7vs/k8ZubFmHBHA1FfhdCzmZr2McYD7vhswHU07iIm+E/rCjGtK3+hoz39uH/J
 PltiCQNeQB0DX0IPG6cljtsPNP5QaiN3uu8QVxZirsYJKBYNcTXEjOw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The interface of power_supply_hwmon.c is only meant to be used by the
psy core. Remove it from the public header file and use the private one
instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       | 17 +++++++++++++++++
 drivers/power/supply/power_supply_hwmon.c |  2 ++
 include/linux/power_supply.h              | 13 -------------
 3 files changed, 19 insertions(+), 13 deletions(-)

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
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 01be04903d7d2465ae2acb9eeb0b55a87868bb87..9b30175ba9aefb0ebc0fbe73fdd158fcefc3bdda 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -9,6 +9,8 @@
 #include <linux/slab.h>
 #include "power_supply.h"
 
+#include "power_supply.h"
+
 struct power_supply_hwmon {
 	struct power_supply *psy;
 	unsigned long *props;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ea0ba149f296644bd18717d91f338172602eb6d6..58264343fb8a1590d02ec18a2d7fe9d874e3bc31 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -943,19 +943,6 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
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

-- 
2.46.2


