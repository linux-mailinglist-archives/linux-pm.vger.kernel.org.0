Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33EC524D4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfFYHby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 03:31:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35563 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfFYHbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 03:31:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190625073151euoutp01a2b90b27169181f644916c2eb61c4a62~rYJo7PWmc0433704337euoutp01a
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 07:31:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190625073151euoutp01a2b90b27169181f644916c2eb61c4a62~rYJo7PWmc0433704337euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561447911;
        bh=5sQ/QgoEhcfzsA95yFN4M7LlrW1v1YWERTGiizKMusA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ig1a/J/kiQ+Cl+AZzq0jsAtt9rOZ7Tp+0ehwE/Axpi9XwW99aFEjjBLTJ2/kFQKHY
         DLv4Ft/8ZuY9zSCV18Slx6vFl7Y3eIq6UK9/oaMnXeE+AeZbNWkseudyQlB/AfZa/N
         +Ehu5DLeCLy6IfNjIUxWMzNhrjyT8mj8SosOzU/g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190625073150eucas1p1804a7b12c5740935757ccbaa71dee43e~rYJn4KCUr1172011720eucas1p1F;
        Tue, 25 Jun 2019 07:31:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.FB.04325.5EDC11D5; Tue, 25
        Jun 2019 08:31:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190625073149eucas1p102dafce3c10e357cba18b64de8058ef9~rYJnDIWly0556905569eucas1p12;
        Tue, 25 Jun 2019 07:31:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190625073149eusmtrp1c21b2f6b29117d29964abef090d964a7~rYJm0oKWL0495604956eusmtrp1M;
        Tue, 25 Jun 2019 07:31:49 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-15-5d11cde5c6c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.B4.04146.4EDC11D5; Tue, 25
        Jun 2019 08:31:48 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190625073148eusmtip2a4fa4a3d5df3009c558e893be5645d45~rYJl48Fxw0621806218eusmtip2O;
        Tue, 25 Jun 2019 07:31:48 +0000 (GMT)
Subject: Re: [PATCH v10 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
To:     cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, keescook@chromium.org,
        Tony Lindgren <tony@atomide.com>, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <2e1be1d3-b6ae-e40d-48cd-6b6adb26860d@partner.samsung.com>
Date:   Tue, 25 Jun 2019 09:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH35X0zE2LhGWJJp2xZNNk1ew7zNMoMqL+eZ5rcBFcPvew@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMYRjGfXuuu2xOi/YdDDOLGZdRGQ3fDGOYCWcYl5oxYxCOnCm0K3sq
        l/yxRJEtJre1STW5zbosaUOZsC2ldHNt0tLYdatIU5hcwnbW6L/f+7zP973v883HEhozPZzd
        YEgQjQYhTkeryOL7PbWT39QERoU6vGH4qsVO4efd7yj89t4knOuqpfCFTg/CKQV2Gh+uylHg
        hwf0+KCnjcB1dVcYXLO7ncGd5pcUflxyksZdGS6ELXVlCnzJ5WZwQ9Vc/GLXeRqXt6dRuPfZ
        VRLffrIAv/gRgL9WvkaztfzXL1kk39G4l+GzTQ0kf9PqZvhC236av51zkeEzUj7RfGaRDfHX
        qpP5rsJRS1UrVDPXi3EbkkRjyKy1qlh3ayaK/6HcVvDoO2lCP5l0pGSBC4N8z10qHalYDXce
        gTunk5GLbgRnP5ciuehCUF92AP078r7F4XedQ3DS2kzKxUcEvU437XMN4ZZBk6Ogj4dyQXD9
        mLfvKoIrpWF3x2kiHbEszQXDDdsWn0fNzYPO2qa+CSQ3DlpMTYSPh3HLoftmIZI9gfDghJf0
        sZKLgAv5HsrHBKeFJm+uQubRkOLIJuRNXSy8fErLHA6ZHos/wRBorSjyP8BIqD5sJmWWwJSR
        7/fsBM/BHL9nBpRXNFC+lQluAthLQmR5Dpy6803hk4ELgMaPgfIGAZBVfJyQZTXsS9XI7vFQ
        ZK5XyBwE5y4eYw4hnbVfLmu/LNZ+Waz/5+Yh0oa0YqKkjxGlqQZxa7Ak6KVEQ0xw9GZ9Ifr7
        R6t7K77cQGU/1zkRxyLdIHWei4vSUEKStF3vRMASuqHqM8JfSb1e2L5DNG5eY0yMEyUnGsGS
        Oq06eUDLSg0XIySIm0QxXjT+6ypY5XATWnw86W34He0S5cbysOXFySVp0WXueYN7zHuDw5cI
        zwfOjnO3La6Gcc6ey4siRrR5Ndq7C8eEP4gOaTUYR+alpmZ/ykr4EDtr66tBGysDY22WeLK0
        +deeW2Pnd1fpGh2EZfqZ0G/tJV2RV/bYpl2rP2KO+m2MvBymsR8dsyo+crWYZteRUqwwZSJh
        lIQ/mlQ/0p8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuO4qLs6n54ocuAz90Wx2v78xEPxQn6YoU4YVceryQc7oz
        RYtgJalpahfpMjMNkWKrvGV5SSWdmne0MNlSTEeGWmFqVJq0uQK//Xie/w+eB/4UJnlIuFMJ
        SRpOnaRIlJKOeO9q1/huS784cm9T8z5UfbeSQO8Xpwn0qWMnKjUOEMgwPwVQZnkliW71lAhQ
        X54SFU7NYmhwsEqI+i/PCdH8tXECvW28T6KFfCNAdwdbBOipcUyIhnoOIPOlxyRqn8sm0OpI
        NY5a34Ug8/JG9OPNJAhyY38s3cTZb6NXhGyxdghnG3RjQrZGf5VkW0ueCNn8zK8kW/BcD9ja
        3gvsQs3m445hsgC1KlXDbY1X8Zr90nAGecoYOZJ5estljJdfpL+nj3RPYEAMl5iQxqn3BEbJ
        4sdmCkDyskN6+fBvXAtWhLnAgYK0N/w8UWdlR0pCVwBo/jBD2Beb4M2Wl/9CznBlJJe0h2YB
        vD06QtoWzvRJaKorX2MXq/DytgXYQhjdTkLdsyKB3bghgK8+rWK5gKJIWgbr9Sk2QUQfhPMD
        JmBjnPaAE1oTZmNX+jQsbtTi9owYdt+zrLEDfQIaHk6tXYfRvvBB7UfMzm7QZCkV2HkLzKwr
        xq4DiW6drlun6NYpunVKGcD1wIVL5ZVxSp6R8Qoln5oUJ4tWKWuAtR4vOn/V1oPh6tA2QFNA
        6iQqM9KREkKRxmco2wCkMKmLqEJhHYliFBnnObXqjDo1kePbgI/1uRuYu2u0ylq2JM0Zxofx
        Q3LGz8vPyxdJ3UQ59OsICR2n0HDnOC6ZU//3BJSDuxYE1q82RFQsjWcevdgsNxzuiqKrzdPs
        qGXkjhP+KzHWBFLkfzo624zb3ILCartemMOg06OfppzkKnFlXn2+KGI2xOOYMPfIk130zuCr
        viC9x3/R8UC2wb37VJbH2YamyaLvG3zv6UPrRIV92tBwZpzYHjyd98WY1X+oPFYc7GmQ4ny8
        gtmBqXnFX1VUj/40AwAA
X-CMS-MailID: 20190625073149eucas1p102dafce3c10e357cba18b64de8058ef9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
References: <CGME20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50@eucas1p2.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-10-l.luba@partner.samsung.com>
        <CAGTfZH35X0zE2LhGWJJp2xZNNk1ew7zNMoMqL+eZ5rcBFcPvew@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/22/19 3:10 PM, Chanwoo Choi wrote:
> Hi,
> 
> 2019년 6월 14일 (금) 오후 6:54, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>
>> Define new performance events supported by Exynos5422 SoC counters.
>> The counters are built-in in Dynamic Memory Controller and provide
>> information regarding memory utilization.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index c2ea94957501..ce658c262c27 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
>>          PPMU_EVENT(d1-cpu),
>>          PPMU_EVENT(d1-general),
>>          PPMU_EVENT(d1-rt),
>> +
>> +       /* For Exynos5422 SoC */
>> +       PPMU_EVENT(dmc0_0),
>> +       PPMU_EVENT(dmc0_1),
>> +       PPMU_EVENT(dmc1_0),
>> +       PPMU_EVENT(dmc1_1),
>>   };
>>
>>   static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
>> --
>> 2.17.1
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
Thank you Chanwoo.

Regards,
Lukasz
