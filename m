Return-Path: <linux-pm+bounces-41138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E7D3BA16
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0633046F9E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C82F99AE;
	Mon, 19 Jan 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSAIwNdQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A9270ED2;
	Mon, 19 Jan 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858533; cv=none; b=jtZuPsuFpWv3Cm5bsZCs+bXf6A66/3FAdX6YfXFqO4IaEJpOUkIm/lL85A6+4XQ7Gn2Jw8lGjqpVP+BeB+WvHpbMk0R3c+GXLqOAuph/s4diLOTGBSAaMfsue1kY5EFn8wsYhboEzrZQcaXud0fM+4lRgw9AAXKnYUm7EXKNVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858533; c=relaxed/simple;
	bh=0p+D1qtaD6EK8C9QKDFoPkOIUPj6Z1i1of+RsQtd/cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1HKtsn5D5E3hTYAWWFCpep9i0deVW0lH/rtMA+NdkqX0m4yo0yGLctopwU7G7FQEaGLk/9SM1fNygjp6xoQPGvU+b+q5usNswLkR4uAMgxM2Sj5gE9xn1ZE9wCyqcQ+SadvQ90yVaHLmwRkFLK5LDD3Ts+0drCtMR8J11RsTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSAIwNdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0C1C116C6;
	Mon, 19 Jan 2026 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858532;
	bh=0p+D1qtaD6EK8C9QKDFoPkOIUPj6Z1i1of+RsQtd/cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSAIwNdQQpkp6oMgDpbCk+aNpAf6NI2V725snnSdP/1pmAdfS3Z0rJzX4h5DcxvFk
	 he5wkSyrVbdLVDRqeW60oboR/CVs8iv/ehVA9r3xvdBmgy+VucsNGLxHs3bUGOjD28
	 FmUsaMyToLjzkt3XEayVquD8ffomEAH717Qbbd/fRv1lL5ONzILiAlLSDK5Ns3beKx
	 Nox0RTElcLc12JWarif0zviVNfKUm5+4QlZHWp2xyULlMmJPnuQ8wl5WMeZVRinLNj
	 lJ2+BAmYoLVbh37cwBxVyrBaNv3562IluyDYvsPwtjLURINRBu+qCzcQJolzJWV2sW
	 SWlm3jQOOI5hA==
Date: Mon, 19 Jan 2026 22:35:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/15] sched/cputime: Correctly support generic vtime
 idle time
Message-ID: <aW6johe2ZUR9l39Z@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-4-frederic@kernel.org>
 <20260119130222.GU830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119130222.GU830755@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 02:02:22PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:51:56PM +0100, Frederic Weisbecker wrote:
> 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 8ddf74e705d3..f1d07a0276a5 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -780,7 +780,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
> >  	ktime_t now, idle;
> >  	unsigned int seq;
> >  
> > -	if (!tick_nohz_active)
> > +	if (!tick_nohz_active || vtime_generic_enabled_cpu(cpu))
> >  		return -1;
> >  
> >  	now = ktime_get();
> 
> Is this not broken? IIUC this means that you can no longer use
> get_cpu_{idle,iowait}_time_us() the moment you have context tracking
> enabled.

It is supported again in patch 13/15. And it's not exactly breaking
bisection in the meantime because the sole user is cpufreq and cpufreq
shouldn't be relevant with nohz_full.

Ok a few subsystem rely on the resulting cpufreq API get_cpu_idle_time():

- the legacy drivers/macintosh/rack-meter.c
- drivers/scsi/lpfc/lpfc_init.c

But cpufreq provides a low-resolution version in the worst case for nohz_full
(again until 13/15).

Hmm, but you're right this is confusing. I think I should be able to fix that
in this patch.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

