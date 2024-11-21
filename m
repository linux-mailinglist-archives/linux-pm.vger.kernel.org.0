Return-Path: <linux-pm+bounces-17869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5749D519E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D7BB248BB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956419F485;
	Thu, 21 Nov 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="SaEUrQ6Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243019F11E;
	Thu, 21 Nov 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209788; cv=none; b=bUCIw7FVXJHRPVomFfvXIieH367L2feOs2GIypk2J0lOZ0dOc6ir4/16BFEmjTy9vw7eo7hFmDpeTzjFFjDMofOdOyzl6Uv1E89ZuFEs4v9apN+ubKKvZvej/s5Ah7gsZZR4RTQ7fudDoyU7Q0Kz0RpLt9ivGVRduFxHpL1HNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209788; c=relaxed/simple;
	bh=BkOA/GRmBCWnWuabveATfHDpVyizVo74Yz0FbHCKvg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDuBp5htY4OqlPjMQQFULGQWEXqcQNntK2RdZN9659U4kLxt5QhFrEjNWK+++1n7yJYu0OfEhyt+4xT1ONptO2uIk2vz+0NCBla/t0Yih1S5UmI4TvKp4ICMbPaMjeRaucs+Cd4ItfTapkc5OYvtnUq6wBwZ8iAqJBjIrO9Dmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=SaEUrQ6Z; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9893F2E09694;
	Thu, 21 Nov 2024 19:23:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209783;
	bh=++PgO6Kf7fkqqQwS6ej9C+2J5H1QoRjUhk8jT24SeC4=; h=From:To:Subject;
	b=SaEUrQ6ZP4g3tPbHCR0lsNIrNUry5Nwj6a42MeUZPaXjHKivRFFRv88E8q+BaoP17
	 Ggb8H8Ze3xvEe6KOnRyp/TC76KYEboar5/UmtvjUWDaf26kgBf+hkU6ZP9xe/8YVYr
	 LVKailruCXEP8PmgmtbdkTodaUzLU4zDPioFgYo0=
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
Subject: [RFC 08/13] acpi/x86: s2idle: rename MS Exit/Entry to Sleep
 Exit/Entry
Date: Thu, 21 Nov 2024 18:22:33 +0100
Message-ID: <20241121172239.119590-9-lkml@antheas.dev>
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
 <173220978286.6491.2438004784289973570@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Microsoft refers to the _DSMs 7,8 as "Sleep Entry" and "Sleep Exit".
Currently, the code uses "MS Entry/Exit" to name the variables, which is
confusing as it could either mean "Modern Standby" or "Microsoft" and is
not representative of the state. Rename as part of converting it into
a transition.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 8b39e3b12ec0..49dcbdea903a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -43,8 +43,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DISPLAY_ON	4
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
-#define ACPI_LPS0_MS_ENTRY      7
-#define ACPI_LPS0_MS_EXIT       8
+#define ACPI_LPS0_SLEEP_ENTRY      7
+#define ACPI_LPS0_SLEEP_EXIT       8
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -370,10 +370,10 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "lps0 entry";
 		case ACPI_LPS0_EXIT:
 			return "lps0 exit";
-		case ACPI_LPS0_MS_ENTRY:
-			return "lps0 ms entry";
-		case ACPI_LPS0_MS_EXIT:
-			return "lps0 ms exit";
+		case ACPI_LPS0_SLEEP_ENTRY:
+			return "sleep entry";
+		case ACPI_LPS0_SLEEP_EXIT:
+			return "sleep exit";
 		}
 	} else {
 		switch (state) {
@@ -610,7 +610,7 @@ int acpi_s2idle_prepare_late(void)
 
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
@@ -663,7 +663,7 @@ void acpi_s2idle_restore_early(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
 }
-- 
2.47.0


