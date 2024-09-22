Return-Path: <linux-pm+bounces-14539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9070F97E2BC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE1F1C20F17
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF639FFE;
	Sun, 22 Sep 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="zh2atIWe"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7E2B9A1;
	Sun, 22 Sep 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025875; cv=none; b=AvWuoV5ec0V8FIjUgZvkbJi/Hs0FCqGrwoy5KXqx8Ooz7f4i0L8wHS5r+0jLA4Ui7xpl9gpiykFVoSWEMOhHLHBVy5FdPLqBnDRs4U42qDPaeI3/oiUJmPQNIijHzIjr+YAgj4/gY6yXYdgsMlqY8IAMzfCBZvs6bajZ4sbTZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025875; c=relaxed/simple;
	bh=hdYiVrfxrtBaACQtrGawG/G1F0oam/9gpUa3/Msk+H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U16itiI5ygSpZzy9ir0UjgyFCNteS8MB8HB2EQifYIaBVe9jbCWYb2mbnH+P9ozGFRHLNMqFiz4LZjc87GhhxTMyfixcjAG6netXLB8S7ln5cLwQ1WOj/A+gV2QE9WwI8j+q5+LRuZnaoLmMaWsLCqdjXXqXtF3H3j1YHmUi+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=zh2atIWe; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id E77A92E09702;
	Sun, 22 Sep 2024 20:24:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727025870;
	bh=WEaCrXuILAhyNJftzE1NUauNPw6HjX292SCxgFJUUak=; h=From:To:Subject;
	b=zh2atIWeZA6zALTnAcOlW/zp2ddwYpX6n4TwWGvH9Z9mQHzRtahOJmTaLy+fut9IX
	 j72TAqb/2PNF9FiqHGEZMFNQTvGNeWMh2L/paFr5m3hZctk0LjLWTeMNdOs1kN/wRz
	 p1LHXDCCZxD2pUuKbQ1FsZ4axLeTQzDTn2CG6LgU=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	luke@ljones.dev,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 4/5] acpi/x86: s2idle: call Display On/Off as part of
 callbacks and rename
Date: Sun, 22 Sep 2024 19:22:57 +0200
Message-ID: <20240922172258.48435-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240922172258.48435-1-lkml@antheas.dev>
References: <20240922172258.48435-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172702587079.19655.3616447128571825577@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Move the Display On/Off notifications into dedicated callbacks that gate
the ACPI mutex, so they can be called outside of the suspend path.
This fixes issues on certain devices that expect kernel drivers to be
fully active during the calls, and allows for the flexibility of calling
them as part of a more elaborate userspace suspend sequence (such as
with "Screen Off" in Windows Modern Standby).

In addition, rename the notifications from "screen_" to "display_", as
there is no documentation referring to them as screen, either by
Intel or Microsoft.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 89 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index dd0b40b9bbe8..a17e28b91326 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -39,8 +39,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
 #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
-#define ACPI_LPS0_SCREEN_OFF	3
-#define ACPI_LPS0_SCREEN_ON	4
+#define ACPI_LPS0_DISPLAY_OFF	3
+#define ACPI_LPS0_DISPLAY_ON	4
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
 #define ACPI_LPS0_MS_ENTRY      7
@@ -50,8 +50,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
 #define ACPI_LPS0_ENTRY_AMD         2
 #define ACPI_LPS0_EXIT_AMD          3
-#define ACPI_LPS0_SCREEN_OFF_AMD    4
-#define ACPI_LPS0_SCREEN_ON_AMD     5
+#define ACPI_LPS0_DISPLAY_OFF_AMD   4
+#define ACPI_LPS0_DISPLAY_ON_AMD    5
 
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
@@ -60,6 +60,7 @@ static int lps0_dsm_func_mask;
 static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
+static bool lsp0_dsm_in_display_off;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -361,9 +362,9 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 {
 	if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_OFF:
+		case ACPI_LPS0_DISPLAY_OFF:
 			return "screen off";
-		case ACPI_LPS0_SCREEN_ON:
+		case ACPI_LPS0_DISPLAY_ON:
 			return "screen on";
 		case ACPI_LPS0_ENTRY:
 			return "lps0 entry";
@@ -376,9 +377,9 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 		}
 	} else {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_ON_AMD:
+		case ACPI_LPS0_DISPLAY_ON_AMD:
 			return "screen on";
-		case ACPI_LPS0_SCREEN_OFF_AMD:
+		case ACPI_LPS0_DISPLAY_OFF_AMD:
 			return "screen off";
 		case ACPI_LPS0_ENTRY_AMD:
 			return "lps0 entry";
@@ -539,27 +540,69 @@ static struct acpi_scan_handler lps0_handler = {
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
+	if (unlikely(WARN_ON(lsp0_dsm_in_display_off)))
+		return -EINVAL;
+
+	lsp0_dsm_in_display_off = true;
+	acpi_scan_lock_acquire();
 
-	/* Screen off */
+	/* Display off */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_OFF_AMD :
-					ACPI_LPS0_SCREEN_OFF,
+					ACPI_LPS0_DISPLAY_OFF_AMD :
+					ACPI_LPS0_DISPLAY_OFF,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
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
+	if (unlikely(WARN_ON(!lsp0_dsm_in_display_off)))
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
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_ON_AMD :
-					ACPI_LPS0_SCREEN_ON,
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
2.46.1


