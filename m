Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561A3FB0AD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 07:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhH3FFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 01:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhH3FFr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 01:05:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7BC061756
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 22:04:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m4so7871230pll.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HziJP/dygEyNluPtXWKc6SpypCt4+2Y7o4pyW2rHfac=;
        b=Zp5ZiMV0CfOCgf2/iAtGJuoGZruRIVvGXo0zwkLhRqNGm2j98/jWGYO3CcQ7JzTty8
         YeBQMg8/vgV5n5MlWTvtEm1vg/F0it6S/Jq1xG2mzzgIcCA8IX+QuRayvC8QXG502Jgo
         /o66oy/NpG6jXjEzCSW2fmXw4iKkG8BfkbvDgCwGYOHPnV+7bSmZLrUyp6itAEfPVS+W
         slQAbuMAnE74l9jaPMWZP3au5bIV0FDIC+JdWFa5QyJKIuvbiLKZtW1zvuaJFuC9bZi6
         uB2/HyNvHuR0sJOUitPcz/xeYH0USq+Ge64MWtcia25BcGv0Kpx6BdYXOSeIz8a5qFnl
         sRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HziJP/dygEyNluPtXWKc6SpypCt4+2Y7o4pyW2rHfac=;
        b=eqYPJK5pvKuH8r5bYlTK4ebUtRVId+y5i3WCGhPosLJZTdvknnqdwWUJFE26MndisT
         vL+UpbxqLu+VO5TJ88wbkytO2MtZ085jsUw8rKThJ95tsSqOS6JIprbbKXMAU6vOlTy2
         u6yWnssKgPFDZUC5l0LY7aq0++8TiS5Dn6Mn9KYmZ3o4NOxiVsUujQinBsa2DyJt7ZM7
         lCEzaDkOd7G/hSKP35gaCcgASUCSJI7AvU98aawwimLqiWnOfxlz/l6jADlqSiBArLxW
         BKf49xIDq6fK2uQU4N7isXyOVVH53JOi5ePYVXQ0TDUlDdhJY23WfOt1ETXDajVVdLwl
         NTvg==
X-Gm-Message-State: AOAM530Bn6CaQFy6AYPpkqIoJH8/tF/i2lDggMWJpFssAEzW3gc9KpG+
        GpTmek0OE7AVfVRUDmjl5nftIw==
X-Google-Smtp-Source: ABdhPJwZ6hgP4vm+aVcTn2qoaIgOSChZ2tiVNSCvx4/M6/3DGZv7qfs0o+VLPB6EuTqFVNGGXHD7JA==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr29224522pjg.118.1630299893596;
        Sun, 29 Aug 2021 22:04:53 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id n24sm14943364pgv.60.2021.08.29.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 22:04:52 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:34:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v14 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
Message-ID: <20210830050450.r4kfv72bsxsttnli@vireshk-i7>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
 <1630162872-25452-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630162872-25452-3-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-21, 23:01, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add of_perf_domain_get_sharing_cpumask function to group cpu
> to specific performance domain.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  include/linux/cpufreq.h |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd7194..4916d70 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -13,6 +13,8 @@
>  #include <linux/completion.h>
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> @@ -1036,6 +1038,43 @@ void arch_set_freq_scale(const struct cpumask *cpus,
>  }
>  #endif
>  
> +#ifdef CONFIG_CPU_FREQ
> +static inline int of_perf_domain_get_sharing_cpumask(int index, const char *list_name,
> +						     const char *cell_name,
> +						     struct cpumask *cpumask)

What happened with the discussion we had about returning index and passing CPU
there ?

-- 
viresh
