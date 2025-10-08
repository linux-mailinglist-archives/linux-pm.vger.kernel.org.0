Return-Path: <linux-pm+bounces-35819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C83BC676A
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05FA24E3065
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86221CC55;
	Wed,  8 Oct 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgzUPALZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45AC34BA38;
	Wed,  8 Oct 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951380; cv=none; b=LPlEvOotsEAe5vairj/FhdAah92MuYK8aTe2tqKuKKPppVfpGdOL86RL0cYMiwhF0r4n3isXUTH4U/tx0d+PiqGb08WnmUM5qEATKRY6LA8WNPZvz5EOfe+8ttyrqyGKh22+E9wVdNUYWs+e2abCGodqkn80UuCAt2BYXWaLTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951380; c=relaxed/simple;
	bh=8RXtyqmUHYlebDgNkwtw05CKYDQhvfLRTzMQS3ooS/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9MrGmWk44qdL4HTIWAYv0frqoWuyqpTYRPiSphcabYbKU+REGyNI0Qbt9W2gCmSqot2DihEJK8sDmCUw0wpYdEKDZtFGDkEhne18SuYmSznQVhReVJL37VWN2eBHPPzC2zWWpZF23GG7kJia4BQ1aIHH62t392nvXXDz2Aephc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgzUPALZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01278C4CEE7;
	Wed,  8 Oct 2025 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759951380;
	bh=8RXtyqmUHYlebDgNkwtw05CKYDQhvfLRTzMQS3ooS/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgzUPALZfxcnsvRtXYVqOsLaTS+qzN+0rLdJ3UNUtAfjUzo8EeLo+YrT51cbxDPZO
	 +mEtJ0VOkzYFNqN7e2eP95GdZRVDE5936kTjtXeoBkJVe/MLEkY2jZlm3C1CC8wlSf
	 XPa6RYFJOZJFBhxVtSu/dVPEdzIZUWOKPczd/Jr9+5r1/Xbm1I5iQ4PFS1EDwC7wPy
	 bCzOkHqzNYTkzpvU/Mx86zDZnGbmoRA+mouCajzUK2yiFJ7HK3Mzj5h6uQgqbxYJzr
	 srSSJUK+RI8FXlDWwXHRbJ0xfRcvQWOJ/wnfUJAkRL2/d2reR2TTYClSOV5+ewdo+U
	 en0HFDcXF7d7g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1 3/3] cpufreq: intel_pstate: Simplify the energy model for hybrid
 systems
Date: Wed, 08 Oct 2025 21:22:27 +0200
Message-ID: <3914183.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5937608.DvuYhMxLoT@rafael.j.wysocki>
References: <5937608.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since em_cpu_energy() computes the cost of using a given CPU to
do work as a product of the utilization of that CPU and a constant
positive cost coefficient supplied through an energy model, EAS
evenly distributes the load among CPUs represented by identical
one-CPU PDs regardless of what is there in the energy model.

Namely, two CPUs represented by identical PDs have the same energy
model data and if the PDs are one-CPU, max_util is always equal to the
utilization of the given CPU, possibly increased by the utilization
of a task that is waking up.  The cost coefficient is a monotonically
increasing (or at least non-decreasing) function of max_util, so the
CPU with higher utilization will generally get a higher (or at least
not lower) cost coefficient.  After multiplying that coefficient by
CPU utilization, the resulting number will always be higher for the
CPU with higher utilization.  Accordingly, whenever these two CPUs
are compared, the cost of running a waking task will always be higher
for the CPU with higher utilization which leads to the even distribution
of load mentioned above.

For this reason, the energy model can be adjusted in arbitrary
ways without disturbing the even distribution of load among CPUs
represented by indentical one-CPU PDs.  In particular, for all of
those CPUs, the energy model can provide one cost coefficient that
does not depend on the performance level.

Moreover, if there are two different CPU types, A and B, each having
a performance-independent cost coefficient in the EM, then these
cost coefficients determine the utilization levels at which CPUs
of type A and B will be regarded as equally expensive for running
a waking task.  For example, if the cost coefficient for CPU type
A is 1, the cost coefficient for CPU type B is 2, and the utilization
of the waking task is x, a CPU of type A will be regarded as "cost-
equivalent" to a CPU of type B if its utilization is the sum of x and
twice the utilization of the latter.  Similarly, for the cost
coefficients equal to 2 and 3, respectively, the "cost equivalence"
utilization of CPU type A will be the sum of x/2 and the CPU type B
utilization multiplied by 3/2.  In the limit of negligibly small x,
the "cost equivalence" utilization of CPU type A is just the
utilization of CPU type B multiplied by the ratio of the cost
coefficients for B and A.  That ratio can be regarded as an effective
"cost priority" of CPU type A relative to CPU type B, as it indicates
how much more on average the former needs to be loaded so it can be
regarded as cost-equivalent to the latter (for low-utilization tasks).

Use the above observations for simplifying the default energy model
for hybrid platforms in intel_pstate as follows:

 * A performance-independent cost coefficient is introduced for each CPU
   type.

 * The number of states in each PD is reduced to 2 (it is not necessary
   to use more of them because the cost per scale-invariant utilization
   point does not depend on the performance level any more).

 * CPUs without L3 cache (LPE-cores) that are expected to be the most
   energy-efficient ones are prioritized over any other CPUs.

 * The CPU type value from CPUID (now easliy accessible through
   cpu_data[]) is used for identifying P-cores and E-cores instead
   of hybrid scaling factors which are less reliable.

 * E-cores are preferred to P-cores.

The cost coefficients for different CPU types that can appear in a
hybrid system (P-cores, E-cores, and LPE-cores that are effectively
E-cores without L3 cache and with lower capacity) are chosen in
accordance with the following rules:

 * The cost priority of LPE-cores relative to E-cores is 1.5.

 * The cost priority of E-cores relative to P-cores is 2, which
   also means that the cost priority of LPE-cores relative to
   P-cores is 3.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -927,23 +927,20 @@ static struct cpudata *hybrid_max_perf_c
 static DEFINE_MUTEX(hybrid_capacity_lock);
 
 #ifdef CONFIG_ENERGY_MODEL
-#define HYBRID_EM_STATE_COUNT	4
+#define HYBRID_EM_STATE_COUNT	2
 
 static int hybrid_active_power(struct device *dev, unsigned long *power,
 			       unsigned long *freq)
 {
 	/*
-	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
-	 * of the maximum capacity such that two CPUs of the same type will be
-	 * regarded as equally attractive if the utilization of each of them
-	 * falls into the same bin, which should prevent tasks from being
-	 * migrated between them too often.
+	 * Create two "states" corresponding to 50% and 100% of the full
+	 * capacity.
 	 *
-	 * For this purpose, return the "frequency" of 2 for the first
+	 * For this purpose, return the "frequency" of 1 for the first
 	 * performance level and otherwise leave the value set by the caller.
 	 */
 	if (!*freq)
-		*freq = 2;
+		*freq = 1;
 
 	/* No power information. */
 	*power = EM_MAX_POWER;
@@ -970,26 +967,18 @@ static bool hybrid_has_l3(unsigned int c
 static int hybrid_get_cost(struct device *dev, unsigned long freq,
 			   unsigned long *cost)
 {
-	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
-
-	/*
-	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
-	 * ratio between the given CPU and the least capable CPU in the system.
-	 * Regard that IPC ratio as the primary cost component and assume that
-	 * the scaling factors for different CPU types will differ by at least
-	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
-	 *
-	 * Add the freq value to the cost, so that the cost of running on CPUs
-	 * of the same type in different "utilization bins" is different.
-	 */
-	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
 	/*
-	 * Increase the cost slightly for CPUs able to access L3 to avoid
-	 * touching it in case some other CPUs of the same type can do the work
-	 * without it.
+	 * The cost per scale-invariant utilization point for LPE-cores (CPUs
+	 * without L3 cache), E-cores and P-cores is chosen so that the cost
+	 * priority of LPE-cores relative to E-cores is 1.5 and the cost
+	 * priority of E-cores relative to P-cores is 2.
 	 */
-	if (hybrid_has_l3(dev->id))
-		*cost += 2;
+	if (!hybrid_has_l3(dev->id))
+		*cost = 2;
+	else if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM)
+		*cost = 3;
+	else
+		*cost = 6;
 
 	return 0;
 }




