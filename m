Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F11987F
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEJGi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 02:38:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53548 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfEJGi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 02:38:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so6108151wme.3;
        Thu, 09 May 2019 23:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFp57boJpfFhBFAlb/ed9iGf+JEpk1sdcUGlB20djWg=;
        b=oG3NSzC6Lua47W6H00tTMGdYhVpuhfUAj4P5VckCsd0W1KK+c8JX2wxAvabs3lxa4I
         IWQA6nIPTe7WkUqzGTKXKwruQQwbWV7AOgmVWf+fIgT4T5IQ8glfHOufg9KFh72GSY5h
         RbbINPGDpCarsFSv8YlIcv99uRBCpg3Ieu5Zr4nZbg5iy97gwlE5EK8ayQ8zoeZMkduI
         jr7mV45gse4HiLbHYAdSqL0kpyieIghhBaBJ/AjBW7KxP3c2xyOTKDm6RtyqCPM8cEnj
         YtoKJ7ygkvUQpxeJweXUI5/q64/MjRXeR0GnYRwEKmFmsFZZEXCXQM6g2Uu7u1Qf58mC
         F/GA==
X-Gm-Message-State: APjAAAVkNdULo6KiEZgaJ4wrVWw1/sQZjkQBOQrbyb5nxmrjWBu7R+gs
        LMF9DhjNpoxmUKiCjRkA3w==
X-Google-Smtp-Source: APXvYqy0ffVTpZ93KEfreFdAk/op7nwYCihsXMgZGjbL+ijh1TtplNVyEONJ+ltirTEFGVqEzrCV+A==
X-Received: by 2002:a1c:1a49:: with SMTP id a70mr5297420wma.120.1557470336581;
        Thu, 09 May 2019 23:38:56 -0700 (PDT)
Received: from tesla ([2a02:c7d:8e07:7c00:3e97:eff:feb3:72f1])
        by smtp.googlemail.com with ESMTPSA id s3sm6811893wre.97.2019.05.09.23.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 23:38:55 -0700 (PDT)
Received: from javi by tesla with local (Exim 4.92)
        (envelope-from <javi@tesla>)
        id 1hOzBG-0004dh-7s; Fri, 10 May 2019 07:38:54 +0100
Date:   Fri, 10 May 2019 07:38:54 +0100
From:   Javi Merino <javi.merino@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Actually trace CPU load in
 thermal_power_cpu_get_power
Message-ID: <20190510063854.GA20477@tesla>
References: <20190502183238.182058-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502183238.182058-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 02, 2019 at 11:32:38AM -0700, Matthias Kaehlcke wrote:
> The CPU load values passed to the thermal_power_cpu_get_power
> tracepoint are zero for all CPUs, unless, unless the
> thermal_power_cpu_limit tracepoint is enabled too:
> 
>   irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815
> 
> vs
> 
>   irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
>   irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
>   cpus=0000000f freq=408000 cdev_state=10 power=416
> 
> There seems to be no good reason for omitting the CPU load information
> depending on another tracepoint. My guess is that the intention was to
> check whether thermal_power_cpu_get_power is (still) enabled, however
> 'load_cpu != NULL' already indicates that it was at least enabled when
> cpufreq_get_requested_power() was entered, there seems little gain
> from omitting the assignment if the tracepoint was just disabled, so
> just remove the check.
> 
> Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Yep, looks good to me.

Acked-by: Javi Merino <javi.merino@kernel.org>

> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..b437804e099b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -458,7 +458,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  			load = 0;
>  
>  		total_load += load;
> -		if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
> +		if (load_cpu)
>  			load_cpu[i] = load;
>  
>  		i++;
> -- 
> 2.21.0.593.g511ec345e18-goog
> 
