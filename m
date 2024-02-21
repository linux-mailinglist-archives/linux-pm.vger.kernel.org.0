Return-Path: <linux-pm+bounces-4204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843D85E4DB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5DB22AA1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169483CDB;
	Wed, 21 Feb 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="i5NBYVK8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65F83CCC
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537584; cv=none; b=T1HH2lsrN5aAYRgj63qroRH6AL61yr6vvcJPCodSlspt69fIx/L0eH1dAFwaJqPjpJ9NSryK1Mg+Q1Ii3XIyuHAXPaq2YM+bsWB2OJ95WCRNsWHE2voHacGkgOBF9GZfZkxKjnPRAulL1wnjKcb/6VxeYdUoNfx2Iv/lYofBTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537584; c=relaxed/simple;
	bh=KkqUbvzPYYth3SxM0r3QYQIpl9bISqSyQeqsj9hxl4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COBzhnsmBD7XrD7GpVip1BuaHNaB/t7yF/8Viymbl6afUKBLEwfx56LEraIxYxYDbG3f5ydSpLNTZhMi5Hsrd7YW4LE3JIopCkFo2kKdhj5OVsYfGlIne2GC2XlL4DaHTCFgQN4qm0EKqEABf8T/8zniLF+iybGpWoC4p1XdPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=i5NBYVK8; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240221174617ff83f1eedd27a99406
        for <linux-pm@vger.kernel.org>;
        Wed, 21 Feb 2024 18:46:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mKsBfKzbS6MQdlGwzOPn+j3onsmhYJkKuuKue8WTjX0=;
 b=i5NBYVK815X3qgokYN5At6yAlMWY0QXGzxusIZKPKlHzg2DxypD4P2LqqpaIBX7C3fpxLH
 hFVrUs50RnANhG0Hlu8Qv0OjN12Xwq+ZfVFQDVVPj9GmfhdnnSUgBeM70xA3OVkSKjg3c1dN
 xZTG+zDgSG6uAk/TaNGLx624vbyow=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-pm@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] power: reset: restart-poweroff: convert to module
Date: Wed, 21 Feb 2024 18:46:07 +0100
Message-ID: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The necessity of having a fake platform device for a generic, platform
independent functionality is not obvious.
Some platforms requre device tree modification for this, some would require
ACPI tables modification, while functionality may be useful even to
end-users without required expertise. Convert the platform driver to
a simple module.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
This RFC is merely to understand if this approach would be accepted.
Converting to "tristate" could follow or preceed this patch.

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index 28f1822db1626..e1d94109f6823 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -20,7 +20,7 @@ static void restart_poweroff_do_poweroff(void)
 	machine_restart(NULL);
 }
 
-static int restart_poweroff_probe(struct platform_device *pdev)
+static int __init restart_poweroff_init(void)
 {
 	/* If a pm_power_off function has already been added, leave it alone */
 	if (pm_power_off != NULL) {
@@ -33,12 +33,10 @@ static int restart_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int restart_poweroff_remove(struct platform_device *pdev)
+static void __exit restart_poweroff_exit(void)
 {
 	if (pm_power_off == &restart_poweroff_do_poweroff)
 		pm_power_off = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id of_restart_poweroff_match[] = {
@@ -47,15 +45,8 @@ static const struct of_device_id of_restart_poweroff_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
 
-static struct platform_driver restart_poweroff_driver = {
-	.probe = restart_poweroff_probe,
-	.remove = restart_poweroff_remove,
-	.driver = {
-		.name = "poweroff-restart",
-		.of_match_table = of_restart_poweroff_match,
-	},
-};
-module_platform_driver(restart_poweroff_driver);
+module_init(restart_poweroff_init);
+module_exit(restart_poweroff_exit);
 
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
 MODULE_DESCRIPTION("restart poweroff driver");
-- 
2.43.0


