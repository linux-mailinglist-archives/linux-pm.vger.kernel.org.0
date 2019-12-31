Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18812D7F7
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 11:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLaKcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 05:32:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46745 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLaKcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 05:32:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so22446903vso.13
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2019 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APq/Wal+/T2ILA2C8LNWwS6Ggl9rmz6le5YLkRNP/Sw=;
        b=HHrpeudfIwbmxHuRTJHpXQiee9zeRr4aVEY+8ccKNrdSUKRL1sPYWvTNYAwyZji2Su
         x5vmizty6Zf/Qm+3cHmG59Szx8w5kfUlTl6s+f6cgCYo94B6lhyEEQYFigXSl7rmOGXc
         PmVSgFQTf2n9QmKEBMSH9J9xxWAFIT2m+elaRkNspcosQEF8D6QeP8b3LBQQjjCu6YgD
         +ALpiLnFBVwvFxP/rZVO39E2sOeEdP3cl+8lfj65EP9ssyAhRFpphcc4uGLXTA5gCnIm
         MpdDXbRamF/4FgzwjBf2K0XHwSDluarQ5eTXLRSR26jCTc8eDck/kQ7qcdPIcd059GlC
         Mh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APq/Wal+/T2ILA2C8LNWwS6Ggl9rmz6le5YLkRNP/Sw=;
        b=fphz0Y7C+39y2JNg71/8QKaJCMfc/4QwOL4FwQsr8WfRO6u07BHDi5r3Ae9531aLnl
         mZ4brsO2YY2ghL2IMwuBK94xGvOSmreFOrZxhr1eGw4ORTdSjknmcwS4oQfWwTtjXyPO
         yfRhlnup+QCil3+pO4n1fY2LZzmEauMlHInIpvRtaNYp+Eill42zwzGTUvxxlquRX9qD
         JuZ81/vPngLq08R/7NZriiBpoGuKmPMe8CYuws1ZR6Nb2HRALv83+7FuTMSuYJX7oFia
         RJNbZQjgDNgOX7HvEY7qYaL7CpC+AOntbaWqMdXzK5x6cCfXd2N78nuaPLncLoQDNG99
         Cu8A==
X-Gm-Message-State: APjAAAXqIZMla6KKdJ6AuVYxOHBk3SeRB81nTXcfg55hKsplECnAMPZs
        3T/VirjaOsMIoSQ+hIFVwXYxG+2hL5IOSZk/D+EPyg==
X-Google-Smtp-Source: APXvYqxcMojNGXqrQu6aASTmtwpwLNCDEpNr0TLNar43gVKvVhyAmAeDk7d7VDvNcmZgtEpYHScuVsvi3mO8nLwxF/0=
X-Received: by 2002:a67:cd96:: with SMTP id r22mr30810457vsl.165.1577788333549;
 Tue, 31 Dec 2019 02:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
 <20191230144402.30195-11-ulf.hansson@linaro.org> <20191230163503.GA16256@bogus>
In-Reply-To: <20191230163503.GA16256@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 Dec 2019 11:31:37 +0100
Message-ID: <CAPDyKFp48rEZAUK3yC9Ac8ECUy+1Z5M6SAt5_ou1DVSe-xVnWg@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] cpuidle: psci: Prepare to use OS initiated
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

On Mon, 30 Dec 2019 at 17:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Dec 30, 2019 at 03:43:57PM +0100, Ulf Hansson wrote:
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
> > Changes in v5:
> >       - None.
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
> > +static inline void psci_set_domain_state(u32 state)
> > +{
> > +     __this_cpu_write(domain_state, state);
> > +}
> > +
> > +static inline u32 psci_get_domain_state(void)
> > +{
> > +     return __this_cpu_read(domain_state);
> > +}
> > +
> > +static inline int psci_enter_state(int idx, u32 state)
> > +{
> > +     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> > +}
> > +
> > +static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > +                                     struct cpuidle_driver *drv, int idx)
> > +{
> > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > +     u32 *states = data->psci_states;
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
> >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> >                               struct cpuidle_driver *drv, int idx)
> >  {
> >       u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
> >
> > -     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> > -                                        idx, state[idx]);
> > +     return psci_enter_state(idx, state[idx]);
> >  }
> >
> >  static struct cpuidle_driver psci_idle_driver __initdata = {
> > @@ -79,7 +112,8 @@ static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >       return 0;
> >  }
> >
> > -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > +                                     struct device_node *cpu_node,
> >                                       unsigned int state_count, int cpu)
> >  {
> >       int i, ret = 0;
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
> Do we still need this check ? I thought we won't attach genpd if OSI is
> not enabled. If possible, please drop the check.

This check is still needed. psci_dt_attach_cpu() now returns NULL when
OSI has not been enabled (see patch 14), as we agreed on during the
discussions around the previous version.

>
> Other than that, looks good to me.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe
