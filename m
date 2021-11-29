Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA38A461109
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbhK2J3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Nov 2021 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbhK2J1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Nov 2021 04:27:18 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD1C061756
        for <linux-pm@vger.kernel.org>; Mon, 29 Nov 2021 01:10:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 137so8371637pgg.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Nov 2021 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqZU7dB4c+Rw9JAiakkbCvFsmlXNXYUS7tOeUtIOfLQ=;
        b=d6l5RiPebDIJXUvKHVE/UQhhHqwbzzNGJru/7cPRP2K6NvZcqgPXgOnpkyTzEQ4COG
         L/GR90IS/yB2VOoHr1jO1sIBX3cKxV/H+CY57EW1fYfLnh6KSQFrgvGuC2uRf7EwSK0T
         tfyU5G1B2m7aDmZOup9i9S7968vLpOgu6YRuTmf0rCOa41Rnw0JDzj03L4xfovujo+KS
         4aRVX7E87YmWrVtmDe66eHLlyAM+I8BgnoRgjCjAW97iXAGAu4d0EAbfZbJUKQyOAxNu
         GH4siRwuLdVmIyiwiPWXcLuJQYb2zrE4n6eYRCAx4rlfsa2FeCFrhYJpp+KrSh6E1PnH
         lQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqZU7dB4c+Rw9JAiakkbCvFsmlXNXYUS7tOeUtIOfLQ=;
        b=mxo0381z12FFDHSCrvKFo5cifY63xDtTrz/0/OAMKSOp0vyM5ZAe72MuPjHNkY0Itb
         F4JTnLM01sZl0haRSmXwidlruEutmXL21VDarqZiSR/evrBhvtKvzykueyJF58fG3XOO
         jteru51cRplP31nuan2CEGirsDjZBqsue2bihJ6AcnUyE+8Tliap5zbEQG1Gt/+QTCp1
         CcvB85UDsFkGtgFeOqF3101YQA+Jp7zJQb9M11Mge7tZDnCJd69KcCD2bzIxI3BuLScA
         YP1j6ep5y06s9QXYtZ1QrUokAj+DkgWjBp5EMLhySejqWGs+WLn9owVW+86dLwkbDOn+
         2xYQ==
X-Gm-Message-State: AOAM5320SK5HH8l4omr4FDLXKOOJ3dFVsX45CW9vPg9tqh1x1gsTW40k
        lREWCcl0trwcEPL+SI/cTQMRRrLPcH4jlw==
X-Google-Smtp-Source: ABdhPJzZlt6748dnh3okRdnl0hdxTSnyx8TLAXDzcuEYGeCHx5b1L18l83I1H82Ht23zjtgvWm8tTA==
X-Received: by 2002:a63:8b4a:: with SMTP id j71mr34782170pge.447.1638177043059;
        Mon, 29 Nov 2021 01:10:43 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id lt5sm12617490pjb.43.2021.11.29.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:10:42 -0800 (PST)
Date:   Mon, 29 Nov 2021 14:40:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in
 add_cpu_dev_symlink()
Message-ID: <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-11-21, 16:02, Xiongfeng Wang wrote:
> When I hot added a CPU, I found 'cpufreq' directory is not created below
> /sys/devices/system/cpu/cpuX/. It is because get_cpu_device() failed in
> add_cpu_dev_symlink().
> 
> cpufreq_add_dev() is the .add_dev callback of a CPU subsys interface. It
> will be called when the CPU device registered into the system. The stack
> is as follows.
>   register_cpu()
>   ->device_register()
>    ->device_add()
>     ->bus_probe_device()
>      ->cpufreq_add_dev()
> 
> But only after the CPU device has been registered, we can get the CPU
> device by get_cpu_device(), otherwise it will return NULL. Since we
> already have the CPU device in cpufreq_add_dev(), pass it to
> add_cpu_dev_symlink(). I noticed that the 'kobj' of the cpu device has
> been added into the system before cpufreq_add_dev().
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..22aa2793e4d2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1004,10 +1004,9 @@ static struct kobj_type ktype_cpufreq = {
>  	.release	= cpufreq_sysfs_release,
>  };
>  
> -static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
> +static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
> +				struct device *dev)
>  {
> -	struct device *dev = get_cpu_device(cpu);
> -
>  	if (unlikely(!dev))
>  		return;
>  
> @@ -1391,7 +1390,7 @@ static int cpufreq_online(unsigned int cpu)
>  	if (new_policy) {
>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
> -			add_cpu_dev_symlink(policy, j);
> +			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>  		}
>  
>  		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> @@ -1565,7 +1564,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	/* Create sysfs link on CPU registration */
>  	policy = per_cpu(cpufreq_cpu_data, cpu);
>  	if (policy)
> -		add_cpu_dev_symlink(policy, cpu);
> +		add_cpu_dev_symlink(policy, cpu, dev);
>  
>  	return 0;
>  }

Interesting that I never hit it earlier despite doing rigorous testing of
hotplug stuff :(

Anyway the patch is okay,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
