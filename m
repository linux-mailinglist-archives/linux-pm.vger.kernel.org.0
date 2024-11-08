Return-Path: <linux-pm+bounces-17216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109839C2253
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F2F1C22947
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF2198E85;
	Fri,  8 Nov 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GFi6Drdo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604513B29F;
	Fri,  8 Nov 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084394; cv=none; b=D7gtQ5AtqNKJZWuRP6cIX4n5U4VWAPFDSLdWfikN1kxNvcLRw22i7nkLebNfoyD8uVKNyJntkwRIXnw0kp/rFFDq8+QHO+G863x8bTzzClE3eTFaot/LVmCPJxV0K5Mt8QQMYIMTzG/X30LKz0n0kd0qc9zqCBQKZiHzNNKOZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084394; c=relaxed/simple;
	bh=j7p+8eYkmatrxwpdXfGxJJavtt0xbw5+drzotrnuAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkPiD5tpLeyOCBwKELmB9JDScYTBn0zwLi2HKitinZXQ8zIHN4aDptm8hKPkxMOCapIgq2iUDsAHbGNfyVWNId/HUwpGNomp4yp2Pu5kxK9y9SwvWNhcqGhv2WyrIjN1yg/EFRX33E5T0tmrNsqUEEPmTrdoR1YMUoeTj6kz2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GFi6Drdo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id eab63553db22e5e7; Fri, 8 Nov 2024 17:46:23 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4598E8384AE;
	Fri,  8 Nov 2024 17:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084383;
	bh=j7p+8eYkmatrxwpdXfGxJJavtt0xbw5+drzotrnuAXQ=;
	h=From:Subject:Date;
	b=GFi6DrdoBt35wiSU0ClHNrocWF1/GSQ2cq9ryJyd/CvrpestHEWl2RWvxGOwZBece
	 G82x7T8kq6lirpymncOvhZ6AtbTnoPf77xGK6TZAqs63sdbsgv9NOMTyRMw5IEeC1A
	 alMWbBN3O1wE8G+VMAIyngo6Ouj0NOMKpw8AiR2NjrB4Q6sAwaR0MJqcz9TPsl2l4g
	 AWskBB2rw8M4EkZt3eI7shcaaVzoun+WJwjh3YaCC6B8lJHMGMNdipB+t2+wOsPscV
	 xX3pQwxL/nmAPoMmO37Zc6AJuvxNf44uQiG3ERed6XvlzKDv/FslYsDnke9b9Wxbnd
	 a18eqWAHXI+4A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS support on hybrid
 platforms
Date: Fri, 08 Nov 2024 17:46:13 +0100
Message-ID: <115421572.nniJfEyVGO@rjwysocki.net>
In-Reply-To: <3607404.iIbC2pHGDl@rjwysocki.net>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 0; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify intel_pstate to register stub EM perf domains for CPUs on
hybrid platforms via em_dev_register_perf_domain() and to use
em_dev_expand_perf_domain() introduced previously for adding new
CPUs to existing EM perf domains when those CPUs become online for
the first time after driver initialization.

This change is targeting platforms (for example, Lunar Lake) where
"small" CPUs (E-cores) are always more energy-efficient than the "big"
or "performance" CPUs (P-cores) when run at the same HWP performance
level, so it is sufficient to tell the EAS that E-cores are always
preferred (so long as there is enough spare capacity on one of them
to run the given task).

Accordingly, the perf domains are registered per CPU type (that is,
all P-cores belong to one perf domain and all E-cores belong to another
perf domain) and they are registered only if asymmetric CPU capacity is
enabled.  Each perf domain has a one-element states table and that
element only contains the relative cost value (the other fields in
it are not initialized, so they are all equal to zero), and the cost
value for the E-core perf domain is lower.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  110 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/energy_model.h>
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -938,6 +939,12 @@ static struct freq_attr *hwp_cpufreq_att
 	NULL,
 };
 
+enum hybrid_cpu_type {
+	HYBRID_PCORE = 0,
+	HYBRID_ECORE,
+	HYBRID_NR_TYPES
+};
+
 static struct cpudata *hybrid_max_perf_cpu __read_mostly;
 /*
  * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpudata,
@@ -945,6 +952,86 @@ static struct cpudata *hybrid_max_perf_c
  */
 static DEFINE_MUTEX(hybrid_capacity_lock);
 
+#ifdef CONFIG_ENERGY_MODEL
+struct hybrid_em_perf_domain {
+	cpumask_t cpumask;
+	struct device *dev;
+	struct em_data_callback cb;
+};
+
+static int hybrid_pcore_cost(struct device *dev, unsigned long freq,
+			     unsigned long *cost)
+{
+	/*
+	 * The number used here needs to be higher than the analogous
+	 * one in hybrid_ecore_cost() below.  The units and the actual
+	 * values don't matter.
+	 */
+	*cost = 2;
+	return 0;
+}
+
+static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
+			     unsigned long *cost)
+{
+	*cost = 1;
+	return 0;
+}
+
+static struct hybrid_em_perf_domain perf_domains[HYBRID_NR_TYPES] = {
+	[HYBRID_PCORE] = { .cb.get_cost = hybrid_pcore_cost, },
+	[HYBRID_ECORE] = { .cb.get_cost = hybrid_ecore_cost, }
+};
+
+static bool hybrid_register_perf_domain(struct hybrid_em_perf_domain *pd)
+{
+	/*
+	 * Registering EM perf domains without asymmetric CPU capacity
+	 * support enabled is wasteful, so don't do that.
+	 */
+	if (!hybrid_max_perf_cpu)
+		return false;
+
+	pd->dev = get_cpu_device(cpumask_first(&pd->cpumask));
+	if (!pd->dev)
+		return false;
+
+	if (em_dev_register_perf_domain(pd->dev, 1, &pd->cb, &pd->cpumask, false)) {
+		pd->dev = NULL;
+		return false;
+	}
+
+	return true;
+}
+
+static void hybrid_register_all_perf_domains(void)
+{
+	enum hybrid_cpu_type type;
+
+	for (type = HYBRID_PCORE; type < HYBRID_NR_TYPES; type++)
+		hybrid_register_perf_domain(&perf_domains[type]);
+}
+
+static void hybrid_add_to_perf_domain(int cpu, enum hybrid_cpu_type type)
+{
+	struct hybrid_em_perf_domain *pd = &perf_domains[type];
+
+	guard(mutex)(&hybrid_capacity_lock);
+
+	if (cpumask_test_cpu(cpu, &pd->cpumask))
+		return;
+
+	cpumask_set_cpu(cpu, &pd->cpumask);
+	if (pd->dev)
+		em_dev_expand_perf_domain(pd->dev, cpu);
+	else if (hybrid_register_perf_domain(pd))
+		em_rebuild_perf_domains();
+}
+#else /* CONFIG_ENERGY_MODEL */
+static inline void hybrid_register_all_perf_domains(void) {}
+static inline void hybrid_add_to_perf_domain(int cpu, enum hybrid_cpu_type type) {}
+#endif /* !CONFIG_ENERGY_MODEL */
+
 static void hybrid_set_cpu_capacity(struct cpudata *cpu)
 {
 	arch_set_cpu_capacity(cpu->cpu, cpu->capacity_perf,
@@ -1034,11 +1121,14 @@ static void __hybrid_refresh_cpu_capacit
 	hybrid_update_cpu_capacity_scaling();
 }
 
-static void hybrid_refresh_cpu_capacity_scaling(void)
+static void hybrid_refresh_cpu_capacity_scaling(bool register_perf_domains)
 {
 	guard(mutex)(&hybrid_capacity_lock);
 
 	__hybrid_refresh_cpu_capacity_scaling();
+
+	if (register_perf_domains)
+		hybrid_register_all_perf_domains();
 }
 
 static void hybrid_init_cpu_capacity_scaling(bool refresh)
@@ -1049,7 +1139,7 @@ static void hybrid_init_cpu_capacity_sca
 	 * operation mode.
 	 */
 	if (refresh) {
-		hybrid_refresh_cpu_capacity_scaling();
+		hybrid_refresh_cpu_capacity_scaling(false);
 		return;
 	}
 
@@ -1059,10 +1149,14 @@ static void hybrid_init_cpu_capacity_sca
 	 * do not do that when SMT is in use.
 	 */
 	if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
-		hybrid_refresh_cpu_capacity_scaling();
+		/*
+		 * Perf domains are not registered before setting hybrid_max_perf_cpu,
+		 * so register them all after setting up CPU capacity scaling.
+		 */
+		hybrid_refresh_cpu_capacity_scaling(true);
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-		 * packing and enable asym capacity.
+		 * packing and enable asym capacity and EAS.
 		 */
 		sched_clear_itmt_support();
 	}
@@ -2215,12 +2309,16 @@ static int hwp_get_cpu_scaling(int cpu)
 
 	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
+	if (cpu_type == 0x40) {
+		hybrid_add_to_perf_domain(cpu, HYBRID_PCORE);
 		return hybrid_scaling_factor;
+	}
 
 	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+	if (cpu_type == 0x20) {
+		hybrid_add_to_perf_domain(cpu, HYBRID_ECORE);
 		return core_get_scaling();
+	}
 
 	/*
 	 * If reached here, this system is either non-hybrid (like Tiger




