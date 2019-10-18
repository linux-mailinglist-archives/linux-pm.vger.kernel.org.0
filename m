Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC3DBD56
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbfJRF5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:57:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44724 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389894AbfJRF5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:57:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so2301987pll.11
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQsGhR9ZGml3wjFEwG0ewcRolEFUUyRHabzESZwufR0=;
        b=L3LhpGdf5pG0gSoA+vMGqs42dgW5Xj0gFs2q1JmiT4zdXa66VUDh3cq0F6whgWX542
         aa1L2JPpCuGkqopFEjwrzviWP9iRDxmakcHM66C9gPX9SUjyEFcpN+4VHoy1Kmm827zs
         oaq/qkpGrL/SLHikRsdpwKmTSMXBlSB7Q7xDspkX70nN5q75CKdJUQ2Iyt0aoDMWxa5J
         sFBxHg0z07uRza1XeGgG3OD7pPd5C8WIzpPv+Rw/HCd+Fwe30kiCCs4b2ES4iTMB9zcf
         3g83yd7uGce12d6YmTM5qcpvHUFIcmMUynW/9hnlKHZPh0bxrJutMczcegOui83MvbyY
         kmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQsGhR9ZGml3wjFEwG0ewcRolEFUUyRHabzESZwufR0=;
        b=cp2lPQyoNkhb1LtV94PQlkcsHB1kKnQaGiRNqmjpBqmHAJixxfBiFJmPDli4vScxCr
         OXPYgqRue7OMq/bMmbrOFt3JzUYKTeD9y0mRkME5EawethmaPzmYNxRzw0wNoBdLfgIL
         axsvO9Lh6Ogh6DpKFjauvW7hWhhwOSTBMN/Rp6jHArFx20RVamCJ6Y8fr4kRyFRm1mpX
         WGzgQTxkajAf0m/hCctQSj9pdOFpUglBZUWNlN/vdxJCkPnTUtuvr446eaOtnYjPAZ8j
         Exq2ycuiZirs5ArMNwDk7JT9dOUKkmuW38Qcj4/4Slm1P8/MeWbAm0FkNCDO2bSETFpZ
         UAMQ==
X-Gm-Message-State: APjAAAWNa3dZo8FXwGJboG93DQeOok3grCBFwAo2asHBBINva5SmTdeV
        i1zh1/kHMSg6DdSrAHFKXPTqBg==
X-Google-Smtp-Source: APXvYqxbEOwe/5sQAtSoS3rk+tKMk5HUg8RZtXjN50F3higpS/vY7FadtxLS4YCI1meSGWtbAk06qA==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr8101703plp.2.1571378243286;
        Thu, 17 Oct 2019 22:57:23 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id r18sm6263453pfc.3.2019.10.17.22.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:57:22 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:27:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 4/5] cpufreq: vexpress-spc: remove lots of debug
 messages
Message-ID: <20191018055720.za3a5zeqdzcupc4h@vireshk-i7>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017123508.26130-5-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 13:35, Sudeep Holla wrote:
> This driver have been used and tested for year now and the extensive
> debug/log messages in the driver are not really required anymore.
> Get rid of those unnecessary log messages.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 72 +++++---------------------
>  1 file changed, 13 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
>  static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
> @@ -324,11 +296,9 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
>  
>  	for_each_present_cpu(i) {
>  		struct device *cdev = get_cpu_device(i);
> -		if (!cdev) {
> -			pr_err("%s: failed to get cpu%d device\n", __func__, i);
> -			return;
> -		}
>  
> +		if (!cdev)
> +			return;

We had a blank line after this, which isn't there in your version
anymore. Please keep that here and few more places below.

>  		_put_cluster_clk_and_freq_table(cdev, cpumask);
>  	}
>  
> @@ -354,19 +324,12 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
>  		goto out;
>  
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
> -	if (ret) {
> -		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
> -				__func__, cpu_dev->id, ret);
> +	if (ret)
>  		goto out;
> -	}
>  
>  	clk[cluster] = clk_get(cpu_dev, NULL);
> -	if (!IS_ERR(clk[cluster])) {
> -		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
> -				__func__, clk[cluster], freq_table[cluster],
> -				cluster);
> +	if (!IS_ERR(clk[cluster]))
>  		return 0;
> -	}
>  
>  	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
>  			__func__, cpu_dev->id, cluster);
> @@ -401,11 +364,9 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
>  	 */
>  	for_each_present_cpu(i) {
>  		struct device *cdev = get_cpu_device(i);
> -		if (!cdev) {
> -			pr_err("%s: failed to get cpu%d device\n", __func__, i);
> -			return -ENODEV;
> -		}
>  
> +		if (!cdev)
> +			return -ENODEV;
>  		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
>  		if (ret)
>  			goto put_clusters;
> @@ -419,19 +380,14 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
>  	clk_big_min = get_table_min(freq_table[0]);
>  	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
>  
> -	pr_debug("%s: cluster: %d, clk_big_min: %d, clk_little_max: %d\n",
> -			__func__, cluster, clk_big_min, clk_little_max);
> -
>  	return 0;
>  
>  put_clusters:
>  	for_each_present_cpu(i) {
>  		struct device *cdev = get_cpu_device(i);
> -		if (!cdev) {
> -			pr_err("%s: failed to get cpu%d device\n", __func__, i);
> -			return -ENODEV;
> -		}
>  
> +		if (!cdev)
> +			return -ENODEV;
>  		_put_cluster_clk_and_freq_table(cdev, cpumask);
>  	}
>  
> @@ -500,8 +456,6 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
>  	}
>  
>  	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
> -	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
> -
>  	return 0;
>  }
>  
> -- 
> 2.17.1

-- 
viresh
