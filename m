Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB42921179F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 03:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgGBBU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgGBBU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 21:20:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB03C08C5C1;
        Wed,  1 Jul 2020 18:20:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so24927495lji.12;
        Wed, 01 Jul 2020 18:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dYCeMOPmLDd6YkOtzFpnQl9uCIfo9ocTM9gPN7zgGLs=;
        b=d9j4CswU2NFZCBq45rswJjWthlpogrZnyxU2Y3/qFx3SzQ/Yg010yg+KHPckVLMK7E
         sPM8Vl3sG/AcQaGYeiyAu0/y2NWDRFpN1cCGWZfSvqzvHm5OiyAxAO1Dt97pMU2E0dmk
         iS7KuYi16IoF64egljBq4I2PpWLZDdd95183IIuQ7d7bgik4N+IndnkWEQhQKukAgMZA
         s+JpJag5nHTBtAfKONT0BOIODyFke/y2jPMJiBL+CegXb4WhTK5iNesdPuPjBHoOitij
         010J4brz2P8aTqBd6+yMM3QatHxh0kZo1oOmAU8jRZ0M8hgVNeF73mXnCW8JE/+4P82m
         R9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYCeMOPmLDd6YkOtzFpnQl9uCIfo9ocTM9gPN7zgGLs=;
        b=YC6fEuv8hQgsxL5mbKztMb2innT7OnhnNF4HqcD5xTW+u9yly7Cmlf+uSa3mzyybgK
         m8pu3VQn1Cxdl/Q5mbR97v226SLQHsfYT8KXDQGnj0HjrJ1wfj44AonMdt3eIxxckHJq
         C68JCzlAgSeflTxVijmfeH3+/tbiw8Lm3LFXmaD1a6XLeI4jalGzCwh9/KPErjwyFHJT
         LJCv2769IMQJ3FAKzte2VyXp9eJn6EqjzYB77EamhkNrgSmbssBHY9nvWWC2dr+mqScF
         szRdu1EqSen8Qo3oNxqlvCl+2TDu/dt04QICs04jCVWKrb/8Q6N8EZ2VtRHJncVTLtaq
         FJLQ==
X-Gm-Message-State: AOAM532Kzwo/s220/HRqHhhwt1ddR/YYfgy02sHtWfRqJJxT2CCaE3eK
        BQAoVn7QRYCFqgVxJDpj+5ZRtJomzjw=
X-Google-Smtp-Source: ABdhPJxfVjfn28q5t97TdXNmIK+RNFjKEXIoVX+Bw+Pu1pBF7C+yZ6DON9DioM1xmYHgdH2FopVzAw==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr13554159ljj.280.1593652857102;
        Wed, 01 Jul 2020 18:20:57 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id d18sm2380862lja.116.2020.07.01.18.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 18:20:56 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fda8aa80-04f1-af00-7a0d-f9b589cdb37e@gmail.com>
Date:   Thu, 2 Jul 2020 04:20:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <136b430d-2097-7b2b-d7dd-b438deee8f5d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 03:59, Chanwoo Choi пишет:
> Hi,
> 
> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>> Tegra EMC driver was turned into a regular kernel driver, it also could
>> be compiled as a loadable kernel module now. Hence EMC clock isn't
>> guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
>> there is no good reason to spam KMSG with a error about missing EMC clock
>> in this case, so let's silence the deferred probe error.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index e94a27804c20..423dd35c95b3 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -801,9 +801,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
>> -	if (IS_ERR(tegra->emc_clock)) {
>> -		dev_err(&pdev->dev, "Failed to get emc clock\n");
>> -		return PTR_ERR(tegra->emc_clock);
>> +	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
>> +	if (err) {
>> +		if (err != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev, "Failed to get emc clock: %d\n",
>> +				err);
>> +		return err;
>>  	}
>>  
>>  	err = platform_get_irq(pdev, 0);
>>
> 
> As I commented on patch10, I recommend that you add the Tegra EMC driver
> commit information into patch description and Looks good to me.
> 

Hello, Chanwoo!

This patch11 and patch10 are depending on the patches 4/5 (the Tegra EMC
driver patches) of *this* series, hence there is no commit information.
I'm expecting that this whole series will go via tegra tree once all the
patches will be reviewed and collect all the necessary acks from you,
ICC and CLK subsystem maintainers.

Please feel free to give yours ack to the patches 10/11 if they are good
to you :)
