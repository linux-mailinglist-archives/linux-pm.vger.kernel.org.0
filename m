Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34841A332D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDIL2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 07:28:13 -0400
Received: from foss.arm.com ([217.140.110.172]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgDIL2N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 07:28:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098BE7FA;
        Thu,  9 Apr 2020 04:28:13 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78D743F73D;
        Thu,  9 Apr 2020 04:28:11 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpu/hotplug: Remove disable_nonboot_cpus()
Date:   Thu,  9 Apr 2020 12:27:41 +0100
Message-Id: <20200409112742.3581-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409112742.3581-1-qais.yousef@arm.com>
References: <20200409112742.3581-1-qais.yousef@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The single user could have called freeze_secondary_cpus() directly.

Since this function was a source of confusion, remove it as it's
just a pointless wrapper.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <len.brown@intel.com>
CC: Pavel Machek <pavel@ucw.cz>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: Todd E Brandt <todd.e.brandt@linux.intel.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/power/suspend-and-cpuhotplug.rst | 4 ++--
 arch/x86/power/cpu.c                           | 2 +-
 include/linux/cpu.h                            | 5 -----
 kernel/cpu.c                                   | 2 +-
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index 572d968c5375..79f7610a6f6f 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -48,7 +48,7 @@ More details follow::
                                         |
                                         |
                                         v
-                              disable_nonboot_cpus()
+                              freeze_secondary_cpus()
                                    /* start */
                                         |
                                         v
@@ -83,7 +83,7 @@ More details follow::
                             Release cpu_add_remove_lock
                                         |
                                         v
-                       /* disable_nonboot_cpus() complete */
+                       /* freeze_secondary_cpus() complete */
                                         |
                                         v
                                    Do suspend
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 915bb1639763..e0a9ad8829b0 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -307,7 +307,7 @@ int hibernate_resume_nonboot_cpu_disable(void)
 	if (ret)
 		return ret;
 	smp_ops.play_dead = resume_play_dead;
-	ret = disable_nonboot_cpus();
+	ret = freeze_secondary_cpus(0);
 	smp_ops.play_dead = play_dead;
 	return ret;
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9ead281157d3..a00941c7828b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -145,10 +145,6 @@ static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
-static inline int disable_nonboot_cpus(void)
-{
-	return freeze_secondary_cpus(0);
-}
 extern void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
@@ -166,7 +162,6 @@ static inline void suspend_enable_secondary_cpus(void)
 }
 
 #else /* !CONFIG_PM_SLEEP_SMP */
-static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
 static inline int suspend_disable_secondary_cpus(void) { return 0; }
 static inline void suspend_enable_secondary_cpus(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 30848496cbc7..d6d2c829561e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1376,7 +1376,7 @@ int freeze_secondary_cpus(int primary)
 
 	/*
 	 * Make sure the CPUs won't be enabled by someone else. We need to do
-	 * this even in case of failure as all disable_nonboot_cpus() users are
+	 * this even in case of failure as all freeze_secondary_cpus() users are
 	 * supposed to do enable_nonboot_cpus() on the failure path.
 	 */
 	cpu_hotplug_disabled++;
-- 
2.17.1

