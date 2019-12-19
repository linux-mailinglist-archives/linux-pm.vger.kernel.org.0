Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8E125FCE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 11:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLSKsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 05:48:20 -0500
Received: from foss.arm.com ([217.140.110.172]:36864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfLSKsU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 05:48:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D30B31B;
        Thu, 19 Dec 2019 02:48:19 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4C13F719;
        Thu, 19 Dec 2019 02:48:16 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:48:14 +0000
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
Message-ID: <20191219104813.6fr34qavpaplecoz@e107158-lin>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-2-ggherdovich@suse.cz>
 <000001d5a29b$c944fd70$5bcef850$@net>
 <1574697961.16378.5.camel@suse.cz>
 <000801d5a41e$a7fce2c0$f7f6a840$@net>
 <1574781600.7677.2.camel@suse.cz>
 <001d01d5a4f4$d96b21b0$8c416510$@net>
 <003d01d5a63d$f6ab3950$e401abf0$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003d01d5a63d$f6ab3950$e401abf0$@net>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug

On 11/28/19 14:48, Doug Smythies wrote:
> Summary: There never was an issue here.
> 
> Sorry for the noise of this thread, and the resulting waste of time.
> 
> On 2019.11.26 23:33 Doug Smythies wrote:
> > On 2019.11.26 07:20 Giovanni Gherdovich wrote:
> >> On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
> >>> [...]
> >>> The issue with the schedutil governor not working properly in the 5.4 RC series
> >>> appears to be hardware dependant.
> 
> No it 's not.
> 
> Issues with my Sandy Bridge, i7-2600K, test computer and kernel 5.4
> seem to be because it is running an older Ubuntu server version,
> apparently somewhat dependant on cgroup V1 and their cgmanager package.
> I am unable to remove the package to test further because I do use VMs
> that seem to depend on it.
> 
> In the kernel configuration when CONFIG_UCLAMP_TASK_GROUP=y
> the computer behaves as though the new parameter "cpu.uclamp.min"
> is set to max rather than 0, but I can not prove it.

I just noticed this. This option shouldn't cause any problem, if it does there
might be a bug that we need to fix.

So cpu.uclamp.min reads 0 but you think it's not taking effect, correct?

In the quotes above I see 5.4 RC, if you haven't tried this against the final
5.4 release, do you mind trying to see if you can reproduce? Trying 5.5-rc2
would be helpful too if 5.4 fails.

Thanks

--
Qais Yousef
