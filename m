Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0340D092
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 02:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhIPAHW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 20:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhIPAHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 20:07:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1CC061574;
        Wed, 15 Sep 2021 17:06:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b7so4191171pfo.11;
        Wed, 15 Sep 2021 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oVyiYM8UFoFaUWrfFN8pM33BOneT811ec06uhiJtXWU=;
        b=N+qizs9+ibDsnowUPshEeM0Hb5SDsPaymkn574aYorj3YpGwt2w42A9H1hEtMz+NJY
         ayTh4I5fLX14fZuJN+GCCk4TNEvy+RsrmquRe8R9nhsI8E307TpUWCC/IJJ2EkJqFiNm
         QmZcG82rSYzNrL5Q647YoSHG53eXAn/M6raRxEkuopYQo4HMccVVCA9sw4jpiQhkWnTE
         5odltj+2Wn2Qq5JYYkvB3wj/yy+T1s1Xq0EZzMkxibORiotU6DKYLywOu/7JV0c2UqRB
         7MSaqDGYxX/sVnvWnGlwFBvxwepDBrBmZf7xsaCHB9lLYXof0eBF9HSFjES6IP0WCN8B
         H9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oVyiYM8UFoFaUWrfFN8pM33BOneT811ec06uhiJtXWU=;
        b=PNFjwc3Ra4VyvYNpLTdvWuqNS6zTUZbHIG9ubAvchmtx42dsNsIiBV2BaBM5RN8Qjv
         zjB1B4//voDcUKYrm/aSY7vBVkZxpVyC4eliDuIlrtPhf+TJFiOpRM3j/uxwA3BiNO7f
         8Yp7rYxsvKZnD2SSmDjXN+9CeXi57Dxh8ltIJKqCjkVHiYKqRwx5+mqpnFxC6Sm6SHM4
         wj1yXom+8mnjvHGvFzGFNHCdYO9wgSjthMZNKmkb1c6BADOToAWI6P8tMEegLuOJyRN9
         w++0qdDVFgMhydLi5TTx7mFhAp4US/yDaG+NfWqixO13eDgTeOEaoOgEd1dMBddz4q0A
         ZsHA==
X-Gm-Message-State: AOAM53099258h6xkrx9gpxWOuSVfD3eIBbHu254ZgPxBn/d0Su9YGqg/
        sfPDNzcoGc8c+4tsnNcGllHpY2RXYvU=
X-Google-Smtp-Source: ABdhPJxFhT4lroYq1bG1qdl5wlsvQ6BLo1tkCx7NL/E7uywREDmYhJULU9+VDwe4kytsESuXD1eNcw==
X-Received: by 2002:a63:af4b:: with SMTP id s11mr2258974pgo.185.1631750761929;
        Wed, 15 Sep 2021 17:06:01 -0700 (PDT)
Received: from [192.168.1.121] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id l185sm872179pfd.62.2021.09.15.17.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 17:06:01 -0700 (PDT)
Message-ID: <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
Date:   Wed, 15 Sep 2021 17:05:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210426213647.704823-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210426213647.704823-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/26/2021 2:36 PM, Florian Fainelli wrote:
> Utilize platform_get_irq_optional() to silence these messages:
> 
> brcmstb_thermal a581500.thermal: IRQ index 0 not found
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

This patch was never picked up and still applies. Daniel, can you pick 
it up?

Thanks!

> ---
>   drivers/thermal/broadcom/brcmstb_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 8df5edef1ded..0cedb8b4f00a 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -351,7 +351,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>   
>   	priv->thermal = thermal;
>   
> -	irq = platform_get_irq(pdev, 0);
> +	irq = platform_get_irq_optional(pdev, 0);
>   	if (irq >= 0) {
>   		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>   						brcmstb_tmon_irq_thread,
> 

-- 
Florian
