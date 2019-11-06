Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB5F0B93
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 02:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfKFBS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 20:18:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60785 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbfKFBS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 20:18:58 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191106011854epoutp0245529fd6914a98a0cb7e6f5a775cef4d~UbgRHAPpl2900829008epoutp02u
        for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2019 01:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191106011854epoutp0245529fd6914a98a0cb7e6f5a775cef4d~UbgRHAPpl2900829008epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573003134;
        bh=Mg/rO753XoqV3dKay771cjTtycmgelBnUyToWlFSJ5U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L9fOdSwQSShiNmL1usxOJpk9e/UMPIgIpbPaTzwhWPpTRJHK7yfXLrFosKNg4oqNY
         jgW8068VHrA7bz00WJY1vXN29T4tfSUky68mUB2KB2IX49N2gPpRki5oKmmxTQON3g
         qx+2T+vsAXKjZ3eOhfWaOzbGgviTfbdX+DMiI4u4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191106011853epcas1p1f307a7852b35e66ce64d0078169d4601~UbgQnNFWN3050330503epcas1p1Z;
        Wed,  6 Nov 2019 01:18:53 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4777wC0ns9zMqYks; Wed,  6 Nov
        2019 01:18:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.8A.04135.A7F12CD5; Wed,  6 Nov 2019 10:18:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191106011850epcas1p2e2ec003e74806182e3a6de388c428f8b~UbgNbxgRH2435324353epcas1p2e;
        Wed,  6 Nov 2019 01:18:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191106011850epsmtrp1d31daaea95e79fe54665e648c7eb5f9e~UbgNa4vSu2631826318epsmtrp14;
        Wed,  6 Nov 2019 01:18:50 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-d2-5dc21f7a138f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.B4.25663.A7F12CD5; Wed,  6 Nov 2019 10:18:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191106011850epsmtip2010e732213c05f0fa2fc8e68a0e3afcd~UbgNKrt3f2969729697epsmtip2H;
        Wed,  6 Nov 2019 01:18:50 +0000 (GMT)
Subject: Re: [PATCH v9 19/19] PM / devfreq: tegra20/30: Add Dmitry as a
 maintainer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <da10a370-de1d-67c9-a916-cdc1a31c0a96@samsung.com>
Date:   Wed, 6 Nov 2019 10:24:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9bd7bfc0-508f-e7fb-d985-d32f2d9a88d8@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTURT1tWVakOqzgFxIhDpqAkSgAxZHQ40LMU3wA5dEJRIcy1iQbnZa
        xeUDBVEI4K6hAiqKSw0hQTTQCITSRMAlRjRBETWCC0RBRZAlGtuORv7Ou/ece++57z2JUHaP
        CJVkGSys2cDoSMJPdLctMjZ6f7gzTdGSq6JvfetDdL6tSkQ/OvxZTHc5ygl6pMSF6MIfNoIe
        +9iJ6J5DNwj60YdkesJRKaJLa54SK2eqG3qvInWjrVesLskbItS2gmZCXVpvR+qRurAUIjU7
        MZNlMliznDVojBlZBq2KTN6YviZdmaCgoqll9FJSbmD0rIpMWpcSvTZL5x6PlO9hdFZ3KIXh
        ODJ2RaLZaLWw8kwjZ1GRrClDZ1pmiuEYPWc1aGM0Rv1ySqGIU7qJ27MzL/e2i02dOGfkSjPK
        RQPSIuQrAbwEzl/7TRQhP4kMNyBw5dsRf/iOIHeiXORhyfAYghd5miIk8SomGxbznCYEHzs+
        CPjDMIJW5zDhEQTgTfDz4TcfTyIQ9wugyZXvrSTEW6Gt8ZbAgwkcBS2fur2C2Xg+PB/vQx4s
        xSug+na7F4vwQrBPHhF5OgfhLfBglOEpc6CjrN9b0heroPzMqb/lg+Fl/0UBj8Mh784FoWcG
        wMfFUOV6JuQ9J8HA+1HE4wAYvF8v5nEoDBwv+IsPwM0OF8GLjyGob3niwyfioaX6tMAzkBBH
        Qq0jlg/Ph8apCsQ3ngVDo8U+/LakcKxAxlMWQNfbXgGPQ+DK0ULiBCJt0+zYplmwTbNg+9/s
        EhLZ0VzWxOm1LEeZ4qZfdh3yvtyohAZU9XidE2EJIv2lM/a2psl8mD3cPr0TgURIBkq3lbpD
        0gxm337WbEw3W3Us50RK97JPCkODNEb3PzBY0illXHx8PL2ESlBSFBksXXW9Ok2GtYyFzWZZ
        E2v+pxNIfENzUfjlu78Gq7co5XL/X9fgqMP/k+n704B55hl+r2vH0joOjC8oPihT54Q0aexK
        zTZtxJuAL0s3JJ/d/GzH10VjildxXMShmpuaqTJ69YYk+nbz0M7htu5dkSFczskHB7sHSx3r
        e/ITd9/xfUd0VVSG6c7NWx7OBc+yE+MRmr2ByqRUKyniMhkqSmjmmD8T+jPYzwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvG6V/KFYg8375SxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i2/PTzFa3G5cwWZx9pm3xc9d81gs+tZeYnPg9thxdwmj
        x85Zd9k9epvfsXnMatvH5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZC++eYC84JVDxefE+
        xgbGl7xdjBwcEgImEr926HQxcnEICexmlPgx/x1LFyMnUFxSYtrFo8wQNcIShw8XQ9S8ZZR4
        tPArG0iNsECIxPczH1lBEiICz5gkFu7dyQSSYBaIlOiZu4UNomMek8SmpW1gHWwCWhL7X9wA
        s/kFFCWu/njMCGLzCthJLN18AsxmEVCRWPWrFewKUYEIiefbb0DVCEqcnPkELM4pYCsxZ8ok
        Fohl6hJ/5l1ihrDFJW49mQ91hLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIjj8trR2MJ07EH2IU4GBU4uFlKD8YK8SaWFZcmXuIUYKD
        WUmEN6YPKMSbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoGx
        f312q6gTb9Tqa23fE4ONJ+pYicoz8W/9+3+fktKdCVxlivO/ebr0Lv6b4GX2I9P9bNLvcPWq
        sIkvp93cdNL764ejblozlGOkrn2e9a30uvIs5pqqpsvv/laa7G5l/LZVNYR3klzbu9tHklP4
        wuumLDRk7+KoNZ4et0RbZ/LfdV9mZS36GbZLiaU4I9FQi7moOBEAypfcHbsCAAA=
X-CMS-MailID: 20191106011850epcas1p2e2ec003e74806182e3a6de388c428f8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191104221855epcas4p3761ca7e09ffa66b686be8b5a840ea383
References: <20191104215617.25544-1-digetx@gmail.com>
        <CGME20191104221855epcas4p3761ca7e09ffa66b686be8b5a840ea383@epcas4p3.samsung.com>
        <20191104215617.25544-20-digetx@gmail.com>
        <0e7db72b-37ff-a36e-11fe-727ed43c26a6@samsung.com>
        <9bd7bfc0-508f-e7fb-d985-d32f2d9a88d8@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 11. 5. 오후 10:29, Dmitry Osipenko wrote:
> 05.11.2019 07:07, Chanwoo Choi пишет:
>> On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
>>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>>> want to help keep them working and evolving in the future.
>>>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  MAINTAINERS | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 9f69d01da3a6..4b9679988514 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
>>>  F:	mm/memblock.c
>>>  F:	Documentation/core-api/boot-time-mm.rst
>>>  
>>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>>> +M:	Dmitry Osipenko <digetx@gmail.com>
>>> +L:	linux-pm@vger.kernel.org
>>> +L:	linux-tegra@vger.kernel.org
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git

From now, I'll help and review the devfreq patches as maintainer
and the devfreq git information is changed[1]. You should change 
the git info as following:
[1] https://lkml.org/lkml/2019/11/5/39

+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git

Also, I add my acked-by tag.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

>>> +S:	Maintained
>>> +F:	drivers/devfreq/tegra20-devfreq.c
>>> +F:	drivers/devfreq/tegra30-devfreq.c
>>> +
>>>  MEMORY MANAGEMENT
>>>  L:	linux-mm@kvack.org
>>>  W:	https://protect2.fireeye.com/url?k=9d0ba644-c09508de-9d0a2d0b-0cc47a336fae-300ed90f1ba3077c&u=http://www.linux-mm.org/
>>>
>>
>> Looks good to me. 
>>
>> But, the merge conflict might be occurred.
>> After getting the review from Myungjoo,
>> you better to send this patch separately
>> based on the latest MAINTAINERS file.
>>
>> Thanks for your all efforts.
> 
> Okay, I'll wait for the rest of patches to land and then re-send this
> patch separately. Thank you very much for the reviews.
> 
> 
-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
