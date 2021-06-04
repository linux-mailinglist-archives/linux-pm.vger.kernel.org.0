Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3039B11E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 05:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDDuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 23:50:13 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37849 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDDuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 23:50:12 -0400
Received: by mail-pf1-f182.google.com with SMTP id y15so6487853pfl.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIq+JVIVR9DjAt6LSJSdRSoXJZoMpMbdkGfBUXWctS8=;
        b=MLa6uHvz/HBRNKFlje+iv6q7NwcrPZZLfLn72Auow2MiBy9pXci6zDSsVtz093uJAQ
         tI2l7rOo5uSkQTM3OLvDb71ZAStKA4kYtUGedUNpqGfacmpPpQbBtiDOfjyVKaEdlDG9
         05yUJ5lAHQVrD94AKI0UneZBLVGoIcr+bX5to7eO7yq0PYK7EhlL1b6Ye5MaO/ENje7Q
         UFfa0CXyEclTLRcfL6hvzL3FFLN9XPQ+5DNPc/lkeEJnZnXZFIWoj/1hnTpM4Jle0jJw
         q/NxexA90JJcPCe+2pIQ2U1mqW1wKQZQkofCHOuIJDTZTwfHlZRSIdWWi9PdWMfgdrWu
         MBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIq+JVIVR9DjAt6LSJSdRSoXJZoMpMbdkGfBUXWctS8=;
        b=MDDr53qFYofbVQ+fMG/bG8a5hwv4pnoSkch+O+ZyODvh2dkKkALGYqPOTZ3ep92WtX
         4TBo9kM46ha0HVhY1uqR1dMtcKn6dbflePNcJF5oKVggxdv0MN17dd3Fv0GofbAnV0X7
         p7Ct1IWp4DSWQ96CvpFkuqeN2d8HxyaxxsI3tnaLpkg/daHjFfZSDmUGgTRW6k/1lDMe
         2FH8BuA3SbKY+hkgSFhDMMW2qAE1AKaCBLSff1VCSRTRItzIAZoOYIpbwlUgbNoM93TR
         B8QWVYu38FCTDCn2zUmcOO+WYHHqiRs+tcU3Q7RzMM68P3reNPmZI6pKkSOhbLldYbn1
         xOJA==
X-Gm-Message-State: AOAM531+rQfkabfUlwPnyA0765KNYTH3gNzjoSztss1W9QjmpYn9GBaQ
        /ibzeA83RyTLFaLX/xEgrSWQ6Q==
X-Google-Smtp-Source: ABdhPJxPYL3u14YlbpACeDySBpftc5/sS7Ra4HGar7+d8+9245hYpnWmvs5a96W4jbVQ38b28AS5mg==
X-Received: by 2002:a63:af46:: with SMTP id s6mr2802591pgo.446.1622778434301;
        Thu, 03 Jun 2021 20:47:14 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id t1sm488715pgl.40.2021.06.03.20.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:47:13 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:17:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hailong Liu <liuhailongg6@163.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] CPUFREQ: loongson2: Remove unused linux/sched.h headers
Message-ID: <20210604034709.kxqy6vcfvtxf5rje@vireshk-i7>
References: <20210603135752.30162-1-liuhailongg6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603135752.30162-1-liuhailongg6@163.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-21, 21:57, Hailong Liu wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Since commit 759f534e93ac(CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()),
> the header <linux/sched.h> is useless in oongson2_cpufreq.c, so remove it.
> 
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index d05e761d9572..afc59b292153 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -16,7 +16,6 @@
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
> -#include <linux/sched.h>	/* set_cpus_allowed() */
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
