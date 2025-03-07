Return-Path: <linux-pm+bounces-23648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02FDA57248
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66867A5A3E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773A254858;
	Fri,  7 Mar 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PZZ9TQBF"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE5250BFB;
	Fri,  7 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376570; cv=none; b=Lyss55xg/tNbp0TZcFsZ5nE1J3L2vRt5wAHOVuNJ+7bD41I1Lh5k6rIJfsX2EY42sn12XxDd/2s0mQ1I3uhSLydoZ6KAerEDNGd5YudJ1Xam/3XJlHQiwsovDE7FGY+PvdteUNWm0ahPJ3jmoMNI0RmNuRzBFZhexut8laO/D3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376570; c=relaxed/simple;
	bh=DwNi7b0jPHaorTviJwSdwnOCF3DHeAnTIYNUscDbSYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIVplHcwHB6G7YK9NOcejlJnPfwXrc1I05fWeGQMg2aoieO/BcYCY/fKVt6GDnG9uv5f1Q3hajjtaVAdy88K6uiNJF4PvuEE9PmDqmw2VTsd8iH1LmNEhxoYRa8xdG46eEEeCisWwnh+msHLCeOFiIkoKaMuVkgpsSDQ26nF7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PZZ9TQBF; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 8209ea52667ca11d; Fri, 7 Mar 2025 20:42:40 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6D62A9A0BFB;
	Fri,  7 Mar 2025 20:42:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376560;
	bh=DwNi7b0jPHaorTviJwSdwnOCF3DHeAnTIYNUscDbSYI=;
	h=From:Subject:Date;
	b=PZZ9TQBFL7jVqSGfV6sk6l7gGCrnzavWmssV8pe5CoO7wh1MLz/ucu1suetSin9Tw
	 nAuDjpB2psRvilPClAR3kjHDxQue11DKpdKfUS7/ECpmMRY1Q6XUwu3zB+9GYtOvlJ
	 n4fsfBH97qHM5uq7bI7Ca+g4QiNoIhbuGiCzfE79+uNOnO8TazVq9emXS4DfW4ObOq
	 V0POLJ+phxib3fR1yL9pYiQwN2v+7rbBjj3+z1SNJCL+2OK8LI0Srp5gMb/ZA4csRR
	 IZq03PiQHI1inuJlEqHdkDbHRzScOTVmQfUGPXTi3993cGA9BGYWk95ZvjW2NnxZNh
	 NgiOErt4aRaCw==
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
 [RFC][PATCH v0.3 6/6] cpufreq: intel_pstate: EAS support for hybrid platforms
Date: Fri, 07 Mar 2025 20:42:28 +0100
Message-ID: <2028801.yKVeVyVuyW@rjwysocki.net>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
References: <22640172.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

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
 drivers/cpufreq/intel_pstate.c |  132 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -44,6 +44,8 @@
 #define INTEL_CPUFREQ_TRANSITION_DELAY_HWP	5000
 #define INTEL_CPUFREQ_TRANSITION_DELAY		500
 
+#define INTEL_PSTATE_CORE_SCALING		100000
+
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -221,6 +223,7 @@
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
+ * @em_registered:	If set, an energy model has been registered.
  * @hwp_notify_work:	workqueue for HWP notifications.
  *
  * This structure stores per CPU instance data for all CPUs.
@@ -260,6 +263,9 @@
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
+#ifdef CONFIG_ENERGY_MODEL
+	bool em_registered;
+#endif
 	struct delayed_work hwp_notify_work;
 };
 
@@ -311,7 +317,7 @@
 
 static inline int core_get_scaling(void)
 {
-	return 100000;
+	return INTEL_PSTATE_CORE_SCALING;
 }
 
 #ifdef CONFIG_ACPI
@@ -945,12 +951,105 @@
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
@@ -1039,6 +1138,11 @@
 	guard(mutex)(&hybrid_capacity_lock);
 
 	__hybrid_refresh_cpu_capacity_scaling();
+	/*
+	 * Perf domains are not registered before setting hybrid_max_perf_cpu,
+	 * so register them all after setting up CPU capacity scaling.
+	 */
+	hybrid_register_all_perf_domains();
 }
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
@@ -1066,7 +1170,7 @@
 		hybrid_refresh_cpu_capacity_scaling();
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-		 * packing and enable asym capacity.
+		 * packing and enable asym capacity and EAS.
 		 */
 		sched_clear_itmt_support();
 	}
@@ -1144,6 +1248,14 @@
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
@@ -3416,6 +3528,8 @@
 
 static int intel_pstate_update_status(const char *buf, size_t size)
 {
+	int ret = -EINVAL;
+
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
 			return -EINVAL;
@@ -3425,6 +3539,8 @@
 
 		cpufreq_unregister_driver(intel_pstate_driver);
 		intel_pstate_driver_cleanup();
+		/* Trigger EAS support reconfiguration in case it was used. */
+		rebuild_sched_domains_energy();
 		return 0;
 	}
 
@@ -3436,7 +3552,13 @@
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
@@ -3448,10 +3570,10 @@
 			intel_pstate_sysfs_hide_hwp_dynamic_boost();
 		}
 
-		return intel_pstate_register_driver(&intel_cpufreq);
+		ret = intel_pstate_register_driver(&intel_cpufreq);
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static int no_load __initdata;




