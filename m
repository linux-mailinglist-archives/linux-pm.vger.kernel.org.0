Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E762FFDC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 23:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKRWOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Nov 2022 17:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiKRWOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2022 17:14:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2968CF05
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 14:14:22 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q21so4882531iod.4
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2022 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0LZyNn1p1cSJxDiThQLZut/Lbe4+t/BrHUoCvbULY0=;
        b=FOA8HBV+hbHZmAI9BKzU6fOAWyKzSWjjtGZ6JnM0IPoTibCXqbsb3LLLkaEc/fqFKv
         LzGRbX8z9mSS0YI6r998d1O17iopKsqYEXvThWz8VzlQOvMxRwovhIW7Tt2K4Rkp1jtK
         190hJSsTSEcgYmOav6tgV11Wp7zhKjPeZU3KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0LZyNn1p1cSJxDiThQLZut/Lbe4+t/BrHUoCvbULY0=;
        b=hTf0aMggFdRZne6YpVv0amj5Ds+vzpvdprj0Z2sWiWbvY3OHJ1B8SDnqc6S3pWNPAv
         Rsp0bfITO2z/KXaaYEgazuFBOJVVOjgUUBVCZ6EZ0tm0M8bS/kRAMYe2sgRQyyJIpzqV
         XoxvGvOtrS/Vt2Ww0tU0yr/kP7VLItGZM2xcsIL2rFj8CYEhuj+Sc4gW7j7zzeKnubBW
         nsYLBhiN5AMngPSG6ATwIuzTUvdZ6ApuUTApA2r95pG8qhOg+1WsLb9eANt3eC11zE+k
         VlKSrxJuz43PvR5eew7r+veLdGmunMODLa/bWpKBSSWz9Dbg8UEXunl4YHqMWiTVsmq6
         pzVA==
X-Gm-Message-State: ANoB5pkI/c4Hab7v0IXGa0qO6Wf/EXIcH06mSoU+UGOFYJPpp78pVgD6
        sxEyx8e7C7F3jn1yKg/KgLk9Jg==
X-Google-Smtp-Source: AA0mqf5vAPa1NMVP0jarNDdoVz+LkFGd8HyCNksSM85zZ1y4qaL2IU+a4yQGGUwQuoAU/IPBAPI4Rw==
X-Received: by 2002:a02:7829:0:b0:363:ae32:346f with SMTP id p41-20020a027829000000b00363ae32346fmr4175968jac.31.1668809661416;
        Fri, 18 Nov 2022 14:14:21 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x8-20020a92cc88000000b00302b029131bsm547894ilo.61.2022.11.18.14.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:14:20 -0800 (PST)
Message-ID: <2183a799-df17-c1b1-db8c-92b5886e7a66@linuxfoundation.org>
Date:   Fri, 18 Nov 2022 15:14:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] cpupower: Introduce powercap intel-rapl library
 helpers and powercap-info command
Content-Language: en-US
To:     Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3200810.N7aMVyhfb1@work>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3200810.N7aMVyhfb1@work>
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

Hi Thomas,

On 11/17/22 02:47, Thomas Renninger wrote:
> Read out powercap zone information via:
> cpupower powercap-info
> and show the zone hierarchy to the user:
> 
> ./cpupower powercap-info
> Driver: intel-rapl
> Powercap domain hierarchy:
> 
> Zone: package-0 (enabled)
> Power consumption can be monitored in micro Watts
> 
>          Zone: core (disabled)
>          Power consumption can be monitored in micro Watts
> 
>          Zone: uncore (disabled)
>          Power consumption can be monitored in micro Watts
> 
>          Zone: dram (disabled)
>          Power consumption can be monitored in micro Watts
> 
> There is a dummy -a option for powercap-info which can/should be used to show
> more detailed info later. Like that other args can be added easily later as well.
> 
> A enable/disable option via powercap-set subcommand is also an enhancement
> for later.
> 
> Also not all RAPL domains are shown. The func walking through RAPL subdomains
> is restricted and hardcoded to: "intel-rapl/intel-rapl:0"
> On my system above powercap domains map to:
> intel-rapl/intel-rapl:0
> -> pack (age-0)
> intel-rapl/intel-rapl:0/intel-rapl:0:0
> -> core
> intel-rapl/intel-rapl:0/intel-rapl:0:1
> -> uncore
> 
> Missing ones on my system are:
> intel-rapl-mmio/intel-rapl-mmio:0
> -> pack (age-0)
> 
> intel-rapl/intel-rapl:1
> -> psys
> 
> This could get enhanced in:
> struct powercap_zone *powercap_init_zones()
> and adopted to walk through all intel-rapl zones, but
> also to other powercap drivers like dtpm
> (Dynamic Thermal Power Management framework),
> cmp with: drivers/powercap/dtpm_*
> 

Thanks for the patch. A few comments below

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/Makefile              |  14 ++-
>   tools/power/cpupower/utils/builtin.h       |   2 +
>   tools/power/cpupower/utils/cpupower.c      |   1 +
>   tools/power/cpupower/utils/powercap-info.c | 113 +++++++++++++++++++++
>   4 files changed, 126 insertions(+), 4 deletions(-)
>   create mode 100644 tools/power/cpupower/utils/powercap-info.c
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index e9b6de314654..9fd3b309b3a6 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -133,7 +133,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
>   	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-monitor.o \
>   	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
>   	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
> -	utils/cpuidle-set.o
> +	utils/cpuidle-set.o utils/powercap-info.o
>   
>   UTIL_SRC := $(UTIL_OBJS:.o=.c)
>   
> @@ -143,9 +143,12 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
>   	utils/helpers/bitmask.h \
>   	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
>   
> -LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
> -LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
> -LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
> +LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h \
> +	lib/powercap.h
> +LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c \
> +	lib/powercap.c
> +LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o \
> +	lib/powercap.o
>   LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
>   
>   override CFLAGS +=	-pipe
> @@ -276,6 +279,7 @@ install-lib: libcpupower
>   	$(INSTALL) -d $(DESTDIR)${includedir}
>   	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
>   	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
> +	$(INSTALL_DATA) lib/powercap.h $(DESTDIR)${includedir}/powercap.h
>   
>   install-tools: $(OUTPUT)cpupower
>   	$(INSTALL) -d $(DESTDIR)${bindir}
> @@ -292,6 +296,7 @@ install-man:
>   	$(INSTALL_DATA) -D man/cpupower-set.1 $(DESTDIR)${mandir}/man1/cpupower-set.1
>   	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
>   	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
> +	$(INSTALL_DATA) -D man/cpupower-powercap-info.1 $(DESTDIR)${mandir}/man1/cpupower-powercap-info.1
>   
>   install-gmo: create-gmo
>   	$(INSTALL) -d $(DESTDIR)${localedir}
> @@ -321,6 +326,7 @@ uninstall:
>   	- rm -f $(DESTDIR)${mandir}/man1/cpupower-set.1
>   	- rm -f $(DESTDIR)${mandir}/man1/cpupower-info.1
>   	- rm -f $(DESTDIR)${mandir}/man1/cpupower-monitor.1
> +	- rm -f $(DESTDIR)${mandir}/man1/cpupower-powercap-info.1
>   	- for HLANG in $(LANGUAGES); do \
>   		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
>   	  done;
> diff --git a/tools/power/cpupower/utils/builtin.h b/tools/power/cpupower/utils/builtin.h
> index f7065ae60a14..e1caefd467cd 100644
> --- a/tools/power/cpupower/utils/builtin.h
> +++ b/tools/power/cpupower/utils/builtin.h
> @@ -8,6 +8,8 @@ extern int cmd_freq_set(int argc, const char **argv);
>   extern int cmd_freq_info(int argc, const char **argv);
>   extern int cmd_idle_set(int argc, const char **argv);
>   extern int cmd_idle_info(int argc, const char **argv);
> +extern int cmd_cap_info(int argc, const char **argv);
> +extern int cmd_cap_set(int argc, const char **argv);
>   extern int cmd_monitor(int argc, const char **argv);
>   
>   #endif
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 8ac3304a9957..9ec973165af1 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -54,6 +54,7 @@ static struct cmd_struct commands[] = {
>   	{ "frequency-set",	cmd_freq_set,	1	},
>   	{ "idle-info",		cmd_idle_info,	0	},
>   	{ "idle-set",		cmd_idle_set,	1	},
> +	{ "powercap-info",	cmd_cap_info,	0	},
>   	{ "set",		cmd_set,	1	},
>   	{ "info",		cmd_info,	0	},
>   	{ "monitor",		cmd_monitor,	0	},
> diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
> new file mode 100644
> index 000000000000..989fafe581cf
> --- /dev/null
> +++ b/tools/power/cpupower/utils/powercap-info.c
> @@ -0,0 +1,113 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <getopt.h>
> +
> +#include "powercap.h"
> +#include "helpers/helpers.h"
> +
> +int powercap_show_all = 0;

Globals don't need initualization to 0.

> +
> +static struct option info_opts[] =
> +{

Open brace needs to be on the previous line. A few more errors about
function definitions etc..

Please add SPDX to new files.

Running checkpatch will show you the errors.

Compile failed with ./lib/powercap.o: No such file or directory
I installed libcpupower.so.0.0.1

thanks,
-- Shuah
