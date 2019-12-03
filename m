Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94B10F9B7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfLCIUT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 03:20:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38979 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfLCIUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 03:20:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so1211365pjb.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 00:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGX/Qw/QlAgVNhbc/CwDXm2ZrxOehhMz8zofTjV1tOE=;
        b=OJIsuzgzNGmRV0oijngBJXHD1RhjsjgMEBxYJkrxN6bRa0/YoZgPQ882PIUtLO8C48
         6pB3KozspwEMvRWTBwVj4a0p4GM6wMMEV69k7G89dgd7GtxN7/ZEwosYfawGxDx3ueAc
         yac8jrt2dzJ7bUzjpgsZEZgSyDL+rhlQcUAUEkRKoZ1CAK80Wr+PfmilSzr4E8n3ZH7B
         cNYEQ6Jh7QbV+nhcAw2m049J9atvvHHBcjWpaDIwRMDPbw5ZDFU7BlbgvsfgdZVZAHJ+
         X/W9uu60vCySUthEbwHFfSJ68nkntiXLSCdQOXZ3+jUWSHeBQCFr6wRzqcGIrI+W1goD
         jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGX/Qw/QlAgVNhbc/CwDXm2ZrxOehhMz8zofTjV1tOE=;
        b=gHt4Oh9YoyAoy/nQzOkxtNN6ED8X7XIIF9a/edUTT/SsDnXiKIjR9SQiK4ZLUCdln0
         05sRTk8edGuOYmExOZ4C2cm5Qq9LyBioXGnbTfYKEfZajzTAs2DDVMglll3GJThLMZKb
         cz5fwS24p9jue6ScBh/jQHYp2PQYbWBvseklZs1S7CmL70SLy5/zjVV3DQ3BZWnW7Qvk
         KkoYWvMu84QkaDN+8Ix7IxCNxUTGaXPKRJZTl5gdvqMJkhs+L0jZ17ryy8YTHBHMYvAc
         UiTEnZgJFTaOL0ZkVRWjEvXaQgKLAfBaYjZcJe4nmfsFFMabZwS5tLzxM32yL9oGX/ee
         Zmvw==
X-Gm-Message-State: APjAAAV6fdcVVWA2GYrbYpbzlEnAAzkYU6V3Tx9qzP28CwGVfQPYwkxv
        i7B4jxpdTrniftyRbarRukNWBw==
X-Google-Smtp-Source: APXvYqyaVfBGooL9JepKXPJ5LeTcCb6fJCU9gsU8lH/OhfBnTDrtp7m6iPiwQY58K9rnXAELuK1+NQ==
X-Received: by 2002:a17:90a:9bc7:: with SMTP id b7mr4191398pjw.72.1575361218554;
        Tue, 03 Dec 2019 00:20:18 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id g7sm2488969pfq.33.2019.12.03.00.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 00:20:17 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:50:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/4] thermal/drivers/cpu_cooling: Rename to
 cpufreq_cooling
Message-ID: <20191203082016.i5imbaxk6glapmo6@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-4-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> As we introduced the idle injection cooling device called
> cpuidle_cooling, let's be consistent and rename the cpu_cooling to
> cpufreq_cooling as this one mitigates with OPPs changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Makefile                             | 2 +-
>  drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (100%)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9c8aa2d4bd28..5c98472ffd8b 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
>  thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
>  
>  # cpufreq cooling
> -thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
> +thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
>  thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
>  
>  # clock cooling
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpufreq_cooling.c
> similarity index 100%
> rename from drivers/thermal/cpu_cooling.c
> rename to drivers/thermal/cpufreq_cooling.c

This isn't enough. Please grep for cpu_cooling and you will see other places
that you need to fix as well :)

-- 
viresh
