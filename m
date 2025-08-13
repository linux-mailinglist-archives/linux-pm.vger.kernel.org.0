Return-Path: <linux-pm+bounces-32256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D3B24753
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E51693D2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71B2F5320;
	Wed, 13 Aug 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHweK6oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBC2F49E6;
	Wed, 13 Aug 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081039; cv=none; b=EVjnlJwA+6vfy7ORJ0LyO0cYcmOnTNp1FnV2D6QPuQoNuAOSC2ykVYsI5KmGyJ2ESAQpHRNOPck3awIxJIpFSjE+hO6DnRBtA6HqIG6g1TlXuITIOoVMcvRJN7GbsPnwOa/gnM4AzRd1HXnzKcV8PJk3rnnhMT3YLmOnObs+eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081039; c=relaxed/simple;
	bh=6z1daFfQ6eLBHSNbpnvAvJ8ClaHWK786S0pbNYdxzus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhd4hqvhnTHYSjz7BLle1WAWbJjjEqyn4ehL7S9GUxnW5V5vUr7tyAoapUPY7snLR/drhk40VMPBK5dgAZtg8bGu/kfNxbzzjQzROSzBfGrNf0XwVv4UZgwWtxAf3JNf/aIF/TPNGbTI55RzkcgYv95FaYP3wUYpkNLm9fVYTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHweK6oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A8C4CEF7;
	Wed, 13 Aug 2025 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081039;
	bh=6z1daFfQ6eLBHSNbpnvAvJ8ClaHWK786S0pbNYdxzus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHweK6oi2ROG/I/sEu0Vf2n7qpeQXJ3Q+ASmgWrR+sPTOvNJU+MgGuCds3D8Z1GuM
	 ZvJFTx0kVeqjQqRi24+o4nDnpT4HY3ndJ07UyujIjiBfpFH79OE32ESpEXtJS+Nonf
	 LZ94BYTJOMiu0SfFKLuapCJvatwR16BcdSv/nuhfCFKTIe8x3LI8L6FsyLAszceg//
	 0qfjtgDiQa8di8V3X1tm1XNXRjnQodUUQIcT+5s4E4dYAlfkw2lg/MxIm+L7WxJROt
	 wk7yJxq5Arye94rtQVKwoUXcDJX3TieF69H3JPM9DGVuxFNCuVvQEH+BLZfL2CrUee
	 3zk9BvT3BH0PA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states with too much
 latency
Date: Wed, 13 Aug 2025 12:25:58 +0200
Message-ID: <5043159.31r3eYUQgx@rafael.j.wysocki>
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

Occasionally, the exit latency of the idle state selected by the menu
governor may exceed the PM QoS CPU wakeup latency limit.  Namely, if the
scheduler tick has been stopped already and predicted_ns is greater than
the tick period length, the governor may return an idle state whose exit
latency exceeds latency_req because that decision is made before
checking the current idle state's exit latency.

For instance, say that there are 3 idle states, 0, 1, and 2.  For idle
states 0 and 1, the exit latency is equal to the target residency and
the values are 0 and 5 us, respectively.  State 2 is deeper and has the
exit latency and target residency of 200 us and 2 ms (which is greater
than the tick period length), respectively.

Say that predicted_ns is equal to TICK_NSEC and the PM QoS latency
limit is 20 us.  After the first two iterations of the main loop in
menu_select(), idx becomes 1 and in the third iteration of it the target
residency of the current state (state 2) is greater than predicted_ns.
State 2 is not a polling one and predicted_ns is not less than TICK_NSEC,
so the check on whether or not the tick has been stopped is done.  Say
that the tick has been stopped already and there are no imminent timers
(that is, delta_tick is greater than the target residency of state 2).
In that case, idx becomes 2 and it is returned immediately, but the exit
latency of state 2 exceeds the latency limit.

Address this issue by modifying the code to compare the exit latency of
the current idle state (idle state i) with the latency limit before
comparing its target residecy with predicted_ns, which allows one
more exit_latency_ns check that becomes redundant to be dropped.

However, after the above change, latency_req cannot take the predicted_ns
value any more, which takes place after commit 38f83090f515 ("cpuidle:
menu: Remove iowait influence"), because it may cause a polling state
to be returned prematurely.

In the context of the previous example say that predicted_ns is 3000 and
the PM QoS latency limit is still 20 us.  Additionally, say that idle
state 0 is a polling one.  Moving the exit_latency_ns check before the
target_residency_ns one causes the loop to terminate in the second
iteration, before the target_residency_ns check, so idle state 0 will be
returned even though previously state 1 would be returned if there were
no imminent timers.

For this reason, remove the assignment of the predicted_ns value to
latency_req from the code.

Fixes: 5ef499cd571c ("cpuidle: menu: Handle stopped tick more aggressively")
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,20 +287,15 @@
 		return 0;
 	}
 
-	if (tick_nohz_tick_stopped()) {
-		/*
-		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and use
-		 * the known time till the closest timer event for the idle
-		 * state selection.
-		 */
-		if (predicted_ns < TICK_NSEC)
-			predicted_ns = data->next_timer_ns;
-	} else if (latency_req > predicted_ns) {
-		latency_req = predicted_ns;
-	}
+	/*
+	 * If the tick is already stopped, the cost of possible short idle
+	 * duration misprediction is much higher, because the CPU may be stuck
+	 * in a shallow idle state for a long time as a result of it.  In that
+	 * case, say we might mispredict and use the known time till the closest
+	 * timer event for the idle state selection.
+	 */
+	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+		predicted_ns = data->next_timer_ns;
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
@@ -316,13 +311,15 @@
 		if (idx == -1)
 			idx = i; /* first enabled state */
 
+		if (s->exit_latency_ns > latency_req)
+			break;
+
 		if (s->target_residency_ns > predicted_ns) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
 			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->exit_latency_ns <= latency_req &&
 			    s->target_residency_ns <= data->next_timer_ns) {
 				predicted_ns = s->target_residency_ns;
 				idx = i;
@@ -354,8 +351,6 @@
 
 			return idx;
 		}
-		if (s->exit_latency_ns > latency_req)
-			break;
 
 		idx = i;
 	}




