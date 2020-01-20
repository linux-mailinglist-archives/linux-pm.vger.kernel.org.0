Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B3D1422D6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 06:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATFcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 00:32:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53104 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATFcx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 00:32:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so6216780pjh.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 21:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2qmd9YWzH6xu5Oj2gVIAaeZHmPEfZ43TMx9sNOsevlQ=;
        b=WdS+IB/WGdpzMpHYEM4F3JWyfLWMh34U4J3B7Qy3FWJHckRCJHasGyLZcijiRAhti9
         TYr8tSAfHilsz/qOFvuCPvFYRNVGri/hhJVpyApRU7cxBU92Ki1fl9GK6xODthE3RRRN
         yPneoXElteqrj2b8TPZMPJ8iyFMWqucSTZJXRVJyBzDE0HsVPrmDVUikgb2yTbgWt9JH
         m+cxYluAuIhVIlm+hvKblhFgU3clfWpxnrrgd9dg4OwMI22xVX46pJt0I1w2n0XDZ7nt
         WP/EILVaGom3bS9uaVwsztIKtAmNiW/bzc5iziM5HT6giGsDqj01WXL+HR3eX6CtjXPk
         x9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qmd9YWzH6xu5Oj2gVIAaeZHmPEfZ43TMx9sNOsevlQ=;
        b=NWHSptY033KGIhW+Z/44NO1Qjt0t1+phZ6R/vSTl3q9nT+56S702H/uhhLWaBrFvy/
         EuEnC4s4/WUJvpyz5eKauqPiTARafcbdeGMM6/Hk7GWy9HPny+Z1uLOYEmEVHQBTncPI
         IWbmQp2TeJD+Razl3bSc10eRhfGq67lZlJl1lnTthJRuYfTzG5grAikkvowwhCz/2I+J
         M3uEB2aMDQWJRZ5jWy9ndMSorENcXQ1oDG/IyFHGh69T2MWBFCc4Q0y5VlVfFBisea/6
         WLffT6MbtWKxIOdfbfpr1cEoCpWmtlCDJUdZ1S61AQelEQKu0vvuekH99pgLdQxaXcTB
         v2Zg==
X-Gm-Message-State: APjAAAVxtnwYg8G6HSuE2VD1XnZYYJ9v3XhXeQJ50WmDOCTvOAPIqiaa
        RXAkR6uotTrBugMGgt6Xp1tNcA==
X-Google-Smtp-Source: APXvYqxEQh0dD7dWdpC/jtMHLtn2aVMV8HFg97xl0O/3IlaQMBlDMq6bfPvKRBHpXikUE39b4UMcSg==
X-Received: by 2002:a17:90a:300b:: with SMTP id g11mr21390053pjb.123.1579498372564;
        Sun, 19 Jan 2020 21:32:52 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id e1sm37678585pfl.98.2020.01.19.21.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 21:32:51 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:02:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> meanwhile, it also increments the kobject reference count to mark it busy.
> However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> the kobject reference count back, which may lead to a potential stuck risk
> that the cpuhp thread deadly waits for dropping of kobject refcount when
> cpufreq policy free.
> 
> For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> If the policy return NULL, we just return 0 to hit the code path of
> cpufreq_driver->get.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 77b0e5d..ee0d404 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
>  
>  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);

Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?

> -	struct private_data *priv = policy->driver_data;
> +	struct cpufreq_policy policy;
> +	struct private_data *priv;
> +
> +	/*
> +	 * In case cpufreq policy has been released, just return 0.
> +	 */
> +	if (cpufreq_get_policy(&policy, cpu))
> +		return 0;

Why did you move away from the previous implementation of cpufreq_cpu_get() ?

> +
> +	priv = policy.driver_data;
>  
>  	return brcm_avs_get_frequency(priv->base);
>  }
> -- 
> 1.9.1

-- 
viresh
