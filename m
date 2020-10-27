Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41529A939
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409830AbgJ0KLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 06:11:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34118 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409753AbgJ0KLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 06:11:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so1226854wro.1;
        Tue, 27 Oct 2020 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DObrNorW8fXGsQynBmTwK5pAsWwCn0bs0/pvbbcTgUc=;
        b=AHFZ9R6NEbnDzOhxmUMC0hSZKwzYrpWItsikqA07XSSbJlJRoQWeyMDI1T2mjrcmI2
         qkVDe8IX2PSqVVAMFOng7ENsusWvdwhHeT8oivK7VxTIf37T0vv+xk2KgjEvnnqpCvMY
         xgXHPiaWgGXiLwD9zS55RVRgWzdX8aDXmddDqVuOlKo8uZo3aw0jGyxYSydYtOBBSaJx
         MllTTABXjHCtGLUMwZPPUl7q530Bw8zJSK4CvXmUL/Y5P1Z9q8SttGAlz05JK0CeadmD
         phBJFE4DERxjEx22zJ3+x8fuCGWYS3++EtRMDRqKtrKSX4oOltqf7WkjezI5tydSjJcU
         kbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DObrNorW8fXGsQynBmTwK5pAsWwCn0bs0/pvbbcTgUc=;
        b=YlxP3mgtlD43be2LdZFMqbtK9QEw8Ul/L+EfeBgzo+musbODmhtRy2dhewLd38LWNv
         0i5BPykvknGy+3a+ka4bn4hbX9iRnvP/CxlGujrT94Q5caXzoIlrHcaScweeSl7OJkhM
         z0lUCxKGyj6G4qlV98KNUqbTb4I5PHAoGonvqYPqmeFiQdCwK1FpZ0UriaR/FfaXpKjG
         TDLx8/P7quAQMXPe8SKnudOU2wmiNIDXVPzy+zRxwdR7p7D6myIbTrMzqX12wq9dlSBZ
         ic2+/wXx42lUkvaJilgTZ025PnQNLN8Ep9o1FjRGHNDnidOgvZK8OP4R87h26VKawUi7
         WIgw==
X-Gm-Message-State: AOAM530rtbOtKCRP3uQM0p//S8gZrlFYDLJcXBK8M1PhaQA7ZDcs+kMK
        9ph+bfOU3WinhlemkD1EP5GssDQTDExv6Q==
X-Google-Smtp-Source: ABdhPJwVwSFFsalOX6ObUB0OpSjsPedl8DAEpWCB0mQnIokTahpjUeij1x/ZbLbGqXoThegjbSzNng==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr1879989wrt.221.1603793463075;
        Tue, 27 Oct 2020 03:11:03 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id j13sm1395863wru.86.2020.10.27.03.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:11:02 -0700 (PDT)
Subject: Re: [PATCH 3/3] thermal: mtk_thermal: make device_reset optional
To:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
References: <20201021164231.3029956-1-fparent@baylibre.com>
 <20201021164231.3029956-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3edf970c-0435-3e8f-b262-4cc954032d53@gmail.com>
Date:   Tue, 27 Oct 2020 11:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021164231.3029956-3-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 21/10/2020 18:42, Fabien Parent wrote:
> MT8516 does not support thermal reset. Use device_reset_optional
> instead of device_reset.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/thermal/mtk_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0bd7aa564bc2..149c6d7fd5a0 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -1052,7 +1052,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	ret = device_reset(&pdev->dev);
> +	ret = device_reset_optional(&pdev->dev);
>   	if (ret)
>   		return ret;
>   
> 
