Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B8126EB6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLSUWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:22:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfLSUV7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28E59B2EF;
        Thu, 19 Dec 2019 20:21:57 +0000 (UTC)
Message-ID: <1576787264.8929.10.camel@suse.cz>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Date:   Thu, 19 Dec 2019 21:27:44 +0100
In-Reply-To: <20191218193429.GH11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191113124654.18122-2-ggherdovich@suse.cz>
         <20191202162232.GA9777@arm.com> <4d1b776d8e797224e92952a4d590a625@suse.cz>
         <20191218193429.GH11457@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 20:34 +0100, Peter Zijlstra wrote:
> On Fri, Dec 06, 2019 at 12:57:46PM +0100, Giovanni Gherdovich wrote:
> > > On Wednesday 13 Nov 2019 at 13:46:49 (+0100), Giovanni Gherdovich wrote:
> > > I see above that you enable the static key (and therefore frequency
> > > invariance before setting the max frequency ratio (if possible) and
> > > before you initialise the counter references. Is there any reason for
> > > doing this?
> > This is a fair point; mine was a deliberate choice but you're the second
> > person making this remark (Peter Zijlstra also suggested I find the max
> > frequency before I set the static key), so it appears this design is
> > unpopular
> > enough to warrant a change in v5.
> 
> You actually 'fix' this in the next patch. I thought it was a patch
> management 'fail' that it didn't end up in this patch.

Uhm. I'm not sure I agree; let me paste the function intel_set_cpu_max_freq
after the entire series is applied:

> static void intel_set_cpu_max_freq(void)
> {
>         u64 ratio = 1, turbo_ratio = 1;
> 
>         if (slv_set_cpu_max_freq(&ratio, &turbo_ratio))
>                 goto set_value;
> 
>         if (glm_set_cpu_max_freq(&ratio, &turbo_ratio))
>                 goto set_value;
> 
>         if (knl_set_cpu_max_freq(&ratio, &turbo_ratio))
>                 goto set_value;
> 
>         if (skx_set_cpu_max_freq(&ratio, &turbo_ratio))
>                 goto set_value;
> 
>         core_set_cpu_max_freq(&ratio, &turbo_ratio);
>

let's say that all functions return false; as I don't check the return value of
the last one, you can very well end up here with 'ratio' and 'turbo_ratio'
that are still untouched, =1 since their initialization, and I would go on and
set the static key anyway (because I previously checked X86_FEATURE_APERFMPERF).

Right?

> set_value:
>         arch_max_turbo_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE,
>                                         ratio);
>         set_arch_max_freq(turbo_disabled());
>         static_branch_enable(&arch_scale_freq_key);
> }

But again, not only people disagree with this behavior, it's probably a little
misleading too in how it's written. Changing in v5.

Giovanni
