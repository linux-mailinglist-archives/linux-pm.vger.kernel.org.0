Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63507126FC0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSVeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 16:34:13 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44541 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSVeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 16:34:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id p6so4711538vsj.11
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3N/xv20J8SmKyxdIBUydg+WJKi/j4HZgNUpU29Nvw8=;
        b=X0VPbWMBHLoH26X8vqiNrC1USpNu0Y2WZmLwRzsHOK66WfFJl04w40Dti6rYzinylY
         fXZSMt1pCfDVpMtlImlTr4cXx/NL+66inQnMeJfQ7C41oPVC+LmABn9csGSATMMHk8Dm
         GwNvKX9uzPIiPYLApJa2RN8irdMoJN+B7tACJRUnwR7NPCg81Iil3daOTS1Vn7nRev4S
         79WG4ajElSmdSZZc0mkaVuFMZfPKq+g6obXny69+emL12bOH20G/9n8JvaMDrV1JDCLS
         uPWWLd/xZ0d+mx0W8CQVE2wXfUxyA1QOJgbm3vRfx4sfEJTaI2HY8/3b/oa7XHB0hu4X
         +QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3N/xv20J8SmKyxdIBUydg+WJKi/j4HZgNUpU29Nvw8=;
        b=tVxHI22voF/aqjA0tOKh1ODe2snrrhGBvzv9aupLxISSdzg2d6iPc+lGTO0Jbxsdfm
         Upv78+yPCwS5NKKow/d5s/TB0SbqaFtw07Kiug+3pCOIkt5yyRiBAJCqy9zfpR3LF7Ju
         ZCWp6bPlV/Ys3OCuQAjSDQDyIBJaOQgMxa4MhG29CVdDt9uiwSX7j6EYaCpT742a2Uwh
         A6GRF1Uj1c6SGa++NpRGctmWzrX+1KFvkmyqkAUH18XLrk+WsqZpoAORtm4SF7Bu2HZw
         jQcZcSNU8GJf3EPlDXm1MDpMgAePCQi5e15w+ipepYNr9/i0Ev2xa7+gMsyFHvkGu5R8
         /SDQ==
X-Gm-Message-State: APjAAAXJHQTG6qBW4UTe+zlaH8GZAs2XAZjJtD617kzEUoC3THxVuOQf
        yHGjxywgGAea8wbj6p7zZBPzrxC7TQ4t5BV48jHCng==
X-Google-Smtp-Source: APXvYqy91D68qidVmpk52u0XOvDjbWwmOgNQsn1lbBUaMX69/fN9Y1E/vvMWovtfTFN9NKzSlbvgMxNRbcs9ab7FTqA=
X-Received: by 2002:a67:f499:: with SMTP id o25mr6268154vsn.165.1576791251573;
 Thu, 19 Dec 2019 13:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-11-ulf.hansson@linaro.org> <20191219143154.GC20746@bogus>
 <CAPDyKForeHdXPTocvAgFDbX+94UQWbJixUpKLY=0MbnF5XUAMA@mail.gmail.com> <20191219180133.GB21846@bogus>
In-Reply-To: <20191219180133.GB21846@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 22:33:34 +0100
Message-ID: <CAPDyKFoM+SccsawV+0hHF+ku+P=5WuVaUCnKV=ftCgBRmRPseA@mail.gmail.com>
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Dec 2019 at 19:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Dec 19, 2019 at 04:48:13PM +0100, Ulf Hansson wrote:
> > On Thu, 19 Dec 2019 at 15:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 04:43:39PM +0100, Ulf Hansson wrote:
> > > > The per CPU variable psci_power_state, contains an array of fixed values,
> > > > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > > > each of the available CPU idle states.
> > > >
> > > > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > > > combination with having PSCI OS initiated (OSI) mode enabled. More
> > > > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > > > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > > > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > > > state of the cluster.
> > > >
> > > > For this reason, introduce a per CPU variable called domain_state and
> > > > implement two helper functions to read/write its value. Then let the
> > > > domain_state take precedence over the regular selected state, when entering
> > > > and idle state.
> > > >
> > > > To avoid executing the above OSI specific code in the ->enter() callback,
> > > > while operating in the default PSCI Platform Coordinated mode, let's also
> > > > add a new enter-function and use it for OSI.
> > > >
> > > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > >       - Rebased on top of earlier changes.
> > > >       - Add comment about using the deepest cpuidle state for the domain state
> > > >       selection.
> > > >
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci.c | 56 ++++++++++++++++++++++++++++++----
> > > >  1 file changed, 50 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > > index 6a87848be3c3..9600fe674a89 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > > @@ -29,14 +29,47 @@ struct psci_cpuidle_data {
> > > >  };
> > > >
> > > >  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> > > > +static DEFINE_PER_CPU(u32, domain_state);
> > > > +
> > >
> > > [...]
> > >
> > > > +static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > > > +                                     struct cpuidle_driver *drv, int idx)
> > > > +{
> > > > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > > > +     u32 *states = data->psci_states;
> > >
> > > Why can't the above be like this for consistency(see below in
> > > psci_enter_idle_state) ?
> >
> > You have a point, however in patch11 I am adding this line below.
> >
> > struct device *pd_dev = data->dev;
> >
> > So I don't think it matters much, agree?
> >
>
> Ah OK, looked odd as part of this patch, may be you could have moved
> this change into that patch. Anyways fine as is.

Okay, then I rather just keep it.

>
> > >
> > >         u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
> > >
> > > > +     u32 state = psci_get_domain_state();
> > > > +     int ret;
> > > > +
> > > > +     if (!state)
> > > > +             state = states[idx];
> > > > +
> > > > +     ret = psci_enter_state(idx, state);
> > > > +
> > > > +     /* Clear the domain state to start fresh when back from idle. */
> > > > +     psci_set_domain_state(0);
> > > > +     return ret;
> > > > +}
> > > >
> > >
> > > [...]
> > >
> > > > @@ -118,6 +152,15 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > > >                       ret = PTR_ERR(data->dev);
> > > >                       goto free_mem;
> > > >               }
> > > > +
> > > > +             /*
> > > > +              * Using the deepest state for the CPU to trigger a potential
> > > > +              * selection of a shared state for the domain, assumes the
> > > > +              * domain states are all deeper states.
> > > > +              */
> > > > +             if (data->dev)
> > >
> > > You can drop this check as return on error above.
> >
> > Actually not, because if OSI is supported, there is still a
> > possibility that the PM domain topology isn't used.
> >
>
> And how do we support that ? I am missing something here.
>
> > This means ->data->dev is NULL.
> >
>
> I don't get that.

This is quite similar to the existing limited support we have for OSI today.

We are using the idle states for the CPU, but ignoring the idle states
for the cluster. If you just skip applying the DTS patch14, this is
what happens.

>
> > >
> > > > +                     drv->states[state_count - 1].enter =
> > > > +                             psci_enter_domain_idle_state;
> > >
> > > I see the comment above but this potential blocks retention mode at
> > > cluster level when all cpu enter retention at CPU level. I don't like
> > > this assumption, but I don't have any better suggestion. Please add the
> > > note that we can't enter RETENTION state at cluster/domain level when
> > > all CPUs enter at CPU level.
> >
> > You are correct, but I think the comment a few lines above (agreed to
> > be added by Lorenzo in the previous version) should be enough to
> > explain that. No?
> >
> > The point is, this is only a problem if cluster RETENTION is
> > considered to be a shallower state that CPU power off, for example.
> >
>
> Yes, but give examples makes it better and helps people who may be
> wondering why cluster retention state is not being entered. You can just
> add to the above comment:
>
> "e.g. If CPU Retention is one of the shallower state, then we can't enter
> any of the allowed domain states."

Hmm, that it's not a correct statement I think, let me elaborate.

The problem is, that in case the CPU has both RETENTION and POWER OFF
(deepest CPU state), we would only be able to reach a cluster state
(RETENTION or POWER OFF) when the CPUs are in CPU POWER OFF (as that's
the deepest).

This is okay, as long as a cluster RETENTION state is considered being
"deeper" than the CPU POWER OFF state. However, if that isn't the
case, it means  the cluster RETENTION state is not considered in the
correct order, but it's still possible to reach as a "domain state".

I think this all is kind of summarized in the comment I agreed upon
with Lorenzo, but if you still think there is some clarification
needed I happy to add it.

Makes sense?

[...]

Kind regards
Uffe
