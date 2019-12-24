Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437A812A03F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXLIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Dec 2019 06:08:40 -0500
Received: from foss.arm.com ([217.140.110.172]:51084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfLXLIk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Dec 2019 06:08:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14C31FB;
        Tue, 24 Dec 2019 03:08:39 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56E813F534;
        Tue, 24 Dec 2019 03:08:37 -0800 (PST)
Date:   Tue, 24 Dec 2019 11:08:35 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Mel Gorman' <mgorman@techsingularity.net>,
        'Matt Fleming' <matt@codeblueprint.co.uk>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Juri Lelli' <juri.lelli@redhat.com>,
        'Paul Turner' <pjt@google.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Quentin Perret' <qperret@qperret.net>,
        'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@suse.de>, 'Len Brown' <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Message-ID: <20191224110834.rgibtqm6dr6kmu5y@e107158-lin.cambridge.arm.com>
References: <1574781600.7677.2.camel@suse.cz>
 <001d01d5a4f4$d96b21b0$8c416510$@net>
 <003d01d5a63d$f6ab3950$e401abf0$@net>
 <20191219104813.6fr34qavpaplecoz@e107158-lin>
 <000701d5b965$361b6c60$a2524520$@net>
 <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com>
 <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com>
 <000301d5b9ae$cd8f5b30$68ae1190$@net>
 <20191223191014.g7lnxafuadwtcqub@e107158-lin.cambridge.arm.com>
 <000401d5b9f7$cf3782c0$6da68840$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000401d5b9f7$cf3782c0$6da68840$@net>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 17:16, Doug Smythies wrote:
> Yes, it fixes the schedutil governor behaving like the performance governor
> problem on my i7-2600K test system.
> 
> I re-ran the tests several times, and re-booted back to the stock (problem)
> kernel to verify incorrect schedutil governor performance (i.e. I toggled
> back and forth, 2 times for each of 2 kernels, tests 1 and 2, total 8 tests).
> Kernel 5.5-rc2: 4 tests FAILED (as expected).
> Kernel 5.5-rc2 + this patch: 4 tests PASSED.

Great! Thanks for testing it, I'll send a proper patch shortly.

> 
> Accidentally tested:
> Kernel 5.5-rc2 + this patch + command line "cgroup_no_v1=all": 1 test PASS.

I think this cgroup_no_v1 is a happy accident. It has nothing to do with the
fault, but for your case maybe helped observing things in a better way. FWIW,
I reproduced the issue on Juno Arm64 using Debian and Buildroot rootfs.

What is actually required to trigger the bug is to create a cpu controller and
add all system tasks to it to create some noise - which Ubuntu and Debian do by
default at boot time. In Buildroot when I did that manually I could see the
frequency going to max most of the time.

I'll add away to test this scenario.

Thanks for your detailed report.

Happy holidays!

--
Qais Yousef
