Return-Path: <linux-pm+bounces-22746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783DA40D94
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D55188F31D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A11FF60F;
	Sun, 23 Feb 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlM3j7eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47102F3B;
	Sun, 23 Feb 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740302053; cv=none; b=qzEyi11Po+U1eLL0zrCRbLhJhPCfFbLZmJgB5cFIA4kQXlfB4qWso9mqjE1l8pCCEhCjUASyKkjaTf3K8QdEWJJ2j1CkzndhgwFWET20O7FnHqDXjp5xQpZMPsnzlaiG9a0uJcGcOAvozkdNH5Ug8NclsclASzmKyLEcDcUXZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740302053; c=relaxed/simple;
	bh=e3MLitCw7D3X/U7auB+ppYOPCSnINJcC2N1dZEbnDSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVdapXnuWLIa7ghUo7fbAB3dIPQQ9IsJPS3EG/QNMMd9jwfezRk2SoxnRIpvej1bs1NkacuUxdTh7xlE52/o3jpzFGOLSQ/tDaqe1H+owbSIXaH1g6SJBWAR5zjipTwgyCTTP3TYlTL+sWEofOxYn1XgzksHnBmDd8E1EFaqXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlM3j7eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B358C4CEDD;
	Sun, 23 Feb 2025 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740302053;
	bh=e3MLitCw7D3X/U7auB+ppYOPCSnINJcC2N1dZEbnDSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlM3j7egETNnva6c3BLp45eauCK15Vg7x7JZbaOrcy3c16hp3uXKHGyo6JylfC3hi
	 ITKnBtFVSAx5VCJ/Ov03bALU9TTKoaqNJSFR0uPVpY/AoExbYeWcShcyYcu/b65M/H
	 py4he7kbcmq3iY96KDKI46niJzTR9MH3ujQNCjZ+YrfxmZBCT5oyUGRd5jDGN9can4
	 47MlSFz14m9uaxFCkRg/xWBBh36tt97vzKa12wMbSVOj8RWTxG3A67PddnxUDG/b2P
	 THjodkoRJLqpSYXxxtRM2kepZsjBFx7rMS4KiBJtxv4F54EbGYeXWkb4UJRfP7cpX6
	 H8T+BPZC6Ol7Q==
Date: Sun, 23 Feb 2025 10:14:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, Anjali K <anjalik@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] sched: Consolidate cpufreq updates
Message-ID: <Z7rm2XRqhCM8m9IU@gmail.com>
References: <20250209235204.110989-1-qyousef@layalina.io>
 <Z7igK4w4PW1T_PCw@gmail.com>
 <20250223000351.xg53osxswsxxohye@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223000351.xg53osxswsxxohye@airbuntu>


* Qais Yousef <qyousef@layalina.io> wrote:

> On 02/21/25 16:47, Ingo Molnar wrote:
> > 
> > * Qais Yousef <qyousef@layalina.io> wrote:
> > 
> > > ---
> > >  include/linux/sched/cpufreq.h    |   4 +-
> > >  kernel/sched/core.c              | 116 +++++++++++++++++++++++++++--
> > >  kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++------------
> > >  kernel/sched/deadline.c          |  10 ++-
> > >  kernel/sched/fair.c              |  84 +++++++++------------
> > >  kernel/sched/rt.c                |   8 +-
> > >  kernel/sched/sched.h             |   9 ++-
> > >  kernel/sched/syscalls.c          |  30 ++++++--
> > >  8 files changed, 266 insertions(+), 117 deletions(-)
> > 
> > The changelog is rather long, and the diffstat is non-trivial.
> > 
> > Could you please split this up into multiple patches?
> 
> Sure. I did consider that but what stopped me is that I couldn't see 
> how I could break them into independent patches. A lot of corner 
> cases needed to be addressed and if I moved them to their own patches 
> I'd potentially break bisectability of this code. If this is not a 
> problem then I can see how I can do a better split. If it is a 
> problem, I'll still try to think it over but it might require a bit 
> of stretching. But I admit I didn't try to think it over that hard.

Yeah, so bisectability should definitely be preserved.

I had a quick look, and these changes look fairly easy to split up to 
reduce size/complexity of individual patches. The following split looks 
pretty natural:

 # ============{ Preparatory changes with no change in functionality: }=========>

 [PATCH 1/9] Extend check_class_changed() with the 'class_changed' return bool
             # But don't use it at call sites yet

 [PATCH 2/9] Introduce and maintain the sugov_cpu::last_iowait_update metric
             # But don't use it yet

 [PATCH 3/9] Extend sugov_iowait_apply() with a 'flags' parameter
             # But don't use it yet internally

 [PATCH 4/9] Extend sugov_next_freq_shared() with the 'flags' parameter
             # But don't use it yet internally

 [PATCH 5/9] Clean up the enqueue_task_fair() control flow to make it easier to extend
             # This adds the goto restructuring but doesn't change functionality

 [PATCH 6/9] Introduce and maintain the cfs_rq::decayed flag
             # But don't use it yet

 [PATCH 7/8] Extend __setscheduler_uclamp() with the 'update_cpufreq' return bool
             # But don't use it yet

 # ============{ Behavioral changes: }==========>

 [PATCH 8/9] Change sugov_iowait_apply() behavior
 [PATCH 9/9] Change sugov_next_freq_shared() bahavior

 ... etc.

This is only a quick stab at the most trivial split-ups, it's not a 
complete list, and I saw other opportunities for split-up too. Please 
make these changes as finegrained as possible, as it changes behavior 
and there is a fair chance of behavioral regressions down the road - 
especially as the patch itself notes that even the new logic isn't 
perfect yet.

If the behavioral changes can be split into further steps, that would 
be preferable too.

Also:

 - Please make the rq->cfs.decayed logic unconditional on UP too, even 
   if it's not used. This reduces some of the ugly #ifdeffery AFAICS.

 - Please don't add prototypes for internal static functions like 
   __update_cpufreq_ctx_switch(), define the functions in the right 
   order instead.

 - Also, please read your comments and fix typos:

+                * This logic relied on PELT signal decays happening once every
+                * 1ms. But due to changes to how updates are done now, we can
+                * end up with more request coming up leading to iowait boost
+                * to be prematurely reduced. Make the assumption explicit
+                * until we improve the iowait boost logic to be better in
+                * general as it is due for an overhaul.

  s/request
   /requests

+        * We want to update cpufreq at context switch, but on systems with
+        * long TICK values, this can happen after a long time while more tasks
+        * would have been added meanwhile leaving us potentially running at
+        * inadequate frequency for extended period of time.

  Either 'an inadequate frequency' or 'inadequate frequencies'.

+        * This logic should only apply when new fair task was added to the
+        * CPU, we'd want to defer to context switch as much as possible, but
+        * to avoid the potential delays mentioned above, let's check if this
+        * additional tasks warrants sending an update sooner.

  s/when new fair task
   /when a new fair task

  s/this additional tasks
   /this additional task

(I haven't checked the spelling exhaustively, there might be more.)

Thanks,

	Ingo

