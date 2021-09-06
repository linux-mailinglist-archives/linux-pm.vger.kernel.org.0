Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C114019BA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhIFK0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhIFK0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 06:26:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B0C061757
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 03:25:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t12so12596310lfg.9
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RErsc/TBCJQsZBsQ+eHRBNFWkmkUWRJ6eCzgNVakbjw=;
        b=wRhcXazJEs4c7ocVrHGzuDsNssEXREj47wdUsLi8T1YGSVbfvXTYcp7JawnyggO4lD
         pyin4znQQwTKbPPLEnb6Sv/Ss0GkAQ65lS+PZ2AOPv7QGg8+Pd7RTrGqkNaqz5nDlyRG
         BLNPmLo5Va9DqseUqXx3NwzoV2Lsb2QZzQyaEwIhYVviJcXMJBxlTWWawab22pXbX/BF
         dlY81zfyK4mk4eO4oEbjb2MfU1zjL+FrwDdm7TCb7HoKvTaJI7movVV+mRdGQTONWYEh
         1A2/oZ5/50JzohMIpuglReE2dSdqfBr6uSmwRGaIFbXC9ZWsCQjxLoCKC2IiDjkbw9sH
         iaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RErsc/TBCJQsZBsQ+eHRBNFWkmkUWRJ6eCzgNVakbjw=;
        b=VI3RLcLkxGyo8P2YDRreqTY+AZn55utmgcgHM64xuL7X9rx0uYmvrwC6M3Q8tpMZBB
         SRV5JfR86AOd6yPPx3UvP+ux++5eobF6ktGu1J1cP9ZjvMds0/WqlWryoJ8pMv7Hl4nM
         51LxDUdzm0Mcqu/f2H/H17BLft3QKg/aeq2C1zXlxQfLLZ0Tp0QXXyY7sXWhq0v0lnN+
         GgXdkY3n9N19PAEMVMuQ8BGGydQznduFnqJKVIaBvRw6X3qGoMsWdHRR+7ApIVZILRd4
         /faewyCCu0h5gXIT50L80i6fhyiADbHPKvnZjEypxOTKi1418n5+4f6cXKUxpLheQVPR
         mqBQ==
X-Gm-Message-State: AOAM533hGnSHx542k5aUlFudAcDEPv7OzwrcVq8kAJFcU1VDKLXnjMfE
        FqnTnWqHFwevlTT77TQ5x0uLnX04YxVulbJ2QldYeA==
X-Google-Smtp-Source: ABdhPJxLSP3+lPbKzI6UzV24s/b18K8qiiW7udt0Ujl4x6s4APzNS/1pJwidhMr6nK2dQcIuxsX2zuS6IYcjHkD30Lw=
X-Received: by 2002:a19:dc47:: with SMTP id f7mr8802284lfj.71.1630923928356;
 Mon, 06 Sep 2021 03:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com> <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
In-Reply-To: <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 12:24:51 +0200
Message-ID: <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 5 Sept 2021 at 10:26, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.09.2021 17:03, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 03.09.2021 11:22, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> When a device is detached from its genpd, genpd loses track of the =
device,
> >>>>> including its performance state vote that may have been requested f=
or it.
> >>>>>
> >>>>> Rather than relying on the consumer driver to drop the performance =
state
> >>>>> vote for its device, let's do it internally in genpd when the devic=
e is
> >>>>> getting detached. In this way, we makes sure that the aggregation o=
f the
> >>>>> votes in genpd becomes correct.
> >>>>
> >>>> This is a dangerous behaviour in a case where performance state
> >>>> represents voltage. If hardware is kept active on detachment, say it=
's
> >>>> always-on, then it may be a disaster to drop the voltage for the act=
ive
> >>>> hardware.
> >>>>
> >>>> It's safe to drop performance state only if you assume that there is=
 a
> >>>> firmware behind kernel which has its own layer of performance manage=
ment
> >>>> and it will prevent the disaster by saying 'nope, I'm not doing this=
'.
> >>>>
> >>>> The performance state should be persistent for a device and it shoul=
d be
> >>>> controlled in a conjunction with runtime PM. If platform wants to dr=
op
> >>>> performance state to zero on detachment, then this behaviour should =
be
> >>>> specific to that platform.
> >>>
> >>> I understand your concern, but at this point, genpd can't help to fix=
 this.
> >>>
> >>> Genpd has no information about the device, unless it's attached to it=
.
> >>> For now and for these always on HWs, we simply need to make sure the
> >>> device stays attached, in one way or the other.
> >>
> >> This indeed requires to redesign GENPD to make it more coupled with a
> >> device, but this is not a real problem for any of the current API user=
s
> >> AFAIK. Ideally the state should be persistent to make API more univers=
al.
> >
> > Right. In fact this has been discussed in the past. In principle, the
> > idea was to attach to genpd at device registration, rather than at
> > driver probe.
> >
> > Although, this is not very easy to implement - and it seems like the
> > churns to do, have not been really worth it. At least so far.
> >
> >>
> >> Since for today we assume that device should be suspended at the time =
of
> >> the detachment (if the default OPP state isn't used), it may be better
> >> to add a noisy warning message if pstate!=3D0, keeping the state untou=
ched
> >> if it's not zero.
> >
> > That would just be very silly in my opinion.
> >
> > When the device is detached (suspended or not), it may cause it's PM
> > domain to be powered off - and there is really nothing we can do about
> > that from the genpd point of view.
> >
> > As stated, the only current short term solution is to avoid detaching
> > the device. Anything else, would just be papering of the issue.
>
> What about to re-evaluate the performance state of the domain after
> detachment instead of setting the state to zero?

I am not suggesting to set the performance state of the genpd to zero,
but to drop a potential vote for a performance state for the *device*
that is about to be detached.

Calling genpd_set_performance_state(dev, 0), during detach will have
the same effect as triggering a re-evaluation of the performance state
for the genpd, but after the detach.

> This way PD driver may
> take an action on detachment if performance isn't zero, before hardware
> is crashed, for example it may emit a warning.

Not sure I got that. Exactly when do you want to emit a warning and
for what reason?

Do you want to add a check somewhere to see if
'gpd_data->performance_state' is non zero - and then print a warning?

Kind regards
Uffe
