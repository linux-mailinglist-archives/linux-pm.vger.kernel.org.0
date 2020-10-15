Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3128F7CD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgJORte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgJORte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 13:49:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6FC061755
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 10:49:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p9so5361170ilr.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYOWF1BxOJgs3HW4IrPbgBxiOJVdF3Iu3s9qsMbPx64=;
        b=dytF5PtpjH9okuF/UTTeaqkfkLwiaj1hQPXouunxg04z+H+I18nv06+Q8VJgDYzV9V
         E4nKyYhPVQuUCXotHu6l/wAN+Q2QPTDYthJ8YtMR10VeII0EnuSgtuIBqI0JT5JU8eoM
         5zSmSd0QI6tr9svj9EAlH2VKl40zXEutYlj5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYOWF1BxOJgs3HW4IrPbgBxiOJVdF3Iu3s9qsMbPx64=;
        b=RZqYSg0lyvWuO7CPk2P2mDaUPB1JrOVaL8SkCY1gLpNOLS4IctKqMQHFTYBMfHt6V4
         lgwjBxGLXkk0sBhzC5y9niisWlO5t5Ttr+JjkKUuB+j2xBuW+Esvpni09mYpCi9f7wCX
         aWjTfxlmWMWIgHJicp9BSOcLKBUZ6aRcH3CyQ/LhDNQ18dD+a+Y0I8h9o5BGgW1W6OsH
         2UkZGOB+09rih3bSv2EnTwcgDBgkdnVjNF/oisPfflSKY/oaxWi2+hbw+RDa4wicOoqx
         HCJZnE8k9WbzvyYEwHhakUR40WDziwY4WvBxYnPPUEq7txf5yaz5Zm1Tea/L2tY2y02D
         IKtQ==
X-Gm-Message-State: AOAM531siSR7fnyXEnFYEyGAYHic2wrISfzb/fo5Fw6kz6KX1+fLrquA
        zf9ZCWkhdVV68f9GwDZ24nMsNA==
X-Google-Smtp-Source: ABdhPJw9fl7Z02uFR9CYvHqI1BjH2MUkOsHHs+9d1vG97kfGUhfzq61cscmcWTvS/nnei6DaHd6wzg==
X-Received: by 2002:a92:1f19:: with SMTP id i25mr4225436ile.198.1602784173587;
        Thu, 15 Oct 2020 10:49:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y26sm3262775iol.24.2020.10.15.10.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 10:49:32 -0700 (PDT)
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
Date:   Thu, 15 Oct 2020 11:49:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015144603.27933-2-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/15/20 8:46 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... instead of poking at the MSR. For that, move the accessor functions
> to misc.c and add a sysfs-writing function too.
>  > There should be no functional changes resulting from this.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>   tools/power/cpupower/lib/cpupower.c          | 23 +++++++++-
>   tools/power/cpupower/lib/cpupower_intern.h   |  5 ++
>   tools/power/cpupower/utils/cpupower-info.c   |  2 +-
>   tools/power/cpupower/utils/cpupower-set.c    |  2 +-
>   tools/power/cpupower/utils/helpers/helpers.h |  8 ++--
>   tools/power/cpupower/utils/helpers/misc.c    | 48 ++++++++++++++++++++
>   tools/power/cpupower/utils/helpers/msr.c     | 28 ------------
>   7 files changed, 81 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
> index 3656e697537e..d2fa4bbecf74 100644
> --- a/tools/power/cpupower/lib/cpupower.c
> +++ b/tools/power/cpupower/lib/cpupower.c
> @@ -16,8 +16,8 @@
>   
>   unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
>   {
> -	int fd;
>   	ssize_t numread;
> +	int fd;
>   

Is there a reason to move "int fd"?

>   	fd = open(path, O_RDONLY);
>   	if (fd == -1)
> @@ -35,6 +35,27 @@ unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
>   	return (unsigned int) numread;
>   }
>   
> +unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen)
> +{
> +	ssize_t numwritten;
> +	int fd;
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd == -1)
> +		return 0;
> +
> +	numwritten = write(fd, buf, buflen - 1);
> +	if (numwritten < 1) {
> +		perror("write failed");

Please add filename to the error message

> +		close(fd);
> +		return -1;
> +	}
> +
> +	close(fd);
> +
> +	return (unsigned int) numwritten;
> +}
> +
>   /*
>    * Detect whether a CPU is online
>    *
> diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
> index 4887c76d23f8..ac1112b956ec 100644
> --- a/tools/power/cpupower/lib/cpupower_intern.h
> +++ b/tools/power/cpupower/lib/cpupower_intern.h
> @@ -1,6 +1,11 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #define PATH_TO_CPU "/sys/devices/system/cpu/"
> +
> +#ifndef MAX_LINE_LEN
>   #define MAX_LINE_LEN 4096
> +#endif
> +
>   #define SYSFS_PATH_MAX 255
>   
>   unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
> +unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
> diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
> index 0ba61a2c4d81..06345b543786 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -101,7 +101,7 @@ int cmd_info(int argc, char **argv)
>   		}
>   
>   		if (params.perf_bias) {
> -			ret = msr_intel_get_perf_bias(cpu);
> +			ret = cpupower_intel_get_perf_bias(cpu);
>   			if (ret < 0) {
>   				fprintf(stderr,
>   			_("Could not read perf-bias value[%d]\n"), ret);
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 052044d7e012..180d5ba877e6 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -95,7 +95,7 @@ int cmd_set(int argc, char **argv)
>   		}
>   
>   		if (params.perf_bias) {
> -			ret = msr_intel_set_perf_bias(cpu, perf_bias);
> +			ret = cpupower_intel_set_perf_bias(cpu, perf_bias);
>   			if (ret) {
>   				fprintf(stderr, _("Error setting perf-bias "
>   						  "value on CPU %d\n"), cpu);
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index c258eeccd05f..37dac161f3fe 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -105,8 +105,8 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
>   extern int read_msr(int cpu, unsigned int idx, unsigned long long *val);
>   extern int write_msr(int cpu, unsigned int idx, unsigned long long val);
>   
> -extern int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> -extern int msr_intel_get_perf_bias(unsigned int cpu);
> +extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
> +extern int cpupower_intel_get_perf_bias(unsigned int cpu);
>   extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
>   
>   /* Read/Write msr ****************************/
> @@ -150,9 +150,9 @@ static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)
>   { return -1; };
>   static inline int write_msr(int cpu, unsigned int idx, unsigned long long val)
>   { return -1; };
> -static inline int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> +static inline int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
>   { return -1; };
> -static inline int msr_intel_get_perf_bias(unsigned int cpu)
> +static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
>   { return -1; };
>   static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>   { return 0; };
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index f406adc40bad..e8f8f643a627 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -1,7 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
>   #if defined(__i386__) || defined(__x86_64__)
>   
>   #include "helpers/helpers.h"
> +#include "helpers/sysfs.h"
> +
> +#include "cpupower_intern.h"
>   
>   #define MSR_AMD_HWCR	0xc0010015
>   
> @@ -40,4 +48,44 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>   		*support = *active = 1;
>   	return 0;
>   }
> +
> +int cpupower_intel_get_perf_bias(unsigned int cpu)
> +{
> +	char linebuf[MAX_LINE_LEN];
> +	char path[SYSFS_PATH_MAX];
> +	unsigned long val;
> +	char *endp;
> +
> +	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
> +		return -1;
> +
> +	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);

Please add return check for snprintf, please add a define for
"cpu%u/power/energy_perf_bias" since it is hardcoded in
read/write functions.

> +
> +	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
> +		return -1;
> +
> +	val = strtol(linebuf, &endp, 0);
> +	if (endp == linebuf || errno == ERANGE)
> +		return -1;
> +
> +	return val;
> +}
> +
> +int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> +{
> +	char path[SYSFS_PATH_MAX];
> +	char linebuf[3] = {};
> +
> +	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
> +		return -1;
> +
> +	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);

Please add return check for snprintf, please add a define for
"cpu%u/power/energy_perf_bias" since it is hardcoded in
read/write functions.

> +	snprintf(linebuf, sizeof(linebuf), "%d", val);

return value check?

> +
> +	if (cpupower_write_sysfs(path, linebuf, 3) <= 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   #endif /* #if defined(__i386__) || defined(__x86_64__) */
> diff --git a/tools/power/cpupower/utils/helpers/msr.c b/tools/power/cpupower/utils/helpers/msr.c
> index ab9950748838..8b0b6be74bb8 100644
> --- a/tools/power/cpupower/utils/helpers/msr.c
> +++ b/tools/power/cpupower/utils/helpers/msr.c
> @@ -11,7 +11,6 @@
>   /* Intel specific MSRs */
>   #define MSR_IA32_PERF_STATUS		0x198
>   #define MSR_IA32_MISC_ENABLES		0x1a0
> -#define MSR_IA32_ENERGY_PERF_BIAS	0x1b0
>   #define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1ad
>   
>   /*
> @@ -73,33 +72,6 @@ int write_msr(int cpu, unsigned int idx, unsigned long long val)
>   	return -1;
>   }
>   
> -int msr_intel_get_perf_bias(unsigned int cpu)
> -{
> -	unsigned long long val;
> -	int ret;
> -
> -	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
> -		return -1;
> -
> -	ret = read_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &val);
> -	if (ret)
> -		return ret;
> -	return val;
> -}
> -
> -int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> -{
> -	int ret;
> -
> -	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
> -		return -1;
> -
> -	ret = write_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, val);
> -	if (ret)
> -		return ret;
> -	return 0;
> -}
> -
>   unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
>   {
>   	unsigned long long val;
> 

thnaks,
-- Shuah
