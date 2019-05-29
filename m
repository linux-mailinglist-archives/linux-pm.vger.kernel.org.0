Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F622E7CC
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE2WJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 18:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfE2WJp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 18:09:45 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868B52075B;
        Wed, 29 May 2019 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559167783;
        bh=3OmN7Ed90J/s26tvuNKReiDT2xMzEGrBWFHugyhQnlw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KOURBKUuflSIr5s09riZllLv7PKMiQLqDJ0Oo9erxssyCTq3o5sECTB1wgLBYwKlZ
         +ogdHnO2mk+N9E7MlnbOcV6E2Lnc7Wx4f1I/oiVi6VnRgIqsxE9YF8q26C2VVlVFD+
         9uizhhYHeemF5ttAD5zLnh0u/i7MsnAnqyd8Wp6Y=
Date:   Thu, 30 May 2019 00:09:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during
 resume
In-Reply-To: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

As explained in

	0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")

we always, no matter what, have to bring up x86 HT siblings during boot at
least once in order to avoid first MCE bringing the system to its knees.

That means that whenever 'nosmt' is supplied on the kernel command-line,
all the HT siblings are as a result sitting in mwait or cpudile after
going through the online-offline cycle at least once.

This causes a serious issue though when a kernel, which saw 'nosmt' on its
commandline, is going to perform resume from hibernation: if the resume
from the hibernated image is successful, cr3 is flipped in order to point
to the address space of the kernel that is being resumed, which in turn
means that all the HT siblings are all of a sudden mwaiting on address
which is no longer valid.

That results in triple fault shortly after cr3 is switched, and machine
reboots.

Fix this by always waking up all the SMT siblings before initiating the
'restore from hibernation' process; this guarantees that all the HT
siblings will be properly carried over to the resumed kernel waiting in
resume_play_dead(), and acted upon accordingly afterwards, based on the
target kernel configuration.
Symmetricaly, the resumed kernel has to push the SMT siblings to mwait
again in case it has SMT disabled; this means it has to online all
the siblings when resuming (so that they come out of hlt) and offline
them again to let them reach mwait.

Cc: stable@vger.kernel.org # v4.19+
Debugged-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

v1 -> v2:
        - restructure error handling as suggested by peterz
        - add Rafael's ack

v2 -> v3:
        - added extra online/offline dance for nosmt case during
          resume, as we want the siblings to be in mwait, not hlt
        - dropped peterz's and Rafael's acks for now due to the above

v3 -> v4:
	- fix undefined return value from arch_resume_nosmt() in case
	  it's not overriden by arch

 arch/x86/power/cpu.c       | 10 ++++++++++
 arch/x86/power/hibernate.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/cpu.h        |  4 ++++
 kernel/cpu.c               |  4 ++--
 kernel/power/hibernate.c   |  9 +++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index a7d966964c6f..513ce09e9950 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -299,7 +299,17 @@ int hibernate_resume_nonboot_cpu_disable(void)
 	 * address in its instruction pointer may not be possible to resolve
 	 * any more at that point (the page tables used by it previously may
 	 * have been overwritten by hibernate image data).
+	 *
+	 * First, make sure that we wake up all the potentially disabled SMT
+	 * threads which have been initially brought up and then put into
+	 * mwait/cpuidle sleep.
+	 * Those will be put to proper (not interfering with hibernation
+	 * resume) sleep afterwards, and the resumed kernel will decide itself
+	 * what to do with them.
 	 */
+	ret = cpuhp_smt_enable();
+	if (ret)
+		return ret;
 	smp_ops.play_dead = resume_play_dead;
 	ret = disable_nonboot_cpus();
 	smp_ops.play_dead = play_dead;
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 4845b8c7be7f..fc413717a45f 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -11,6 +11,7 @@
 #include <linux/suspend.h>
 #include <linux/scatterlist.h>
 #include <linux/kdebug.h>
+#include <linux/cpu.h>
 
 #include <crypto/hash.h>
 
@@ -245,3 +246,35 @@ int relocate_restore_code(void)
 	__flush_tlb_all();
 	return 0;
 }
+
+int arch_resume_nosmt(void)
+{
+	int ret = 0;
+	/*
+	 * We reached this while coming out of hibernation. This means
+	 * that SMT siblings are sleeping in hlt, as mwait is not safe
+	 * against control transition during resume (see comment in
+	 * hibernate_resume_nonboot_cpu_disable()).
+	 *
+	 * If the resumed kernel has SMT disabled, we have to take all the
+	 * SMT siblings out of hlt, and offline them again so that they
+	 * end up in mwait proper.
+	 *
+	 * Called with hotplug disabled.
+	 */
+	cpu_hotplug_enable();
+	if (cpu_smt_control == CPU_SMT_DISABLED ||
+			cpu_smt_control == CPU_SMT_FORCE_DISABLED) {
+		enum cpuhp_smt_control old = cpu_smt_control;
+
+		ret = cpuhp_smt_enable();
+		if (ret)
+			goto out;
+		ret = cpuhp_smt_disable(old);
+		if (ret)
+			goto out;
+	}
+out:
+	cpu_hotplug_disable();
+	return ret;
+}
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 3813fe45effd..fcb1386bb0d4 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -201,10 +201,14 @@ enum cpuhp_smt_control {
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology(void);
+extern int cpuhp_smt_enable(void);
+extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
 #else
 # define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
 static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
+static inline int cpuhp_smt_enable(void) { return 0; }
+static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
 #endif
 
 /*
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f2ef10460698..077fde6fb953 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2061,7 +2061,7 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
 
-static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
+int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;
 
@@ -2093,7 +2093,7 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
 
-static int cpuhp_smt_enable(void)
+int cpuhp_smt_enable(void)
 {
 	int cpu, ret = 0;
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index c8c272df7154..b65635753e8e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -257,6 +257,11 @@ void swsusp_show_speed(ktime_t start, ktime_t stop,
 		(kps % 1000) / 10);
 }
 
+__weak int arch_resume_nosmt(void)
+{
+	return 0;
+}
+
 /**
  * create_image - Create a hibernation image.
  * @platform_mode: Whether or not to use the platform driver.
@@ -324,6 +329,10 @@ static int create_image(int platform_mode)
  Enable_cpus:
 	suspend_enable_secondary_cpus();
 
+	/* Allow architectures to do nosmt-specific post-resume dances */
+	if (!in_suspend)
+		error = arch_resume_nosmt();
+
  Platform_finish:
 	platform_finish(platform_mode);
 

-- 
Jiri Kosina
SUSE Labs

