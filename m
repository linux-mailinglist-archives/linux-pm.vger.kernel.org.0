Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399F2228B8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGPRK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 13:10:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D0C061755
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 10:10:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17so4790399otl.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=74VCADifLAjW5QPg1wIiKFbTZE5Zk+0UxL1G9qiWDfU=;
        b=ATLY3ADcfNMXjwxTz5e/3qQ/hjPPxzPinh3EbuXsvn07xGcW/3W5O22FyyqYP+GEfn
         ZGHbXAseThuZQfmOpBANR07eo0wZrprTqC/UAFg4zXcWMDoy4xMX6brLRi9wSMc0JNoy
         zbmXnRJFwCuMBF9gUZb+e7STiNbM/6whKcu8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=74VCADifLAjW5QPg1wIiKFbTZE5Zk+0UxL1G9qiWDfU=;
        b=fFZ45h/AGVdNriNwK2LX27tOZhx9d293Vl0R9x8DRD7sxMWQQVkBLZyEKgxszVtf1W
         Nis0IVhppqzXS1NuNbm6ebWZEb8ugb5SuLYBpD1GgY0R4vA34Y9ZEjVeciTqNBHv42hW
         LHENIAq/Y3JTU3N8nAEvIttM5IcygRdMqCRSvbCSZj6SLKm0lySERYOmdF1kFGnmU/ao
         OYzlsWqgxTX7HNNhZ2FiW+KU4lFCGiw4Dm5VJqlZS5/PwTuM32yJDpA8PTTCvj4oXfws
         5M4NontAgtBdg10sUNm8vJjZ7jm3ReqgDuerRGyf5O/3og0cBi0YL/UOnHg/MoQvezyO
         sCqQ==
X-Gm-Message-State: AOAM533x+x4DaOiibqAtCUAtJj07PB9ZzXpLrJ0Zlze5PEmP1OJpN/pr
        IJshMThHogryh94hseRvSDaERw==
X-Google-Smtp-Source: ABdhPJzuDxQBmf0/WSARbFEvj0I0lNmxbC39konR22yd2dlhEBWFopRh0Q6fzhuY1pxfLBYQGaW8dQ==
X-Received: by 2002:a9d:6b92:: with SMTP id b18mr5184027otq.367.1594919424977;
        Thu, 16 Jul 2020 10:10:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t10sm1268907otd.78.2020.07.16.10.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 10:10:24 -0700 (PDT)
Subject: Re: [PATCH] cpupower: Provide offline CPU information for cpuidle-set
 and cpufreq-set options
To:     latha@linux.vnet.ibm.com, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200713075647.70036-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <839adf7f-8875-47c5-0126-038e69e638ac@linuxfoundation.org>
Date:   Thu, 16 Jul 2020 11:10:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713075647.70036-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/13/20 1:56 AM, latha@linux.vnet.ibm.com wrote:
> From: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> 
> When a user tries to modify cpuidle or cpufreq properties on offline
> CPUs, the tool returns success (exit status 0) but also does not provide
> any warning message regarding offline cpus that may have been specified
> but left unchanged. In case of all or a few CPUs being offline, it can be
> difficult to keep track of which CPUs didn't get the new frequency or idle
> state set. Silent failures are difficult to keep track of when there are a
> huge number of CPUs on which the action is performed.
> 
> This patch adds an additional message if the user attempts to modify
> offline cpus.
> 

The idea is good. A few comments below on implementing it with
duplicated code in cmd_freq_set() and cmd_idle_set().

Please eliminate code duplication as much as possible. Handling
offline_cpus alloc/free similar to cpus_chosen will reduce some
duplication.

> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpufreq-set.c | 24 ++++++++++++++++++++++--
>   tools/power/cpupower/utils/cpuidle-set.c | 21 ++++++++++++++++++++-
>   2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 6ed82fba5aaa..87031120582a 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -195,10 +195,14 @@ int cmd_freq_set(int argc, char **argv)
>   	extern int optind, opterr, optopt;
>   	int ret = 0, cont = 1;
>   	int double_parm = 0, related = 0, policychange = 0;
> +	int str_len = 0;
>   	unsigned long freq = 0;
>   	char gov[20];
> +	char *offline_cpus_str = NULL;
>   	unsigned int cpu;
>   
> +	struct bitmask *offline_cpus = NULL;
> +
>   	struct cpufreq_policy new_pol = {
>   		.min = 0,
>   		.max = 0,
> @@ -311,14 +315,21 @@ int cmd_freq_set(int argc, char **argv)
>   		}
>   	}
>   
> +	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
> +	str_len = sysconf(_SC_NPROCESSORS_CONF) * 5;
> +	offline_cpus_str = malloc(sizeof(char) * str_len);
>   

Allocate once when cpus_chosen is allocated.

>   	/* loop over CPUs */
>   	for (cpu = bitmask_first(cpus_chosen);
>   	     cpu <= bitmask_last(cpus_chosen); cpu++) {
>   
> -		if (!bitmask_isbitset(cpus_chosen, cpu) ||
> -		    cpupower_is_cpu_online(cpu) != 1)
> +		if (!bitmask_isbitset(cpus_chosen, cpu))
> +			continue;
> +
> +		if (cpupower_is_cpu_online(cpu) != 1) {
> +			bitmask_setbit(offline_cpus, cpu);
>   			continue;
> +		}
>   
>   		printf(_("Setting cpu: %d\n"), cpu);
>   		ret = do_one_cpu(cpu, &new_pol, freq, policychange);
> @@ -328,5 +339,14 @@ int cmd_freq_set(int argc, char **argv)
>   		}
>   	}
>   
> +	if (!bitmask_isallclear(offline_cpus)) {
> +		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
> +		printf(_("Following CPUs are offline:\n%s\n"),
> +			 offline_cpus_str);
> +		printf(_("cpupower set operation was not performed on them\n"));
> +	}

Make the printing common for cmd_idle_set() and cmd_freq_set().
Make this generic to be able to print online and offline cpus.

> +	free(offline_cpus_str);
> +	bitmask_free(offline_cpus);

Free these from main()

> +
>   	return 0;
>   }
> diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
> index 569f268f4c7f..adf6543fd3d6 100644
> --- a/tools/power/cpupower/utils/cpuidle-set.c
> +++ b/tools/power/cpupower/utils/cpuidle-set.c
> @@ -27,9 +27,12 @@ int cmd_idle_set(int argc, char **argv)
>   	extern char *optarg;
>   	extern int optind, opterr, optopt;
>   	int ret = 0, cont = 1, param = 0, disabled;
> +	int str_len = 0;
>   	unsigned long long latency = 0, state_latency;
>   	unsigned int cpu = 0, idlestate = 0, idlestates = 0;
>   	char *endptr;
> +	char *offline_cpus_str = NULL;
> +	struct bitmask *offline_cpus = NULL;
>   
>   	do {
>   		ret = getopt_long(argc, argv, "d:e:ED:", info_opts, NULL);
> @@ -99,14 +102,20 @@ int cmd_idle_set(int argc, char **argv)
>   	if (bitmask_isallclear(cpus_chosen))
>   		bitmask_setall(cpus_chosen);
>   
> +	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
> +	str_len = sysconf(_SC_NPROCESSORS_CONF) * 5;
> +	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
> +

Same comment as before.

>   	for (cpu = bitmask_first(cpus_chosen);
>   	     cpu <= bitmask_last(cpus_chosen); cpu++) {
>   
>   		if (!bitmask_isbitset(cpus_chosen, cpu))
>   			continue;
>   
> -		if (cpupower_is_cpu_online(cpu) != 1)
> +		if (cpupower_is_cpu_online(cpu) != 1) {
> +			bitmask_setbit(offline_cpus, cpu);
>   			continue;
> +		}
>   
>   		idlestates = cpuidle_state_count(cpu);
>   		if (idlestates <= 0)
> @@ -181,5 +190,15 @@ int cmd_idle_set(int argc, char **argv)
>   			break;
>   		}
>   	}
> +
> +	if (!bitmask_isallclear(offline_cpus)) {
> +		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
> +		printf(_("Following CPUs are offline:\n%s\n"),
> +			 offline_cpus_str);
> +		printf(_("CPU idle operation was not performed on them\n"));
> +	}

Same comment as before.

> +	free(offline_cpus_str);
> +	bitmask_free(offline_cpus);
> +

Same comment as before.
>   	return EXIT_SUCCESS;
>   }
> 

thanks,
-- Shuah
