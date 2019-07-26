Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C976407
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGZLBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 07:01:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:18348 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfGZLBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 07:01:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190726110106epoutp040e91695dc3ed208fc7d571087d30e241~08AMhRWdU2763727637epoutp04M
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 11:01:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190726110106epoutp040e91695dc3ed208fc7d571087d30e241~08AMhRWdU2763727637epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564138866;
        bh=kcE3GR2TU8uayVxoqH3p+KC+NazB5aH2KDMPv6Ni+zs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oNLtgUtdcnkXLULaWkLiDNqQ0AMAAlQ5BgRp4OCeu9UkJdn7ZTyxuC1DID9DuippJ
         6yb2Df8fMVSqa5CsNKYdHFEKmWM2dZN6BQB/byRCofuMUJIXNipVCdd0H8zQ25tcQz
         sKPyRHoYcl1TvKeWhuUSjPCctwwoUVCPTw+0SIAw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190726110106epcas1p4515c63070edf78d9f02390f05d2b934e~08AL_ZNwC3048430484epcas1p4J;
        Fri, 26 Jul 2019 11:01:06 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45w5jX128mzMqYkY; Fri, 26 Jul
        2019 11:01:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.00.04085.07DDA3D5; Fri, 26 Jul 2019 20:01:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726110103epcas1p10cc201a13c99ffa8497329d70b7d2520~08AJeN-kU2936629366epcas1p1w;
        Fri, 26 Jul 2019 11:01:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190726110103epsmtrp11fc4f1aea89fcff8fce9276745333a6e~08AJdWKQM0394803948epsmtrp1y;
        Fri, 26 Jul 2019 11:01:03 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-02-5d3add70e81b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.FA.03706.F6DDA3D5; Fri, 26 Jul 2019 20:01:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190726110103epsmtip1e2a115c4e055c4b7f82188e52a79fd35~08AJNGAGj2769327693epsmtip1K;
        Fri, 26 Jul 2019 11:01:03 +0000 (GMT)
Subject: Re: [RFC PATCH 04/11] devfreq: exynos-bus: Clean up code
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
Message-ID: <2871b90b-f8e6-13c0-0e0b-66ce70e3ec86@samsung.com>
Date:   Fri, 26 Jul 2019 20:04:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfsD0XFs2hM64Kf0eG2G+xhWef3QZKjk9NU2ECzgQeqsA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmrm7BXatYg+nP2SwOHdvKbvHsqLbF
        /CPnWC2ufH3PZjF97yY2i0n3J7BYnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe4
        3biCzWLG5JdsDnweO2fdZffYtKqTzePOtT1sHve7jzN5bF5S73Hw3R4mj74tqxg9Pm+SC+CI
        yrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpbSaEs
        MacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd
        8WzlOZaChY4V1w+vYmtg3KzbxcjBISFgIrFiqn8XIxeHkMAORokJU1rYIJxPjBLHJjxnhHC+
        MUrc694L5HCCdUz+1MUKkdjLKLF5fzcThPOeUeL9jd3sIFXCAo4S17tOgdkiArYSu2fPYwEp
        YhZYySKxruMd2Cg2AS2J/S9usIHY/AKKEld/PAaL8wrYSVz7u5EVxGYRUJWYvmgxmC0qECHx
        6cFhVogaQYmTM5+wgNicAoES7+5vAbOZBcQlbj2ZzwRhy0s0b53NDLJYQmAXu8TsfS+YIH5w
        kTh+/hgLhC0s8er4FnYIW0riZX8blF0tsfLkETaI5g5GiS37L7BCJIwl9i+dzAQKPmYBTYn1
        u/QhwooSO3/PZYRYzCfx7msPKySEeSU62oQgSpQlLj+4C3WCpMTi9k62CYxKs5C8MwvJC7OQ
        vDALYdkCRpZVjGKpBcW56anFhgWmyNG9iRGcprUsdzAeO+dziFGAg1GJh/fCcstYIdbEsuLK
        3EOMEhzMSiK8W3cAhXhTEiurUovy44tKc1KLDzGaAkN7IrOUaHI+MIfklcQbmhoZGxtbmBia
        mRoaKonzLvxhESskkJ5YkpqdmlqQWgTTx8TBKdXAeJJxE7PG4WjL3G1vfq7z77u/aFuVqm37
        T5/lCS0Xz6eKv8ibba3BcV3/yO+0Y7XHUxrj361T2Hups3bJ8WVnv+8p05sjkcbblXhh0s3w
        2oMKKod9mT6/EDJm2McYGN2YtfpR1gPtLbJltwoOLRWcdfQg++bAlQeZXl1XuxPdv+SQ1pv1
        c87OX6HEUpyRaKjFXFScCADcYXDr6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnG7+XatYgyXnZCwOHdvKbvHsqLbF
        /CPnWC2ufH3PZjF97yY2i0n3J7BYnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbe4
        3biCzWLG5JdsDnweO2fdZffYtKqTzePOtT1sHve7jzN5bF5S73Hw3R4mj74tqxg9Pm+SC+CI
        4rJJSc3JLEst0rdL4Mp4tvIcS8FCx4rrh1exNTBu1u1i5OSQEDCRmPypi7WLkYtDSGA3o8TK
        E59YIBKSEtMuHmXuYuQAsoUlDh8uhqh5yyjxdcM9dpAaYQFHietdp8BsEQFbid2z57GAFDEL
        rGaROLPhPxNEx20mib7jU5hBqtgEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk7j2dyMriM0ioCox
        fdFiMFtUIELi8I5ZUDWCEidnPgG7jlMgUOLd/S1gNrOAusSfeZeYIWxxiVtP5jNB2PISzVtn
        M09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOGK1
        NHcwXl4Sf4hRgINRiYdXY5VlrBBrYllxZe4hRgkOZiUR3q07gEK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwrvSz4W9O8XhVusyYWaDk8IUp7C8CT9Tu
        kfN+Ov2w7JO965feLP7CITVhnkOkmux+yWItJfcVT6oOvJwoUlgYvrb39d76iNRjvJHX49tf
        ZR+p9Nv/4tsCF5WNnqejzrVyHtsWyHP3cTjvHxEZp1nx93iLqngOlvd7B0izP13aULdze5uW
        nvZWJZbijERDLeai4kQANKPnUdQCAAA=
X-CMS-MailID: 20190726110103epcas1p10cc201a13c99ffa8497329d70b7d2520
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22
References: <CGME20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22@eucas1p2.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <20190723122016.30279-5-a.swigon@partner.samsung.com>
        <CAGTfZH3Z334D3OKpBOGSfS9RoHkOX-s_2M858z1Ye2NoMtVh4g@mail.gmail.com>
        <CAJKOXPfsD0XFs2hM64Kf0eG2G+xhWef3QZKjk9NU2ECzgQeqsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 26. 오후 7:45, Krzysztof Kozlowski wrote:
> On Thu, 25 Jul 2019 at 14:51, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> 2019년 7월 24일 (수) 오전 8:07, Artur Świgoń <a.swigon@partner.samsung.com>님이 작성:
>>>
>>> This patch adds minor improvements to the exynos-bus driver.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 49 ++++++++++++++++--------------------
>>>  1 file changed, 22 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 4bb83b945bf7..412511ca7703 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -15,11 +15,10 @@
>>>  #include <linux/device.h>
>>>  #include <linux/export.h>
>>>  #include <linux/module.h>
>>> -#include <linux/of_device.h>
>>> +#include <linux/of.h>
>>>  #include <linux/pm_opp.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/regulator/consumer.h>
>>> -#include <linux/slab.h>
>>>
>>>  #define DEFAULT_SATURATION_RATIO       40
>>>  #define DEFAULT_VOLTAGE_TOLERANCE      2
>>> @@ -256,7 +255,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>                                         struct exynos_bus *bus)
>>>  {
>>>         struct device *dev = bus->dev;
>>> -       int i, ret, count, size;
>>> +       int i, ret, count;
>>>
>>>         /* Get the regulator to provide each bus with the power */
>>>         bus->regulator = devm_regulator_get(dev, "vdd");
>>> @@ -283,8 +282,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>         }
>>>         bus->edev_count = count;
>>>
>>> -       size = sizeof(*bus->edev) * count;
>>> -       bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>> +       bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);
>>>         if (!bus->edev) {
>>>                 ret = -ENOMEM;
>>>                 goto err_regulator;
>>> @@ -388,7 +386,7 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>         ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>>         if (!ondemand_data) {
>>>                 ret = -ENOMEM;
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>         ondemand_data->upthreshold = 40;
>>>         ondemand_data->downdifferential = 5;
>>> @@ -400,14 +398,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>         if (IS_ERR(bus->devfreq)) {
>>>                 dev_err(dev, "failed to add devfreq device\n");
>>>                 ret = PTR_ERR(bus->devfreq);
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>>         /* Register opp_notifier to catch the change of OPP  */
>>>         ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>>>         if (ret < 0) {
>>>                 dev_err(dev, "failed to register opp notifier\n");
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>>         /*
>>> @@ -417,16 +415,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>         ret = exynos_bus_enable_edev(bus);
>>>         if (ret < 0) {
>>>                 dev_err(dev, "failed to enable devfreq-event devices\n");
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>>         ret = exynos_bus_set_event(bus);
>>>         if (ret < 0) {
>>>                 dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>> -err:
>>> +out:
>>>         return ret;
>>>  }
>>>
>>> @@ -446,27 +444,28 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>         parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>>>         if (IS_ERR(parent_devfreq)) {
>>>                 ret = -EPROBE_DEFER;
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>>         passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
>>>         if (!passive_data) {
>>>                 ret = -ENOMEM;
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>         passive_data->parent = parent_devfreq;
>>>
>>>         /* Add devfreq device for exynos bus with passive governor */
>>> -       bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
>>> +       bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> +                                               DEVFREQ_GOV_PASSIVE,
>>>                                                 passive_data);
>>>         if (IS_ERR(bus->devfreq)) {
>>>                 dev_err(dev,
>>>                         "failed to add devfreq dev with passive governor\n");
>>>                 ret = PTR_ERR(bus->devfreq);
>>> -               goto err;
>>> +               goto out;
>>>         }
>>>
>>> -err:
>>> +out:
>>>         return ret;
>>>  }
>>>
>>> @@ -484,11 +483,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>                 return -EINVAL;
>>>         }
>>>
>>> -       bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>> +       bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
>>>         if (!bus)
>>>                 return -ENOMEM;
>>>         mutex_init(&bus->lock);
>>> -       bus->dev = &pdev->dev;
>>> +       bus->dev = dev;
>>>         platform_set_drvdata(pdev, bus);
>>>
>>>         /* Parse the device-tree to get the resource information */
>>> @@ -502,7 +501,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>                 goto err;
>>>         }
>>>
>>> -       node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>> +       node = of_parse_phandle(np, "devfreq", 0);
>>>         if (node) {
>>>                 of_node_put(node);
>>>                 ret = exynos_bus_profile_init_passive(bus, profile);
>>> @@ -547,12 +546,10 @@ static int exynos_bus_resume(struct device *dev)
>>>         int ret;
>>>
>>>         ret = exynos_bus_enable_edev(bus);
>>> -       if (ret < 0) {
>>> +       if (ret < 0)
>>>                 dev_err(dev, "failed to enable the devfreq-event devices\n");
>>> -               return ret;
>>> -       }
>>>
>>> -       return 0;
>>> +       return ret;
>>>  }
>>>
>>>  static int exynos_bus_suspend(struct device *dev)
>>> @@ -561,12 +558,10 @@ static int exynos_bus_suspend(struct device *dev)
>>>         int ret;
>>>
>>
>> NACK.
> 
> Instead of simple nack you should explain what is wrong with proposed
> approach. The existing code could be improved and this patch clearly
> improves the readability. "err" label is confusing if it is used for
> correct exit path. The last "if() return" block is subjective - but
> then explain exactly why you prefer one over another. No just "nack"
> for peoples contributions.

OK. Sorry for my lack comment.

Actually, I prefer 'err' instead of 'out' because jump to 'err'
statement point when failed to call some functions. In my case,
'err' is proper without any problem.


> 
>>>         ret = exynos_bus_disable_edev(bus);
>>> -       if (ret < 0) {
>>> +       if (ret < 0)
>>>                 dev_err(dev, "failed to disable the devfreq-event devices\n");
>>> -               return ret;
>>> -       }

When happen error by function call, I think that have to print
the error log, just return or jump some point like 'err'
for restoring the previous state.

But, in this case, even if happen the error, the exception handling
of exynos_bus_disable_edev() just prints the error log without return.

I knew that this it is possible because the exynos_bus_disable_edev(bus)
was called at the end of function. But, I want to keep the same style
for exception handling if there are no any critical benefits.

>>>
>>> -       return 0;
>>> +       return ret;
>>>  }
>>>  #endif
>>>
>>> --
>>> 2.17.1
>>>
>>
>> NACK.
>>
>> As I already commented, It has never any benefit.
>> I think that it is not usful. Please drop it.
> 
> The benefit for me is clear - makes the code easier to understand.
> 
> Best regards,
> Krzysztof
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
