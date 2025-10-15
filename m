Return-Path: <linux-pm+bounces-36186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E54BDED68
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04623A4911
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DB23F405;
	Wed, 15 Oct 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES86vZsn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B223D7FD;
	Wed, 15 Oct 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536182; cv=none; b=md34bTIByCeleU+MOeyh4wm33ttklaPvvurshL8sEiUWzf1bzyb4cZsjs6sIBM05PvHmwp8VrMZjHfeXCIBSzw8zQJ/hN2lSOkTmOVw/Lkl4+NNtMSx+o6+Cs3WCKQBPCNm0BvECTxFB1JvfoXD+yqglfzibYUh049i5XG8a4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536182; c=relaxed/simple;
	bh=lYRJkVGazGfv6HdykBaWgpfgSdIoqR3rphf1LvIQqBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/YiQ39KAJiVRcso8f+xxqyJTvae/VKFYmJTbLkOnp7FzlIza5sJO/7nJ2UUe75s7mBijI4iM3UvNxu3y/0UZ2jnet18fw2i1ZT2ABvoOvJvYC6Fx7Gv6jt6PpQ1ulXb7bpMredm8GSaf8OPoT/y2aLV/rAJKgk8SmyPKSMhfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES86vZsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D6FC4CEF8;
	Wed, 15 Oct 2025 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536181;
	bh=lYRJkVGazGfv6HdykBaWgpfgSdIoqR3rphf1LvIQqBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES86vZsnBFugcJDREezpGi36/oe4BNKE8yFUYhw3Eq+2Z5DtV+N2MOJ1QdiNxdHKG
	 5ouEvGqRFxVlQGPoyoI/v/v+YaEuhnLUll2+UralIdnVs7Tfcffy/PTfgnpLRjThOL
	 aIeB8By8D7KuwX0iLazpgWeA5IbogL/cNPXp51Et0nIIEVzx2YP10SptawcgJJZ7Zr
	 6arTAFsUCbct9UqXr/wmgdCLr+kN2D1iAe6V/w8cwiW/9AFzv3lg0+UOyRR37UM345
	 pOGgh5o0EvaBf0VbU4DWN1NgRroNxAs8ToTTukpSal9WSBOKJmd3pOD6hvQMqCUYI1
	 wcb5cKHW2vWgQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 2/3] cpufreq: intel_pstate: Add and use hybrid_has_l3()
Date: Wed, 15 Oct 2025 15:47:45 +0200
Message-ID: <13884343.uLZWGnKmhe@rafael.j.wysocki>
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

Introduce a function for checking whether or not a given CPU has L3
cache, called hybrid_has_l3(), and use it in hybrid_get_cost() for
computing cost coefficients associated with a given perf domain.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/cpufreq/intel_pstate.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -951,11 +951,26 @@ static int hybrid_active_power(struct de
 	return 0;
 }
 
+static bool hybrid_has_l3(unsigned int cpu)
+{
+	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(cpu);
+	unsigned int i;
+
+	if (!cacheinfo)
+		return false;
+
+	for (i = 0; i < cacheinfo->num_leaves; i++) {
+		if (cacheinfo->info_list[i].level == 3)
+			return true;
+	}
+
+	return false;
+}
+
 static int hybrid_get_cost(struct device *dev, unsigned long freq,
 			   unsigned long *cost)
 {
 	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
-	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(dev->id);
 
 	/*
 	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
@@ -973,17 +988,8 @@ static int hybrid_get_cost(struct device
 	 * touching it in case some other CPUs of the same type can do the work
 	 * without it.
 	 */
-	if (cacheinfo) {
-		unsigned int i;
-
-		/* Check if L3 cache is there. */
-		for (i = 0; i < cacheinfo->num_leaves; i++) {
-			if (cacheinfo->info_list[i].level == 3) {
-				*cost += 2;
-				break;
-			}
-		}
-	}
+	if (hybrid_has_l3(dev->id))
+		*cost += 2;
 
 	return 0;
 }




