Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590DF410AF2
	for <lists+linux-pm@lfdr.de>; Sun, 19 Sep 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhISJpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Sep 2021 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbhISJpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Sep 2021 05:45:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCDC061574;
        Sun, 19 Sep 2021 02:43:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n18so14378973pgm.12;
        Sun, 19 Sep 2021 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ujZYCN2hNIBT5RbdU8R3eOc6j6lEG3PQETpYdg9DbBc=;
        b=MRfUZHjikWvtbxL9OaHghlwj40Fx/p2cDFvuKXkLmqdBPDvOSgx9Rmhuayid1vNXcD
         GlGdc+shfLUDhFE4jaPnEWlCa/OZ9cQRpY8i9ewKdbC4V08O6D2INQvVvHFKlK1qMGNq
         Xw9niYzj5ddgEtVfkrOMt7NNQpNO6/pmhVtwzpMbtWYD/+FtkZjBWRUcLj30SfpUxTlF
         dZ4N/WQhGchhvzTBixOhZ0RSlz5+c3dqdBzUMQ891gcS6ukQGrUMfnlcWVrCNf6PJyU2
         RQ5mKVGbGyCVcp5ugIv7nq36a31GaNsfnuMaCX+IFrwlOjSqcHq0Yn+Zuz8ca9EQ8CXf
         RQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujZYCN2hNIBT5RbdU8R3eOc6j6lEG3PQETpYdg9DbBc=;
        b=MtAKbHGjJUEwxOzneet4gbgGLd6no3KD6WBp3DxHAqsioiKJpYeIrBjbCt4UT9GeSJ
         lxc5ekZBySuWMwRdjqtUdI2p8/ZdRvmq/bJyFdHsrjTnTCRFRs1xXjJhSH8gscb346AW
         1yl6lT1Eur68KfMw3suIp/KMdX8xtHdq0WX4fgeK5mYriiTPggOHWN1L6IJh9QWp54HR
         KF9kpPY2DywgwwxyFhARinIBOLoFeomI+/4tkhJW6CfJ7EC0BAeZ1TeFUInUuH2Pi/Z9
         ymZtLqY2XYx0WMakp12sLibJZMb2TX0b8vDXO3tjGDBvdi+saMcUefk7ydGS48XMOm4E
         9dBg==
X-Gm-Message-State: AOAM531tDdrw8f9IY7cH1pNKGSGBfc77S9lbbKDSY/F2YKJEmXBluUz5
        5TsV9ks2THg+on5U5p65OqGFO2nkVj4=
X-Google-Smtp-Source: ABdhPJxbbHzNmfgc5i6PcrHjAWEr1DMvwBIs+hDKpJBTdjeXbNpu+gig3MhSpK+FL8ySD6H3hcMnOw==
X-Received: by 2002:a63:ce57:: with SMTP id r23mr18549344pgi.271.1632044625811;
        Sun, 19 Sep 2021 02:43:45 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y80sm6403104pfb.196.2021.09.19.02.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 02:43:45 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PM / devfreq: tegra30: Check whether
 clk_round_rate() returns zero rate
To:     Dmitry Osipenko <digetx@gmail.com>
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
 <26d90b01-13d5-3bd8-da0a-b9ff61c7845a@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <4b5faca8-c0fc-e7bb-5a0b-c66714bc5f61@gmail.com>
Date:   Sun, 19 Sep 2021 18:43:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <26d90b01-13d5-3bd8-da0a-b9ff61c7845a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 16. 오전 10:28, Dmitry Osipenko wrote:
> 15.09.2021 21:31, Chanwoo Choi пишет:
>> On 21. 9. 15. 오후 12:51, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
>>>> EMC clock is always-on and can't be zero. Check whether clk_round_rate()
>>>> returns zero rate and error out if it does. It can return zero if clock
>>>> tree isn't initialized properly.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>    drivers/devfreq/tegra30-devfreq.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>> b/drivers/devfreq/tegra30-devfreq.c
>>>> index d83fdc2713ed..65ecf17a36f4 100644
>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>> @@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct
>>>> platform_device *pdev)
>>>>            return err;
>>>>        rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>> -    if (rate < 0) {
>>>> +    if (rate <= 0) {
>>>>            dev_err(&pdev->dev, "Failed to round clock rate: %ld\n",
>>>> rate);
>>>> -        return rate;
>>>> +        return rate ?: -EINVAL;
>>
>> If rate is 0, It doesn't return and fall-through? even if print the
>> error message. 'return rate ?: -EINVAL;' style is strange for me
>> because it doesn't specify the 'return value' when rate is true.
> 
> It's not clear to me what do you mean by "return and fall-through".
> 
> It specifies the 'return value' when rate is true. It's a short form of
> "rate ? rate : -EINVAL".

I has not known this short form. Thanks for comment. I understand.



-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
