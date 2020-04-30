Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE81BF6FB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD3LkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 07:40:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgD3LkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 07:40:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782E1106F;
        Thu, 30 Apr 2020 04:40:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8B883F305;
        Thu, 30 Apr 2020 04:40:22 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] cpu/hotplug: Remove __freeze_secondary_cpus()
Date:   Thu, 30 Apr 2020 12:40:04 +0100
Message-Id: <20200430114004.17477-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430114004.17477-1-qais.yousef@arm.com>
References: <20200430114004.17477-1-qais.yousef@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The refactored function is no longer required as the codepaths that call
freeze_secondary_cpus() are all suspend/resume related now.

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
 include/linux/cpu.h | 7 +------
 kernel/cpu.c        | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9d34dc3b859f..52692587f7fe 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -144,12 +144,7 @@ static inline void get_online_cpus(void) { cpus_read_lock(); }
 static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
-int __freeze_secondary_cpus(int primary, bool suspend);
-static inline int freeze_secondary_cpus(int primary)
-{
-	return __freeze_secondary_cpus(primary, true);
-}
-
+extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 10c60e9f58b7..8d57c3cfe862 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1327,7 +1327,7 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int __freeze_secondary_cpus(int primary, bool suspend)
+int freeze_secondary_cpus(int primary)
 {
 	int cpu, error = 0;
 
@@ -1352,7 +1352,7 @@ int __freeze_secondary_cpus(int primary, bool suspend)
 		if (cpu == primary)
 			continue;
 
-		if (suspend && pm_wakeup_pending()) {
+		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
 			error = -EBUSY;
 			break;
-- 
2.17.1

