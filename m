Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523C39CCA8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfHZJlG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:41:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfHZJlG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cpMCmokty3jsi/04xYp8Y95YiA93Dy+2Li8BcOeH3YU=; b=n3xv8lL4P59BNaCxMzSy3lBBd
        QDGK1Acqom5rXn84uwykR9/Y64XAmKjnMNSCBqF8+kMxn93bZK6RAGviTatQjlDh2Xi/W/3PF2f+q
        XrrvHnqNxgB+7frqPFXOZ6W7o7I9P3wTkyYO5hpEtwMObjx9lVTpv2rBakgMWwty0j32U1lvdWvZo
        TpZez73uuLjRXXda8Qm/wA/+rcqQd8wtjfkH+LM9eAeNN/8/FYJtrOmYGRohiVcy6vuWndLgvQftd
        BUb8t5iD1sG+z4f3z+5MT3s+981VE/duSMNHb0Cwsuwib2RJpzX85+oaymWCQJBYqWGEhh0H5ZVp9
        7Ncutfuog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2BUi-0003eJ-Ex; Mon, 26 Aug 2019 09:41:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2364B301FF9;
        Mon, 26 Aug 2019 11:40:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85BD420991192; Mon, 26 Aug 2019 11:40:58 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:40:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast
 switching
Message-ID: <20190826094058.GP2369@hirez.programming.kicks-ass.net>
References: <20190807153340.11516-1-douglas.raillard@arm.com>
 <3316959.EEulJYEQYJ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3316959.EEulJYEQYJ@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 26, 2019 at 11:10:52AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 7, 2019 5:33:40 PM CEST Douglas RAILLARD wrote:
> > Fast switching path only emits an event for the CPU of interest, whereas the
> > regular path emits an event for all the CPUs that had their frequency changed,
> > i.e. all the CPUs sharing the same policy.
> > 
> > With the current behavior, looking at cpu_frequency event for a given CPU that
> > is using the fast switching path will not give the correct frequency signal.
> > 
> > Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 1f82ab108bab..975ccc3de807 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -153,6 +153,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> >  			      unsigned int next_freq)
> >  {
> >  	struct cpufreq_policy *policy = sg_policy->policy;
> > +	int cpu;
> >  
> >  	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> >  		return;
> > @@ -162,7 +163,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> >  		return;
> >  
> >  	policy->cur = next_freq;
> > -	trace_cpu_frequency(next_freq, smp_processor_id());
> > +
> > +	if (trace_cpu_frequency_enabled()) {
> > +		for_each_cpu(cpu, policy->cpus)
> > +			trace_cpu_frequency(next_freq, cpu);
> > +	}
> >  }
> >  
> >  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> > 
> 
> Peter, any comments here?

I was thinking this would be a static map and dealing with it would be
something trivially done in post (or manually while reading), but sure,
whatever:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
