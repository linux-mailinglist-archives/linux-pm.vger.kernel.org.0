Return-Path: <linux-pm+bounces-36733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A3C01E63
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2EA1A64186
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE70330B27;
	Thu, 23 Oct 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHnzFiO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0130E0F9;
	Thu, 23 Oct 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231067; cv=none; b=D1CSFd3aKcXWcyQKGGAkPX9V8eFLyjP6yDNocD1EEDHVBZbBo8nMSnC7dIxFh9gL9bwqzxxXAnivuay6yw58/zBTQ8pUsgN1fgwQBjXorpnG8zqULFTf9Ulplnmx4uW5hQe9ORnh/Ad++xiggGI0kzvCE0NH/F9LJ1TduSbbHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231067; c=relaxed/simple;
	bh=ez3PbUsv1rESznuMiJLqjOGEvPB7lEbaKFWMyfGuR24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tq+PHcNIW531PqVYVGNZfQNMeaHc7mSn7HIb7jJm6mx390lNzl5XDWNi8wyT2NSrpe9jvnidfoHsEHhx4LEvZsfxbtxWTHMGH1pHjRnRYWMK7a3tKNhmYMeHE64/tFb2PfurpKzrR5vE3li27mhpHHbCwgT8mAzR2pyTHtIoP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHnzFiO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104C0C4CEF7;
	Thu, 23 Oct 2025 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231066;
	bh=ez3PbUsv1rESznuMiJLqjOGEvPB7lEbaKFWMyfGuR24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHnzFiO06tWmdtxo01tQB8+t4UW5oEUH/c182+Qlqw3JFk0qfYlUX30uXGCJDCmoL
	 KKfT9MFpe5vEr/17FCOlP0s7j4RGqLJwGKE0DotxclxyO0cqbLq+nKa7C2tA+eN76k
	 OV7kqnsh/hazV45WCeORtBcaO63fzzWWvI2wtSynPd+K+YJ63fdqHwSee9WzJTn52Q
	 jXzLpwTyjAH4GBiS8OalknizPk2LVJYyJcw0f7Bduql4/lx1E8QJUPtNDHf/na5lME
	 tXrA9OcFUtnTxy8BZLLH3/ZgeQ4JvTiAB2CRH1Un9OaCVOmxDEEU65GmtPW8iZwfSK
	 pUwc8vfAY9tiw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Frederic Weisbecker' <frederic@kernel.org>,
 'LKML' <linux-kernel@vger.kernel.org>,
 'Peter Zijlstra' <peterz@infradead.org>,
 'Christian Loehle' <christian.loehle@arm.com>,
 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Subject:
 Re: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states with too
 much latency
Date: Thu, 23 Oct 2025 16:51:02 +0200
Message-ID: <5040239.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <004501dc43c9$ec8aa930$c59ffb90$@telus.net>
References:
 <2804546.mvXUDI8C0e@rafael.j.wysocki> <5043159.31r3eYUQgx@rafael.j.wysocki>
 <004501dc43c9$ec8aa930$c59ffb90$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Doug,

On Thursday, October 23, 2025 5:05:44 AM CEST Doug Smythies wrote:
> Hi Rafael,
> 
> Recent email communications about other patches had me
> looking at this one again. 
> 
> On 2025.08.13 03:26 Rafael wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> ... snip...
> 
> > However, after the above change, latency_req cannot take the predicted_ns
> > value any more, which takes place after commit 38f83090f515 ("cpuidle:
> > menu: Remove iowait influence"), because it may cause a polling state
> > to be returned prematurely.
> >
> > In the context of the previous example say that predicted_ns is 3000 and
> > the PM QoS latency limit is still 20 us.  Additionally, say that idle
> > state 0 is a polling one.  Moving the exit_latency_ns check before the
> > target_residency_ns one causes the loop to terminate in the second
> > iteration, before the target_residency_ns check, so idle state 0 will be
> > returned even though previously state 1 would be returned if there were
> > no imminent timers.
> >
> > For this reason, remove the assignment of the predicted_ns value to
> > latency_req from the code.
> 
> Which is okay for timer-based workflow,
> but what about non-timer based, or interrupt driven, workflow?
> 
> Under conditions where idle state 0, or Polling, would be used a lot,
> I am observing about a 11 % throughput regression with this patch
> And idle state 0, polling, usage going from 20% to 0%. 
> 
> From my testing of kernels 6.17-rc1, rc2,rc3 in August and September
> and again now. I missed this in August/September:
> 
> 779b1a1cb13a cpuidle: governors: menu: Avoid selecting states with too much latency - v6.17-rc3
> fa3fa55de0d6 cpuidle: governors: menu: Avoid using invalid recent intervals data - v6.17-rc2
> baseline reference: v6.17-rc1
> 
> teo was included also. As far as I can recall its response has always been similar to rc3. At least, recently.
> 
> Three graphs are attached:
> Sampling data once per 20 seconds, the test is started after the first idle sample,
> and at least one sample is taken after the system returns to idle after the test.
> The faster the test runs the better.
> 
> Test computer:
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> Distro: Ubuntu 24.04.3, server, no desktop GUI.
> CPU frequency scaling driver: intel_pstate
> HWP: disabled.
> CPU frequency scaling governor: performance
> Ilde driver: intel_idle
> Idle governor: menu (except teo for one compare test run)
> Idle states: 4: name : description:
>   state0/name:POLL                desc:CPUIDLE CORE POLL IDLE
>   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
>   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
>   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60

OK, so since the exit residency of an idle state cannot exceed its target
residency, the appended change (on top of 6.18-rc2) should make the throughput
regression go away.

---
 drivers/cpuidle/governors/menu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -321,10 +321,13 @@ static int menu_select(struct cpuidle_dr
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;




