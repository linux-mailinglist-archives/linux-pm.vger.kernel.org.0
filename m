Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B078E437A97
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhJVQKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 12:10:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64202 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhJVQKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 12:10:48 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 62cc4a2e6e5ecd79; Fri, 22 Oct 2021 18:08:30 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7CDD666A9B8;
        Fri, 22 Oct 2021 18:08:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] PM: suspend: Do not pause cpuidle in the suspend-to-idle path
Date:   Fri, 22 Oct 2021 18:04:02 +0200
Message-ID: <1813297.tdWV9SEqCh@kreacher>
In-Reply-To: <2230995.ElGaqSPkdT@kreacher>
References: <2230995.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvfeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is pointless to pause cpuidle in the suspend-to-idle path,
because it is going to be resumed in the same path later and
pausing it does not serve any particular purpose in that case.

Rework the code to avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   11 ++++++-----
 kernel/power/suspend.c    |    8 ++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state
 
 	resume_device_irqs();
 	device_wakeup_disarm_wake_irqs();
-
-	cpuidle_resume();
 }
 
 /**
@@ -881,6 +879,7 @@ void dpm_resume_early(pm_message_t state
 void dpm_resume_start(pm_message_t state)
 {
 	dpm_resume_noirq(state);
+	cpuidle_resume();
 	dpm_resume_early(state);
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
@@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state
 {
 	int ret;
 
-	cpuidle_pause();
-
 	device_wakeup_arm_wake_irqs();
 	suspend_device_irqs();
 
@@ -1521,9 +1518,13 @@ int dpm_suspend_end(pm_message_t state)
 	if (error)
 		goto out;
 
+	cpuidle_pause();
+
 	error = dpm_suspend_noirq(state);
-	if (error)
+	if (error) {
+		cpuidle_resume();
 		dpm_resume_early(resume_event(state));
+	}
 
 out:
 	dpm_show_time(starttime, state, error, "end");
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -97,7 +97,6 @@ static void s2idle_enter(void)
 	raw_spin_unlock_irq(&s2idle_lock);
 
 	cpus_read_lock();
-	cpuidle_resume();
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
@@ -105,7 +104,6 @@ static void s2idle_enter(void)
 	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
 
-	cpuidle_pause();
 	cpus_read_unlock();
 
 	raw_spin_lock_irq(&s2idle_lock);
@@ -405,6 +403,9 @@ static int suspend_enter(suspend_state_t
 	if (error)
 		goto Devices_early_resume;
 
+	if (state != PM_SUSPEND_TO_IDLE)
+		cpuidle_pause();
+
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		pr_err("noirq suspend of devices failed\n");
@@ -459,6 +460,9 @@ static int suspend_enter(suspend_state_t
 	dpm_resume_noirq(PMSG_RESUME);
 
  Platform_early_resume:
+	if (state != PM_SUSPEND_TO_IDLE)
+		cpuidle_resume();
+
 	platform_resume_early(state);
 
  Devices_early_resume:







