Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20AF93C3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKLPN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 10:13:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfKLPNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 10:13:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so12138631wrr.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aL0fbv6KeJNvtxT5CdrQViagZLp9s9K8vsOn0Xh8q30=;
        b=Kang/UmVVO1JPRhaQOEq1cOuhtLfxV7mH+vBGpXjJRl9ZL8f3tEldO5gzgYeyiJSjY
         UaLVwbBlddvt0CMDMLjBK/QBO7tu8AdXOV2FkyPOTucPuRiQ9aRarfocg7NobZXOg6cs
         g2OZmqGNhrr4i1olFfKwJrx/6+kWtMbNOjkU9ja8lnp3drrEdN00+6w1jQjL1uRDDwn+
         /SabzP7k9yE+4TO2nPJcytl5xc6q6NOls2FQTDalkBv9PHB1pLFAQ/ttcZEe+ii2YcmT
         5kcqQjzJdYmpY8zLndyuvAubs2z7N7Z84tBAA/Zn7tsdU1mSPQvU/Pq9cdd/eygrWgOy
         4F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aL0fbv6KeJNvtxT5CdrQViagZLp9s9K8vsOn0Xh8q30=;
        b=Yql6c9TYqhs0Zv7EgSCkhw12kU1dXu/9rl8RBJb489QL6c+J4m2diDNE3LDyHp19ZO
         AnxIo4EYm4r3wG2ZSt9Za4u7KEnO+H3bqUW/NVU6/52CHpjxJu1O5oVwrgDmOu/7XJ5N
         0CxXTBbGJM10bCdr6vqff77jg8zNl9GKXncNAuP93qu6M2YuZ44Ao4erYD1esbyT3sFW
         V5NER3F7Biue8mra3b65vgGC5UCGCG1sdNcvT/vehK+1TMlVXVK2sHWZ87ogFZhX9Mde
         nERbRf0qSlCMla3AC9slDe9YVvx0RHB/JHjMddpLZ74UdveHh8sTHNf5hfVUJpW7Y99Y
         bXUA==
X-Gm-Message-State: APjAAAVJRMa/CJjiKHC0F7qbQ3IZzd7gxej++2/pRiSb0he3BiYXBSS9
        JWVwvR6QPchcgw0/RMZxPig41w==
X-Google-Smtp-Source: APXvYqyKSz7ayM+LSOBrTbwWxWGYkGmnqdkIZGg0N25K4y3R0Fy9sYBrP0Oa7gkHA4qtDs81NyGe+g==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr3166501wro.322.1573571603419;
        Tue, 12 Nov 2019 07:13:23 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id b3sm3107126wmj.44.2019.11.12.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:13:22 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:13:19 +0000
From:   Quentin Perret <qperret@google.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] thermal: power_allocator: Fix Kconfig warning
Message-ID: <20191112151319.GA239065@google.com>
References: <20191112145114.36580-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112145114.36580-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 12 Nov 2019 at 22:51:14 (+0800), YueHaibing wrote:
> When do randbuiding, we got this:
> 
> WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
>   Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>   Selected by [y]:
>   - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>

This will not cause run-time problems, but I guess the warning is
annoying so ...

> Make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR also depends on ENERGY_MODEL.
>  
> Fixes: a4e893e802e6 ("thermal: cpu_cooling: Migrate to using the EM framework")

Daniel: can we rely on this sha1 ? Or is this branch force-pushed ?

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 59b79fc..5e9e038 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -108,6 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  
>  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>  	bool "power_allocator"
> +	depends on ENERGY_MODEL
>  	select THERMAL_GOV_POWER_ALLOCATOR
>  	help
>  	  Select this if you want to control temperature based on
> -- 
> 2.7.4

Thanks,
Quentin
