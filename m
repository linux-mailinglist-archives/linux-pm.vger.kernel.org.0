Return-Path: <linux-pm+bounces-27594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479BFAC27CA
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC215401CD
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E794296D0D;
	Fri, 23 May 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEJF+uts"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AA4120B;
	Fri, 23 May 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018643; cv=none; b=hW1PTrgXewYpGGY8rlhNkMjEZGwDXj/gsPHfuWpUa9Vr82MvkxVIYV5euUobWGAmNwLA3wV9JMjLSQN01jxUB+TF8KK2E3vAhGgBgreQ/r0zdKYBSfvY1CVDufnS2i6IwQxHpU0pUFftoXLjClgn+sn6xE+y8yblykTLDAV44QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018643; c=relaxed/simple;
	bh=Adv/SzYY1kL96AE7h8AQE8GubOTLp/Wk+DtJGu644YE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YuVR2ndYNll1jUPMg38lJ4l/AXhrtM4vcmM5Oi++t/kAt6l4RYD6+Kxj7RLgI8MT/6q2VZ2T9nSPzS3K+A/YPansEF6m8WUL6OHXNxjpkdtynWGtnZzI5A7o4QjYQ8Gc3/IoaHAUZS0UDzRebh1QfoNIObNGRzO4jsMvQ+C69vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WEJF+uts; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8Pk1b0UMHhjG5XBjXRII1ET1RF8evIDkrLvxPpnPWn8=; b=WEJF+utso6HD8RTg5Quj1n4C1F
	MWPyY5Br/OT2mJuMGM9HBT+Ylkwlv3WO5x9EKRA/9ovQt2yiT3VUrKnoO0+628/X59B34n0er5JKD
	qzZoTAIThlOMw8NtCkcKxqGsSiiiSkTen0vlJmFYgEldmpQUCe9wJZjeKwhlhWU7b3nHTAtObLxoI
	kKG2mXFvQlleUg5KaMZ5hZ1iKBtKOkHJadNlhQJ9gUfii849mhikxmoUHBvE071EJ2bWf0TwuDN+j
	bemd8nN4xCQD8b3kN2g2Vna3vY4AJAMTdWuPkSlgy2j3NGBbvKQEoge+AeKbTHkmOqVO5eSJrieDf
	lP0YnaFw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uIVUr-00000001M0L-49ka;
	Fri, 23 May 2025 16:43:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C941300472; Fri, 23 May 2025 18:43:49 +0200 (CEST)
Date: Fri, 23 May 2025 18:43:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org,
	hannes@cmpxchg.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tj@kernel.org
Subject: [PATCH] sched: Make clangd usable
Message-ID: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Due to the weird Makefile setup of sched the various files do not
compile as stand alone units. The new generation of editors are trying
to do just this -- mostly to offer fancy things like completions but
also better syntax highlighting and code navigation.

Specifically, I've been playing around with neovim and clangd.

Setting up clangd on the kernel source is a giant pain in the arse
(this really should be improved), but once you do manage, you run into
dumb stuff like the above.

Fix up the scheduler files to at least pretend to work.

(this excludes ext because those include games are worse than average)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Ingo, the alternative is going back a normal make setup, hmm?


 kernel/sched/autogroup.c         |    3 +++
 kernel/sched/autogroup.h         |    2 ++
 kernel/sched/clock.c             |    3 +++
 kernel/sched/completion.c        |    5 +++++
 kernel/sched/core_sched.c        |    2 ++
 kernel/sched/cpuacct.c           |    2 ++
 kernel/sched/cpudeadline.c       |    1 +
 kernel/sched/cpudeadline.h       |    2 ++
 kernel/sched/cpufreq.c           |    1 +
 kernel/sched/cpufreq_schedutil.c |    2 ++
 kernel/sched/cpupri.c            |    1 +
 kernel/sched/cpupri.h            |    3 +++
 kernel/sched/cputime.c           |    3 +++
 kernel/sched/deadline.c          |    4 ++++
 kernel/sched/debug.c             |    3 +++
 kernel/sched/idle.c              |    5 +++++
 kernel/sched/isolation.c         |    2 ++
 kernel/sched/loadavg.c           |    2 ++
 kernel/sched/membarrier.c        |    2 ++
 kernel/sched/pelt.c              |    1 +
 kernel/sched/pelt.h              |    7 ++++++-
 kernel/sched/psi.c               |    2 ++
 kernel/sched/rt.c                |    3 +++
 kernel/sched/sched-pelt.h        |    1 +
 kernel/sched/sched.h             |    1 +
 kernel/sched/smp.h               |    1 +
 kernel/sched/stats.c             |    1 +
 kernel/sched/stop_task.c         |    1 +
 kernel/sched/swait.c             |    1 +
 kernel/sched/topology.c          |    2 ++
 kernel/sched/wait.c              |    1 +
 kernel/sched/wait_bit.c          |    3 +++
 32 files changed, 72 insertions(+), 1 deletion(-)

--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -4,6 +4,9 @@
  * Auto-group scheduling implementation:
  */
 
+#include "autogroup.h"
+#include "sched.h"
+
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
 static atomic_t autogroup_seq_nr;
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -2,6 +2,8 @@
 #ifndef _KERNEL_SCHED_AUTOGROUP_H
 #define _KERNEL_SCHED_AUTOGROUP_H
 
+#include "sched.h"
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 
 struct autogroup {
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -54,6 +54,9 @@
  *
  */
 
+#include <linux/sched/clock.h>
+#include "sched.h"
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  * This is default implementation.
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -13,6 +13,11 @@
  * Waiting for completion is a typically sync point, but not an exclusion point.
  */
 
+#include <linux/linkage.h>
+#include <linux/sched/debug.h>
+#include <linux/completion.h>
+#include "sched.h"
+
 static void complete_with_flags(struct completion *x, int wake_flags)
 {
 	unsigned long flags;
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -4,6 +4,8 @@
  * A simple wrapper around refcount. An allocated sched_core_cookie's
  * address is used to compute the cookie of the task.
  */
+#include "sched.h"
+
 struct sched_core_cookie {
 	refcount_t refcnt;
 };
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -6,6 +6,8 @@
  * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
  * (balbir@in.ibm.com).
  */
+#include <linux/sched/cputime.h>
+#include "sched.h"
 
 /* Time spent by the tasks of the CPU accounting group executing in ... */
 enum cpuacct_stat_index {
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -6,6 +6,7 @@
  *
  *  Author: Juri Lelli <j.lelli@sssup.it>
  */
+#include "sched.h"
 
 static inline int parent(int i)
 {
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/spinlock.h>
 
 #define IDX_INVALID		-1
 
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+#include "sched.h"
 
 DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+#include <uapi/linux/sched/types.h>
+#include "sched.h"
 
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -22,6 +22,7 @@
  *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
+#include "sched.h"
 
 /*
  * p->rt_priority   p->prio   newpri   cpupri
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/sched/rt.h>
 
 #define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO+1)
 
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,9 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/cputime.h>
+#include <linux/tsacct_kern.h>
+#include "sched.h"
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
  #include <asm/cputime.h>
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,10 @@
  */
 
 #include <linux/cpuset.h>
+#include <linux/sched/clock.h>
+#include <uapi/linux/sched/types.h>
+#include "sched.h"
+#include "pelt.h"
 
 /*
  * Default limits for DL period; on the top end we guard against small util
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -6,6 +6,9 @@
  *
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
+#include <linux/debugfs.h>
+#include <linux/nmi.h>
+#include "sched.h"
 
 /*
  * This allows printing both to /sys/kernel/debug/sched/debug and
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -6,6 +6,11 @@
  * (NOTE: these are not related to SCHED_IDLE batch scheduled
  *        tasks which are handled in sched/fair.c )
  */
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <linux/livepatch.h>
+#include "sched.h"
+#include "smp.h"
 
 /* Linker adds these: start and end of __cpuidle functions */
 extern char __cpuidle_text_start[], __cpuidle_text_end[];
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2017-2018 SUSE, Frederic Weisbecker
  *
  */
+#include <linux/sched/isolation.h>
+#include "sched.h"
 
 enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -6,6 +6,8 @@
  * figure. Its a silly number but people think its important. We go through
  * great pains to make it work on big machines and tickless kernels.
  */
+#include <linux/sched/nohz.h>
+#include "sched.h"
 
 /*
  * Global load-average calculations
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -4,6 +4,8 @@
  *
  * membarrier system call
  */
+#include <uapi/linux/membarrier.h>
+#include "sched.h"
 
 /*
  * For documentation purposes, here are some membarrier ordering
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -23,6 +23,7 @@
  *  Move PELT related code from fair.c into this pelt.c file
  *  Author: Vincent Guittot <vincent.guittot@linaro.org>
  */
+#include "pelt.h"
 
 /*
  * Approximate:
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _KERNEL_SCHED_PELT_H
+#define _KERNEL_SCHED_PELT_H
+#include "sched.h"
+
 #ifdef CONFIG_SMP
 #include "sched-pelt.h"
 
@@ -233,4 +238,4 @@ update_idle_rq_clock_pelt(struct rq *rq)
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
-
+#endif /* _KERNEL_SCHED_PELT_H */
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -136,6 +136,8 @@
  * cost-wise, yet way more sensitive and accurate than periodic
  * sampling of the aggregate task states would be.
  */
+#include <linux/psi.h>
+#include "sched.h"
 
 static int psi_bug __read_mostly;
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -4,6 +4,9 @@
  * policies)
  */
 
+#include "sched.h"
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
--- a/kernel/sched/sched-pelt.h
+++ b/kernel/sched/sched-pelt.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by Documentation/scheduler/sched-pelt; do not modify. */
+#include <linux/types.h>
 
 static const u32 runnable_avg_yN_inv[] __maybe_unused = {
 	0xffffffff, 0xfa83b2da, 0xf5257d14, 0xefe4b99a, 0xeac0c6e6, 0xe5b906e6,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -69,6 +69,7 @@
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
 #include <linux/delayacct.h>
+#include <linux/mmu_context.h>
 
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -3,6 +3,7 @@
  * Scheduler internal SMP callback types and methods between the scheduler
  * and other internal parts of the core kernel:
  */
+#include <linux/types.h>
 
 extern void sched_ttwu_pending(void *arg);
 
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -2,6 +2,7 @@
 /*
  * /proc/schedstat implementation
  */
+#include "sched.h"
 
 void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
 			       struct sched_statistics *stats)
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -7,6 +7,7 @@
  *
  * See kernel/stop_machine.c
  */
+#include "sched.h"
 
 #ifdef CONFIG_SMP
 static int
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -2,6 +2,7 @@
 /*
  * <linux/swait.h> (simple wait queues ) implementation:
  */
+#include "sched.h"
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3,7 +3,9 @@
  * Scheduler topology setup/handling methods
  */
 
+#include <linux/sched/isolation.h>
 #include <linux/bsearch.h>
+#include "sched.h"
 
 DEFINE_MUTEX(sched_domains_mutex);
 void sched_domains_mutex_lock(void)
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -4,6 +4,7 @@
  *
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
+#include "sched.h"
 
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sched/debug.h>
+#include "sched.h"
+
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */

