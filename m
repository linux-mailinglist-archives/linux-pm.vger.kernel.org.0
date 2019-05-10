Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90FB19DC5
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEJNFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 09:05:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34240 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfEJNFJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 09:05:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so3021908pgt.1;
        Fri, 10 May 2019 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fpkFptDpQZm55D6haD3JjJF9CnC6Z82ZE89k2GMPDNU=;
        b=Cmq1aMrTSDioFuOgSDGJ+Vw9DKxqHMVvStU7l/OlsJiKZQXOyzsG0AZv8fyz5VyUAj
         Zz3qK2Mb06CmSPFghLMyLh4x0y2ylW9CMHpAsYVpLMoyUbi10mmhk3QXWZVglFplXkZ6
         8J6rJOngm4jrOz8LL20+1yQOv1JQ7GdnJ2zCKLpYR9DB07UIJW8HPn6Tl01qOKJ05ltB
         VDupjhqf3DHBHAvsIewy3sfk4sryVkIT8TX2kf7VCgG1pK/fcXXxdmSX26bKDYTXZz2f
         qBtA5+YEyAWbqtkmH7jea8z+yddm8gPdVdu2xqB50wLUHaoqXDjNAxo69YAWYUAmByFr
         Tvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpkFptDpQZm55D6haD3JjJF9CnC6Z82ZE89k2GMPDNU=;
        b=ljQiSBuYinIXfbjkjUWX2rQd4gUmZyNWLN5hmMepPqLSIPJUx0nLinHBPtO4E51w6n
         w8/+kIJJvSe3Ert4oDKxVz7zOxYz1nLmrj680JilNut3Bg1CERNkZEIidcYAJU+uHVMO
         D1COxvE3pUaX6nK7UBaFRMQ0CniVHLGoqHLoZnFYrnNgOn4eXDH8LyQmzF9kcc7TUDKX
         bK1qz8a5nuMR4DqQ1BVu5N44GTFbWcfO8fvZi0lLRXVAQ6+tA2L9cIfn+xkSTkvwSdna
         VBHT+/Syn6fZdZfaj/z2gOzEDJMNtKssJHTXMCsoL0OZhQElEYLlOemWaGfjR5hjw+SQ
         r1WA==
X-Gm-Message-State: APjAAAX8MHnbodJXfo92BtgK7h+a2f+fwgMRXVC0fLqEdSVw4RGb5tjV
        beBNwOcaQe49gIyxImnRR/SOk0D5
X-Google-Smtp-Source: APXvYqw80K8ybW3+Do2to1CKTX+/l4pQZ/DHt5qQi7HkB/kfjjBaNJQDIrqr+aePGvKQ8zH6en83ww==
X-Received: by 2002:a62:520b:: with SMTP id g11mr13374539pfb.215.1557493508647;
        Fri, 10 May 2019 06:05:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63sm11348932pfu.95.2019.05.10.06.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 06:05:07 -0700 (PDT)
Subject: Re: [PATCH] power: supply: ucs1002: Fix build error without
 CONFIG_REGULATOR
To:     YueHaibing <yuehaibing@huawei.com>, sre@kernel.org,
        andrew.smirnov@gmail.com, sebastian.reichel@collabora.com,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20190510071823.2984-1-yuehaibing@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b37be09-c323-94c6-8bba-44e854597e95@roeck-us.net>
Date:   Fri, 10 May 2019 06:05:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510071823.2984-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/10/19 12:18 AM, YueHaibing wrote:
> Fix gcc build error while CONFIG_REGULATOR is not set
> 
> drivers/power/supply/ucs1002_power.o: In function `ucs1002_probe':
> drivers/power/supply/ucs1002_power.c:593: undefined reference to `devm_regulator_register'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3b8): undefined reference to `regulator_enable_regmap'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3c0): undefined reference to `regulator_disable_regmap'
> drivers/power/supply/ucs1002_power.o:(.rodata+0x3c8): undefined reference to `regulator_is_enabled_regmap'
> 
> Add Kconfig dependency to CONFIG_REGULATOR.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/power/supply/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ef36bd2..26dacda 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -682,6 +682,7 @@ config CHARGER_UCS1002
>   	tristate "Microchip UCS1002 USB Port Power Controller"
>   	depends on I2C
>   	depends on OF
> +	depends on REGULATOR
>   	select REGMAP_I2C
>   	help
>   	  Say Y to enable support for Microchip UCS1002 Programmable
> 

