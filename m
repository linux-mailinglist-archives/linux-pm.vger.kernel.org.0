Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230934645D7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 05:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhLAE0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 23:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbhLAE0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 23:26:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D69C061746
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 20:22:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so20011950pja.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 20:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcEgUb04R0YIKBDc5kvecvt8guIN0oPTGgU6hhekSu0=;
        b=Q+FqR0omf3x58asYe8TRsohqyc0Ftl64Wy5Ldc49srOjgSzl7ix9XV+NwaB0s8PTWR
         zBJWU4N46xQXSzrdboG6fM+UXEbKpfuc53UQQPgisZqGXiAhfP+lpL+ptKVd6OnzM6eK
         3o+I4BE27Xva4DcBcs0ULTO5JiNEC0tpaqeYibwS+djed+1LKhn9QGzfMCNBWsKL6ghT
         nyILfe/8ZeC6DMVV1xSUMbf8x2iTIfv046z8G78+7raPFK4cI7NFlPS8GnouAp0RdNqb
         hUBYkw+mriRfcEB9ab8bLAxSxs7nuqYnP5DT+fgUzUuoKQwDVrg0UhAj50txsDZJqEp3
         lmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcEgUb04R0YIKBDc5kvecvt8guIN0oPTGgU6hhekSu0=;
        b=1k6ZGjdYMlKx6IPZbOCSz19oFyItI9yqdfZUBgiSw4CNeGQdh/OzR3ArpMEEs7UTsD
         3k+c/2ryy6s30sco2QmQOGCGlPlawSWuJer5ttOYARFBUvg9IuYbuveSUJPkp76CVeI+
         Ssx0gfHKo7GfiT26GY1OCrYRuq3a3/c+TL6HvhvdjapdjVeLWyRnIeSg/H7TJA5IXtPi
         Qa1aWS4Do8BLF+m57HPsdcv7WrQ2kq+zSOo626/JGCS6+yeH11Vjka9Pzhsv0iUCq69g
         ZHXiDias4xrpU89bqWXXHrc2fkeqJ7zzCK9WE4ZTWaL73Msgo4Rju2bek4Mtgwu4KJ4T
         8U+g==
X-Gm-Message-State: AOAM530kVTZA4EeCdT8/BBIEftxwyv85qyKr6KJJPi4op3uF7MwBCiy3
        ZCEYTqL15eMUQsm2mebqbOlAFY1M+F7VjA==
X-Google-Smtp-Source: ABdhPJy9hdpC3ssfbbj7x5V7ord8tThcCm3TuGFJADITSmAvHAGv5STODM1ktC6xanOBU8PkuSJIHw==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr4427177plg.17.1638332569617;
        Tue, 30 Nov 2021 20:22:49 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id j6sm22927805pfu.205.2021.11.30.20.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 20:22:49 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:52:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Message-ID: <20211201042245.amxgyevar6gjbkfb@vireshk-i7>
References: <20211130151526.949-1-tangyizhou@huawei.com>
 <20211130151526.949-2-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130151526.949-2-tangyizhou@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-11-21, 23:15, Tang Yizhou wrote:
> The comment is inconsistent with the block_notifier_call_chain() call,
> so fix it.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..8f753675e4a2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1296,7 +1296,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  
>  	if (policy->max_freq_req) {
>  		/*
> -		 * CPUFREQ_CREATE_POLICY notification is sent only after
> +		 * CPUFREQ_REMOVE_POLICY notification is sent only after

No, the earlier comment is correct. It says when the CREATE notification was
sent and so we need to do the remove here before removing max_freq_req.

>  		 * successfully adding max_freq_req request.
>  		 */
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -- 
> 2.17.1

-- 
viresh
