Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6539F87F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhFHOMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:12:38 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:37554 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhFHOMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:12:37 -0400
Received: by mail-vs1-f45.google.com with SMTP id f21so9205530vsl.4
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp8WuOu/yqqzZGYlja6yQLelD5XFkPHgD8DhKXXS7ro=;
        b=Ngez4LhsjD28ltuqAm67nRZDKVF0T8J9PHugigwnNrmTxUHfMqTDp7mdwQxshrZqs8
         whMzQb8hIZzN+OzjXWH10zkPKDlsTf+I1ONzkoGm5abJtoU9OBojooe6bclXynCUydPU
         +up+5mXXKfUBp7UnAvGp5h5Xfwt7mar+OYTkSQp5wi944GEh5z6dVros9yBcdHtegrOn
         D9pav/S4qjO2w1DHioqQZLoO5SBUGZlDRkqswLf2Mc0aLXowisHzfO315npQq+yIH5eO
         BOILkMHrMJnz9c1W9BgfAcrZiSZWrAyPYjtQ5+Uv9iTT3x39aaBek8aMSmM7Z5yfHm8L
         O+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp8WuOu/yqqzZGYlja6yQLelD5XFkPHgD8DhKXXS7ro=;
        b=U4rpaIWjKd5DRAEC+ti+pX84xhfUwihcuvDOE7B7U8oYJjzM8lhiMDLlnAyB7aF9QK
         Y3Q9OyKP2IQ/XUhJcDWMkb6845QyOQMX2BesRrOGVtg0ohKSpUy9/D0V2DX7nsQTr7FC
         e1tASi66fy74isO7n75+PVUJzgbU0/f5HQyhWhsXPd19FUtX6aCezPY12PCvSBhvu9HK
         0PgSbSzHgxIuOwfbxi3E/rM635zFztmutO9zqdDnPALnWs69+5KbSNndFLRgky5dwWEx
         gPCyadOGXlTbsO9sGTZjaGacu+OSWR/T9pU3KE0Pt2et84i5iFpXE84I9neUVvWymR1r
         9yOA==
X-Gm-Message-State: AOAM532s/mb91LsKnI4j2E7OCAxeBIrtConJRvdQJ8xYMJwbSRy28tys
        fdrdsQ8ItXNvHWW94mVVFWhot9Eg5TDTidulluzASpLLdnFiNw==
X-Google-Smtp-Source: ABdhPJz+8aUtsghoOR4YkaB8PUCKU90IQgYbzEXPK69sfo2EEUdG6HSiOPmbxfCMbM/C+gjLqvF+otkfXEba8huQRaY=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr232062vsg.34.1623161372065;
 Tue, 08 Jun 2021 07:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org> <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
 <YL9oMVqox7GVASen@gerhold.net>
In-Reply-To: <YL9oMVqox7GVASen@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 16:08:55 +0200
Message-ID: <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
To:     Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Jun 2021 at 14:53, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi,
>
> On Thu, Jun 03, 2021 at 12:20:57PM +0200, Ulf Hansson wrote:
> > + Mark Brown, Dmitry Baryshkov
> >
> > On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Recent changes in genpd drops and restore performance state votes for
> > > devices during runtime PM.
> > >
> > > For the similar reasons, but to avoid the same kind of boilerplate code in
> > > device PM callbacks for system sleep in subsystems/drivers, let's drop and
> > > restore performance states votes in genpd for the attached devices during
> > > system sleep.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > After a second thought, it looks like we maybe should defer to apply
> > this final patch of the series. At least until we figured out how to
> > address the below issue:
> >
> > So, I noticed that we have things like "regulator-fixed-domain", that
> > uses "required-opps" to enable/disable a regulator through the
> > dev_pm_set_performance_state() interface.
>
> Not directly related to your concern, but related to another discussion
> we had recently: To me, this looks mostly like another solution for
> voting for performance states without doing full DVFS, also known as
> assigned-performance-states [1] or required-opps on devices [2]. :)
>
> It's just wrapped in a regulator interface here. Actually, if we
> implement [2], the regulator-fixed-domain should mostly just become some
> sort of simple wrapper around runtime PM for the regulator device, since
> the required-opp might be applied automatically then.

Honestly, I am not sure about what the regulator-fixed-domain intends
to model, but I assume it's something that fits well to be modelled as
a plain regulator, to start with.

Perhaps Mark can chime in and spread some light over this?

>
> [1]: https://lore.kernel.org/linux-arm-msm/1622095949-2014-1-git-send-email-rnayak@codeaurora.org/
> [2]: https://lore.kernel.org/linux-arm-msm/YLYV3ov%2FiBffZMg4@gerhold.net/
>
> > We likely don't want to drop the performance state internally in genpd
> > when genpd_suspend_noirq() gets called, for the corresponding struct
> > device for the regulator.
> >
>
> So your concern is that the performance state is dropped during suspend
> even though the regulator core thinks the regulator stays enabled?

Yes.

>
> I played with regulator-fixed-domain a bit and I would say this is
> already broken (unless you rely on one of the side effects I mentioned
> in [3]). The power domain gets powered off entirely during system
> suspend, and then the performance state won't have any effect either.

Right, I get your point.

Although, this isn't a problem, because the on/off and performance
states are today considered as orthogonal in gendp. Well, at least
currently until/if we decide to change this.

>
> I guess we would need some way to say that this device should only be
> managed through runtime PM and never automatically suspended during
> system suspend?

Yes!

For the on/off state, genpd uses the system wakeup interface to
understand whether the device is used in a wakeup path, see the call
to device_wakeup_path() in genpd_finish_suspend().
If that's the case the PM domain stays powered on during system suspend.

Potentially we could use the same interface (or something similar) to
support these kinds of cases.

>
> Stephan
>
> [3]: https://lore.kernel.org/linux-pm/YLkOAyydZMnxkEy+@gerhold.net/

Kind regards
Uffe
