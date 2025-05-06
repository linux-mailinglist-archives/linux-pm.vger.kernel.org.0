Return-Path: <linux-pm+bounces-26750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C19AACEF1
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E81C201F5
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD31C84C0;
	Tue,  6 May 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DVgMwE1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C215442A;
	Tue,  6 May 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564584; cv=none; b=sYcqT3tZCZX4rua3u5TXR2/R3eQgYeZI7ltVnUy3X6gkzsgyI30fnMlnGtB6enVwM0GSjX0XqzJdrBqrVCucug6WJOhmX7kwM53RKredcF2Tdqo/DEqacDxZ8h+HZ5pZU730+Wy0K1v/62wLUnMq4u70AtTbyAeqobsspBiXUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564584; c=relaxed/simple;
	bh=y9O0cKWr/GhlP3nisOVEX/6jmqzzdahTsgDvin4Izz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwMrWm3DMENdakHfO8UacLxwTmTZNkAF1z4xpOIWEABObaf8LFr7wYHlR4fvc9VWtNyptsbHVT1F6Q15kh7O4bF9/g7FUHW5Ngpva+bsL3RfaYopGzFhyhhf8CeM8DyRqbZxido9EokWQMsjysNo0SZtGijFz5HA6KdIat12Oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DVgMwE1g; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8D04C666BAC;
	Tue,  6 May 2025 22:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564574;
	bh=y9O0cKWr/GhlP3nisOVEX/6jmqzzdahTsgDvin4Izz0=;
	h=From:Subject:Date;
	b=DVgMwE1gPNPtDts3zflWnnaNsIydvFucL/gIiLIamonNDsjMGj8ebtXMRMjcNKh5x
	 ePTRApCGbGeSfxcSQM/e2ed6PES0i6ilBy04vaFLjjb9J+jTghtA7AtUyVZFKXWDcJ
	 eiWQO0HuJYVXcsEeKX6pRU5pfkNAWKbBWdxe70nudX/AFZZ9Ebd8JcH1GX9zzE/P9K
	 3nKHEaFoTtdxnOuWMiUE878CMNQI+DGfL5tgRM4+7D33t3LP3H2hSZd63FAhECkcRX
	 BszCrr0sdF4qYBz3Bob5VGyRzg3GAKtsohup1fWVm2q+BUdus1I+Yv05VOmIqb0eWx
	 KV3Q+6+2EFaOg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v2 5/7] cpufreq: intel_pstate: EAS support for hybrid platforms
Date: Tue, 06 May 2025 22:44:30 +0200
Message-ID: <6057101.MhkbZ0Pkbq@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify intel_pstate to register EM perf domains for CPUs on hybrid
platforms without SMT which causes EAS to be enabled on them when
schedutil is used as the cpufreq governor (which requires intel_pstate
to operate in the passive mode).

This change is targeting platforms (for example, Lunar Lake) where the
"little" CPUs (E-cores) are always more energy-efficient than the "big"
or "performance" CPUs (P-cores) when run at the same HWP performance
level, so it is sufficient to tell EAS that E-cores are always preferred
(so long as there is enough spare capacity on one of them to run the
given task).  However, migrating tasks between CPUs of the same type
too often is not desirable because it may hurt both performance and
energy efficiency due to leaving warm caches behind.

For this reason, register a separate perf domain for each CPU and choose
the cost values for them so that the cost mostly depends on the CPU type,
but there is also a small component of it depending on the performance
level (utilization) which helps to balance the load between CPUs of the
same type.

The cost component related to the CPU type is computed with the help of
the observation that the IPC metric value for a given CPU is inversely
proportional to its performance-to-frequency scaling factor and the cost
of running code on it can be assumed to be roughly proportional to that
IPC ratio (in principle, the higher the IPC ratio, the more resources
are utilized when running at a given frequency, so the cost should be
higher).

For all CPUs that are online at the system initialization time, EM perf
domains are registered when the driver starts up, after asymmetric
capacity support has been enabled.  For the CPUs that become online
later, EM perf domains are registered after setting the asymmetric
capacity for them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v1 -> v2:
   * Drop changes that were needed for EAS to work without schedutil.
   * Rename em_registered to pd_registered.
   * Adjust the changelog.
   * Pick up tags.

---
 drivers/cpufreq/intel_pstate.c |  115 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -221,6 +221,7 @@
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
+ * @pd_registered:	Set when a perf domain is registered for this CPU.
  * @hwp_notify_work:	workqueue for HWP notifications.
  *
  * This structure stores per CPU instance data for all CPUs.
@@ -260,6 +261,9 @@
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
+#ifdef CONFIG_ENERGY_MODEL
+	bool pd_registered;
+#endif
 	struct delayed_work hwp_notify_work;
 };
 
@@ -303,6 +307,7 @@
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
+#define INTEL_PSTATE_CORE_SCALING	100000
 #define HYBRID_SCALING_FACTOR_ADL	78741
 #define HYBRID_SCALING_FACTOR_MTL	80000
 #define HYBRID_SCALING_FACTOR_LNL	86957
@@ -311,7 +316,7 @@
 
 static inline int core_get_scaling(void)
 {
-	return 100000;
+	return INTEL_PSTATE_CORE_SCALING;
 }
 
 #ifdef CONFIG_ACPI
@@ -948,12 +953,105 @@
  */
 static DEFINE_MUTEX(hybrid_capacity_lock);
 
+#ifdef CONFIG_ENERGY_MODEL
+#define HYBRID_EM_STATE_COUNT	4
+
+static int hybrid_active_power(struct device *dev, unsigned long *power,
+			       unsigned long *freq)
+{
+	/*
+	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
+	 * of the maximum capacity such that two CPUs of the same type will be
+	 * regarded as equally attractive if the utilization of each of them
+	 * falls into the same bin, which should prevent tasks from being
+	 * migrated between them too often.
+	 *
+	 * For this purpose, return the "frequency" of 2 for the first
+	 * performance level and otherwise leave the value set by the caller.
+	 */
+	if (!*freq)
+		*freq = 2;
+
+	/* No power information. */
+	*power = EM_MAX_POWER;
+
+	return 0;
+}
+
+static int hybrid_get_cost(struct device *dev, unsigned long freq,
+			   unsigned long *cost)
+{
+	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
+
+	/*
+	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
+	 * ratio between the given CPU and the least capable CPU in the system.
+	 * Regard that IPC ratio as the primary cost component and assume that
+	 * the scaling factors for different CPU types will differ by at least
+	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
+	 *
+	 * Add the freq value to the cost, so that the cost of running on CPUs
+	 * of the same type in different "utilization bins" is different.
+	 */
+	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
+
+	return 0;
+}
+
+static bool hybrid_register_perf_domain(unsigned int cpu)
+{
+	static const struct em_data_callback cb
+			= EM_ADV_DATA_CB(hybrid_active_power, hybrid_get_cost);
+	struct cpudata *cpudata = all_cpu_data[cpu];
+	struct device *cpu_dev;
+
+	/*
+	 * Registering EM perf domains without enabling asymmetric CPU capacity
+	 * support is not really useful and one domain should not be registered
+	 * more than once.
+	 */
+	if (!hybrid_max_perf_cpu || cpudata->pd_registered)
+		return false;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return false;
+
+	if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
+					cpumask_of(cpu), false))
+		return false;
+
+	cpudata->pd_registered = true;
+
+	return true;
+}
+
+static void hybrid_register_all_perf_domains(void)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		hybrid_register_perf_domain(cpu);
+}
+
+static void hybrid_update_perf_domain(struct cpudata *cpu)
+{
+	if (cpu->pd_registered)
+		em_adjust_cpu_capacity(cpu->cpu);
+}
+#else /* !CONFIG_ENERGY_MODEL */
+static inline bool hybrid_register_perf_domain(unsigned int cpu) { return false; }
+static inline void hybrid_register_all_perf_domains(void) {}
+static inline void hybrid_update_perf_domain(struct cpudata *cpu) {}
+#endif /* CONFIG_ENERGY_MODEL */
+
 static void hybrid_set_cpu_capacity(struct cpudata *cpu)
 {
 	arch_set_cpu_capacity(cpu->cpu, cpu->capacity_perf,
 			      hybrid_max_perf_cpu->capacity_perf,
 			      cpu->capacity_perf,
 			      cpu->pstate.max_pstate_physical);
+	hybrid_update_perf_domain(cpu);
 
 	pr_debug("CPU%d: perf = %u, max. perf = %u, base perf = %d\n", cpu->cpu,
 		 cpu->capacity_perf, hybrid_max_perf_cpu->capacity_perf,
@@ -1042,6 +1140,11 @@
 	guard(mutex)(&hybrid_capacity_lock);
 
 	__hybrid_refresh_cpu_capacity_scaling();
+	/*
+	 * Perf domains are not registered before setting hybrid_max_perf_cpu,
+	 * so register them all after setting up CPU capacity scaling.
+	 */
+	hybrid_register_all_perf_domains();
 }
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
@@ -1069,7 +1172,7 @@
 		hybrid_refresh_cpu_capacity_scaling();
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-		 * packing and enable asym capacity.
+		 * packing and enable asym capacity and EAS.
 		 */
 		sched_clear_itmt_support();
 	}
@@ -1147,6 +1250,14 @@
 	}
 
 	hybrid_set_cpu_capacity(cpu);
+	/*
+	 * If the CPU was offline to start with and it is going online for the
+	 * first time, a perf domain needs to be registered for it if hybrid
+	 * capacity scaling has been enabled already.  In that case, sched
+	 * domains need to be rebuilt to take the new perf domain into account.
+	 */
+	if (hybrid_register_perf_domain(cpu->cpu))
+		em_rebuild_sched_domains();
 
 unlock:
 	mutex_unlock(&hybrid_capacity_lock);




