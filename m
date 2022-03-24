Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A84E66A5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Mar 2022 17:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiCXQI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Mar 2022 12:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351558AbiCXQI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2022 12:08:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7606A051
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2022 09:06:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 12so5311681oix.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2022 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndopoaQxbjUpH+KO21aa7+zGRJVnKw1Lny6N5VHvt1w=;
        b=d1qf+hBkFVQGwQVw4Kn92O/e1UaYfQtaekGJ9BIdAsugoXAwvYGifna8Vov8BFDIR3
         JZMmLzaQzH9kjEwvYGxrRoy83kwkyQhlrQ6ylw1KY3nQ/Bu1nyKATLsIT3W40g2xC/Wd
         uqoCh25FfVFvtfkQ5XIgBkP/uUvCnOjtP49NzHyhiKF5GNIcWPfL72o0qmdS8XaiMTVv
         yOBaiNhvJUxnnpit5+b8car22XupljXINPsfwUbh2BV0fHbUnc1scqzdW0SIrrNFNnFw
         M3AcEk6xnXQo8+ZWy7wKv87gA9QVzNycQEvSCiaE0n2k++orLLMGjm10AEpl+fBtTEti
         vhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndopoaQxbjUpH+KO21aa7+zGRJVnKw1Lny6N5VHvt1w=;
        b=Quxasv1JJlL4ONg4QMpoihYM6bRnYPom0bsI7L4LQJNT+o0FLUGJ8ch//aM088QM1c
         ljoKul9pNl6lgH/dC/QUFjePLY+x3foAEoVzw07+bbLgmvWjoETttxan0XUiePW6bfNJ
         fZPvgCtrcrLo7ptUhhyy2Dw+zCO+SZghKjPvFe8uDr8KzrA5FtnGvMbMk+MKJ3EUZfYQ
         Y1GfOiE281BEfTAtlxP6SZMovgIPKyB2nY6b4l5wNu7dY6TzSYtpY6dMh/3lYLNDa8I6
         VArfM49V/3BLIFjy5iPRZGsV2rfhqHL6WhmCIJKZrYK+T2qbRECeXcm6INnRxKyebBe+
         gODw==
X-Gm-Message-State: AOAM533FZPHjC/UQ/kkfG/awttNU5MmMhvLXOckN+BNYuVUF2OmqDpi+
        gDbutGk+h1K4aB1GiDmhDtnbsA==
X-Google-Smtp-Source: ABdhPJytPuzv/6r6jstRqMjvrBI3761nE2S1zA1MHV3c2CSju6k+6dsid7r1sgRJT0prDNof5ShKJg==
X-Received: by 2002:a54:4408:0:b0:2ec:b7d0:11e9 with SMTP id k8-20020a544408000000b002ecb7d011e9mr3005722oiw.91.1648138010157;
        Thu, 24 Mar 2022 09:06:50 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 12-20020a05687012cc00b000de97cc1beesm517226oam.43.2022.03.24.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:06:49 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:08:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: qcom-hw: provide online/offline
 operations
Message-ID: <YjyXatXzL8GDrcw0@ripper>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309223938.3819715-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 09 Mar 14:39 PST 2022, Dmitry Baryshkov wrote:

> Provide lightweight online and offline operations. This saves us from
> parsing all the resources each time the CPU is put online.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I think the other 3 patches are -rc material, this seems like v5.19.

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 39 +++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fe638e141003..d38b1552ec13 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -403,11 +403,12 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>  
> +static int qcom_cpufreq_hw_lmh_online(struct cpufreq_policy *policy);
> +
>  static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  {
>  	struct qcom_cpufreq_data *data = policy->driver_data;
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> -	int ret;
>  
>  	/*
>  	 * Look for LMh interrupt. If no interrupt line is specified /
> @@ -419,12 +420,21 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	if (data->throttle_irq < 0)
>  		return data->throttle_irq;
>  
> -	data->cancel_throttle = false;
> -	data->policy = policy;
> -
>  	mutex_init(&data->throttle_lock);
>  	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
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
>  	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
>  	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
>  				   IRQF_ONESHOT | IRQF_NO_AUTOEN, data->irq_name, data);
> @@ -441,10 +451,12 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	return 0;
>  }
>  
> -static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> +static int qcom_cpufreq_hw_lmh_offline(struct cpufreq_policy *policy)
>  {
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +
>  	if (data->throttle_irq <= 0)
> -		return;
> +		return 0;
>  
>  	mutex_lock(&data->throttle_lock);
>  	data->cancel_throttle = true;
> @@ -453,6 +465,8 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>  	cancel_delayed_work_sync(&data->throttle_work);
>  	irq_set_affinity_hint(data->throttle_irq, NULL);
>  	free_irq(data->throttle_irq, data);
> +
> +	return 0;
>  }
>  
>  static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> @@ -567,6 +581,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
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
>  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev = get_cpu_device(policy->cpu);
> @@ -576,7 +600,6 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> -	qcom_cpufreq_hw_lmh_exit(data);
>  	kfree(policy->freq_table);
>  	kfree(data);
>  	iounmap(base);
> @@ -608,6 +631,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.get		= qcom_cpufreq_hw_get,
>  	.init		= qcom_cpufreq_hw_cpu_init,
>  	.exit		= qcom_cpufreq_hw_cpu_exit,
> +	.online		= qcom_cpufreq_hw_cpu_online,
> +	.offline	= qcom_cpufreq_hw_cpu_offline,
>  	.register_em	= cpufreq_register_em_with_opp,
>  	.fast_switch    = qcom_cpufreq_hw_fast_switch,
>  	.name		= "qcom-cpufreq-hw",
> -- 
> 2.34.1
> 
