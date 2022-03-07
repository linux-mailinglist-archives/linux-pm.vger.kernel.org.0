Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03464D0B45
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 23:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiCGWjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbiCGWji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 17:39:38 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DA22BD5
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 14:38:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id s35-20020a0568302aa300b005b2463a41faso1620860otu.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTF9vrsd2i2cuIT7pb0cvt5XJ2Vw/Z8/+uLJ5S39AOY=;
        b=MrlTo/nnUkfTj6vgECUjzloL6+twkSz5Jnos0f5W1kje5brJsb8HNh8lRUAJu+opEt
         +grGx2HfhLn51GYKhDGksdTw+S33cptspCCjvJJRyV6cRMuVP6IoF1mWVYdSxP5Fs0UK
         FOrplOH7tyvcjUPBudWw7Td+e4/BfUfNgXKNTgZ20mDlTAGg6D1lBcShr/Ld36YokAYz
         fZbHdZOKX6PKzJg4xXsi2WewSKm4Fp27rlwG+UK8S0PwJXouSFnnarZibRqjsiqFe19v
         ISzH4aRK36O8Js8rjXR2L6JIgbANbIkSs0isDhnRoqX9WCVlhykbvxHDOxL25xM3Vu2I
         idPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTF9vrsd2i2cuIT7pb0cvt5XJ2Vw/Z8/+uLJ5S39AOY=;
        b=Lvr3xPW6XNgGDGGun3EXhdZ1dNmjA0Jle6vgh7QNWVa2lf6rMTI7x+LBn9HgDO81mz
         M3mnWgNHd2fMdnAQxp+ifhbai/kP4w/RE4+D+EqAAa3ZhtwIDtPJKSvrFyX2LiXGOW54
         FOdaeRMnFb81DDfbg+I2YGuaork60PW2ISex0K7jPQHa5rrrjmIZ0mg8rLCI0/P4ukbW
         5SXHaMLsBfUcurimvBVcWjmafqRfopST/ede3v7lArFhJ3KIwmFRmr2FKW/kBlTqmcSm
         Z0vrNpBwa0OdlpMqgxOoo48b85J7Fe2mY1RbX53Rl1rwS4GnYKpmr59XpEWgfVzAATLl
         ETwA==
X-Gm-Message-State: AOAM533vu5eK2ys2AIsfkxGaIIMLqXkwsPPhiS2aEAbYYVxd7S3P0mda
        R3K6aLrq5MdrqJXAyTCFElF955CNoHpl1Q==
X-Google-Smtp-Source: ABdhPJwjoTy/Td0Di42nEQO6s02K5f4h78ONVIaG8dslj0/IgWssxJEoLszm7IfYw5OY2HDq4XIJmw==
X-Received: by 2002:a05:6830:14d7:b0:5b2:2ca5:c6de with SMTP id t23-20020a05683014d700b005b22ca5c6demr4573735otq.133.1646692721428;
        Mon, 07 Mar 2022 14:38:41 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id c13-20020a056830314d00b005b2144c5f8esm4017344ots.81.2022.03.07.14.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:38:40 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:40:25 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] cpufreq: qcom-hw: provide online/offline operations
Message-ID: <YiaJ2cF6SkQo3Eqz@ripper>
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
 <20220307153050.3392700-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307153050.3392700-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 07 Mar 07:30 PST 2022, Dmitry Baryshkov wrote:

> Provide lightweight online and offline operations. This saves us from
> parsing and tearing down the OPP tables each time the CPU is put online
> or offline.

Isn't that a slight understatement? Doesn't it also save us from e.g.
ioremapping the memory, traversing DT to discover the policy's
related_cpus and requesting the dcvs interrupt?

I like the idea of getting these things out of the init/exit path. I do
however think that we could move most of this to probe time, and thereby
be able to rely on devm operations for many of these things.

That said, I still like your idea of having a fast path for this...

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 580520215ee7..12b67f16b78f 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -424,10 +424,26 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	return 0;
>  }
>  
> -static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> +static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
>  {
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	int ret;
> +

For backwards compatibility reasons it's valid to not have
data->throttle_irq. This will however cause irq_set_affinity_hint() to
return -EINVAL and we'll get a print.

So you should handle that gracefully.

> +	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
> +			data->irq_name, data->throttle_irq);
> +
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +
>  	if (data->throttle_irq <= 0)
> -		return;
> +		return 0;
>  
>  	mutex_lock(&data->throttle_lock);
>  	data->cancel_throttle = true;

This will mark the throttle as cancelled, you need to clear this as
you're bringing the policy online again.

> @@ -435,6 +451,12 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>  
>  	cancel_delayed_work_sync(&data->throttle_work);
>  	irq_set_affinity_hint(data->throttle_irq, NULL);

You don't disable_irq(data->throttle_irq) here. I think
qcom_lmh_dcvs_notify() will be unhappy if we get thermal pressure from a
policy with no cpus?

Note though that you can't enable it in online(), as it will be enabled
in ready()...

> +
> +	return 0;
> +}
> +
> +static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> +{
>  	free_irq(data->throttle_irq, data);

As above, you should treat throttle_irq <= 0 gracefully.

Regards,
Bjorn

>  }
>  
> @@ -588,6 +610,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
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
