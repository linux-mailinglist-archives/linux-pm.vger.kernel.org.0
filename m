Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C208F4026F3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbhIGKRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbhIGKRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 06:17:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EBC061575
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 03:16:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c8so18538678lfi.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gte/f8JQJEenUK63bdZ8cYaxSDk49TB3bEE1Ykja/m0=;
        b=HrPuk6HEc9IUJoFeNctPwwtXpLcBFcfrqpn+x/CCTKlUPBlm6C/6ilVmpo2KAuAPqD
         B1xKCFrXd0rkBCKaO6bBUM8ugqBXePmlx/xRGvPCLWqjfk48hVNyS/0BroizNUe1YJk1
         KsFl1rc+VIOb85EZdmUwXDAKJNaVSSI+NdeffdWOYX6Qqj6YxbqahdOegd3iNaqiGIVj
         Z2d2ZQdb8MYT/dbJu3QvGrfiAFE7xL/0A6PuG1hk/eGzE5A98/cAJ+Bs1WNrz4m9rc0t
         SChqG4nY2S9wRCRgypxBZ7HGaifKrcaKAldnIzg+lYSL0I5K4Af//RYLo0tgoMLgs5w8
         sdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gte/f8JQJEenUK63bdZ8cYaxSDk49TB3bEE1Ykja/m0=;
        b=q2py47zX1Gp40xDhtBP4jscCNnxLbMVCmKLDAYDvSVUUNfoMvHfKB7kCIQyK8v/PJh
         DgChiJmF5hL+ZcBTe1af+w2tHBm1unob5Kfb2vngk6Wnuz12x7q0UIHBsPB1ZgOc0eW+
         98Iq97mUEFp2FEWLeHl9r5UqLK7/27f3j4ZIax3oE8ahqnLeoJlJXTMcZJvjBS+YNW30
         xyUMOOaY025u0I2Y4SZuxIMVrV1fKFl5YJ8NDl1oJcOC8k860tBqUqNMJPwQArs/Dajg
         0CuV1BOx48rdMlrWbMqueAoLrDIhgzwNZiN0FSBcuv2s/sECGks/2XPvEfgXfCBkGKP/
         j0ZA==
X-Gm-Message-State: AOAM531TwhUQGG3+L6x50WKCNBMCYWCywNT3ZSfnveyGpCP9SQN+UE3y
        Lb9SYxfBASen6qVokhbWh8W4igA5YmXFpPgs2+H8JQ==
X-Google-Smtp-Source: ABdhPJz3uKrnXQfyfvXyjCZhEC8AqqTxCx0RdRHUYl4A3JNjjK8xbZUD1O65rBNvNiz1u3B2K5lYcpPEymM7vy8hAfE=
X-Received: by 2002:a05:6512:1043:: with SMTP id c3mr11847227lfb.358.1631009797441;
 Tue, 07 Sep 2021 03:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com> <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com> <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
 <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com> <CAPDyKFqqdgr2DHf1Fidj3ksPHe3XgwvCo8SbQ2Cmnc5y1PDvMw@mail.gmail.com>
 <7ee1a2eb-67d7-dcad-6039-05129d3822ec@gmail.com>
In-Reply-To: <7ee1a2eb-67d7-dcad-6039-05129d3822ec@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Sep 2021 12:16:00 +0200
Message-ID: <CAPDyKFoFPpPPd0cUDRhqzXzXaQyNAv7UZToTaHnGXY30QXNB9g@mail.gmail.com>
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

On Mon, 6 Sept 2021 at 21:33, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.09.2021 20:34, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 6 Sept 2021 at 16:11, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 06.09.2021 13:24, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Sun, 5 Sept 2021 at 10:26, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> 03.09.2021 17:03, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wr=
ote:
> >>>>>>
> >>>>>> 03.09.2021 11:22, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> =
wrote:
> >>>>>>>>
> >>>>>>>> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>>>> When a device is detached from its genpd, genpd loses track of =
the device,
> >>>>>>>>> including its performance state vote that may have been request=
ed for it.
> >>>>>>>>>
> >>>>>>>>> Rather than relying on the consumer driver to drop the performa=
nce state
> >>>>>>>>> vote for its device, let's do it internally in genpd when the d=
evice is
> >>>>>>>>> getting detached. In this way, we makes sure that the aggregati=
on of the
> >>>>>>>>> votes in genpd becomes correct.
> >>>>>>>>
> >>>>>>>> This is a dangerous behaviour in a case where performance state
> >>>>>>>> represents voltage. If hardware is kept active on detachment, sa=
y it's
> >>>>>>>> always-on, then it may be a disaster to drop the voltage for the=
 active
> >>>>>>>> hardware.
> >>>>>>>>
> >>>>>>>> It's safe to drop performance state only if you assume that ther=
e is a
> >>>>>>>> firmware behind kernel which has its own layer of performance ma=
nagement
> >>>>>>>> and it will prevent the disaster by saying 'nope, I'm not doing =
this'.
> >>>>>>>>
> >>>>>>>> The performance state should be persistent for a device and it s=
hould be
> >>>>>>>> controlled in a conjunction with runtime PM. If platform wants t=
o drop
> >>>>>>>> performance state to zero on detachment, then this behaviour sho=
uld be
> >>>>>>>> specific to that platform.
> >>>>>>>
> >>>>>>> I understand your concern, but at this point, genpd can't help to=
 fix this.
> >>>>>>>
> >>>>>>> Genpd has no information about the device, unless it's attached t=
o it.
> >>>>>>> For now and for these always on HWs, we simply need to make sure =
the
> >>>>>>> device stays attached, in one way or the other.
> >>>>>>
> >>>>>> This indeed requires to redesign GENPD to make it more coupled wit=
h a
> >>>>>> device, but this is not a real problem for any of the current API =
users
> >>>>>> AFAIK. Ideally the state should be persistent to make API more uni=
versal.
> >>>>>
> >>>>> Right. In fact this has been discussed in the past. In principle, t=
he
> >>>>> idea was to attach to genpd at device registration, rather than at
> >>>>> driver probe.
> >>>>>
> >>>>> Although, this is not very easy to implement - and it seems like th=
e
> >>>>> churns to do, have not been really worth it. At least so far.
> >>>>>
> >>>>>>
> >>>>>> Since for today we assume that device should be suspended at the t=
ime of
> >>>>>> the detachment (if the default OPP state isn't used), it may be be=
tter
> >>>>>> to add a noisy warning message if pstate!=3D0, keeping the state u=
ntouched
> >>>>>> if it's not zero.
> >>>>>
> >>>>> That would just be very silly in my opinion.
> >>>>>
> >>>>> When the device is detached (suspended or not), it may cause it's P=
M
> >>>>> domain to be powered off - and there is really nothing we can do ab=
out
> >>>>> that from the genpd point of view.
> >>>>>
> >>>>> As stated, the only current short term solution is to avoid detachi=
ng
> >>>>> the device. Anything else, would just be papering of the issue.
> >>>>
> >>>> What about to re-evaluate the performance state of the domain after
> >>>> detachment instead of setting the state to zero?
> >>>
> >>> I am not suggesting to set the performance state of the genpd to zero=
,
> >>> but to drop a potential vote for a performance state for the *device*
> >>> that is about to be detached.
> >>
> >> By removing the vote of the *device*, you will drop the performance
> >> state of the genpd. If device is active and it's wrong to drop its
> >> state, then you may cause the damage.
> >>
> >>> Calling genpd_set_performance_state(dev, 0), during detach will have
> >>> the same effect as triggering a re-evaluation of the performance stat=
e
> >>> for the genpd, but after the detach.
> >>
> >> Yes
> >>
> >>>> This way PD driver may
> >>>> take an action on detachment if performance isn't zero, before hardw=
are
> >>>> is crashed, for example it may emit a warning.
> >>>
> >>> Not sure I got that. Exactly when do you want to emit a warning and
> >>> for what reason?
> >>>
> >>> Do you want to add a check somewhere to see if
> >>> 'gpd_data->performance_state' is non zero - and then print a warning?
> >>
> >> I want to check the 'gpd_data->performance_state' from the detachment
> >> callback and emit the warning + lock further performance changes in th=
e
> >> PD driver since it's a error condition.
> >
> > Alright, so if I understand correctly, you intend to do the check for
> > the "error condition" of the device in the genpd->detach_dev()
> > callback?
>
> Yes

Okay.

>
> > What exactly do you intend to do beyond this point, if you detect the
> > "error condition"? Locking further changes of the performance state
> > seems fragile too, especially if some other device/driver requires the
> > performance state to be raised. It sounds like you simply need to call
> > BUG_ON() then?
>
> I can lock it to high performance state.

Alright.

>
> > Also note that a very similar problem exists, *before* the device gets
> > attached in the first place. More precisely, nothing prevents the
> > performance state from being set to a non-compatible value for an
> > always-on HW/device that hasn't been attached yet. So maybe you need
> > to set the maximum performance state at genpd initializations, then
> > use the ->sync_state() callback to very that all consumers have been
> > attached to the genpd provider, before allowing the state to be
> > changed/lowered?
>
> That is already done by the PD driver.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/soc/tegra/pmc.c#L3=
790

Yes, I already knew that, but forgot it. :-) Thanks for the pointer.
Let me rethink the approach.

In a way, it kind of sounds like this is a generic problem - so
perhaps we should think of adding a ->withdraw_sync_state() callback
that can be assigned by provider drivers, to get informed when a
consumer driver is getting unbinded.

Kind regards
Uffe
