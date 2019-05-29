Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344602DAD3
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfE2KcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 06:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2KcH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 06:32:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0787421721;
        Wed, 29 May 2019 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559125926;
        bh=tSyB8R9LSCvDZM0gfCgG+2cjclheMogFDxE5DrDOEOk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=P5l7mvrYQpdnqXe/9pQu4/3eUvCtSn1lisXJrdp4GmIP/xBunN5o33lLawdTA3QrG
         ITgdZHdfivXS6ZTG2JSf6ozrCLQo03I+JsYTEK8D/FqHjGkkywNXkC8918sRRSpBOa
         X6ohzL8SBf2QZTTB9eJB5VZon2Tk34Hqhi3R/9PI=
Date:   Wed, 29 May 2019 12:32:02 +0200 (CEST)
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
Subject: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault during
 resume
In-Reply-To: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
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

Cc: stable@vger.kernel.org # v4.19+
Debugged-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

v1 -> v2:
	restructure error handling as suggested by peterz
	add Rafael's ack

 arch/x86/power/cpu.c | 10 ++++++++++
 include/linux/cpu.h  |  2 ++
 kernel/cpu.c         |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 3813fe45effd..b5523552a607 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -201,10 +201,12 @@ enum cpuhp_smt_control {
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology(void);
+extern int cpuhp_smt_enable(void);
 #else
 # define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
 static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
+static inline int cpuhp_smt_enable(void) { return 0; }
 #endif
 
 /*
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f2ef10460698..3ff5ce0e4132 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2093,7 +2093,7 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
 
-static int cpuhp_smt_enable(void)
+int cpuhp_smt_enable(void)
 {
 	int cpu, ret = 0;
 

-- 
Jiri Kosina
SUSE Labs

