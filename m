Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A19274DCA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 02:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIWAX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 20:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgIWAXz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 20:23:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8589FC061755;
        Tue, 22 Sep 2020 17:23:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so15662315ljj.12;
        Tue, 22 Sep 2020 17:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwzaj94ysfb2oIuq7DMGMurIpefx3s7WUXIPx+I2/JI=;
        b=HsjApSOQdUFAXFomG0yjE8eIsjfUv+vuxrkNFEzOjy7yBCKLpyehHduZkrcSlQXpzX
         +8EzQTenrCe2UHZPnaGtAP7BSIOi2qxqCzEtA/08QUq6RvB69JGjKo5f/QXn0/2OOXik
         qwV12VaUhHZFV5vsEX5wkJ4sv5SzP1aAxL6UVsgo9IH8OpIt7+ODrn/6pnn3e1qaQxwQ
         JduhuHTdqnm/5emRGmiFU5ndBYwvbFVChFwaq/4/X47ZH4AVAWW/O1mbCeOQEI627LJC
         bpv/tT8bui01jscbPWSZ/HpKFBxI19cTQER0qtvQTvtcl/9/PrYL09TKqntPKNxRiNp9
         Tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwzaj94ysfb2oIuq7DMGMurIpefx3s7WUXIPx+I2/JI=;
        b=ms0A4X+ACxWSTsV1GdN1QhOEtclhBHk0+bdkNzL33siinCZDccOuMtOOW4oIHh91db
         9Y340qYigL2vKp2qv9A0xPylkGWXglaV3+/b5jCEfPrWt7yAk2nupDAXCYSrEUzTSYOn
         eGu5NCYmtPR5rvdd7j2jgYZBrwiNQwGr/hQ3nyrOd9inlHp046D8PR6YJlYHO+QfbLkd
         oHCUCAZ55K7/sLUjHwBcE9Yzxb/+aZrnvpzJGW5MJ6dCIoUOg/2JBVaEO2w1X8RiLKSv
         9izXFQMBH3VU6Lx1ClExv47rjONVFcFDPlm6nJ9PCIshf03UPesaso/RJ64JXFFLndAQ
         lD+Q==
X-Gm-Message-State: AOAM531hA870/OrmUNhNjkMxf1LswRANkwxBbDFQ/RGx57vsfwuPD25b
        bZQ9s7ibLIlMd6gVlhI0+1aIcR7lLvs=
X-Google-Smtp-Source: ABdhPJyeTG9zBC3DCrZGGpyGMVtvFhq9Cv5J7h6zr1hxSWOy/bzdCkJqDKMqs5yXZK6qL4bTJ37snA==
X-Received: by 2002:a2e:9943:: with SMTP id r3mr2154914ljj.342.1600820633688;
        Tue, 22 Sep 2020 17:23:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u18sm4393580ljo.131.2020.09.22.17.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 17:23:53 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
 <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
 <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
 <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
 <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
 <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
 <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
 <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
 <64f4b682-00b7-60f2-902f-e50a40a04a55@samsung.com>
 <c80c6f3a-bbbf-f18b-33c8-62e63397df9c@gmail.com>
Message-ID: <cc3523ad-1295-cccb-12da-f0ea7c129e7a@gmail.com>
Date:   Wed, 23 Sep 2020 03:23:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c80c6f3a-bbbf-f18b-33c8-62e63397df9c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.09.2020 00:37, Dmitry Osipenko пишет:
> 18.09.2020 12:23, Chanwoo Choi пишет:
> ...
>>> Hence if we want to improve the code, I think we can make this change:
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c
>>> index ee274daa57ac..4e3ac23e6850 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -891,8 +891,6 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev)
>>>  		return err;
>>>  	}
>>>
>>> -	reset_control_assert(tegra->reset);
>>> -
>>>  	err = clk_prepare_enable(tegra->clock);
>>>  	if (err) {
>>>  		dev_err(&pdev->dev,
>>> @@ -900,7 +898,7 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev)
>>>  		return err;
>>>  	}
>>>
>>> -	reset_control_deassert(tegra->reset);
>>> +	reset_control_reset(tegra->reset);
>>>
>>>  	for (i = 0; i < mc->num_timings; i++) {
>>>  		/*
>>
>> It looks good to me for improving the readability
>> for everyone who don't know the detailed h/w information.
> 
> Okay, I'll make a patch sometime soon.

Chanwoo, I want to clarify that the Dan's v1 patch is still good to me
and should be applied. I'll improve the readability on top of the Dan's
change.
