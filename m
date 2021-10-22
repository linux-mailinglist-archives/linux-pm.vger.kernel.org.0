Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FE437A95
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhJVQKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 12:10:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54312 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJVQKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 12:10:47 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 39576844557c031d; Fri, 22 Oct 2021 18:08:28 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B5AE966A9A4;
        Fri, 22 Oct 2021 18:08:27 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] PM: sleep: Pause cpuidle later and resume it earlier during system transitions
Date:   Fri, 22 Oct 2021 18:07:47 +0200
Message-ID: <2813389.e9J7NaK4W3@kreacher>
In-Reply-To: <2230995.ElGaqSPkdT@kreacher>
References: <2230995.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvfeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 8651f97bd951 ("PM / cpuidle: System resume hang fix with
cpuidle") that introduced cpuidle pausing during system suspend
did that to work around a platform firmware issue causing systems
to hang during resume if CPUs were allowed to enter idle states
in the system suspend and resume code paths.

However, pausing cpuidle before the last phase of suspending
devices is the source of an otherwise arbitrary difference between
the suspend-to-idle path and other system suspend variants, so it is
cleaner to do that later, before taking secondary CPUs offline (it
is still safer to take secondary CPUs offline with cpuidle paused,
though).

Modify the code accordingly, but in order to avoid code duplication,
introduce new wrapper functions, pm_sleep_disable_secondary_cpus()
and pm_sleep_enable_secondary_cpus(), to combine cpuidle_pause()
and cpuidle_resume(), respectively, with the handling of secondary
CPUs during system-wide transitions to sleep states.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    8 +-------
 kernel/power/hibernate.c  |   12 +++++++-----
 kernel/power/power.h      |   14 ++++++++++++++
 kernel/power/suspend.c    |   10 ++--------
 4 files changed, 24 insertions(+), 20 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -403,9 +403,6 @@ static int suspend_enter(suspend_state_t
 	if (error)
 		goto Devices_early_resume;
 
-	if (state != PM_SUSPEND_TO_IDLE)
-		cpuidle_pause();
-
 	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		pr_err("noirq suspend of devices failed\n");
@@ -423,7 +420,7 @@ static int suspend_enter(suspend_state_t
 		goto Platform_wake;
 	}
 
-	error = suspend_disable_secondary_cpus();
+	error = pm_sleep_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -453,16 +450,13 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	suspend_enable_secondary_cpus();
+	pm_sleep_enable_secondary_cpus();
 
  Platform_wake:
 	platform_resume_noirq(state);
 	dpm_resume_noirq(PMSG_RESUME);
 
  Platform_early_resume:
-	if (state != PM_SUSPEND_TO_IDLE)
-		cpuidle_resume();
-
 	platform_resume_early(state);
 
  Devices_early_resume:
Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -300,7 +300,7 @@ static int create_image(int platform_mod
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = suspend_disable_secondary_cpus();
+	error = pm_sleep_disable_secondary_cpus();
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -342,7 +342,7 @@ static int create_image(int platform_mod
 	local_irq_enable();
 
  Enable_cpus:
-	suspend_enable_secondary_cpus();
+	pm_sleep_enable_secondary_cpus();
 
 	/* Allow architectures to do nosmt-specific post-resume dances */
 	if (!in_suspend)
@@ -466,6 +466,8 @@ static int resume_target_kernel(bool pla
 	if (error)
 		goto Cleanup;
 
+	cpuidle_pause();
+
 	error = hibernate_resume_nonboot_cpu_disable();
 	if (error)
 		goto Enable_cpus;
@@ -509,7 +511,7 @@ static int resume_target_kernel(bool pla
 	local_irq_enable();
 
  Enable_cpus:
-	suspend_enable_secondary_cpus();
+	pm_sleep_enable_secondary_cpus();
 
  Cleanup:
 	platform_restore_cleanup(platform_mode);
@@ -587,7 +589,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = suspend_disable_secondary_cpus();
+	error = pm_sleep_disable_secondary_cpus();
 	if (error)
 		goto Enable_cpus;
 
@@ -609,7 +611,7 @@ int hibernation_platform_enter(void)
 	local_irq_enable();
 
  Enable_cpus:
-	suspend_enable_secondary_cpus();
+	pm_sleep_enable_secondary_cpus();
 
  Platform_finish:
 	hibernation_ops->finish();
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -32,7 +32,6 @@
 #include <linux/suspend.h>
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
-#include <linux/cpuidle.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
 
@@ -879,7 +878,6 @@ void dpm_resume_early(pm_message_t state
 void dpm_resume_start(pm_message_t state)
 {
 	dpm_resume_noirq(state);
-	cpuidle_resume();
 	dpm_resume_early(state);
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
@@ -1518,13 +1516,9 @@ int dpm_suspend_end(pm_message_t state)
 	if (error)
 		goto out;
 
-	cpuidle_pause();
-
 	error = dpm_suspend_noirq(state);
-	if (error) {
-		cpuidle_resume();
+	if (error)
 		dpm_resume_early(resume_event(state));
-	}
 
 out:
 	dpm_show_time(starttime, state, error, "end");
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -4,6 +4,8 @@
 #include <linux/utsname.h>
 #include <linux/freezer.h>
 #include <linux/compiler.h>
+#include <linux/cpu.h>
+#include <linux/cpuidle.h>
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -310,3 +312,15 @@ extern int pm_wake_lock(const char *buf)
 extern int pm_wake_unlock(const char *buf);
 
 #endif /* !CONFIG_PM_WAKELOCKS */
+
+static inline int pm_sleep_disable_secondary_cpus(void)
+{
+	cpuidle_pause();
+	return suspend_disable_secondary_cpus();
+}
+
+static inline void pm_sleep_enable_secondary_cpus(void)
+{
+	suspend_enable_secondary_cpus();
+	cpuidle_resume();
+}



