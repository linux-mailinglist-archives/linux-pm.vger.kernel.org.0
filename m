Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D432715C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Feb 2021 07:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhB1G7y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Feb 2021 01:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhB1G7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Feb 2021 01:59:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBBC06174A;
        Sat, 27 Feb 2021 22:58:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k22so7636568pll.6;
        Sat, 27 Feb 2021 22:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8CLTUXVVZcMiqETcvGKGx4dgIVTKeUoOcCN29WuOTI=;
        b=pZXOz7dSMFcRlF92cWgx1jtDPCUCzNTibhUw/QK3IMW4hHVgCbD4UIsZXFsyRaE2ko
         qcKIjE6+JXXMn5jICu0FGQY2RQ4ODfa6TTA38qzlCUolNqyw8K3bcWTNK0desIMxJU6i
         /Pa3Z9gmK06ioRO7l2j3GSt0i5u+J3CXCQbtlofX+M+tK6BwtpuPWAs0fd6Pyxfw9H8C
         AP06UL92/CkFi3JGp8AynbS9QTaMmAaZRcK6X0VAJ3Y/9MfOrmE0NZWECZbk/gdxFfk+
         T21qztGHpCHFnuzhm/9uMSDYGUdlT0aU1neZo3qtMFOr/H9z2iB9WaF1qP8DZHy8CSjM
         TeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8CLTUXVVZcMiqETcvGKGx4dgIVTKeUoOcCN29WuOTI=;
        b=L3AjQAI7g4HyA7rWSyEGR1umpSeAN6O9W2Efub6j6m/DikqohZhsOCc1My7/zw0qic
         elh9Tcbhjf3Up3uqluAYNgDCYdkE3G/pCd/SRIUjo0lugBToQxw/CHSUFM26/STTX1UK
         NCwZ+y5fbKgQjw/KquswE+HfKZcMIGlrGs+6YU5one5lIob8IyTDKMDrhbTD62/Aub1j
         7H+sBVchQRSgMqwBpU1gqnUQaSn13Nqkk2yBX7WZ0bvfBj+r/2puy2U3idgZRl2AvhLE
         XVCAmykgVC6MCZ18bQltwx9yUVLys5KjV4Mlw1g++ns5/UrWHaLYxf/xCgHjcaAGZwZR
         2MxQ==
X-Gm-Message-State: AOAM533DzKC0fxXjT0Ts9r8QTeABwVR2zBNLfFZpcPoKWc/iF7Xg/ibB
        ZBXXIUzxB5Y6Sh7bLk6xhgV0D7uD6bUDsg==
X-Google-Smtp-Source: ABdhPJxLl1eeT6VENQBjMZTEP9NmHMBjwg3TG64+8zuHU8eT3mS4phpRucptnYESkO+JHospYb5qZw==
X-Received: by 2002:a17:90a:a10a:: with SMTP id s10mr11502337pjp.36.1614495512210;
        Sat, 27 Feb 2021 22:58:32 -0800 (PST)
Received: from [172.30.1.25] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e8sm10252764pfl.101.2021.02.27.22.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 22:58:31 -0800 (PST)
Subject: Re: [PATCH] devfreq: rk3399_dmc: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <chanwoo@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200828153100.19006-1-krzk@kernel.org>
 <CAGTfZH3+mxBXzVp5Wz=F6nbx3bfubrmJozVzVdt8s1e45WQOqg@mail.gmail.com>
 <CAJKOXPdw=2MMT+5=_TtOqEwPA8s40J21eYXfzv8Whk7F8uF9dw@mail.gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <8c7f16ac-2287-eddb-e074-90cfec56500b@gmail.com>
Date:   Sun, 28 Feb 2021 15:58:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdw=2MMT+5=_TtOqEwPA8s40J21eYXfzv8Whk7F8uF9dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 2. 28. 오전 1:35, Krzysztof Kozlowski wrote:
> On Sat, 29 Aug 2020 at 15:10, Chanwoo Choi <chanwoo@kernel.org> wrote:
>>
>> On Sat, Aug 29, 2020 at 12:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Common pattern of handling deferred probe can be simplified with
>>> dev_err_probe().  Less code and the error value gets printed.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>   drivers/devfreq/rk3399_dmc.c | 20 ++++++--------------
>>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>> index 027769e39f9b..35b3542f1f7b 100644
>>> --- a/drivers/devfreq/rk3399_dmc.c
>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>> @@ -324,22 +324,14 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>          mutex_init(&data->lock);
>>>
>>>          data->vdd_center = devm_regulator_get(dev, "center");
>>> -       if (IS_ERR(data->vdd_center)) {
>>> -               if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
>>> -                       return -EPROBE_DEFER;
>>> -
>>> -               dev_err(dev, "Cannot get the regulator \"center\"\n");
>>> -               return PTR_ERR(data->vdd_center);
>>> -       }
>>> +       if (IS_ERR(data->vdd_center))
>>> +               return dev_err_probe(dev, PTR_ERR(data->vdd_center),
>>> +                                    "Cannot get the regulator \"center\"\n");
>>>
>>>          data->dmc_clk = devm_clk_get(dev, "dmc_clk");
>>> -       if (IS_ERR(data->dmc_clk)) {
>>> -               if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
>>> -                       return -EPROBE_DEFER;
>>> -
>>> -               dev_err(dev, "Cannot get the clk dmc_clk\n");
>>> -               return PTR_ERR(data->dmc_clk);
>>> -       }
>>> +       if (IS_ERR(data->dmc_clk))
>>> +               return dev_err_probe(dev, PTR_ERR(data->dmc_clk),
>>> +                                    "Cannot get the clk dmc_clk\n");
>>>
>>>          data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
>>>          if (IS_ERR(data->edev))
>>> --
>>> 2.17.1
>>>
>>
>> Applied it. Thanks.
> 
> Hi Chanwoo,
> 
> Do you know what happened with this patch? You replied that it is
> applied but I cannot find it in the Linus' or next trees.
> 

Hi Krzysztof,

There was some my mistake. I'm sorry.
I applied it again to next branch.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
