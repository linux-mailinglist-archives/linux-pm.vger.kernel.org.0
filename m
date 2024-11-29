Return-Path: <linux-pm+bounces-18247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4334F9DEAF3
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C466B21C35
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F71974FE;
	Fri, 29 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="SXIhg6v/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B614600C;
	Fri, 29 Nov 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897710; cv=none; b=hsVqN6T5QJmJaR4lEtJ9NxiFUN0JLnPUQrI1+RUfIMGG3lFxPqoPPcv720dLUV86zA7dNDi4RjeYxowdzij7OKACcHeCbz6c7XYbxED4Ar0+OhkRLmJ0QoiGXrgbeEpfeT215d432hwGLHLMi0dvL3zPSj7d1W+YIoejLBJlmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897710; c=relaxed/simple;
	bh=IWjmn1yIhP+LrnlCgE1nt0YBoOITdeu5KNHqPaIxTUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbJtVafEWW88xrRZnBxuN/xfETyff2v+sXw/KYk4ZLlV+2OB7dnk/03iD9WFnwyiPzooPClgG5KDzDSJyDf0y0/3YMeObxKlVIYM04fy5sNnzdKN6RAHILfxQrdV82eS3SlZbGvb7vK5QeOkoK5VrfIPdSdXTBDhnJnb9XReBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=SXIhg6v/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id bec5d256e9aad60d; Fri, 29 Nov 2024 17:28:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CDDE1A47B8B;
	Fri, 29 Nov 2024 17:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897699;
	bh=IWjmn1yIhP+LrnlCgE1nt0YBoOITdeu5KNHqPaIxTUs=;
	h=From:Subject:Date;
	b=SXIhg6v/vEeNjGzbYz1zWFdGfGW2lEflOMBkI7TfnRd1CRnZhuOfnspfkLa3RDXWj
	 m5wzGQ+l+W7fnvg4i7y/v4DDFT3NzqgIcQlDhcWWOyDWWuQBQuS+HAUoS0oR9yeRyQ
	 ChD1vyMQafRTcCIIvJ3xK2Afg9HQ4TjoBIZH+daLJTytdW1YklogmsKiZ7dmf+lmLj
	 Z/QAxUyxAtwL8SV0AUlDrDwNsFheKHwI3702KD+evPHiU40PrRzSAHqXGifY93nrgr
	 fg+LlyniZf89db84dzBY14Jt/ZO4pExipx3qxes9ssxfaqJvl1I2agkd9smZ1o3g0K
	 uwbBJb4rDC3KA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Subject:
 [RFC][PATCH v021 9/9] cpufreq: intel_pstate: Add basic EAS support on hybrid
 platforms
Date: Fri, 29 Nov 2024 17:28:12 +0100
Message-ID: <4414387.ejJDZkT8p0@rjwysocki.net>
In-Reply-To: <5861970.DvuYhMxLoT@rjwysocki.net>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify intel_pstate to register EM perf domains for hybrid domains,
introduced previously, via em_dev_register_perf_domain(), and to use
em_dev_expand_perf_domain(), also introduced previously, for adding
new CPUs to existing EM perf domains when those CPUs become online for
the first time after driver initialization.

This change is targeting platforms (for example, Lunar Lake) where the
"little" CPUs (E-cores) are always more energy-efficient than the "big"
or "performance" CPUs (P-cores) when run at the same HWP performance
level, so it is sufficient to tell EAS that E-cores are always preferred
(so long as there is enough spare capacity on one of them to run the
given task).

Accordingly, an EM perf domain with 1-element states array is registered
for each hybrid domain in the system and each of them is assigned a
single cost value.

The observation used here is that the IPC ratio between the CPUs in a
given hybrid domain is inversely proportional to their performance-to-
frequency scaling factor (which must be the same for all of them) and
the cost of running on one of them can be assumed to be proportional
to that IPC ratio (in principle, the higher the IPC ratio, the more
resources are utilized when running at a given frequency, so the cost
should be higher).

EM perf domains for all CPUs that are online during system startup are
registered at the driver initialization time, after asymmetric capacity
support has been enabled.  For the CPUs that become online later and
do not belong to any existing hybrid domain, an EM perf domain is
registered when the hybrid domain for the given CPU is created.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.1 -> v0.2:
     * Some changes have been dropped because patch [8/9] takes
       care of what they did now.
     * Some corner cases related to changing driver operation modes
       are now handled.

For now, I'm sticking to the idea of having one "effective OPP" per
EM perf domain because (a) it should be sufficient for the target
use case IIUC and (b) anything more complex would need to be tied to
the capacity updates carried out by intel_pstate and that would be
a much heavier lifting.

Besides, I'd generally prefer to avoid updating the energy model on
every CPU capacity update because that might need to happen too often.

If my understanding of this thread is correct:

https://lore.kernel.org/lkml/20240830130309.2141697-1-vincent.guittot@linaro.org/

if there is only one "OPP" per perf domain, within a perf domain EAS will
look for a CPU with the highest spare capacity which is exactly what I
want and it will generally prefer domains with the lower cost values.

So far, I'm not aware of any upcoming hybrid platforms with significant
cross-over points between power-performance curves for different types
of CPUs, so the current approach (possibly with the addition of some kind
of load balancing) should be sufficient for them.

If such cross-over points become an issue the future, more complete energy
models will need to be used for systems where they are present, but that
will require solving the problem with scaling the performance numbers in
the states table to the current CPU capacity at init time.

---
 drivers/cpufreq/intel_pstate.c |   83 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -950,12 +950,67 @@ static DEFINE_MUTEX(hybrid_capacity_lock
  */
 struct hybrid_domain {
 	struct hybrid_domain *next;
+	struct device *dev;
 	cpumask_t cpumask;
 	int scaling;
 };
 
 static struct hybrid_domain *hybrid_domains;
 
+static int hybrid_get_cost(struct device *dev, unsigned long freq_not_used,
+			   unsigned long *cost)
+{
+	struct pstate_data *pd = &all_cpu_data[dev->id]->pstate;
+
+	/*
+	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
+	 * ratio between the CPUs in the given domain and the least capable CPU
+	 * in the system.  Assume the cost to be proportional to that IPC ratio
+	 * (and note that perf_ctl_scaling is always the same for all CPUs in
+	 * the system and it is equal to the perf-to-frequency scaling factor
+	 * for one CPU type).
+	 */
+	*cost = div_u64(100ULL * pd->perf_ctl_scaling, pd->scaling);
+
+	return 0;
+}
+
+static bool hybrid_register_perf_domain(struct hybrid_domain *hd)
+{
+	static struct em_data_callback em_cb = EM_ADV_DATA_CB(NULL, hybrid_get_cost);
+
+	/*
+	 * Registering EM perf domains without enabling asymmetric CPU capacity
+	 * support is not really useful and one domain should not be registered
+	 * more than once.
+	 */
+	if (!hybrid_max_perf_cpu || hd->dev)
+		return false;
+
+	hd->dev = get_cpu_device(cpumask_any(&hd->cpumask));
+	if (!hd->dev)
+		return false;
+
+	/*
+	 * Use one EM state in each domain to indicate that the cost associated
+	 * with it applies to all CPUs in it regardless of the frequency.
+	 */
+	if (em_dev_register_perf_domain(hd->dev, 1, &em_cb, &hd->cpumask, false)) {
+		hd->dev = NULL;
+		return false;
+	}
+
+	return true;
+}
+
+static void hybrid_register_all_perf_domains(void)
+{
+	struct hybrid_domain *hd;
+
+	for (hd = hybrid_domains; hd; hd = hd->next)
+		hybrid_register_perf_domain(hd);
+}
+
 static void hybrid_add_to_domain(struct cpudata *cpudata)
 {
 	int scaling = cpudata->pstate.scaling;
@@ -975,6 +1030,8 @@ static void hybrid_add_to_domain(struct
 				return;
 
 			cpumask_set_cpu(cpu, &hd->cpumask);
+			if (hd->dev)
+				em_dev_expand_perf_domain(hd->dev, cpu);
 
 			pr_debug("CPU %d added to hybrid domain %*pbl\n", cpu,
 				 cpumask_pr_args(&hd->cpumask));
@@ -991,11 +1048,14 @@ static void hybrid_add_to_domain(struct
 	hd->scaling = scaling;
 	hd->next = hybrid_domains;
 	hybrid_domains = hd;
+	if (hybrid_register_perf_domain(hd))
+		em_rebuild_perf_domains();
 
 	pr_debug("New hybrid domain %*pbl: scaling = %d\n",
 		 cpumask_pr_args(&hd->cpumask), hd->scaling);
 }
 #else /* CONFIG_ENERGY_MODEL */
+static inline void hybrid_register_all_perf_domains(void) {}
 static inline void hybrid_add_to_domain(struct cpudata *cpudata) {}
 #endif /* !CONFIG_ENERGY_MODEL */
 
@@ -1093,6 +1153,11 @@ static void hybrid_refresh_cpu_capacity_
 	guard(mutex)(&hybrid_capacity_lock);
 
 	__hybrid_refresh_cpu_capacity_scaling();
+	/*
+	 * Perf domains are not registered before setting hybrid_max_perf_cpu,
+	 * so register them all after setting up CPU capacity scaling.
+	 */
+	hybrid_register_all_perf_domains();
 }
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
@@ -1116,7 +1181,7 @@ static void hybrid_init_cpu_capacity_sca
 		hybrid_refresh_cpu_capacity_scaling();
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-		 * packing and enable asym capacity.
+		 * packing and enable asym capacity and EAS.
 		 */
 		sched_clear_itmt_support();
 	}
@@ -3467,6 +3532,8 @@ static ssize_t intel_pstate_show_status(
 
 static int intel_pstate_update_status(const char *buf, size_t size)
 {
+	int ret = -EINVAL;
+
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
 			return -EINVAL;
@@ -3476,6 +3543,8 @@ static int intel_pstate_update_status(co
 
 		cpufreq_unregister_driver(intel_pstate_driver);
 		intel_pstate_driver_cleanup();
+		/* Trigger EAS support reconfiguration in case it was used. */
+		rebuild_sched_domains_energy();
 		return 0;
 	}
 
@@ -3487,7 +3556,13 @@ static int intel_pstate_update_status(co
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
@@ -3499,10 +3574,10 @@ static int intel_pstate_update_status(co
 			intel_pstate_sysfs_hide_hwp_dynamic_boost();
 		}
 
-		return intel_pstate_register_driver(&intel_cpufreq);
+		ret = intel_pstate_register_driver(&intel_cpufreq);
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static int no_load __initdata;




