Return-Path: <linux-pm+bounces-41247-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCcELSYqcWniewAAu9opvQ
	(envelope-from <linux-pm+bounces-41247-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 20:33:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9985C407
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75FC17E6373
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125C345734;
	Wed, 21 Jan 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8mnX7pQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB6346E41;
	Wed, 21 Jan 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018680; cv=none; b=cUcwIktMUp0egLjHK1YB5HCX+jqwPcEwclczxAIToC75ypnOq7tJ05rDJkBiaoKftCdOvj7XV+PupvWpD+D04xrAjcvNQKX6Pn0bLLzI2GUwFscOrMPEnvniszTrHeGvAdYOvAtBpbCD4oPycvOmK1PVXDbRfqHKbKuXJMoFKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018680; c=relaxed/simple;
	bh=zgHajdVw61MqSQX6CzNOyKpHHjKBbIr1ZOLWeN8umBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo/MApLVKA3UzHaluwBe0T97kqv+SK7wINZbSm/28a7KN0IdvVZHxruDDCNq0XDs57coJYSff8pwqeSXYLItHSC4wFSoOAepnT68UmH25VLMM6+6S7NT6DqfuGA78yaBSMP1EWHNB/DlaJadf5z6yq5uCeA4xE76PHxC1nmMeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8mnX7pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4622CC19422;
	Wed, 21 Jan 2026 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769018679;
	bh=zgHajdVw61MqSQX6CzNOyKpHHjKBbIr1ZOLWeN8umBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8mnX7pQClLyRszYv6lZRWRdiGNnqFJVNvE+Z4pRPauE/B5J84fJI11PNQMH1FpdF
	 lvVk+nNc1pR35MlRZX2TJZxasZFeYFgtsAIiupoZ1+Mu2nqwtnFa4Pq0xkLuK84QU1
	 5nLpIwResJGOP9yVZm6DcV52yoEGIuz9HzqLJdqkPu2VTyKJd58tOMT3jVv+MKz1Zo
	 Rthm5BKmMGOGaLeGW8ezfj1xH4FCNBHHoJ1p+9eeTG3r+qMbTRIpDI9OJcMVtucqs2
	 jrblMtbHN8h5QqjYpsjlc92BkyVYkW8RD59XEMglysdk1t164EM4kbuay4PvII/fuy
	 emULbyvfdS+qQ==
Date: Wed, 21 Jan 2026 19:04:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 05/15] s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <aXEVM-04lj0lntMr@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
 <20260121121748.9719Bab-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121121748.9719Bab-hca@linux.ibm.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41247-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2B9985C407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Jan 21, 2026 at 01:17:48PM +0100, Heiko Carstens a écrit :
> On Fri, Jan 16, 2026 at 03:51:58PM +0100, Frederic Weisbecker wrote:
> > diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> > index 39cb8d0ae348..54bb932184dd 100644
> > --- a/arch/s390/kernel/idle.c
> > +++ b/arch/s390/kernel/idle.c
> > @@ -35,6 +35,12 @@ void account_idle_time_irq(void)
> >  			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
> >  	}
> >  
> > +	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
> > +
> > +	/* Dyntick idle time accounted by nohz/scheduler */
> > +	if (idle->idle_dyntick)
> > +		return;
> > +
> >  	idle_time = lc->int_clock - idle->clock_idle_enter;
> >  
> >  	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> > @@ -45,7 +51,6 @@ void account_idle_time_irq(void)
> >  
> >  	/* Account time spent with enabled wait psw loaded as idle time. */
> >  	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
> > -	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
> >  	account_idle_time(cputime_to_nsecs(idle_time));
> >  }
> 
> This breaks idle time reporting (aka enabled wait psw time) via the per-cpu
> sysfs files (see show_idle_time()). That is: the second WRITE_ONCE() should
> also go above the early return statement; but of course this leads to other
> dependencies...

Oh right! Will fix that.

BTW here is a question for you, does the timer (as in get_cpu_timer()) still
decrements while in idle? I would assume not, given how lc->system_timer
is updated in account_idle_time_irq().

And another question in this same function is this :

    lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;

clock_idle_enter is updated right before halting the CPU. But when was
last_update_clock updated last? Could be either task switch to idle, or
a previous idle tick interrupt or a previous idle IRQ entry. In any case
I'm not sure the difference is meaningful as steal time.

I must be missing something.

> Not sure what to do with this. I thought about removing those sysfs files
> already in the past, since they are of very limited use; and most likely
> nothing in user space would miss them.

Perhaps but this file is a good comparison point against /proc/stat because
s390 vtime is much closer to measuring the actual CPU halted time than what
the generic nohz accounting does (which includes more idle code execution).

> 
> Anyway, you need to integrate the trivial patch below, so everything compiles
> for s390. It also _seems_ to work.

Thanks, I'll include that.

> 
> Guess I need to spend some more time on accounting and see what it would take
> to convert to VIRT_CPU_ACCOUNTING_GEN, while keeping the current precision and
> functionality.

I would expect more overhead with VIRT_CPU_ACCOUNTING_GEN, though that has yet
to be measured. In any case you'll lose some idle cputime precision (but
you need to read that through s390 sysfs files) if what we want to measure
here is the actual halted time.

Perhaps we could enhance VIRT_CPU_ACCOUNTING_GEN and nohz idle cputime
accounting to match s390 precision. Though I expect some cost
accessing the clock inevitably more often on some machines.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

