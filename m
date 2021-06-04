Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4039B3B3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFDHVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFDHVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 03:21:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303FC06174A
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 00:19:23 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id u188so4340980vsu.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUGXtmm3YaaYQA8A3NSHgtbe8akKxyp8jdu/y6noB0U=;
        b=tLf7J5afBpLfm20TZzOAxqfviSxldh3sN/UTbxzKhDB7y6aQzVak4rBUkyRPQG33o5
         2CCbgayd3+BjiKKd5vYS9P4mr/8WP7y1mPRuXbMH1MMrEiQ7+2p+YjxydG2JH86SEyYN
         5mhPP6/36sXocZwLqcrDYsisq574ul0/ay5GK5RcojQkKOPruiLidFG6LM3lmyKNsY9E
         V3yrLc6qi1Hpt7XOBIPQ3NFeDQOqp1pj+6cVUCMwIkk4KZz/c2860T1Ck1kgbux7GkDj
         rD52hiI1+4vwuXEkSEyYaw6y9CxMlUlz4qmn+HY11dg+UlPXZyO7WUQQNjr8kxGJN04Q
         jNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUGXtmm3YaaYQA8A3NSHgtbe8akKxyp8jdu/y6noB0U=;
        b=QCay0RwWQe+lT0jicJyExBV/0PcKH4/FAFINOSjHo1lSt/gKTsQLyGBCVFKGfuMPGp
         L8U2UTvbrsDtIqapGJ+Za8aD1sNc7LA3XEeS7bfF9XS6y/hfuJmmGHJgkBIX1VRuVEji
         dnOhrDQHmVttJsM9QMOzVwdcXP+L6n+0hL97xArTxKcKnOd130EtbGTaQAX8eYCiTGw1
         l05CrXh7fQk7gIpHUm+V8ihJ4Fl4HD5OwNpNPwhgSBhDJXw4xmYQaqjBnGvTVu+xxPfP
         taFknI9LCSxAw3f3OooCTYjCS5hDbR8n3O+zYnewh5bIbDi+VLQUcRmoqmmqjN1JB4T5
         SukQ==
X-Gm-Message-State: AOAM530I1hIVa5GnCYzo3YUCLosps3xSMxcuYTVNsPPWrvSo7PIpCBJJ
        KI9XC9MREJCznO3nWG3DmpwEWWFdVH1ij6rarFEQdQ==
X-Google-Smtp-Source: ABdhPJzo9GqS9h3POv3Xet9DMdIVcWmPvwBW6Tvbshz7HOCBv0w+Vh2vMe8mdSvwCusNyTHZIeSQ00a4wBjuDFLF6xM=
X-Received: by 2002:a67:e359:: with SMTP id s25mr1333199vsm.55.1622791162238;
 Fri, 04 Jun 2021 00:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <YLi5N06Qs+gYHgYg@gerhold.net> <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
 <YLkOAyydZMnxkEy+@gerhold.net>
In-Reply-To: <YLkOAyydZMnxkEy+@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 09:18:45 +0200
Message-ID: <CAPDyKFpaKkeyOpP7iW8-WG7DLs6Gd1eD2KO3pDYrVQ3z88zFJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in subsystem/drivers
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 at 19:16, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Jun 03, 2021 at 05:27:30PM +0200, Ulf Hansson wrote:
> > On Thu, 3 Jun 2021 at 13:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > I think this might also go into the direction of my problem with the OPP
> > > core for CPU DVFS [1] since the OPP core currently does not "power-on"
> > > the power domains, it just sets a performance state. I got kind of stuck
> > > with all the complexity of power domains in Linux so I think we never
> > > solved that.
> >
> > Hmm, that issue is in a way related.
> >
> > Although, if I understand correctly, that was rather about at what
> > layer it makes best sense to activate the device (from runtime PM
> > point of view). And this was needed due to the fact that the
> > corresponding genpd provider, requires the PM domain to be power on to
> > allow changing a performance state for it. Did I get that correct?
> >
>
> Yes, mostly. But I guess I keep coming back to the same question:
>
> When/why does it make sense to vote for a "performance state" of
> a power domain that is or might be powered off?
>
> "Powered off" sounds like the absolutely lowest possible performance
> state to me, it's just not on at all. And if suddenly a device comes and
> says "I want performance state X", nothing can change until the power
> domain is also "powered on".
>
> I think my "CPU DVFS" problem only exists because in many other
> situations it's possible to rely on one of the following side effects:
>
>   1. The genpd provider does not care if it's powered on or not.
>      (i.e. it's always-on or implicitly powers on if state > 0).
>   2. There is some other device that votes to keep the power domain on.
>
> And that's how the problem relates to my comment for this patch series ...
>
> >
> > >
> > > Do I understand your patch set correctly that you basically make the
> > > performance state votes conditional to the "power-on" vote of the device
> > > (which is automatically toggled during runtime/system PM)?
> >
> > The series can be considered as a step in that direction, but no, this
> > series doesn't change that behaviour.
> >
> > Users of dev_pm_genpd_set_performance_state() are still free to set a
> > performance state, orthogonally to whether the PM domain is powered on
> > or off.
> >
> > >
> > > If yes, I think that's a good thing. It was always really confusing to me
> > > that a device can make performance state votes if it doesn't actually
> > > want the power domain to be powered on.
> >
> > I share your view, it's a bit confusing.
> >
> > Just adding the condition internally to genpd to prevent the caller of
> > dev_pm_genpd_set_performance() from succeeding to set a new state,
> > unless the genpd is powered on, should be a rather simple thing to
> > add.
> >
> > However, to change this, we first need to double check that all the
> > callers are making sure they have turned on the PM domain (typically
> > via runtime PM).
> >
>
> ... because if performance state votes would be conditional to the
> "power-on" vote of the device, it would no longer be possible
> to rely on the side effects mentioned above. So this would most
> certainly break some code that (incorrectly?) relies on these side
> effects, but would also prevent such code.

Right. I understand your point and I am open to discuss an
implementation. Although, I suggest we continue that separately from
the $subject series.

>
> My (personal) feeling so far is that just dropping performance votes
> during runtime/system suspend just makes the entire situation even more
> confusing.

Well, that's what most subsystems/drivers need to do.

Moreover, we have specific devices that only use one default OPP [1].

>
> > >
> > > What happens if a driver calls dev_pm_genpd_set_performance_state(...)
> > > while the device is suspended? Will that mess up the performance state
> > > when the device resumes?
> >
> > Good question. The idea is:
> >
> > If genpd in genpd_runtime_suspend() are able to drop an existing vote
> > for a performance state, it should restore the vote in
> > genpd_runtime_resume(). This also means, if there is no vote to drop
> > in genpd_runtime_suspend(), genpd should just leave the vote as is in
> > genpd_runtime_resume().
> >
>
> But the next time the device enters runtime suspend that vote would be
> dropped, wouldn't it? That feels kind of strange to me.

What do you mean by "next time"?

My main point is, if the device enters runtime suspend state, why
should we keep the vote for an OPP for the device? I mean, the device
isn't going to be used anyway.

>
> Stephan

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-pm/list/?series=489309
