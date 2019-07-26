Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1A763DB
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGZKtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 06:49:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28035 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfGZKtT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 06:49:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190726104914epoutp01f5f27ef11324f7daee04fa1964142876~07108fxhX0870808708epoutp01s
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 10:49:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190726104914epoutp01f5f27ef11324f7daee04fa1964142876~07108fxhX0870808708epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564138154;
        bh=FIem0CBgLtzFAqemq5f5qbAnnycsSJMfeDVL8zF1qi4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WczEiAsv1rqzmdAOf14xZOESPKte7VHAJhZnEilN4tmci3GsxhVjWIWcifXfT2aF/
         XkJKFMULS08uM0I7x0Y5R2/a/25T6FKCYqOcUch+eBCuq4eOeBfIfzS6vsUPPd3O4S
         W0HxitfWe6g5wFmkuV5gTg9Jt3ma50XSZaAvHGt4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726104913epcas1p2d655cf59d621852a8144b4e197e4a334~0710Lb4eX2019720197epcas1p2N;
        Fri, 26 Jul 2019 10:49:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45w5Rq2TRZzMqYkZ; Fri, 26 Jul
        2019 10:49:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.8D.04075.7AADA3D5; Fri, 26 Jul 2019 19:49:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726104910epcas1p2eeb9f55b4fc0bc7b4d4a1bc05358758b~071xJudE-2019720197epcas1p2L;
        Fri, 26 Jul 2019 10:49:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726104910epsmtrp211de1d153c6bdc03c887623f840fa98a~071xGVDnz0122601226epsmtrp23;
        Fri, 26 Jul 2019 10:49:10 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-de-5d3adaa76465
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.9A.03706.6AADA3D5; Fri, 26 Jul 2019 19:49:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190726104909epsmtip1e1bb6a5400bed5480c06a24590667b60~071w323wD2044320443epsmtip1Q;
        Fri, 26 Jul 2019 10:49:09 +0000 (GMT)
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
To:     Krzysztof Kozlowski <krzk@kernel.org>, cwchoi00@gmail.com
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ea48649f-736e-4d76-e1f5-47731fb44a74@samsung.com>
Date:   Fri, 26 Jul 2019 19:52:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe4nOjjuA2MXLP1n=dPa7o6egjLZScSBNhyi9agHqqM7A@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmnu7yW1axBmcmClgcOraV3eLZUW2L
        +UfOsVpc+fqezWL63k1sFpPuT2CxOH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y25x
        u3EFm8WMyS/ZHPg8ds66y+6xaVUnm8eda3vYPO53H2fy2Lyk3uPguz1MHn1bVjF6fN4kF8AR
        lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S2kkJZ
        Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7
        4/p11YLrRhXH/8xnamD8p9TFyMkhIWAisezfTTYQW0hgB6PExRd+XYxcQPYnRon5E6+wQTjf
        GCVe3D/OCNPxaeZLqMReRolnW7uYIJz3jBJ7OjewgFQJC4RLvFz2BWyuiICtxO7Z81hAipgF
        VrJIrOt4BzaKTUBLYv+LG2BF/AKKEld/PAaL8wrYSXzb8hPI5uBgEVCVuDvNCyQsKhAh8enB
        YVaIEkGJkzOfgO3iFAiUOLZzDVgrs4C4xK0n85kgbHmJ5q2zmUH2SgjsYpfo+bAK6gUXib3P
        W9ggbGGJV8e3sEPYUhKf3+2FildLrDx5hA2iuYNRYsv+C6wQCWOJ/UsnM4EcxyygKbF+lz5E
        WFFi5++5UEfwSbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlI3pmF5IVZSF6Y
        hbBsASPLKkax1ILi3PTUYsMCI+TI3sQITtFaZjsYF53zOcQowMGoxMN7YbllrBBrYllxZe4h
        RgkOZiUR3q07gEK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5g/8kriDU2NjI2NLUwMzUwN
        DZXEeRf+sIgVEkhPLEnNTk0tSC2C6WPi4JRqYDzqYnWxqo6N5+p5yyOL3KxOtcseSOg8Pe+S
        yBuZlgfsUsuNPZZ+8p85R3ryvXA7ZnFL4fi29RYmb17dTRQ9NeFjcGBk5Hw55dJ41j+N0foe
        v191bVJVUT+1/1Tv5ZbEC4/NitfrnZi/vd7dQOf4yo6Vd/8Lst5UFp146POVnsehq7IEGm8x
        3VZiKc5INNRiLipOBADNjK8U5wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnO6yW1axBo/72C0OHdvKbvHsqLbF
        /CPnWC2ufH3PZjF97yY2i0n3J7BYnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe4
        3biCzWLG5JdsDnweO2fdZffYtKqTzePOtT1sHve7jzN5bF5S73Hw3R4mj74tqxg9Pm+SC+CI
        4rJJSc3JLEst0rdL4Mq4fl214LpRxfE/85kaGP8pdTFyckgImEh8mvmSrYuRi0NIYDejxOYp
        z9kgEpIS0y4eZe5i5ACyhSUOHy6GqHnLKPHoaBczSI2wQLjEy2VfwOpFBGwlds+exwJSxCyw
        mkXizIb/TBAdt5kkdp7eyApSxSagJbH/xQ2wDn4BRYmrPx4zgti8AnYS37b8ZATZxiKgKnF3
        mhdIWFQgQuLwjllQJYISJ2c+YQGxOQUCJY7tXAMWZxZQl/gz7xIzhC0ucevJfCYIW16ieets
        5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER6uW
        5g7Gy0viDzEKcDAq8fBqrLKMFWJNLCuuzD3EKMHBrCTCu3UHUIg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQZGXfmfuRI3Yq04JA6/nlawKrSIuf7cya+K
        4QX9TgqHZ6g2bDFrWhZ7JeGbeE/vbr3w6Rzv/0hyBOQrThM5tsexVz/XfX5K+mWd6oIJ5uVT
        Jz/v/uuW/J6p5XKpjYTws6f2S7WdG50+/HXtZQxI/iWu+UVK4r/N87iZXwWTqqfXHgpjWet4
        46MSS3FGoqEWc1FxIgC7Xjrq0gIAAA==
X-CMS-MailID: 20190726104910epcas1p2eeb9f55b4fc0bc7b4d4a1bc05358758b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
References: <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <20190723122016.30279-2-a.swigon@partner.samsung.com>
        <CAGTfZH0JE0PmiCHaT3vMrDaP0-8eZ3afyHy_zT9aFmMOGNTR8g@mail.gmail.com>
        <CAJKOXPe4nOjjuA2MXLP1n=dPa7o6egjLZScSBNhyi9agHqqM7A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 26. 오후 7:42, Krzysztof Kozlowski wrote:
> On Thu, 25 Jul 2019 at 14:44, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> 2019년 7월 24일 (수) 오전 8:09, Artur Świgoń <a.swigon@partner.samsung.com>님이 작성:
>>>
>>> This patch adds a new static function, exynos_bus_profile_init(), extracted
>>> from exynos_bus_probe().
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
>>>  1 file changed, 60 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index d9f377912c10..d8f1efaf2d49 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>         return ret;
>>>  }
>>>
>>> +static int exynos_bus_profile_init(struct exynos_bus *bus,
>>> +                                  struct devfreq_dev_profile *profile)
>>> +{
>>> +       struct device *dev = bus->dev;
>>> +       struct devfreq_simple_ondemand_data *ondemand_data;
>>> +       int ret;
>>> +
>>> +       /* Initialize the struct profile and governor data for parent device */
>>> +       profile->polling_ms = 50;
>>> +       profile->target = exynos_bus_target;
>>> +       profile->get_dev_status = exynos_bus_get_dev_status;
>>> +       profile->exit = exynos_bus_exit;
>>> +
>>> +       ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>> +       if (!ondemand_data) {
>>> +               ret = -ENOMEM;
>>> +               goto err;
>>> +       }
>>> +       ondemand_data->upthreshold = 40;
>>> +       ondemand_data->downdifferential = 5;
>>> +
>>> +       /* Add devfreq device to monitor and handle the exynos bus */
>>> +       bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> +                                               DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>> +                                               ondemand_data);
>>> +       if (IS_ERR(bus->devfreq)) {
>>> +               dev_err(dev, "failed to add devfreq device\n");
>>> +               ret = PTR_ERR(bus->devfreq);
>>> +               goto err;
>>> +       }
>>> +
>>> +       /* Register opp_notifier to catch the change of OPP  */
>>> +       ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "failed to register opp notifier\n");
>>> +               goto err;
>>> +       }
>>> +
>>> +       /*
>>> +        * Enable devfreq-event to get raw data which is used to determine
>>> +        * current bus load.
>>> +        */
>>> +       ret = exynos_bus_enable_edev(bus);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "failed to enable devfreq-event devices\n");
>>> +               goto err;
>>> +       }
>>> +
>>> +       ret = exynos_bus_set_event(bus);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> +               goto err;
>>> +       }
>>> +
>>> +err:
>>> +       return ret;
>>> +}
>>> +
>>>  static int exynos_bus_probe(struct platform_device *pdev)
>>>  {
>>>         struct device *dev = &pdev->dev;
>>>         struct device_node *np = dev->of_node, *node;
>>>         struct devfreq_dev_profile *profile;
>>> -       struct devfreq_simple_ondemand_data *ondemand_data;
>>>         struct devfreq_passive_data *passive_data;
>>>         struct devfreq *parent_devfreq;
>>>         struct exynos_bus *bus;
>>> @@ -418,52 +475,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>         if (ret < 0)
>>>                 goto err;
>>>
>>> -       /* Initialize the struct profile and governor data for parent device */
>>> -       profile->polling_ms = 50;
>>> -       profile->target = exynos_bus_target;
>>> -       profile->get_dev_status = exynos_bus_get_dev_status;
>>> -       profile->exit = exynos_bus_exit;
>>> -
>>> -       ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>> -       if (!ondemand_data) {
>>> -               ret = -ENOMEM;
>>> +       ret = exynos_bus_profile_init(bus, profile);
>>> +       if (ret < 0)
>>>                 goto err;
>>> -       }
>>> -       ondemand_data->upthreshold = 40;
>>> -       ondemand_data->downdifferential = 5;
>>> -
>>> -       /* Add devfreq device to monitor and handle the exynos bus */
>>> -       bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> -                                               DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>> -                                               ondemand_data);
>>> -       if (IS_ERR(bus->devfreq)) {
>>> -               dev_err(dev, "failed to add devfreq device\n");
>>> -               ret = PTR_ERR(bus->devfreq);
>>> -               goto err;
>>> -       }
>>> -
>>> -       /* Register opp_notifier to catch the change of OPP  */
>>> -       ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>>> -       if (ret < 0) {
>>> -               dev_err(dev, "failed to register opp notifier\n");
>>> -               goto err;
>>> -       }
>>> -
>>> -       /*
>>> -        * Enable devfreq-event to get raw data which is used to determine
>>> -        * current bus load.
>>> -        */
>>> -       ret = exynos_bus_enable_edev(bus);
>>> -       if (ret < 0) {
>>> -               dev_err(dev, "failed to enable devfreq-event devices\n");
>>> -               goto err;
>>> -       }
>>> -
>>> -       ret = exynos_bus_set_event(bus);
>>> -       if (ret < 0) {
>>> -               dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> -               goto err;
>>> -       }
>>>
>>>         goto out;
>>>  passive:
>>> --
>>> 2.17.1
>>>
>>
>> NACK.
>>
>> It has not any benefit and I don't understand reason why it is necessary.
>> I don't agree. Please drop it.
> 
> The probe has 12 local variables and around 140 lines of code (so much
> more than coding style recommendations). Therefore splitting some
> logical part out of probe to make code better organized and more
> readable is pretty obvious benefit.

After checked the patch3, I changed my opinion. It seems more simple than before
and I replied on patch3. But, I think that can merge patch1/2/2 to one patch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
