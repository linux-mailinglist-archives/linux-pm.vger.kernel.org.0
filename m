Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723822AB1A0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgKIHJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 02:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgKIHJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 02:09:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE03C0613CF
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 23:09:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so6365473pgr.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 23:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/FaU29Y4JMgTHlOU8rTa94tuMXWoPpfGji5be75b2rU=;
        b=rLcblK+BzZkRhrZxn4EP3AT262nanGmzzXc6E/2nKdNmHuzVWUzVbHEaPXoOX4Qm4H
         /Zbr2fh+qToihwPlC4AyxBRUMCjaUK8NBBeWp7R78QOMy9/BAkoj9FANA3o4CP1C23M1
         i4sYs+dAJ1OQ1qus/ttZqstmgjrGBoRFF8JTJt9ujsXH5QpBKssu5SzM5MKVtC0sMRKF
         uPOPjLL1ZNkJF+JCctLX+aOKyVnc0iI5otQJf0eFRpkL2sTX7hGfu8BckDLzDtvzbpwI
         IXA49jnMccGgjTmxreO/OHRARVU79oRFygk7m2K1oOrm0odAipLKyfymPx0D6uLdWYAn
         +z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/FaU29Y4JMgTHlOU8rTa94tuMXWoPpfGji5be75b2rU=;
        b=dtRe9qwt4T9t5/T4qTEBTD1uwtQn5GZZ2/z4vhl6BoFhsvsqcqV4J/w2/dO1qB6hOV
         BwjKvgdFFe1EBilFoRJkS3XtIo5xzkS7FqAbgkRXN1QG0K0tNDikSyZcpN+iUprgd5RB
         O/pEJKMqeg+PNSoXhb+QayZbbmtNt6GO0YwfrMDUARBQ/9q6DKzRDPdIK3K4E6ArisZ7
         T/99IAgr+IAherf5vCHHHqIJuHeWuJUYC8Aeg4Mju85P4nsms4xxz30pXfyJb9aF4xa6
         iHDchNT/R/huJGv2hFsjWeflyWDeYpZJMtiBLhkDFNTH2e1sqJsymaXXZygPkl60I4mb
         SiLg==
X-Gm-Message-State: AOAM530Vez4ZYCJ2vUOwbNfrMORVGOOf/jmCqih8ZoCsKvHIxYcOckjX
        l76TxqDu+1w4wM6gcWLk7JHtuw==
X-Google-Smtp-Source: ABdhPJwHnqQfjbd/Ne5UA7inACgKNQYPefTdQYv1OnLT0ZXBJR8ER18iX0wldDJH5BDcTRKrKXUH3w==
X-Received: by 2002:a17:90a:fd8d:: with SMTP id cx13mr11754034pjb.138.1604905766984;
        Sun, 08 Nov 2020 23:09:26 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v16sm9163875pgk.26.2020.11.08.23.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:09:26 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:39:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] cppc_cpufreq: expose information on frequency domains
Message-ID: <20201109070924.d47rohgumvdial3b@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-8-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-8-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> Use the existing sysfs attribute "freqdomain_cpus" to expose
> information to userspace about CPUs in the same frequency domain.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |  3 ++-
>  drivers/cpufreq/cppc_cpufreq.c                     | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 1a04ca8162ad..0eee30b27ab6 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -264,7 +264,8 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>  		attribute is useful for user space DVFS controllers to get better
>  		power/performance results for platforms using acpi-cpufreq.
>  
> -		This file is only present if the acpi-cpufreq driver is in use.
> +		This file is only present if the acpi-cpufreq or the cppc-cpufreq
> +		drivers are in use.
>  
>  
>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 60ac7f8049b5..b4edeeb57d04 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -483,6 +483,19 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> +static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +
> +	return cpufreq_show_cpus(cpu_data->domain->shared_cpu_map, buf);
> +}
> +cpufreq_freq_attr_ro(freqdomain_cpus);
> +
> +static struct freq_attr *cppc_cpufreq_attr[] = {
> +	&freqdomain_cpus,
> +	NULL,
> +};
> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
> @@ -491,6 +504,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
>  	.set_boost = cppc_cpufreq_set_boost,
> +	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
