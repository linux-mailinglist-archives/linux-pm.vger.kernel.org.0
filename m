Return-Path: <linux-pm+bounces-36185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC0BDED62
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A4E3A33BC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1D20E6E1;
	Wed, 15 Oct 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enGhx55T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FD1DE4EF;
	Wed, 15 Oct 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536179; cv=none; b=T/9/CMa1OJ1nwysvgoEy3/+Z29xPAPcLnyAYnCIGZ0jAigkRRUFmM8xQjwLOPvbAS5nyPXmWCkR+CriOtlDJE3f2Iz8xT07mWlAs4l2bGiB4kj0aVhoXbU7GSQz+f9B3dmzJUaBQX8WyfcQo8VM7HINOTyYI0nGZDnnCkRX+lDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536179; c=relaxed/simple;
	bh=DzNYFgpRPpTj7P0n56xhZU0ojaAqJDbk17uCLP+HWCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJxUz6Uk1kNXhHDXbfPB+jRglzO5XDPqrKRbE/gXD2NgAyJY6cZKB94kP8Ax+ndTBUj0OCGscwbfcpAphIlOcbaCKBQBnvwhFkCNfEGOcsI6tnuEnXskK0waIMzlKnHjsO8RQ43dnNVVgd5vHhOIxzHF4+4+dK3wmktsQVgqogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enGhx55T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EADEC4CEFB;
	Wed, 15 Oct 2025 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536178;
	bh=DzNYFgpRPpTj7P0n56xhZU0ojaAqJDbk17uCLP+HWCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enGhx55T7+QMnLsQq7NzNEhAGAUecKfiPu1QqOuFxIjXyDUI3i++ltQ+rIEHD9gMJ
	 pPyS1lKrZh00NVFgsI4LVeK9LYv05nJn0zkDipisoPnwgwl6H3i6ZFTfwNT0TADyFx
	 NNrN/rQd0M39vy+BQYjgcmE2Y8DU7zfnHSELD5jxB79/7jideJl9XnHVdzmfTGr6sN
	 jZdb+rG9jdwvVBPTmKgjwF6iaieomZWt+yIyASlv5ZizqegJyw1JsyZEokB00RRXyt
	 jgQ5JeoGLyJEGNcXg9BSTcm6njeadAB90ZOf+bt/LLC4zQ9XO2JOIXhILduus0AJFp
	 /Oij2PoQUS3Uw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject:
 [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model rules
Date: Wed, 15 Oct 2025 15:48:30 +0200
Message-ID: <3394529.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2404176.ElGaqSPkdT@rafael.j.wysocki>
References: <2404176.ElGaqSPkdT@rafael.j.wysocki>
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
---
 drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

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
-		*cost += 2;
+	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
+		if (hybrid_has_l3(dev->id)) /* E-core */
+			*cost += 2;
+	} else { /* P-core */
+		*cost += 4;
+	}
 
 	return 0;
 }




