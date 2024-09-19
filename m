Return-Path: <linux-pm+bounces-14478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3797CCF9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372BC1F22C14
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4831A08C2;
	Thu, 19 Sep 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="rm/XBKOQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACE1EB56;
	Thu, 19 Sep 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766431; cv=none; b=m5Vw0lj3pMX7xbI0s2yPJCLJT6ndZSMGA/orXcVHJ3+AL3zbD58O7gHgd88u9UuWviS8VxnDF4UMsAmZaoKLbLRbDKR6GkcTpOL77IDL0NKeVdg6giShyqEAZCyijSybzWj9IzqxARrev8y0YMB8NimoAj+8aev7qX81yoaTs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766431; c=relaxed/simple;
	bh=gkjVQ81/OGWaa+G/4QS8wPf4pkOCPqgYyM08k9Kjz1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRbWkXpAZQBubwrpfs0wSnENd+P6XhSmLjQ+UEdKrA9aarW6LMKOeQjtA48Gk7mfW5xEJVhdWp5FYmfkauqiSlxPpvCekR1ph2QmJexXkTNttBFQ+mOVgi3qHnbKRGIlWBlSGVPAUjfTg2Hc/BqcQHpbZ6A/ibuvKptDFvbYZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=rm/XBKOQ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:6813:1156:549c:fa23])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 13E0E2E09C11;
	Thu, 19 Sep 2024 20:20:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726766424;
	bh=sTJcvD3ghjMAZI0q0CaO0A3NL6Fe4Q6twf2MptYvw7k=; h=From:To:Subject;
	b=rm/XBKOQzXjZSjHc53q4iBIVPrJEKlSjCkuIKERdmq2ESyh9pFv/gRMAl0MSZ7OSE
	 tsOtfWuCS3LlZihN/Uci8xG13HN7/MlXAasAyAKyLTmMWPSH1cWa5ylkYjffLWufJG
	 YYrV+pQwScM5kwOD3G9QsdbAWGRRo+nW4OYByrag=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:6813:1156:549c:fa23) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario.Limonciello@amd.com,
	luke@ljones.dev,
	me@kylegospodneti.ch
Subject: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part of
 callbacks
Date: Thu, 19 Sep 2024 19:19:51 +0200
Message-ID: <20240919171952.403745-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919171952.403745-1-lkml@antheas.dev>
References: <20240919171952.403745-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172676642290.26992.10738575555388669892@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Move the screen on and off calls into dedicated callbacks that gate
the ACPI mutex, so they can be called outside of the suspend path.
This fixes issues on certain devices that expect kernel drivers to be
fully active during the calls, and allows for the flexibility of calling
them as part of a more elaborate userspace suspend sequence (such as
with "Screen Off" in Windows Modern Standby).

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 72 +++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index dd0b40b9bbe8..aa448ed58077 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -60,6 +60,7 @@ static int lps0_dsm_func_mask;
 static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
+static bool lsp0_dsm_in_screen_off;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -539,15 +540,19 @@ static struct acpi_scan_handler lps0_handler = {
 	.attach = lps0_device_attach,
 };
 
-int acpi_s2idle_prepare_late(void)
+static int acpi_s2idle_screen_off(void)
 {
-	struct acpi_s2idle_dev_ops *handler;
-
 	if (!lps0_device_handle || sleep_no_lps0)
 		return 0;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
+	if (lsp0_dsm_in_screen_off) {
+		acpi_handle_info(lps0_device_handle,
+				"called screen off call twice before calling screen on.\n");
+		// fallthrough for debugging, calling twice should be gated by the caller
+	}
+
+	lsp0_dsm_in_screen_off = true;
+	acpi_scan_lock_acquire();
 
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
@@ -560,6 +565,50 @@ int acpi_s2idle_prepare_late(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
+static int acpi_s2idle_screen_on(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (!lsp0_dsm_in_screen_off) {
+		acpi_handle_info(lps0_device_handle,
+				"called screen on before calling screen off.\n");
+		// fallthrough for debugging, calling twice should be gated by the caller
+	}
+
+	lsp0_dsm_in_screen_off = false;
+	acpi_scan_lock_acquire();
+
+	/* Screen on */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_SCREEN_ON_AMD :
+					ACPI_LPS0_SCREEN_ON,
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
@@ -623,19 +672,10 @@ void acpi_s2idle_restore_early(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
-
-	/* Screen on */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_ON_AMD :
-					ACPI_LPS0_SCREEN_ON,
-					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
+	.screen_off = acpi_s2idle_screen_off,
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
@@ -644,10 +684,12 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.screen_on = acpi_s2idle_screen_on,
 };
 
 void __init acpi_s2idle_setup(void)
 {
+	lsp0_dsm_in_screen_off = false;
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.46.1


