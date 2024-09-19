Return-Path: <linux-pm+bounces-14482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56D97CD0A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B8B285694
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5381A0B1E;
	Thu, 19 Sep 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Y4ppS1IY"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01DF1A2848;
	Thu, 19 Sep 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766798; cv=none; b=FBHS34nAa9yga9jHUBmMxl0gtCIc5aZ8bwbdzvqMBY3JLj2t9gO2VRPtbb2fUgM+3dMX55oeugzhV5vaSaMRQwADgLrXVAqPELk7lQ52yqam4DBTeBhmhaGLSVX4jFMqKzxblAECFYYSlMhurS1yo5fVLRaB8/FgeaUwaQdzdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766798; c=relaxed/simple;
	bh=hmWlx/cLlSaH/IO1ZEjQxJG2EKpp2wLIxmnZmp/VHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyMcyRA/yCSuLTe6c+f5Xeqf8GIfwYSzAlly40FzSJrWIFUJDyaM3XftnqkZy4Q9TzxwUidJYly8vB88+yANmKuQ7+4Mcjly0djHmR4vebHMH34RBU3ve+/cun9KabMjvg5V8zaxKzzWIwCOEI5TV6AE5AeGMSu/e+ZJp2A3z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Y4ppS1IY; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:6813:1156:549c:fa23])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3F9182E09C25;
	Thu, 19 Sep 2024 20:20:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726766416;
	bh=1GPf111nh2bHLIm8C+lfqX5qYHAJo/tpPpPbFuwPGDc=; h=From:To:Subject;
	b=Y4ppS1IYbpR2QeC6vLTuhXnKKoODmHSVduzUqJ0Cj7FoXzrGKhYHjoUdHM66U48Ch
	 gOIBItPcmH7VmTUQZQThoX4hbZExCqGvfWEUpePXQz10XzJ4MEh0t9vdXYeVn/jNpT
	 EC0FDlWrWxEA+UgH8hbpodls4WUyDjGOJjn1ANqU=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:6813:1156:549c:fa23) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario.Limonciello@amd.com,
	luke@ljones.dev,
	me@kylegospodneti.ch
Subject: [PATCH v1 1/4] acpi/x86: s2idle: add support for screen off and
 screen on callbacks
Date: Thu, 19 Sep 2024 19:19:49 +0200
Message-ID: <20240919171952.403745-2-lkml@antheas.dev>
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
 <172676641622.26464.13999305177901794476@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The screen off and screen on firmware functions are meant to signify
the system entering a state where the user is not actively interacting
with it (i.e., in Windows this state is called "Screen Off" and the
system enters it once it turns the screen off e.g., due to inactivity).

In this state, the kernel and userspace are fully active, and the user
might still be interacting with the system somehow (such as with
listening to music or having a hotspot). Userspace is supposed to
minimize non-essential activities, but this is not required.
In addition, there is no requirement of suspending post the screen off
call. If the user interacts with the system, the kernel should call
screen on and resume normal operation.

This patch adds a set of callbacks to allow calling the screen on/off
callbacks outside of the suspend/resume path. It is based on
Mario Limonciello's patch on the superm1/dsm-screen-on-off branch.
However, the intent here is completely different.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  5 +++++
 kernel/power/suspend.c  | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff77..96ceaad07839 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -132,6 +132,7 @@ struct platform_suspend_ops {
 };
 
 struct platform_s2idle_ops {
+	int (*screen_off)(void);
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
@@ -140,6 +141,7 @@ struct platform_s2idle_ops {
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
+	int (*screen_on)(void);
 };
 
 #ifdef CONFIG_SUSPEND
@@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
 #define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
 #define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
 
+int platform_suspend_screen_off(void);
+int platform_suspend_screen_on(void);
+
 static inline void pm_suspend_clear_flags(void)
 {
 	pm_suspend_global_flags = 0;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..19734b297527 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
 	       (valid_state(state) && !cxl_mem_active());
 }
 
+int platform_suspend_screen_off(void)
+{
+	return s2idle_ops && s2idle_ops->screen_off ? s2idle_ops->screen_off() : 0;
+}
+EXPORT_SYMBOL_GPL(platform_suspend_screen_off);
+
+int platform_suspend_screen_on(void)
+{
+	return s2idle_ops && s2idle_ops->screen_on ? s2idle_ops->screen_on() : 0;
+}
+EXPORT_SYMBOL_GPL(platform_suspend_screen_on);
+
 static int platform_suspend_prepare(suspend_state_t state)
 {
 	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
-- 
2.46.1


