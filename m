Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECDEC476
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 15:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKAOPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 10:15:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35767 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKAOPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 10:15:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so1736207ljg.2;
        Fri, 01 Nov 2019 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e0tGtyGNT4kJrC3FzIuXmzWyqLKYES36p37pNrq+te0=;
        b=q+oEe0pDcNt3aIIGsFlBC+vuhAWm6ZzaY0JHON82tZAuc4IJ2cLt1cUxWgrmeaLIdb
         i8r+E34/NXMzQcH7AIDpod2KClNHoWXKvFE7UNWx/sOsLESjDJAjcfxHe2YkSu6UzP1D
         NSP8YdpxKHt8/ksrGkElnpj2dpiyBVNnnPIsaLEzkLTWWoY3NQdoRFwgiN28SPaAiRax
         UWZRi7zzLMpua5uNWM5xsglcC5V4PtsQrEwume77vAcHarRKklyYb+MPYZu+LnjmylEo
         FzAgFhzJW3ZNN82tpOxSpn7uwGHJFA0n9Ww15hs9ryrrtVqSGWVKlCGaasEaXmGIlNr9
         TmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0tGtyGNT4kJrC3FzIuXmzWyqLKYES36p37pNrq+te0=;
        b=YnjxfFRbr6QuGVxVg0ATKVCho9urVt3gZZBmIkuwmZjdZLIH+Uo8lIN1L38oXrFv7q
         FsZH5umgGvylyeuJc8Bh+pkD/AlqXXTmnM9h4z/NQbHnXQsEiJZUQsRrZhc8V8AKKlT9
         n/SY+aWGEpHzk05i7j7hFXk/86BgVUThj3AsPSWwMQeLMtza/3W2IGJ65MSsEPS6e45p
         Jm0ucJmTb5gUtCMSoAf6OJPVblEiRn4sKc2IwpkEQ1y1xg2LQZjiKJ6p1ZoIRFdE+f8D
         EPo7fNt++lDjD6BmeA3O+yiLXR6Ccv4HQC73LAnPDsPJEDeHIZntmEPpCoGkWOeRiPUS
         0kug==
X-Gm-Message-State: APjAAAXhWdTmlu/Y5ckHVN8Ym9JddauDjv2VPBQ+FiWhdUoEGc3Su4fV
        xZ+h92aqHKPg6kr85jwZIQV+2q2B
X-Google-Smtp-Source: APXvYqxsbdGpkDO3MxGcdyqfwf4268XChSrkHtw4H/YHQKMTTu1VOUYaS95vLN1tgjUOnaJze2Im1A==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr8468737lji.68.1572617698640;
        Fri, 01 Nov 2019 07:14:58 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id v21sm2584805lfe.68.2019.11.01.07.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:14:58 -0700 (PDT)
Subject: Re: [PATCH v7 18/19] PM / devfreq: tegra30: Tune up MCCPU boost-down
 coefficient
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029220019.26773-1-digetx@gmail.com>
 <CGME20191029220656epcas2p4b19cb854054ebce6132c7111f52cada4@epcas2p4.samsung.com>
 <20191029220019.26773-19-digetx@gmail.com>
 <99a90972-2170-ebcb-7bff-cd9ba8b0b0d1@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <110096a4-9f77-3912-a911-76d9c2c5c277@gmail.com>
Date:   Fri, 1 Nov 2019 17:14:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <99a90972-2170-ebcb-7bff-cd9ba8b0b0d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2019 10:45, Chanwoo Choi пишет:
> On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
>> MCCPU boosts up very aggressively by 800% and boosts down very mildly by
>> 10%. This doesn't work well when system is idling because the very slow
>> de-boosting results in lots of consecutive-down interrupts, in result
>> memory stays clocked high and CPU doesn't enter deepest idling state
>> instead of keeping memory at lowest freq and having CPU cluster turned
>> off. A more faster de-boosting fixes the case of idling system and doesn't
>> affect the case of an active system.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index d0dd42856e5b..9a21a29198ee 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -123,7 +123,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>>  		.offset = 0x200,
>>  		.irq_mask = 1 << 25,
>>  		.boost_up_coeff = 800,
>> -		.boost_down_coeff = 90,
>> +		.boost_down_coeff = 40,
>>  		.boost_up_threshold = 27,
>>  		.boost_down_threshold = 10,
>>  		.avg_dependency_threshold = 50000,
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> IMO, I think that it is not good to change the threshold value
> on device driver directly when some requirement happen.
> Instead, better to get the threshold value from device-tree file.

I think in worst case these values could be tuned for a hardware
generation. The current hardcoded values should be good enough for everyone.

If we'll find that some differentiation is needed, then we could
consider making the pre-defined config per hardware generation by
specifying "data" fields of the of_device_id table.

It also should be possible add sysfs interface for userpace to change
the boosting values. Or make these values a driver's module parameters.

There are different variants of what could be done in order to
differentiate the configuration. But again, this is not needed for.
