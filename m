Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7611565C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFRYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 12:24:36 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42400 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFRYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 12:24:35 -0500
Received: by mail-vk1-f195.google.com with SMTP id u123so2493991vkb.9
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szPaD/KuEfS4Yi/OsnTIq0RLmNuR3/zYG9307ITUQeg=;
        b=ddh1wJjlLEjQM1WR9kzJ8K+/crojHDHqI6LzfTwtSXaaB0WqnpjfjeL+rTTIJ1vTh0
         0Jae6HDI7C24ZaHkb/tV1C7kaD9DZHxls6a/j6WXYQeC+t+zjE1tfOp0wwSFghgBSodc
         xyFbeFRrDIyxqE+HNYYt5QHsnLyvsnay9uB4gJRUIv1QYL8Y+7xcOo+nIzibCax8Ds3q
         7uch5mBUWbqVAdw57POuKhket4lEhvr8EwETVaufPJXDErI+g0NnSL955qD4/SHt10gF
         Xe4Yt8pr3zdi7tiHoe9xerplJU9Ww0RoerlV8AqY1naYG9TAt+9JH9jFBGSE1NZpkmFL
         XjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szPaD/KuEfS4Yi/OsnTIq0RLmNuR3/zYG9307ITUQeg=;
        b=Nne52YXreZ5IG1WLNzbEzDddlRfAvb1/lIcBOPMi+83CLf17AyMVH/RN/1ArKFtAa7
         1CU88RJa7aVCaVchOdtmu6EwKdEDkeJIxAGbSmRjHt0fzxusIX1Ba3BXPbN6VXXO0xTp
         GehFe8lm2EQiLeDBdv+RzkUcimuA3CCNkjFrQWImmv9ipnFSvmYRWGAlpxhgiHlFqTU8
         w5mdeZYgARxT+cXKt8bMdDVLMGbFnITQHjrL5mUZf9M00szL7Z7m8KLpuTfZdGCRfbM8
         yNcyOdHVvAe7bumsLAyOi+1cR3anYok6yItczRahh6TVJgZwDXaXnjC/m7b2XEhrr4Xs
         8uhQ==
X-Gm-Message-State: APjAAAX/CtY8ggx5m+yQZmmZCxw8ZoKxHuFyq/KcwQRai7j1dBVFO4/s
        wqqGqY+hP4n5oRiaN8iHo8u86DPoU53in/T1xbkQLg==
X-Google-Smtp-Source: APXvYqwiBKiBMnP+60X/FFFfP/Bz9E1Hn3ELs7RJsnESL+czx3hd2fk2X3QyQGJ/m6AVMyIMefSPqrTk9AZaTEbF9/0=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr13113089vkm.25.1575653074665;
 Fri, 06 Dec 2019 09:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org> <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
 <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
 <20191206112549.GA22964@e121166-lin.cambridge.arm.com> <CAPDyKFq0gS2fasU3Yyh+wPC7Pjnucv6_+vDN234ks+yuiURKCw@mail.gmail.com>
 <20191206151421.GA5288@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191206151421.GA5288@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Dec 2019 18:23:57 +0100
Message-ID: <CAPDyKFraVC8MajxEWUbtR8+ur7MzCv9g81zeP1T4JWs6+2tEVQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Dec 2019 at 16:14, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 06, 2019 at 03:26:16PM +0100, Ulf Hansson wrote:
>
> [...]
>
> > > You can merge it as it is but that's how things stand and adding
> > > a comment to the *code* would help understand its logic.
> >
> > Okay, how about adding a comment along the lines of this:
> >
> > "Using the deepest state for the CPU to trigger a potential selection
> > of a shared state for the domain, assumes the domain states are all
> > deeper states".
>
> Just this it should be fine (I trimmed it a bit).

Great, I add that!

>
> > > > So, unless I am missing your point, I think the above code does
> > > > exactly what you want, no?
> > > >
> > > > In regards to the "arbitrary choice" of what cpuidle state to use,
> > > > there are more details about why that is, in the changelog.
> > > >
> > > > >
> > > > > This inizialization though does not belong in here, it is done at driver
> > > > > level, it should not be done in this per-cpu path. IIUC the logic the
> > > > > enter pointer should only be overridden if and only if all cpus managed
> > > > > by the driver have a corresponding device associated.
> > > >
> > > > I think you have overlooked the fact that there are one cpuidle driver
> > > > registered per CPU. The above doesn't make sense to me, sorry.
> > >
> > > You are calling psci_dt_cpu_init_idle() for every possibile cpu.
> > >
> > > Every time psci_dt_attach_cpu() is called, we check dev and override
> > > the idle driver enter method. There is one driver, what I am saying
> > > is that it is not correct to check dev and override the enter pointer
> > > for *every* cpu that we try to attach to a power domain. This must
> > > be done once for all by checking that *all* devices could be attached
> > > to a power domain.
> >
> > Ah, now I think get your point.
> >
> > You want me to re-iterate through all the registered cpuidle drivers,
> > which means one per CPU - and then override the enter callback for
> > each of them, but only if all devices was successfully attached to a
> > PM domain. Is that correct?
> >
> > My only worries with this, is that we have already registered the
> > cpuidle drivers and I don't think it's a good idea to update the enter
> > callbacks, beyond that point.
> >
> > Perhaps another option is to track whether the first CPU gets attached
> > (and then update the enter callback), but after that require all the
> > remaining CPUs to be attached as well - else bail out with an error
> > code, failing to register all the driver instances.
> >
> > What do you think about that?
>
> I was confused - now we have one cpuidle driver per cpu so this
> comment was bogus from this perspective (I was still reasoning
> wit a *single* cpuidle driver across cpus. Apologies).

No worries!

We agreed on the way forward, so I am happy. :-)

>
> Sudeep will follow up on this but please forget this specific
> comment - I was wrong.

Alright, thanks!

Does that also mean I can add your ack for the rest of the patches in
the series (besides the last hotplug patch) or is there any other
issues you want to raise?

Have a nice weekend!

Kind regards
Uffe
