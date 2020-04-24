Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A741B6D8E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 07:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXFxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 01:53:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgDXFxV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Apr 2020 01:53:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E520DAD9A;
        Fri, 24 Apr 2020 05:53:17 +0000 (UTC)
Message-ID: <1587707595.28179.11.camel@suse.cz>
Subject: Re: [PATCH 1/4] x86, sched: Bail out of frequency invariance if
 base frequency is unknown
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri, 24 Apr 2020 07:53:15 +0200
In-Reply-To: <20200424013222.GA26355@ranerica-svr.sc.intel.com>
References: <20200416054745.740-1-ggherdovich@suse.cz>
         <20200416054745.740-2-ggherdovich@suse.cz>
         <20200422171547.GA11942@ranerica-svr.sc.intel.com>
         <1587629164.28094.11.camel@suse.cz>
         <20200424013222.GA26355@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-04-23 at 18:32 -0700, Ricardo Neri wrote:
> On Thu, Apr 23, 2020 at 10:06:04AM +0200, Giovanni Gherdovich wrote:
> > > 
> > > It may be possible that MSR_TURBO_RATIO_LIMIT is also all-zeros. In
> > > such case, turbo_freq will be also zero. If that is the case,
> > > arch_max_freq_ratio will be zero and we will see a division by zero
> > > exception in arch_scale_freq_tick() because mcnt is multiplied by
> > > arch_max_freq_ratio().
> > 
> > Thanks Ricardo for clarifying this.
> > 
> > Follow-up question: when I see an all-zeros MSR_TURBO_RATIO_LIMIT, can I
> > assume the CPU doesn't support turbo boost? Or is it possible that such a CPU
> > has turbo boost, just the turbo ratios aren't declared in the MSR?
> > 
> > Some context: this feature (called "frequency invariance") wants to know
> > what's the max clock freq a CPU can have at any time (it needs it for some
> > scheduler calculations). This is hard to know precisely, because turbo can
> > kick in at any time and depends on many factors.  So it settles for an
> > "average maximum frequency", which I decided the 4 cores turbo is a good
> > estimate for. Now, if an all-zeros MSR_TURBO_RATIO_LIMIT means "turbo boost
> > unsupported", this is actually the easy case because then I know exactly what
> > the max freq is (base frequency). If, on the other hand, an all-zeros MSR
> > means "there may or may not be turbo, and you don't know how much" then I must
> > disable frequency invariance.
> 
> I'd say that there can be cases in which the CPU has turbo boost and yet the
> turbo ratios are not declared in MSR_TURBO_RATIO_LIMIT. Hence, frequency
> invariance should be disabled.

Great, thanks for the information Ricardo!

For the tip tree maintainers: Ricardo is identifying an additional corner case
I need to take care of, but this series stands on its own: the commits
correctly do what their changelog says, and fix existing bugs.

I'll send an additional patch that follows Ricardo's recommendations, and it
will apply on top of this series.


Giovanni
