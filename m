Return-Path: <linux-pm+bounces-34246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64231B4AC9A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B76345D1E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F233322A05;
	Tue,  9 Sep 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9RvPHIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB7322755;
	Tue,  9 Sep 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418259; cv=none; b=P1u+f1jj48mLnI3BLGFpnOJETK/hRC+mt73sTelWeSv2Qj+BGOLxhQ290V9lV0bl3y7lhoPNIfhTdqa/yR9ZXwpb9kLAE7JVP+02YfGGBNjZ+psghIS7Kg40Ex2WTP2d9YmX69lzv+lFlJNtxoXSoaAx/fUXQhPOZbCP/evqk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418259; c=relaxed/simple;
	bh=koEjJ0K44gXpZTQ9arL7K8K/MOY3Y3pz7eVFwI3QSeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ATT3/gXETMC8FyZPDhx9XI/IN+gslvvDsFdCjA6yUOZYgcfgpNzc0jwZOIF23FBD5vp12z+z77k94vvwHncgG50aQ6aafL7HzbCwLges8Tzopng6zsarg06JbwPLUbH1f0oqXtRP+xoI1W0rwcgmvVsLWbW1XwsNQWWWahalQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9RvPHIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D54AC4CEF4;
	Tue,  9 Sep 2025 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757418258;
	bh=koEjJ0K44gXpZTQ9arL7K8K/MOY3Y3pz7eVFwI3QSeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=b9RvPHIY1GM/AnSy30vF1LEwI4Xe7UsqU3J43Gpus4dGa6Q/QjZ91FQ0QQkQlLAEQ
	 Z3DVK7GFq0gSyJQY9bVG2KaHlun6ux04B7hbfC5EvzWJMWzuFFaaZza+O+IbTTvtn4
	 cZd0/qsYka+coYNMOkXiFBzTYnQsAX7bRpABdom/wLLjEV+Lvuw6b2ulVMHCvP+cfy
	 /QLP246EKj9avFDHIhsaZ2MoZM37KP+xJtftCALZPWk3JivKoynUOFIeyiuQvz/jMi
	 ahKS/GJ9kWJWnF+6x2fvGj5wLZ4mtxlmQdOi/tdhB+hW3efa1zHmDDmpkE9j4cx4Nw
	 ULMSvI4GLC7Sg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>, Linux PM <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 [PATCH v1] smp: Fix up and expand the smp_call_function_many() kerneldoc
Date: Tue, 09 Sep 2025 13:44:14 +0200
Message-ID: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The smp_call_function_many() kerneldoc comment got out of sync with the
function definition (bool parameter "wait" is incorrectly described as a
bitmask in it), so fix it up by copying the "wait" description from the
smp_call_function() kerneldoc and add information regarding the handling
of the local CPU to it.

Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/smp.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -884,16 +884,15 @@ static void smp_call_function_many_cond(
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
+ *
+ * @func is not called on the local CPU even if @mask contains it.  Consider
+ * using on_each_cpu_cond_mask() instead if this is not desirable.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)




