Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE529FE142
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKOPa5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 10:30:57 -0500
Received: from cmta16.telus.net ([209.171.16.89]:40473 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfKOPa4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 10:30:56 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id VdYfit82MFXoiVdYgiVUb5; Fri, 15 Nov 2019 08:30:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573831854; bh=yMfigeQBBOt/OlOFPFk+3W/D65H7EvP4UA3rosQWmIU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wfac57YiF7xX0aRDFhpiq2jQiMFLwNxMs0W07nH49IDSESIAN/8MSZYt3E1x7koTr
         Whuw3FZgTy6TE9Tv2aQXobQzF6EYjXyTtdafkSbrY6Ks7DfvyJtfzrYJIWlGDo1c2o
         QtSB954/ZeuIGfeqRz59R1fn82HTZYEAdk9YC6JxqmxtVzgIqG/GPYNoKirIUMLZ5Y
         S5bxf6nrzayoyQQe/2nv3Tdo/1HPJ8P20rFqMCJ8wuGtOlV/6Tw1G0pNMZDBVEtajE
         1j4P0LyE+XsCK5ZnYlwIgvluZoT9fvwy3JvNsTMecTr2UyNaIlvDRbAlgbdcA20UBP
         Z5+HMtLj20wVw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=XbKOgolVw54_PmlDEtoA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Peter Zijlstra'" <peterz@infradead.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Sargun Dhillon'" <sargun@sargun.me>,
        "'Tejun Heo'" <tj@kernel.org>, "'Xie XiuQi'" <xiexiuqi@huawei.com>,
        <xiezhipeng1@huawei.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com> <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com> <20191115105110.GG4131@hirez.programming.kicks-ass.net> <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com> <20191115130144.GA4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115130144.GA4097@hirez.programming.kicks-ass.net>
Subject: RE: [PATCH v4] sched/freq: move call to cpufreq_update_util
Date:   Fri, 15 Nov 2019 07:30:47 -0800
Message-ID: <000001d59bc9$aab4e010$001ea030$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWbtO4ylk/1Cq0UT7GdBw8Mb2nOvgADxNjA
X-CMAE-Envelope: MS4wfHHFw51kjAZZ0qdbGvJn7HzWIB4x3VEf3XTQKgWc4M/sDOsEmPYxF6VpbwmuHyROFdkggo5LWZiX9Jmv1VGR1f1BqKRv5Fkk/jATlDEyYHtrTfX4Mh7x
 4ph6c4uhrsvltmOk0m+pGBnDz0Oa+i4pk8IFM8/UMWb420NveSPauJCWgGT60b2VqV/7HVjygj1GZY/shKU6vV55xcYRBYoldeNxBr+I0TzdVK4Fnmzdhu52
 uluAHLN6KA86IbSLZkb7Ccejm74bH2V45J1HMjS8HB+/x5DF/fQ6o651qk5rf/olEOcGrMc+YHnil4PNsLGJkTjYVJS3k+Nt73+ywI/tgXqo+Wg7/NB2YtIt
 guEqL03+zfdBLedYHoGrsVy8qonhYG3m8i/FMNHXDtAi4OG1DsBaFPzVJ3K2jetF+77b4tnbXa2ThnMD2/rueSBthhUWHoUDSksdIl5e5CiNW0aZLaVNFw13
 5dlaPSABLUYwuR246zvaciE4ed2mpUpzxUeCAJoH61YLrp5tkDMUy7r6U7ljyAbz6g6xvDjV49aoucfuH2K5tBJKRTugyHy4Jg7ujsuISdiSNVNy+y24vKcu
 qhWPf+3vPSHPRue7PG/I218F/N/q5TA5+0QGru+fVif/Nig0pdOd0bMrVtxjgIfXA1h1F8pwlg/5PrZ8U+jZ+Kae
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 2019.11.15 05:02 Peter Zijlstra wrote:
> On Fri, Nov 15, 2019 at 12:03:31PM +0100, Vincent Guittot wrote:
>
>> This patch does 2 things:
>> - fix the spurious call to cpufreq just before attaching a task
>
> Right, so that one doesn't concern me too much.
>
>> - make sure cpufreq is still called when cfs is 0 but not irq/rt or dl
>
> But per the rq->has_blocked_load logic we would mostly stop sending
> events once we reach all 0s.
>
> Now, most of those updates will be through _nohz_idle_balance() ->
> update_nohz_stats(), which are remote, which means intel_pstate is
> ignoring them anyway.
>
> Now the _nohz_idle_balance() -> update_blocked_averages() thing runs
> local, and that will update the one random idle CPU we picked to run
> nohz balance, but all others will be left where they were.
>
> So why does intel_pstate care... Esp. on SKL+ with per-core P state this
> is of dubious value.
>
> Also, and maybe I should go read back, why do we care what the P state
> is when we're mostly in C states anyway? These are all idle CPUs,
> otherwise we wouldkn't be running update_blocked_averages() on them
> anyway.
>
> Much confusion..

Background:

It is true that this is very likely a rare use case.
Apparently, I can make my test system considerably more "idle"
than most.

For many years now, I have never seen the time between calls,
per CPU, to the intel_pstate driver exceed 4 seconds.

Then as of:
sched/fair: Fix O(nr_cgroups) in load balance path
and for an idle system, the time between calls could
be as much as a few hundred seconds. Myself, and not
knowing much (anything) about scheduler details, I found
this odd, and so investigated.

And yes, so who cares if we are in deep C states anyhow?
If, for whatever reason, the system is running with
"intel_idle.max_cstate=1" my findings were that
the processor could end up consuming a lot more energy
for a long long time. Why? Because, at least for my
processor, and older i7-2600K (no HWP), in idle state 1, the
CPU does not relinquish its vote to the PLL, and with
no calls to the driver the requested p-state doesn't decay.

Not previously mentioned: The situation is considerably
exasperated by this piece of boost code within the intel_pstate
driver:

        /*
         * If the average P-state during the previous cycle was higher than the
         * current target, add 50% of the difference to the target to reduce
         * possible performance oscillations and offset possible performance
         * loss related to moving the workload from one CPU to another within
         * a package/module.
         */
        avg_pstate = get_avg_pstate(cpu);
        if (avg_pstate > target)
                target += (avg_pstate - target) >> 1;

Hope this helps.

... Doug
 

