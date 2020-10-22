Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE6295D5F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897281AbgJVLaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:30:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46170 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897279AbgJVLaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:30:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id l4so1317449oii.13;
        Thu, 22 Oct 2020 04:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSTQnfiSle/G+ffgc8i4ByrbO0fkKL6UxU71VpX5YJ8=;
        b=ds+qGKtgrCbAWUTqNkl2Gxc8OsausYHphOjmhzpDY8Q9MMWhqa69+KM6Pu4pUJVx4q
         GirBOoKqM/nQ6jLLnPAnfrkcD+9H5Df+4AWkAp7xTdykiXEk9vQO2RZazNW4RoFaGCMT
         2RRLqjL7cyAVjns7RAZervrdAaDhPgfktqDS/pPR3vsGZva1zYwp81uvKZ9PnPnV0ZBx
         GtXTsgzh1rxjNNZh9TMIi5LsGEoc+LZLZ1P9YAYE1HFTf4DZsqMVkqNx5e4p4hFH8VsU
         AFunl/qDS8Tq14tIm1NNqZD4mmS8W2fercJYOAwJ+Tzt+54+ubOvWA+fmWjKYoH9Lano
         v7Zg==
X-Gm-Message-State: AOAM533i0erLywOzULRFhlI6zpArRbc7IFCBVyZyfDmTp8XLFpkQ5sBi
        CqgqFwlHu/3LXutorjEcdYawWDurog7vlYargfY=
X-Google-Smtp-Source: ABdhPJxRmGkFBRfkGyPi/jnbKKfFCsIXYN1lA9uQTdfPAdka3Duz9P7XiYzkQubpycT4mdAZWsjvWfmKydeMXgb56YM=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr1227163oii.69.1603366212247;
 Thu, 22 Oct 2020 04:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net> <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
 <20201022090523.GV2628@hirez.programming.kicks-ass.net> <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
In-Reply-To: <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 13:30:01 +0200
Message-ID: <CAJZ5v0jZC=UwW9L+KB3pugsTL9P1tZmvQ-sVMV-udn7+L_gEeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 1:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-10-20, 11:05, Peter Zijlstra wrote:
> > On Thu, Oct 22, 2020 at 02:02:55PM +0530, Viresh Kumar wrote:
> > > One of the issues I see with this is that schedutil may not be
> > > available in all configurations and it is still absolutely fine to
> > > using the suggested helper to get the energy numbers in such cases, so
> > > we shouldn't really make it scheutil dependent.
> >
> > The only constraint on schedutil is SMP I think; aside from that it
> > should/could always be available.
> >
> > Given the trainwreck here:
> >
> >   20201022071145.GM2628@hirez.programming.kicks-ass.net
> >
> > (you're on Cc), I'm starting to lean more and more towards making it
> > unconditionally available (when SMP).
> >
> > Anybody forcing it off either sets performance (in which case we don't
> > care about energy usage anyway)
>
> I agree.

That's not really the case, though.

Many people use intel_pstate in the active mode with HWP enabled too.

Arguably, that doesn't need to compute the effective utilization, so I
guess it is not relevant for the discussion here, but it is not
negligible in general.

> > or they select one of the old (broken)
> > ondemand/conservative things and I don't give a crap.
>
> The other kernel layers, for example cpufreq-cooling in question here,
> don't really need to bother with the governor in use and should be
> able to get the energy numbers anyway. So for me, the energy number
> that the cpufreq-cooling stuff gets should be same irrespective of the
> governor in use, schedutil or ondemand.
>
> Having said that, schedutil really doesn't need to install the
> fallback (which you suggested earlier), rather the scheduler core can
> do that directly with cpufreq core and schedutil can also use the same
> fallback mechanism maybe ? And so we can avoid the exporting of stuff
> that way.

I like this better than the fallback idea TBH.
