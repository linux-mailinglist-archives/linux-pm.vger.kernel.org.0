Return-Path: <linux-pm+bounces-25571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CCA90B11
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CD93ABE00
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575821C176;
	Wed, 16 Apr 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LPV+bduJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949D217736;
	Wed, 16 Apr 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827172; cv=none; b=n1o360TmuGviNPA7IMfdXB+kFwQORZ7Hk3Dc0EOgEQfoe/NEvB1/je55HGfNpx1X5IYKQAAQa9D86J0WjtJ4BVmc5WTXAEh34Tx5CYvQ4YJnHlSYBGuxbjO2KonsZdlhYE96ZIe0HdzTQi7/YdBJCULjCVIPQjtv9qHak8DSYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827172; c=relaxed/simple;
	bh=DXUwgGsGvG1/FNFayBBE1LosHw9IhrInavjio6JOKeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMJJBzdPZ4sbPJ6pr/xL1QB71pFv0EWbFp6NPfwjEcCSvIejh/hI3+dIarD3fmwyAVDGHvI3d2Wd3OORzAx1+VewcRVDZIucjwJ8oWFsifcB1IIMHpfxg3HqZGt90hRt8M4MrCOg+Mp4sgz0WyRDKSCUL6eMNOCDduX6qS3dB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LPV+bduJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 87078662716;
	Wed, 16 Apr 2025 20:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827168;
	bh=DXUwgGsGvG1/FNFayBBE1LosHw9IhrInavjio6JOKeA=;
	h=From:Subject:Date;
	b=LPV+bduJXxOuHGIEbiTz+tZwTeoTWAxtp8AxpV5HoSjwIkhL/7DWlisfz62QLMYev
	 e6e6EU/KSeXohwltMr6jAhPG/F3GTVDPWWhtfchcJ5o/3o6kVasSeTX7iKISidTr72
	 Yw1Cdl9WchOKIrc3NY4+UEwFmnTV4FASUOhAwgphM/cD5r/agytG9/DmVXXVeLTpl0
	 hyj8r/3KMzI45JidFtzPlfFfy7ASqXWOl1RcAPoyMuYbUzFYQPr7RtaDADwwbB+I60
	 h7vX2oCkkueh7Ixf9k8vZKnPppRBDN5ZaAfNvKs2w7oog67ydGnaEzHVfdFiOWxzbl
	 DrrXLwcvwVbYw==
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
 Christian Loehle <christian.loehle@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>
Subject:
 [RFT][PATCH v1 6/8] cpufreq: intel_pstate: EAS support for hybrid platforms
Date: Wed, 16 Apr 2025 20:09:38 +0200
Message-ID: <3682828.R56niFO833@rjwysocki.net>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
References: <3344336.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify intel_pstate to register EM perf domains for CPUs on hybrid
platforms and enable EAS on them.

This change is targeting platforms (for example, Lunar Lake) where the
"little" CPUs (E-cores) are always more energy-efficient than the "big"
or "performance" CPUs (P-cores) when run at the same HWP performance
level, so it is sufficient to tell EAS that E-cores are always preferred
(so long as there is enough spare capacity on one of them to run the
given task).  However, migrating tasks between CPUs of the same type
too often is not desirable because it may hurt both performance and
energy efficiency due to leaving warm caches behind.

For this reason, register a separate perf domain for each CPU and assign
costs for them so that the cost mostly depends on the CPU type, but
there is also a small component of it depending on the performance
level (utilization) which allows to avoid substantial load imbalances
between CPUs of the same type.

The observation used here is that the IPC metric value for a given CPU
is inversely proportional to its performance-to-frequency scaling factor
and the cost of running on it can be assumed to be roughly proportional
to that IPC ratio (in principle, the higher the IPC ratio, the more
resources are utilized when running at a given frequency, so the cost
should be higher).  This main component of the cost is amended with a
small addition proportional performance.

EM perf domains for all CPUs that are online during system startup are
registered at the driver initialization time, after asymmetric capacity
support has been enabled.  For the CPUs that become online later, EM
perf domains are registered after setting the asymmetric capacity for
them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.3 -> v1:
     * Relocated INTEL_PSTATE_CORE_SCALING define (Tim).
     * Rephrased a comment regarding EAS disabling (Tim).

---
 drivers/cpufreq/intel_pstate.c |  131 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -221,6 +221,7 @@
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
+ * @em_registered:	If set, an energy model has been registered.
  * @hwp_notify_work:	workqueue for HWP notifications.
  *
  * This structure stores per CPU instance data for all CPUs.
@@ -260,6 +261,9 @@
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
+#ifdef CONFIG_ENERGY_MODEL
+	bool em_registered;
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
@@ -945,12 +950,105 @@
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
+	if (!hybrid_max_perf_cpu || cpudata->em_registered)
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
+	cpudata->em_registered = true;
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
+	if (cpu->em_registered)
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
@@ -1039,6 +1137,11 @@
 	guard(mutex)(&hybrid_capacity_lock);
 
 	__hybrid_refresh_cpu_capacity_scaling();
+	/*
+	 * Perf domains are not registered before setting hybrid_max_perf_cpu,
+	 * so register them all after setting up CPU capacity scaling.
+	 */
+	hybrid_register_all_perf_domains();
 }
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
@@ -1066,7 +1169,7 @@
 		hybrid_refresh_cpu_capacity_scaling();
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-		 * packing and enable asym capacity.
+		 * packing and enable asym capacity and EAS.
 		 */
 		sched_clear_itmt_support();
 	}
@@ -1144,6 +1247,14 @@
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
@@ -3397,6 +3508,8 @@
 
 static int intel_pstate_update_status(const char *buf, size_t size)
 {
+	int ret = -EINVAL;
+
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
 			return -EINVAL;
@@ -3406,6 +3519,8 @@
 
 		cpufreq_unregister_driver(intel_pstate_driver);
 		intel_pstate_driver_cleanup();
+		/* Disable EAS support in case it was used. */
+		rebuild_sched_domains_energy();
 		return 0;
 	}
 
@@ -3417,7 +3532,13 @@
 			cpufreq_unregister_driver(intel_pstate_driver);
 		}
 
-		return intel_pstate_register_driver(&intel_pstate);
+		ret = intel_pstate_register_driver(&intel_pstate);
+		/*
+		 * If the previous status had been "passive" and the schedutil
+		 * governor had been used, it disabled EAS on exit, so trigger
+		 * sched domains rebuild in case EAS needs to be enabled again.
+		 */
+		rebuild_sched_domains_energy();
 	}
 
 	if (size == 7 && !strncmp(buf, "passive", size)) {
@@ -3429,10 +3550,10 @@
 			intel_pstate_sysfs_hide_hwp_dynamic_boost();
 		}
 
-		return intel_pstate_register_driver(&intel_cpufreq);
+		ret = intel_pstate_register_driver(&intel_cpufreq);
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static int no_load __initdata;




