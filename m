Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57E2ED4F9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbhAGRDy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 12:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbhAGRDy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:03:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B838C0612F4
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 09:03:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so6311859wrb.12
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V7bXUt4+mzGD7Vvoy2qGLuZX1B7w0czTK0+1WPwVnkI=;
        b=ItsnHhde2tn573UhUTtPB6PetVTNFlZOPf0OC+lumEhCTn7sEpHmprOHnflgtcpXLW
         dl0x51wPClUDc5m/MfNJOeTiVSPNacvTT1XRX5bAiB7zYcOw/wujg4bUU0zVyHXarjAg
         5RvsqC/GmD8MkI9UTKSMnTItJgL0QU6j8m+sECRKbjARVawILCmuybUTE81Seugvjm2O
         30yT2nQ8CV7BLivHimBBGstofV08AdQqcpSJHSd/GNTZSq/b1t2JbyRMWNT9hGYrbAoD
         CR3J+ZkKRGeIwrmJTL1xQWHtzIYcSc7Hc1lQvOzd5pAdn2fNQ6rwKWLRLp10fhJsDuvs
         7JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7bXUt4+mzGD7Vvoy2qGLuZX1B7w0czTK0+1WPwVnkI=;
        b=j8+C8SG6ZsgwFQPIZK3juBCTV49dzYZ9z8lGJcLx7nvY5w9sUPs5yIHnmqQgHXkkfR
         FgbDAei+P8pfPBiGwzldC9rM4D5FlIbw8uZeBU54kmkanrzUdDDEtXlzHdI0XceyOZr4
         6WLTs2phiO/PVydmobOpOrGwr2v2SvOpABO3xWaIXTDoDf3VJCJ9rDre0kgSvDLLjTwT
         QiUDMGCsiN+m2+gMghacAj+G3BC0OhklcBhdxB4pVYfNMzqbcN3zhIdGyzIjYITYvR4F
         SjvTpf90FKJszCwaemsctuwvgkSf0tiSnWax3r3hgbA4+0KNSTue2BhB67+hT3nt4Hxz
         m6QQ==
X-Gm-Message-State: AOAM531kCiyacGb7B2qKmEmiV6LasninvlfSgyjwkD6OlmsbFeJhaLEL
        ZtVvXcVQF/nn51pLHGwQu8xddQ==
X-Google-Smtp-Source: ABdhPJwj6jHgyRRkB72+LRwQXmY5lDHBk3reZ4TJQ/NGffRsK8Pcsd7SOg/8mtRjuwMNp8+HwI+tqw==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr9644476wrk.276.1610038990870;
        Thu, 07 Jan 2021 09:03:10 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-152-224.adsl.proxad.net. [82.252.152.224])
        by smtp.googlemail.com with ESMTPSA id o83sm8467999wme.21.2021.01.07.09.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:03:10 -0800 (PST)
Subject: Re: [PATCH 3/3] powercap/drivers/dtpm: Fix an IS_ERR() vs NULL check
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <X/V8zHPwlGiSxq1M@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5cd25798-5dc1-4e8b-61a6-5a5f425f9473@linaro.org>
Date:   Thu, 7 Jan 2021 18:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/V8zHPwlGiSxq1M@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/01/2021 10:03, Dan Carpenter wrote:
> The powercap_register_control_type() function never returns NULL, it
> returns error pointers on error so update this check.
> 
> Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for these fixes.

  --Daniel

> ---
>  drivers/powercap/dtpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 470a1182b868..5a51cd34a7e8 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -467,9 +467,9 @@ static int __init dtpm_init(void)
>  	struct dtpm_descr **dtpm_descr;
>  
>  	pct = powercap_register_control_type(NULL, "dtpm", NULL);
> -	if (!pct) {
> +	if (IS_ERR(pct)) {
>  		pr_err("Failed to register control type\n");
> -		return -EINVAL;
> +		return PTR_ERR(pct);
>  	}
>  
>  	for_each_dtpm_table(dtpm_descr)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
