Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3412AFD4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfL0ADQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 19:03:16 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:25213 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfL0ADQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 19:03:16 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191227000313epoutp02ffabffeaef4a3f566158b9823714b89e~kEXvbxdGs0200302003epoutp02O
        for <linux-pm@vger.kernel.org>; Fri, 27 Dec 2019 00:03:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191227000313epoutp02ffabffeaef4a3f566158b9823714b89e~kEXvbxdGs0200302003epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577404993;
        bh=WA59LNYJUt2fnjJ+DhnIp9dd0bE/LhrRH5GQ+S7fr+8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LujLXdySbgmVSnLvmbx0qEdxSXjnpK5LREJVtstvOlodTCHAdnWOfnKD8bje6BbPr
         D6a12SfNG2i+wSQDFuXaruUWnDr0rhY11C235N3cG6O+pf6ocVRqv1/z7b5N+Iyc0w
         ZZkGzlhZW5fd+7OPUZMFTiu47iaRSaaiUnMRoRm4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191227000312epcas1p4173878ecd8739fcbb83c0ade834d68fe~kEXu6yDgY2314223142epcas1p4K;
        Fri, 27 Dec 2019 00:03:12 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47kRqL0DZZzMqYkg; Fri, 27 Dec
        2019 00:03:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.D2.52419.D3A450E5; Fri, 27 Dec 2019 09:03:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191227000309epcas1p145ab877d7254a2e5e29c1a33b02dd583~kEXrrYIFK2734127341epcas1p1W;
        Fri, 27 Dec 2019 00:03:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191227000309epsmtrp14501116d06ad2fdf45a87ae9326beeaf~kEXrqBTRL0742607426epsmtrp1R;
        Fri, 27 Dec 2019 00:03:09 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-8b-5e054a3d28a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.41.10238.C3A450E5; Fri, 27 Dec 2019 09:03:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191227000308epsmtip2d2aa064d3f8397a927215c21eb2df2a5~kEXraFDV_2373323733epsmtip2Y;
        Fri, 27 Dec 2019 00:03:08 +0000 (GMT)
Subject: Re: [PATCH 4/9] PM / devfreq: exynos-bus: Replace deprecated
 'devfreq' property
To:     Rob Herring <robh@kernel.org>
Cc:     krzk@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a54e4275-012e-77d9-bdbe-1aab64b5c12b@samsung.com>
Date:   Fri, 27 Dec 2019 09:09:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191226210119.GA8706@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmrq6tF2ucQcMSG4v781oZLeYfOcdq
        8f/Ra1aL/sevmS3On9/AbnG26Q27xYq7H1ktNj2+xmpxedccNovPvUcYLT49+M9sMeP8PiaL
        hU0t7BZrj9xlt1h6/SKTxe3GFWwW//fsYHcQ9Fgzbw2jx6ZVnWwem5fUe2x8t4PJo2/LKkaP
        7dfmMXt83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/
        18rQwMDIFKgwITvj8fMXbAV/RSpWH/3B0sA4XbCLkZNDQsBEYuP9Y+wgtpDADkaJ0x99uhi5
        gOxPjBI7Vr9hhXC+MUrMOPIPyOEA6/i0yREivpdR4tXM34wQzntGidkfG9lARgkLRElsO7CI
        FcQWEVCU+N02DWwSs8AaZom2Kb9ZQBJsAloS+1/cAGvgByq6+uMxI4jNK2An8fbsBGYQm0VA
        VeLIkWdg9aICYRInt7VA1QhKnJz5BCzOCTTnxcqPYMuYBcQlbj2ZzwRhy0tsfzuHGWSxhMAx
        dokzE5uZIJ52kZh6+SiULSzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2L53M
        BAoLZgFNifW79CHCihI7f89lhFjMJ/Huaw80uHglOtqEIEqUJS4/uAu1VlJicXsn2wRGpVlI
        3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCY+TY3sQITt1a5jsYN5zzOcQowMGoxMPbsYsl
        Tog1say4MvcQowQHs5II7+oixjgh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA/MK3kl8Yam
        RsbGxhYmhmamhoZK4rwcPy7GCgmkJ5akZqemFqQWwfQxcXBKNTB26X883hietu9N98/8E4fc
        wqRVJ0coJCxLXtK6eLrp24KzflmPPZM/X4xSm3NQ6In2al/Bkm+7835WSdQWfeCcsGrKnM+e
        018y5PR0ZcXsd9ISuPbeg0PjEot6xNH6pMKEK7vbYwtkuf68+7lb7f/Ch9tetLiVz2e1XGgw
        sf+qnOPRRQvuXjVUYinOSDTUYi4qTgQAq4eALvMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvK6tF2ucwdIgi/vzWhkt5h85x2rx
        /9FrVov+x6+ZLc6f38BucbbpDbvFirsfWS02Pb7GanF51xw2i8+9RxgtPj34z2wx4/w+JouF
        TS3sFmuP3GW3WHr9IpPF7cYVbBb/9+xgdxD0WDNvDaPHplWdbB6bl9R7bHy3g8mjb8sqRo/t
        1+Yxe3zeJBfAHsVlk5Kak1mWWqRvl8CV8fj5C7aCvyIVq4/+YGlgnC7YxcjBISFgIvFpk2MX
        IxeHkMBuRomdFxezdTFyAsUlJaZdPMoMUSMscfhwMUTNW0aJ7R8fgtUIC0RJbDuwiBXEFhFQ
        lPjdNo0VpIhZYA2zxPmebhaIjruMEvt2NTGCVLEJaEnsf3EDrJsfqOPqj8dgcV4BO4m3Zycw
        g9gsAqoSR448YwGxRQXCJHYuecwEUSMocXLmE7A4J9CcFys/gm1mFlCX+DPvEjOELS5x68l8
        JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiOYS3NHYyXl8QfYhTgYFTi4e3YxRInxJpYVlyZe4hRgoNZSYR3dRFjnBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MTirzBWe0Xu0+nLptsdTs
        Qm2R/PmtLFvbtWQeWgp3hQZnGHKcWx+yj8X37o9JHbd0twWIsTetFbt/fJnz7L8WQYyWfsaL
        RA3a0nL8Zpzl704O/TFRYrqBQvF82fBN/bOfH5XkY9ko5yYcVLpn0wuF/Wb99YqVYWEfXaRC
        /at45d7G3vqp8FeJpTgj0VCLuag4EQA70uBv3QIAAA==
X-CMS-MailID: 20191227000309epcas1p145ab877d7254a2e5e29c1a33b02dd583
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9@epcas1p1.samsung.com>
        <20191217055738.28445-5-cw00.choi@samsung.com> <20191226210119.GA8706@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/27/19 6:01 AM, Rob Herring wrote:
> On Tue, Dec 17, 2019 at 02:57:33PM +0900, Chanwoo Choi wrote:
>> In order to remove the deprecated 'devfreq' property, replace with
>> new 'exynos,parent-bus' property in order to get the parent devfreq device
>> in devicetree file instead of 'devfreq' property. But, to guarantee the
>> backward-compatibility, keep the support 'devfreq' property.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../bindings/devfreq/exynos-bus.txt           | 16 +++++++--------
>>  drivers/devfreq/exynos-bus.c                  | 20 ++++++++++++-------
>>  2 files changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index e71f752cc18f..c948cee01124 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -45,7 +45,7 @@ Required properties only for parent bus device:
>>    of buses.
>>  
>>  Required properties only for passive bus device:
>> -- devfreq: the parent bus device.
>> +- exynos,parent-bus: the parent bus device.
> 
> If you are going to do something new, why not use the interconnect 
> binding here?

As I knew, interconnect make the data path among multiple nodes
and set the average and peak bandwidth to the specific data path.

It means that some data will be flowed from node_a to node_d
or the reverse way because each node has the tightly coupled
dependency for data flow.

	node_a <-> node_b <-> node_c <-> node_d


On the other hand, exynos-bus.c driver is not related to 'data path'.
Each bus just need to control the their own frequency and voltage.
But, share the power line (regulator) between exynos-bus device
even if there are no any dependency of data flow.

'exynos,parent-bus' property just indicate the specific
devfreq device(parent bus device) which controls
the shared power line(regulator) in order to prevent
the h/w problem due to the wrong pair of frequency and voltage.

'exynos,parent-bus' property is only used to catch
the change timing of shared power line.


And,
as you commented, there are some data path among the exynos-bus
devices for the display h/w as following:

	bus_display -> bus_leftbus -> bus_dmc

In order to make the data path between bus devices,
interconnect binding is required. This approach[1] was posted.
[1] https://patchwork.kernel.org/cover/11305265/
- [RFC,v3,0/7] PM / devfreq: Simple QoS for exynos-bus using interconnect

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
