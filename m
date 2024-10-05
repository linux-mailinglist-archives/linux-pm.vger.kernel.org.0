Return-Path: <linux-pm+bounces-15205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5449915D4
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83A5284A43
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D514D6EB;
	Sat,  5 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Rj7m4jmi"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017D14C5AE;
	Sat,  5 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122794; cv=none; b=awEWZifOAqx6rwuIY1Jqy+Hs18UhxxfcHKl5BEzhaFBW6yj6/nUUQS1u8osnu7pv8xHcwteWePd9cyO9I4pCQdY2AuKSbhFi1a2sz815r/f4c6eDWQFm8znKCh2Y/IlBTMvcb1ihXxTF89VL+VpUoAMkXCHx+ipxNusHgiesiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122794; c=relaxed/simple;
	bh=cVeJsyW6U2wZJ6iC3eZHoUXaNynzQYlamOESFTS23GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0v9woHx/B9ic8vWgxQJkg+eQudQkkJrMv7wbUGVQafqcoW9S3iM9pZqH8X1752sRR04sdoefRA2mgUjEnGnz/Jpesf5NfrwWWGDIjXzvMfWN8gV3DyknxRdE1cdze8e4B0oiidzdlpnunafngzBrYMY3kOVj2Y2/WnQjX1o4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Rj7m4jmi; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122791;
	bh=cVeJsyW6U2wZJ6iC3eZHoUXaNynzQYlamOESFTS23GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rj7m4jmislF/SBdurxFNvhaTC+uSfBTDDziJi43AC446/0IAvsKZYr5p/yXpKcmfF
	 I7P6FhkoWYzA5IrwTXbHQdtwHqVJYKC/iXXIwdilx6I/NPd/kkDUlLvoFHdnfPqfr1
	 JfAq7Vl26caRbj6DzLKJGBqTPk4WbfWxtmSM0L04=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:06:17 +0200
Subject: [PATCH 3/4] power: supply: core: mark attribute arrays as
 ro_after_init
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-cleanups-v1-3-45303b2d0a4d@weissschuh.net>
References: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
In-Reply-To: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122791; l=3387;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cVeJsyW6U2wZJ6iC3eZHoUXaNynzQYlamOESFTS23GI=;
 b=24viEx2PtK/jahp7sIGwnohJclF/Xq5E2PE1rJsfaqUF7sSYUZbAkq7EjMUgNQbNixmGiH+GY
 TiQdpwIw8NhD1t5YVN2g3tsbtM33exykL3gr3mfBiuwlv+7PUNb7kt4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute arrays are only modified during the __init phase.
To protect them against intentional or accidental modification,
mark them as __ro_after_init.

To make sure no modifications are introduced, also mark the return
values of the accessors as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  2 +-
 drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 1bc57615ba68fb33e5b77f720e454dbba6daa291..4c558fb3db7211a610134960292790ea3584b363 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -18,7 +18,7 @@ extern int power_supply_property_is_writeable(struct power_supply *psy,
 
 #ifdef CONFIG_SYSFS
 
-extern void power_supply_init_attrs(void);
+extern void __init power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern const struct attribute_group *power_supply_attr_groups[];
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 16b3c5880cd8ce14cd7c697b11fcf5449b65c2d6..571de43fcca9827cf0fe3023e453defbf1eaec7d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -142,7 +142,7 @@ static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
 };
 
-static struct power_supply_attr power_supply_attrs[] = {
+static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	/* Properties of type `int' */
 	POWER_SUPPLY_ENUM_ATTR(STATUS),
 	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
@@ -225,9 +225,9 @@ static struct power_supply_attr power_supply_attrs[] = {
 #define POWER_SUPPLY_ATTR_CNT ARRAY_SIZE(power_supply_attrs)
 
 static struct attribute *
-__power_supply_attrs[POWER_SUPPLY_ATTR_CNT + 1];
+__power_supply_attrs[POWER_SUPPLY_ATTR_CNT + 1] __ro_after_init;
 
-static struct power_supply_attr *to_ps_attr(struct device_attribute *attr)
+static const struct power_supply_attr *to_ps_attr(struct device_attribute *attr)
 {
 	return container_of(attr, struct power_supply_attr, dev_attr);
 }
@@ -273,7 +273,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 					  char *buf) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct power_supply_attr *ps_attr = to_ps_attr(attr);
+	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
@@ -326,7 +326,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 					   const char *buf, size_t count) {
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct power_supply_attr *ps_attr = to_ps_attr(attr);
+	const struct power_supply_attr *ps_attr = to_ps_attr(attr);
 	enum power_supply_property psp = dev_attr_psp(attr);
 	union power_supply_propval value;
 
@@ -401,7 +401,7 @@ const struct attribute_group *power_supply_attr_groups[] = {
 	NULL
 };
 
-void power_supply_init_attrs(void)
+void __init power_supply_init_attrs(void)
 {
 	int i;
 

-- 
2.46.2


