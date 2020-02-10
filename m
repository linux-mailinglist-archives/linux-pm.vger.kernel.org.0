Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855E1157B94
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgBJNbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 08:31:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49268 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgBJNbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 08:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zJERE8RQFEvavVoodECE0tC0EkLezz+9Xi+PVOEgn48=; b=tag8GRycoSig7G87Xiy3/Rl1cJ
        J29GI3xoEKlqPONfUNUIpUxL5OHGGIC5AOxHpHLqU2iwWnBT4RGMH+YTI+sAkCxzjjPeV+C5qj0xi
        vSmI9H2lva7YSIjtkCsUxz3Sg+JBEWQyBM+LjqqPuod3oMGXbqgWhZbKM+5DLilC8ho2WJLLI/nrb
        k3dhocsQJic0vn3wWIzHr/gCLhR9G/TmpsTgRAjN7XSThaUx1ZNO9C5oeTi46s+jM7ZAkXyHVoK55
        i5o8i/+yqBA6HXQzW/V0wkJ54WoAJ08wmrAhdE1BsJMS3D9ACsmrAZzem6gJRjYOdOoCdZUUt5Qwb
        f9TqO+ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j199J-0006YY-0H; Mon, 10 Feb 2020 13:30:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C7B7300E0C;
        Mon, 10 Feb 2020 14:29:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D8B120148931; Mon, 10 Feb 2020 14:30:51 +0100 (CET)
Date:   Mon, 10 Feb 2020 14:30:51 +0100
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
Message-ID: <20200210133051.GI14897@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
 <d0155018-52e6-e1c9-a03d-1b9703b7a28a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0155018-52e6-e1c9-a03d-1b9703b7a28a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 23, 2020 at 05:16:52PM +0000, Douglas Raillard wrote:
> Hi Rafael,
> 
> On 1/23/20 3:43 PM, Rafael J. Wysocki wrote:
> > On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
> > <douglas.raillard@arm.com> wrote:
> >>
> >> Make schedutil cpufreq governor energy-aware.
> > 
> > I have to say that your terminology is confusing to me, like what
> > exactly does "energy-aware" mean in the first place?
> 
> Should be better rephrased as "Make schedutil cpufreq governor use the
> energy model" I guess. Schedutil is indeed already energy aware since it
> tries to use the lowest frequency possible for the job to be done (kind of).

So ARM64 will soon get x86-like power management if I read these here
patches right:

  https://lkml.kernel.org/r/20191218182607.21607-2-ionela.voinescu@arm.com

And I'm thinking a part of Rafael's concerns will also apply to those
platforms.

> Other than that, the only energy-related information schedutil uses is
> the assumption that lower freq == better efficiency. Explicit use of the
> EM allows to refine this assumption.

I'm thinking that such platforms guarantee this on their own, if not,
there just isn't anything we can do about it, so that assumption is
fair.

(I've always found it weird to have less efficient OPPs listed anyway)

> >> 1) Selecting the highest possible frequency for a given cost. Some
> >>    platforms can have lower frequencies that are less efficient than
> >>    higher ones, in which case they should be skipped for most purposes.
> >>    They can still be useful to give more freedom to thermal throttling
> >>    mechanisms, but not under normal circumstances.
> >>    note: the EM framework will warn about such OPPs "hertz/watts ratio
> >>    non-monotonically decreasing"
> > 
> > While all of that is fair enough for platforms using the EM, do you
> > realize that the EM is not available on the majority of architectures
> > (including some fairly significant ones) and so adding overhead
> > related to it for all of them is quite less than welcome?
> 
> When CONFIG_ENERGY_MODEL is not defined, em_pd_get_higher_freq() is
> defined to a static inline no-op function, so that feature won't incur
> overhead (patch 1+2+3).
> 
> Patch 4 and 5 do add some new logic that could be used on any platform.
> Current code will use the boost as an energy margin, but it would be
> straightforward to make a util-based version (like iowait boost) on
> non-EM platforms.

Right, so the condition 'util_avg > util_est' makes sense to trigger
some sort of boost off of.

What kind would make sense for these platforms? One possibility would be
to instead of frobbing the energy margin, as you do here, to frob the C
in get_next_freq().

(I have vague memories of this being proposed earlier; it also avoids
that double OPP iteration thing complained about elsewhere in this
thread if I'm not mistaken).


That is; I'm thinking it is important (esp. now that we got frequency
invariance sorted for x86), to have this patch also work for !EM
architectures (as those ARM64-AMU things would be).


