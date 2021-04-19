Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B950C364A67
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbhDSTU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbhDSTU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 15:20:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607AEC061763
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:19:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u80so2979811oia.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZbzeWV6GVD6eWJkyDTEOnuhwhKdeOlP9Hjos10f4Wck=;
        b=AG3GCPgSzQKPV5Ik9GoFJN6AeK5tu97CW+dY7p6heFhaMlgqS0SJclid86ifZoMha5
         0D8IPMlfe1al7QHNtkOiYQK/APGpIbVTqdh+tMZXuvJmrOu1iuF1rdsfifpLdv28VzrP
         COMRHTOrn0kBhXvxtyJ/CtOG9DcbtzFD++l8kr0USzbDz3ADs2Py+4SsJqMqVfgiNuVt
         7WLjUNU/gqrqMg4rpBi6dVaIYiATEW5QWj+c/nscurTwn4mb9lGKKJYQgz3lzuOa5Q7D
         2J9hLk8QlADVj2KBTqiOVz2wEd+1I2g2GiwqFnOR3BAeGArlbCgBQxrnV8cOwzVjIdti
         IYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZbzeWV6GVD6eWJkyDTEOnuhwhKdeOlP9Hjos10f4Wck=;
        b=ZXn1cQGeLsRHhyJjIDMPj4QrTcxeHK4auTdgLhIXW/hkmY7uNDxAfiORbtwXJla+b3
         T9vOcv3BumTnGDWqk9zLS7UuRldUooYWIlaOgWIhw9cQ+OLc7HJlyP7B82laLWlgW7yD
         X42I7CxQwZccFhDvqNXSzewtgWmxGeFykxwrIPlupex0XmLasbAJK1Zh3GNh/5+ghuGL
         GaCAR1itBxbl1CbIH8Xeb00FhTCUSwznhdtpQfYDjvTmVN211IKfvcKRYMl8KzPnNyf4
         VEv6s1+/CXUgGp/OY5Vn17dvmvEoiVHr2qyQFuMlZgSmJpvDa83z3umD9EOaBEIC2DbU
         Sq0Q==
X-Gm-Message-State: AOAM533ckQ9WgH7iJU5ZOt+Pd8ShC8DCyZ/byqq1/0CcGs8MfiyhbWpA
        1k5RbNtWZHDbBN0ShrnOgAGVzA==
X-Google-Smtp-Source: ABdhPJwkvLH1F188hbMXxG6v9qePRDH2A18GDCuL3t8TOIiiuq+kiy/JK1hmoTuAES8KAqW8cByPDQ==
X-Received: by 2002:aca:e057:: with SMTP id x84mr427362oig.5.1618859994764;
        Mon, 19 Apr 2021 12:19:54 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p11sm3709901oti.53.2021.04.19.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:19:54 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:19:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 6/7] cpufreq: qcom-hw: Allow getting the maximum
 transition latency for OPPs
Message-ID: <20210419191952.GV1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-7-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174557.227318-7-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:

> In order to fine-tune the frequency scaling from various governors,
> allow to set a maximum transition latency from OPPs, which may be
> different depending on the SoC.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a92959bb7b50..5f67da796f6c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -1401,6 +1401,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	void __iomem *base;
>  	struct qcom_cpufreq_data *data;
>  	const char *fdom_resname;
> +	unsigned int transition_latency;
>  	int cpu_count, index, ret;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
> @@ -1478,6 +1479,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> +	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
> +	if (!transition_latency)
> +		transition_latency = CPUFREQ_ETERNAL;
> +
> +	policy->cpuinfo.transition_latency = transition_latency;
> +
>  	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
>  	if (policy_has_boost_freq(policy)) {
> -- 
> 2.30.0
> 
