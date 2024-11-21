Return-Path: <linux-pm+bounces-17866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E259D5198
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AA528241A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DA1ACDE7;
	Thu, 21 Nov 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Q/xfjQMG"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F855C29;
	Thu, 21 Nov 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209782; cv=none; b=fPn5xsNUCbwqJ8SbZ68FgFtXj+yCNr71VIeEAfliOmc/QYriCRNdNIaxSkFSW/5/KujUxQSKazmpK5wBW90aEuAtNQfGyEyaUCHq0kVtIpcrIgWoVpm5A5cItGpX8RL9xSXztNqP96zPhX1Hn4iAJbLvIXigT86eJgGuO9j6ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209782; c=relaxed/simple;
	bh=nPeuDYB9iq+q35n0hzzxL3hzoSUCRdXzx4Hh8YhrhVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPTf9Ek4Am5V/2vdwFcZFL4doYNPrbae8Yhmi6pdSGOBUwnmMf602CxiSFtrsRM71oCLTDq/Y1YOZuODhlZ2R37ih7SlIkDSYRz3bNWk8lzfz7b4TWHUcMlODKnB/G7IZc2SgN91Hst7rdL+nrR/A1rTHYqrXH16WSD5WRRIj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Q/xfjQMG; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DA5DE2E09594;
	Thu, 21 Nov 2024 19:22:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209777;
	bh=etxEsp1/Zp5Onht50q+cVfkXXC1E1c/Mq9gluG3R0+Y=; h=From:To:Subject;
	b=Q/xfjQMGKhI+wS4gKp2RDRSpmMznb6ZeWSyecWYb0qRtfi9t2H6CoDW61Ukbxh9F0
	 r4NgnRt7qN5Z8M507IiT2dWiSOdE/+4aj/pLCawDXG06ZYQ7qTqGwsGFKidtDymIdZ
	 FlhnyGO9t4irzhrXd6Nf3/ZpDbLcBXw4HXm+UdBQ=
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
Subject: [RFC 05/13] acpi/x86: s2idle: add modern standby transition function
Date: Thu, 21 Nov 2024 18:22:30 +0100
Message-ID: <20241121172239.119590-6-lkml@antheas.dev>
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
 <173220977702.5388.1203506289428423876@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Add a new function to transition modern standby states and call it
as part of the suspend sequence to make sure it begins under the
Modern Standby "Sleep" state.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  11 ++++
 kernel/power/power.h    |   1 +
 kernel/power/suspend.c  | 127 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 01ee64321cda..b8fe781d8026 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -40,6 +40,15 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MIN		PM_SUSPEND_TO_IDLE
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
+typedef int __bitwise standby_state_t;
+
+#define PM_STANDBY_ACTIVE		((__force standby_state_t) 0)
+#define PM_STANDBY_SCREEN_OFF	((__force standby_state_t) 1)
+#define PM_STANDBY_SLEEP		((__force standby_state_t) 2)
+#define PM_STANDBY_RESUME		((__force standby_state_t) 3)
+#define PM_STANDBY_MIN			PM_STANDBY_ACTIVE
+#define PM_STANDBY_MAX			((__force standby_state_t) 4)
+
 /**
  * struct platform_suspend_ops - Callbacks for managing platform dependent
  *	system sleep states.
@@ -281,6 +290,8 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+extern int pm_standby_transition(standby_state_t state);
+extern int pm_standby_state(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index de0e6b1077f2..4ee067cd0d4d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -207,6 +207,7 @@ extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
 extern const char * const pm_labels[];
 extern const char *pm_states[];
 extern const char *mem_sleep_states[];
+extern const char *standby_states[];
 
 extern int suspend_devices_and_enter(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index a42e8514ee7a..1865db71a0c2 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -45,12 +45,21 @@ static const char * const mem_sleep_labels[] = {
 	[PM_SUSPEND_MEM] = "deep",
 };
 const char *mem_sleep_states[PM_SUSPEND_MAX];
+static const char * const standby_labels[] = {
+	[PM_STANDBY_ACTIVE] = "active",
+	[PM_STANDBY_SCREEN_OFF] = "screen_off",
+	[PM_STANDBY_SLEEP] = "sleep",
+	[PM_STANDBY_RESUME] = "resume",
+};
+const char *standby_states[PM_STANDBY_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 suspend_state_t pm_suspend_target_state;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
 
+standby_state_t standby_current = PM_STANDBY_ACTIVE;
+
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
@@ -188,6 +197,16 @@ void __init pm_states_init(void)
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
 	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+	/* All systems support the "active" state. */
+	standby_states[PM_STANDBY_ACTIVE] = standby_labels[PM_STANDBY_ACTIVE];
+	/*
+	 * Not all systems support these states, where they will have increased
+	 * power consumption. If deemed necessary, they should be gated to not
+	 * mislead userspace.
+	 */
+	standby_states[PM_STANDBY_SCREEN_OFF] = standby_labels[PM_STANDBY_SCREEN_OFF];
+	standby_states[PM_STANDBY_SLEEP] = standby_labels[PM_STANDBY_SLEEP];
+	standby_states[PM_STANDBY_RESUME] = standby_labels[PM_STANDBY_RESUME];
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -354,6 +373,108 @@ static bool platform_suspend_again(suspend_state_t state)
 		suspend_ops->suspend_again() : false;
 }
 
+static int platform_standby_transition_internal(standby_state_t state)
+{
+	int error;
+
+	if (state == standby_current)
+		return 0;
+	if (state > PM_STANDBY_MAX)
+		return -EINVAL;
+
+	pm_pr_dbg("Transitioning from standby state %s to %s\n",
+		  standby_states[standby_current], standby_states[state]);
+
+	/* Resume can only be entered if we are on the sleep state. */
+	if (state == PM_STANDBY_RESUME) {
+		if (standby_current != PM_STANDBY_SLEEP)
+			return -EINVAL;
+		standby_current = PM_STANDBY_RESUME;
+		return platform_standby_turn_on_display();
+	}
+
+	/*
+	 * The system should not be able to re-enter Sleep from resume as it
+	 * is undefined behavior. As part of setting the state to "Resume",
+	 * were promised a transition to "Screen Off" or "Active".
+	 */
+	if (standby_current == PM_STANDBY_RESUME && state == PM_STANDBY_SLEEP)
+		return -EINVAL;
+
+	/* Resume is the Sleep state logic-wise. */
+	if (standby_current == PM_STANDBY_RESUME)
+		standby_current = PM_STANDBY_SLEEP;
+
+	if (standby_current < state) {
+		for (; standby_current < state; standby_current++) {
+			switch (standby_current + 1) {
+			case PM_STANDBY_SCREEN_OFF:
+				error = platform_standby_display_off();
+				break;
+			case PM_STANDBY_SLEEP:
+				error = platform_standby_sleep_entry();
+				break;
+			}
+
+			if (error)
+				return error;
+		}
+	} else if (standby_current > state) {
+		for (; standby_current > state; standby_current--) {
+			switch (standby_current) {
+			case PM_STANDBY_SLEEP:
+				error = platform_standby_sleep_exit();
+				break;
+			case PM_STANDBY_SCREEN_OFF:
+				error = platform_standby_display_on();
+				break;
+			}
+
+			if (error)
+				return error;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pm_standby_transition - Transition between Modern Standby states
+ *
+ * Fires the appropriate firmware notifications to transition to the requested
+ * state. Returns an error if the transition fails. The function does not
+ * rollback. It is up to userspace to handle the error and re-transition when
+ * appropriate.
+ */
+int pm_standby_transition(standby_state_t state)
+{
+	unsigned int sleep_flags;
+	int error;
+
+	sleep_flags = lock_system_sleep();
+	error = platform_standby_transition_internal(state);
+	unlock_system_sleep(sleep_flags);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(pm_standby_transition);
+
+/**
+ * pm_standby_state - Returns the current standby state
+ */
+int pm_standby_state(void)
+{
+	unsigned int sleep_flags;
+	int state;
+
+	sleep_flags = lock_system_sleep();
+	state = standby_current;
+	unlock_system_sleep(sleep_flags);
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(pm_standby_state);
+
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay = 5;
 module_param(pm_test_delay, uint, 0644);
@@ -586,6 +707,7 @@ static void suspend_finish(void)
 static int enter_state(suspend_state_t state)
 {
 	int error;
+	standby_state_t standby_prior;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
@@ -601,6 +723,9 @@ static int enter_state(suspend_state_t state)
 	if (!mutex_trylock(&system_transition_mutex))
 		return -EBUSY;
 
+	standby_prior = standby_current;
+	platform_standby_transition_internal(PM_STANDBY_SLEEP);
+
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
@@ -630,6 +755,8 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	platform_standby_transition_internal(standby_prior);
+
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
-- 
2.47.0


