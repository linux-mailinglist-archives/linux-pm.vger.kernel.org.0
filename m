Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434F0129A4A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWTKU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 14:10:20 -0500
Received: from foss.arm.com ([217.140.110.172]:47954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLWTKU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 14:10:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4498F328;
        Mon, 23 Dec 2019 11:10:19 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE89F3F68F;
        Mon, 23 Dec 2019 11:10:16 -0800 (PST)
Date:   Mon, 23 Dec 2019 19:10:14 +0000
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
Message-ID: <20191223191014.g7lnxafuadwtcqub@e107158-lin.cambridge.arm.com>
References: <1574697961.16378.5.camel@suse.cz>
 <000801d5a41e$a7fce2c0$f7f6a840$@net>
 <1574781600.7677.2.camel@suse.cz>
 <001d01d5a4f4$d96b21b0$8c416510$@net>
 <003d01d5a63d$f6ab3950$e401abf0$@net>
 <20191219104813.6fr34qavpaplecoz@e107158-lin>
 <000701d5b965$361b6c60$a2524520$@net>
 <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com>
 <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com>
 <000301d5b9ae$cd8f5b30$68ae1190$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000301d5b9ae$cd8f5b30$68ae1190$@net>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 08:34, Doug Smythies wrote:
> On 2019.12.23 06:41 Qais Yousef wrote:
> > On 12/23/19 14:07, Qais Yousef wrote:
> >>> Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
> >>> set the schedutil governor.
> >>> launch test 2 and related monitoring tools.
> >>> verify performance governor like behavior.
> >> 
> >> So as stated above, by default uclamp_{min, max} = (0, 1024). So it wouldn't
> >> act as performance governor by default unless you explicitly write 1024 to
> >> uclamp.min.
> >> 
> >> Let me go find Ubuntu mainline tree to see if they applied anything extra in
> >> there. If they modified the default behavior that could explain what you see.
> >
> > Actually I see what you were saying now that you copy the config. So I think
> >  I misunderstood and you are running Linus' 5.5-rc2 + Ubuntu PPA config.
> 
> Yes, exactly.
> I have a clone of the main Linus git branch, but steal the kernel
> configuration from the Ubuntu mainline PPA.

I think I managed to reproduce it. The below seems to fix it for me, can you
try it out please?

I think what's going on is that the child group default util_min value isn't
propagated correctly after it's created, so we end up using the root_task_group
values which is 1024 for both min and max.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..cf9d9106d1b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7100,6 +7100,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)

        if (parent)
                sched_online_group(tg, parent);
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+       cpu_util_update_eff(css);
+#endif
+
        return 0;
 }

