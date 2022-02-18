Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4774BC30D
	for <lists+linux-pm@lfdr.de>; Sat, 19 Feb 2022 00:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiBRXyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Feb 2022 18:54:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiBRXyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Feb 2022 18:54:12 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D840A16
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 15:53:54 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e79so9444988iof.13
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 15:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rOpUiR8n3d/m0SdjK8sAMw/3CX7PN8XqlvE3BZ5rD0k=;
        b=EGE1LgCBRl3NkHrHJw/T6Giq8BHqYXQjHi+CLUSqJR3UyprEz0GI72cPWPOH4usAiu
         OuslpHfqCLmRXJHhk6EL3QXf8NnPRpsgTtfbqyJSnVTX6ZYBOUYVb/78tXu5mlOIkm7d
         jX282FuwadAI0JSrM8kDvO44jcXyPPhyIxTMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rOpUiR8n3d/m0SdjK8sAMw/3CX7PN8XqlvE3BZ5rD0k=;
        b=MELTlMsKEjd3aic86Zfe9imhsEEdmrn10+2iNfqjgZiab9xHNA9a/3bAPrlxTYs+z+
         nB278Bw3L7bxT9QzAiq4hKX5d4d9HKQrNYkwS4mtaLkG4pjK9zuLmT4fL6qOcWnY9No6
         NRf2mnu9EpwzVzmU+iscZAYilCrIzmkJZlRtHlCp16YVsMbSiM5nz7F+jFaCF1c1Np9E
         lbF93/luCHcxqo9pnttPV3aSF6Pm2ArUoZUW7Co8fi6qB2EbTOcR7fuVT4tOZgnElpVR
         /j9eljl+QeICk72OxIpiIVVwPRGfutdnax7qOWveFR3XOMmB+dmfhfWV0hDG+kWoYSk5
         iHJA==
X-Gm-Message-State: AOAM533bdsiwTw6W/oTfC2Up8t6n5K4whAN7MsbF7MF/tWpoz5nSVhdR
        BBd9GlUWIww4FFofcxQiSvkn8g==
X-Google-Smtp-Source: ABdhPJySxT0XluO0lLx8upzk8DdrfyQukZiJ56ChtE9EZNjdGXUhefD/cOScpUE2bMZuEOdTMtOBlA==
X-Received: by 2002:a05:6638:1405:b0:30d:69cd:f44 with SMTP id k5-20020a056638140500b0030d69cd0f44mr6883109jad.208.1645228433847;
        Fri, 18 Feb 2022 15:53:53 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r7sm2317316ilc.24.2022.02.18.15.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 15:53:53 -0800 (PST)
Subject: Re: [PATCH RESEND v6 5/9] cpupower: Introduce ACPI CPPC library
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-6-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5e7bfce4-f326-930b-4a25-15538f741167@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 16:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216073558.751071-6-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/16/22 12:35 AM, Huang Rui wrote:
> Kernel ACPI subsytem introduced the sysfs attributes for acpi cppc
> library in below path:
> 
> /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> And these attributes will be used for AMD P-State driver to provide some
> performance and frequency values.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/Makefile        |  6 +--
>   tools/power/cpupower/lib/acpi_cppc.c | 59 ++++++++++++++++++++++++++++
>   tools/power/cpupower/lib/acpi_cppc.h | 21 ++++++++++
>   3 files changed, 83 insertions(+), 3 deletions(-)
>   create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
>   create mode 100644 tools/power/cpupower/lib/acpi_cppc.h
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 3b1594447f29..e9b6de314654 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
>   	utils/helpers/bitmask.h \
>   	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
>   
> -LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
> -LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
> -LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
> +LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
> +LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
> +LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
>   LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
>   
>   override CFLAGS +=	-pipe
> diff --git a/tools/power/cpupower/lib/acpi_cppc.c b/tools/power/cpupower/lib/acpi_cppc.c
> new file mode 100644
> index 000000000000..a07a8922eca2
> --- /dev/null
> +++ b/tools/power/cpupower/lib/acpi_cppc.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include "cpupower_intern.h"
> +#include "acpi_cppc.h"
> +
> +/* ACPI CPPC sysfs access ***********************************************/
> +
> +static int acpi_cppc_read_file(unsigned int cpu, const char *fname,
> +			       char *buf, size_t buflen)
> +{
> +	char path[SYSFS_PATH_MAX];
> +
> +	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/acpi_cppc/%s",
> +		 cpu, fname);
> +	return cpupower_read_sysfs(path, buf, buflen);
> +}
> +
> +static const char *acpi_cppc_value_files[] = {
> +	[HIGHEST_PERF] = "highest_perf",
> +	[LOWEST_PERF] = "lowest_perf",
> +	[NOMINAL_PERF] = "nominal_perf",
> +	[LOWEST_NONLINEAR_PERF] = "lowest_nonlinear_perf",
> +	[LOWEST_FREQ] = "lowest_freq",
> +	[NOMINAL_FREQ] = "nominal_freq",
> +	[REFERENCE_PERF] = "reference_perf",
> +	[WRAPAROUND_TIME] = "wraparound_time"
> +};
> +
> +unsigned long acpi_cppc_get_data(unsigned cpu, enum acpi_cppc_value which)

unsigned int cpu

> +{
> +	unsigned long long value;
> +	unsigned int len;
> +	char linebuf[MAX_LINE_LEN];
> +	char *endp;
> +
> +	if (which >= MAX_CPPC_VALUE_FILES)
> +		return 0;
> +
> +	len = acpi_cppc_read_file(cpu, acpi_cppc_value_files[which],
> +				  linebuf, sizeof(linebuf));
> +	if (len == 0)
> +		return 0;
> +
> +	value = strtoull(linebuf, &endp, 0);
> +
> +	if (endp == linebuf || errno == ERANGE)
> +		return 0;
> +
> +	return value;
> +}
> diff --git a/tools/power/cpupower/lib/acpi_cppc.h b/tools/power/cpupower/lib/acpi_cppc.h
> new file mode 100644
> index 000000000000..576291155224
> --- /dev/null
> +++ b/tools/power/cpupower/lib/acpi_cppc.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_CPPC_H__
> +#define __ACPI_CPPC_H__
> +
> +enum acpi_cppc_value {
> +	HIGHEST_PERF,
> +	LOWEST_PERF,
> +	NOMINAL_PERF,
> +	LOWEST_NONLINEAR_PERF,
> +	LOWEST_FREQ,
> +	NOMINAL_FREQ,
> +	REFERENCE_PERF,
> +	WRAPAROUND_TIME,
> +	MAX_CPPC_VALUE_FILES
> +};
> +
> +extern unsigned long acpi_cppc_get_data(unsigned cpu,

extern prototype in .h?

unsigned int cpu

> +					enum acpi_cppc_value which);
> +
> +#endif /* _ACPI_CPPC_H */
> 

thanks,
-- Shuah
