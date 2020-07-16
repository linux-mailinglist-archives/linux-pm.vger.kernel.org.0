Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9D2227AD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgGPPnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPPnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 11:43:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCAC061755;
        Thu, 16 Jul 2020 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YW5k+8pBftzmTCtcIt+wTiL8y5jSa7qLtn99P+gDtao=; b=SZ3PqTunaJSTw0BWY3Eh6geqHA
        Wq5ztdJoKSqJWRbZ1ovA10m4jye7t7pV3JTzwqbxd9uFx2pzEN+IxPPzaPnyzW3z7h9AtNaiULduI
        JGIPzHVv8LAL6i0BhGxx9F6kAi+lOD53gVynnveS82YWc58ZIX8m9p39fchoCbCB2c1Y14py/5cAq
        BXZwj+ovwGwbKZZLGNJn3fZapITLS2lqQIKe5MFP216QxOdO7aRT4BU8fO/cLoeaztpKhKMo8Vg0d
        1v8YadZM3WhgPctuafBuuBaBkqcMPypUlv81S60B6huY2usvOlteddvsyNtdQmHc7OSyH9B31JOcB
        7HZcpAaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw62s-0004nQ-IV; Thu, 16 Jul 2020 15:43:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7CED300446;
        Thu, 16 Jul 2020 17:43:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A42320298C02; Thu, 16 Jul 2020 17:43:35 +0200 (CEST)
Date:   Thu, 16 Jul 2020 17:43:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200716154335.GT10769@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 16, 2020 at 03:24:37PM +0100, Lukasz Luba wrote:
> On 7/16/20 12:56 PM, Peter Zijlstra wrote:

> > The second attempts to guesstimate power, and is the subject of this
> > patch.
> > 
> > Currently cpufreq_cooling appears to estimate the CPU energy usage by
> > calculating the percentage of idle time using the per-cpu cpustat stuff,
> > which is pretty horrific.
> 
> Even worse, it then *samples* the *current* CPU frequency at that
> particular point in time and assumes that when the CPU wasn't idle
> during that period - it had *this* frequency...

*whee* :-)

...

> In EM we keep power values in the array and these values grow
> exponentially. Each OPP has it corresponding
> 
> P_x = C (V_x)^2 f_x    , where x is the OPP id thus corresponding V,f
> 
> so we have discrete power values, growing like:
> 
> ^(power)
> |
> |
> |                          *
> |
> |
> |                       *
> |                       |
> |                   *   |
> |                       | <----- power estimation function
> |            *          |        should not use linear 'util/max_util'
> |   *                   |        relation here *
> |_______________________|_____________> (freq)
>    opp0     opp1  opp2 opp3 opp4
> 
> What is the problem
> First:
> We need to pick the right Power from the array. I would suggest
> to pick the max allowed frequency for that whole period, because
> we don't know if the CPUs were using it (it's likely).
> Second:
> Then we have the utilization, which can be considered as:
> 'idle period & running period with various freq inside', lets
> call it avg performance in that whole period.
> Third:
> Try to estimate the power used in that whole period having
> the avg performance and max performance.
> 
> What you are suggesting is to travel that [*] line in
> non-linear fashion, but in (util^3)/(max_util^3). Which means
> it goes down faster when the utilization drops.
> I think it is too aggressive, e.g.
> 500^3 / 1024^3 = 0.116  <--- very little, ~12%
> 200^3 / 300^3  = 0.296
> 
> Peter could you confirm if I understood you correct?

Correct, with the caveat that we might try and regression fit a 3rd
order polynomial to a bunch of EM data to see if there's a 'better'
function to be had than a raw 'f(x) := x^3'.

> This is quite important bit for me.

So, if we assume schedutil + EM, we can actually have schedutil
calculate a running power sum. That is, something like: \Int P_x dt.
Because we know the points where OPP changes.

Although, thinking more, I suspect we need tighter integration with
cpuidle, because we don't actually have idle times here, but that should
be doable.

But for anything other than schedutil + EM, things become more
interesting, because then we need to guesstimate power usage without the
benefit of having actual power numbers.

We can of course still do that running power sum, with whatever P(u) or
P(f) end up with, I suppose.

> > Another point is that cpu_util() vs turbo is a bit iffy, and to that,
> > things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
> > have the benefit of giving you values that match your own sampling
> > interval (100ms), where the sched stuff is PELT (64,32.. based).
> > 
> > So what I've been thinking is that cpufreq drivers ought to be able to
> > supply this method, and only when they lack, can the cpufreq-governor
> > (schedutil) install a fallback. And then cpufreq-cooling can use
> > whatever is provided (through the cpufreq interfaces).
> > 
> > That way, we:
> > 
> >   1) don't have to export anything
> >   2) get arch drivers to provide something 'better'
> > 
> > 
> > Does that sounds like something sensible?
> > 
> 
> Yes, make sense. Please also keep in mind that this
> utilization somehow must be mapped into power in a proper way.
> I am currently working on addressing all of these problems
> (including this correlation).

Right, so that mapping util to power was what I was missing and
suggesting we do. So for 'simple' hardware we have cpufreq events for
frequency change, and cpuidle events for idle, and with EM we can simply
sum the relevant power numbers.

For hardware lacking EM, or hardware managed DVFS, we'll have to fudge
things a little. How best to do that is up in the air a little, but
virtual power curves seem a useful tool to me.

The next problem for IPA is having all the devices report power in the
same virtual unit I suppose, but I'll leave that to others ;-)


