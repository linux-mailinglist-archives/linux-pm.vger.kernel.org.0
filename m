Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3B1005EA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRMu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 07:50:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46865 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfKRMu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 07:50:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id i31so5166825uae.13
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CJs0fnp4q3JTEKHH9CQ9OKvCdAUdjRx5u4JJzw81b0=;
        b=jm/CGt7tMSAzLYhkixWLkxEXB1f5LJyGoCoOoFxlnO1gso8Id9iLeGv2aW4LW5znZq
         g6D7bQd8XKKrGt6fHk4Mm7CoUf8yYM84TI2iPBGcS7sUvriRa441sKSufEAI0F7m7E8C
         eOam7M7+p4Lcwf4AlUnszEmEghhMJ91gL+MXQxzPpe8Nsir1Hopl7O6iXlOBMMbv15C2
         O0mkepdXFpseZGMHApBOd8ZRVmgfXYKeqf+9jK5l039kqix7NysENToIMw9mgNefwmp/
         fJN6n5Ze7UzzgzbMZ0rNaAt3ktEj9ZUb6uvFCMIYPbP/Ofvkm4EvLIVVE89VgaXVR0AC
         sZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CJs0fnp4q3JTEKHH9CQ9OKvCdAUdjRx5u4JJzw81b0=;
        b=Cg8sB/ShROJlIiK2yBD8nF3NsRm8kwtyfWc1s16IaMswNQYeL6e5ju60EUNpMdPCz7
         xSBfH/IvGR607eefH9gMcWcbXnRWvhQzWWbY28cdB4w4PJL+HW1RunHUmK856ih/7JF9
         LGp3pVfuckAtpBr85A9CQfetlZKzZakXUscGXl/pGTk7LJK+fNgCBMkRKgHnDeP9ScVJ
         dVzsnfNs/BR4jxbxf9ti/XT8QJdA18BPHZx3nRcJMFtjXvJTX8uUyAm3JwgwBikMa101
         NsjL5yc6xMQxfI0QKPcmRF7tbQcI1OW+eMqi5nZ2D29smcvPEtMDWTc5PzxmZ1L/+pjV
         X7xQ==
X-Gm-Message-State: APjAAAUIW3kctk6IX80+TdRi1FmAStvRLhIulVlctfPu9Xm5DjcbhgTM
        29g5oZchW+IBa72mvkjXwDLpnRS/Tce3pU+GM77HXqfHf9I=
X-Google-Smtp-Source: APXvYqzllSdd6OH2VE+FgRV8tVggasb5KGapL/QKSUOqEAXbQPVSSHwo16Z2VRlyvLFg4PqcAu+xADeZo9azF6gmR7M=
X-Received: by 2002:ab0:61cc:: with SMTP id m12mr16585279uan.129.1574081455188;
 Mon, 18 Nov 2019 04:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-10-ulf.hansson@linaro.org> <20191115171555.GD27170@bogus>
In-Reply-To: <20191115171555.GD27170@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 13:50:19 +0100
Message-ID: <CAPDyKFr0jmcF9EAnhDER49kwb3oBGwFJy2iQArmqAqdB5Xz0BA@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] cpuidle: psci: Attach CPU devices to their PM domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Fri, 15 Nov 2019 at 18:16, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 29, 2019 at 05:44:34PM +0100, Ulf Hansson wrote:
> > In order to enable a CPU to be power managed through its PM domain, let's
> > try to attach it by calling psci_dt_attach_cpu() during the cpuidle
> > initialization.
> >
> > psci_dt_attach_cpu() returns a pointer to the attached struct device, which
> > later should be used for runtime PM, hence we need to store it somewhere.
> > Rather than adding yet another per CPU variable, let's create a per CPU
> > struct to collect the relevant per CPU variables.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Rebased.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 830995b8a56f..167249d0493f 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -20,14 +20,20 @@
> >
> >  #include <asm/cpuidle.h>
> >
> > +#include "cpuidle-psci.h"
> >  #include "dt_idle_states.h"
> >
> > -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > +struct psci_cpuidle_data {
> > +     u32 *psci_states;
> > +     struct device *dev;
> > +};
> > +
> > +static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> >
> >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> >                               struct cpuidle_driver *drv, int idx)
> >  {
> > -     u32 *state = __this_cpu_read(psci_power_state);
> > +     u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
> >
> >       return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> >                                          idx, state[idx]);
> > @@ -78,7 +84,9 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> >  {
> >       int i, ret = 0;
> >       u32 *psci_states;
> > +     struct device *dev;
> >       struct device_node *state_node;
> > +     struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
> >
> >       state_count++; /* Add WFI state too */
> >       psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
> > @@ -104,8 +112,16 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> >               goto free_mem;
> >       }
> >
> > -     /* Idle states parsed correctly, initialize per-cpu pointer */
> > -     per_cpu(psci_power_state, cpu) = psci_states;
> > +     dev = psci_dt_attach_cpu(cpu);
>
> Why do we need to call psci_dt_attach_cpu for even PC mode and ...
>
> > +     if (IS_ERR(dev)) {
> > +             ret = PTR_ERR(dev);
> > +             goto free_mem;
> > +     }
> > +
> > +     data->dev = dev;
> > +
>
> ... assign NULL above. I don't see the need for one. Default it will be
> NULL anyway and we can call psci_dt_attach_cpu only if psci_has_osi_support()

Are you sure it's NULL as default? It's a pointer, within a static
initiated struct.

"static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data,
psci_cpuidle_data);"

>
> I will look through further patches to see if it make sense or not.

So, the check for psci_has_osi_support() is done in
psci_dt_attach_cpu(), which returns "NULL" if OSI isn't supported.

The idea with this approach is also to keep the common code in
psci_dt_cpu_init_idle() (or the entire cpuidle-psci.c actually), as
transparent as possible, to whether PSCI OSI-mode is supported or not.

Of course, if you insist, I am open to change in any way you prefer.

Kind regards
Uffe
