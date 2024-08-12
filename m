Return-Path: <linux-pm+bounces-12081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F394EE8A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779C91C21B5A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D117CA16;
	Mon, 12 Aug 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="e2RzsdA4"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6E17C7B6;
	Mon, 12 Aug 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470286; cv=none; b=db/QfYnQrlInCtcYED4As201enq/pKpsLVNS+plBB9Knuj1F9mDSgtuhthWk3AacCdPQvmWvAwRmVqlwWgtW7Pc3GrEyiYPgbxhZaKcJcIGf/2FI5BtOU1RsLoKh/2hi/C6Ry9e8Uk7jGlh6oXMZQg+B/2gSe0dLp5b4mQrZiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470286; c=relaxed/simple;
	bh=TAzaqLEXZwPMWSYO/SkXZvcvfA0ip0KR/KdQjur0rsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx2/KiL+CS37g+DHnamMa0VANhAvisjpFMsevdrGQMa1DSRAWcyP+YxXenuoYoLOv5iG/3tRHSy4WuXHoL/P5Pgs4Zckz9tErsgEfsR1hiJ7i/SF5+rZMFTRc9yVKoLsq2DRW1rBVLIyOOwjW/HE/ud8yWbMx4u+UWHowhQybZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=e2RzsdA4 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 4538414de25ae86d; Mon, 12 Aug 2024 14:44:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5D1786F0D80;
	Mon, 12 Aug 2024 14:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723466681;
	bh=TAzaqLEXZwPMWSYO/SkXZvcvfA0ip0KR/KdQjur0rsk=;
	h=From:Subject:Date;
	b=e2RzsdA44Sv/hh12ygeJlkNw9y61CuV4SI4vPd+5Ss0xzyBW5ULZPw/jUOI9ZOYeL
	 m6YPCFbbSzecGdgTHDQbano+frSBlSqIoCBJ4ZSgjYc8y1I7Lvoo1HdLtrmfSo8zoq
	 MEdZmnwXST+NCojcoiBIccLTfreDxzOA7uzjgWnntx/tH+5Q3Hj9l1KDLW1zhQ8/Dl
	 5ly6Df5D3hLcmDct16BgTGboh29VGj54orIloRoOHtfeqy834SrXEtCUvMbYwT5jgL
	 15nk7tPKLGsNXO12KHTB6aj3zvfXM/FDFxbtPDOxOME4GuVmxdMNChMOGsq3y0Mgj+
	 CysLJ/GBGAM7A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [PATCH v2 3/3] cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid
 systems
Date: Mon, 12 Aug 2024 14:44:30 +0200
Message-ID: <3311190.44csPzL39Z@rjwysocki.net>
In-Reply-To: <4941491.31r3eYUQgx@rjwysocki.net>
References: <4941491.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
 rggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate use the HWP_HIGHEST_PERF values from
MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
via the previously introduced arch_set_cpu_capacity() on hybrid
systems without SMT.

Setting asymmetric CPU capacity is generally necessary to allow the
scheduler to compute task sizes in a consistent way across all CPUs
in a system where they differ by capacity.  That, in turn, should help
to improve scheduling decisions.  It is also necessary for the schedutil
cpufreq governor to operate as expected on hybrid systems where tasks
migrate between CPUs of different capacities.

The underlying observation is that intel_pstate already uses
MSR_HWP_CAPABILITIES to get CPU performance information which is
exposed by it via sysfs and CPU performance scaling is based on it.
Thus using this information for setting asymmetric CPU capacity is
consistent with what the driver has been doing already.  Moreover,
HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
both the instructions-per-cycle (IPC) factor and the maximum turbo
frequency and the units in which that value is expressed are the same
for all CPUs in the system, so the maximum capacity ratio between two
CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
values.  Of course, in principle that capacity ratio need not be
directly applicable at lower frequencies, so using it for providing the
asymmetric CPU capacity information to the scheduler is a rough
approximation, but it is as good as it gets.  Also, measurements
indicate that this approximation is not too bad in practice.

If the given system is hybrid and non-SMT, the new code disables ITMT
support in the scheduler (because it may get in the way of asymmetric CPU
capacity code in the scheduler that automatically gets enabled by setting
asymmetric CPU capacity) after initializing all online CPUs and finds
the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
capacity number for each (online) CPU by dividing the product of its
HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.

When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
and if it is the one with the maximum HWP_HIGHEST_PERF value, the
capacity numbers for all of the other online CPUs are recomputed.  This
also takes care of a cleanup during driver operation mode changes.

Analogously, when a new CPU goes online, its capacity number is updated
and if its HWP_HIGHEST_PERF value is greater than the current maximum
one, the capacity numbers for all of the other online CPUs are
recomputed.

The case when the driver is notified of a CPU capacity change, either
through the HWP interrupt or through an ACPI notification, is handled
similarly to the CPU online case above, except that if the target CPU
is the current highest-capacity one and its capacity is reduced, the
capacity numbers for all of the other online CPUs need to be recomputed
either.

If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
capacity information is computed from scratch to reflect the new turbo
status.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Check hybrid_max_perf_cpu in intel_pstate_update_limits_for_all()
     to avoid triggering a warning from arch_set_cpu_capacity() on
     non-hybrid systems.

---
 drivers/cpufreq/intel_pstate.c |  220 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -16,6 +16,7 @@
 #include <linux/tick.h>
 #include <linux/slab.h>
 #include <linux/sched/cpufreq.h>
+#include <linux/sched/smt.h>
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
@@ -215,6 +216,7 @@ struct global_params {
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  * @last_io_update:	Last time when IO wake flag was set
+ * @capacity_perf:	Highest perf used for scale invariance
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
@@ -253,6 +255,7 @@ struct cpudata {
 	u64 hwp_req_cached;
 	u64 hwp_cap_cached;
 	u64 last_io_update;
+	unsigned int capacity_perf;
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
@@ -295,6 +298,7 @@ static int hwp_mode_bdw __ro_after_init;
 static bool per_cpu_limits __ro_after_init;
 static bool hwp_forced __ro_after_init;
 static bool hwp_boost __read_mostly;
+static bool hwp_is_hybrid;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -934,6 +938,111 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
+static struct cpudata *hybrid_max_perf_cpu __read_mostly;
+/*
+ * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpudata,
+ * and the x86 arch scale-invariance information from concurrent updates.
+ */
+static DEFINE_MUTEX(hybrid_capacity_lock);
+
+static void hybrid_set_cpu_capacity(struct cpudata *cpu)
+{
+	arch_set_cpu_capacity(cpu->cpu, cpu->capacity_perf,
+			      hybrid_max_perf_cpu->capacity_perf,
+			      cpu->capacity_perf,
+			      cpu->pstate.max_pstate_physical);
+
+	pr_debug("CPU%d: perf = %u, max. perf = %u, base perf = %d\n", cpu->cpu,
+		 cpu->capacity_perf, hybrid_max_perf_cpu->capacity_perf,
+		 cpu->pstate.max_pstate_physical);
+}
+
+static void hybrid_clear_cpu_capacity(unsigned int cpunum)
+{
+	arch_set_cpu_capacity(cpunum, 1, 1, 1, 1);
+}
+
+static void hybrid_get_capacity_perf(struct cpudata *cpu)
+{
+	if (READ_ONCE(global.no_turbo)) {
+		cpu->capacity_perf = cpu->pstate.max_pstate_physical;
+		return;
+	}
+
+	cpu->capacity_perf = HWP_HIGHEST_PERF(READ_ONCE(cpu->hwp_cap_cached));
+}
+
+static void hybrid_set_capacity_of_cpus(void)
+{
+	int cpunum;
+
+	for_each_online_cpu(cpunum) {
+		struct cpudata *cpu = all_cpu_data[cpunum];
+
+		if (cpu)
+			hybrid_set_cpu_capacity(cpu);
+	}
+}
+
+static void hybrid_update_cpu_scaling(void)
+{
+	struct cpudata *max_perf_cpu = NULL;
+	unsigned int max_cap_perf = 0;
+	int cpunum;
+
+	for_each_online_cpu(cpunum) {
+		struct cpudata *cpu = all_cpu_data[cpunum];
+
+		if (!cpu)
+			continue;
+
+		/*
+		 * During initialization, CPU performance at full capacity needs
+		 * to be determined.
+		 */
+		if (!hybrid_max_perf_cpu)
+			hybrid_get_capacity_perf(cpu);
+
+		/*
+		 * If hybrid_max_perf_cpu is not NULL at this point, it is
+		 * being replaced, so don't take it into account when looking
+		 * for the new one.
+		 */
+		if (cpu == hybrid_max_perf_cpu)
+			continue;
+
+		if (cpu->capacity_perf > max_cap_perf) {
+			max_cap_perf = cpu->capacity_perf;
+			max_perf_cpu = cpu;
+		}
+	}
+
+	if (max_perf_cpu) {
+		hybrid_max_perf_cpu = max_perf_cpu;
+		hybrid_set_capacity_of_cpus();
+	} else {
+		pr_info("Found no CPUs with nonzero maximum performance\n");
+		/* Revert to the flat CPU capacity structure. */
+		for_each_online_cpu(cpunum)
+			hybrid_clear_cpu_capacity(cpunum);
+	}
+}
+
+static void __hybrid_init_cpu_scaling(void)
+{
+	hybrid_max_perf_cpu = NULL;
+	hybrid_update_cpu_scaling();
+}
+
+static void hybrid_init_cpu_scaling(void)
+{
+	mutex_lock(&hybrid_capacity_lock);
+
+	__hybrid_init_cpu_scaling();
+
+	mutex_unlock(&hybrid_capacity_lock);
+}
+
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
@@ -962,6 +1071,43 @@ static void intel_pstate_get_hwp_cap(str
 	}
 }
 
+static void hybrid_update_capacity(struct cpudata *cpu)
+{
+	unsigned int max_cap_perf;
+
+	mutex_lock(&hybrid_capacity_lock);
+
+	if (!hybrid_max_perf_cpu)
+		goto unlock;
+
+	/*
+	 * The maximum performance of the CPU may have changed, but assume
+	 * that the performance of the other CPUs has not changed.
+	 */
+	max_cap_perf = hybrid_max_perf_cpu->capacity_perf;
+
+	intel_pstate_get_hwp_cap(cpu);
+
+	hybrid_get_capacity_perf(cpu);
+	/* Should hybrid_max_perf_cpu be replaced by this CPU? */
+	if (cpu->capacity_perf > max_cap_perf) {
+		hybrid_max_perf_cpu = cpu;
+		hybrid_set_capacity_of_cpus();
+		goto unlock;
+	}
+
+	/* If this CPU is hybrid_max_perf_cpu, should it be replaced? */
+	if (cpu == hybrid_max_perf_cpu && cpu->capacity_perf < max_cap_perf) {
+		hybrid_update_cpu_scaling();
+		goto unlock;
+	}
+
+	hybrid_set_cpu_capacity(cpu);
+
+unlock:
+	mutex_unlock(&hybrid_capacity_lock);
+}
+
 static void intel_pstate_hwp_set(unsigned int cpu)
 {
 	struct cpudata *cpu_data = all_cpu_data[cpu];
@@ -1070,6 +1216,22 @@ static void intel_pstate_hwp_offline(str
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 
 	wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+
+	mutex_lock(&hybrid_capacity_lock);
+
+	if (!hybrid_max_perf_cpu) {
+		mutex_unlock(&hybrid_capacity_lock);
+
+		return;
+	}
+
+	if (hybrid_max_perf_cpu == cpu)
+		hybrid_update_cpu_scaling();
+
+	mutex_unlock(&hybrid_capacity_lock);
+
+	/* Reset the capacity of the CPU going offline to the initial value. */
+	hybrid_clear_cpu_capacity(cpu->cpu);
 }
 
 #define POWER_CTL_EE_ENABLE	1
@@ -1165,21 +1327,46 @@ static void __intel_pstate_update_max_fr
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+	struct cpudata *cpudata;
 
 	if (!policy)
 		return;
 
-	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
+	cpudata = all_cpu_data[cpu];
+
+	__intel_pstate_update_max_freq(cpudata, policy);
+
+	/* Prevent the driver from being unregistered now. */
+	mutex_lock(&intel_pstate_driver_lock);
 
 	cpufreq_cpu_release(policy);
+
+	hybrid_update_capacity(cpudata);
+
+	mutex_unlock(&intel_pstate_driver_lock);
 }
 
 static void intel_pstate_update_limits_for_all(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
-		intel_pstate_update_limits(cpu);
+	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+
+		if (!policy)
+			continue;
+
+		__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
+
+		cpufreq_cpu_release(policy);
+	}
+
+	mutex_lock(&hybrid_capacity_lock);
+
+	if (hybrid_max_perf_cpu)
+		__hybrid_init_cpu_scaling();
+
+	mutex_unlock(&hybrid_capacity_lock);
 }
 
 /************************** sysfs begin ************************/
@@ -1618,6 +1805,13 @@ static void intel_pstate_notify_work(str
 		__intel_pstate_update_max_freq(cpudata, policy);
 
 		cpufreq_cpu_release(policy);
+
+		/*
+		 * The driver will not be unregistered while this function is
+		 * running, so update the capacity without acquiring the driver
+		 * lock.
+		 */
+		hybrid_update_capacity(cpudata);
 	}
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
@@ -2034,8 +2228,10 @@ static void intel_pstate_get_cpu_pstates
 
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
-			if (cpu->pstate.scaling != perf_ctl_scaling)
+			if (cpu->pstate.scaling != perf_ctl_scaling) {
 				intel_pstate_hybrid_hwp_adjust(cpu);
+				hwp_is_hybrid = true;
+			}
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
@@ -2703,6 +2899,8 @@ static int intel_pstate_cpu_online(struc
 		 */
 		intel_pstate_hwp_reenable(cpu);
 		cpu->suspended = false;
+
+		hybrid_update_capacity(cpu);
 	}
 
 	return 0;
@@ -3143,6 +3341,20 @@ static int intel_pstate_register_driver(
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	/*
+	 * On hybrid systems, use asym capacity instead of ITMT, but because
+	 * the capacity of SMT threads is not deterministic even approximately,
+	 * do not do that when SMT is in use.
+	 */
+	if (hwp_is_hybrid && !sched_smt_active() &&
+	    arch_enable_hybrid_capacity_scale()) {
+		sched_clear_itmt_support();
+
+		hybrid_init_cpu_scaling();
+
+		arch_rebuild_sched_domains();
+	}
+
 	return 0;
 }
 




