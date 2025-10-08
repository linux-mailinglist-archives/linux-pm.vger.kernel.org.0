Return-Path: <linux-pm+bounces-35820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41DBC676C
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F8D188FC92
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08425A65B;
	Wed,  8 Oct 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYls0OYe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E734BA38;
	Wed,  8 Oct 2025 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951386; cv=none; b=Nt/XH4s0k0dOp5WqBY14y0hx+zdNq/ZsUeCvcnsLOGWMsyL1ryEKFj1rlI76SX0t0nezGxFoo1IT0oPsf3LzldH17iBVbD+NgWOkiKTuV7OK+x2rRmywlxkhzl78wDzPHBSe0JSygZPOdFb40v3ebsztb2NqvVhW1pyFL0bQ14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951386; c=relaxed/simple;
	bh=JbpHhJpglwcaBjT67FBk0svkwpFc/zCHD8tYveXp41M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRefO+FjdUerofZJvdvDg+TdkmCDkuA22e813iNe1UjXdywjB/nM8wE4LsmeK54SZraX9toU0krThlsNRC03P80u4DyZpmUt4VBsEKwYuFP+vKE1/4r0wT+0w9/PZ75fKNAnb/iqcw2ZAj95hzSO84vpkiyNgjqQhc2R3TFyU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYls0OYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC30AC4CEF4;
	Wed,  8 Oct 2025 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759951384;
	bh=JbpHhJpglwcaBjT67FBk0svkwpFc/zCHD8tYveXp41M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYls0OYewIrU5Bsq0CL66V7mJYH84rQGOHxvdaIOnCoQN+zDyEP3gxIfKmkHz3D0y
	 uiztaBB8OHC3WB/ICyJ2HlHcbTabfP24hRQjOLLBrBXSMoZ5YP5XEOtxwZYoGy/p1D
	 r3nFHATND+1jywTdk5+kc/az9mWep29X5aGcNottxBoh5kMqEJgSWR9/S+i0ujTiBY
	 hRzCZuOkZJqsXyhde/aHBqAgPtRYSp4x1z2vZVZeJRRGFfIyBH0k4tF7Pmky98Wx9m
	 y41W9/QCTjGoN68OLe8A6T7TTbOirjcJj5OyJ5pVXLPbP1unosICEn4s4S+9hEOhnE
	 65iIx9EsKgyEw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1 2/3] cpufreq: intel_pstate: Add and use hybrid_has_l3()
Date: Wed, 08 Oct 2025 20:56:15 +0200
Message-ID: <5025953.GXAFRqVoOG@rafael.j.wysocki>
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

Introduce a function for checking whether or not a given CPU has L3
cache, called hybrid_has_l3(), and use it in hybrid_get_cost() for
computing cost coefficients associated with a given perf domain.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




