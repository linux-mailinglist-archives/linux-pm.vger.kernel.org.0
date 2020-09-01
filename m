Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B8258F78
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 15:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIANux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgIANud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 09:50:33 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6CC061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 06:50:32 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a16so630196vsp.12
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOYRszVylv5Qz23BmXtjMyc9Iy5dLd/KwZYwPdNZWvk=;
        b=mXnW2229THyIwXHowE9JPOwUPUufL0VNNEPER7Bdo2EBxEvqyAO5QUNwL18OTKlqax
         yLy2Borm6DemMVOBzi/pLv2xE0SiMLwZICkxd1y5CWgwi8K2uDS/vJVOgmWj4qEOYZSF
         l8bIC0oY6vO7H4erEZPHeJYw9cHEEFZJ/KdaG4S8YNJCNRQGtGN0FxbFcVwlMa0I1/Vx
         PTa8eTkaxGLSWlXwjta1h5vNH768TzITBEBWZMQou0ZUdnTUOn/cg4R7NTbms+cWhLKF
         Si9Q8DUtuaePB8NjSlTuSq+qaDzlYP7NkasuwyLmJDX+Yp3aq37s9TLuqzujCSw/PrfJ
         O3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOYRszVylv5Qz23BmXtjMyc9Iy5dLd/KwZYwPdNZWvk=;
        b=KrwI0lEPWim7KTUpb7pghpE4Nzi6OC2/kCkGhlW6suDlIEvQoKx02iCIV5ykCz/Ti2
         CXBYQpx0K4sQh+FL6LcjlwmTiA2ahQUr6trTHi0rhlObYuhZwPU4zbP7At3BXJSUF3Eu
         AwtZillDBz8DxX7aJGhHCLccqR+kBzpTolEHbmirYDp40UEZkuidGvf2lwCnwjQ6LZY0
         1B9SL9fin+goKxU/JBM1CqYesW7gs9Igbct21bdutKJFLUJxfrZq3724SgtkhCvnGzSB
         DbzJhIqTd4bcU506K1cJPj+73RC8N2wBvDssKVpLhOx85E3ZBdujA3yRpMCegmV8MC67
         P0pg==
X-Gm-Message-State: AOAM531VWZnTes/lUr5t6tdnP5oVDtUUY7F/3ToUrqx/okStU8p19moh
        /ch6B3CLXyCmqma4NtFgVoB9je5wFuZncQ3yODRNM4uGYDbJhgzC
X-Google-Smtp-Source: ABdhPJwihfluFpkZ7O1r9fXxhvAzd3IUDix1pJIOwBcijCDhp3bWlxCH593fIx9K+Gsuks9sFuYCzkL8WmzOTjFJr0g=
X-Received: by 2002:a67:d209:: with SMTP id y9mr1522066vsi.44.1598968231415;
 Tue, 01 Sep 2020 06:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
 <20200901121226.217568-3-ulf.hansson@linaro.org> <20200901133218.GB27090@bogus>
In-Reply-To: <20200901133218.GB27090@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 15:49:55 +0200
Message-ID: <CAPDyKFrpfXD4tdghXyFPZUNT138FOi643rxTgrtjTBXP1S1nSg@mail.gmail.com>
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

On Tue, 1 Sep 2020 at 15:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 01, 2020 at 02:12:26PM +0200, Ulf Hansson wrote:
> > If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> > topology with the genpd providers isn't initialized. This is perfectly fine
> > from cpuidle-psci point of view.
> >
> > However, since the PM domain topology in the DTS files is a description of
> > the HW, no matter of whether the PSCI OSI mode is supported or not, other
> > consumers besides the CPUs may rely on it.
> >
> > Therefore, let's always allow the initialization of the PM domain topology
> > to succeed, independently of whether the PSCI OSI mode is supported.
> > Consequentially we need to track if we succeed to enable the OSI mode, as
> > to know when a domain idlestate can be selected.
> >
> > Note that, CPU devices are still not being attached to the PM domain
> > topology, unless the PSCI OSI mode is supported.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Assign the genpd ->power_off() callback, only when the PSCI OSI mode
> >       has been successfully enabled.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 57 ++++++++++++++-------------
> >  1 file changed, 29 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index b6ab0415f450..256e7e35b5af 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -105,7 +105,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> >       kfree(states);
> >  }
> >
> > -static int psci_pd_init(struct device_node *np)
> > +static int psci_pd_init(struct device_node *np, bool use_osi)
> >  {
> >       struct generic_pm_domain *pd;
> >       struct psci_pd_provider *pd_provider;
> > @@ -135,11 +135,14 @@ static int psci_pd_init(struct device_node *np)
> >
> >       pd->free_states = psci_pd_free_states;
> >       pd->name = kbasename(pd->name);
> > -     pd->power_off = psci_pd_power_off;
> >       pd->states = states;
> >       pd->state_count = state_count;
> >       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> >
> > +     /* Use the ->power_off() callback when OSI is enabled. */
>
> IIUC, you did mention that we need to attach PD even when the OSI fails
> as this could be shared domain. With the below conditional assignment
> of power_off, I understand that if OSI fails and we have domains attached,
> then it will be always ON ?

From a genpd point of view, the corresponding PM domain can be powered
off (as long as all attached consumers allow that as well, of course).

Hmm, maybe we should add a GENPD_FLAG_ALWAYS_ON, to really enforce
that it stays on?

>
>
> Other than that, this patch looks good.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe
