Return-Path: <linux-pm+bounces-17874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126799D51AB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E076B255F9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470131A76DA;
	Thu, 21 Nov 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="xd5Zm672"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52899198A3F;
	Thu, 21 Nov 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209819; cv=none; b=p9xd9JH4mEIzi0Y2gPZjsyIBy8lDJjR/0ibdYFdnPBbved4n5wDAYlXsH4r/DzoVjHnWg4i57lXiBVnCez78+UPIe4NjUWJhD/Vyp7VPhUZbPjbi7ObzI8cKKJONxyn0N0bXY9s2wPew09EJoreqYWD+3D9CMZVWhbvB5xA9WZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209819; c=relaxed/simple;
	bh=NeoxsfC/JCrP7PwwM9eLeMjprU8TXcYXcO5c2Qv620Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMrsU8lnj1gSkUkt+yczQhx/EksTOrzbLqpoSsp3U1fj9SVUBWa7cOEXlgcDDZFls3fWHNOSfbJZSx+U9pEsQOOOlAiW+RgW6FtnRpZh6TVhz+2oPb/xs3LHhFUhiXj18OsGNcGwsIS9qM9PQ+2ixM46HSIx0yLuFXn0q6ep1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=xd5Zm672; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AAAE32E096A8;
	Thu, 21 Nov 2024 19:23:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209814;
	bh=0f+2vUNiJNBCr2npgGT+5C+NFvaobl1gc8LB0xDB8Io=; h=From:To:Subject;
	b=xd5Zm672kx6WPxxwdIdOopLw247otKLGUSlYgc39zBytVDs1dqLf6PnKD44ji7rMJ
	 tZaXea3xm/nZvvo8YlbExpNPAXZjOkbWK/d0lNEFSt/EziDuGBpZSPnow+Wp/lyly7
	 jJ/McVF4SCNYb8GmqCpBeVoLdvOM0gI5PtrsK5kU=
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
Subject: [RFC 13/13] PM: standby: Add sysfs attribute for modern standby
 transitions
Date: Thu, 21 Nov 2024 18:22:38 +0100
Message-ID: <20241121172239.119590-14-lkml@antheas.dev>
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
 <173220981281.10560.4859672454396129529@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Add a sysfs attribute to allow informing the kernel about the current
standby state, those being: "active", "screen_off", "sleep", and
"resume" (to prepare turning the display on). The final modern
standby state DRIPS is omitted, as that is entered during the kernel
suspend process and userspace will never see it.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-power | 34 ++++++++++++
 kernel/power/main.c                   | 75 +++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e2..eff13980cc7c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -39,6 +39,40 @@ Description:
 		See Documentation/admin-guide/pm/sleep-states.rst for more
 		information.
 
+What:		/sys/power/standby
+Date:		November 2024
+Contact:	Antheas Kapenekakis <lkml@antheas.dev>
+Description:
+		The /sys/power/standby file controls the standby state of the
+		system. Modern S0ix capable systems can enter a set of low power
+		states while the kernel is still active. Transitioning into those
+		states may 1) deactivate tertiary hardware, and 2) change the
+		presentation of the device (e.g., pulse the suspend light, turn
+		off the keyboard backlight).
+
+		Available states are "active" (fully active), "screen-off" (fully
+		active but all displays of the system are off; virtual and real),
+		"sleep" (major userspace components have been frozen; light
+		background tasks may still run; this state may affect the power
+		envelope of the device). The final state is DRIPS or LSP0, where
+		the kernel suspends, and is entered by writing "mem" to
+		/sys/power/state. There is a secondary sleep state called "resume"
+		that can only be entered from "sleep" and is used in certain
+		devices to boost the Power Limit (PLx) while remaining in sleep
+		to hasten preparing for transitioning to "active".
+
+		Writing one of the above strings to this file causes the system
+		to transition into the corresponding state, by firing the
+		corresponding firmware notifications during the transition.
+
+		DRIPS or LSP0 (i.e., mem "s2idle") can only be entered from the
+		"sleep" state. If the kernel is asked to transition to DRIPS from
+		a different state, it will transition to "sleep" and then suspend.
+		On wakeup, the kernel will transition back to the previous state.
+
+		See Documentation/admin-guide/pm/standby-states.rst for more
+		information.
+
 What:		/sys/power/disk
 Date:		September 2006
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..4377fdaf4a8d 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -748,6 +748,80 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(state);
 
+#ifdef CONFIG_SUSPEND
+/*
+ * standby - control system s2idle standby state.
+ *
+ * show() returns available standby states, which may be "active", "screen_off",
+ * "sleep" and "resume" (still in sleep but preparing to turn on display).
+ * See Documentation/admin-guide/pm/standby-states.rst for a description of
+ * what they mean.
+ *
+ * store() accepts one of those strings, translates it into the proper
+ * enumerated value, and initiates a transition to that standby state.
+ *
+ * When the system suspends, it will first enter the state "sleep", suspend,
+ * and then restore the last state before entering "sleep". I.e., if userspace
+ * is not S0ix-aware, the transitions expected by Modern Standby devices will
+ * always be performed.
+ */
+static ssize_t standby_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	char *s = buf;
+	standby_state_t i;
+	standby_state_t curr = pm_standby_state();
+
+	if (curr < 0)
+		return -EBUSY;
+
+	for (i = PM_STANDBY_MIN; i < PM_STANDBY_MAX; i++)
+		if (standby_states[i])
+			s += sprintf(s, curr == i ? "[%s] " : "%s ", standby_states[i]);
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static standby_state_t decode_standby_state(const char *buf, size_t n)
+{
+	standby_state_t state;
+	char *p;
+	int len;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	for (state = PM_STANDBY_MIN; state < PM_STANDBY_MAX; state++) {
+		const char *label = standby_states[state];
+
+		if (label && len == strlen(label) && !strncmp(buf, label, len))
+			return state;
+	}
+
+	return PM_STANDBY_MAX;
+}
+
+static ssize_t standby_store(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t n)
+{
+	int error;
+	standby_state_t state;
+
+	state = decode_standby_state(buf, n);
+
+	if (state >= PM_STANDBY_MAX)
+		return -EINVAL;
+
+	error = pm_standby_transition(state);
+	return error ? error : n;
+}
+
+power_attr(standby);
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * The 'wakeup_count' attribute, along with the functions defined in
@@ -974,6 +1048,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_SUSPEND
 	&mem_sleep_attr.attr,
 	&sync_on_suspend_attr.attr,
+	&standby_attr.attr,
 #endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
-- 
2.47.0


