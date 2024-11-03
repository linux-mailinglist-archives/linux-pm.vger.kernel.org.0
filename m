Return-Path: <linux-pm+bounces-16905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88B9BA655
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316C3281574
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376E184522;
	Sun,  3 Nov 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmuEO33r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A617CA1F
	for <linux-pm@vger.kernel.org>; Sun,  3 Nov 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646784; cv=none; b=aNYc+qhePFbjKdLa8VrmxuQQZvQdJ0Ra+qetoA7+08brzsD36yz0zQurlgckX+v63XjOBwG4Mrn6BkxgJdZtdNPxtwsdhG/SC8BAe4Uq8MQ6xQS8Bh1uTcgTRLuO+VsuPIcBqgCZz6shk3k3C2Bt+3BlBy+QQX0zFDbpfgKOKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646784; c=relaxed/simple;
	bh=wYAoJRD7v8jrHJmEguNTQmd3c50c8FjNbmBzvtkQOFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgqJFxv2nWrsDTRqYdDLp0nV5mRTbCj9o+MnT9l/e2Ev+o5w0RK1MiLM20YnvkgHkEYOzTY3fWm7+zDft6MbbvzRVyOb7RaSbQYEU7US4TmB7RKQ+h1GZnj4b34O6CwHP1H66Zp8bhZGTIi+qly25mgEfgIO9weFvMJN1Te1KPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmuEO33r; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so2352435a91.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Nov 2024 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730646782; x=1731251582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHQktcKdIhna5z27pQ3PuyXhlPaLntIaSmvbBw7PwoE=;
        b=KmuEO33ruVGkb98SLj0/8QwsYF8UCpg2ZnuF8gixbV9yOGxOOAjaWkD11fs+B88fyg
         gIkYtCcdVWgHBSTRvjc3fpdZH/586CRwDV1T8/9k8b1qwsYOGCuNg/jMFDFQri9+02pe
         4Epb/FJEt3LITMpeVtCDIjKLTnX49poPfTRBIoB4TWZHgrXhadgjIBt3XgAzWTY5n6AM
         vvaWCcBJATS9yXY087GCjCXzIBvxv8P+CZXCijntxBx808anG7vefZqtPKU8pDNkZ3zN
         l5igR3zKEynRk1jUongAU31yy01QveR8D4zf+f4j7yBFP7f0vn8JSxIj+dHg3BbmWnSd
         Eocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646782; x=1731251582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHQktcKdIhna5z27pQ3PuyXhlPaLntIaSmvbBw7PwoE=;
        b=N8U9rJxyvUY8mgEN3DLLjtLUl4NfbNZJo3EeUJY2gAtkqsCyH3g2kgts8giWfaumgD
         XyGVgwCP6MAF+f4a5oWEnjOML69C5GF+IfPDNwn3wBQkhnPoFBQS8v1Q6/OpW6EN3+wF
         e6egL1UwMgQ6p7nViuEr9xkel/gbCCsu69brjHsLRNTz9W7vrO/yvB0ctmCDp5rYlyX5
         zo5cKWUtpqmg8p9n4gypI7D7po/nsqEdNfHPqnv+aDtBgxZbFOOI+jqcwYFhiAkxa3WT
         kkZEv9HE7M5BdUD3NY4Ijd/eNc0wFINECIgq23ADDmRAx6qcj+kk56XusUqDS79h0Nvm
         gXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhpO+bMl+DiDyCgIg8IVNoLIOqt++dkIWzodUFpL9hdA9D8HgYK16hj30BfH70kJ8aCcBmNUohw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTYO9xlF7ZoJ3b5IAys4pSaF1qyOkET6sLUqtuqE8tdMoKxU8
	9g05rT39U9kJ3FRkHXy5+RjChGpqWznsAI3Y3T7t/cI0Rn/9eBqKmYTycc1ZgEy8BsMkwNQtJnQ
	4jAjQ7Mv9MBCv/7Gm8Y5XQ+qLjGJoCUt4EnR5zw==
X-Google-Smtp-Source: AGHT+IHRIh1ITCIAJ4M7w1UM8me5MLqRixS/tsHhgXfawiZDUkumg9GSz+T7fPFwKnIa+4k1jBzouIXTP6K8KhWz3Do=
X-Received: by 2002:a17:90b:4a86:b0:2e1:ce7b:6069 with SMTP id
 98e67ed59e1d1-2e94c529acamr15224146a91.33.1730646782163; Sun, 03 Nov 2024
 07:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031132745.3765612-1-quic_sibis@quicinc.com> <20241031132745.3765612-3-quic_sibis@quicinc.com>
In-Reply-To: <20241031132745.3765612-3-quic_sibis@quicinc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 3 Nov 2024 16:12:50 +0100
Message-ID: <CAKfTPtDNBPC8QQzFBNDKNW_sJfkoShSsxo7iMC8Wga+wixyHzA@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] cpufreq: scmi: Register for limit change notifications
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 14:28, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>
> v7:
> * Add a new request instead of reusing the max_freq_req [Vincent]
> * Use the non-devm versions of register/unregister of event notifier
>   since we have to remove them when the cpus get removed anyway.
> * Add new patch to fix cleanup path on boost enablement failure.
>
>  drivers/cpufreq/scmi-cpufreq.c | 51 ++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 07d6f9a9b7c8..ff13f7d4b2c9 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/types.h>
> @@ -25,7 +26,10 @@ struct scmi_data {
>         int domain_id;
>         int nr_opp;
>         struct device *cpu_dev;
> +       struct cpufreq_policy *policy;
>         cpumask_var_t opp_shared_cpus;
> +       struct notifier_block limit_notify_nb;
> +       struct freq_qos_request limits_freq_req;
>  };
>
>  static struct scmi_protocol_handle *ph;
> @@ -174,6 +178,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>         NULL,
>  };
>
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +       struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +       struct scmi_perf_limits_report *limit_notify = data;
> +       struct cpufreq_policy *policy = priv->policy;
> +       unsigned int limit_freq_khz;
> +       int ret;
> +
> +       limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +
> +       policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);

I don't think that the above is needed or correct, the cpufreq qos
notifier will take care of updating policy->max with handle_update()

> +
> +       ret = freq_qos_update_request(&priv->limits_freq_req, policy->max);
> +       if (ret < 0)
> +               pr_warn("failed to update freq constraint: %d\n", ret);
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
> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -294,6 +318,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>                 }
>         }
>
> +       ret = freq_qos_add_request(&policy->constraints, &priv->limits_freq_req, FREQ_QOS_MAX,
> +                                  FREQ_QOS_MAX_DEFAULT_VALUE);
> +       if (ret < 0) {
> +               dev_err(cpu_dev, "failed to add qos limits request: %d\n", ret);
> +               goto out_free_table;
> +       }
> +
> +       priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +       ret = sdev->handle->notify_ops->event_notifier_register(sdev->handle, SCMI_PROTOCOL_PERF,
> +                                                       SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +                                                       &priv->domain_id,
> +                                                       &priv->limit_notify_nb);
> +       if (ret)
> +               dev_warn(&sdev->dev,
> +                        "failed to register for limits change notifier for domain %d\n",
> +                        priv->domain_id);
> +
> +       priv->policy = policy;
> +
>         return 0;
>
>  out_free_table:
> @@ -313,7 +356,13 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>         struct scmi_data *priv = policy->driver_data;
> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>
> +       sdev->handle->notify_ops->event_notifier_unregister(sdev->handle, SCMI_PROTOCOL_PERF,
> +                                                           SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +                                                           &priv->domain_id,
> +                                                           &priv->limit_notify_nb);
> +       freq_qos_remove_request(&priv->limits_freq_req);
>         dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>         dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>         free_cpumask_var(priv->opp_shared_cpus);
> @@ -372,6 +421,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>         if (!handle)
>                 return -ENODEV;
>
> +       scmi_cpufreq_driver.driver_data = sdev;
> +
>         perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>         if (IS_ERR(perf_ops))
>                 return PTR_ERR(perf_ops);
> --
> 2.34.1
>

