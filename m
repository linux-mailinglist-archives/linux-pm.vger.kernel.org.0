Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F899109172
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfKYQAW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 11:00:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728454AbfKYQAW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Nov 2019 11:00:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED843BF17;
        Mon, 25 Nov 2019 16:00:19 +0000 (UTC)
Message-ID: <1574697961.16378.5.camel@suse.cz>
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
Date:   Mon, 25 Nov 2019 17:06:01 +0100
In-Reply-To: <000001d5a29b$c944fd70$5bcef850$@net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191113124654.18122-2-ggherdovich@suse.cz>
         <000001d5a29b$c944fd70$5bcef850$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2019-11-23 at 23:49 -0800, Doug Smythies wrote:
> ...
> Kernel 5.4-rc8 + revert, intel_cpufreq/schedutil: 3899 seconds
> Kernel 5.4-rc8 + gg 6 + revert, intel_cpufreq/schedutil: 2740.7 seconds
> Ratio: 0.70 (as expected)
> Kernel 5.4-rc8, intel_cpufreq/schedutil: 2334.7 seconds (faster than expected)
> Kernel 5.4-rc8 + gg 6 patch set, intel_cpufreq/schedutil: 2275.0 seconds (faster than expected)
> Ratio: 0.97 (not as expected)
> Kernel 5.4-rc8, intel_cpufreq/performance: 2215.3 seconds
> Kernel 5.4-rc8, intel_cpufreq/ondemand: 3286.3 seconds
> Re-stated from previous e-mail:
> Kernel 5.3-rc8, intel_cpufreq/schedutil: ratio: 0.69 (I don't have the original times)

Hello Doug,

schedutil in 5.4 going a lot faster than in 5.3 would be a surprise. I'm
running that same test too to check if I can see it as well.

Besides, as it's already been said this patchset adds frequency
scale-invariance to scheduler metrics such as load and utilization and that's
useful also in areas other than frequency scaling (most notably the scheduler
load balancer).


Thanks,
Giovanni
