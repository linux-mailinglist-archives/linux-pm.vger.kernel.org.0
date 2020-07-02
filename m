Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AA21181E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGBBZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 21:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgGBBZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 21:25:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011BBC08C5C1;
        Wed,  1 Jul 2020 18:25:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so16284109ljm.1;
        Wed, 01 Jul 2020 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OA49WuL0sThpD2AYuMtpdZGroGjS32Zzwhjd8yiNNuE=;
        b=Mk2P/S1R51LjiHT7a52NIA3xKyA8UaSrakv3wRtyWYPe6BL3niPa/Dc/e4xhwoI/7y
         qJCb9fIvWwDH+rLQCzB7ZXYtVgYJ17S079OzNbyqQDLIp0iyIOZCd2f/fXeMuCcMZLJt
         /nXGZj42VSvsYShz0ll30Lyi6zGzcBWLqTeKBVrFClp61LhaHRGRo7AY9m0Pyg+rKlJg
         leQR6wWLC+Ta3BChiNfVKYMnm6Cnijo3iVy35FtBvlPGz1TinVSDi5OeLq4ExN/pNSKk
         HVnbRxh9g2dXkTgaTw8nTyxZK7+4+/oV5s4HURZiYG3wpDpJvgjBmRy+AXNHPlFQSHMp
         sU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OA49WuL0sThpD2AYuMtpdZGroGjS32Zzwhjd8yiNNuE=;
        b=slZMJu6lAawQN/iCGs4dlR9wMT9bChNtotd7jbt18qWWpQgBtEpozvPhrYb6v98KTQ
         p+sGjMzHCybZuAv5p7opDBBhO8eUVfIPNvhvwFLtgW7Ix3FwNx6eC2Co+cH6emM2lgG7
         Aq4wvhdtZxuiU5jDBDGsdd7NQGHrOyZOhmTxXZvuuGbbfKSaJN6B+7nNVOpgrUji7FC8
         bBBTtWKL4BFsPvMJG6IcVSKhwa/Djra3lfDWXTP0zQmOJNS7Pi11rbsodUsyYcBuIoYm
         dlxGFzkkjbIUlvXyV2B6rIhfGzLDALvnexi6bzqSLLXq/UKI4nDOAph5QpAA1J2ECQM1
         xImg==
X-Gm-Message-State: AOAM532p/VGDQQmPt/R2Fs9r3rOXPcWcZ2mYCxqEBDAUihn6OOq/Tv0k
        JL8Z7UshUhQb6DHBZaPflXkvvWXZcQM=
X-Google-Smtp-Source: ABdhPJxhRnB8zlB9MEI6/ePrP8TdwiCvmtrvwqZ45jg4cOgOfkQ8DUYoWvB37U4c3CnwDzsMcLaC0A==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr10807112ljg.61.1593653104194;
        Wed, 01 Jul 2020 18:25:04 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id t4sm2704596lfp.21.2020.07.01.18.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 18:25:03 -0700 (PDT)
Subject: Re: [PATCH v4 11/37] PM / devfreq: tegra30: Silence deferred probe
 error
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <CGME20200609131843epcas1p3a5b06308559ff03ef1b27521f412b656@epcas1p3.samsung.com>
 <20200609131404.17523-12-digetx@gmail.com>
 <136b430d-2097-7b2b-d7dd-b438deee8f5d@samsung.com>
 <fda8aa80-04f1-af00-7a0d-f9b589cdb37e@gmail.com>
 <8e941321-5da6-e9e7-6a4e-8c0477911ebd@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3e30279c-0964-4dd8-e7ac-2066c8ccc902@gmail.com>
Date:   Thu, 2 Jul 2020 04:25:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8e941321-5da6-e9e7-6a4e-8c0477911ebd@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 04:34, Chanwoo Choi пишет:
> On 7/2/20 10:20 AM, Dmitry Osipenko wrote:
>> 02.07.2020 03:59, Chanwoo Choi пишет:
>>> Hi,
>>>
>>> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>>>> Tegra EMC driver was turned into a regular kernel driver, it also could
>>>> be compiled as a loadable kernel module now. Hence EMC clock isn't
>>>> guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
>>>> there is no good reason to spam KMSG with a error about missing EMC clock
>>>> in this case, so let's silence the deferred probe error.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra30-devfreq.c | 9 ++++++---
>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>> index e94a27804c20..423dd35c95b3 100644
>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>> @@ -801,9 +801,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	}
>>>>  
>>>>  	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
>>>> -	if (IS_ERR(tegra->emc_clock)) {
>>>> -		dev_err(&pdev->dev, "Failed to get emc clock\n");
>>>> -		return PTR_ERR(tegra->emc_clock);
>>>> +	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
>>>> +	if (err) {
>>>> +		if (err != -EPROBE_DEFER)
>>>> +			dev_err(&pdev->dev, "Failed to get emc clock: %d\n",
>>>> +				err);
>>>> +		return err;
>>>>  	}
>>>>  
>>>>  	err = platform_get_irq(pdev, 0);
>>>>
>>>
>>> As I commented on patch10, I recommend that you add the Tegra EMC driver
>>> commit information into patch description and Looks good to me.
>>>
>>
>> Hello, Chanwoo!
>>
>> This patch11 and patch10 are depending on the patches 4/5 (the Tegra EMC
>> driver patches) of *this* series, hence there is no commit information.
>> I'm expecting that this whole series will go via tegra tree once all the
>> patches will be reviewed and collect all the necessary acks from you,
>> ICC and CLK subsystem maintainers.
>>
>> Please feel free to give yours ack to the patches 10/11 if they are good
>> to you :)
>>
>>
> 
> OK. Looks good to me
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Thank you! :)
