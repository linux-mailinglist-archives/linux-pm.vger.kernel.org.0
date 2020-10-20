Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015BA29324D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 02:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbgJTARW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgJTARW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 20:17:22 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5AC0613CE
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 17:17:20 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c1so73722uap.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXGSyBwNaBjMrW2ERxIvilFJ1fWcA9bm1Ase8U4RnoM=;
        b=BIplX+9oOilzheiFYjLxzo3YjWEXmrI1MjMABQjE7ctb6s08QF6kZjgen0t9fbJWIq
         tv4E6cikhwb0C1hDeBHbJC/GGHoTnx7TM9dixTQk/JORHRWWpvDjhtVyp+RSrnXL0yJd
         d3TrcsXmGMqp/Eh0b23VbcNRzpCpqUgsL0u4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXGSyBwNaBjMrW2ERxIvilFJ1fWcA9bm1Ase8U4RnoM=;
        b=cApTbcC0i8l2zokTbDDoHZ4ZdkvC8uQKEgGqrk8hRo3tAZIjtzFKzO65omQy4ol1aU
         KTYUfMtxDGn4D5nTT6RCTqwyihd7C4gzpqCuE3cmgRX9mlNkEsXVCV1JRmxlnOIOFa7j
         J7xZMwlBCE1/vNbQlAWy6zwADI2O32qKNN1GCc4yVoVkoxIG8WlNNP3h1uUAfv0yRxtG
         bvM2CCwHP64pA/fzVqQ7XlLWP6yvUyljiryJPTnFrpuscS8mx+ncnnHuUAcLl2GRuPqd
         CCFNODyPu4SNEabzrmUuf1LZ2BYMwFdeXDqJdvkgA5vx+EZzxUJx+RHhvfwjdGtawSiA
         pscA==
X-Gm-Message-State: AOAM532nW6tjZEy6R4zNrw/QFzt9ruiExTbBEi0Feo5wMs/aeb+0zdRN
        s6MounNRA+vESootbOqwGifCbAg01cNTsw==
X-Google-Smtp-Source: ABdhPJy8P8IQocdQOkM3TXlF0KC1IZmaBlYXoV314lZpkLr0nlICQ13VkhMfQ+eEkBnffUDBPzmXDw==
X-Received: by 2002:ab0:335a:: with SMTP id h26mr70697uap.62.1603153039828;
        Mon, 19 Oct 2020 17:17:19 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a22sm3234vsh.13.2020.10.19.17.17.18
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 17:17:19 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id f8so78906vsl.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 17:17:18 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr143939vsl.4.1603153038232;
 Mon, 19 Oct 2020 17:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201019140601.3047-1-lukasz.luba@arm.com> <20201019140601.3047-2-lukasz.luba@arm.com>
In-Reply-To: <20201019140601.3047-2-lukasz.luba@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Oct 2020 17:17:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Up1Qssb=Q2UfXTKmd1oLGrEpTCH50ejgFSPnRQP1d-iQ@mail.gmail.com>
Message-ID: <CAD=FV=Up1Qssb=Q2UfXTKmd1oLGrEpTCH50ejgFSPnRQP1d-iQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PM / EM: Add a flag indicating units of power
 values in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Oct 19, 2020 at 7:06 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> There are different platforms and devices which might use different scale
> for the power values. Kernel sub-systems might need to check if all
> Energy Model (EM) devices are using the same scale. Address that issue and
> store the information inside EM for each device. Thanks to that they can
> be easily compared and proper action triggered.
>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c |  3 ++-
>  drivers/opp/of.c               |  2 +-
>  include/linux/energy_model.h   |  9 +++++++--
>  kernel/power/energy_model.c    | 24 +++++++++++++++++++++++-
>  4 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index e855e8612a67..3714a4cd07fa 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -188,7 +188,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>         policy->fast_switch_possible =
>                 handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>
> -       em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
> +       em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
> +                                   false);
>
>         return 0;
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 874b58756220..9e1307061de5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1333,7 +1333,7 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>                 goto failed;
>         }
>
> -       ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus);
> +       ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
>         if (ret)
>                 goto failed;
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b67a51c574b9..2c31d79bb922 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -29,6 +29,8 @@ struct em_perf_state {
>   * em_perf_domain - Performance domain
>   * @table:             List of performance states, in ascending order
>   * @nr_perf_states:    Number of performance states
> + * @milliwatts:                Flag indicating the power values are in milli-Watts
> + *                     or some other scale.
>   * @cpus:              Cpumask covering the CPUs of the domain. It's here
>   *                     for performance reasons to avoid potential cache
>   *                     misses during energy calculations in the scheduler
> @@ -43,6 +45,7 @@ struct em_perf_state {
>  struct em_perf_domain {
>         struct em_perf_state *table;
>         int nr_perf_states;
> +       bool milliwatts;
>         unsigned long cpus[];
>  };
>
> @@ -79,7 +82,8 @@ struct em_data_callback {
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -                               struct em_data_callback *cb, cpumask_t *span);
> +                               struct em_data_callback *cb, cpumask_t *spani,
> +                               bool milliwatts);
>  void em_dev_unregister_perf_domain(struct device *dev);
>
>  /**
> @@ -186,7 +190,8 @@ struct em_data_callback {};
>
>  static inline
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -                               struct em_data_callback *cb, cpumask_t *span)
> +                               struct em_data_callback *cb, cpumask_t *span,
> +                               bool milliwatts)
>  {
>         return -EINVAL;
>  }
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index c1ff7fa030ab..efe2a595988e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -52,6 +52,17 @@ static int em_debug_cpus_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
>
> +static int em_debug_units_show(struct seq_file *s, void *unused)
> +{
> +       struct em_perf_domain *pd = s->private;
> +       char *units = pd->milliwatts ? "milliWatts" : "bogoWatts";
> +
> +       seq_printf(s, "%s\n", units);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(em_debug_units);
> +
>  static void em_debug_create_pd(struct device *dev)
>  {
>         struct dentry *d;
> @@ -64,6 +75,8 @@ static void em_debug_create_pd(struct device *dev)
>                 debugfs_create_file("cpus", 0444, d, dev->em_pd->cpus,
>                                     &em_debug_cpus_fops);
>
> +       debugfs_create_file("units", 0444, d, dev->em_pd, &em_debug_units_fops);
> +
>         /* Create a sub-directory for each performance state */
>         for (i = 0; i < dev->em_pd->nr_perf_states; i++)
>                 em_debug_create_ps(&dev->em_pd->table[i], d);
> @@ -250,17 +263,24 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
>   * @cpus       : Pointer to cpumask_t, which in case of a CPU device is
>   *             obligatory. It can be taken from i.e. 'policy->cpus'. For other
>   *             type of devices this should be set to NULL.
> + * @milliwatts : Flag indicating that the power values are in milliWatts or
> + *             in some other scale. It must be set properly.
>   *
>   * Create Energy Model tables for a performance domain using the callbacks
>   * defined in cb.
>   *
> + * The @milliwatts is important to set with correct value. Some kernel
> + * sub-systems might rely on this flag and check if all devices in the EM are
> + * using the same scale.
> + *
>   * If multiple clients register the same performance domain, all but the first
>   * registration will be ignored.

Should the bullet point above be changed?

I haven't dug through all the code so I may be being naive, but it
seems like if someone registers with "milliWatts" set to true then it
should ignore the old values where milliWatts were false?  Otherwise,
I think, if SCMI registers some numbers first does that mean we can't
later register updated numbers in the device tree?  Also, what happens
when some devices register with milliWatts, some with bogoWatts, and
some with both?  How do we decide what we should be using and what we
should be throwing away?

As per my response in the cover letter, I guess one option would be to
try to figure out a bogoWatts to milliWatts conversion factor the
first time someone tried to register once one way and once the other
way?


-Doug
