Return-Path: <linux-pm+bounces-33333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B61B3AB6E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 22:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D5FA013AF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A81274FF2;
	Thu, 28 Aug 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhvsm+lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1A273D7B;
	Thu, 28 Aug 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412186; cv=none; b=LpjHjG4B+WoCCklwh4O5hlvz1Y59NLw8kkMJCO5t5CjmEfQVT0swsmVry5tCG6YexnecGzObm6jaTTJ0+cxvXE5/8J4/+8OQnPKj5nc6DgHHQXaWkZ25awcBKAc/StbBg9H/p957WpOwm7cgMhu+d2SBnJQaFu8xX2MwryiAHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412186; c=relaxed/simple;
	bh=CgBLmyi9jgGUOiv9TCodnN5Hn/4OG3mZltDzTz2ZkBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHu6+Szz56kt+eWLHC3uCET75VuMCBBaCAIUFXAlfCnzZ0MY+2DHl7VWZVU4ScjZYaR/qeWusTAfE1yhWpaOge7IMxqf8GeNeMRzZqZpFs0747t7SzSameUcbp5sCnXOw+gt2/eR1hA1qIFp9yVnFWUAukfO5qChcFSJOv6ellM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhvsm+lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A7AC4CEEB;
	Thu, 28 Aug 2025 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756412185;
	bh=CgBLmyi9jgGUOiv9TCodnN5Hn/4OG3mZltDzTz2ZkBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhvsm+lcTt1YfmIC0GR9xSBEK83jAIDPHlw1FVHjoDGKzxVlZT0pemqxIbRa4P4QH
	 fsnDGSzVIdcYWANZeLn1WWyIKAGsOSzazcK7widCEwPTdt6SHuSiL/2YYrH+zmj6tK
	 NuudI4e1eLLYCwhcZnpUU59FbqLMEHBfvSwN7ceKs5r6S+MIRgp+oJ0bH6Hdyh9lZ4
	 cC7mnZ0odHhjxsWSDbjc4U6jTvw++byM3CL5rIMANkBM/hVPd0Yw1BUfOnuMjAfY/w
	 kuAtxnhvMdUiDDmrBL6hdUEhbvdslfNXzReAcyaKT8Z6W2ZcC+W0u4PvFfa6PllpWW
	 AiK22kKremk8A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1] cpuidle: governors: teo: Special-case nohz_full CPUs
Date: Thu, 28 Aug 2025 22:16:20 +0200
Message-ID: <5939372.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2804546.mvXUDI8C0e@rafael.j.wysocki>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This change follows an analogous modification of the menu governor [1].

Namely, when the governor runs on a nohz_full CPU and there are no user
space timers in the workload on that CPU, it ends up selecting idle
states with target residency values above TICK_NSEC, or the deepest
enabled idle state in the absence of any of those, all the time due to
a tick_nohz_tick_stopped() check designed for running on CPUs where the
tick is not permanently disabled.  In that case, the fact that the tick
has been stopped means that the CPU was expected to be idle sufficiently
long previously, so it is not unreasonable to expect it to be idle
sufficiently long again, but this inference does not apply to nohz_full
CPUs.

In some cases, latency in the workload grows undesirably as a result of
selecting overly deep idle states, and the workload may also consume
more energy than necessary if the CPU does not spend enough time in the
selected deep idle state.

Address this by amending the tick_nohz_tick_stopped() check in question
with a tick_nohz_full_cpu() one to avoid effectively ignoring all
shallow idle states on nohz_full CPUs.  While doing so introduces a risk
of getting stuck in a shallow idle state for a long time, that only
affects energy efficiently, but the current behavior potentially hurts
both energy efficiency and performance that is arguably the priority for
nohz_full CPUs.

While at it, add a comment explaining the logic in teo_state_ok().

Link: https://lore.kernel.org/linux-pm/2244365.irdbgypaU6@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -227,9 +227,17 @@
 	cpu_data->total += PULSE;
 }
 
-static bool teo_state_ok(int i, struct cpuidle_driver *drv)
+static bool teo_state_ok(int i, struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	return !tick_nohz_tick_stopped() ||
+	/*
+	 * If the scheduler tick has been stopped already, avoid selecting idle
+	 * states with target residency below the tick period length under the
+	 * assumption that the CPU is likely to be idle sufficiently long for
+	 * the tick to be stopped again (or the tick would not have been
+	 * stopped previously in the first place).  However, do not do that on
+	 * nohz_full CPUs where the above assumption does not hold.
+	 */
+	return !tick_nohz_tick_stopped() || tick_nohz_full_cpu(dev->cpu) ||
 		drv->states[i].target_residency_ns >= TICK_NSEC;
 }
 
@@ -379,7 +387,7 @@
 				 * shallow or disabled, in which case take the
 				 * first enabled state that is deep enough.
 				 */
-				if (teo_state_ok(i, drv) &&
+				if (teo_state_ok(i, drv, dev) &&
 				    !dev->states_usage[i].disable) {
 					idx = i;
 					break;
@@ -391,7 +399,7 @@
 			if (dev->states_usage[i].disable)
 				continue;
 
-			if (teo_state_ok(i, drv)) {
+			if (teo_state_ok(i, drv, dev)) {
 				/*
 				 * The current state is deep enough, but still
 				 * there may be a better one.
@@ -460,7 +468,7 @@
 	 */
 	if (drv->states[idx].target_residency_ns > duration_ns) {
 		i = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
-		if (teo_state_ok(i, drv))
+		if (teo_state_ok(i, drv, dev))
 			idx = i;
 	}
 




