Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CF12660E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSPsv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:48:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34002 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSPsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 10:48:51 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so4070728vsf.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KrItn2ITQ/gEkMRXxlNzrQRHLgN8opGe0fqAyinPUw=;
        b=Krs4v/f5ShTU6CHF0kcrKOfGo7eQ1cC8sZXkheJgud6E52UN2qdbWjgA0hVxLVjNi4
         xttVorIYYFJMhg9rmpwqL4mpm6Aqo00mzZOE6JLxvAXbUAeDIgU1c3NA06d//tiKU3vn
         Eb4BIHzOYGuloyzyHiRfu5SyQDyR8LDTln9mFiThtfqvwx1PPJw4sTE0bwWci2+1arro
         InOyFqt4TlI+xY/YlgF0mgG2UXZaVaEbPQwhf6xC6IqWOZuN887kPaTKQ9LJcuPPK7qy
         vxGMrH2aIqaPPfLq+KwXgidpZovEQV8dbuSYsEu+zIoH1eB4Aw/E6/FJB4IsEGLNF5SK
         cyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KrItn2ITQ/gEkMRXxlNzrQRHLgN8opGe0fqAyinPUw=;
        b=AWAox1295Vhsh93f6mtbdENdsxaSC3tB3KgnoQ23IJ7syj4zaOGZvd54Rrd60cVFxY
         DxmVKBXt7vgtk1MImIVchbtqm/U/JDaUjE+yp/UT4GOCQ62r6qSi6JyEkn2uuAtXzs8r
         lMFBZn+JKpzHPgCv3Kz+9aG63P0IKsGoAzd/RmdI8wPLY8nRodO4TEcjrhLuA6DxCKTX
         jWaGEYKbwp+mrMNGbggIEjP3JycMhVnPstSfEFgBC6zkQeSMvmHIiBh7pvDqsrJ4j9vm
         L+2c1M47+XHNgdEWjukPuGAeTE+RbKi5U5tY6BjFGaz3EPLbvCvPMmrHFEFDqXbjPXyP
         gB4A==
X-Gm-Message-State: APjAAAViTHswLA63zKkv7Zl9M/F1Q+zjuFkqobS2DEM46Cpc98WVf8CU
        2bUgXW6ME7XpXoLTEN/FQERd9fhlq/fVSHayCFSp0Q==
X-Google-Smtp-Source: APXvYqxqo21q1MMNfYKhRJXzlWwvyuU59L2d1Xb7zAa7BXcxGpN1Fniu6C6xLfMTbN70e+rP5ASWf+q3jTb16FT4FAA=
X-Received: by 2002:a67:b649:: with SMTP id e9mr5500898vsm.34.1576770529749;
 Thu, 19 Dec 2019 07:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-11-ulf.hansson@linaro.org> <20191219143154.GC20746@bogus>
In-Reply-To: <20191219143154.GC20746@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 16:48:13 +0100
Message-ID: <CAPDyKForeHdXPTocvAgFDbX+94UQWbJixUpKLY=0MbnF5XUAMA@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

On Thu, 19 Dec 2019 at 15:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Dec 11, 2019 at 04:43:39PM +0100, Ulf Hansson wrote:
> > The per CPU variable psci_power_state, contains an array of fixed values,
> > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > each of the available CPU idle states.
> >
> > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > combination with having PSCI OS initiated (OSI) mode enabled. More
> > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > state of the cluster.
> >
> > For this reason, introduce a per CPU variable called domain_state and
> > implement two helper functions to read/write its value. Then let the
> > domain_state take precedence over the regular selected state, when entering
> > and idle state.
> >
> > To avoid executing the above OSI specific code in the ->enter() callback,
> > while operating in the default PSCI Platform Coordinated mode, let's also
> > add a new enter-function and use it for OSI.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v4:
> >       - Rebased on top of earlier changes.
> >       - Add comment about using the deepest cpuidle state for the domain state
> >       selection.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 56 ++++++++++++++++++++++++++++++----
> >  1 file changed, 50 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 6a87848be3c3..9600fe674a89 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -29,14 +29,47 @@ struct psci_cpuidle_data {
> >  };
> >
> >  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> > +static DEFINE_PER_CPU(u32, domain_state);
> > +
>
> [...]
>
> > +static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > +                                     struct cpuidle_driver *drv, int idx)
> > +{
> > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > +     u32 *states = data->psci_states;
>
> Why can't the above be like this for consistency(see below in
> psci_enter_idle_state) ?

You have a point, however in patch11 I am adding this line below.

struct device *pd_dev = data->dev;

So I don't think it matters much, agree?

>
>         u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
>
> > +     u32 state = psci_get_domain_state();
> > +     int ret;
> > +
> > +     if (!state)
> > +             state = states[idx];
> > +
> > +     ret = psci_enter_state(idx, state);
> > +
> > +     /* Clear the domain state to start fresh when back from idle. */
> > +     psci_set_domain_state(0);
> > +     return ret;
> > +}
> >
>
> [...]
>
> > @@ -118,6 +152,15 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> >                       ret = PTR_ERR(data->dev);
> >                       goto free_mem;
> >               }
> > +
> > +             /*
> > +              * Using the deepest state for the CPU to trigger a potential
> > +              * selection of a shared state for the domain, assumes the
> > +              * domain states are all deeper states.
> > +              */
> > +             if (data->dev)
>
> You can drop this check as return on error above.

Actually not, because if OSI is supported, there is still a
possibility that the PM domain topology isn't used.

This means ->data->dev is NULL.

>
> > +                     drv->states[state_count - 1].enter =
> > +                             psci_enter_domain_idle_state;
>
> I see the comment above but this potential blocks retention mode at
> cluster level when all cpu enter retention at CPU level. I don't like
> this assumption, but I don't have any better suggestion. Please add the
> note that we can't enter RETENTION state at cluster/domain level when
> all CPUs enter at CPU level.

You are correct, but I think the comment a few lines above (agreed to
be added by Lorenzo in the previous version) should be enough to
explain that. No?

The point is, this is only a problem if cluster RETENTION is
considered to be a shallower state that CPU power off, for example.

>
> As I wrote above I got another doubt. What if platform specifies just
> RETENTION state at CPU as well as Cluster/domain ? I think it should be
> fine, just asking it out loud.

It's fine.

However, I am looking at what future improvements that can be made.
This is one of them, but let's discuss that later on.

Kind regards
Uffe
