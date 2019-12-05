Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4511911483B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 21:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfLEUjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 15:39:23 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43018 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLEUjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 15:39:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id x4so3409237vsx.10
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 12:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSvOjQkThzkjS0E5kT8izv176PiG+QeLySxW76GfG/8=;
        b=KEqh5U3mky5aGe7W96TiE2LasaP3xlk51SGQLcUTzI1gDcy3EH1dmJjfwPF/JMLEBM
         nGW8/IEwFXENSKvuLMyqJq96Kr0LfnE6z/+8Tp7EQd2fB1Df1iiwJoWw6TRgiNgTJuLZ
         TgrcNx9ZGBo597myzBWXph+Dsp5sIE/30gEpNX/TsvHQX0Pd5mTNnJDB53bYzEnCZTjb
         v3zt0XPG6g9HJjA1lnPkIYhsHqMnsI809RxuIQ8B4lEh1rFGDgcs0uBPvTw3SMsr647w
         a9KMvmrWdUgCDY6klznjR5FatNCjj3nUZMnQnyERTctkh5Sd+jGWTuXmjGz6YGJDfYl9
         lt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSvOjQkThzkjS0E5kT8izv176PiG+QeLySxW76GfG/8=;
        b=j/JGWxhX65wzpvBS1vuBj3Y7PeVvnFSpzYlIN1NH0ph0vSMvs9XD1o0yYgli+ifXQj
         TYLp0mhxPQgn6JOkxEOrAYY22MxOVAuBwoe3YHVNJrapR7PbF7VvCKF8EFn1af86CMJ0
         ilvJL6ONV4XC8UlUFt/FCirg9oGmfHpAu4OskBH+CQHEyl82gaI6qJtGXIzhQ1sIO5pG
         MdqCNIUCg2sDwLxRjKjGZj9BUE9F76FpsK0lNA8me2mhvUnLvK/tB34LXEl+UzptWewX
         BIaBoxiZs3v37+nIAVBxyNmZ4KWVI7kJ1UYe4fDgT7DBiOZEDnWgHCsDTkJWghnMn3rB
         FSsw==
X-Gm-Message-State: APjAAAWiSJXb+o6W7LzZ/M55p2Y4BVqhWnnyeHROoQNKYKw5WhxubBrB
        g9lHKSCXzf3VD6wsFfx4qyhWAKp3eXr2p4L4GjOcAA==
X-Google-Smtp-Source: APXvYqwv8W+XvnbaXKWKlmbMYtOfLrbfwOBq+4ILBpgcTAHXNniAJi3G7xZyAP75rfwK/aPe4c6uig2q/Wwh9WLoeNU=
X-Received: by 2002:a67:f499:: with SMTP id o25mr6993350vsn.165.1575578362421;
 Thu, 05 Dec 2019 12:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org> <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
 <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
In-Reply-To: <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Dec 2019 21:38:45 +0100
Message-ID: <CAPDyKFpRLWO0D9an_OH3VJYDXM=SQWDfx0A4tOhufA+_L2Zp-g@mail.gmail.com>
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

On Thu, 5 Dec 2019 at 21:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 5 Dec 2019 at 19:35, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Nov 27, 2019 at 11:29:11AM +0100, Ulf Hansson wrote:
> >
> > [...]
> >
> > > -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > > +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > > +                                     struct device_node *cpu_node,
> > >                                       unsigned int state_count, int cpu)
> > >  {
> > >       int i, ret = 0;
> > > @@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > >               goto free_mem;
> > >       }
> > >
> > > +     /* Manage the deepest state via a dedicated enter-function. */
> > > +     if (dev)
> > > +             drv->states[state_count - 1].enter =
> > > +                     psci_enter_domain_idle_state;
> >
> >
> > It is unfortunate to make this arbitrary choice, it would be best
> > if you could detect which states are "domain" states aka are governed
> > by multiple cpus.
>
> The domain states are managed and selected by the genpd providers, via
> using runtime PM reference counting. Please have a closer look at the
> code in cpuidle-psci-domain.c and in the generic PM domain, that
> should give you the needed details.
>
> I am overriding the enter callback for the *deepest* known idle state
> of the CPU, which is according to what you requested [1].
>
> So, unless I am missing your point, I think the above code does
> exactly what you want, no?
>
> In regards to the "arbitrary choice" of what cpuidle state to use,
> there are more details about why that is, in the changelog.

Correction: Since I have moved patches around, I realized that the
explanation is actually put in the changelog of patch11.

For clarity, let me cut and paste it here as well:

"The triggering point for when runtime PM reference counting should be done,
has been selected to the deepest idle state for the CPU. However, from the
hierarchical point view, there may be good reasons to do runtime PM
reference counting even on shallower idle states, but at this point this
isn't supported, mainly due to limitations set by the generic PM domain."

Is that good enough or you want some of this information also in the
changelog of $subject patch? Or if you have any other idea for how to
make this more clear?

[...]

Kind regards
Uffe
