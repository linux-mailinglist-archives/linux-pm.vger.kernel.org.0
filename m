Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835D5126ECE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSUXb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:23:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfLSUXb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 15:23:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74D57B2EF;
        Thu, 19 Dec 2019 20:23:29 +0000 (UTC)
Message-ID: <1576787357.8929.12.camel@suse.cz>
Subject: Re: [PATCH v4 2/6] x86,sched: Add support for frequency invariance
 on SKYLAKE_X
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Date:   Thu, 19 Dec 2019 21:29:17 +0100
In-Reply-To: <20191218200624.GI11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191113124654.18122-3-ggherdovich@suse.cz>
         <20191218200624.GI11457@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 21:06 +0100, Peter Zijlstra wrote:
> On Wed, Nov 13, 2019 at 01:46:50PM +0100, Giovanni Gherdovich wrote:
> > The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
> > accounting. On SKYLAKE_X CPUs set freq_max to the highest frequency that can
> > be sustained by a group of at least 4 cores.
> > 
> > From the changelog of commit 31e07522be56 ("tools/power turbostat: fix
> > decoding for GLM, DNV, SKX turbo-ratio limits"):
> > 
> > >   Newer processors do not hard-code the the number of cpus in each bin
> > >   to {1, 2, 3, 4, 5, 6, 7, 8}  Rather, they can specify any number
> > >   of CPUS in each of the 8 bins:
> > > 
> > >   eg.
> > > 
> > >   ...
> > >   37 * 100.0 = 3600.0 MHz max turbo 4 active cores
> > >   38 * 100.0 = 3700.0 MHz max turbo 3 active cores
> > >   39 * 100.0 = 3800.0 MHz max turbo 2 active cores
> > >   39 * 100.0 = 3900.0 MHz max turbo 1 active cores
> > > 
> > >   could now look something like this:
> > > 
> > >   ...
> > >   37 * 100.0 = 3600.0 MHz max turbo 16 active cores
> > >   38 * 100.0 = 3700.0 MHz max turbo 8 active cores
> > >   39 * 100.0 = 3800.0 MHz max turbo 4 active cores
> > >   39 * 100.0 = 3900.0 MHz max turbo 2 active cores
> > 
> > This encoding of turbo levels applies to both SKYLAKE_X and GOLDMONT/GOLDMONT_D,
> > but we treat these two classes in separate commits because their freq_max
> > values need to be different. For SKX we prefer a lower freq_max in the ratio
> > freq_curr/freq_max, allowing load and utilization to overshoot and the
> > schedutil governor to be more performance-oriented. Models from the Atom
> > series (such as GOLDMONT*) are handled in a forthcoming commit as they have to
> > favor power-efficiency over performance.
> 
> Can we at least use a single function to decode both? A little like the
> below. I'm not married to the naming, but I think it is a little silly
> to have 2 different functions to decode the exact same MSRs.
> 
> (one could even go as far as to make a boot param to override the {1,4}
> default core count for these things)

Sure, that was actually a gross oversight on my part for not seeing that.
Thanks for catching it and sketching a solution.

Giovanni
