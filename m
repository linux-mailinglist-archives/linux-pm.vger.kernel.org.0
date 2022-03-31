Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1B4EE073
	for <lists+linux-pm@lfdr.de>; Thu, 31 Mar 2022 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiCaSbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Mar 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiCaSbd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2022 14:31:33 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC31168C9
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 11:29:45 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id s1-20020a05682003c100b00324b888f165so119823ooj.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mcQUhaovxCAqErgroen0yneFFzpc+nhqPmvZDgs5HKE=;
        b=KJNvwcpNHB8uwneYT5A98+bPn6FwNn5mYg7RbCaW0xGt4zd807SyLNW3jY+YCoTl9p
         1Dq7HY2DKjJriaRvEVlc9WpM0We9P3ffwu8RYXgG4gL3lxKnOyArAU8Sd7/h3juwMr+m
         2XJ/LpTmJJIo8BR23GdGnRAcAMaS+5mUf0lvP0tsevSgBxW8oEHWnB7EczrXhg5Wi0P7
         Pc1pZPca5vGOuxk+7Hcp7uiq0es8IsP5CfXXz7KkOFm1SVowIZYS2ThGRruuvdlBEYz3
         8Yu8mlK0y/YvEUY5eo1UTmT0RPQv98svaEqTCbZCVAnnX9TtaVmfYvLMTPyd9ABqgvBZ
         1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mcQUhaovxCAqErgroen0yneFFzpc+nhqPmvZDgs5HKE=;
        b=nmcyL8WDep/f71MyxwQAstU+8YSXebITpSmJtxXSIPsKI8p7jB/hlmKTP2Pj4JHVf1
         zrJQQZnUHGD+2si1F5uv2/7Sar4Zg20UoZCxO2ELR5PRVXcPh+FPGGMoxn1NfZsSjcV/
         MqbvTdKCB2yWPWo+cO0OvwLKJMW5BPysEDiIFOGxTvEb5xEatNeq0E/cKCFfQZsm6ql3
         cYg9ov9DbvE0IcG7lXQndkUReUx4lOIYWkWQeizUY7aUe90MWcgJNLo4yq5BpmKa+jxP
         ZcAsvL3F0bBx3OFgz4yH03IIC8z1mvFIOvIHOlQTh+K0Z/gPYcJovQBwy6MIw5l+HZrf
         RGDA==
X-Gm-Message-State: AOAM5339KM4uN+MW2suORnHjJWIBB/FcvMlIWkUwn6BML9bwdC0BZCvi
        cTDmwLKg1VHJg32VxX39SU2U0cE+q0EIYw==
X-Google-Smtp-Source: ABdhPJwp88HpGzUX79uZJuS634y7BQ1kpSiJcZ7cORN3TgpjjveFHWsm3fZcoWOI8Np4zk0GkmdwwQ==
X-Received: by 2002:a4a:e7c8:0:b0:321:11d8:6146 with SMTP id y8-20020a4ae7c8000000b0032111d86146mr5556132oov.76.1648751385047;
        Thu, 31 Mar 2022 11:29:45 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i21-20020a056830011500b005cdc3cdacb5sm125944otp.57.2022.03.31.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:29:44 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:32:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-cpufreq-hw: Fix throttle frequency
 value on EPSS platforms
Message-ID: <YkXzrrvQ5MPQ956H@ripper>
References: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
 <20220328112836.2464486-3-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112836.2464486-3-vladimir.zapolskiy@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 28 Mar 04:28 PDT 2022, Vladimir Zapolskiy wrote:

> On QCOM platforms with EPSS flavour of cpufreq IP a throttled frequency is
> obtained from another register REG_DOMAIN_STATE, thus the helper function
> qcom_lmh_get_throttle_freq() should be modified accordingly, as for now
> it returns gibberish since .reg_current_vote is unset for EPSS hardware.
> 

Perhaps add a paragraph here to mention that you're replacing
19200 * HZ_PER_KHZ with xo_rate in this patch as well?

> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 53954e5086e0..3156d79ef39e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -30,6 +30,7 @@
>  
>  struct qcom_cpufreq_soc_data {
>  	u32 reg_enable;
> +	u32 reg_domain_state;
>  	u32 reg_dcvs_ctrl;
>  	u32 reg_freq_lut;
>  	u32 reg_volt_lut;
> @@ -283,11 +284,16 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  	}
>  }
>  
> -static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
> +static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>  {
> -	unsigned int val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
> +	unsigned int lval;
>  
> -	return (val & 0x3FF) * 19200;
> +	if (data->soc_data->reg_current_vote)
> +		lval = readl_relaxed(data->base + data->soc_data->reg_current_vote) & 0x3ff;
> +	else
> +		lval = readl_relaxed(data->base + data->soc_data->reg_domain_state) & 0xff;
> +
> +	return lval * xo_rate;
>  }
>  
>  static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> @@ -297,14 +303,12 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  	struct device *dev = get_cpu_device(cpu);
>  	unsigned long freq_hz, throttled_freq;
>  	struct dev_pm_opp *opp;
> -	unsigned int freq;
>  
>  	/*
>  	 * Get the h/w throttled frequency, normalize it using the
>  	 * registered opp table and use it to calculate thermal pressure.
>  	 */
> -	freq = qcom_lmh_get_throttle_freq(data);
> -	freq_hz = freq * HZ_PER_KHZ;
> +	freq_hz = qcom_lmh_get_throttle_freq(data);
>  
>  	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
>  	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
> @@ -371,6 +375,7 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>  
>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
>  	.reg_enable = 0x0,
> +	.reg_domain_state = 0x20,
>  	.reg_dcvs_ctrl = 0xb0,
>  	.reg_freq_lut = 0x100,
>  	.reg_volt_lut = 0x200,
> -- 
> 2.33.0
> 
