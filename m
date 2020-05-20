Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17321DA98F
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 06:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETE7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 00:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgETE7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 00:59:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C2AC061A0E
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:59:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so842280plr.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUe61dQ2rATp0g2fVzkgSjry1iA6cICVHnLw1uv8pQo=;
        b=mV33gjoe3gfJjgsWMj0D1BkuNrrlvxVP2//X4rVJg3pnvhEiTuaVXR20j9q8mXKPTf
         vzn/v/BXrr8ltlm2z4zZzpmZHkaqA3aP2+lvK+wJF/mLZG0dh4P5k2699yiPSVzLTwmL
         m8uJUGPJDGoyauejydfLol7ikLOXABWjilNkJHJhb4YEEdjeXuTEdsDw88JfaOSnw5aN
         YfV4iPg70SJin4nljODK6VyC1Plahclp7ExBTyBzZ2T/Mzm5m83yyKZut+Ui+Pttstov
         AKIKAsecCxPDbUuBgxc0MMV1F0k2EGFGoiA+E6r5OJ262l89HjtbaMy3sLY3p1kUkjru
         R/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUe61dQ2rATp0g2fVzkgSjry1iA6cICVHnLw1uv8pQo=;
        b=NHDYiN6WHSLoUip6WhOkUNBXu49xvx9qre4jE5LdFhpYGzQhdvCIgBhD1ph0rAaIMt
         CLduJbOaj2Jnf12aMzKOfLVzJrotKSZqozXSIBMSDAWzfoDrDaVX5OfAKX65uF79TI2D
         iE6SQtOBlC5j8syssJQFSlu1AOAFbknP3pIVC5rf3hGCGK00Ol62oGCIfFkXLCfPEC/g
         gUERng+otFvAlTxMmX53OVsut2ETHXOOnZcuMV6KP1Ef+dh+6fEjffLLFglYDjRAUDlL
         ASmjtwQCL42WYjwLwKvcJ8dsSkxlx84U6xEIcndfoUeGKcBnBfIhbA7z3GZLEt8ejtJR
         l3HQ==
X-Gm-Message-State: AOAM531Wp8whQEUQGbK+cluMVU1PHPv7UHzOIRX+Q5Hdo8H7LPY9PoLz
        IUO1slOtmPPAzcVzZ08nNyOZJA==
X-Google-Smtp-Source: ABdhPJznzDJNUdhD5z0jGMVi+d7HROyOCPena41ltLDgm7oZ3XNWA9W3k+3iz8MjCmRep0yVm0J7fg==
X-Received: by 2002:a17:90b:4c88:: with SMTP id my8mr3180471pjb.176.1589950754061;
        Tue, 19 May 2020 21:59:14 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id f6sm915490pfd.175.2020.05.19.21.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 21:59:13 -0700 (PDT)
Date:   Wed, 20 May 2020 10:29:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] cpufreq: change '.set_boost' to act on only
 one policy
Message-ID: <20200520045911.amww3nm3e7cezcbf@vireshk-i7>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-05-20, 19:41, Xiongfeng Wang wrote:
> Macro 'for_each_active_policy()' is defined internally. To avoid some
> cpufreq driver needing this macro to iterate over all the policies in
> '.set_boost' callback, we redefine '.set_boost' to act on only one
> policy and pass the policy as an argument.
> 'cpufreq_boost_trigger_state()' iterate over all the policies to set
> boost for the system. This is preparation for adding SW BOOST support
> for CPPC.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  4 ++--
>  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
>  include/linux/cpufreq.h        |  2 +-
>  3 files changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 289e8ce..b0a9eb5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -126,7 +126,7 @@ static void boost_set_msr_each(void *p_en)
>  	boost_set_msr(enable);
>  }
>  
> -static int set_boost(int val)
> +static int set_boost(struct cpufreq_policy *policy, int val)
>  {
>  	get_online_cpus();
>  	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);

I think (Rafael can confirm), that you need to update this as well. You don't
need to run for each cpu now, but for each CPU in the policy.

> @@ -162,7 +162,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
>  	if (ret || val > 1)
>  		return -EINVAL;
>  
> -	set_boost(val);
> +	set_boost(policy, val);
>  
>  	return count;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d03f250..d0d86b1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2532,34 +2532,29 @@ void cpufreq_update_limits(unsigned int cpu)
>  /*********************************************************************
>   *               BOOST						     *
>   *********************************************************************/
> -static int cpufreq_boost_set_sw(int state)
> +static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>  {
> -	struct cpufreq_policy *policy;
> -
> -	for_each_active_policy(policy) {
> -		int ret;
> -
> -		if (!policy->freq_table)
> -			return -ENXIO;
> +	int ret;
>  
> -		ret = cpufreq_frequency_table_cpuinfo(policy,
> -						      policy->freq_table);
> -		if (ret) {
> -			pr_err("%s: Policy frequency update failed\n",
> -			       __func__);
> -			return ret;
> -		}
> +	if (!policy->freq_table)
> +		return -ENXIO;
>  
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			return ret;
> +	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
> +	if (ret) {
> +		pr_err("%s: Policy frequency update failed\n", __func__);
> +		return ret;
>  	}
>  
> +	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
>  int cpufreq_boost_trigger_state(int state)
>  {
> +	struct cpufreq_policy *policy;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -2570,16 +2565,22 @@ int cpufreq_boost_trigger_state(int state)
>  	cpufreq_driver->boost_enabled = state;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> -	ret = cpufreq_driver->set_boost(state);
> -	if (ret) {
> -		write_lock_irqsave(&cpufreq_driver_lock, flags);
> -		cpufreq_driver->boost_enabled = !state;
> -		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -
> -		pr_err("%s: Cannot %s BOOST\n",
> -		       __func__, state ? "enable" : "disable");
> +	for_each_active_policy(policy) {
> +		ret = cpufreq_driver->set_boost(policy, state);
> +		if (ret)
> +			goto err_reset_state;
>  	}
>  
> +	return 0;
> +
> +err_reset_state:
> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	cpufreq_driver->boost_enabled = !state;
> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
> +	pr_err("%s: Cannot %s BOOST\n",
> +	       __func__, state ? "enable" : "disable");
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 67d5950..3494f67 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -367,7 +367,7 @@ struct cpufreq_driver {
>  
>  	/* platform specific boost support code */
>  	bool		boost_enabled;
> -	int		(*set_boost)(int state);
> +	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>  };
>  
>  /* flags */
> -- 
> 1.7.12.4

-- 
viresh
