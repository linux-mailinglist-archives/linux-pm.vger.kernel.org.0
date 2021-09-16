Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3761140D130
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 03:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhIPB3d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhIPB3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 21:29:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D221C061574;
        Wed, 15 Sep 2021 18:28:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so11857749lfu.5;
        Wed, 15 Sep 2021 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nn45bUIl96WIFsT4CN3x7DghHPbrAhKFSaIduPWSZkU=;
        b=D8DU4mSw6cSYFQ8suIyp64R0VVAZh6DQCoxHnANYkUTfVZiEEyVKQ+yqiou/6fQ5Qm
         vkTu7PInawFreqF8g4x91QuV7ppLmVabWqAguheLpb0FFTDxs5bekaBqMe492Ws3v4LM
         YYQpIW00z///2b2I9Jca54Q1yhdNCrLD+fPPAV6XCOtA0yBi/2AyuLRE0P+30+6LYjQC
         68yzExokhqLpcT/KhCmFV2d9/ZKHpDTswSjQHddq58MjMELZTx2akWj18YzOzAWaUF1G
         W36Zys7m7RQCoASklp67URZIo7p6eeRtZT8Lv4cxud3KxPDsvC3hIrOQsULYHjDMk4gq
         jP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nn45bUIl96WIFsT4CN3x7DghHPbrAhKFSaIduPWSZkU=;
        b=ActXdSq1jjZ1t7cmI46rmXzIf3Pg1FaXUZNw5uJSqxIzdKPNdEYpyxepT/83BA9x7J
         Z98z0kzeG8ES0PpKiFW55sWKT+2iNEXoHtJ0a5wFaOWbQLCSiG/rY7anuYseQBTgiIK9
         oqwYLBO6UubPujj1aiYXNxznrzPo4aLw6swzwX6UnNWJulvDBr76gt5qdixq0VzfrN1L
         7AOUAr/Iik2UaqtxNBjdymHicnwmT+ek7qmZ66Ohye4KEzP5aVdcgsG/qZt1IPKPrlKL
         TVHtH34F1HWAJntet8v/5jvHii7CF3+ryDyo8XB7VMrE7qGg9jc4atvtsIIsQZvPikgc
         SW2g==
X-Gm-Message-State: AOAM532om5Ked8JxiPGajfvO30HqUFd15bY1Se+viiEh5PjPmBosz6zP
        Qg2HyDPWnTePh1q5ITU1bjs=
X-Google-Smtp-Source: ABdhPJzbUSUXPW9or3AwwwZSR/K3KohU1VLv2sABEALCC/gpyM3zULJdOtF7UOBfYYrMwSl4YhDk7w==
X-Received: by 2002:a05:6512:3fa8:: with SMTP id x40mr2051116lfa.536.1631755689417;
        Wed, 15 Sep 2021 18:28:09 -0700 (PDT)
Received: from [192.168.2.145] (94-29-62-67.dynamic.spd-mgts.ru. [94.29.62.67])
        by smtp.googlemail.com with ESMTPSA id x192sm121892lff.154.2021.09.15.18.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 18:28:08 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PM / devfreq: tegra30: Check whether
 clk_round_rate() returns zero rate
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-5-digetx@gmail.com>
 <9fa66405-883a-3653-eb5d-3cd7eee07a0a@gmail.com>
 <e9233eeb-6780-b390-dffa-8de9315effa3@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <26d90b01-13d5-3bd8-da0a-b9ff61c7845a@gmail.com>
Date:   Thu, 16 Sep 2021 04:28:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e9233eeb-6780-b390-dffa-8de9315effa3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.09.2021 21:31, Chanwoo Choi пишет:
> On 21. 9. 15. 오후 12:51, Chanwoo Choi wrote:
>> Hi,
>>
>> On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
>>> EMC clock is always-on and can't be zero. Check whether clk_round_rate()
>>> returns zero rate and error out if it does. It can return zero if clock
>>> tree isn't initialized properly.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>   drivers/devfreq/tegra30-devfreq.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c
>>> index d83fdc2713ed..65ecf17a36f4 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev)
>>>           return err;
>>>       rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>> -    if (rate < 0) {
>>> +    if (rate <= 0) {
>>>           dev_err(&pdev->dev, "Failed to round clock rate: %ld\n",
>>> rate);
>>> -        return rate;
>>> +        return rate ?: -EINVAL;
> 
> If rate is 0, It doesn't return and fall-through? even if print the
> error message. 'return rate ?: -EINVAL;' style is strange for me
> because it doesn't specify the 'return value' when rate is true.

It's not clear to me what do you mean by "return and fall-through".

It specifies the 'return value' when rate is true. It's a short form of
"rate ? rate : -EINVAL".

The final returned value will be printed by the driver's core. The value
returned by clk_round_rate() is important here since it tells the reason
of the error.

https://elixir.bootlin.com/linux/v5.15-rc1/source/drivers/base/dd.c#L533
