Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9F4205B7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 08:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhJDGPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 02:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhJDGPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 02:15:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65722C0613EC
        for <linux-pm@vger.kernel.org>; Sun,  3 Oct 2021 23:13:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s75so4676046pgs.5
        for <linux-pm@vger.kernel.org>; Sun, 03 Oct 2021 23:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XntAjvkFhoJm9SfDhp1+lB9X4205W7jSFxUyPaX0NI0=;
        b=BqIm+OlXOqzyc2qOtX2n/5bPFvCL1WiiIVbXzmvOo1Mt30SKWqQCVCDOJFOFpgq46W
         5rQ10P+CANIH+JKS2U9SwpP3Cvy5Iw3xaC93THsLYGhzQDlx1vZ6boB7y8ylIIJIb/cm
         23Lu5IzAj6MG50JAYMxxjWs5oiPvxdnEe9iGlHJZoF2eh+Oc0A9Atj2VmmQxcMdI68kp
         OUxnqzF7/31Z76Iz8s72ZJ+elcj66Kg7kZNljptL1+zrU9hVtwcHPB67Dij6wmUJvIUT
         6xXvdaNRQcQ71tNkCUrZo80mEBrBDN8JffG7whWWjYVOrdvj7/Sb+atASbmHtgGXtCYG
         O8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XntAjvkFhoJm9SfDhp1+lB9X4205W7jSFxUyPaX0NI0=;
        b=GSuq7i0RGqLlgnJSUVDUPXTc+ustt6PsNnmAa8P5Imm1AtyZfVSCuTaO8d57eAqwYy
         UeajyFWm1oEQKCughSjtMP2VLZUprUAPV9rQU7XM5POzXioMdxCjSn5uwIMklKPsnpwS
         /TMhlWQ+qgYOJWxK5TWnoBIQAF0zIZADiMF+krnxubmMCkPxSiJ2yCCjZjlFIt+X52NP
         t1n5k5G8xHBq+CJfUeaMbuBGM72grfIttWqPLDvY9zjrCvlMIbczE6admYAY3nETpaUv
         yUvTPDmnqGz/tcauTzEdkarYBW6NDexuClFKCT1hWyUnhFXXcHdwzUqTZwWoeAruGyqD
         eNRQ==
X-Gm-Message-State: AOAM533Kd3J5Hwgx+iG0pHMoBqS8IY34ghCfDesLrQWhh3j8vi9UTZPH
        cEDhxriTPu48AG2cU1oCrc36zQ==
X-Google-Smtp-Source: ABdhPJzOwA4jj74rHcQAe47W8NOgh+6zNGEEZf04pBTvOzaM+XzcDfYKOSRDibbo4QX31//fu9OtTA==
X-Received: by 2002:a63:d80c:: with SMTP id b12mr9337075pgh.331.1633328010891;
        Sun, 03 Oct 2021 23:13:30 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id s3sm998645pfw.2.2021.10.03.23.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:13:30 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:43:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c244x: add fallthrough comments for switch
Message-ID: <20211004061328.nmvjuyloitd7bswz@vireshk-i7>
References: <20210927095150.944127-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927095150.944127-1-arnd@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-09-21, 11:51, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Apparently nobody has so far caught this warning, I hit it in randconfig
> build testing:
> 
> drivers/cpufreq/s3c2440-cpufreq.c: In function 's3c2440_cpufreq_setdivs':
> drivers/cpufreq/s3c2440-cpufreq.c:175:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
>    camdiv |= S3C2440_CAMDIVN_HCLK3_HALF;
>           ^
> drivers/cpufreq/s3c2440-cpufreq.c:176:2: note: here
>   case 3:
>   ^~~~
> drivers/cpufreq/s3c2440-cpufreq.c:181:10: error: this statement may fall through [-Werror=implicit-fallthrough=]
>    camdiv |= S3C2440_CAMDIVN_HCLK4_HALF;
>           ^
> drivers/cpufreq/s3c2440-cpufreq.c:182:2: note: here
>   case 4:
>   ^~~~
> 
> Both look like the fallthrough is intentional, so add the new
> "fallthrough;" keyword.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/s3c2440-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
> index 148e8aedefa9..2011fb9c03a4 100644
> --- a/drivers/cpufreq/s3c2440-cpufreq.c
> +++ b/drivers/cpufreq/s3c2440-cpufreq.c
> @@ -173,12 +173,14 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
>  
>  	case 6:
>  		camdiv |= S3C2440_CAMDIVN_HCLK3_HALF;
> +		fallthrough;
>  	case 3:
>  		clkdiv |= S3C2440_CLKDIVN_HDIVN_3_6;
>  		break;
>  
>  	case 8:
>  		camdiv |= S3C2440_CAMDIVN_HCLK4_HALF;
> +		fallthrough;
>  	case 4:
>  		clkdiv |= S3C2440_CLKDIVN_HDIVN_4_8;
>  		break;

Applied. Thanks.

-- 
viresh
