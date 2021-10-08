Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEC426592
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJHIGo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJHIGn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Oct 2021 04:06:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601BC061570
        for <linux-pm@vger.kernel.org>; Fri,  8 Oct 2021 01:04:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m21so2347263pgu.13
        for <linux-pm@vger.kernel.org>; Fri, 08 Oct 2021 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DeR+7GpxoRNUeEEHb8NPT+aLj2hVPbRU+o+5A+ubwxY=;
        b=zLv6nQYDKZUUtInR3WJHKXsy4Y1A/g/9Mz6q5bx9kMIsQYh6ILwVmKsF/mODixybVq
         7kO2p8iQgoiCTaZulwnfs+HtqSXrif8GMnIRtQNbYXfPEmzZjL3sK+M/bfZUS4cA5wCw
         C6PFMiS9rFy4GK6r9dPDAu7mw2NOPnjZ9vSM0Mxbc5noBCzfYQOn7GvizJCpkRQEh0Rh
         K/O554ZOnNxjyYTFTyA9YVIb+dRdAuY4jjFXsWc8aQJNBvbAkHBoZx938+HywV+4a65W
         Fd/V/dLGyPeb48ceXx5FKMe3Xv07voqSoqvOYsNjVwXUd0PyyqTuL4b1aX83t5hPr+t5
         5AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DeR+7GpxoRNUeEEHb8NPT+aLj2hVPbRU+o+5A+ubwxY=;
        b=lxu3Jol2soFvqbEh58fOpnYBI4oxqy9OGEiGCMtc107ZVM7lZe8gEkLZrnTpV3eH9W
         zic3ZPQMUgoQIUzza1g1/1H+2Aro6rBl9caNgK3r64iYeXMJTMoi4GNvpKFrazK9hWMm
         WWues0tgWCHg7cvcAm9tu9H61dH2ao5E10G1h4uNcUv771GBlhALuXUIZhL2r7inY508
         XUGNCJqm8iDqbbLBpH8w8qWEwzXKR6xm8jilq1/U/bYrLm4abbGKD32GSo9M3YH7nTJD
         s4gWj8RZHwSbWUHNzyyyKm+bDyjS6+9TVwNNzKOIkM9KKf1dUjYMk9InWLb+PPTG38AS
         JnMw==
X-Gm-Message-State: AOAM533ny5ZRzW5g9yVF5xLn/6/GzYu0nAaw5/Oi+efuZebD+OpV4juL
        H2oIuGY7EAVxUDEJmmeWcThN4g==
X-Google-Smtp-Source: ABdhPJzr4I6xc19o/8fwfjqRfCs10YkJ2fyHtm6ad2iEzH/RHLsk929ajPNe2U9vqIrvsEM7U+Ji0g==
X-Received: by 2002:a62:6206:0:b0:44c:bc1f:aa5a with SMTP id w6-20020a626206000000b0044cbc1faa5amr8402640pfb.5.1633680288225;
        Fri, 08 Oct 2021 01:04:48 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id g8sm1781289pfv.51.2021.10.08.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:04:47 -0700 (PDT)
Date:   Fri, 8 Oct 2021 13:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, d-gerlach@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] opp: Fix return in _opp_add_static_v2()
Message-ID: <20211008080446.jppjpwjliwdotk3h@vireshk-i7>
References: <20211008074652.19700-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008074652.19700-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-10-21, 15:46, YueHaibing wrote:
> Fix sparse warning:
> drivers/opp/of.c:924 _opp_add_static_v2() warn: passing zero to 'ERR_PTR'
> 
> For duplicate OPPs 'ret' be set to zero.
> 
> Fixes: deac8703da5f ("PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2a97c6535c4c..c32ae7497392 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -921,7 +921,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  free_opp:
>  	_opp_free(new_opp);
>  
> -	return ERR_PTR(ret);
> +	return ret ? ERR_PTR(ret) : NULL;
>  }
>  
>  /* Initializes OPP tables based on new bindings */

Applied. Thanks.

-- 
viresh
