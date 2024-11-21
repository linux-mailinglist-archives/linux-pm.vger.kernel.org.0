Return-Path: <linux-pm+bounces-17870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A49D519F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5142824AE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE151A3BDA;
	Thu, 21 Nov 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="t47zSLsQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100231A2C04;
	Thu, 21 Nov 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209792; cv=none; b=Mk1Hh3QmMsN6p6pgTXw0QhofSq5V39J9I64PxY/e7Dmw13MzENlLcAVMZ/hVQDR6rMsW0weUenxK8jiIHTjiK+shRLAa9Z8wTNQkIqu3xeMPqT3WTSLhXalghENDHXguo3nNZ6/+l9PCP0OG8lcJOJSPz66ul+LH7zd9LJgqGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209792; c=relaxed/simple;
	bh=Xew9c0dDpqjXgcxhawHekhslIQbl0YmHFio8y8/qqPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgQrQ6guQ1sOkG41FmAT8MFuMbWSDyqKlTkxfIBQxNAcV43Y70XPLrUUei3UNl2E1IjWmMXFGA8Ubd5Vsnb1Gjo+2YdAHj49snE7ILGV98M5G+8ZBlUNAo73Pvmfhc8bFvSn12QFJV5IkxDd5n5bRgDEDAFvgdvEe4uwCzS6SzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=t47zSLsQ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 470F52E096A9;
	Thu, 21 Nov 2024 19:23:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209788;
	bh=qGjHS8GQ4N3CJVQ4zNZrdwaBwtKD2iqsG4bJWaOXvl0=; h=From:To:Subject;
	b=t47zSLsQqqK0XuiT9GSfSTCmhFjdtjU7Ug6E1u4/k50n4tUITpIjWvFQyPsb09OkZ
	 kh1zM2Oj7eS9FBw3yBAcgE8lDVbE4zkSDmcTC7QKjcezjEOZVpONEGW1OF9TENzmDB
	 CLGRObLzDRAIwiRob2+jMeJYnCtVZ/Y56BphfWhY=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC 09/13] acpi/x86: s2idle: call Sleep Entry/Exit as part of
 callbacks
Date: Thu, 21 Nov 2024 18:22:34 +0100
Message-ID: <20241121172239.119590-10-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121172239.119590-1-lkml@antheas.dev>
References: <20241121172239.119590-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173220978571.7825.3175429476405251822@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Move the Sleep Entry/Exit notifications outside the suspend sequence,
with their own ACPI lock, as was done for Display On/Off.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 57 ++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 49dcbdea903a..bdc2cc8d4994 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -61,6 +61,7 @@ static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
 static bool lsp0_dsm_in_display_off;
+static bool lsp0_dsm_in_sleep;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -567,6 +568,48 @@ static int acpi_s2idle_display_off(void)
 	return 0;
 }
 
+static int acpi_s2idle_sleep_entry(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0 || lps0_dsm_func_mask_microsoft <= 0)
+		return 0;
+
+	if (WARN_ON(lsp0_dsm_in_sleep))
+		return -EINVAL;
+
+	lsp0_dsm_in_sleep = true;
+	acpi_scan_lock_acquire();
+
+	/* Modern Standby Sleep Entry */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
+static int acpi_s2idle_sleep_exit(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0 || lps0_dsm_func_mask_microsoft <= 0)
+		return 0;
+
+	if (WARN_ON(!lsp0_dsm_in_sleep))
+		return -EINVAL;
+
+	lsp0_dsm_in_sleep = false;
+	acpi_scan_lock_acquire();
+
+	/* Modern Standby Sleep Exit */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
 static int acpi_s2idle_display_on(void)
 {
 	if (!lps0_device_handle || sleep_no_lps0)
@@ -608,13 +651,9 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	}
 
 	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
@@ -659,17 +698,14 @@ void acpi_s2idle_restore_early(void)
 					ACPI_LPS0_EXIT,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	}
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.display_off = acpi_s2idle_display_off,
+	.sleep_entry = acpi_s2idle_sleep_entry,
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
@@ -678,6 +714,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.sleep_exit = acpi_s2idle_sleep_exit,
 	.display_on = acpi_s2idle_display_on,
 };
 
-- 
2.47.0


