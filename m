Return-Path: <linux-pm+bounces-41137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9802D3B911
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63F3B30552D5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCA2F5479;
	Mon, 19 Jan 2026 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXD2y8uy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D82ECD2A;
	Mon, 19 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856692; cv=none; b=e9eZbrW+5ImMvLfoBe0LAuR7iEnuC9s2EG6oLmLG9OiGQP5METNuwOR9+aSZabrlpE2RZlifmC7GHhKphbcE2VNDQR/95mgDDkI5lVgn03rQ044QcrI2ASYoh7PBs0s2xNPG4WEr2H3a0vctkIIFwb71tcxB4jRqmXXBUR6OwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856692; c=relaxed/simple;
	bh=6o+770Yuc3JjhJgvTCTVGSnWnwzkyqp25xUHsXx/C6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeByR0d1kd6xt+S3OTCtqZb3i3HGY82+hGBzWKKJd+y1FlFCnp+RUDykTH2DzuqBnirWCZlZA3FT26zxvrkRAPOMor2Bmo7H9MmZq1cuuTq5oZrk5aWboPOYknDguY0NcthzKpC4mqqnSRUKinoyn/E5mY48orqRz0ah3cV1hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXD2y8uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABEC116C6;
	Mon, 19 Jan 2026 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768856692;
	bh=6o+770Yuc3JjhJgvTCTVGSnWnwzkyqp25xUHsXx/C6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXD2y8uyJXn1wpB61gKSaO/rK1kVC3HviBmxyTELifn8la3q38wzR/8/FAe+5fNYl
	 ik+9L6OTEhlmGu1UQdY4aD1a5aW7HYIXswoYSgJh7xMmBDk3dBcl2jDRPQ3Gekd589
	 SW9zUCR9XPe6pZCj0TKHTnObA3HPP0+tHT8d3okl57iIQ4vOrOe60WdPZmfCCXT5Sc
	 6Z8dPnAGg1Dv34Rm1pypG+/y+3MHgCNUROe90BwGxYzcjF9MSHa3jR/Mg0xsSEaBI0
	 mYwEoCld9S81GOQ2xQZh3gPzMLIX2nazcrTF/Va1DfE4XpjmaE6W4b3KxEe9XYL5Ud
	 PiMpAlO96fSFA==
Date: Mon, 19 Jan 2026 22:04:49 +0100
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
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Message-ID: <aW6ccexiQaPLQcS1@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-2-frederic@kernel.org>
 <20260119125347.GT830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119125347.GT830755@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 01:53:47PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:51:54PM +0100, Frederic Weisbecker wrote:
> 
> >  kernel/sched/idle.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index c174afe1dd17..35d79af3286d 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -260,6 +260,12 @@ static void do_idle(void)
> >  {
> >  	int cpu = smp_processor_id();
> >  
> > +	if (cpu_is_offline(cpu)) {
> 
> Does it make sense to make that: if (unlikely(cpu_is_offline(cpu))) ?

Yes indeed!

> 
> > +		local_irq_disable();
> 
> Also, do we want something like:
> 
> 		WARN_ON_ONCE(need_resched());
> 
> ?

Definetly.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

