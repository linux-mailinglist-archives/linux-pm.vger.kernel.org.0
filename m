Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D667225D0CD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgIDFGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 01:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDFGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 01:06:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C82C061244
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 22:06:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so615717plr.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBbMB4VPz7Fp/I3o67RU25C6dBsW7GnQgeenEJJuSTw=;
        b=Rvfn1BnhAg+y/6coc//ePKxc7FZWsnd+hdeOXshn2MhZk5umuXuTThMjqB6FCKmbff
         sgSmeAxPftQyIsN6rRK6yq6eE7RaKVePVWgHwoeNSSWVlwgKrcDJ9eZp4zkRGgypdDQQ
         C8GSqzK7knDsU4dsHYYwNo5gJbV1fMaQaIi0A34jEORfJ0nVevNrVUM708Yy5cu4u5ox
         pRFflSiQUPMq7Z3rLGXpxE7EJlqUxp4P0XK/B2In77Y5KUmqSe7eeQ8alxgankoZD0tV
         lajoUaOcV/2iBqQknr7bnsXqKGXOMcKtv25aMGxMJ4MEh9AhAOHCGnEQZhTTh/bX4ZUn
         PoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBbMB4VPz7Fp/I3o67RU25C6dBsW7GnQgeenEJJuSTw=;
        b=kDm/aY29TZ35FOqWG2KWG29FD8D7IKYj0Vv8D86VQT8eH1DYga7DA4uV2Z7ca7ClUD
         CKSIvdHwWq+aYRigC384oeHi8t5tm8blJ4SavHL5PsoKEPNeWuJxjk6E3L17xz6z1jSC
         MFhc2hYof6fITJCsO4gsil61wWTpXbQdRU1fB9rfMNsoqDc5eRY5Yf3uHmUMAsTDAAFL
         wi5P7lQp0F0ZFhnmj6sAmVummp5a1E6i0jAl5c6yzDdQDjcBGGELYHLjjDXFHZn4BtOc
         pkjnVdNG+CCTOFugIz0GF3KG/Ff+lHA/dUAEy8caTXMhlAAICp7WEDOaTIk5CkfQrERU
         oSyQ==
X-Gm-Message-State: AOAM5322X8LXblCg6nTGrOqfjdLi/20eS5wTw+HFZWtM2YQMAjelVt8h
        WfBoQOYbBdvNy5Y2P2vR8TcWlw==
X-Google-Smtp-Source: ABdhPJwyHx/64jYDWTs4ttIoXGIjsEOyTW7OJHFB9S6rqlWJHC8IE9cTP+9hhRz8wSvzYxnEaCUYlg==
X-Received: by 2002:a17:902:9a90:: with SMTP id w16mr7481201plp.188.1599195977499;
        Thu, 03 Sep 2020 22:06:17 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id c5sm4254341pgj.0.2020.09.03.22.06.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 22:06:16 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:36:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq,cppc: fix issue when hotplugging out policy->cpu
Message-ID: <20200904050604.yoar2c6fofcikipp@vireshk-i7>
References: <20200903111955.31029-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903111955.31029-1-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-20, 12:19, Ionela Voinescu wrote:
> An issue is observed in the cpufreq CPPC driver when having dependency
> domains (PSD) and the policy->cpu is hotplugged out.
> 
> Considering a platform with 4 CPUs and 2 PSD domains (CPUs 0 and 1 in
> PSD-1, CPUs 2 and 3 in PSD-2), cppc_cpufreq_cpu_init() will be called
> for the two cpufreq policies that are created and it will set
> all_cpu_data[policy->cpu]->cpu = policy->cpu.
> 
> Therefore all_cpu_data[0]->cpu=0, and all_cpu_data[2]->cpu=2. But for
> CPUs 1 and 3, all_cpu_data[{1,3}]->cpu will remain 0 from the structure
> allocation.
> 
> If CPU 2 is hotplugged out, CPU 3 will become policy->cpu. But its
> all_cpu_data[3]->cpu will remain 0. Later, when the .target() function
> is called for policy2, the cpu argument to cppc_set_perf() will be 0 and
> therefore it will use the performance controls of CPU 0, which will
> result in a performance level change for the wrong domain.
> 
> While the possibility of setting a correct CPU value in the per-cpu
> cppc_cpudata structure is available, it can be noticed that this cpu value
> is not used at all outside the .target() function, where it's not actually
> necessary. Therefore, remove the cpu variable from the cppc_cpudata
> structure and use policy->cpu in the .target() function as done for the
> other CPPC cpufreq functions.
> 
> Fixes: 5477fb3bd1e8  ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Testing was done on a Juno R2 platform (with the proper ACPI/CPPC setup):
> CPUs 0, 1, 2, 3 are in PSD-0 (policy0), CPUs 4 and 5 are in PSD-4
> (policy4).
> 
> Before the fix:
> 
> root@sqwt-ubuntu:~# dmesg | grep address
> [    2.165177] ACPI CPPC: ACPI desired perf address 0: - ffff80001004d200
> [    2.174226] ACPI CPPC: ACPI desired perf address 1: - ffff800010055200
> [    2.183231] ACPI CPPC: ACPI desired perf address 2: - ffff80001005d200
> [    2.192234] ACPI CPPC: ACPI desired perf address 3: - ffff800010065200
> [    2.201245] ACPI CPPC: ACPI desired perf address 4: - ffff80001006d218
> [    2.210256] ACPI CPPC: ACPI desired perf address 5: - ffff800011ff1218
> [..]
> [    2.801940] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 38300
> [    2.835286] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
> [..]
> root@sqwt-ubuntu:~# cd /sys/devices/system/cpu/cpufreq/
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
> [   72.098758] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 51200
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
> [   85.430645] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 0 > ../cpu4/online
> [  102.606380] CPPC Cpufreq:CPPC: Calculate: (6285/261)*4266=102727.
> [  102.612491] CPPC Cpufreq:CPPC: Core rate = 1203832, arch timer rate: 50000000
> [  102.619659] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 102400
> [  102.626898] CPU4: shutdown
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
> [  141.116882] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 51200
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
> [  159.288273] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 102400
> 
> 
> After the fix:
> 
> root@sqwt-ubuntu:~# cd /sys/devices/system/cpu/cpufreq/
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
> [  139.903322] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 51200
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
> [  147.279040] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 0 > ../cpu4/online
> [  153.598686] CPPC Cpufreq:CPPC: Calculate: (6171/253)*4266=104053.
> [  153.604797] CPPC Cpufreq:CPPC: Core rate = 1219371, arch timer rate: 50000000
> [  153.611960] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 102400
> [  153.619190] CPU4: shutdown
> [  153.621911] psci: CPU4 killed (polled 0 ms)
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
> [  170.122495] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 51200
> root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
> [  177.206342] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 102400
> 
> Thanks,
> Ionela.
> 
>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>  include/acpi/cppc_acpi.h       | 1 -
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f29e8d0553a8..54457f5fe49e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -149,8 +149,9 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  		unsigned int target_freq,
>  		unsigned int relation)
>  {
> -	struct cppc_cpudata *cpu;
>  	struct cpufreq_freqs freqs;
> +	int cpu_num = policy->cpu;
> +	struct cppc_cpudata *cpu;
>  	u32 desired_perf;
>  	int ret = 0;
>  
> @@ -166,12 +167,12 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  	freqs.new = target_freq;
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -	ret = cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
> +	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
>  	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>  
>  	if (ret)
>  		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
> -				cpu->cpu, ret);
> +				cpu_num, ret);
>  
>  	return ret;
>  }
> @@ -247,7 +248,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpu = all_cpu_data[policy->cpu];
>  
> -	cpu->cpu = cpu_num;
>  	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
>  
>  	if (ret) {
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index a6a9373ab863..451132ec83c9 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -124,7 +124,6 @@ struct cppc_perf_fb_ctrs {
>  
>  /* Per CPU container for runtime CPPC management. */
>  struct cppc_cpudata {
> -	int cpu;
>  	struct cppc_perf_caps perf_caps;
>  	struct cppc_perf_ctrls perf_ctrls;
>  	struct cppc_perf_fb_ctrs perf_fb_ctrs;

With the way things are designed, I believe this is one of the bugs
out of many.

The structure cppc_cpudata must be shared across all CPUs of the same
policy, so they all end up using the same set of values for different
variables. i.e. it shouldn't be a per-cpu thing at all. Just allocate
it from cpufreq_driver->init and store in policy->driver_data for use
elsewhere.

That would be a proper fix IMO, we just avoided one of the bugs here
otherwise.

-- 
viresh
