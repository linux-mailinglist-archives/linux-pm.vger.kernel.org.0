Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A78113AE0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 05:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLEEgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 23:36:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfLEEgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 23:36:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so1846003wro.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=keNUPJzqbpb1zvh7gwgj7wSZGJ1RcEtCjXcl9nIyRWA=;
        b=hEvfs86e9uivc96esO1PqMIaSDQRwe6rRSEh3UTbWwRpAfK2D9o0OHW9jyWdUe+ImC
         KM5sjitV4VYUSsac91vLm0LvC2QACkEbjm+0bQ9Usog5c782YsT0qny4ZFJy4VNaaSPj
         EoxT4aPxXr+CxnhTvj6mg+0gI6BMQ0BvXkUSCTtK4JWxrfURYclITMO5RB0/bJH0GV9K
         ICalID4puBDrItEojRVXbjuKsTJ/YPJt6Xlql9wzZ9RXhh3pubq8cEt3s5sYE1KzUS8x
         QwAVJIhhZQaZkudwl6IhRSSzAGZ1MN263zCP8gq5tnsmIZCHCa1Ve0QoErHbRHURc2er
         kWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=keNUPJzqbpb1zvh7gwgj7wSZGJ1RcEtCjXcl9nIyRWA=;
        b=OCiV/xsBvAEB7XH6XmlJn+IapuhAF3qU7U2/hyIZzk2WjJ5f+n8jr1H76C0Mb1XhiI
         1byLTMZNahx1w8sN5L1MT8jT+DNf4PG6WGxhcjyrE/D1H55Z/YwF+azhxc6E78fdQSX8
         sl3t6TRizNaP1wIeLOtRyzOKlbPJHCZw0RbwaoRqgUvEo2EXg7b1jUFZR55xp5FCmy6x
         kAh96tZPknv+xNAO2P3qIDxRai7gZr4J0VVYl6UPgr4OYygPgGh28EhF1dHhBIsW0les
         ld9rCgSE8hgDrnUlZe/PoowMzPof5IQZfU+lqt4t2E/wepQhKXuAAukMqLI0IqEeFBH+
         cPwg==
X-Gm-Message-State: APjAAAVLw/CGs7MfFWLX8ZARhw57HP/gsb6EjYVIkXnGHlN7+fFFV8j6
        UyWYh509aXmePwba+DDbamcFkg==
X-Google-Smtp-Source: APXvYqyAeuNq7VceTAS9eq+u2nkne8kbzO+3NySJpdhCTng6yAxjdC53noAT+TaQdRaTXEWhj0rzog==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr7357191wrr.252.1575520573537;
        Wed, 04 Dec 2019 20:36:13 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id j12sm11408925wrw.54.2019.12.04.20.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 20:36:12 -0800 (PST)
Date:   Thu, 5 Dec 2019 04:36:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
Message-ID: <20191205043609.GA231782@google.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
 <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
 <9436e207-8a65-f01b-c348-32a8a00f03d4@infradead.org>
 <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

On Thursday 05 Dec 2019 at 12:27:47 (+0800), Zhang Rui wrote:
> I overlooked the original report probably because I was not CCed.
> 
> This is introduced by commit a4e893e802e6("thermal: cpu_cooling:
> Migrate to using the EM framework") which adds the dependency of
> ENERGY_MODEL for THERMAL_GOV_POWER_ALLOCATOR.
> 
> To fix this, it's better to make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> depends on THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Please confirm the problem is fixed by below patch.
> 
> thanks,
> rui
> 
> From c9429f6e28ea2219686a4294d39f015ba373774b Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 5 Dec 2019 12:17:07 +0800
> Subject: [PATCH] thermal: fix a Kconfig warning
> 
> Currently, THERMAL_GOV_POWER_ALLOCATOR is selected by
> THERMAL_DEFAULT_GOV_POWER_ALLOCATOR even if it has some unmet
> dependencies.
> 
> This causes the Kconfig warning
>    WARNING: unmet direct dependencies detected for
>       THERMAL_GOV_POWER_ALLOCATOR
>       Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>       Selected by [y]:
>       - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> 
> Fix the problem by making THERMAL_DEFAULT_GOV_POWER_ALLOCATOR depends on
> THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Fixes: a4e893e802e6("thermal: cpu_cooling: Migrate to using the EM framework")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 59b79fc48266..79b27865c6f4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -108,7 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  
>  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>  	bool "power_allocator"
> -	select THERMAL_GOV_POWER_ALLOCATOR
> +	depends on THERMAL_GOV_POWER_ALLOCATOR
>  	help
>  	  Select this if you want to control temperature based on
>  	  system and device power allocation. This governor can only
> -- 
> 2.17.1

FWIW, a similar fix has been suggested a couple weeks back:

  https://lore.kernel.org/lkml/20191113105313.41616-1-yuehaibing@huawei.com/

Thanks,
Quentin
