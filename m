Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74B1D3D28
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgENTM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 15:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729523AbgENTM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 15:12:28 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7510C061A0C
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 12:12:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b11so2636416vsa.13
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LE3Op6W1pMVVmKhBNLCDSlKGpivMWVI6Y3FDIsX10s=;
        b=hdhJP6EkEPN4CIH6D4KHLE7Hg+GJ+ap7GksmrIQCwncKT0WXcnpBJflfW9zqooy/CR
         1SyXzAEnzuGmhPNMPO8t6tBWaIpAn9Pgeqe0w2N77pECiKnK9O+sb03tun6Lbp7c8LVO
         ZQ2W8WuLM+ptixrh3UzXJ4AkylwR1r1VLt6jrJ/JXMNkWp8rB/mWgsTv8PUaiF59avZ0
         fiF4tgSoFNUKdWnTSo21eIESqvyQNcB8Av36iYz6e1XEGc8zqpgKOdGxboaFb7gLyXc3
         +vZO6/Fj9xJTySrViGMj+gagg/9QH3dp1Noon3ZuMCGnzAKIBjgYPU6AppZLienNgYbw
         TLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LE3Op6W1pMVVmKhBNLCDSlKGpivMWVI6Y3FDIsX10s=;
        b=rDlC5nJbdxGN4wHBWrr9ZmZcTRWJ2c8bXb1qTkvsI2xPmfkw0/GgSRQAvPoisidm6y
         wYLTjUKCOsr31xirZyyoTdqD0p2pNmxUt7cdcH2OSsFVlvRmP0j4yCe0EbAUU+Y2wiUE
         GLdJ+JIY493oxPbXBPnmjAuTLw1k2UYPII1QNAgvonsNXYVZ6cRxVx27Gi6/XlabhEd8
         0x+fdfD4lZkhkUhUDDquc9I/7EH4h5EBUG4qi+CGOS59MW/2IT2JuHMY1mrf+1zxYDFy
         4acrVgNXNQgRXklapzRKFH4pUDW7d4Ay90dSHSj/2pNLmSLhNyBLBHKT5uHhRX//B9mV
         L5ww==
X-Gm-Message-State: AOAM532YrSlKSuPU/JyxgFELtf1saf6MQJJ+eiEC7FZvbA4BUbTIJ380
        /lH5vGdr5078sNEeUm2+z3BxyPQIrmJIb36BQb8XuQ==
X-Google-Smtp-Source: ABdhPJyFDV7FfjuvogH4RjQMp/eTHNABRxGEE68tUKUm3krpWc2shmK46EO0auQqrgNrRsGZNJCioZodjIqF0MeMz/Q=
X-Received: by 2002:a05:6102:242:: with SMTP id a2mr4819381vsq.200.1589483546788;
 Thu, 14 May 2020 12:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
 <20200514142015.GA23401@bogus> <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
 <20200514172816.GA42669@bogus>
In-Reply-To: <20200514172816.GA42669@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 May 2020 21:11:50 +0200
Message-ID: <CAPDyKFrdrOnxFHaAR=cmMi2VfSudyHdjZ7vRZKhTQtepdkiXug@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 May 2020 at 19:28, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, May 14, 2020 at 05:41:37PM +0200, Ulf Hansson wrote:
> > On Thu, 14 May 2020 at 16:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Mon, May 11, 2020 at 03:33:46PM +0200, Ulf Hansson wrote:
> > > > Moving forward, platforms are going to need to execute specific "last-man"
> > > > operations before a domain idle state can be entered.
> > >
> > > I need to dig the thread details, but I remember commenting on one of
> > > the similar discussion. It was something to do with voting which wasn't
> > > necessary at all. I am interested in the details here.
> > >
> > > > In one way or the other, these operations needs to be triggered while
> > > > walking the  hierarchical topology via runtime PM and genpd, as it's at that
> > > > point the last-man becomes known.
> > > >
> > > > Moreover, executing last-man operations needs to be done after the CPU PM
> > > > notifications are sent through cpu_pm_enter(), as otherwise it's likely
> > > > that some notifications would fail. Therefore, let's re-order the sequence
> > > > in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
> > > > pm_runtime_put_sync().
> > > >
> > >
> > > More details on why notifications fail ?
> >
> > Well, at this moment this is more of a hypothetical issue as there is
> > no last-man notification sent/used yet.
> >
>
> Ah OK.
>
> > However, typically we would call cpu_cluster_pm_enter() in the path as
> > when the psci_pd_power_off() is called (for psci PM domains), when a
> > valid domain state has been found.
> >
>
> Please don't use cpu_cluster_pm_enter. I thought the whole idea of genpd
> will remove the notion of cluster and we will never need to use
> cpu_cluster_pm_*
>
> > This means, we would violate the cpu_cluster_pm_enter() API, as it's
> > clearly stated in its corresponding function header, that
> > cpu_pm_enter() needs to be called first (and that's also how others
> > are currently using it).
> >
>
> Ah so, it was just for use of cpu_cluster_pm_* which I would like to
> avoid. That was one of the motivation for using genpd I thought.
>
> > Note that, I am currently exploring whether we shall call
> > cpu_cluster_pm_enter|exit() at all, or whether we can use some other
> > new genpd mechanism to accomplish the similar thing.
> >
>
> Good, you do think so.

Okay, let's see where things go. I will keep you posted.

> > >
> > > > Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
> > > > Reported-by: Lina Iyer <ilina@codeaurora.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > > index bae9140a65a5..d0fb585073c6 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > > @@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > > >       u32 state;
> > > >       int ret;
> > > >
> > > > +     ret = cpu_pm_enter();
> > > > +     if (ret)
> > > > +             return -1;
> > > > +
> > >
> > > This change is ignoring the retention case psci_enter_state handles and
> > > this may affect performance by doing unnecessary save/restore.
> >
> > This was already the case before. CPU_PM_CPU_IDLE_ENTER_PARAM() ends
> > up always setting "is_retention" to 0, when __CPU_PM_CPU_IDLE_ENTER()
> > is called.
> >
>
> Ah OK, I recall now, sorry for the noise.

No worries, thanks for reviewing.

That said, are you fine with Rafel queuing this then?

Kind regards
Uffe
