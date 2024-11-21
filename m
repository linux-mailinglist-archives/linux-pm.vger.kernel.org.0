Return-Path: <linux-pm+bounces-17871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285189D51A1
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BC01F2220D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653D1AAE13;
	Thu, 21 Nov 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="lvi8NWAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E961A7AF5;
	Thu, 21 Nov 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209794; cv=none; b=qIkwrQ2349VoihstjnztsTk4tFCCWcIZxmzj0Cl4PtC2bsOgtKfZ/MginhQY/DWtzsE5ft8xYI4S16juhIEyeXCQ2GPnFAnJ0qtQSqun3zPM0Zv1VP8wX2pjfIt1I0fupVwPfDZtLkDjVqycyapgpcd55czn3/Ti7O31XpRe2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209794; c=relaxed/simple;
	bh=PxZp/4k4T+44Ijn+2G8Xbmo2HDgH31bONasYyUJFSfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKUUKo7t0LEU0e0tFNb1y47gIgBhB5mYbiJGGfdaijD8+fXFuu8yNvprxoTTiBmx5N5ij9676hU1jiE1xLApHy5/81NzZksPmpmAf1Ig2AYCqpD+G8EOelcHCYqhrUfKnxsEaTLTMtjXceb7bbOfGaZS6TuAse8JvescUBF6Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=lvi8NWAr; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0F1152E0952F;
	Thu, 21 Nov 2024 19:23:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209791;
	bh=md6zaJta8omWGAdQeUBLLs46yHXPjdxLdPWorE9Bt7o=; h=From:To:Subject;
	b=lvi8NWArex8mogvPYZwjq7HnYAXitC8yxOhHcfQRD2ifF79HVpyy8g+xDQqkRIMll
	 RtRM3KxAFksXLnCiQLP7P3bv5SS5hfHhNWFRifO/57XNG7JrBlDKSDUWiU/J+HtQH9
	 ghJZvehM74sRU2wE5lMiENmFtnuCQ/nZGkrm79Jg=
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
Subject: [RFC 10/13] acpi/x86: s2idle: add Turn On Display and call as part of
 callback
Date: Thu, 21 Nov 2024 18:22:35 +0100
Message-ID: <20241121172239.119590-11-lkml@antheas.dev>
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
 <173220979049.9411.6636007944859871917@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Turn On Display callback was introduced in Windows 22H2, to allow
devices to resume faster from sleep. Essentially, if the device lowers
its power limit (PLx) while it is in the Sleep state, this might lengthen
the suspend sequence in an undesirable manner. Implement this callback,
which corresponds to Modern Standby Firmware notification (_DSM) 9.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index bdc2cc8d4994..d389c57d2963 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_EXIT		6
 #define ACPI_LPS0_SLEEP_ENTRY      7
 #define ACPI_LPS0_SLEEP_EXIT       8
+#define ACPI_LPS0_TURN_ON_DISPLAY  9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -375,6 +376,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "sleep entry";
 		case ACPI_LPS0_SLEEP_EXIT:
 			return "sleep exit";
+		case ACPI_LPS0_TURN_ON_DISPLAY:
+			return "turn on display";
 		}
 	} else {
 		switch (state) {
@@ -589,6 +592,29 @@ static int acpi_s2idle_sleep_entry(void)
 	return 0;
 }
 
+static int acpi_s2idle_turn_on_display(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0 ||
+	    lps0_dsm_func_mask_microsoft <= 0)
+		return 0;
+
+	/* This call is only valid while we are in a sleep state */
+	if (WARN_ON(!lsp0_dsm_in_sleep))
+		return -EINVAL;
+
+	acpi_scan_lock_acquire();
+
+	/* Modern Standby Turn On Display */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+
+	acpi_scan_lock_release();
+
+	return 0;
+}
+
 static int acpi_s2idle_sleep_exit(void)
 {
 	if (!lps0_device_handle || sleep_no_lps0 || lps0_dsm_func_mask_microsoft <= 0)
@@ -714,6 +740,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
+	.turn_on_display = acpi_s2idle_turn_on_display,
 	.sleep_exit = acpi_s2idle_sleep_exit,
 	.display_on = acpi_s2idle_display_on,
 };
-- 
2.47.0


