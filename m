Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A435012979D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWOkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:40:49 -0500
Received: from foss.arm.com ([217.140.110.172]:46622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfLWOkt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 09:40:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2EDA1FB;
        Mon, 23 Dec 2019 06:40:48 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2493F534;
        Mon, 23 Dec 2019 06:40:46 -0800 (PST)
Date:   Mon, 23 Dec 2019 14:40:44 +0000
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
Message-ID: <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com>
References: <20191113124654.18122-2-ggherdovich@suse.cz>
 <000001d5a29b$c944fd70$5bcef850$@net>
 <1574697961.16378.5.camel@suse.cz>
 <000801d5a41e$a7fce2c0$f7f6a840$@net>
 <1574781600.7677.2.camel@suse.cz>
 <001d01d5a4f4$d96b21b0$8c416510$@net>
 <003d01d5a63d$f6ab3950$e401abf0$@net>
 <20191219104813.6fr34qavpaplecoz@e107158-lin>
 <000701d5b965$361b6c60$a2524520$@net>
 <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 14:07, Qais Yousef wrote:
> > Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
> > set the schedutil governor.
> > launch test 2 and related monitoring tools.
> > verify performance governor like behavior.
> 
> So as stated above, by default uclamp_{min, max} = (0, 1024). So it wouldn't
> act as performance governor by default unless you explicitly write 1024 to
> uclamp.min.
> 
> Let me go find Ubuntu mainline tree to see if they applied anything extra in
> there. If they modified the default behavior that could explain what you see.

Actually I see what you were saying now that you copy the config. So I think
I misunderstood and you are running Linus' 5.5-rc2 + Ubuntu PPA config.

I'm trying to to reproduce the issue at my end.

Cheers

--
Qais Yousef
