Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8620620A702
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405151AbgFYUsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405026AbgFYUsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 16:48:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7DC08C5C1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 13:48:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so5280953edr.9
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tn33QMHZ+qNx5YT7oVBhQ/nQOONeR57qMeYBaxKkSXo=;
        b=Ggd+eURO6bXZrXb/VrO6+GxK6IB0ymlMRAjfKYtjDGfvFU0I0yzRD6yvgotEk3BWPf
         PGehawuwWuxJffh9+td9mlCHcAVUQNWj2ejefuznqGo8V+4g+wTK+ufuWOvYOvF38Sup
         7nzPAtDMJb+KbyRYO0JXywstw/xOGIiXzZDlSixrgKtxcDWVHwPcShzNUeSjCkYWiKUd
         2c9/E+zttHjji2yyoaRZ+fuMLDcTKrFh6AV3QLqK17VFBDK/HfnKPU/diOPh45NxYWre
         62t3JyO6a9VOns7Ewz3MXGMCdE9+p4yl8BRtNzVIF3LHlDZSGqc89OP4BfMlGiedk6HO
         k2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tn33QMHZ+qNx5YT7oVBhQ/nQOONeR57qMeYBaxKkSXo=;
        b=fVpnsbqCVQH7WiOn0o/drJpW0ZTJebNnWWQtGWUYFow8LziF/K0dO2aubEU7lgFeJ2
         bzEOS8c1GgQkIxubl2IkV+7DTnX9yoLINcHV2e8EPhIS/5QPQSeKkLxWrRxbLOj9RtUr
         yn5Qt8F+yY3+ywIIEyiXSlL+V2RWHifLzy2q5F3pbpAlE7grHK3xQVknS8g6LuTyRrDs
         z5Cj5PRmp8JYJ80wyh5YUroeCrYfP83rWjQfgkPgINaHI+PCcdXnx/XyNwcCBMNyQGbw
         mlVkQ7sjQy6KlkOxa3Km+LXi9CiXpUF1nbR8qdqRGs754PsocCss0NW1RzjMq+jVYOet
         5uMw==
X-Gm-Message-State: AOAM530pdbfTth29OFnX/JlC/VzZ2+u9axXPOMOAjkzdf59GzhRREgfH
        i/3tXFgb36WDaaVPXRNNo8NhzS2Wr2vntXV9bYz/CA==
X-Google-Smtp-Source: ABdhPJxMYbJ9UZDD3lxVN3tEGwHQsEYytGrM3sJo+TNPXLGdrEYJ2a4RfAquxSOd7PoDH9I6lJXON22hhfJyFvcjD50=
X-Received: by 2002:a50:e606:: with SMTP id y6mr28081edm.303.1593118080706;
 Thu, 25 Jun 2020 13:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200625064614.101183-1-wvw@google.com> <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
In-Reply-To: <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
From:   Wei Wang <wvw@google.com>
Date:   Thu, 25 Jun 2020 13:47:49 -0700
Message-ID: <CAGXk5yrA=oXZs9KAaELsO7+ex7xCggEwdWSC_KXrUWQnvKEpWQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits change
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 3:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-06-20, 23:46, Wei Wang wrote:
> > To avoid reducing the frequency of a CPU prematurely, we skip reducing
> > the frequency if the CPU had been busy recently.
> >
> > This should not be done when the limits of the policy are changed, for
> > example due to thermal throttling. We should always get the frequency
> > within the new limits as soon as possible.
> >
> > There was a fix in
> > commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when
> > limits change") upstream which introduced another flag. However, the
> > fix didn't address the case when next_freq is the same as previously
> > voted, which is then checked in sugov_update_next_freq. As a result, the
> > frequency would be stuck at low until the high demanding workload quits.
> >
> > test trace:
> >   kworker/u19:0-1872  ( 1872) [002] ....   347.878871: cpu_frequency_limits: min=600000 max=2348000 cpu_id=6
> >          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_should_update_freq: thermal limit on policy6
> >          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_deferred_update: policy6 skipped update
> >          dhry64-11525 (11525) [007] d.h2   347.884040: sugov_deferred_update: policy6 skipped update
>
> I am not sure these are helpful in the logs as the code which
> generated them isn't there in the kernel.
>
Yes, those traceprintk were added to those particular functions to help debug.


> > ...
> >
> > This patch fixes this by skipping the check and forcing an update in
> > this case. The second flag was kept as the limits_change flag could be
> > updated in thermal kworker from another CPU.
>
> I am sorry but I am not fully sure of what the problem is. Can you
> describe that by giving an example with some random frequency, and
> tell the expected and actual behavior ?
>
The problem is sugov thought next_freq already updated (but actually
skipped by the rate limit thing) and all following updates will be
skipped.
Actually this is specifically for Android common kernel 4.19's issue
which has sugov_up_down_rate_limit in sugov_update_next_freq, let's
continue discussion there.

Thanks!
-Wei
> > Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 7fbaee24c824..dc2cd768022e 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                  unsigned int next_freq)
> >  {
> > -     if (sg_policy->next_freq == next_freq)
> > +     if (!sg_policy->need_freq_update && sg_policy->next_freq == next_freq)
>
> AFAIU, if the next freq is same as currently programmed one, there is
> no need to force update it.
>
> >               return false;
> >
> >       sg_policy->next_freq = next_freq;
> >       sg_policy->last_freq_update_time = time;
> > +     sg_policy->need_freq_update = false;
> >
> >       return true;
> >  }
> > @@ -178,7 +179,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >               return sg_policy->next_freq;
> >
> > -     sg_policy->need_freq_update = false;
> >       sg_policy->cached_raw_freq = freq;
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> > --
> > 2.27.0.212.ge8ba1cc988-goog
>
> --
> viresh
