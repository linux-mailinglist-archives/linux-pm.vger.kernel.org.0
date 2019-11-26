Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA910A102
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfKZPOU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 10:14:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:58184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728078AbfKZPOU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 10:14:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E196B9ED;
        Tue, 26 Nov 2019 15:14:18 +0000 (UTC)
Message-ID: <1574781600.7677.2.camel@suse.cz>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Doug Smythies <dsmythies@telus.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Borislav Petkov' <bp@suse.de>, 'Len Brown' <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'Mel Gorman' <mgorman@techsingularity.net>,
        'Matt Fleming' <matt@codeblueprint.co.uk>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Juri Lelli' <juri.lelli@redhat.com>,
        'Paul Turner' <pjt@google.com>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Quentin Perret' <qperret@qperret.net>,
        'Dietmar Eggemann' <dietmar.eggemann@arm.com>
Date:   Tue, 26 Nov 2019 16:20:00 +0100
In-Reply-To: <000801d5a41e$a7fce2c0$f7f6a840$@net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
                 <20191113124654.18122-2-ggherdovich@suse.cz>
                 <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz>
         <000801d5a41e$a7fce2c0$f7f6a840$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
> [...]
> The issue with the schedutil governor not working properly in the 5.4 RC series
> appears to be hardware dependant.
> 
> My test computer is Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz., Sandy Bridge.
> On a temporary basis, I acquired a computer with an
> Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz, Haswell,
> and schedutil governor behaviour with the exact same kernels is fine:
> 
> That "gitsource" test, "make test" 6 times, first run thrown out:
> 
> Kernel 5.4 intel_cpufreq/schedutil: 3411.8 seconds
> Kernel 5.4 + gg 6 intel_cpufreq/schedutil: 1696.7 seconds
> Ratio: 0.49
> Recall you got a ratio of 0.49 with 5th generation, Broadwell.

It's good to hear that we're getting the same performance numbers for this
patchset on all hardware that is not a Sandy Bridge. Thanks for double
checking, independent verification is always valuable.

Now, regarding the 5.4 regression for schedutil you see on Sandy Bridge: can
we move this to the kernel bugzilla? Would you care to open a bug there and CC
me to it? If it's reproducible we should assess it and see what can be done.

I've tried gitsource on 5.3 versus 5.4, using intel_cpufreq + schedutil; I
don't see the drop you're observing, but I don't have a Sandy Bridge readily
available. This is what I see:

Arithmetic mean of elapsed time for gitsource over 5 iterations (seconds):

    microarch         v5.3 (baseline)                             v5.4
    ------------------------------------------------------------------
    Haswell         1337.84  +- 0.11%     1336.35  +- 0.12% (   0.11%)
    Broadwell       1335.42  +- 0.08%     1352.54  +- 0.03% (  -1.28%)
    Skylake          887.03  +- 1.02%      870.90  +- 1.19% (   1.82%)

I'm looking around for a Sandy Bridge but I can make no promises at the
moment.


Thanks,
Giovanni
