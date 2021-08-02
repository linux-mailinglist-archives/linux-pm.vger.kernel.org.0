Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957783DD2E0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhHBJWZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhHBJWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 05:22:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741AC0613D5
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 02:22:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so10563330wmg.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XuMl146g7mclGYpsz+vV1OUnrRE5rQPP1q+8mYAGid4=;
        b=bMO4Yuwwl/X1UlTBP10vd1lgINlkZLxp1MIhUI+h5Qa2T2734B4IXMD3SzQee71ZaQ
         syOikuB6S74kyg0b2Yr4fgZXqUgXWt95l3oqciILiRi98hXLOywuYwGTO6vyP/hNd4iC
         iVbW+GNXjX5zvYim3G1x1/wVGn6oQ8IehUv6iClJmZgwRSUN0Cds8OsESqtZ76aBesPh
         3T2Hnuvp9J25XdSAVzm33ghkduu8yqb6nWk4FnL3BmMbvRwQEuZl3RvLj/lVFjibX+RM
         cOJFUChRFT2rUfZyte311A51XxmT/X9F0o6DZdHUHqldoQpEVrwHOgM049dIOD23/qoS
         GG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XuMl146g7mclGYpsz+vV1OUnrRE5rQPP1q+8mYAGid4=;
        b=bnBnlbBu8f+byIDNSxNVXKVuyWahQOi0NB/9cxnkxXg0U1FrdmgitaF34Ld9Rs3BXs
         DOC5QgrPGN5H0Pf33YQgmIqz1IVEfBax1pcca8dNj8/Htyl9vot54uG9/S1IM1VaSNhV
         kEgeFiuqhSUDUkKxZ+zDpo85fUSGkrIAc5wwrvrtRooB37ht6h9GmeCjEVAuDkqwBHgv
         Q2oFMc33tZsxWFwUIDmQP8F2HmHyo+r4doKXrlvYNAEwilmqfEmDfz8dpHNIsvYNgmXI
         gj8HJNdZbFDiit//hqvDYlyqtWYT0SyeK+fUQPknFHmtfYEcglWNo6eejKL+RovkibUg
         zPEQ==
X-Gm-Message-State: AOAM532ww6DOkkXTZvOIXr9Pa58QJwr8P5VU/pTFzVK8buk2rklvObH4
        fR4YjQ1wFBaFNeNDol+LGniRwLSO6hvs0g==
X-Google-Smtp-Source: ABdhPJyPj7EV8YTRcj2LwBVXx4j3qTJBkFztXU4NyNIm7T+22E6veE4Q+YZxYvX2kcMaDCDNXsNiOQ==
X-Received: by 2002:a1c:452:: with SMTP id 79mr15504367wme.125.1627896132222;
        Mon, 02 Aug 2021 02:22:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:186d:6344:a12c:5b26? ([2a01:e34:ed2f:f020:186d:6344:a12c:5b26])
        by smtp.googlemail.com with ESMTPSA id n186sm10949241wme.40.2021.08.02.02.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:22:11 -0700 (PDT)
Subject: Re: [PATCH] mfd/cpuidle: ux500: Rename driver symbol
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <20210802090859.3237509-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6429cf2a-63c2-d925-d5d9-24eff617d1c6@linaro.org>
Date:   Mon, 2 Aug 2021 11:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802090859.3237509-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/08/2021 11:08, Linus Walleij wrote:
> The PRCMU driver defines this as a DT node but there are no bindings
> for it and it needs no data from the device tree. Just spawn the
> device directly in the same way as the watchdog.
> 
> Name it "db8500-cpuidle" since there are no ambitions to support any
> more SoCs than this one.
> 
> This rids this annoying boot message:
> [    0.032610] cpuidle-dbx500: Failed to locate of_node [id: 0]
> 
> However I think the device still spawns and work just fine, despite
> not finding a device tree node.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Rafael/Daniel: it would be perfect if one of you could ACK
> this so that Lee can just merge this into the MFD tree as
> a non-urgent fix.
> ---
>  drivers/cpuidle/cpuidle-ux500.c | 2 +-
>  drivers/mfd/db8500-prcmu.c      | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
> index a2d34be17a09..f7d778580e9b 100644
> --- a/drivers/cpuidle/cpuidle-ux500.c
> +++ b/drivers/cpuidle/cpuidle-ux500.c
> @@ -117,7 +117,7 @@ static int dbx500_cpuidle_probe(struct platform_device *pdev)
>  
>  static struct platform_driver dbx500_cpuidle_plat_driver = {
>  	.driver = {
> -		.name = "cpuidle-dbx500",
> +		.name = "db8500-cpuidle",
>  	},
>  	.probe = dbx500_cpuidle_probe,
>  };
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 75049cf38832..64dd4f9a1e49 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -2951,14 +2951,16 @@ static const struct mfd_cell common_prcmu_devs[] = {
>  		.pdata_size = sizeof(db8500_wdt_pdata),
>  		.id = -1,
>  	},
> +	{
> +		.name = "db8500-cpuidle",
> +		.id = -1,
> +	},
>  };
>  
>  static const struct mfd_cell db8500_prcmu_devs[] = {
>  	MFD_CELL_OF("db8500-prcmu-regulators", NULL,
>  		    &db8500_regulators, sizeof(db8500_regulators), 0,
>  		    "stericsson,db8500-prcmu-regulator"),
> -	MFD_CELL_OF("cpuidle-dbx500",
> -		    NULL, NULL, 0, 0, "stericsson,cpuidle-dbx500"),
>  	MFD_CELL_OF("db8500-thermal",
>  		    NULL, NULL, 0, 0, "stericsson,db8500-thermal"),
>  };
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
