Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8698962FFDE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKRWOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 17:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKRWOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 17:14:33 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF7AB0E5
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 14:14:30 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z9so3192645ilu.10
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6U9vhhCc0ZjI0G127iNmS3dIx5ibCy+aRfyyuxLbfjA=;
        b=L7xOllGZ6TnzfDyUFeI/jJz+1kZUS0TG19c0mWmcPZwD/hvjPHv0FdmyR1pfw0j6P1
         VuWDQvr6SzErIqXXJMPA1xHRf8t/DQ1KgrPMedMpuopUgBV0voZt+78J42rcbGuKtFbB
         fh3FzYOD0SPny0f5Cppx0yxpd83b5QhOt/xbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6U9vhhCc0ZjI0G127iNmS3dIx5ibCy+aRfyyuxLbfjA=;
        b=tf2XiPmN5PqQc5t3s8+KdmSJrDmCcwvaXmVhG2xa+zL7jVPOdC6dCwa9f01ZYvazOI
         8lvuX46HJ8lruCBWxUQmKU+nFkagdIPPEUzbrdL3derYyKIyhnT6PSzk3UwMVwOD8LXp
         04IDd/05Aw3Rrc3+Gjlf+If9jvFJaQ7gZuApkYPThytU1w7xKP7JPVaQ/mZzI5gIg5wH
         DzchflGBB/XtGyD+dyYPL7OPbkNAadoWxpp2scP3zGNIXhhqAAHNpu1MxhF9G5+88N5V
         RCrTlfj8sFFFDhfNcAkftdRyE4Ncf0XMAnMGHGBYihcCr7tqg8bl76qqDJnXu/aRkV+/
         lyrQ==
X-Gm-Message-State: ANoB5plnV003rlaS+JI7+yMYorZtLrXDIJBdLIjb6ABFV+GSMxtQMQvj
        sQxhNrR7+HTw4TB/dPDeqU2TCg==
X-Google-Smtp-Source: AA0mqf6OQ8dPbqQAfBChS/r+Fev/jd3NTggvFOd1iVcX2johtpsNJkga39EEXWhPO33kN6sov1dqYg==
X-Received: by 2002:a92:a304:0:b0:302:504e:e289 with SMTP id a4-20020a92a304000000b00302504ee289mr4187831ili.129.1668809669865;
        Fri, 18 Nov 2022 14:14:29 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h22-20020a02c736000000b00365ddf7d1d8sm1576859jao.53.2022.11.18.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:14:29 -0800 (PST)
Message-ID: <09824a12-bf79-2dc1-9656-34d30beb037b@linuxfoundation.org>
Date:   Fri, 18 Nov 2022 15:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] cpupower: rapl monitor - shows the used power
 consumption in uj for each rapl domain
Content-Language: en-US
To:     Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <14777287.JCcGWNJJiE@work>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <14777287.JCcGWNJJiE@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/17/22 02:48, Thomas Renninger wrote:
> This CPU power monitor shows the power consumption
> as exposed by the powercap subsystem, cmp with:
> Documentation/power/powercap/powercap.rst
> 
> cpupower monitor -m RAPL
>   CPU| pack | core | unco
>     0|6853926|967832|442381
>     8|6853926|967832|442381
>     1|6853926|967832|442381
>     9|6853926|967832|442381
> 
> Unfortunately RAPL domains cannot be directly mapped to the corresponding
> CPU socket/package, core it belongs to.
> Not sure this is possible at all with the current data exposed from the kernel.
> 
> Still it can be worthful information for developers trying to optimize
> power consumption of workloads or their system in general.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/Makefile                 |   1 +
>   .../utils/idle_monitor/cpupower-monitor.c     |   7 +-
>   .../utils/idle_monitor/idle_monitors.def      |   1 +
>   .../utils/idle_monitor/rapl_monitor.c         | 147 ++++++++++++++++++
>   4 files changed, 153 insertions(+), 3 deletions(-)
>   create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 9fd3b309b3a6..59bfa05dec5d 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -131,6 +131,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
>   	utils/idle_monitor/hsw_ext_idle.o \
>   	utils/idle_monitor/amd_fam14h_idle.o utils/idle_monitor/cpuidle_sysfs.o \
>   	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-monitor.o \
> +	utils/idle_monitor/rapl_monitor.o \
>   	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
>   	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
>   	utils/cpuidle-set.o utils/powercap-info.o
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 7c77045fef52..075e766ff1f3 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -459,9 +459,10 @@ int cmd_monitor(int argc, char **argv)
>   			print_results(1, cpu);
>   	}
>   
> -	for (num = 0; num < avail_monitors; num++)
> -		monitors[num]->unregister();
> -
> +	for (num = 0; num < avail_monitors; num++) {
> +		if (monitors[num]->unregister)
> +			monitors[num]->unregister();
> +	}
>   	cpu_topology_release(cpu_top);
>   	return 0;
>   }
> diff --git a/tools/power/cpupower/utils/idle_monitor/idle_monitors.def b/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
> index 0d6ba4dbb9c7..7c926e90c87e 100644
> --- a/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
> +++ b/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
> @@ -4,5 +4,6 @@ DEF(intel_nhm)
>   DEF(intel_snb)
>   DEF(intel_hsw_ext)
>   DEF(mperf)
> +DEF(rapl)
>   #endif
>   DEF(cpuidle_sysfs)
> diff --git a/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c b/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
> new file mode 100644
> index 000000000000..1acadf5ef90e
> --- /dev/null
> +++ b/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
> @@ -0,0 +1,147 @@
> +/*
> + *  (C) 2016      Thomas Renninger <trenn@suse.com>
> + *
> + *  Licensed under the terms of the GNU GPL License version 2.

Missing SPDX - please add

> + *
> + */
> +
> +#if defined(__i386__) || defined(__x86_64__)

I am seeing checpatch errors in this one as well in addition to
missing SPDX.

Running checkpatch will show you some of the errors.

thanks,
-- Shuah
