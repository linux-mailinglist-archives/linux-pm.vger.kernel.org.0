Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109ED25904A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIAOYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIAOYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 10:24:21 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE9C061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 07:24:10 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s29so482679uae.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0841vRD0P3xU4E/LUpIQiuM2rN2CsHVvCQKZ7w10Uw=;
        b=GZs/zG6eHNK+WjKNjW7IzC4WYMno0udiUVtSq444fIe4zuGGPZUx/ZXFe25f73OFic
         t9B7aKLCuw1fi+jzwM92b43u11MusM2nrochD0Nx/bSlw0NXxJWhWmNApBT7TMUCKR3X
         ZWXH7YNRTl1Xurjb5EWMXO3FsGDO9nLIknvc2l6slQMZB1ZCgpAksjCo+Flr3OoNSK8u
         XQ/KruqKFNKh3tJUe2oqayjpJNJsv4q3kL7uAwm3xCkOvaj6XGK+k7gLtKJOelbhTyul
         fHTb9Sykx809lYq9KoWsLCvELnKkdqnbeZeCmXG6AI44QFz/dwCkXOxUCnaDCXwtT4Ss
         vA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0841vRD0P3xU4E/LUpIQiuM2rN2CsHVvCQKZ7w10Uw=;
        b=Q0xHjuI71ovd7cvzAY4+440c3DO0kHJ3FU9HTLYMqCoKhu1asL5M6fRAr79z0wZ7Py
         TZYfCDDSskgZN7YqRFtStp95eNS57JxrP5hlWein6MBsn/ExydyTZshrnApUU/zQWWu4
         XMiPSVUO93yP+2/a2b00QNZg8tklWDcXz5sRKhQbDrfCbp0vRj5mFq6/9roUZArL8M6O
         +CdEj7YudVJ3GJyYNpj7JFQk+xoKG7v0iJ/7I+WRBYquGGJ/Z6saGEa9LnzRs5KDB8Ue
         JnrAs+N+gdoFN1sIS0VUIqp0PBiiEFh2bVH66N8h6+w+eWI8ennwMBVSqJ99eSlzFPcr
         VMwg==
X-Gm-Message-State: AOAM531txFPT88q6lzouaWRPD4Q0YWpflBzS6WFtK4gsYJAmNEja2n35
        db7r3hg29N0AXJ9Yw6sF6OmnZp2D+sEQeIMlnn/ZsQ==
X-Google-Smtp-Source: ABdhPJwdsePHI6TV++yYCuYXGcfVM4sRFxJ+tMHz7V77U4vhv8yutcpQfdnhB1E5KhQvnmJglapawas6yt3nKG9T2CY=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr1466021uaq.15.1598970248358;
 Tue, 01 Sep 2020 07:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
 <20200901121226.217568-3-ulf.hansson@linaro.org> <20200901133218.GB27090@bogus>
 <CAPDyKFrpfXD4tdghXyFPZUNT138FOi643rxTgrtjTBXP1S1nSg@mail.gmail.com> <20200901141141.GA11121@bogus>
In-Reply-To: <20200901141141.GA11121@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 16:23:31 +0200
Message-ID: <CAPDyKFq8CGwEMFna-dU-OqBHog35j1NC=Yi7U1ZtecEUrih75Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: psci: Allow PM domain to be initialized
 even if no OSI mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
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

On Tue, 1 Sep 2020 at 16:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 01, 2020 at 03:49:55PM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 15:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Sep 01, 2020 at 02:12:26PM +0200, Ulf Hansson wrote:
> > > > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > > > topology with the genpd providers isn't initialized. This is perfectly fine
> > > > from cpuidle-psci point of view.
> > > >
> > > > However, since the PM domain topology in the DTS files is a description of
> > > > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > > > consumers besides the CPUs may rely on it.
> > > >
> > > > Therefore, let's always allow the initialization of the PM domain topology
> > > > to succeed, independently of whether the PSCI OSI mode is supported.
> > > > Consequentially we need to track if we succeed to enable the OSI mode, as
> > > > to know when a domain idlestate can be selected.
> > > >
> > > > Note that, CPU devices are still not being attached to the PM domain
> > > > topology, unless the PSCI OSI mode is supported.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >       - Assign the genpd ->power_off() callback, only when the PSCI OSI mode
> > > >       has been successfully enabled.
> > > >
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci-domain.c | 57 ++++++++++++++-------------
> > > >  1 file changed, 29 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > index b6ab0415f450..256e7e35b5af 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > @@ -105,7 +105,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> > > >       kfree(states);
> > > >  }
> > > >
> > > > -static int psci_pd_init(struct device_node *np)
> > > > +static int psci_pd_init(struct device_node *np, bool use_osi)
> > > >  {
> > > >       struct generic_pm_domain *pd;
> > > >       struct psci_pd_provider *pd_provider;
> > > > @@ -135,11 +135,14 @@ static int psci_pd_init(struct device_node *np)
> > > >
> > > >       pd->free_states = psci_pd_free_states;
> > > >       pd->name = kbasename(pd->name);
> > > > -     pd->power_off = psci_pd_power_off;
> > > >       pd->states = states;
> > > >       pd->state_count = state_count;
> > > >       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> > > >
> > > > +     /* Use the ->power_off() callback when OSI is enabled. */
> > >
> > > IIUC, you did mention that we need to attach PD even when the OSI fails
> > > as this could be shared domain. With the below conditional assignment
> > > of power_off, I understand that if OSI fails and we have domains attached,
> > > then it will be always ON ?
> >
> > From a genpd point of view, the corresponding PM domain can be powered
> > off (as long as all attached consumers allow that as well, of course).
> >
>
> Can be powered off ? Or will be powered off ? It sounds wrong if it will
> be powered off as the domain needs to be powered up for CPU to be running.
> It sounds like we may be out of sync though not a big issue, it sounds
> weird for me.

You are right, it's a bit weird.

>
> > Hmm, maybe we should add a GENPD_FLAG_ALWAYS_ON, to really enforce
> > that it stays on?
> >
>
> Should that not be default for CPU power domains if OSI can't be enabled ?

Yes, that makes perfect sense to me as well. Let me respin and fix it,
I will also add your acks/reviewed-by.

Kind regards
Uffe
