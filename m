Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF12B404E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgKPJx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 04:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgKPJx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 04:53:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F0C0613CF;
        Mon, 16 Nov 2020 01:53:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so24243046lfe.12;
        Mon, 16 Nov 2020 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lcEOXvLAoocGQuexLr5WJ4wPYzuj7Bow0v7llTK1Jfo=;
        b=Tled1+1mn2KZFgkOsJhRdU4B/dSV1SzMNyrnCwAD4DOJyZmRBWB4E5JTiKQEOdAN3p
         pF9WPiD/8+mMyRKAubV9F755dBUaIIqFkNx4LtloQeZ6TVc8Ai4d1PWy6/HV4N+IOE2d
         vLwnfrSSaJsQRiTEFbXzSKXRozRmdKutJb0irVaXC9mSbG4l8J7OVZ6is9brT9iftzBi
         pQjFmDXpGlBAtOlY9TOdnJzyV4VP7eZBclX5ixrhxYEbXjlhVHa0cIfxfUeKSSpyvIV0
         78D0D6NGvXeXUh5q/A84HfvIdrqYsUOdG0/b9BnKyDvdBXJ7JYE7efNnewh96joOaGar
         6eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lcEOXvLAoocGQuexLr5WJ4wPYzuj7Bow0v7llTK1Jfo=;
        b=glJkKsKyCbo1sfN0nqjhQImv2T/sOMSuNPLEv7yvGl5xgAYttGo895es9H/KUMfsqM
         B+qvRqRy2TdHcRItCHDxiVuOPMLapLFUUuTKipUNzYULPFZC5G4c7RVPHp1WTBoRmZFK
         r0G1ZG9Icr+jcfheMElS5g7pRaefbHPfyXkB0n/6C2adxnXjD/fDjOiEvXrDcVY3QsbP
         vyAYrhEKey0U2Cy/krxPdDxy0pDQvHvwjuXUFhCkG8J+i8E/usxltETK9SkFvITHMkIj
         FtRuEkpafNJQAlu4Wd1r1WgLAWRgFzIQVCzWUeK4tua+Uqt07rHQXCbR6Qgqeic/ZJl3
         8JMg==
X-Gm-Message-State: AOAM532ql/3fhS17lujMlupH/1yt5Oi3SpAn8/q9PUF3afri2vBEkulM
        0uUUqPm1t8LohvfWDO99sJP1HKtwSds=
X-Google-Smtp-Source: ABdhPJyY8SXeXZKjXG+v2mu8zs7ZkL6P8R2nIMeg8/9jyH0X78uYadqfSP/FqagxTyXg0PgQ34mP3A==
X-Received: by 2002:a05:6512:481:: with SMTP id v1mr6984646lfq.132.1605520436092;
        Mon, 16 Nov 2020 01:53:56 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id f9sm2644923lfe.192.2020.11.16.01.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 01:53:55 -0800 (PST)
Subject: Re: [PATCH v5 2/4] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201104203403.24937-1-digetx@gmail.com>
 <20201104203403.24937-3-digetx@gmail.com> <20201113093747.GJ2787115@dell>
 <3ad644fd-cd03-a1e1-36d9-014304fdfcee@gmail.com>
 <20201116084837.GM3718728@dell>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0e795281-ca18-fca6-1585-a487bcfabb86@gmail.com>
Date:   Mon, 16 Nov 2020 12:53:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201116084837.GM3718728@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.11.2020 11:48, Lee Jones пишет:
>>>> +config MFD_ACER_A500_EC
>>>> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"
>>>
>>> Drop "driver".  This is meant to be describing the device.
>>>
>>>> +	depends on I2C
>>>
>>> depends on OF ?
>> ...
>>>> +	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
>>>> +	select MFD_CORE
>>>> +	select REGMAP
>>>> +	help
>>
>> ARCH_TEGRA_2x_SOC selects OF.
>>
>> For COMPILE_TEST it doesn't matter since OF framework provides stubs for
>> !OF.
> 
> I always thought it was best to be explicit.

Alright, I see that the OF selection is all over the MFD Kconfig, hence
let's keep it consistent.

I also prefer the explicit variant more, but some other kernel
maintainers may disagree.

>> ...
>>> Why EOPNOTSUPP?
>>
>> Other sizes aren't supported by embedded controller.
>>
>> Although, perhaps this check isn't really needed at all since the sizes
>> are already expressed in the a500_ec_regmap_config.
>>
>> I'll need to take a closer look at why this size-checking was added
>> because don't quite remember already. If it's not needed, then I'll
>> remove it in the next revision, otherwise will add a clarifying comment.
> 
> "Operation not supported on transport endpoint" doesn't seem like a
> good fit here.  If the check says, please consider changing it to
> something like -EINVAL.

The regmap core code performs all the necessary checks before driver's
code is reached, perhaps I just overlooked something before. Hence it
will be removed in the next revision.

...
>>>> +	while (retries-- > 0) {
>>>> +		ret = i2c_smbus_read_word_data(client, reg);
>>>> +		if (ret >= 0)
>>>> +			break;
>>>> +
>>>> +		msleep(A500_EC_I2C_ERR_TIMEOUT);
>>>> +	}
...
>>> I'm surprised there isn't a generic function which does this kind of
>>> read.  Seems like pretty common/boilerplate stuff.
>>
>> I'm not quite sure that this is a really very common pattern which
>> deserves a generic helper.
> 
> What?  Read from I2C a few times, then sleep sounds like a pretty
> common pattern to me.

Maybe the read_poll_timeout() helper could be used for that, but I think
the open-coded variant is much easier to perceive, don't you agree?

>> ...
>>>> +static int a500_ec_restart_notify(struct notifier_block *this,
>>>> +				  unsigned long reboot_mode, void *data)
>>>> +{
>>>> +	if (reboot_mode == REBOOT_WARM)
>>>> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
>>>> +					  REG_WARM_REBOOT, 0);
>>>> +	else
>>>> +		i2c_smbus_write_word_data(a500_ec_client_pm_off,
>>>> +					  REG_COLD_REBOOT, 1);
>>>
>>> What's with the magic '0' and '1's at the end?
>>
>> These are the values which controller's firmware wants to see, otherwise
>> it will reject command as invalid. I'll add a clarifying comment to the
>> code.
> 
> Thanks.  Hopefully with a bit more information as to why the firmware
> expects to see them.  Hopefully they're not random.
> 

These are the firmware-defined specific command opcodes, I'll add
defines for them to make it more clear, thanks.
