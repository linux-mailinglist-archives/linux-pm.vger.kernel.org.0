Return-Path: <linux-pm+bounces-17868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EF9D519B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C511F2222C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD041AB6C0;
	Thu, 21 Nov 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FKI2hFuo"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0E1B0F2B;
	Thu, 21 Nov 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209785; cv=none; b=FE09ADVwra5UNAN9YPeVKdxdTm3wFD8IHzulcdwNYaQG0jWJ17Xl5cdIfev//JbHCdnLYQYK+PTj9wYnzskRkKHjaiLeS1LIg1MWcQGld+jRREIM6qSf0c9kgVzThtnP/dCIRLazidAArz6Swa4jtvtvFV2JJEQ2I/PfaYZ5L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209785; c=relaxed/simple;
	bh=TI9WUqJYccL+CwFDF1WKnHPI/ZVHxgkTkQ5fwWfGfNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INsoyXIPVw0vdPijlPJ8A6ZsEbWSztKeuoE4WpBxGIpnLcfmO+Q+y4bx27Z3u2Zym2YtfZTv5TUCTwg7YPda3eEvaCGiCAW6SWIk1B9pp4MtsxeVEd3gR7gA0sJmXOqboJrGLvPiLpUpjvzFBmmlg31uL56zMwSPqQnJp6YMdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FKI2hFuo; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 301052E0966E;
	Thu, 21 Nov 2024 19:22:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209781;
	bh=ciKMesMP9Mc1IdOCWc4ppsKpGwJlPYfRDo95aaXXzt4=; h=From:To:Subject;
	b=FKI2hFuoBYe4NdD4JqhxeV0tCjKnTThOqV+7FE+B+xeZTusiOjcSkPCT0kQAoOhjp
	 Umwj3OUKc85zGq7E0PifEkeWWyMu+CxfaCV/i6Y7UaE+rxxfAjZro7qVECCzKMYIiU
	 ZXS1EMM40U4hPZ0BcG3tCYICee/MyCUW9uRrcS54=
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
Subject: [RFC 07/13] acpi/x86: s2idle: call Display On/Off as part of
 callbacks
Date: Thu, 21 Nov 2024 18:22:32 +0100
Message-ID: <20241121172239.119590-8-lkml@antheas.dev>
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
 <173220978051.6005.3661749764522674078@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Move the Display On/Off notifications into dedicated callbacks that gate
the ACPI mutex, so they can be called outside of the suspend path.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 67 +++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7391f87f3aa0..8b39e3b12ec0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -60,6 +60,7 @@ static int lps0_dsm_func_mask;
 static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
+static bool lsp0_dsm_in_display_off;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -539,17 +540,18 @@ static struct acpi_scan_handler lps0_handler = {
 	.attach = lps0_device_attach,
 };
 
-int acpi_s2idle_prepare_late(void)
+static int acpi_s2idle_display_off(void)
 {
-	struct acpi_s2idle_dev_ops *handler;
-
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
+	if (WARN_ON(lsp0_dsm_in_display_off))
+		return -EINVAL;
+
+	lsp0_dsm_in_display_off = true;
+	acpi_scan_lock_acquire();
 
-	/* Screen off */
+	/* Display off */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
 					ACPI_LPS0_DISPLAY_OFF_AMD :
@@ -560,6 +562,47 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
+static int acpi_s2idle_display_on(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (WARN_ON(!lsp0_dsm_in_display_off))
+		return -EINVAL;
+
+	lsp0_dsm_in_display_off = false;
+	acpi_scan_lock_acquire();
+
+	/* Display on */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_DISPLAY_ON_AMD :
+					ACPI_LPS0_DISPLAY_ON,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
+int acpi_s2idle_prepare_late(void)
+{
+	struct acpi_s2idle_dev_ops *handler;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (pm_debug_messages_on)
+		lpi_check_constraints();
+
 	/* LPS0 entry */
 	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
@@ -623,19 +666,10 @@ void acpi_s2idle_restore_early(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
-
-	/* Screen on */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-						ACPI_LPS0_DISPLAY_ON_AMD :
-						ACPI_LPS0_DISPLAY_ON,
-					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
+	.display_off = acpi_s2idle_display_off,
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
@@ -644,6 +678,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.display_on = acpi_s2idle_display_on,
 };
 
 void __init acpi_s2idle_setup(void)
-- 
2.47.0


