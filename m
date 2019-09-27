Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEAEC0BD8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfI0S7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfI0S7y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 14:59:54 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA403207FF;
        Fri, 27 Sep 2019 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569610793;
        bh=E73g80IzW6M1EitSeL0eIccYNXP+iG5cDrk7F+CAOI4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lbk0CZYN7l4OBvnl8OAlF/JVsFiAJJq3vwVUD0lLmU/yX6kt3w+k1OWLrXJHWINsf
         2geCKyLrIXXlCvJYibE1NgOXKyQ5AAk37lHdNwsXf6eEQJwTKA+9FYoPHekUNzxJZL
         RJDe79uBC2uqbPQqBCrp+bjjQAy16oa1v2OhntUA=
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Pu Wen <puwen@hygon.com>,
        Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>, shuah <shuah@kernel.org>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b90697df-e898-31d2-5149-c223cb11ba5c@kernel.org>
Date:   Fri, 27 Sep 2019 12:59:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/18/19 10:34 AM, Natarajan, Janakarajan wrote:
> Modify cpupower to schedule itself on each of the cpus in the system and
> then get the APERF/MPERF register values.
> 
> This is advantageous because an IPI is not generated when a read_msr() is
> executed on the local logical CPU thereby reducing the chance of having
> APERF and MPERF being out of sync.

Somehow this doesn't read right. Is this that you are trying to avoid
APERF and MPERF being out of sync with this change?

This description is rather confusing.

> 
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---
>   .../utils/idle_monitor/mperf_monitor.c        | 38 ++++++++++++++-----
>   1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> index 44806a6dae11..8b072e39c897 100644
> --- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> @@ -10,6 +10,7 @@
>   #include <stdlib.h>
>   #include <string.h>
>   #include <limits.h>
> +#include <sched.h>
>   
>   #include <cpufreq.h>
>   
> @@ -86,15 +87,33 @@ static int mperf_get_tsc(unsigned long long *tsc)
>   	return ret;
>   }
>   
> +static int get_aperf_mperf(int cpu, unsigned long long *aval,
> +			   unsigned long long *mval)
> +{
> +	cpu_set_t set;
> +	int ret;
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);
> +	if (sched_setaffinity(getpid(), sizeof(set), &set) == -1) {
> +		dprint("Could not migrate to cpu: %d\n", cpu);
> +		return 1;
> +	}
> +
> +	ret = read_msr(cpu, MSR_APERF, aval);
> +	ret |= read_msr(cpu, MSR_MPERF, mval);
> +
> +	return ret;
> +}
> +
>   static int mperf_init_stats(unsigned int cpu)
>   {
> -	unsigned long long val;
> +	unsigned long long aval, mval;
>   	int ret;
>   
> -	ret = read_msr(cpu, MSR_APERF, &val);
> -	aperf_previous_count[cpu] = val;
> -	ret |= read_msr(cpu, MSR_MPERF, &val);
> -	mperf_previous_count[cpu] = val;
> +	ret = get_aperf_mperf(cpu, &aval, &mval);

get_aperf_mperf() could return error right? It returns 1 when
sched_setaffinity() fails. Shouldn't the return value checked,
instead of using aval and mval?

> +	aperf_previous_count[cpu] = aval;
> +	mperf_previous_count[cpu] = mval;
>   	is_valid[cpu] = !ret;
>   
>   	return 0;
> @@ -102,13 +121,12 @@ static int mperf_init_stats(unsigned int cpu)
>   
>   static int mperf_measure_stats(unsigned int cpu)
>   {
> -	unsigned long long val;
> +	unsigned long long aval, mval;
>   	int ret;
>   
> -	ret = read_msr(cpu, MSR_APERF, &val);
> -	aperf_current_count[cpu] = val;
> -	ret |= read_msr(cpu, MSR_MPERF, &val);
> -	mperf_current_count[cpu] = val;
> +	ret = get_aperf_mperf(cpu, &aval, &mval);

Same comments as above here.

> +	aperf_current_count[cpu] = aval;
> +	mperf_current_count[cpu] = mval;
>   	is_valid[cpu] = !ret;
>   
>   	return 0;
> 

thanks,
-- Shuah
