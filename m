Return-Path: <linux-pm+bounces-8237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84558D16EB
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32143B23EB2
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55613D242;
	Tue, 28 May 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZSVBu3V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFD4EB2E
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887329; cv=none; b=HUz5w+wt01AAUKXWMAw3Kmk1ORqy9GKegMRLmxQnDIdumozsCEztLjLtRkqxyYHU+oybch6vg3txVsz+uyOgr0199ZwcuytODcq5Z7+dJ+zmoEF++L8UrmtMi9OAU+BAi/p0UFoWne42XxcaupT8zBg69DOHJS4VrQax0cyxqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887329; c=relaxed/simple;
	bh=pyP8rDh+w0C8gcPL7MoR95ziGLdrYH6TSPb+59IRlkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iv50g40b1xYy13A5Xk9tgLNmSfYqRSrQZ4LFkZKxQm/OsvfJ629/m4FoW/LegVJCl93e2+PVCf36DhOLiKh9wIWlb9YuIE+elVMIvPrm/+9kcsvL/THyw1u8RUCk60EuZ5aLdxR0776WvFnyFVEnzbgctGlJYs8GyT3QNHYjYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZSVBu3V; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-681953ad4f2so454437a12.2
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716887327; x=1717492127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzsEUsWkD7l7X1wafx1iQHAi5RdHqsVhvTOLNp+TkVA=;
        b=UZSVBu3VdiG6Tba7Inw+HkssZLIH04SwbZZPu5efeXW2lwbxd3uEsD7gCZe42Duo//
         doVpqVXgVP0Q4jQ+9jVDi2glPEGvYvt16Rqn8eDlMWqhWk39RPAC9ljzFJyOnd6DL50/
         hyGSaQXf92zxDtF/N6ww7Ktg7++4YarhNSHRp2u+fT+aA6YyKMbOzIeiJvojTq9QsbKC
         kY6qF93TdmghxY9/GjswYcONMsnfyXwpJOxoElhlzddqKyV4c/D+0BZDOQzMPmPLUotn
         sSmSdQcPN2LIupLhIWqhyMIalHI9n6KUMjIeQZC0RXaFBc2wYZtwXqUfsYCDOU2zWeia
         8I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716887327; x=1717492127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzsEUsWkD7l7X1wafx1iQHAi5RdHqsVhvTOLNp+TkVA=;
        b=GueSBRPOvcQ5JackI+QsMMR4cA0+UQFPLePzC+b2xzMtxN41joiS9aqWuKArvHaNni
         pYhCCmnB7Nd6XAC7bCe4zUHPlQ8FLVD/KBxVDWo9PIEQZN+/Vvq1mKXxGULw8h+TP2z9
         HH9aUGfVnktVYNYMLDktuLJ2R+ef7iMer7SUKAMknAHPt21mgGSIH6d17tFvTUT/7V9D
         kCHIzlcYPvKS2MaYXEH510BMJVkJoiuXDoGm046aZ3UR4PfVe2k8crYkAz8SRhWOane7
         noKIRaEwLhGR/8VaPjFWyxkvHsB2YetdrMpWrvOUPStccRBfIMB+3Ir0xqzD3mjoOd4k
         c2mg==
X-Forwarded-Encrypted: i=1; AJvYcCVdEmOhGM5a0imkgwZOEebYSAou4DXAcknpvwbkqrsqHI2iah1sX2FgzEWQ1vkyAXBI5OglTtalIejbgnpCl7wgAxG7PsjbPBI=
X-Gm-Message-State: AOJu0Yx6zwxHqzgcxCYBikQp8v1Nlw9B+RMkJxE51ovfl20uphBi1eGq
	6OSTLHWsDorynmvkwsMQiGZdS3UD0CYj7p9lenc7I6QYxfS7KcRbGGByYX/kN61wBZHnuHlAUxk
	Zm1RxpW/h/kJu1PMg83WvLLtA6LdvkHd02HIHRQ==
X-Google-Smtp-Source: AGHT+IEpp2xFUfFsrKyY0Fn1X3JerpHWf7v4Pyi+GEGyAWb87x5Vdhb6hTTfWmqiLOeY09bymWn5SMCp3zl5C/IeOp8=
X-Received: by 2002:a17:90a:e558:b0:2bd:b43f:4b with SMTP id
 98e67ed59e1d1-2bf5f2053abmr10123355a91.31.1716887326972; Tue, 28 May 2024
 02:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328074131.2839871-1-quic_sibis@quicinc.com> <20240328074131.2839871-3-quic_sibis@quicinc.com>
In-Reply-To: <20240328074131.2839871-3-quic_sibis@quicinc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 28 May 2024 11:08:35 +0200
Message-ID: <CAKfTPtDtnCm2NqhiXZLODXH5A9Hc9ryP==3LFZUcNnKE4J+PEg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Register for limit change notifications
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sibi,

On Thu, 28 Mar 2024 at 08:42, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v4:
> * Use a interim variable to show the khz calc. [Lukasz]
> * Use driver_data to pass on the handle and scmi_dev instead of using
>   global variables. Dropped Lukasz's Rb due to adding these minor
>   changes.
>
>  drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 3b4f6bfb2f4c..d946b7a08258 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -21,11 +21,18 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>
> +struct scmi_cpufreq_driver_data {
> +       struct scmi_device *sdev;
> +       const struct scmi_handle *handle;
> +};
> +
>  struct scmi_data {
>         int domain_id;
>         int nr_opp;
>         struct device *cpu_dev;
> +       struct cpufreq_policy *policy;
>         cpumask_var_t opp_shared_cpus;
> +       struct notifier_block limit_notify_nb;
>  };
>
>  static struct scmi_protocol_handle *ph;
> @@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>         NULL,
>  };
>
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +       struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +       struct scmi_perf_limits_report *limit_notify = data;
> +       struct cpufreq_policy *policy = priv->policy;
> +       unsigned int limit_freq_khz;
> +
> +       limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +
> +       policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> +
> +       cpufreq_update_pressure(policy);

I noticed your patch while looking for other things in the archive but
I don't think this is the right way to do it.

cpufreq_update_pressure() aims to set to the scheduler the aggregation
of all cappings set to cpufreq through the pm_qos and
freq_qos_add_request(). Calling this function directly in scmi
notification callback will overwrite the pm_qos aggregation. And at
the opposite, any update of a pm_qos constraint will overwrite scmi
notification. Instead you should better set a pm_qos constraint like
others

> +
> +       return NOTIFY_OK;
> +}
> +
>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         int ret, nr_opp, domain;
> @@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>         struct device *cpu_dev;
>         struct scmi_data *priv;
>         struct cpufreq_frequency_table *freq_table;
> +       struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>                 }
>         }
>
> +       priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +       ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
> +                                                       SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +                                                       &domain,
> +                                                       &priv->limit_notify_nb);
> +       if (ret)
> +               dev_warn(cpu_dev,
> +                        "failed to register for limits change notifier for domain %d\n", domain);
> +
> +       priv->policy = policy;
> +
>         return 0;
>
>  out_free_opp:
> @@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>         int ret;
>         struct device *dev = &sdev->dev;
>         const struct scmi_handle *handle;
> +       struct scmi_cpufreq_driver_data *data;
>
>         handle = sdev->handle;
>
>         if (!handle)
>                 return -ENODEV;
>
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->sdev = sdev;
> +       data->handle = handle;
> +       scmi_cpufreq_driver.driver_data = data;
> +
>         perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>         if (IS_ERR(perf_ops))
>                 return PTR_ERR(perf_ops);
> --
> 2.34.1
>
>

