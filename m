Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF0818EE6D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 04:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCWDSp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 23:18:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51419 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCWDSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 23:18:45 -0400
Received: by mail-pj1-f65.google.com with SMTP id hg10so5513255pjb.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aMIzTIHWSoQEuD3NW13lJVBAL+BLE12hWj2KYBO7txM=;
        b=S1YSH0Q/6tQP2M8Q1UwsLzzUyHLw6bppQVF1Ha5ktef5mmvYNF1a3jHHwm1D85PIog
         6KTN5gH2fCJwEin7BwM/RqJwZplQsswobQSYalBEbrsVo1qM6QgiPB5ycwcQbJ/UNM/i
         A61/X6MSqWEDH+T4pLUGx/NDv2Wdxjo7uqdKxGL8KyssPyhx5Q8oe0hUGVyaxp+TohOJ
         FqbrUWct6+ejA/t5UgcM3UOBT+qLLEDsDBDu32+5w7rpjvsbJdlfHZcnCpd8igflGtTJ
         bzSl9JdLebueNglDgX+smG5EgZImeGuiolkgLqThV5bl9Tmwj5r0UgTUAGagPnf5mk3N
         6ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aMIzTIHWSoQEuD3NW13lJVBAL+BLE12hWj2KYBO7txM=;
        b=FHN72cbEBQGpDe0nqjjkUN5BMv9jQmFY7lmikCcjpE8BbAbP+kwO5RJGaS+T4MEhbl
         FUg7eKg1Cjqf1bOflbFOzhsbdOqYEwgxa4fpKkaKidDE//RSj9Fny6VhOQq1wN/yxf8o
         XHyYyiHUN5ruoHz4CzQEjS2KmpfvQ4Rkm7Ow22MYkgUYz36cEH8RY0DMd4Y29xBxu3bp
         rK3UX7fr4LpecZDGTXvbAuDIztUFxWJSbbaMOWCufYaotW8tFl1liGpM9gEq9XtA4kth
         vfSrF9SoXOaxsB7k+OgxG4zBC1u9cLcFNubWvnCc2yB6AFlaIJUns39eXVOzMHr1MGfC
         srMQ==
X-Gm-Message-State: ANhLgQ0rZTjZ8Jec3G2jOvF8o3K/++zZdtCOkj5zZYHir1ABJf/UGLwq
        q6wIOXvXlCBFTqQGNmmHoEkPvA==
X-Google-Smtp-Source: ADFU+vu8k9GI5cnzzbIwLy/DS7vxGfnesH9BGW3MYJZxorO/F/gtqw4J5cxkWEf67HBbY+LMsmk/vg==
X-Received: by 2002:a17:90a:757:: with SMTP id s23mr22938559pje.166.1584933523923;
        Sun, 22 Mar 2020 20:18:43 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id 184sm10578687pgb.52.2020.03.22.20.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 20:18:43 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:48:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Remove abusing WARN_ON
Message-ID: <20200323031833.fefxzvl7q2t5dn3i@vireshk-i7>
References: <20200321193107.21590-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321193107.21590-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-03-20, 20:31, Daniel Lezcano wrote:
> The WARN_ON macros are used at the entry functions state2power() and
> set_cur_state().
> 
> state2power() is called with the max_state retrieved from
> get_max_state which returns cpufreq_cdev->max_level, then it check if
> max_state is > cpufreq_cdev->max_level. The test does not really makes
> sense but let's assume we want to make sure to catch an error if the
> code evolves. However the WARN_ON is overkill.
> 
> set_cur_state() is also called from userspace if we write to the
> sysfs. It is easy to see a stack dumped by just writing to sysfs
> /sys/class/thermal/cooling_device0/cur_state a value greater than
> "max_level". A bit scary. Returing -EINVAL is enough.
> 
> Remove these WARN_ON.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index af55ac08e1bd..d66791a71320 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -273,7 +273,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>  
>  	/* Request state should be less than max_level */
> -	if (WARN_ON(state > cpufreq_cdev->max_level))
> +	if (state > cpufreq_cdev->max_level)
>  		return -EINVAL;
>  
>  	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
> @@ -434,7 +434,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	int ret;
>  
>  	/* Request state should be less than max_level */
> -	if (WARN_ON(state > cpufreq_cdev->max_level))
> +	if (state > cpufreq_cdev->max_level)
>  		return -EINVAL;
>  
>  	/* Check if the old cooling action is same as new cooling action */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>


-- 
viresh
