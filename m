Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE93184443
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMKEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 06:04:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMKEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 06:04:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so11280136wrx.6
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1BEt3UIGfTekolaIpPF/hNSscfxV9hshAR77bRQcfs=;
        b=Iro+3wZDWxCWBF3ZCk4grTtxEu8Ng2iTU/+5rxgpeCPlIMvgELtoh1xmBS6mLfYBJp
         PbKf695K0pbXUAtKLP81n78yrq39uBxyUxhVDEjljT/whkCSZqM6Jg2mOnzW6LaNCha8
         aqI0aswpcT9Wrv5bn1NFxW/5C/KUtz8ABt9I0XpHUu9fQjtK6GV3SJkyZNpqtXtNDcXm
         IPS1f3XXRq5PRyhiZhaQfY+WFVV84msB79je7IBk5pWsWkH/oJLcPrICAH9qW7Dw8tdP
         kwGJQBs+RqMQfqI3N8r8SOixaP1DgMzACMqqflMsgRcl0KTOu6NjLf5utsw9IJzFIM0H
         l7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1BEt3UIGfTekolaIpPF/hNSscfxV9hshAR77bRQcfs=;
        b=CEfQp+mhtIavNdAC1EH8zURS+QswWw51XNervLIKlhE+JVfIhaMErmHlSkYQgck5nj
         juhEGdM+rERJozCubTtOwVP7LxUZT4AKnDKwjtZXQlQjDO/jmT8MYTQkVbqfIzmly6a5
         hei4MZtUTRKxgSSjZ4rSxi+BzuLI8v2977rmMo4dRrCfLhqoBn2bsClHl/vfu7ZLLGmV
         hugTJ/6PrSlcddmIkwvBpZX7DMYBa3wFmi861VOpnOZh3gGhRMLsaZTu+7l/k17DzqEx
         cYmGham8PSYh5E1v3eFsfaYes19xvj0hl6f+aZ223IQuKHA32YYqNp6uZG9fJbZSmhlk
         9kXg==
X-Gm-Message-State: ANhLgQ1ElitgbWNb9fYGx2WUAXRAcNOl/S6wRn0O8cm8RHCWoepx3oK0
        19zqxCcYng8h5Y5BgQdctGa5Uw==
X-Google-Smtp-Source: ADFU+vuSOxM7UP5iet+lNWpCxn8Nzw1dxCSR6mmfTI+siSqyYgXG1TXkJqWMlxCnj9dsZhpGWBOitA==
X-Received: by 2002:a5d:5691:: with SMTP id f17mr16399522wrv.74.1584093852416;
        Fri, 13 Mar 2020 03:04:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id l83sm16694454wmf.43.2020.03.13.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:04:11 -0700 (PDT)
Date:   Fri, 13 Mar 2020 10:04:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org
Subject: Re: [PATCH v4 1/4] PM / EM: add devices to Energy Model
Message-ID: <20200313100407.GA144499@google.com>
References: <20200309134117.2331-1-lukasz.luba@arm.com>
 <20200309134117.2331-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309134117.2331-2-lukasz.luba@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Monday 09 Mar 2020 at 13:41:14 (+0000), Lukasz Luba wrote:
<snip>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9cd8f0adacae..0efd6cf6d023 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1047,9 +1047,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
>   * calculation failed because of missing parameters, 0 otherwise.
>   */
>  static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> -					 int cpu)
> +					 struct device *cpu_dev)
>  {
> -	struct device *cpu_dev;
>  	struct dev_pm_opp *opp;
>  	struct device_node *np;
>  	unsigned long mV, Hz;
> @@ -1057,10 +1056,6 @@ static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
>  	u64 tmp;
>  	int ret;
>  
> -	cpu_dev = get_cpu_device(cpu);
> -	if (!cpu_dev)
> -		return -ENODEV;
> -
>  	np = of_node_get(cpu_dev->of_node);
>  	if (!np)
>  		return -EINVAL;
> @@ -1128,6 +1123,6 @@ void dev_pm_opp_of_register_em(struct cpumask *cpus)
>  	if (ret || !cap)
>  		return;
>  
> -	em_register_perf_domain(cpus, nr_opp, &em_cb);
> +	em_register_perf_domain(cpu_dev, nr_opp, &em_cb, cpus);

Any reason for not checking the return value here ? You added a nice
check in scmi_get_cpu_power(), perhaps do the same thing here ?

>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index fe83d7a210d4..fcf2dab1b3b8 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -333,18 +333,18 @@ static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
>  		return false;
>  
>  	policy = cpufreq_cdev->policy;
> -	if (!cpumask_equal(policy->related_cpus, to_cpumask(em->cpus))) {
> +	if (!cpumask_equal(policy->related_cpus, em_span_cpus(em))) {
>  		pr_err("The span of pd %*pbl is misaligned with cpufreq policy %*pbl\n",
> -			cpumask_pr_args(to_cpumask(em->cpus)),
> +			cpumask_pr_args(em_span_cpus(em)),
>  			cpumask_pr_args(policy->related_cpus));
>  		return false;
>  	}
>  
>  	nr_levels = cpufreq_cdev->max_level + 1;
> -	if (em->nr_cap_states != nr_levels) {
> +	if (em->nr_perf_states != nr_levels) {
>  		pr_err("The number of cap states in pd %*pbl (%u) doesn't match the number of cooling levels (%u)\n",

s/cap states/performance states

> -			cpumask_pr_args(to_cpumask(em->cpus)),
> -			em->nr_cap_states, nr_levels);
> +			cpumask_pr_args(em_span_cpus(em)),
> +			em->nr_perf_states, nr_levels);
>  		return false;
>  	}

<snip>
> +static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> +				int nr_states, struct em_data_callback *cb)
>  {
>  	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
>  	unsigned long power, freq, prev_freq = 0;
> -	int i, ret, cpu = cpumask_first(span);
> -	struct em_cap_state *table;
> -	struct em_perf_domain *pd;
> +	struct em_perf_state *table;
> +	int i, ret;
>  	u64 fmax;
>  
> -	if (!cb->active_power)
> -		return NULL;
> -
> -	pd = kzalloc(sizeof(*pd) + cpumask_size(), GFP_KERNEL);
> -	if (!pd)
> -		return NULL;
> -
>  	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
>  	if (!table)
> -		goto free_pd;
> +		return -ENOMEM;
>  
> -	/* Build the list of capacity states for this performance domain */
> +	/* Build the list of performance states for this performance domain */
>  	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
>  		/*
>  		 * active_power() is a driver callback which ceils 'freq' to
> -		 * lowest capacity state of 'cpu' above 'freq' and updates
> +		 * lowest performance state of 'dev' above 'freq' and updates
>  		 * 'power' and 'freq' accordingly.
>  		 */
> -		ret = cb->active_power(&power, &freq, cpu);
> +		ret = cb->active_power(&power, &freq, dev);
>  		if (ret) {
> -			pr_err("pd%d: invalid cap. state: %d\n", cpu, ret);
> +			dev_err(dev, "EM: invalid perf. state: %d\n",
> +				ret);

Not easy to figure out which device has a problem with this. I'm
guessing you went that way since this is called before ida_simple_get() ?
Could that be refactored to make the error message more useful ?

>  			goto free_cs_table;
>  		}

<snip>
> +/**
> + * em_unregister_perf_domain() - Unregister Energy Model (EM) for the device
> + * @dev		: Device for which the EM is registered
> + *
> + * Try to unregister the EM for the specified device (it checks current
> + * reference counter). The EM for CPUs will not be freed.
> + */
> +void em_unregister_perf_domain(struct device *dev)
> +{
> +	struct em_device *em_dev, *tmp;
> +
> +	if (IS_ERR_OR_NULL(dev))
> +		return;
> +
> +	/* We don't support freeing CPU structures in hotplug */
> +	if (_is_cpu_device(dev))
> +		return;

Can we WARN() here ?

> +
> +	mutex_lock(&em_pd_mutex);
> +
> +	if (list_empty(&em_pd_dev_list)) {
> +		mutex_unlock(&em_pd_mutex);
> +		return;
> +	}
> +
> +	list_for_each_entry_safe(em_dev, tmp, &em_pd_dev_list, em_dev_list) {
> +		if (em_dev->dev == dev) {
> +			kref_put(&em_dev->kref, _em_release);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&em_pd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(em_unregister_perf_domain);

Otherwise this looks pretty good to me. So, with these small nits
addressed:

  Acked-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin
