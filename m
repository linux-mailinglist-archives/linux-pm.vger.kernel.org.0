Return-Path: <linux-pm+bounces-19520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F2C9F7D23
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EC17A210B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83211A23A1;
	Thu, 19 Dec 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QbV/Gz8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A8225765;
	Thu, 19 Dec 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618507; cv=none; b=GLdB23ppNw+HRRUdsETyAYCXCV4vTtnN6iHCF37MiXfWUIcWQmNGq8CBeYgPOG/5HQhQOsuxONsMgR6Clag5kcm9w1C+gpuNUiHKJjA77pHRbpAPh+zV6Ize5cNONcJM9/QgbwIbZQKvZNEfiT+yifaqdNeN1KRrj2lD90klfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618507; c=relaxed/simple;
	bh=dvN9fhb4siOHSRjPCMUKcDImjcClV2JlJx2H6MOGwag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DtSEV/Ds921geLHesox8yf7YQN2DFxoyHSdKM6J9z04bbiFi1ZoC/R9afj35jt0gLTU/k/Xc9xgv/wyzvVRRCF5pm5AtdMjEA3mIV7AlnNiuUC9vRauhiF9Syfzax3KQkfeVMNZK1/zMgbKVW8PjT87mlwrWAzVB1+nfSaT9cVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QbV/Gz8x; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734618501;
	bh=dvN9fhb4siOHSRjPCMUKcDImjcClV2JlJx2H6MOGwag=;
	h=From:Date:Subject:To:Cc:From;
	b=QbV/Gz8xhraavLuXZrbMwrjGACLGXCWcE66i41aoEKka2CmfM+gSq8qDkDgYyNT7A
	 asSYENm7X1aB7KEAmi9yrBzIiiLq+kSApijTCsGPx77KgMNG7dnXtISowu0j/fW74x
	 +yZGge+bMp05AruijVjqPJnlN9i0FbC0vWVbb7uw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 19 Dec 2024 15:28:18 +0100
Subject: [PATCH] power: supply: core: fix build of extension sysfs group if
 CONFIG_SYSFS=n
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241219-psy-extensions-sysfs-v1-1-868fc6cb46d6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIEtZGcC/x2MQQqAIBAAvxJ7biGlKPtKdIhaay8mbkQi/j3rO
 DAzCYQCk8BYJQh0s/DpCqi6gvVY3E7IW2HQjW6VVga9RKTnIveZghLFChpFtjFDN/RbByX1gSw
 //3aac34Bv5d3mmYAAAA=
X-Change-ID: 20241219-psy-extensions-sysfs-91ef098587d5
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734618500; l=5139;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dvN9fhb4siOHSRjPCMUKcDImjcClV2JlJx2H6MOGwag=;
 b=U5Um1x/Z94Sdj9ZwqkKeC64lpJcthhbNszBxdCGwr1WWeAtaEY+FtW2ZV7rML1E2yP6BJmuuE
 c4WG3CaDFDuByvyj9DpvXb/uCVqYdrfINqH8ilNUscseue5WmcaYBq+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add and use wrapper functions for the sysfs interaction.
Restore the compatibility of CONFIG_POWER_SUPPLY=y and CONFIG_SYSFS=n.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20241218195229.GA2796534@ax162/
Fixes: 288a2cabcf6b ("power: supply: core: add UAPI to discover currently used extensions")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Based on power-supply/for-next.
---
 drivers/power/supply/power_supply.h       | 12 +++++++++++-
 drivers/power/supply/power_supply_core.c  | 13 +++++--------
 drivers/power/supply/power_supply_sysfs.c | 15 ++++++++++++++-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 9ed749cd09369f0f13017847687509736b30aae8..8f6a2d44b996689b13e3ad4216e6f426d328b979 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -40,14 +40,24 @@ struct power_supply_ext_registration {
 
 extern void __init power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
-extern const struct attribute_group power_supply_extension_group;
 extern const struct attribute_group *power_supply_attr_groups[];
+extern int power_supply_sysfs_add_extension(struct power_supply *psy,
+					    const struct power_supply_ext *ext,
+					    struct device *dev);
+extern void power_supply_sysfs_remove_extension(struct power_supply *psy,
+						const struct power_supply_ext *ext);
 
 #else
 
 static inline void power_supply_init_attrs(void) {}
 #define power_supply_attr_groups NULL
 #define power_supply_uevent NULL
+static inline int power_supply_sysfs_add_extension(struct power_supply *psy,
+						   const struct power_supply_ext *ext,
+						   struct device *dev)
+{ return 0; }
+static inline void power_supply_sysfs_remove_extension(struct power_supply *psy,
+						       const struct power_supply_ext *ext) {}
 
 #endif /* CONFIG_SYSFS */
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 76ebaef403ed5cf0c00691dd9633bb12ce774fb1..eeeed1216e22595de75d1d2a482de4a5e6901773 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1386,10 +1386,9 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 	reg->data = data;
 	list_add(&reg->list_head, &psy->extensions);
 
-	ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
-				      &dev->kobj, ext->name);
+	ret = power_supply_sysfs_add_extension(psy, ext, dev);
 	if (ret)
-		goto sysfs_link_failed;
+		goto sysfs_add_failed;
 
 	ret = power_supply_update_sysfs_and_hwmon(psy);
 	if (ret)
@@ -1398,8 +1397,8 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 	return 0;
 
 sysfs_hwmon_failed:
-	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_group.name, ext->name);
-sysfs_link_failed:
+	power_supply_sysfs_remove_extension(psy, ext);
+sysfs_add_failed:
 	list_del(&reg->list_head);
 	kfree(reg);
 	return ret;
@@ -1415,9 +1414,7 @@ void power_supply_unregister_extension(struct power_supply *psy, const struct po
 	power_supply_for_each_extension(reg, psy) {
 		if (reg->ext == ext) {
 			list_del(&reg->list_head);
-			sysfs_remove_link_from_group(&psy->dev.kobj,
-						     power_supply_extension_group.name,
-						     reg->ext->name);
+			power_supply_sysfs_remove_extension(psy, ext);
 			kfree(reg);
 			power_supply_update_sysfs_and_hwmon(psy);
 			return;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 261bf7bf6e22e3e9ac49074662220ed8db4aa207..9ce5eda2409387cfb55fbeacab1ced7b5ba5ceba 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -462,7 +462,7 @@ static struct attribute *power_supply_extension_attrs[] = {
 	NULL
 };
 
-const struct attribute_group power_supply_extension_group = {
+static const struct attribute_group power_supply_extension_group = {
 	.name = "extensions",
 	.attrs = power_supply_extension_attrs,
 };
@@ -624,3 +624,16 @@ int power_supply_charge_types_parse(unsigned int available_types, const char *bu
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(power_supply_charge_types_parse);
+
+int power_supply_sysfs_add_extension(struct power_supply *psy, const struct power_supply_ext *ext,
+				     struct device *dev)
+{
+	return sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
+				       &dev->kobj, ext->name);
+}
+
+void power_supply_sysfs_remove_extension(struct power_supply *psy,
+					 const struct power_supply_ext *ext)
+{
+	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_group.name, ext->name);
+}

---
base-commit: 288a2cabcf6bb35532e8b2708829bdc2b85bc690
change-id: 20241219-psy-extensions-sysfs-91ef098587d5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


