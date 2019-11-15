Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED6FDEF5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKONbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 08:31:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39339 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfKONbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 08:31:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so10724457ljc.6
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owEif5DDsGmkWrR2bOQw0Tu37BwJ/6VDJnctQZE/unk=;
        b=kVXlSMbmuvfa6FG0LateKEQ8kOMXjev2umGtggRjItX/o8etXqQMax/aVi5gUlo+SJ
         LWvE7FPtiv+s24wL/wTvYFq4Jjf1yf9P22MRdFv/PlPYtgsy2Jz76FaVtQmML/ROLYXR
         p40inBGxQBWyA+RIs5EEHEn6N8Ti2GI693f3tsZWC+o5UkQKJbMqqKYRkCP5U0r/RrW4
         Cm12rI/2NR/iZvXtDdvj/fGarTHEeYUl1emjCsCNh+yRG7y9TEebqqBtcnqJPSDa1s+F
         Rus3CalX7cR+p34jr7CNWa1X+v6iM7kU4LLM/K+oQR4wM3bghgJAwED4+avyRZE33c5j
         g5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owEif5DDsGmkWrR2bOQw0Tu37BwJ/6VDJnctQZE/unk=;
        b=hcNJ3Qmt7iSeK+d7tvmb33gP2ue++3s0S30YN+0ym1jmdXbV8APp3y+YQdkWTyGByp
         g23ScrLOwJJe+FtxTjh7GQpUUT1lhAclqqXaWTtJ6atrXlix5IEhpC1fncJQR6OMgO90
         tDYfARW2wn3oZQQ8ZAK450vs0Go6fr1gv1rUwHSU1YPfwt6I2zAxByXDc76zlChUITZr
         nImrqI4BhPBZZ7Nf0joJqoOnlYJ5BI9lgYOnS91r6asRE/wXnhdo2C4yzH9cohk4NtZc
         jiVuMukO4isIyCtwUQ7mbjTytclPdHzxB6tFMUEFdI27XoeeIm2JvZ0tRmobLC1EWC8o
         48Yw==
X-Gm-Message-State: APjAAAX8+Jij6lU1fmUhSkhGXTeiLBy5m6pLj18vqfsLAsaIcfapa5R3
        buL/UGBAUmQqMbpQP0b10Wy9UEwTDddBsGL6qWVo3w==
X-Google-Smtp-Source: APXvYqwtqVZeOXU64f92wrWYkjlLPEKeNLzTiyg+ktWVv5LriIzng8KsjJMvxs4khm75rv2g02zmafkT3/7U0RidtbI=
X-Received: by 2002:a2e:9748:: with SMTP id f8mr9922879ljj.87.1573824670486;
 Fri, 15 Nov 2019 05:31:10 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net> <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
 <20191115130144.GA4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115130144.GA4097@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 14:30:58 +0100
Message-ID: <CAKfTPtBrxqkoFeWkxX1J1QmhBpRfDh6nYs1wRA-WR8y15AmaYQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 12:03:31PM +0100, Vincent Guittot wrote:
>
> > This patch does 2 things:
> > - fix the spurious call to cpufreq just before attaching a task
>
> Right, so that one doesn't concern me too much.
>
> > - make sure cpufreq is still called when cfs is 0 but not irq/rt or dl
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

Doug mentioned some periodic timers that were running on the CPUs

>
> Also, and maybe I should go read back, why do we care what the P state
> is when we're mostly in C states anyway? These are all idle CPUs,
> otherwise we wouldkn't be running update_blocked_averages() on them
> anyway.

AFAIU, there is not 100% idle but they have periodic timers that will
fire and run at higher P state


>
>
> Much confusion..
