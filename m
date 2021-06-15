Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE0D3A7656
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 07:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFOFSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 01:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFOFSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 01:18:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535DC0613A2
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 22:16:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k5so11093276pjj.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 22:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MF/9GnXqxvuZpa6ITiz3hC8SrxhwYLiu/agW3G5WgBY=;
        b=sjZv+V7kIk0a7879L2xpzGWf8dhpSEDL+ygwsf10R4byp60E4h+FhJuiQb1i5PDVC7
         tVST2s3orPfaYP4eWk2d3qoq8irlNmlwnkEke6k/G/Ky2nyVQMml4K4Z2Zroc3WqNkJu
         QtfZaoOCvsAoKwp6nag4+sy8s6V6BammMpYkIjA55fdYPMX7RVZysXT9pyACQLQdrNX9
         luFd4r465tBSQ+qjfEpgR1wYiwDYo8bwci1v8D1PF7gzpFF3qRjMu+SQq2VtmtiYlUpN
         Rm71AIKWaiqMI2xBQyeFAuMUe/oHy2g11fgoGJB+jTKrG7UOmAVHMirKcJYo5Ugki78y
         AjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MF/9GnXqxvuZpa6ITiz3hC8SrxhwYLiu/agW3G5WgBY=;
        b=jwI8DtxArBcHKjYOUAfAmf1r7awFImUekkX/1Mlk8Xkb2HfLkbJLekEG5eQenNrEyn
         gSVtZ+y1QOaipxaLlldExQWM6lTaY1/nlKbdy7moToS0CefRLmNdN69Xz46cC7RGwmUQ
         /U89NVy7wvt7trGvLz6rz2iBs6BLOrvCRaPkN1whB+76NBpb7dt+Kwd9RoOjp6Udb2as
         j+Z+ZlREq5lph8qPDigux5HzpxYNrBRyWIKbptdb8/4JttJyp9YK+NiuZIIQN0IYUI+u
         QBMRCNgMbqg1o7PNNpWTrwnCZ8QDFRPzRQfmGsNCUo96rR31EUHp4BA8/8udAoc3hwv0
         kNGQ==
X-Gm-Message-State: AOAM530rNevGXxQ2haQPOCT3rsQmcD235FsBLjza3i0O8FSvW6hwQfRx
        oe7ZI32CqO6WacRuujsVnKs0FA==
X-Google-Smtp-Source: ABdhPJwkqPSy21YHAlu9KXouDIGVIWiNd+lplxfQA1z0yDh03lzNgcNVye1XHseNyBqlgDKyYlw5Sg==
X-Received: by 2002:a17:902:aa04:b029:ec:f779:3a2b with SMTP id be4-20020a170902aa04b02900ecf7793a2bmr2674218plb.44.1623734178006;
        Mon, 14 Jun 2021 22:16:18 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id a66sm14765359pfb.162.2021.06.14.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:16:17 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:46:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
Message-ID: <20210615051615.kiec62zmxomomv2l@vireshk-i7>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-4-thara.gopinath@linaro.org>
 <20210614103141.nnrd4sn756os52wh@vireshk-i7>
 <5a8f1622-4964-a8e1-f8a1-1dbd38948d45@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8f1622-4964-a8e1-f8a1-1dbd38948d45@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-06-21, 21:58, Thara Gopinath wrote:
> On 6/14/21 6:31 AM, Viresh Kumar wrote:
> > On 08-06-21, 18:29, Thara Gopinath wrote:
> > > +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> > > +{
> > > +	struct cpufreq_policy policy;
> > > +	struct dev_pm_opp *opp;
> > > +	struct device *dev;
> > > +	unsigned long max_capacity, capacity, freq_hz;
> > > +	unsigned int val, freq;
> > > +
> > > +	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
> > > +	freq = qcom_lmh_vote_to_freq(val);
> > > +	freq_hz = freq * HZ_PER_KHZ;
> > > +
> > > +	/* Do I need to calculate ceil and floor ? */
> > 
> > You don't know ?
> 
> stray comment! Will remove it.
> 
> > 
> > > +	dev = get_cpu_device(cpumask_first(data->cpus));
> > > +	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
> > > +	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
> > > +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
> > > +
> > > +	data->throttled_freq = freq_hz / HZ_PER_KHZ;
> > > +
> > 
> > What exactly are we trying to do here ? A comment would be good as
> > well.
> 
> You want me to put a comment saying converting frequency in hz to khz ?

Not that, but for the entire routine. What exactly are we looking to
do here and why?

> > 
> > > +	cpufreq_get_policy(&policy, cpumask_first(data->cpus));
> > > +
> > > +	/* Update thermal pressure */
> > > +	max_capacity = arch_scale_cpu_capacity(cpumask_first(data->cpus));
> > 
> > Set capacity of a single CPU from a policy ?
> 
> Get maximum capacity of a cpu.

Ahh, I thought you are setting it :(

> > 
> > > +	capacity = data->throttled_freq * max_capacity;
> > > +	capacity /= policy.cpuinfo.max_freq;
> > > +	/* Don't pass boost capacity to scheduler */
> > > +	if (capacity > max_capacity)
> > > +		capacity = max_capacity;
> > > +	arch_set_thermal_pressure(data->cpus, max_capacity - capacity);
> > 
> > You should really be using policy->cpus instead of allocating
> > data->cpus..
> 
> Yes I should be. But I still need data->cpus to get the policy.

From the comment which comes later on, you shall get the policy here
anyway.
 
> > > +}
> > > +
> > > +static void qcom_lmh_dcvs_poll(struct work_struct *work)
> > > +{
> > > +	struct qcom_cpufreq_data *data;
> > > +
> > > +	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
> > > +
> > > +	qcom_lmh_dcvs_notify(data);
> > 
> > You should really move the below stuff the disable_irq_nosync(), it
> > will make your life easier.

Damn, s/disable_irq_nosync/qcom_lmh_dcvs_notify/

> I don't understand your comment here. I want to disable irq. call notify.
> Start polling. And in polling I want to call notify and if the thermal event
> has passed stop polling else continue polling.

Yeah, I messed up in the comment. I was asking to move the enable-irq
and mod_delayed_work to qcom_lmh_dcvs_notify() itself.

> > > +	/**
> > > +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
> > > +	 * polling and switch back to interrupt mechanism
> > > +	 */
> > > +	if (data->throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(data->cpus)))
> > > +		/* Clear the existing interrupts and enable it back */
> > > +		enable_irq(data->lmh_dcvs_irq);
> > > +	else
> > > +		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
> > > +				 msecs_to_jiffies(10));
> > > +}
> > > +
> > > +static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
> > > +{
> > > +	struct qcom_cpufreq_data *c_data = data;
> > > +
> > > +	/* Disable interrupt and enable polling */
> > > +	disable_irq_nosync(c_data->lmh_dcvs_irq);
> > > +	qcom_lmh_dcvs_notify(c_data);
> > > +	mod_delayed_work(system_highpri_wq, &c_data->lmh_dcvs_poll_work, msecs_to_jiffies(10));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> > >   	.reg_enable = 0x0,
> > >   	.reg_freq_lut = 0x110,
> > >   	.reg_volt_lut = 0x114,
> > > +	.reg_current_vote = 0x704,
> > 
> > Should this be a different patch ?
> 
> Why ? This is the register to read the throttled frequency.

Okay, it looked this is separate. Leave it.

> > > +		ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
> > > +				       0, "dcvsh-irq", data);
> > 
> > I would rather pass policy as data here.
> 
> So policy for a cpu can change runtime, right ?

No, it is allocated just once.

-- 
viresh
