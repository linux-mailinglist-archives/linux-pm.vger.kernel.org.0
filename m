Return-Path: <linux-pm+bounces-36294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E973DBE4905
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEC058252C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8421301000;
	Thu, 16 Oct 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFmb/iac"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8E23EAB4;
	Thu, 16 Oct 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631738; cv=none; b=JbcrO7EK7QpYn9VjBVfN8cHfZaomkFxNBO9L499G1hydA4zlNnmdatg5BorhG9ZiROmQkS/1iKRLgcB5v/BvRsyClv8WHyxKpnm/8Yo91L2R60e8mm9KFLJQHRL/2zKGt6QOeJuSP9dH/PfQgpxApIBT4nD6x3wFqw2kLXWKuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631738; c=relaxed/simple;
	bh=/vPCtUNxUxUrURmVRLH/Zanu6E4IpRsjCbDrKYN9pFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbKxLl1HI8bREcJaAhi6Zj5w2WS6wCbhO/Ej3Qm6/l2igOkUjnyZvHG60RcFEHZzcTSmlKcG+BtKUeIxW8N2+AC53NC6OyUT2MTwamwN6kIMuKKv/YTtjQK5hB6Ycs5Xo1AOEUceWIAOV3d9qEeG9S/zPFY7LUPikqn3DUTco5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFmb/iac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B9C4CEF1;
	Thu, 16 Oct 2025 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631738;
	bh=/vPCtUNxUxUrURmVRLH/Zanu6E4IpRsjCbDrKYN9pFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFmb/iac5f9BP5PjQCueO37qH4g3mCrQlxiuKA2Q0OLdye+hxGILZa6uDC7koEjTk
	 Slf+wcUhD4Ds+psK5ut6EXuXQzBl9SQM4bi8RhSf1CTIav9rnY4lYAGMXwgqthm8Jo
	 7kLUXI1qLgmSrIH/dlBDh+gBx+UaKJxeT7O2O8FEf+vQfMt6DPNWyd19mlowf2Z9Sx
	 ySp7W0/yr+SC0rslmkby6haBi1plBmA9KGemBaIc14qvdicpJSL0DYn8DpXAqmq1aQ
	 GcLcT8vWEqIhUq9IYm6A1TSJlwEGRtn8DuCKtkywhIFDK6m/XvHJTGc0Hhp+1Mt7um
	 IG1oDge4kc3dg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject:
 [PATCH v3 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model rules
Date: Thu, 16 Oct 2025 18:22:13 +0200
Message-ID: <5932894.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3394529.aeNJFYEL58@rafael.j.wysocki>
References:
 <2404176.ElGaqSPkdT@rafael.j.wysocki> <3394529.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using HWP-to-frequency scaling factors for computing cost
coefficients in the energy model used on hybrid systems, which is
fragile, rely on CPU type information that is easily accessible now and
the information on whether or not L3 cache is present for this purpose.

This also allows the cost coefficients for P-cores to be adjusted so
that they start to be populated somewhat earlier (that is, before
E-cores are loaded up to their full capacity).

In addition to the above, replace an inaccurate comment regarding the
reason why the freq value is added to the cost in hybrid_get_cost().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v2 -> v3:
   * Reduce cost differences between CPU types by 1 (Tian, Christian)
   * Add a tag from Dietmar

Note: The other patches in the series have not changed.

v1 -> v2: New patch

---
 drivers/cpufreq/intel_pstate.c |   35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
 			       unsigned long *freq)
 {
 	/*
-	 * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-100%
-	 * of the maximum capacity such that two CPUs of the same type will be
-	 * regarded as equally attractive if the utilization of each of them
-	 * falls into the same bin, which should prevent tasks from being
-	 * migrated between them too often.
+	 * Create four "states" corresponding to 40%, 60%, 80%, and 100% of the
+	 * full capacity.
 	 *
 	 * For this purpose, return the "frequency" of 2 for the first
 	 * performance level and otherwise leave the value set by the caller.
@@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
 static int hybrid_get_cost(struct device *dev, unsigned long freq,
 			   unsigned long *cost)
 {
-	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
-
+	/* Facilitate load balancing between CPUs of the same type. */
+	*cost = freq;
 	/*
-	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
-	 * ratio between the given CPU and the least capable CPU in the system.
-	 * Regard that IPC ratio as the primary cost component and assume that
-	 * the scaling factors for different CPU types will differ by at least
-	 * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
+	 * Adjust the cost depending on CPU type.
 	 *
-	 * Add the freq value to the cost, so that the cost of running on CPUs
-	 * of the same type in different "utilization bins" is different.
-	 */
-	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
-	/*
-	 * Increase the cost slightly for CPUs able to access L3 to avoid
-	 * touching it in case some other CPUs of the same type can do the work
-	 * without it.
+	 * The idea is to start loading up LPE-cores before E-cores and start
+	 * to populate E-cores when LPE-cores are utilized above 60% of the
+	 * capacity.  Similarly, P-cores start to be populated when E-cores are
+	 * utilized above 60% of the capacity.
 	 */
-	if (hybrid_has_l3(dev->id))
+	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
+		if (hybrid_has_l3(dev->id)) /* E-core */
+			*cost += 1;
+	} else { /* P-core */
 		*cost += 2;
+	}
 
 	return 0;
 }




