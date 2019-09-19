Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B98B8848
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 01:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436853AbfISXzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 19:55:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:22723 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436849AbfISXzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 19:55:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 16:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; 
   d="scan'208";a="338820974"
Received: from spandruv-mobl3.jf.intel.com ([10.255.93.177])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2019 16:55:22 -0700
Message-ID: <f5fde2bc758cc15fdb575f52c2138bb67aa514b7.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Date:   Thu, 19 Sep 2019 16:55:22 -0700
In-Reply-To: <1568730426.3329.3.camel@suse.cz>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <4226d5f460604a8130f8079b74ef3fb1d60009d7.camel@linux.intel.com>
         <1568730426.3329.3.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-09-17 at 16:27 +0200, Giovanni Gherdovich wrote:
> Hello Srinivas,
> 
> On Fri, 2019-09-13 at 15:52 -0700, Srinivas Pandruvada wrote:
> > On Mon, 2019-09-09 at 04:42 +0200, Giovanni Gherdovich wrote:
> > 
> > ...
> > 
> > > +
> > > +/*
> > > + * APERF/MPERF frequency ratio computation.
> > > + *
> > > + * The scheduler wants to do frequency invariant accounting and
> > > needs a <1
> > > + * ratio to account for the 'current' frequency, corresponding
> > > to
> > > + * freq_curr / freq_max.
> > 
> > I thought this is no longer the restriction and Vincent did some
> > work
> > to remove this restriction. 
> 
> If you're referring to the patch
> 
>   23127296889f "sched/fair: Update scale invariance of PELT"
> 
> merged in v5.2, I'm familiar with that and from my understanding you
> still
> want a <1 scaling factor. This is my recalling of the patch:
> 
> Vincent was studying some synthetic traces and realized that util_avg
> reported
> by PELT didn't quite match the result you'd get computing the formula
> with pen
> and paper (theoretical value). To address this he changed where the
> scaling
> factor is applied in the PELT formula.
> 
> At some point when accumulating the PELT sums, you'll have to measure
> the time
> 'delta' since you last updated PELT. What we have after Vincent's
> change is
> that this time length 'delta' gets itself scaled by the
> freq_curr/freq_max
> ratio:
> 
>     delta = time since last PELT update
>     delta *= freq_percent
> 
> In this way time goes at "wall clock speed" only when you're running
> at max
> capacitiy, and goes "slower" (from the PELT point of view) if we're
> running at
> a lower frequency. I don't think Vincent had in mind a faster-than-
> wall-clock
> PELT time (which you'd get w/ freq_percent>1).
> 
> Speaking of which, Srinivas, do you have any opinion and/or
> requirement about
> this? I confusely remember Peter Zijlstra saying (more than a year
> ago, now)
> that you would like an unclipped freq_curr/freq_max ratio, and may
> not be
> happy with this patch clipping it to 1 when freq_curr >
> 4_cores_turbo. If
> that's the case, could you elaborate on this?
> Ignore that if it doesn't make sense, I may be mis-remembering.
I was thinking of power efficiency use case particularly for Atom like
platforms, 1C max as you observed is more efficient.

But now sched deadline code is using  arch_scale_freq_capacity(() to
calculate dl_se->runtime, where closer to deterministic value with all
cores, may be better, which will be scaled with base_freq. 

Thanks,
Srinivas

