Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9215BF10
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 14:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBMNUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 08:20:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMNUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 08:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nWao7vXWLar6EbgrIS/9bZuzm1XeNtdsbw4OYMTbL/M=; b=YL7jWle7dwKJ7y6uA233H/5va/
        bd3hQTOHGhqIYXvS0EmW1x40asB7IWG/bET8mwG4x7JcY8U5ry1YPN4NAKRaCZXuqM9sZIUIRS9iA
        BSAYEZBidCgYC4rBF1bbMNFJ8srloqJB1nzG+KStqWgQo3E4ZVTw+cqO1g6YQQveNINvqesZ2rT4S
        Kp4/vEcpCUw4Gy6OcsPZFSro7Ed9dXwLMD9QyRFS2y9e2H/Ezn+nFH/JdJ44YzuickbY2JPgw8duQ
        1iMOigG0kG86X1EiWIZg85Ls2O0M3z6Bz811rt5ADraVjt7ue2RzlxeXySgRkDmmJ1PVVEztUwKWa
        jg77drNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2EPq-0008TQ-Tz; Thu, 13 Feb 2020 13:20:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF386300446;
        Thu, 13 Feb 2020 14:18:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89FF22B2E4996; Thu, 13 Feb 2020 14:20:24 +0100 (CET)
Date:   Thu, 13 Feb 2020 14:20:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20200213132024.GP14897@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
 <d0155018-52e6-e1c9-a03d-1b9703b7a28a@arm.com>
 <20200210133051.GI14897@hirez.programming.kicks-ass.net>
 <278bff0c-6f49-5200-d7df-1c844de1c98c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278bff0c-6f49-5200-d7df-1c844de1c98c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 11:55:32AM +0000, Douglas Raillard wrote:
> On 2/10/20 1:30 PM, Peter Zijlstra wrote:

> > So ARM64 will soon get x86-like power management if I read these here
> > patches right:
> > 
> >   https://lkml.kernel.org/r/20191218182607.21607-2-ionela.voinescu@arm.com
> > 
> > And I'm thinking a part of Rafael's concerns will also apply to those
> > platforms.
> 
> AFAIU there is an important difference: ARM64 firmware should not end up
> increasing frequency on its own, it should only cap the frequency. That
> means that the situation stays the same for that boost:
> 
> Let's say you let schedutil selecting a freq that is +2% more power
> hungry. That will probably not be enough to make it jump to the next
> OPP, so you end up not boosting. Now if there is a firmware that decides
> for some reasons to cap frequency, it will be a similar situation.

The moment you give out OPP selection to a 3rd party (be it firmware or
a micro-controller) things are uncertain at best anyway.

Still, in general, if you give it higher input, it tends to at least
consider going faster -- which might be all you can ask for...

So I'm not exactly seeing what your argument is here.

> > Right, so the condition 'util_avg > util_est' makes sense to trigger
> > some sort of boost off of.
> > 
> > What kind would make sense for these platforms? One possibility would be
> > to instead of frobbing the energy margin, as you do here, to frob the C
> > in get_next_freq().
> 
> If I'm correct, changing the C value would be somewhat similar to the
> relative boosting I had in a previous version. Maybe adding a fixed
> offset would give more predictable results as was discussed with Vincent
> Guittot. In any case, it would change the perceived util (like iowait
> boost).

It depends a bit on what you change C into. If we do something trivial
like:
		1.25 ; !(util_avg > util_est)
	C := {
		2    ;  (util_avg > util_est)

ie. a binary selection of constants, then yes, I suppose that is the
case.

But nothing stops us from making it more complicated; or having it
depend on the presence of EM data.

> > (I have vague memories of this being proposed earlier; it also avoids
> > that double OPP iteration thing complained about elsewhere in this
> > thread if I'm not mistaken).
> 
> It should be possible to get rid of the double iteration mentioned by
> Quentin. Choosing to boost the util or the energy boils down to:
> 
> 1) If you care more about predictable battery life (or energy bill) than
> predictability of the boost feature, EM should be used.
> 
> 2) If you don't have an EM or you care more about having a predictable
> boost for a given workload, use util (or disable that boost).
> 
> The rational is that with 1), you will get a different speed boost for a
> given workload depending on the other things executing at the same time,
> as the speed up is not linear with the task-related metric (util -
> util_est). If you are already at high freq because of another workload,
> the speed up will be small because the next 100Mhz will cost much more
> than the same +100Mhz delta starting from a low OPP.

It's just that I'm not seeing how 1 actually works or provides that more
predictable battery life I suppose. We have this other sub-thread to
argue about that :-)

> > That is; I'm thinking it is important (esp. now that we got frequency
> > invariance sorted for x86), to have this patch also work for !EM
> > architectures (as those ARM64-AMU things would be).
> 
> For sure, that feature is supposed to help in cases that would be
> impossible to pinpoint with hardware, since it has to know what tasks
> execute.

OK, so I'm thinking we're agreeing that it would be good to have this
support !EM systems too.
