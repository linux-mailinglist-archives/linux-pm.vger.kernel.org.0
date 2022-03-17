Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274D4DD10C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCQXGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 19:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiCQXGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 19:06:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFA2D8890
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:05:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt26so11488242lfb.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1LkRXG1wYA+PMPwi0rI4Ord/Tgqpg0iZrCPXqhvFo+k=;
        b=j1YPPQu+TN0pjRu3PrWy4qsTflBTWxdN5WyUo859qjU0OAZraqN834wYnPlZoyJWDI
         j2mwOAOgjXH+jclKkWQatyZQI2aqZAB8MBynArnDFbeZ4fDXPR9GDgWx0qZCy3kcd6KR
         aUlFoXI2HNU6wXqUhYsBQ7h4CaKw0MSOQJ+MSpl7tBV3ohJS1zRrAvK1uKEdUjvN7vOO
         ojleNOe4/fRDN5Lhez1ofQkXpFvT0JPN2wximVt+HjrVr1s+MZYEM2h3LTl5acUx9H3s
         fTVM9s6VtPk3JqWfTeMIOGhaDBghApKLw/QNIWoZdBAGkKoV1hRJHFv2hFCMYJMQ4Y2h
         T/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LkRXG1wYA+PMPwi0rI4Ord/Tgqpg0iZrCPXqhvFo+k=;
        b=V//0USYg5YCcJy/koSQivL9YhUxmUyZjg5OOJx0h2KxAlnCFEIFCX8oM/4GFou9/2m
         1hJ7EIRQOJgLK1RPft/EOt/9rt2+ZPuBmezAhCPpEcBe6TwERLRISnwL6j03kDACPpyO
         SJqA3TvkmMLkntCQrKN47txfVZpMOOJfSkxLFIqhmwLEc6q9dFsIzqhv4GfQDEE/d4PN
         H9ZyY0Q92mjJVYYGBEFZ5tT6AesfOvbG/woj+VMEpLE4cyXH/Nw4fCSmtnuS32Srgauk
         12dbOtuWVJAb1qACPT9kjr5smOPPF4FZo6K/+/I0Qb+T+UrHk3yakhl0BwZeaRsLAZuW
         jMjQ==
X-Gm-Message-State: AOAM533aDCtiG8o5oo4mcgWM6aT6VUXv4bscshSayCXG1jqi3w8uynlX
        Q8NKSFTUJpDjRXQIaxPMBPzZtw==
X-Google-Smtp-Source: ABdhPJyd2BAsrblXS6Rd0RMNTdxzSQ4sJa3deV59RUNUIR6CchNbcp4AhQsGVkmYX5NeUTWeI7PJ7g==
X-Received: by 2002:a05:6512:2828:b0:448:2339:591f with SMTP id cf40-20020a056512282800b004482339591fmr4182318lfb.274.1647558304278;
        Thu, 17 Mar 2022 16:05:04 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id u25-20020ac243d9000000b004483661cbc4sm575247lfl.145.2022.03.17.16.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:05:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] cpufreq: qcom-hw: provide online/offline
 operations
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-5-dmitry.baryshkov@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <21b0c0d3-6b3d-b991-7d17-6ce51711e10a@linaro.org>
Date:   Fri, 18 Mar 2022 01:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220309223938.3819715-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 3/10/22 12:39 AM, Dmitry Baryshkov wrote:
> Provide lightweight online and offline operations. This saves us from
> parsing all the resources each time the CPU is put online.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 39 +++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fe638e141003..d38b1552ec13 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -403,11 +403,12 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>   
> +static int qcom_cpufreq_hw_lmh_online(struct cpufreq_policy *policy);
> +
>   static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>   {
>   	struct qcom_cpufreq_data *data = policy->driver_data;
>   	struct platform_device *pdev = cpufreq_get_driver_data();
> -	int ret;
>   
>   	/*
>   	 * Look for LMh interrupt. If no interrupt line is specified /
> @@ -419,12 +420,21 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>   	if (data->throttle_irq < 0)
>   		return data->throttle_irq;
>   
> -	data->cancel_throttle = false;
> -	data->policy = policy;
> -
>   	mutex_init(&data->throttle_lock);
>   	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
>   
> +	return qcom_cpufreq_hw_lmh_online(policy);
> +}
> +
> +static int qcom_cpufreq_hw_lmh_online(struct cpufreq_policy *policy)
> +{
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	int ret;
> +
> +	data->cancel_throttle = false;
> +	data->policy = policy;
> +
>   	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
>   	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
>   				   IRQF_ONESHOT | IRQF_NO_AUTOEN, data->irq_name, data);
> @@ -441,10 +451,12 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>   	return 0;
>   }
>   
> -static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> +static int qcom_cpufreq_hw_lmh_offline(struct cpufreq_policy *policy)
>   {
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +
>   	if (data->throttle_irq <= 0)
> -		return;
> +		return 0;
>   
>   	mutex_lock(&data->throttle_lock);
>   	data->cancel_throttle = true;
> @@ -453,6 +465,8 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>   	cancel_delayed_work_sync(&data->throttle_work);
>   	irq_set_affinity_hint(data->throttle_irq, NULL);
>   	free_irq(data->throttle_irq, data);
> +
> +	return 0;
>   }
>   
>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> @@ -567,6 +581,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	return ret;
>   }
>   
> +static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
> +{
> +	return qcom_cpufreq_hw_lmh_online(policy);
> +}
> +
> +static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	return qcom_cpufreq_hw_lmh_offline(policy);
> +}
> +
>   static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>   {
>   	struct device *cpu_dev = get_cpu_device(policy->cpu);
> @@ -576,7 +600,6 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>   
>   	dev_pm_opp_remove_all_dynamic(cpu_dev);
>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> -	qcom_cpufreq_hw_lmh_exit(data);
>   	kfree(policy->freq_table);
>   	kfree(data);
>   	iounmap(base);
> @@ -608,6 +631,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>   	.get		= qcom_cpufreq_hw_get,
>   	.init		= qcom_cpufreq_hw_cpu_init,
>   	.exit		= qcom_cpufreq_hw_cpu_exit,
> +	.online		= qcom_cpufreq_hw_cpu_online,
> +	.offline	= qcom_cpufreq_hw_cpu_offline,
>   	.register_em	= cpufreq_register_em_with_opp,
>   	.fast_switch    = qcom_cpufreq_hw_fast_switch,
>   	.name		= "qcom-cpufreq-hw",
> 

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
