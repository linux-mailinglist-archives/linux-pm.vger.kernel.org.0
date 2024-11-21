Return-Path: <linux-pm+bounces-17862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072F9D50BC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43D1B23C79
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0832198A2F;
	Thu, 21 Nov 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bSRtOj/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7871990AB;
	Thu, 21 Nov 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206583; cv=none; b=P6/+VVknol5VggbIuEq3WWyrAIDxOfzwvAhNPCZqJOT8L6zI6F7zSk41CVgzRK0uzJm1+zlMCHh8Om2SpiXgeIXZcVY4JP/jPo+F9ffxRSIIrxoIo/aRBZZcdrnsRIXs+7qcyXzMjS/28Xp4I7pCOmtzMoYTyw9FejbY7F2XDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206583; c=relaxed/simple;
	bh=KBlm+PY8r6pCW0H54X1PIOvoepWbroSKAgUlxr1PlLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hm+pZ5GOLSHfarVxm3MKi1Z/4kqoEcOeBOkLt/XRzzsGKhw3brw2xhpAbTjDtghNK82g9xYimxihMMoWSTvsKnEeh5K8svCMmhb1vaCYyhIsSbdPrytSTROrDCPXR51Kh9sTXyaJ5+o/Xg+x724lSpShg4SX5CzC9ws52fcBioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bSRtOj/3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732206574;
	bh=KBlm+PY8r6pCW0H54X1PIOvoepWbroSKAgUlxr1PlLw=;
	h=From:Date:Subject:To:Cc:From;
	b=bSRtOj/3/agJoi4hjXbx60+K1pIb1sdpvfPwJZGcyuAOis8Hqlf2GaNywvgTTJ6zh
	 3MVimqRcfKqdsihqSExQR8mmuSsbZt+Gf9+d3nauxtVtDpyH4JfIkb8OXXj69nO4MX
	 yjOwu7z7qILtZ9waQ4SH2H+3X0ywLB/vCsOw0rm0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Nov 2024 17:29:32 +0100
Subject: [PATCH] thermal: int3400: Remove unneeded data_vault
 attribute_group
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241121-sysfs-const-bin_attr-int340x_thermal-v1-1-2436facf9dae@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOtfP2cC/x3N0QrCMAxA0V8ZeTbQ1k3RXxEZtaYuoJkkQSZj/
 27x8bzcu4KRMhmcuxWUPmw8S0PcdVCmLA9CvjdDCqmPMUW0r1XDMos53ljG7K7I4vs+LKNPpK/
 8xHo6hDykUuJwhJZ6K1Ve/pvLddt+GbnWAnYAAAA=
X-Change-ID: 20241121-sysfs-const-bin_attr-int340x_thermal-f960a52cc157
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732206574; l=2881;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KBlm+PY8r6pCW0H54X1PIOvoepWbroSKAgUlxr1PlLw=;
 b=ufRGddApucFjv7bKF8DyZwI8R+KTQrRxY6Lp7EsxgQtFQ20d+RcVf11iHqho25FppYwAOZZSS
 z7yS+PgY/DZBF7Uu/Vy8t8d3hUe5TJCRn04h4yq6NrT0ICLRbFxW1bk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The group only contains a single entry and the conditionals around its
lifecycle make clear that this won't change.
Remove the unnecessary group.

This saves some memory and it's easier to read.
The removal of a non-const bin_attribute[] instance is also a
preparation for the constification of struct bin_attributes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index b0c0f0ffdcb046607b4478390f39a77ae316a511..558a08f1727fc48c37181f8d345e236f879dab27 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -75,11 +75,6 @@ struct odvp_attr {
 
 static BIN_ATTR_SIMPLE_RO(data_vault);
 
-static struct bin_attribute *data_attributes[] = {
-	&bin_attr_data_vault,
-	NULL,
-};
-
 static ssize_t imok_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
@@ -108,10 +103,6 @@ static const struct attribute_group imok_attribute_group = {
 	.attrs = imok_attr,
 };
 
-static const struct attribute_group data_attribute_group = {
-	.bin_attrs = data_attributes,
-};
-
 static ssize_t available_uuids_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -624,8 +615,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	}
 
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
-		result = sysfs_create_group(&pdev->dev.kobj,
-					    &data_attribute_group);
+		result = device_create_bin_file(&pdev->dev, &bin_attr_data_vault);
 		if (result)
 			goto free_uuid;
 	}
@@ -648,7 +638,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_sysfs:
 	cleanup_odvp(priv);
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
-		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
 		kfree(priv->data_vault);
 	}
 free_uuid:
@@ -683,7 +673,7 @@ static void int3400_thermal_remove(struct platform_device *pdev)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
 	if (!ZERO_OR_NULL_PTR(priv->data_vault))
-		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);

---
base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
change-id: 20241121-sysfs-const-bin_attr-int340x_thermal-f960a52cc157

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


