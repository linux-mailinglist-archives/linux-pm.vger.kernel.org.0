Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023C422E69
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJEQxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhJEQxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:53:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B9C06174E
        for <linux-pm@vger.kernel.org>; Tue,  5 Oct 2021 09:51:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p21so7242578wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXTjxuUZnmqjHtVD8/qvvFaOiH10Qiusvt2hNLMFYc4=;
        b=a9vaykgeQFPZ5IWK4tw43UUz2rYmFvYlcMiv/BSqpAqKwQJrJR7b+A10p3SCXVLHUe
         sJv1ZyxTgbo+v/Fq0/jSG2CT3AHYnKkZZy/ylaHVw2MmrAv2ZlU1aZy8SEyqfaTakbdr
         4SelJSHP89Qojt8u1xnUBh77hbfIl0SasZwJibIPsQwm7/jOS7wfBvNUXQrboAo5jjRU
         WNnbBiAu+q+iePzXqdRL/tvYIXJ74z01iak/3d1TW8td297I4kSOl87BUAmAftrUNJ2b
         75zKntuwYUyfn3BnvXIL6RcZICeed80Wz8whaXMb7I2vTSNRpMc1dH1vYBZ53BRSI/Og
         520Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXTjxuUZnmqjHtVD8/qvvFaOiH10Qiusvt2hNLMFYc4=;
        b=ogtrIXLJgorIJijEhDKZcPel1Rr9o3e0U0HUCegvjD58GCkL+SeYVVjrox8bYNGzN9
         GhSAgTCrokChy71xUSxuveBRjpsKSx8zORJLKgNytSFpGNUXsMzBF8wiFoueY5K1DXwe
         vxuhmP+QQmbzdn39+mZWe3SC3tKxGJqNoEmcgegQICP0sCv+tNmELDzXPQ0VTKNWr8Pr
         ESYlmGZ7Z1oM+oKOnItEll+cMU6rnvwrcYciPhR033fhhlOLgt3uTwGU0JzjNxDs0RaV
         fGzFGE/+CDUjYeBBT83+X9QBOLFzHXAMRK+NgGtZSZWu3izmsKoU95lYr7sU4Qq6MNP2
         qQkQ==
X-Gm-Message-State: AOAM532mmFFr/t7bgkyQ8+3nBXbyiI4N2reRgLvGjwV7OKnbTaE9uRnl
        g1EJPE8j6owbyXc4s7gaoxoMyapdXxHevw==
X-Google-Smtp-Source: ABdhPJwWSTpySBGm7o6pyhpzyWOoXtWOExVDc6+pizpXAC0kUuqkLVz4SbBzgQCIsZNkmGTBrwGnYA==
X-Received: by 2002:a1c:a443:: with SMTP id n64mr4562314wme.32.1633452711715;
        Tue, 05 Oct 2021 09:51:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b9d9:80fd:d5df:361b? ([2a01:e34:ed2f:f020:b9d9:80fd:d5df:361b])
        by smtp.googlemail.com with ESMTPSA id m4sm2643472wml.28.2021.10.05.09.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:51:51 -0700 (PDT)
Subject: Re: [PATCH] thermal: thermal_mmio: Constify static struct
 thermal_mmio_ops
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Talel Shenhar <talel@amazon.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
 <CAJZ5v0jrXbuyQez1rX7-9CEjazTFp32SSH60Tx5Oqf+D2Czv5Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01fde6ee-af39-1ae2-a8e2-da8e4f3f8e68@linaro.org>
Date:   Tue, 5 Oct 2021 18:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jrXbuyQez1rX7-9CEjazTFp32SSH60Tx5Oqf+D2Czv5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 16:36, Rafael J. Wysocki wrote:
> On Tue, Sep 21, 2021 at 3:55 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
>>
>> The only usage of thermal_mmio_ops is to pass its address to
>> devm_thermal_zone_of_sensor_register(), which has a pointer to const
>> struct thermal_zone_of_device_ops as argument. Make it const to allow
>> the compiler to put it in read-only memory.
>>
>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>> ---
>>  drivers/thermal/thermal_mmio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
>> index ded1dd0d4ef7..360b0dfdc3b0 100644
>> --- a/drivers/thermal/thermal_mmio.c
>> +++ b/drivers/thermal/thermal_mmio.c
>> @@ -34,7 +34,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
>>         return 0;
>>  }
>>
>> -static struct thermal_zone_of_device_ops thermal_mmio_ops = {
>> +static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
>>         .get_temp = thermal_mmio_get_temperature,
>>  };
>>
>> --
> 
> I'm not sure what happened to this patch.
> 
> Daniel, are you going to pick it up?

Yes.

I had picked also the intel ones but I'll drop them.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
