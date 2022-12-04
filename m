Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60BE641CA4
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 12:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLDLfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 06:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLDLfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 06:35:51 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A801182C
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 03:35:50 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d14so3944440ilq.11
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCqCVlm2gWWxwc47amlLDLZQfBgu2mBenlFlBGkMsAs=;
        b=peS3N8wnkuNUsfo2yCWLAmkMZJYQBcfR6BcAAC7dYHwjsrPOuFdr+Y9c32SSb22aeH
         4KD/hwNVucWb3JgqqFv+5GrqdTwDTs9OEhl/mehCCgqlLxyQl9oOnDpvITU99EkhxaOC
         mTWC/K/AXXOg/21DKwAQaxnYFZYuVReS1rUwcLFlZ++lRul7PYtWEGCCYaO3IwAQe2mr
         6GYVMZm3mjLoaXvsPjP16AkO9a6KD5bIrb5DJHeyAcfcgTiNG7oRditafWmQId01/cv2
         AFAYBUfAVG+tfMV7t8pbgbFhAm8J8XLNMk9kevCNHfQ8YRq/GYwiV13EHKpRnr79UfSI
         dGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCqCVlm2gWWxwc47amlLDLZQfBgu2mBenlFlBGkMsAs=;
        b=l0UVC/xVWnUi4Ki2Wpp+8WmKTXUfzqm/Gyqj2Yh/yuFdlsHwVSQDrej/RnidVjt9NI
         OKMAvgUnqo+tQn/9z8cXvuxz/P4FNDeEBkMYw2RcEjv6TqC07CrPd1elfpgqNx2Y3aDR
         lFfxmIcEzvZGtuvpQUQQKbRtzgngrXbE2Ve6lR6OUu0j+YkeRZk9ay93nWGPrUdPwif8
         GHQqxfB/NljDQPS8trMC6JE8ojUKGzJge949pEjgt8wvBTSKJN5nZcUh0abdh/qXen9L
         aY1rV+IXJYZriO+kvkD8Q+WK9YB0/R6CY4+MekhGGws2hAIs123mK77DSdHgJythv+zH
         ASqg==
X-Gm-Message-State: ANoB5pn735orD9Rnkrxq1V2qjpD0tbBERMV+CgxW9iZWrAhq9chQTUpF
        pluZW8mohqcFrj2PjPT1zsHN73bexakbsBeb6MkaFg==
X-Google-Smtp-Source: AA0mqf6ZLuFHP3u6fxB7to0Z1Lp4auDKOZyLkChhXPrxA9/ylEdCwf2HQtdpoTv3Ibyh68PnLyvD1dIEYFKLEZHSHt8=
X-Received: by 2002:a92:7c0c:0:b0:302:efa3:6230 with SMTP id
 x12-20020a927c0c000000b00302efa36230mr21867381ilc.232.1670153750075; Sun, 04
 Dec 2022 03:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com> <20221203143323.w32boxa6asqvvdnp@airbuntu>
In-Reply-To: <20221203143323.w32boxa6asqvvdnp@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 4 Dec 2022 12:35:39 +0100
Message-ID: <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 3 Dec 2022 at 15:33, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/02/22 15:57, Vincent Guittot wrote:
>
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 7c0dd57e562a..4bbbca85134b 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > >          *   * Thermal pressure will impact all cpus in this perf domain
> > >          *     equally.
> > >          */
> > > -       if (sched_energy_enabled()) {
> > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > >
> > >                 rq->cpu_capacity_inverted = 0;
> > >
> > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > -
> > > -               for (; pd; pd = pd->next) {
> > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > +               for_each_active_policy_safe(policy, policy_n) {
> >
> > So you are looping all cpufreq policy (and before the perf domain) in
> > the period load balance. That' really not something we should or want
> > to do
>
> Why is it not acceptable in the period load balance but acceptable in the hot
> wake up path in feec()? What's the difference?

This patch loops on all cpufreq policy in sched softirq, how can this
be sane ? and not only in eas mode but also in the default asymmetric
performance  one.

This inverted detection doesn't look like the right way to fix your
problem IMO. That being said, i agree that I haven't made any other
proposal apart that I think that you should use a different rules for
task and for overutilized and part of your problem comes from this.

Then this make eas and util_fits_cpu even more Arm specific and I
still hope to merge sched_asym_cpucapacity and asym_packing a some
levels because they looks  more and more similar but each side is
trying to add some SoC specific policy

Vincent

>
>
> Thanks!
>
> --
> Qais Yousef
