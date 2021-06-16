Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECBF3AA3DE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhFPTJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFPTJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:09:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2BC06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:07:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r9so3829078wrz.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ux1IzFszJ4GlRe8cOiKiQDcd1b4k328A2GnLxqyXZTc=;
        b=u11mZiHDrXWDYEuQUIFgr5frWWMBnYydtsUfbt642qNvbXgC43KeK6gIVx5SheJWRS
         clhSWwMMnJhV+nUkBtiOPpkkwvYE3gkQmkSCZ9z85aKMdopywH/AGZrgWRSg7AD/P2hE
         Xqyl6661JW41qWHE/F3rrn/VeunyGdjnSqva4g1MfZlKPS1Kr4utEE0+7zAyXACcpH+U
         tTUeBE6Z7uVAghfdi2B9ngDrP5Re21wM7/ueDnlWaQ8QpfFFWZaFu4PFiHEqXbVTK8KB
         GmmRouK6IqLtjafVJiB5Kc4G2zTby26f3M6XggH9vvBhj+WiKmMVQiJSOtXEGGhFgmgz
         ZgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ux1IzFszJ4GlRe8cOiKiQDcd1b4k328A2GnLxqyXZTc=;
        b=ApR/JFyRvxGesxrqs0z7o3TL6gtDw4gwj4fV2Ei2dRLD8EaBc/y1DYyKMdJ9Axv1H8
         SS3IBYrytIIFveCCQqrBzBGsV2ZI1TO1N3C5mLiEYLQ8R2BTTTBIDjqYeZbw3U2IJSWD
         NtHA22iEYSohafv+v2x+BSIgLhSG7bChb73/QIB2uPL3qt/m4PSHOzWzqdQIyNs2l97j
         81OZ8PGkOQKUUAe0nzis8+4+Dxc9hM0QYYYHsU8A6RX2VqfHZ3+fMHewDR14nkrvXkNZ
         2wDrH0GrBTG8H/UZa/QHi/oHl8CGs5keNdS7gr/+1brLig0rRG73g5FJyNKTMjBh1NQu
         iyQg==
X-Gm-Message-State: AOAM531UH47/sYDv9T5KEfSLct9+kUxZhLjCo0eQPPw/NOLxw5Tv30/1
        y7z10gxM0RwfHHVGB+hFZd7vAA==
X-Google-Smtp-Source: ABdhPJwLgeAUSYSDsp9mdlGVzKDcUzuWDxNV7mgIZTgpNxYF5dTbfxwtaA7vSUwo9WVZo8glGwRg0A==
X-Received: by 2002:a05:6000:1367:: with SMTP id q7mr692232wrz.306.1623870418866;
        Wed, 16 Jun 2021 12:06:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id c7sm3073452wrs.23.2021.06.16.12.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:06:58 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] soc/tegra: irq: Add stubs needed for compile
 testing
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210606222817.12388-1-digetx@gmail.com>
 <20210606222817.12388-3-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <92b521c6-f3fd-4f2c-de4f-3363e0384f55@linaro.org>
Date:   Wed, 16 Jun 2021 21:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210606222817.12388-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2021 00:28, Dmitry Osipenko wrote:
> Add stubs needed for compile-testing of tegra-cpuidle driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/soc/tegra/irq.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
> index 8eb11a7109e4..94539551c8c1 100644
> --- a/include/soc/tegra/irq.h
> +++ b/include/soc/tegra/irq.h
> @@ -6,8 +6,15 @@
>  #ifndef __SOC_TEGRA_IRQ_H
>  #define __SOC_TEGRA_IRQ_H
>  
> -#if defined(CONFIG_ARM)
> +#include <linux/types.h>
> +
> +#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)

Does not CONFIG_ARCH_TEGRA depends on CONFIG_ARM ?

>  bool tegra_pending_sgi(void);
> +#else
> +static inline bool tegra_pending_sgi(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* __SOC_TEGRA_IRQ_H */
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
