Return-Path: <linux-pm+bounces-32254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518CB24736
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D618462316C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD02F3C25;
	Wed, 13 Aug 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYcYVq2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854B27FB12;
	Wed, 13 Aug 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081023; cv=none; b=av31feSh3oEH17MY9j5wR7A0zBIApE5vMRurA3NT+ByQAcx0f2lFthEkmZGMOsWr907jq/XKDCu1o9UA7tQpTnZqbafo4XLIGlrV7JWWxgjJwWYa77gaGNR/gJAAO368o5+MM26egN4jRyKHSeEzmMjf8EUsNTcTHbHSOxYSSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081023; c=relaxed/simple;
	bh=vDPhAaa14SEPGFOTgtOyQn/Sq2qo0iYZvFtBPzZ4t1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU1GxoWPDcJYt6xJr6Vnq/OABLgojD5ie1U1+JXyg/NgAnRCBpdA2YOU9LK9bTW+4IDMHhg6dQ3q+qgjN+vFOK0ZeL0V2aGtRp1OXZCRl4ei2g5Tb4f01FfRLbbX33jIOuA30rD0p5Z0joAoznQxoTjgA7Kk64DCmH5/ZCZINSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYcYVq2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330A8C4CEEB;
	Wed, 13 Aug 2025 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081023;
	bh=vDPhAaa14SEPGFOTgtOyQn/Sq2qo0iYZvFtBPzZ4t1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYcYVq2cYeyg33K6b1yGD/Zb67bkv0TNBDV+giZjQ0RtN1ktgtRkN08z+/S0klgge
	 0YlSe+Vfm2kjFp09yuHClNnGrnpWilfZfALso27/9W3WxDW7hJbHKdrrWDtjjqZdbd
	 opNc9/y1IQ64OvOT+D+cgTiglF7ocmEGLqPEjda+EBP4RDRIRJ8rY3iyKZknbyZ4E+
	 aOATNkv4klY+xnvZJXnjNA1v3apd2FCJe2rdliM3tAawBhSyrVLwc3iQ9gwr9sE1xR
	 1c07GU1MfRjktDlkMP/654kiFcoxXsp398SJng6Tj1TwZRqPWE0tJE4/cqIVrSlaPX
	 rR2e2V8hGYz/w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
Date: Wed, 13 Aug 2025 12:29:51 +0200
Message-ID: <2244365.irdbgypaU6@rafael.j.wysocki>
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

When the menu governor runs on a nohz_full CPU and there are no user
space timers in the workload on that CPU, it ends up selecting idle
states with target residency values above TICK_NSEC all the time due to
a tick_nohz_tick_stopped() check designed for a different use case.
Namely, on nohz_full CPUs the fact that the tick has been stopped does
not actually mean anything in particular, whereas in the other case it
indicates that previously the CPU was expected to be idle sufficiently
long for the tick to be stopped, so it is not unreasonable to expect
it to be idle beyond the tick period length again.
  
In some cases, this behavior causes latency in the workload to grow
undesirably.  It may also cause the workload to consume more energy
than necessary if the CPU does not spend enough time in the selected
deep idle states.

Address this by amending the tick_nohz_tick_stopped() check in question
with a tick_nohz_full_cpu() one to avoid using the time till the next
timer event as the predicted_ns value all the time on nohz_full CPUs.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -293,8 +293,18 @@
 	 * in a shallow idle state for a long time as a result of it.  In that
 	 * case, say we might mispredict and use the known time till the closest
 	 * timer event for the idle state selection.
+	 *
+	 * However, on nohz_full CPUs the tick does not run as a rule and the
+	 * time till the closest timer event may always be effectively infinite,
+	 * so using it as a replacement for the predicted idle duration would
+	 * effectively always cause the prediction results to be discarded and
+	 * deep idle states to be selected all the time.  That might introduce
+	 * unwanted latency into the workload and cause more energy than
+	 * necessary to be consumed if the discarded prediction results are
+	 * actually accurate, so skip nohz_full CPUs here.
 	 */
-	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+	if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &&
+	    predicted_ns < TICK_NSEC)
 		predicted_ns = data->next_timer_ns;
 
 	/*




