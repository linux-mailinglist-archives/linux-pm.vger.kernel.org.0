Return-Path: <linux-pm+bounces-19306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690E09F31B4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EA77A2B76
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824C205511;
	Mon, 16 Dec 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JAHJH70O"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D82054E6;
	Mon, 16 Dec 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356360; cv=none; b=VUsdBjm7aEy0Fn11EcgHB2ChMVktGmSyGyNGsctuUXEj9aJGH2dJErfSl2ttlh5dnfYYfzWqV945Itz/te8uwCjR7n8vFC5381mi3+jrrE0WpREnnySAH9FoSLvNOGkbbVuybwo1V17PrISUFpeswMcZQOO3PN0m3GHuT3hu2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356360; c=relaxed/simple;
	bh=maLJvdHMGdaeWjPEplAdgY7968lccnwkwy0LuI9OVYk=;
	h=From:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebftinTa+JR12ed1JeVv9K5xY47abD4AAB4ATjSClpT67p/j53AnwTA2xkSmWQ1a4dsjO7wJXfu8HTvs5k+/xm1EEU8nKbLJytbJ4uyJEmYexqZlUofj7T+IQJ8blHO17A76moUBQ58LyMPAIoDsuC74wSYG9y5PnIhDCZZw6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JAHJH70O; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id a219ac7d98729a14; Mon, 16 Dec 2024 14:39:09 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 50665841E0A;
	Mon, 16 Dec 2024 14:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1734356349;
	bh=maLJvdHMGdaeWjPEplAdgY7968lccnwkwy0LuI9OVYk=;
	h=From:Subject:Date;
	b=JAHJH70O/hbZhNcbZlYBrKxsnUqZawhQpfMmNnl2mqXXEqvHC4nOw9GKTZ945zyn6
	 sc4uNlbwPJeM52zppVQ96XLYF9koQp/NV0tm00+lloZgkVR1qOhYMiuS8YTO3oNneo
	 Mi/7r0Fc4WJtWEyMp89pbjSX2LzTPl64durmBHcKEE9qnK7gxGCcgQBxlTn71ZgIXl
	 I1GJd4etWRxMFPQ4p0rTaQp3MQ+bmL0Nw5W1SrFltQjjlx8e1dJopufn7VRzAEM7fD
	 T0lmnrYJBQF/17nlmlWGoYA6YzxQ/ubBDP2TEvGWP9zwtG3d2T6Bo0AqABV2hFWWzm
	 T2B42qcphYOWg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eric Biederman <ebiederm@xmission.com>,
 David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ming Lei <ming.lei@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1] kexec_core: Add and update comments regarding the KEXEC_JUMP flow
Date: Mon, 16 Dec 2024 14:39:09 +0100
Message-ID: <4968818.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnehmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfevledvvdetkedthfehgeetheehgfekheevtdeljeegiedvtefhtdetgeffheetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghdrlhgvihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The KEXEC_JUMP flow is analogous to hibernation flows occurring before
and after creating an image and before and after jumping from the
restore kernel to the image one, which is why it uses the same device
callbacks as those hibernation flows.

Add comments explaining that to the code in question and update an
existing comment in it which appears a bit out of context.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The kexec_jump code has a few problems AFAICS.

First off, it should use lock_system_sleep() or "interesting" things may
happen when it is run in parallel to a system-wide PM transition.

Second, it looks like it should use pm_sleep_disable/enable_decondary_cpus()
instead of the "raw" suspend_disable/enable_secondary_cpus() because running
it with unpaused cpuidle is kind of a slippery slope.

Moreover, it wouldn't hurt to somehow call acpi_pm_freeze() somewhere during
it to prevent background platform activity from interfering with the "resume"
part of it.

It also might be useful to unify it with the analogous hibernation flows more
directly, but that would require some rearrangements of the latter.

I'm going to send patches along these lines at one point in the future
unless I'm told that this is a bad idea.

Thanks!

---
 kernel/kexec_core.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1001,6 +1001,12 @@
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur before
+		 * creating an image and before jumping from the restore kernel
+		 * to the image one, so it uses the same device device callbacks
+		 * as those two flows.
+		 */
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1011,12 +1017,10 @@
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
-		/* At this point, dpm_suspend_start() has been called,
-		 * but *not* dpm_suspend_end(). We *must* call
-		 * dpm_suspend_end() now.  Otherwise, drivers for
-		 * some devices (e.g. interrupt controllers) become
-		 * desynchronized with the actual state of the
-		 * hardware at resume time, and evil weirdness ensues.
+		/*
+		 * dpm_suspend_end() must be called after dpm_suspend_start()
+		 * to complete the transition, like in the hibernation flows
+		 * mentioned above.
 		 */
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
@@ -1052,6 +1056,13 @@
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur after
+		 * creating an image and after the image hernel has got control
+		 * back, and in case the devices have been reset or otherwise
+		 * manipulated in the meantime, it uses the device callbacks
+		 * used by the latter.
+		 */
 		syscore_resume();
  Enable_irqs:
 		local_irq_enable();




