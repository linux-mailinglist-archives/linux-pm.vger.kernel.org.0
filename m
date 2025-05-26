Return-Path: <linux-pm+bounces-27638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62BAC3B39
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875CA18877BD
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4CE1E32A2;
	Mon, 26 May 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4dePnaS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA31DF26E;
	Mon, 26 May 2025 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247120; cv=none; b=U/8oCdm8VRVrF1O/7HHgCOMk1Kn7QYT6buP1BncJ2JJzMafdaDIi2czJNo3NT8tJmJbqMao4tCeJvuA0JZ/0mDtgkFuTcV6xnpQuEJR1bW/48xsDGN5Bwi/vRl+qztIgKehlSAQFyv4JcVS4NmszkxkyjBdu0LLYoHcJpkgLY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247120; c=relaxed/simple;
	bh=0tjbl8QDCX/Gi0+zZfCr8Oy262R0AhDETMxOJlisbrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKeEui+cVR6SYdM7uwsdWWVuZf66ihD6qU+RPSTcTkqAQ5fo0vApJ7AwRpkPyhNwCLX2eBfFtJ9USVTe2wx3Ey4ITXnAiKlSv5U0LR8Dw9j4XveytY/F4qGHxz4kxAt/1lCxUKdbt+VDj3hzWUTEfnecAarfyIci2zIf9a4YFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4dePnaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE473C4CEE7;
	Mon, 26 May 2025 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748247119;
	bh=0tjbl8QDCX/Gi0+zZfCr8Oy262R0AhDETMxOJlisbrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4dePnaSz2TeITbuWxNYza2cLBbq6OxvdTWndda/54DxiVNC8Q2AZ4WKZGFYzFsr/
	 IId+iolffLkqta21Rgk+dnMnhLE/5LC0O5VABRc7+v75Kbmbj2VJF0GGMhKzwC5Qh4
	 /9ws/iv4u7JXcTEwv39WpimBRMy/dbPrBcGOQy/OzEGnw6Cb7rdxhvpS4TMBAP+2Px
	 Ju6QVonGzW/upCvyD/mP8Ceyjb1yCY3PZ3YbavzlGl3sZeUsYUTA8Z0a+jWEWJ5UVJ
	 53fJt67/cMVOnCh8C12sAPgTtusQGQAWypYd6MjLIqGfz4u8PSDvNc06Flh39GIuza
	 ovSCaKSPUYONA==
Date: Mon, 26 May 2025 10:11:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <aDQiSF0OwoSBMkE3@gmail.com>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> Due to the weird Makefile setup of sched the various files do not 
> compile as stand alone units. The new generation of editors are 
> trying to do just this -- mostly to offer fancy things like 
> completions but also better syntax highlighting and code navigation.
> 
> Specifically, I've been playing around with neovim and clangd.
> 
> Setting up clangd on the kernel source is a giant pain in the arse 
> (this really should be improved), but once you do manage, you run 
> into dumb stuff like the above.
> 
> Fix up the scheduler files to at least pretend to work.

>  kernel/sched/autogroup.c         |    3 +++
>  kernel/sched/autogroup.h         |    2 ++
>  kernel/sched/clock.c             |    3 +++
>  kernel/sched/completion.c        |    5 +++++
>  kernel/sched/core_sched.c        |    2 ++
>  kernel/sched/cpuacct.c           |    2 ++
>  kernel/sched/cpudeadline.c       |    1 +
>  kernel/sched/cpudeadline.h       |    2 ++
>  kernel/sched/cpufreq.c           |    1 +
>  kernel/sched/cpufreq_schedutil.c |    2 ++
>  kernel/sched/cpupri.c            |    1 +
>  kernel/sched/cpupri.h            |    3 +++
>  kernel/sched/cputime.c           |    3 +++
>  kernel/sched/deadline.c          |    4 ++++
>  kernel/sched/debug.c             |    3 +++
>  kernel/sched/idle.c              |    5 +++++
>  kernel/sched/isolation.c         |    2 ++
>  kernel/sched/loadavg.c           |    2 ++
>  kernel/sched/membarrier.c        |    2 ++
>  kernel/sched/pelt.c              |    1 +
>  kernel/sched/pelt.h              |    7 ++++++-
>  kernel/sched/psi.c               |    2 ++
>  kernel/sched/rt.c                |    3 +++
>  kernel/sched/sched-pelt.h        |    1 +
>  kernel/sched/sched.h             |    1 +
>  kernel/sched/smp.h               |    1 +
>  kernel/sched/stats.c             |    1 +
>  kernel/sched/stop_task.c         |    1 +
>  kernel/sched/swait.c             |    1 +
>  kernel/sched/topology.c          |    2 ++
>  kernel/sched/wait.c              |    1 +
>  kernel/sched/wait_bit.c          |    3 +++
>  32 files changed, 72 insertions(+), 1 deletion(-)

Yeah, I see no reason why this wouldn't work - and the original build 
speedup will still be present.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

