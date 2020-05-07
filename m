Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90661C98EF
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgEGSKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgEGSKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780AC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:43 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ce16so6671830qvb.15
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1hVWpcQCBXlH3SqDBepJS0v9206DDLEbeu2byk1docE=;
        b=voI6X5z1oHfaGl+yun2YjFQ9wyIgV3UMOhZV6BqoY3yJQLB6FIKy5DXw7DhxmeXVwg
         zbed3tHC1jjQpgXtPPtaTDX1GiZxYpU/sbjaH2LcbbbWqBmJ3bRnMVvNrs0q4CFtUXhP
         iwKxxIpHw5VkKGPoiCi6LCR4Xi60EqcVfNVTZH5i7UFJSupsOqJt2Y5b888qYIFNlJV0
         vpjDtq9fXzDF01SlrXMqZbF+IE3x9nT8QFCk6/Yob2XG9tABdHPXY9hm9rk5VZhx1u/9
         8oRPRe4VztaYP+xyXKiXFF0O4rFD+V3eTGc0qz92cBzAGCCWBBMm4acNu9ZcMbdhGMmt
         6VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1hVWpcQCBXlH3SqDBepJS0v9206DDLEbeu2byk1docE=;
        b=Shii0JyWgoxIIY4rCwfiXSSy5tKQnk4wOIi/XNX9qNbLZLLhXwCOFbwL5MyW5fqiab
         n5LGCOUq7S7K9O/26u3d84AXqsJR3RCo6Ym387+V1rF6w/EmblN21i9AxMKEeT70tPwf
         USlFEQUs75dPfqbUn7eyRJZyWC6JY8tsbcb7e7oqzPHZFufbWGCVa/mUPfglDPYHoQ4E
         r2QBz9oFM/wzY/MPgHD87QGDTD3lWBPcwgo2HjisVXYaoGAg4Mj1qEpAoDddtZ3arTPr
         WSa9qX0gqFIbwdtyUE8Q0YPbUuZFyDCSJF/ihjPECEB42LDJhylLGtjgqdvcD5Vxct5S
         uFiQ==
X-Gm-Message-State: AGi0Pua8a2aU7J9bvOuuQ/534BudES9zRA0c57EvqBB8F+g8fGOAnKgs
        jVm1ijyMO03DFfTYLIXypqjInmmaV9VJ
X-Google-Smtp-Source: APiQypI5EDf5t8r8O2JW1BDLkaew1g1NrIavX4ksxqmlBo9Mo0BH0ajd0rABhci5wzxC3jB7LEQhfhbfZ2NH
X-Received: by 2002:a0c:f889:: with SMTP id u9mr13938607qvn.60.1588875043082;
 Thu, 07 May 2020 11:10:43 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:11 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-14-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 13/14] sched: cpufreq: Use IS_ENABLED() for schedutil
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IS_ENABLED() macro evaluates to true when an option is set to =y or
=m. As such, it is a good fit for tristate options.

In preparation for modularizing schedutil, change all the related ifdefs
to use IS_ENABLED().

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/cpufreq.h      | 2 +-
 include/linux/sched/sysctl.h | 2 +-
 kernel/sched/sched.h         | 4 ++--
 kernel/sched/topology.c      | 4 ++--
 kernel/sysctl.c              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 267cc3b624da..c1176b8a0f61 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -983,7 +983,7 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 }
 #endif
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 			struct cpufreq_governor *old_gov);
 #else
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..704d971f204f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -94,7 +94,7 @@ extern int sysctl_schedstats(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
 extern int sched_energy_aware_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 60592cde80e8..087508723e58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -217,7 +217,7 @@ static inline void update_avg(u64 *avg, u64 sample)
 
 static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
 {
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+#if IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	return unlikely(dl_se->flags & SCHED_FLAG_SUGOV);
 #else
 	return false;
@@ -2459,7 +2459,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 }
 #endif
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 
 #define perf_domain_span(pd) (to_cpumask(((pd)->em_pd->cpus)))
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b905f2e8d9b2..5f49d25730bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,7 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
@@ -2287,7 +2287,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	/* Build perf. domains: */
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !sched_energy_update; j++) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..e115bf26cdb0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -475,7 +475,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 	},
 #endif
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
 		.procname	= "sched_energy_aware",
 		.data		= &sysctl_sched_energy_aware,
-- 
2.26.2.526.g744177e7f7-goog

