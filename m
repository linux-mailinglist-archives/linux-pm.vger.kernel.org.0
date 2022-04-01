Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134B4EFCC4
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352747AbiDAWZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 18:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiDAWZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 18:25:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF595BD14
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 15:24:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i7so4175906oie.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZjOBeY2iD25N1VXT7TCOLEd/N2hkIpoCrhlPTaYha0=;
        b=KsCSmmPe37eVaT8lKsKfPUs4Oaoory+5mZlp9bw7SUeHsrMQGfZNl67X9Bat+Lrw0C
         giVfMc28oY1jZxNuDr5Pj07Is5LzZS0oVT01EG2gR8PHut7jYA3U0SVBEIhy5J6ltts/
         LvimsPG0BvZ0JE3r5+FDbTj3LIJM4UWeP1BEy/wa65zq3dayZRYBtsJDXZ2skQygslRL
         NRqISDrCVsStXxnviWGTVOOZ9+g1tH39OClr/lFePeSu6oys6aCRuN3afvzAUhya75nC
         DAzwTB3Ju1vkrdpCbGtnxgZSQdsL3yZZhnDEKurT9wLFuleCiIqfqUVRUHw/e93sA+5p
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZjOBeY2iD25N1VXT7TCOLEd/N2hkIpoCrhlPTaYha0=;
        b=5wMmXxjwV/frmVL1TFKU1qmfoxnBeXxFO61Gn1rFVuIn6oqgz6K8dDnhepDPBIJobE
         q+9uak+Zkk9xqNK01zqYTUXN6Xu/bOQXspxEHuKMOPAsQNJwF/yXPiG6gZjQDk+b/7ED
         FHhZgkBQep8+h+r+K0+mJc+XY6JLkrM73gdzGvCv627cwc+dBBLxwgPD2dSDvPT1E2hJ
         73FxRO/Z/hcFG54Nw74ppc15eQ92OEuz7QXoaA9OVxWTxBdB2Qw/gB8Yjdih4FuozZJb
         gHnKPuyEIpqnFAdHYzCSb6WAPbnf51fbid+u9cuaIwGYDqZLU0lDoQXGxPGoGj2ZH+ww
         Eucg==
X-Gm-Message-State: AOAM532X2me3RxgJ96YfpjVRFuJT1XXjvwI6HFIjGQH4VuIAAP6yvuSP
        M+ZxJusAQ49ou9zqZmkcJqQbuPSiWHJvXA==
X-Google-Smtp-Source: ABdhPJzM/ghuirhQyVuB5/VZsRxiM71OfXtcGbZnmK+Jj2UOEpvGgifFf2KYAB7RzoIhp4qEeS72FA==
X-Received: by 2002:a05:6808:ed0:b0:2f7:4bd0:c6d8 with SMTP id q16-20020a0568080ed000b002f74bd0c6d8mr5369062oiv.119.1648851842018;
        Fri, 01 Apr 2022 15:24:02 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w39-20020a056830412700b005cda87bbdcesm1702637ott.6.2022.04.01.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 15:24:01 -0700 (PDT)
Date:   Fri, 1 Apr 2022 15:26:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: qcom-cpufreq-hw: Fix throttle frequency
 value on EPSS platforms
Message-ID: <Ykd8FUgLhGb0x7VI@ripper>
References: <20220401071424.2869057-1-vladimir.zapolskiy@linaro.org>
 <20220401071424.2869057-3-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401071424.2869057-3-vladimir.zapolskiy@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 01 Apr 00:14 PDT 2022, Vladimir Zapolskiy wrote:

> On QCOM platforms with EPSS flavour of cpufreq IP a throttled frequency is
> obtained from another register REG_DOMAIN_STATE, thus the helper function
> qcom_lmh_get_throttle_freq() should be modified accordingly, as for now
> it returns gibberish since .reg_current_vote is unset for EPSS hardware.
> 
> To exclude a hardcoded magic number 19200 it is replaced by "xo" clock rate
> in KHz.
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

This could have been picked up by the maintainer already in the previous
version, if it wasn't the second patch in the series. Please send it
separately, or as the first patch of the two, so we can ask Viresh to
pick it up (just in case we don't reach an agreement of your next
version of the other patch).

Regards,
Bjorn

> ---
> Changes from v1 to v2:
> * added a comment about a replaced 19200 number in the code, thanks
>   to Bjorn for suggestion and review.
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index e17413a6f120..d5ede769b09a 100644
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
> @@ -284,11 +285,16 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
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
> @@ -298,14 +304,12 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
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
> @@ -377,6 +381,7 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
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
