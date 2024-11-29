Return-Path: <linux-pm+bounces-18251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D99DEAFB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78506B21219
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5419F421;
	Fri, 29 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="WayB0odm"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28A14E2E6;
	Fri, 29 Nov 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897711; cv=none; b=hIrXiMEZKhrxgtu4V2jgIHl0IDhjQold0LxVx1IpMRBxx6fuqantVkq/6RC1Nyj3rFy244H9Ku+LeKb2vA7GFELfhVNCg1tcOVkwFojbdjwXUZL0DZZwzubbfAo3BMe5NPO7Welqvd586fwZ+HVzmk60b4a8xevwAsTVcoz+70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897711; c=relaxed/simple;
	bh=HMGBZOXSMMvv1IfoZw8Sx2HA/3BEClrax5ORvrtMt1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAm3EcpV4PPDpcHCkl/x8ucOHVpkE3RF9Ltn+lGa0XSdgQNke91A14g2aq0qVmhdVA5IRNqGJYb76yetJmKe9AYc/g3qPK2MOv8RjdDuIKxCizJ+lj7iG+V1sHE6bgTtHhigAOD26UQrs+ashtmR+t1DvLEcw8iB18wQve/0u8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=WayB0odm; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 62129d98bd018b2f; Fri, 29 Nov 2024 17:28:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9874DA47B8B;
	Fri, 29 Nov 2024 17:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897707;
	bh=HMGBZOXSMMvv1IfoZw8Sx2HA/3BEClrax5ORvrtMt1c=;
	h=From:Subject:Date;
	b=WayB0odmVKpfkTFhPGYu6Q3Jf/EApccNMChSPAFk/PcN4BVo+3wCyYfkE90EXoYkV
	 a6wOAcs/KNaHSdajOFqvqLMdkdWZMGvCnz9AIJUB20Ccgmen/8UZIx08EcbeOefExH
	 RLNMhXucYzeM/wOWUrhPwdx8hsohYkgraR2ltNI943v0/opq/ShyAxrmnHwroJ3mMI
	 LoIPaZGZ9j3qKnS/8c9oQQsnrrySgd3isxqD40rYgBZNIzQGaYXU1UPj8GuPF6tJKG
	 SgjSFs0ntyi2HJ3zp6MlGKW96HPpOHXhhljRzsi4+Rq7a8NOGye0EQvEU8mir7vnET
	 9uWwRKPJfDyCw==
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
 [RFC][PATCH v021 1/9] cpufreq: intel_pstate: Use CPPC to get scaling factors
Date: Fri, 29 Nov 2024 16:56:15 +0100
Message-ID: <4992622.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the P-core hybrid scaling factor for the given processor model is not
known, use CPPC to compute hybrid scaling factors for all CPUs.

Since the current default hybrid scaling factor is only suitable for a
few early hybrid platforms, add intel_hybrid_scaling_factor[] entries
for them and initialize the scaling factor to zero ("unknown") by
default.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   59 +++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -28,6 +28,7 @@
 #include <linux/pm_qos.h>
 #include <linux/bitfield.h>
 #include <trace/events/power.h>
+#include <linux/units.h>
 
 #include <asm/cpu.h>
 #include <asm/div64.h>
@@ -302,11 +303,11 @@ static bool hwp_is_hybrid;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
-#define HYBRID_SCALING_FACTOR		78741
+#define HYBRID_SCALING_FACTOR_ADL	78741
 #define HYBRID_SCALING_FACTOR_MTL	80000
 #define HYBRID_SCALING_FACTOR_LNL	86957
 
-static int hybrid_scaling_factor = HYBRID_SCALING_FACTOR;
+static int hybrid_scaling_factor;
 
 static inline int core_get_scaling(void)
 {
@@ -414,18 +415,15 @@ static int intel_pstate_get_cppc_guarant
 static int intel_pstate_cppc_get_scaling(int cpu)
 {
 	struct cppc_perf_caps cppc_perf;
-	int ret;
-
-	ret = cppc_get_perf_caps(cpu, &cppc_perf);
 
 	/*
-	 * If the nominal frequency and the nominal performance are not
-	 * zero and the ratio between them is not 100, return the hybrid
-	 * scaling factor.
-	 */
-	if (!ret && cppc_perf.nominal_perf && cppc_perf.nominal_freq &&
-	    cppc_perf.nominal_perf * 100 != cppc_perf.nominal_freq)
-		return hybrid_scaling_factor;
+	 * Compute the perf-to-frequency scaling factor for the given CPU if
+	 * possible, unless it would be 0.
+	 */
+	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
+	    cppc_perf.nominal_perf && cppc_perf.nominal_freq)
+		return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
+			       cppc_perf.nominal_perf);
 
 	return core_get_scaling();
 }
@@ -2211,24 +2209,30 @@ static void hybrid_get_type(void *data)
 
 static int hwp_get_cpu_scaling(int cpu)
 {
-	u8 cpu_type = 0;
+	if (hybrid_scaling_factor) {
+		u8 cpu_type = 0;
+
+		smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
-	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
-		return hybrid_scaling_factor;
+		/*
+		 * Return the hybrid scaling factor for P-cores and use the
+		 * default core scaling for E-cores.
+		 */
+		if (cpu_type == 0x40)
+			return hybrid_scaling_factor;
 
-	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+		if (cpu_type == 0x20)
+			return core_get_scaling();
+	}
+
+	/* Use core scaling on non-hybrid systems. */
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
 		return core_get_scaling();
 
 	/*
-	 * If reached here, this system is either non-hybrid (like Tiger
-	 * Lake) or hybrid-capable (like Alder Lake or Raptor Lake) with
-	 * no E cores (in which case CPUID for hybrid support is 0).
-	 *
-	 * The CPPC nominal_frequency field is 0 for non-hybrid systems,
-	 * so the default core scaling will be used for them.
+	 * The system is hybrid, but the hybrid scaling factor is not known or
+	 * the CPU type is not one of the above, so use CPPC to compute the
+	 * scaling factor for this CPU.
 	 */
 	return intel_pstate_cppc_get_scaling(cpu);
 }
@@ -3665,6 +3669,11 @@ static const struct x86_cpu_id intel_epp
 };
 
 static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
+	X86_MATCH_VFM(INTEL_ALDERLAKE, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),




