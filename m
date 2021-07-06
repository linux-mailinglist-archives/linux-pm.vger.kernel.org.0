Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160B3BD792
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGFNVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhGFNVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB061FB;
        Tue,  6 Jul 2021 06:18:42 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98F003F73B;
        Tue,  6 Jul 2021 06:18:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 1/6] PM: Introduce Active Stats framework
Date:   Tue,  6 Jul 2021 14:18:23 +0100
Message-Id: <20210706131828.22309-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new centralized mechanism for gathering and maintaining CPU
performance statistics - the Active Stats Framework (ASF). It tracks the
CPU activity at all performance levels (frequencies) taking into account
the idle entry/exit. This combined information can be used by other kernel
subsystems, like thermal governor, which tries to estimate the CPU
performance. The information about frequency change comes from CPUFreq
framework, while the idle entry/exit from CPUIdle framework. The ASF is
triggered in both scenarios so it can combine them locally and account in a
proper data structures. ASF is also attached to CPU hotplug, to properly
track it.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/active_stats.rst | 128 ++++
 Documentation/power/index.rst        |   1 +
 MAINTAINERS                          |   8 +
 include/linux/active_stats.h         | 131 ++++
 kernel/power/Kconfig                 |   9 +
 kernel/power/Makefile                |   1 +
 kernel/power/active_stats.c          | 921 +++++++++++++++++++++++++++
 7 files changed, 1199 insertions(+)
 create mode 100644 Documentation/power/active_stats.rst
 create mode 100644 include/linux/active_stats.h
 create mode 100644 kernel/power/active_stats.c

diff --git a/Documentation/power/active_stats.rst b/Documentation/power/active_stats.rst
new file mode 100644
index 000000000000..c97adbf679b7
--- /dev/null
+++ b/Documentation/power/active_stats.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Active Stats framework
+=======================
+
+1. Overview
+-----------
+
+The Active Stats framework provides useful statistical information on CPU
+performance state time residency to other frameworks or governors. The
+information contains a real time spent by the CPU when running at each
+performance state (frequency), excluding idle time. This knowledge might be used
+by other kernel subsystems to improve their mechanisms, e.g. used power
+estimation. The statistics does not distinguish idle states and does not track
+each idle state residency. It is done in this way because in most of the modern
+platforms the kernel has no control over deeper CPU idle states.
+
+The Active Stats consists of two components:
+a) the Active Stats Tracking (AST) mechanism
+b) Active Stats Monitor (ASM)
+
+The diagram below presents the design::
+
+       +---------------+  +---------------+
+       |    CPUFreq    |  |    CPUIdle    |
+       +---------------+  +---------------+
+                 |                 |
+                 |                 |
+                 +-------+         |
+                         |         |
+                         |         |
+       +--------------------------------------------------------+
+       | Active Stats    |         |                            |
+       | Framework       v         v                            |
+       |                 +---------------------+                |
+       |                 |    Active Stats     |                |
+       |                 |     Tracking        |                |
+       |                 +---------------------+                |
+       |                           |                            |
+       |                           |                            |
+       |                 +---------------------+                |
+       |                 |    Active Stats     |                |
+       |                 |     Monitor         |                |
+       |                 +---------------------+                |
+       |                   ^         ^                          |
+       |                   |         |                          |
+       +--------------------------------------------------------+
+                           |         |
+                           |         |
+                +----------+         |
+                |                    |
+        +------------------+   +--------------+
+        | Thermal Governor |   |    Other     |
+        +------------------+   +--------------+
+                ^                    ^
+                |                    |
+        +------------------+   +--------------+
+        | Thermal          |   |      ?       |
+        +------------------+   +--------------+
+
+The AST mechanism gathers and maintains statistics from CPUFreq and CPUIdle
+frameworks. It is triggered in the CPU frequency switch paths. It accounts
+the time spent at each frequency for each CPU. It supports per-CPU DVFS as
+well as shared frequency domain. The idle time accounting is triggered every
+time the CPU enters and exits idle state.
+
+The ASM is a component which is used by other kernel subsystems (like thermal
+governor) willing to know these statistical information. The client subsystem
+uses its private ASM structure to keep track of the system statistics and
+calculated local difference. Based on ASM data it is possible to calculate CPU
+running time at each frequency, from last check. The time difference between
+checks of ASM determines the period.
+
+
+2. Core APIs
+------------
+
+2.1 Config options
+^^^^^^^^^^^^^^^^^^
+
+CONFIG_ACTIVE_STATS must be enabled to use the Active Stats framework.
+
+
+2.2 Registration of the Active Stats Monitor
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Subsystems which want to use ASM to track CPU performance should register
+into the Active Stats framework by calling the following API::
+
+  struct active_stats_monitor *active_stats_cpu_setup_monitor(int cpu);
+
+The allocated and configured ASM structure will be returned in success
+otherwise a proper ERR_PTR() will be provided. See the
+kernel/power/active_stats.c for further documenation of this function.
+
+
+2.3 Accessing the Active Stats Monitor
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To get the latest statistics about CPU performance there is a need to call
+the following API::
+
+  int active_stats_cpu_update_monitor(struct active_stats_monitor *ast_mon);
+
+In this call the Active Stats framework calculates and populates lastest
+statistics for the given CPU. The statistics are then provided in the
+'ast_mon->local' which is an array of 'struct active_stats_state'.
+That structure contains array of time residency for each performance state
+(in nanoseconds). Looping over the array 'ast_mon->local->residency' (which
+has length provided in 'ast_mon->states_count') will provide detailed
+information about time residency at each performance state (frequency) in
+the given period present in 'ast_mon->local_period'. The local period value
+might be bigger than the sum in the residency array, when the CPU was idle
+or offline. More details about internals of the structures can be found in
+include/linux/active_stats.h.
+The 1st argument is the ASM allocated structure returned during setup (2.2).
+
+
+2.4 Clean up of the Active Stats Monitor
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To clean up the ASM when it is not needed anymore there is a need to call
+the following API::
+
+  void active_stats_cpu_free_monitor(struct active_stats_monitor *ast_mon);
+
+The associated structures will be freed.
diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index a0f5244fb427..757b8df44651 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -7,6 +7,7 @@ Power Management
 .. toctree::
     :maxdepth: 1
 
+    active_stats
     apm-acpi
     basic-pm-debugging
     charger-manager
diff --git a/MAINTAINERS b/MAINTAINERS
index efeaebe1bcae..6b831d4834d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -446,6 +446,14 @@ F:	Documentation/virt/acrn/
 F:	drivers/virt/acrn/
 F:	include/uapi/linux/acrn.h
 
+ACTIVE STATS
+M:	Lukasz Luba <lukasz.luba@arm.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/power/active_stats.rst
+F:	include/linux/active_stats.h
+F:	kernel/power/active_stats.c
+
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
 S:	Maintained
diff --git a/include/linux/active_stats.h b/include/linux/active_stats.h
new file mode 100644
index 000000000000..e7b81f5d774c
--- /dev/null
+++ b/include/linux/active_stats.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ACTIVE_STATS_H
+#define _LINUX_ACTIVE_STATS_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/seqlock.h>
+#include <linux/spinlock.h>
+
+/**
+ * active_stats_state - State statistics associated with performance level
+ * @last_event_ts:	Timestamp of the last event in nanoseconds
+ * @last_freq_idx:	Last used frequency index
+ * @residency:		Array which holds total time (in nanoseconds) that
+ *			each frequency has been used when CPU was
+ *			running
+ */
+struct active_stats_state {
+	u64 last_event_ts;
+	int last_freq_idx;
+	u64 *residency;
+};
+
+/**
+ * active_stats_snapshot - Active Stats Snapshot structure
+ * @curr:	Snapshot of statistics from Active Stats main structure
+ *		which accounts this CPU performance states residency
+ * @prev:	Old snapshot of the Active Stats main structure
+ *		structure, against which new snapshot is compared
+ * @result:	Statistics of running time for each performance state which
+ *		are calculated for this CPU for a specific period based on
+ *		@prev and @curr data.
+ */
+struct active_stats_snapshot {
+	struct active_stats_state *curr;
+	struct active_stats_state *prev;
+	struct active_stats_state *result;
+};
+
+/**
+ * active_stats - Active Stats main structure
+ * @activated:	Set when the tracking mechanism is used
+ * @num_clients:	Number of clients using tracking mechanism
+ * @in_ilde:	Set when CPU is in idle
+ * @offline:	Set when CPU was hotplug out and is offline
+ * @states_count:	Number of state entries in the statistics
+ * @states_size:	Size of the state stats entries in bytes
+ * @freq:	Frequency table
+ * @local:	Statistics of running time which are calculated for this CPU
+ * @snapshot:	Snapshot of statistics which accounts the frequencies
+ *		residency combined with idle period
+ * @seqcount:	Used for making consistent state for the reader side
+ *		of this statistics data
+ */
+struct active_stats {
+	bool activated;
+	int num_clients;
+	bool in_idle;
+	bool offline;
+	unsigned int states_count;
+	unsigned int states_size;
+	unsigned int *freq;
+	struct active_stats_snapshot snapshot;
+	struct active_stats *shared_ast;
+	struct mutex activation_lock;
+	/* protect concurent cpufreq changes in slow path */
+	spinlock_t lock;
+	/* Seqcount to create consistent state in the read side */
+	seqcount_t seqcount;
+};
+
+/**
+ * active_stats_monitor - Active Stats Monitor structure
+ * @local_period:	Local period for which the statistics are provided
+ * @states_count:	Number of state entries in the statistics
+ * @states_size:	Size of the state stats entries in bytes
+ * @ast:	Active Stats structure for the associated CPU, which is used
+ *		for taking the snapshot
+ * @snapshot:	Snapshot of statistics which accounts for this private monitor
+ *		period the frequencies residency combined with idle
+ * @tmp_view:	Snapshot of statistics which is used for calculating local
+ *		monitor statistics for private period the frequencies
+ *		residency combined with idle
+ * @lock:	Lock which is used to serialize access to Active Stats
+ *		Monitor structure which might be used concurrently.
+ */
+struct active_stats_monitor {
+	int cpu;
+	u64 local_period;
+	unsigned int states_count;
+	unsigned int states_size;
+	struct active_stats *ast;
+	struct active_stats_snapshot snapshot;
+	struct active_stats_snapshot tmp_view;
+	struct mutex lock;
+};
+
+#if defined(CONFIG_ACTIVE_STATS)
+void active_stats_cpu_idle_enter(ktime_t time_start);
+void active_stats_cpu_idle_exit(ktime_t time_start);
+void active_stats_cpu_freq_fast_change(int cpu, unsigned int freq);
+void active_stats_cpu_freq_change(int cpu, unsigned int freq);
+struct active_stats_monitor *active_stats_cpu_setup_monitor(int cpu);
+void active_stats_cpu_free_monitor(struct active_stats_monitor *ast_mon);
+int active_stats_cpu_update_monitor(struct active_stats_monitor *ast_mon);
+#else
+static inline
+void active_stats_cpu_freq_fast_change(int cpu, unsigned int freq) {}
+static inline
+void active_stats_cpu_freq_change(int cpu, unsigned int freq) {}
+static inline
+void active_stats_cpu_idle_enter(ktime_t time_start) {}
+static inline
+void active_stats_cpu_idle_exit(ktime_t time_start) {}
+static inline
+struct active_stats_monitor *active_stats_cpu_setup_monitor(int cpu)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline
+void active_stats_cpu_free_monitor(struct active_stats_monitor *ast_mon)
+{
+}
+static inline
+int active_stats_cpu_update_monitor(struct active_stats_monitor *ast_mon)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* _LINUX_ACTIVE_STATS_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 6bfe3ead10ad..c1701a75fe4f 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -331,3 +331,12 @@ config ENERGY_MODEL
 	  The exact usage of the energy model is subsystem-dependent.
 
 	  If in doubt, say N.
+
+config ACTIVE_STATS
+	bool "Enable Active Stats"
+	depends on CPU_FREQ && CPU_IDLE && PM_OPP
+	help
+	  Enable support for architectures common code for tracking and
+	  processing the CPU performance time residency. It is useful for
+	  power estimation, energy usage and can be used in frameworks such
+	  as thermal.
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 5899260a8bef..4b89aabf2259 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
 
 obj-$(CONFIG_ENERGY_MODEL)	+= energy_model.o
+obj-$(CONFIG_ACTIVE_STATS)	+= active_stats.o
diff --git a/kernel/power/active_stats.c b/kernel/power/active_stats.c
new file mode 100644
index 000000000000..96c4f9238620
--- /dev/null
+++ b/kernel/power/active_stats.c
@@ -0,0 +1,921 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Active Stats - CPU performance statistics tracking mechanism, which
+ * provides handy and combined information about how long a CPU was running
+ * at each frequency - excluding idle period. It is more detailed information
+ * than just time accounted in CPUFreq when that frequency was set.
+ *
+ * Copyright (C) 2021, ARM Ltd.
+ * Written by: Lukasz Luba, ARM Ltd.
+ */
+
+#include <linux/active_stats.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/pm_opp.h>
+#include <linux/sched/clock.h>
+#include <linux/slab.h>
+
+static cpumask_var_t cpus_to_visit;
+static void processing_done_fn(struct work_struct *work);
+static DECLARE_WORK(processing_done_work, processing_done_fn);
+
+static DEFINE_PER_CPU(struct active_stats *, ast_local);
+
+static struct active_stats_state *alloc_state_stats(int count);
+static void update_local_stats(struct active_stats *ast, ktime_t event_ts);
+static void get_stats_snapshot(struct active_stats *ast);
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *rootdir;
+
+static int active_stats_debug_residency_show(struct seq_file *s, void *unused)
+{
+	struct active_stats *ast = s->private;
+	u64 ts, residency;
+	int i;
+
+	ts = local_clock();
+
+	/*
+	 * Print statistics for each performance state and related residency
+	 * time [ns].
+	 */
+	for (i = 0; i < ast->states_count; i++) {
+		residency = ast->snapshot.result->residency[i];
+		if (i == ast->snapshot.result->last_freq_idx && !ast->in_idle && !ast->offline)
+			residency += ts - ast->snapshot.result->last_event_ts;
+
+		seq_printf(s, "%u:\t%llu\n", ast->freq[i], residency);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(active_stats_debug_residency);
+
+static void active_stats_debug_init(int cpu)
+{
+	struct device *dev;
+	struct dentry *d;
+
+	if (!rootdir)
+		rootdir = debugfs_create_dir("active_stats", NULL);
+
+	dev = get_cpu_device(cpu);
+	if (!dev)
+		return;
+
+	d = debugfs_create_dir(dev_name(dev), rootdir);
+	debugfs_create_file("time_in_state", 0444, d,
+			    per_cpu(ast_local, cpu),
+			    &active_stats_debug_residency_fops);
+}
+
+static void active_stats_debug_remove(int cpu)
+{
+	struct dentry *debug_dir;
+	struct device *dev;
+
+	dev = get_cpu_device(cpu);
+	if (!dev || !rootdir)
+		return;
+
+	debug_dir = debugfs_lookup(dev_name(dev), rootdir);
+	debugfs_remove_recursive(debug_dir);
+}
+#else /* CONFIG_DEBUG_FS */
+static void active_stats_debug_init(int cpu) {}
+static void active_stats_debug_remove(int cpu) {}
+#endif
+
+static int get_freq_index(struct active_stats *ast, unsigned int freq)
+{
+	int i;
+
+	for (i = 0; i < ast->states_count; i++)
+		if (ast->freq[i] == freq)
+			return i;
+	return -EINVAL;
+}
+
+static void free_state_stats(struct active_stats_state *stats)
+{
+	if (!stats)
+		return;
+
+	kfree(stats->residency);
+	kfree(stats);
+}
+
+static void active_stats_deactivate(struct active_stats *ast)
+{
+	mutex_lock(&ast->activation_lock);
+
+	ast->num_clients--;
+	if (!ast->num_clients)
+		WRITE_ONCE(ast->activated, false);
+
+	/* Do similar accouning for shared structure and not deeper */
+	if (ast->shared_ast)
+		active_stats_deactivate(ast->shared_ast);
+
+	mutex_unlock(&ast->activation_lock);
+}
+
+static void active_stats_reinit_snapshots(struct active_stats *ast, int cpu)
+{
+	int size = ast->states_size;
+	unsigned long freq;
+	int curr_freq_idx;
+	u64 curr_ts;
+
+	freq = cpufreq_quick_get(cpu);
+	curr_freq_idx = get_freq_index(ast, freq);
+	if (curr_freq_idx < 0)
+		curr_freq_idx = 0;
+
+	curr_ts = local_clock();
+
+	/* Only idle stats have the 'curr' and 'prev' */
+	if (ast->shared_ast) {
+		ast->snapshot.curr->last_event_ts = curr_ts;
+		ast->snapshot.curr->last_freq_idx = curr_freq_idx;
+
+		ast->snapshot.prev->last_freq_idx = curr_freq_idx;
+		ast->snapshot.prev->last_event_ts = curr_ts;
+
+		memcpy(ast->snapshot.prev->residency,
+		       ast->snapshot.curr->residency, size);
+	}
+
+	ast->snapshot.result->last_event_ts = curr_ts;
+	ast->snapshot.result->last_freq_idx = curr_freq_idx;
+}
+
+static void active_stats_activate(struct active_stats *ast, int cpu)
+{
+	mutex_lock(&ast->activation_lock);
+
+	ast->num_clients++;
+	if (!READ_ONCE(ast->activated)) {
+		/* For idle tracking stats take snapshot of freq stats */
+		if (ast->shared_ast) {
+			get_stats_snapshot(ast);
+			ast->in_idle = idle_cpu(cpu);
+		}
+
+		active_stats_reinit_snapshots(ast, cpu);
+		WRITE_ONCE(ast->activated, true);
+	}
+
+	mutex_unlock(&ast->activation_lock);
+}
+
+/**
+ * active_stats_cpu_setup_monitor - setup Active Stats Monitor structures
+ * @cpu:	CPU id for which the update is done
+ *
+ * Setup Active Stats Monitor statistics for a given @cpu. It allocates the
+ * needed structures for tracking the CPU performance levels residency.
+ * Return a valid pointer to struct active_stats_monitor or corresponding
+ * ERR_PTR().
+ */
+struct active_stats_monitor *active_stats_cpu_setup_monitor(int cpu)
+{
+	struct active_stats_monitor *ast_mon;
+	struct active_stats *ast;
+
+	ast = per_cpu(ast_local, cpu);
+	if (!ast)
+		return ERR_PTR(-EINVAL);
+
+	ast_mon = kzalloc(sizeof(struct active_stats_monitor), GFP_KERNEL);
+	if (!ast_mon)
+		return ERR_PTR(-ENOMEM);
+
+	ast_mon->snapshot.result = alloc_state_stats(ast->states_count);
+	if (!ast_mon->snapshot.result)
+		goto free_ast_mon;
+
+	ast_mon->snapshot.curr = alloc_state_stats(ast->states_count);
+	if (!ast_mon->snapshot.curr)
+		goto free_local;
+
+	ast_mon->snapshot.prev = alloc_state_stats(ast->states_count);
+	if (!ast_mon->snapshot.prev)
+		goto free_snapshot_curr;
+
+	ast_mon->tmp_view.result = alloc_state_stats(ast->states_count);
+	if (!ast_mon->tmp_view.result)
+		goto free_snapshot_prev;
+
+	ast_mon->tmp_view.curr = alloc_state_stats(ast->states_count);
+	if (!ast_mon->tmp_view.curr)
+		goto free_tmp_view_result;
+
+	ast_mon->tmp_view.prev = alloc_state_stats(ast->states_count);
+	if (!ast_mon->tmp_view.prev)
+		goto free_tmp_view_snapshot_curr;
+
+	ast_mon->ast = ast;
+	ast_mon->local_period = 0;
+	ast_mon->states_count = ast->states_count;
+	ast_mon->states_size = ast->states_count * sizeof(u64);
+	ast_mon->cpu = cpu;
+
+	active_stats_activate(ast->shared_ast, cpu);
+	active_stats_activate(ast, cpu);
+
+	mutex_init(&ast_mon->lock);
+
+	return ast_mon;
+
+free_tmp_view_snapshot_curr:
+	free_state_stats(ast_mon->tmp_view.curr);
+free_tmp_view_result:
+	free_state_stats(ast_mon->tmp_view.result);
+free_snapshot_prev:
+	free_state_stats(ast_mon->snapshot.prev);
+free_snapshot_curr:
+	free_state_stats(ast_mon->snapshot.curr);
+free_local:
+	free_state_stats(ast_mon->snapshot.result);
+free_ast_mon:
+	kfree(ast_mon);
+
+	return ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_setup_monitor);
+
+/**
+ * active_stats_cpu_free_monitor - free Active Stats Monitor structures
+ * @ast_mon:	Active Stats Monitor pointer
+ *
+ * Free the Active Stats Monitor data structures. No return value.
+ */
+void active_stats_cpu_free_monitor(struct active_stats_monitor *ast_mon)
+{
+	if (IS_ERR_OR_NULL(ast_mon))
+		return;
+
+	active_stats_deactivate(ast_mon->ast);
+
+	free_state_stats(ast_mon->tmp_view.prev);
+	free_state_stats(ast_mon->tmp_view.curr);
+	free_state_stats(ast_mon->tmp_view.result);
+	free_state_stats(ast_mon->snapshot.prev);
+	free_state_stats(ast_mon->snapshot.curr);
+	free_state_stats(ast_mon->snapshot.result);
+	kfree(ast_mon);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_free_monitor);
+
+static int update_monitor_stats(struct active_stats_monitor *ast_mon)
+{
+	struct active_stats_state *snapshot_local, *origin_local;
+	struct active_stats_state *origin_freq, *snapshot_freq;
+	struct active_stats_state *origin_idle, *snapshot_idle;
+	unsigned long seq_freq, seq_idle;
+	struct active_stats *ast;
+	int size, cpu_in_idle;
+
+	ast = ast_mon->ast;
+	size = ast->states_size;
+
+	/*
+	 * Take a consistent snapshot of the statistics updated from other CPU
+	 * which might be changing the frequency for the whole domain.
+	 */
+	origin_freq = ast->shared_ast->snapshot.result;
+	snapshot_freq = ast_mon->tmp_view.curr;
+	do {
+		seq_freq = read_seqcount_begin(&ast->shared_ast->seqcount);
+
+		/*
+		 * Take a consistent snapshot of the statistics updated from other CPU
+		 * which might be toggling idle.
+		 */
+		origin_idle = ast->snapshot.prev;
+		snapshot_idle = ast_mon->tmp_view.prev;
+		origin_local = ast->snapshot.result;
+		snapshot_local = ast_mon->tmp_view.result;
+		do {
+			seq_idle = read_seqcount_begin(&ast->seqcount);
+
+			memcpy(snapshot_idle->residency, origin_idle->residency, size);
+			snapshot_idle->last_event_ts = origin_idle->last_event_ts;
+			snapshot_idle->last_freq_idx = origin_idle->last_freq_idx;
+
+			memcpy(snapshot_local->residency, origin_local->residency, size);
+			snapshot_local->last_event_ts = origin_local->last_event_ts;
+			snapshot_local->last_freq_idx = origin_local->last_freq_idx;
+
+			cpu_in_idle = ast->in_idle || ast->offline;
+		} while (read_seqcount_retry(&ast->seqcount, seq_idle));
+
+		/* Now take from frequency, which path is less often used */
+		memcpy(snapshot_freq->residency, origin_freq->residency, size);
+		snapshot_freq->last_event_ts = origin_freq->last_event_ts;
+		snapshot_freq->last_freq_idx = origin_freq->last_freq_idx;
+
+	} while (read_seqcount_retry(&ast->shared_ast->seqcount, seq_freq));
+
+	return cpu_in_idle;
+}
+
+/**
+ * active_stats_cpu_update_monitor - update Active Stats Monitor structures
+ * @ast_mon:	Active Stats Monitor pointer
+ *
+ * Update Active Stats Monitor statistics for a given @ast_mon. It calculates
+ * residency time for all supported performance levels when CPU was running.
+ * Return 0 for success or -EINVAL on error.
+ */
+int active_stats_cpu_update_monitor(struct active_stats_monitor *ast_mon)
+{
+	struct active_stats_state *origin, *snapshot, *old, *local, *result;
+	int last_local_freq_idx, last_new_freq_idx;
+	int size, i, cpu_in_idle;
+	struct active_stats *ast;
+	s64 total_residency = 0;
+	u64 local_last_event_ts;
+	u64 last_event_ts = 0;
+	s64 period = 0;
+	s64 diff, acc;
+	u64 curr_ts;
+
+	if (IS_ERR_OR_NULL(ast_mon))
+		return -EINVAL;
+
+	ast = ast_mon->ast;
+
+	size = ast_mon->states_size;
+	origin = ast_mon->ast->snapshot.result;
+	local = ast_mon->snapshot.result;
+
+	mutex_lock(&ast_mon->lock);
+
+	curr_ts = local_clock();
+
+	/* last_event_ts = local->last_event_ts; */
+
+	/* Use older buffer for upcoming newest data */
+	swap(ast_mon->snapshot.curr, ast_mon->snapshot.prev);
+
+	snapshot = ast_mon->snapshot.curr;
+	old = ast_mon->snapshot.prev;
+	result = ast_mon->tmp_view.result;
+
+
+	cpu_in_idle = update_monitor_stats(ast_mon);
+
+	if (!cpu_in_idle) {
+		/* Take difference since this freq is set */
+		last_event_ts = max(last_event_ts, ast_mon->tmp_view.curr->last_event_ts);
+		/* Or take difference since the idle CPU last time accounted it if it was later */
+		last_event_ts = max(last_event_ts, result->last_event_ts);
+		diff = curr_ts - last_event_ts;
+
+		local_last_event_ts = ast_mon->tmp_view.result->last_event_ts;
+		period = curr_ts - local_last_event_ts;
+
+		last_new_freq_idx = ast_mon->tmp_view.curr->last_freq_idx;
+		last_local_freq_idx = ast_mon->tmp_view.result->last_freq_idx;
+
+		diff = max(0LL, diff);
+		if (diff > 0) {
+			result->residency[last_new_freq_idx] += diff;
+			total_residency += diff;
+		}
+		/* Calculate the difference for freq snapshot with idle snapshot */
+		for (i = 0; i < ast_mon->states_count; i++) {
+
+			acc = ast_mon->tmp_view.curr->residency[i];
+			acc -= ast_mon->tmp_view.prev->residency[i];
+
+			if (last_local_freq_idx != i) {
+				result->residency[i] += acc;
+				total_residency += acc;
+			}
+		}
+
+		/* Don't account twice the same running period */
+		result->residency[last_local_freq_idx] += period - total_residency;
+	}
+
+	memcpy(snapshot->residency, result->residency, size);
+
+	/* Calculate the difference of the running time since last check */
+	for (i = 0; i < ast_mon->states_count; i++) {
+		diff = snapshot->residency[i] - old->residency[i];
+		/* Avoid CPUs local clock differences issue and set 0 */
+		local->residency[i] = diff > 0 ? diff : 0;
+	}
+
+	snapshot->last_event_ts = curr_ts;
+	local->last_event_ts = curr_ts;
+	ast_mon->local_period = snapshot->last_event_ts - old->last_event_ts;
+
+	mutex_unlock(&ast_mon->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_update_monitor);
+
+static void get_stats_snapshot(struct active_stats *ast)
+{
+	struct active_stats_state *origin, *snapshot;
+	int size = ast->states_size;
+	unsigned long seq;
+
+	origin = ast->shared_ast->snapshot.result;
+	snapshot = ast->snapshot.curr;
+
+	/*
+	 * Take a consistent snapshot of the statistics updated from other CPU
+	 * which might be changing the frequency for the whole domain.
+	 */
+	do {
+		seq = read_seqcount_begin(&ast->shared_ast->seqcount);
+
+		memcpy(snapshot->residency, origin->residency, size);
+
+		snapshot->last_event_ts = origin->last_event_ts;
+		snapshot->last_freq_idx = origin->last_freq_idx;
+
+	} while (read_seqcount_retry(&ast->shared_ast->seqcount, seq));
+}
+
+static void
+update_local_stats(struct active_stats *ast, ktime_t event_ts)
+{
+	s64 total_residency = 0;
+	s64 diff, acc, period;
+	ktime_t prev_ts;
+	u64 prev;
+	int i;
+
+	get_stats_snapshot(ast);
+
+	prev = max(ast->snapshot.result->last_event_ts, ast->snapshot.curr->last_event_ts);
+	prev_ts = ns_to_ktime(prev);
+	diff = ktime_sub(event_ts, prev_ts);
+
+	prev_ts = ns_to_ktime(ast->snapshot.result->last_event_ts);
+	period = ktime_sub(event_ts, prev_ts);
+
+	i = ast->snapshot.curr->last_freq_idx;
+
+	diff = max(0LL, diff);
+	if (diff > 0) {
+		ast->snapshot.result->residency[i] += diff;
+		total_residency += diff;
+	}
+
+	for (i = 0; i < ast->states_count; i++) {
+		if (ast->snapshot.result->last_freq_idx == i)
+			continue;
+
+		acc = ast->snapshot.curr->residency[i];
+		acc -= ast->snapshot.prev->residency[i];
+		ast->snapshot.result->residency[i] += acc;
+		total_residency += acc;
+	}
+
+	/* Don't account twice the same running period */
+	i = ast->snapshot.result->last_freq_idx;
+	ast->snapshot.result->residency[i] += period - total_residency;
+
+	ast->snapshot.result->last_freq_idx = ast->snapshot.curr->last_freq_idx;
+
+	ast->snapshot.prev->last_freq_idx = ast->snapshot.curr->last_freq_idx;
+	ast->snapshot.prev->last_event_ts = ast->snapshot.curr->last_event_ts;
+
+	swap(ast->snapshot.curr, ast->snapshot.prev);
+
+	ast->snapshot.result->last_event_ts = event_ts;
+}
+
+static inline
+void _active_stats_cpu_idle_enter(struct active_stats *ast, ktime_t enter_ts)
+{
+	write_seqcount_begin(&ast->seqcount);
+
+	update_local_stats(ast, enter_ts);
+	ast->in_idle = true;
+
+	write_seqcount_end(&ast->seqcount);
+}
+
+static inline
+void _active_stats_cpu_idle_exit(struct active_stats *ast, ktime_t time_end)
+{
+	int size = ast->states_size;
+
+	write_seqcount_begin(&ast->seqcount);
+
+	get_stats_snapshot(ast);
+
+	ast->snapshot.result->last_freq_idx = ast->snapshot.curr->last_freq_idx;
+
+	memcpy(ast->snapshot.prev->residency, ast->snapshot.curr->residency, size);
+	ast->snapshot.prev->last_freq_idx = ast->snapshot.curr->last_freq_idx;
+	ast->snapshot.prev->last_event_ts = ast->snapshot.curr->last_event_ts;
+
+	swap(ast->snapshot.curr, ast->snapshot.prev);
+
+	ast->snapshot.result->last_event_ts = time_end;
+	ast->in_idle = false;
+
+	write_seqcount_end(&ast->seqcount);
+}
+
+/**
+ * active_stats_cpu_idle_enter - update Active Stats idle tracking data
+ * @enter_ts:	the time stamp with idle enter value
+ *
+ * Update the maintained statistics for entering idle for a given CPU.
+ * No return value.
+ */
+void active_stats_cpu_idle_enter(ktime_t enter_ts)
+{
+	struct active_stats *ast;
+
+	ast = per_cpu(ast_local, raw_smp_processor_id());
+	if (!ast || !READ_ONCE(ast->activated))
+		return;
+
+	_active_stats_cpu_idle_enter(ast, enter_ts);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_idle_enter);
+
+/**
+ * active_stats_cpu_idle_exit - update Active Stats idle tracking data
+ * @time_end:	the time stamp with idle exit value
+ *
+ * Update the maintained statistics for exiting idle for a given CPU.
+ * No return value.
+ */
+void active_stats_cpu_idle_exit(ktime_t time_end)
+{
+	struct active_stats *ast;
+
+	ast = per_cpu(ast_local, raw_smp_processor_id());
+	if (!ast || !READ_ONCE(ast->activated))
+		return;
+
+	_active_stats_cpu_idle_exit(ast, time_end);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_idle_exit);
+
+static void _active_stats_cpu_freq_change(struct active_stats *shared_ast,
+					  unsigned int freq, u64 ts)
+{
+	int prev_idx, next_idx;
+	s64 time_diff;
+
+	next_idx = get_freq_index(shared_ast, freq);
+	if (next_idx < 0)
+		return;
+
+	write_seqcount_begin(&shared_ast->seqcount);
+
+	/* The value in prev_idx is always a valid array index */
+	prev_idx = shared_ast->snapshot.result->last_freq_idx;
+
+	time_diff = ts - shared_ast->snapshot.result->last_event_ts;
+
+	/* Avoid jitter from different CPUs local clock */
+	if (time_diff > 0)
+		shared_ast->snapshot.result->residency[prev_idx] += time_diff;
+
+	shared_ast->snapshot.result->last_freq_idx = next_idx;
+	shared_ast->snapshot.result->last_event_ts = ts;
+
+	write_seqcount_end(&shared_ast->seqcount);
+}
+
+/**
+ * active_stats_cpu_freq_fast_change - update Active Stats tracking data
+ * @cpu:	the CPU id belonging to frequency domain which is updated
+ * @freq:	new frequency value
+ *
+ * Update the maintained statistics for frequency change for a given CPU's
+ * frequency domain. This function must be used only in the fast switch code
+ * path. No return value.
+ */
+void active_stats_cpu_freq_fast_change(int cpu, unsigned int freq)
+{
+	struct active_stats *ast;
+	u64 ts;
+
+	ast = per_cpu(ast_local, cpu);
+	if (!ast || !READ_ONCE(ast->activated))
+		return;
+
+	ts = local_clock();
+	_active_stats_cpu_freq_change(ast->shared_ast, freq, ts);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_freq_fast_change);
+
+/**
+ * active_stats_cpu_freq_change - update Active Stats tracking data
+ * @cpu:	the CPU id belonging to frequency domain which is updated
+ * @freq:	new frequency value
+ *
+ * Update the maintained statistics for frequency change for a given CPU's
+ * frequency domain. This function must not be used in the fast switch code
+ * path. No return value.
+ */
+void active_stats_cpu_freq_change(int cpu, unsigned int freq)
+{
+	struct active_stats *ast, *shared_ast;
+	unsigned long flags;
+	u64 ts;
+
+	ast = per_cpu(ast_local, cpu);
+	if (!ast || !READ_ONCE(ast->activated))
+		return;
+
+	shared_ast = ast->shared_ast;
+	ts = local_clock();
+
+	spin_lock_irqsave(&shared_ast->lock, flags);
+	_active_stats_cpu_freq_change(shared_ast, freq, ts);
+	spin_unlock_irqrestore(&shared_ast->lock, flags);
+}
+EXPORT_SYMBOL_GPL(active_stats_cpu_freq_change);
+
+static struct active_stats_state *alloc_state_stats(int count)
+{
+	struct active_stats_state *stats;
+
+	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
+	if (!stats)
+		return NULL;
+
+	stats->residency = kcalloc(count, sizeof(u64), GFP_KERNEL);
+	if (!stats->residency)
+		goto free_stats;
+
+	return stats;
+
+free_stats:
+	kfree(stats);
+
+	return NULL;
+}
+
+static struct active_stats *
+active_stats_setup(int cpu, int nr_opp, struct active_stats *shared_ast)
+{
+	struct active_stats *ast;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int i;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev) {
+		pr_err("%s: too early to get CPU%d device!\n",
+		       __func__, cpu);
+		return NULL;
+	}
+
+	ast = kzalloc(sizeof(*ast), GFP_KERNEL);
+	if (!ast)
+		return NULL;
+
+	ast->states_count = nr_opp;
+	ast->states_size = ast->states_count * sizeof(u64);
+	ast->in_idle = true;
+
+	ast->snapshot.result = alloc_state_stats(nr_opp);
+	if (!ast->snapshot.result)
+		goto free_ast;
+
+	if (!shared_ast) {
+		ast->freq = kcalloc(nr_opp, sizeof(unsigned long), GFP_KERNEL);
+		if (!ast->freq)
+			goto free_ast_local;
+
+		for (i = 0, rate = 0; i < nr_opp; i++, rate++) {
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+			if (IS_ERR(opp)) {
+				dev_warn(cpu_dev, "reading an OPP failed\n");
+				kfree(ast->freq);
+				goto free_ast_local;
+			}
+			dev_pm_opp_put(opp);
+
+			ast->freq[i] = rate / 1000;
+		}
+
+		/* Frequency isn't known at this point */
+		ast->snapshot.result->last_freq_idx = nr_opp - 1;
+	} else {
+		ast->freq = shared_ast->freq;
+
+		ast->snapshot.curr = alloc_state_stats(nr_opp);
+		if (!ast->snapshot.curr)
+			goto free_ast_local;
+
+		ast->snapshot.prev = alloc_state_stats(nr_opp);
+		if (!ast->snapshot.prev)
+			goto free_ast_snapshot;
+
+		ast->snapshot.curr->last_freq_idx = nr_opp - 1;
+		ast->snapshot.prev->last_freq_idx = nr_opp - 1;
+
+		ast->snapshot.result->last_freq_idx = nr_opp - 1;
+	}
+
+	mutex_init(&ast->activation_lock);
+	spin_lock_init(&ast->lock);
+	seqcount_init(&ast->seqcount);
+
+	return ast;
+
+free_ast_snapshot:
+	free_state_stats(ast->snapshot.curr);
+free_ast_local:
+	free_state_stats(ast->snapshot.result);
+free_ast:
+	kfree(ast);
+
+	return NULL;
+}
+
+static void active_stats_cleanup(struct active_stats *ast)
+{
+	free_state_stats(ast->snapshot.prev);
+	free_state_stats(ast->snapshot.curr);
+	free_state_stats(ast->snapshot.result);
+	kfree(ast);
+}
+
+static void active_stats_init(struct cpufreq_policy *policy)
+{
+	struct active_stats *ast, *shared_ast;
+	cpumask_var_t setup_cpus;
+	struct device *cpu_dev;
+	int nr_opp, cpu;
+
+	cpu = policy->cpu;
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev) {
+		pr_err("%s: too early to get CPU%d device!\n",
+		       __func__, cpu);
+		return;
+	}
+
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
+		dev_warn(cpu_dev, "OPP table is not ready\n");
+		return;
+	}
+
+	if (!alloc_cpumask_var(&setup_cpus, GFP_KERNEL)) {
+		dev_warn(cpu_dev, "cpumask alloc failed\n");
+		return;
+	}
+
+	shared_ast = active_stats_setup(cpu, nr_opp, NULL);
+	if (!shared_ast) {
+		free_cpumask_var(setup_cpus);
+		dev_warn(cpu_dev, "failed to setup shared_ast properly\n");
+		return;
+	}
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		ast = active_stats_setup(cpu, nr_opp, shared_ast);
+		if (!ast) {
+			dev_warn(cpu_dev, "failed to setup stats properly\n");
+			goto cpus_cleanup;
+		}
+
+		ast->shared_ast = shared_ast;
+		per_cpu(ast_local, cpu) = ast;
+
+		active_stats_debug_init(cpu);
+
+		cpumask_set_cpu(cpu, setup_cpus);
+	}
+
+	free_cpumask_var(setup_cpus);
+
+	dev_info(cpu_dev, "Active Stats created\n");
+	return;
+
+cpus_cleanup:
+	for_each_cpu(cpu, setup_cpus) {
+		active_stats_debug_remove(cpu);
+
+		ast = per_cpu(ast_local, cpu);
+		per_cpu(ast_local, cpu) = NULL;
+
+		active_stats_cleanup(ast);
+	}
+
+	free_cpumask_var(setup_cpus);
+	kfree(ast->freq);
+
+	active_stats_cleanup(shared_ast);
+}
+
+static int
+active_stats_init_callback(struct notifier_block *nb,
+			   unsigned long val, void *data)
+{
+	struct cpufreq_policy *policy = data;
+
+	if (val != CPUFREQ_CREATE_POLICY)
+		return 0;
+
+	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
+
+	active_stats_init(policy);
+
+	if (cpumask_empty(cpus_to_visit))
+		schedule_work(&processing_done_work);
+
+	return 0;
+}
+
+static struct notifier_block active_stats_init_notifier = {
+	.notifier_call = active_stats_init_callback,
+};
+
+static void processing_done_fn(struct work_struct *work)
+{
+	cpufreq_unregister_notifier(&active_stats_init_notifier,
+				    CPUFREQ_POLICY_NOTIFIER);
+	free_cpumask_var(cpus_to_visit);
+}
+
+static int cpuhp_active_stats_cpu_offline(unsigned int cpu)
+{
+	struct active_stats *ast;
+
+	ast = per_cpu(ast_local, cpu);
+	if (!ast)
+		return 0;
+
+	ast->offline = true;
+
+	if (!READ_ONCE(ast->activated))
+		return 0;
+
+	_active_stats_cpu_idle_enter(ast, local_clock());
+
+	return 0;
+}
+
+static int cpuhp_active_stats_cpu_online(unsigned int cpu)
+{
+	struct active_stats *ast;
+
+	ast = per_cpu(ast_local, cpu);
+	if (!ast)
+		return 0;
+
+	ast->offline = false;
+
+	if (!READ_ONCE(ast->activated))
+		return 0;
+
+	_active_stats_cpu_idle_exit(ast, local_clock());
+
+	return 0;
+}
+
+static int __init active_stats_register_notifier(void)
+{
+	int ret;
+
+	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpus_to_visit, cpu_possible_mask);
+
+	ret = cpufreq_register_notifier(&active_stats_init_notifier,
+					CPUFREQ_POLICY_NOTIFIER);
+
+	if (ret)
+		free_cpumask_var(cpus_to_visit);
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"active_stats_cpu:online",
+				cpuhp_active_stats_cpu_online,
+				cpuhp_active_stats_cpu_offline);
+
+	return ret;
+}
+fs_initcall(active_stats_register_notifier);
-- 
2.17.1

