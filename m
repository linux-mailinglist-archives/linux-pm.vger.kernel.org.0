Return-Path: <linux-pm+bounces-14538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2D97E2BA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9512A1F20622
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3039AE3;
	Sun, 22 Sep 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YMV90tWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE11A276;
	Sun, 22 Sep 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025875; cv=none; b=BVldZqZ5i62h1dSMG3giNLrpiTWwRwJVKAtTceScozuThXfWBuq3RqrCTc/Eb7fY84Uq28+Bphi/tCjVyHRTVhvxNUsvQix6YtWjRnmCDPj88xs6LKnX0UKhMJjvrEJA7j45LpRETrXKYqyFo8kigJ5Zvv5ffTTybBIDy55ZDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025875; c=relaxed/simple;
	bh=/q6XQlUZwLuDa/LRHCtcLcdUytwC2i3gD3uQ+jnxVM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIhlXyWHSKUml8b+H17EROo9wq8xAzLtbfYfd5WZk7a+8CnD/94TbFExIeJkMTGoHIeoraa6BPie209A8Hwdz6AlKmHp3zQzlY6TGEM/+YB3XlqMnqKBR5PxfpYUqaCAajyfH/kdBN7RO65zHA47o9KA9d2D2Vr9NbNK4Aj6RMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YMV90tWM; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A3C982E096FB;
	Sun, 22 Sep 2024 20:24:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727025869;
	bh=4xg+XiBJrHP9fSaSSoDTSxVBoNzDqUeh30zv1W614Vc=; h=From:To:Subject;
	b=YMV90tWMB6AKpvEhYLVWmakwqaWNx4cVqbi4ZlD7y5Pc35WtdpKmMFpuJTrr/D+wx
	 qWGYuq90smSSDsqmX+wuu7PxGBjeUETnj7nwCUs7bmt4QmEXOqrs1hmuVDIZk5XFdv
	 msV3xITT75w2PEheOXtY3k51ZiBCnV7wf5VkJkso=
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
Subject: [PATCH v2 3/5] acpi/x86: s2idle: add quirk table for modern standby
 delays
Date: Sun, 22 Sep 2024 19:22:56 +0200
Message-ID: <20240922172258.48435-4-lkml@antheas.dev>
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
 <172702586953.19607.1922514203249411979@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Unfortunately, some modern standby systems, including the ROG Ally, rely
on a delay between modern standby transitions. Add a quirk table for
introducing delays between modern standby transitions, and quirk the
ROG Ally on "Display Off", which needs a bit of time to turn off its
controllers prior to suspending (i.e., entering DRIPS).

Reported-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  5 +++++
 kernel/power/suspend.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8f33249cc067..d7e2a4d8ab0c 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -144,6 +144,11 @@ struct platform_s2idle_ops {
 	int (*display_on)(void);
 };
 
+struct platform_s2idle_quirks {
+	int delay_display_off;
+	int delay_display_on;
+};
+
 #ifdef CONFIG_SUSPEND
 extern suspend_state_t pm_suspend_target_state;
 extern suspend_state_t mem_sleep_current;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 610f8ecaeebd..af2abdd2f8c3 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -11,6 +11,7 @@
 
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -61,6 +62,30 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+// The ROG Ally series disconnects its controllers on Display Off, without
+// holding a lock, introducing a race condition. Add a delay to allow the
+// controller to disconnect cleanly prior to suspend.
+static const struct platform_s2idle_quirks rog_ally_quirks = {
+	.delay_display_off = 500,
+};
+
+static const struct dmi_system_id platform_s2idle_quirks[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
+		},
+		.driver_data = (void *)&rog_ally_quirks
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
+		},
+		.driver_data = (void *)&rog_ally_quirks
+	},
+	{}
+};
+
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
@@ -589,12 +614,26 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	/*
+	 * Windows transitions between Modern Standby states slowly, over multiple
+	 * seconds. Certain manufacturers may rely on this, introducing race
+	 * conditions. Until Linux can support modern standby, add the relevant
+	 * delays between transitions here.
+	 */
+	const struct dmi_system_id *s2idle_sysid = dmi_first_match(
+		platform_s2idle_quirks
+	);
+	const struct platform_s2idle_quirks *s2idle_quirks = s2idle_sysid ?
+		s2idle_sysid->driver_data : NULL;
+
 	/*
 	 * Linux does not have the concept of a "Screen Off" state, so call
 	 * the platform functions for Display On/Off prior to the suspend
 	 * sequence, mirroring Windows which calls them outside of it as well.
 	 */
 	platform_suspend_display_off();
+	if (s2idle_quirks && s2idle_quirks->delay_display_off)
+		msleep(s2idle_quirks->delay_display_off);
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
@@ -624,6 +663,8 @@ static int enter_state(suspend_state_t state)
  Unlock:
 	mutex_unlock(&system_transition_mutex);
 
+	if (s2idle_quirks && s2idle_quirks->delay_display_on)
+		msleep(s2idle_quirks->delay_display_on);
 	platform_suspend_display_on();
 	return error;
 }
-- 
2.46.1


