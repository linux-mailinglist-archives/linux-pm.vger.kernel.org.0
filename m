Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958292681FE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgINADj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 20:03:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24055 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgINADh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 20:03:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200914000332epoutp0305398ba1fd4133c013f7bd5666ce42d5~0fY0eLvsz1482414824epoutp03J
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 00:03:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200914000332epoutp0305398ba1fd4133c013f7bd5666ce42d5~0fY0eLvsz1482414824epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600041812;
        bh=qDu6UuoR1j78Y94GV7MM4oVV/smj/mjEvM/pJIQx1oE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aB8mtERBFvIWaAxq37bCavViN32BY1yON4WF1OMUuZ7nF7pYGA4SZu9MTtDDuVaJP
         Tpbzd3AU0i0pIUY2qZCaEf15mE8zIoNV0ppQW8IpPjeE052umRKu0NsP0wjQ/QpilR
         pWAnrsHc68J7HLH40eyw6JEtflWDILkLsrM4/jNU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200914000332epcas1p428a2a2a7d94877e6f217dc3f416021ee~0fYz6368S3186631866epcas1p4V;
        Mon, 14 Sep 2020 00:03:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BqRQm6gLXzMqYkv; Mon, 14 Sep
        2020 00:03:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.B7.20696.F43BE5F5; Mon, 14 Sep 2020 09:03:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200914000327epcas1p4d83c4cf93f3661c3c8787b2261b8a526~0fYvu_SCq2542825428epcas1p4C;
        Mon, 14 Sep 2020 00:03:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914000327epsmtrp1441c3c23f39c7c8b32249cebf4c06ee5~0fYvuICRQ0656106561epsmtrp1F;
        Mon, 14 Sep 2020 00:03:27 +0000 (GMT)
X-AuditID: b6c32a39-eebff700000050d8-2d-5f5eb34f79d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.A2.08382.F43BE5F5; Mon, 14 Sep 2020 09:03:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200914000327epsmtip2cfb48a96f91d45f9133e1a880291f55d~0fYvfkwot2499624996epsmtip2T;
        Mon, 14 Sep 2020 00:03:27 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] PM / devfreq: event: Change prototype of
 devfreq_event_get_edev_by_phandle function
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6ed7a604-d10d-c2e1-34cf-d22b6fa083f8@samsung.com>
Date:   Mon, 14 Sep 2020 09:15:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200910120812.GC2206@pi3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmnq7/5rh4g76fJhbnz29gtzjb9Ibd
        YtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtbjeuYHPg8Fgzbw2jx6ZVnWwem5fUe/RtWcXo
        8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+Arltm
        DtApSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMD
        I1OgwoTsjId/rjIVvOGuaJ+9m62B8SRnFyMnh4SAicShw39YQGwhgR2MEhtnC3cxcgHZnxgl
        mjdfYYJwvjFKHFq+BMjhAOs4f0cAomEvo0TbmWQI+z2jxP8FpiC2sEChxPVjV9hAbBEBTYnr
        f7+zgsxhFrjIKNH59Ro7SIJNQEti/4sbYEX8AooSV388ZgSxeQXsJM5fawKrYRFQlbh0ZDMT
        iC0qECZxclsLVI2gxMmZT8Cu5hTQkGh49gasnllAXOLWk/lMELa8xPa3c5ghvlzIIXHwqxyE
        7SKx5MJNNghbWOLV8S3sELaUxMv+Nii7WmLlySNsIEdLCHQwSmzZf4EVImEssX/pZHBAMAN9
        tn6XPkRYUWLn77mMEHv5JN597WGFhBWvREebEESJssTlB3eZIGxJicXtnWwTGJVmIflmFpIP
        ZiH5YBbCsgWMLKsYxVILinPTU4sNC0yRo3oTIziNalnuYJz+9oPeIUYmDsZDjBIczEoivK4p
        sfFCvCmJlVWpRfnxRaU5qcWHGE2B4TuRWUo0OR+YyPNK4g1NjYyNjS1MDM1MDQ2VxHkf3lKI
        FxJITyxJzU5NLUgtgulj4uCUamBSepT5+OdLrb+uZxJn7qmpva1w9+y+S4ELWJ6JTLe2ejyz
        /kLV9MM2FdJv5ryTXJ65Uv7b1aTZPw9OmpowhU8uzWSNmqfvwo0pRboejnNP2XjdivVe9sP/
        Y9P04vV/v8/41F+yNnXB4Q9OChv2t4YG3XRVWPzKPTlStddUYcXNyp6d07yyRT//mV52/IyU
        hUdExl5bNoEF+97KJz3nTF9/oNVwp3JOblj+nkPlUcIPpSpt3r0pLJioFhp0X+PXym/5m29H
        HUiTeXbI4KF+gccWZb8n3+VvRWss4PFf3Ps2/MPPcw/U0tTZb5tbekjM8bX0dw7SOXzBOPCJ
        xpsTm7/Mvjjvmvj6tTkis7YIVE99psRSnJFoqMVcVJwIALp5KVcsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXtd/c1y8wapd8hbnz29gtzjb9Ibd
        YtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtbjeuYHPg8Fgzbw2jx6ZVnWwem5fUe/RtWcXo
        8XmTXABrFJdNSmpOZllqkb5dAlfGwz9XmQrecFe0z97N1sB4krOLkYNDQsBE4vwdgS5GTg4h
        gd2MEu9PiYHYEgKSEtMuHmWGKBGWOHy4uIuRC6jkLaPE+unz2UBqhAUKJa4fuwJmiwhoSlz/
        +50VpIhZ4CKjxIufv9gght5mlNj5xB/EZhPQktj/4gZYnF9AUeLqj8eMIDavgJ3E+WtN7CA2
        i4CqxKUjm5lAbFGBMImdSx4zQdQISpyc+YQFxOYU0JBoePYGrJ5ZQF3iz7xLzBC2uMStJ/OZ
        IGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
        P3cTIzimtDR3MG5f9UHvECMTB+MhRgkOZiURXteU2Hgh3pTEyqrUovz4otKc1OJDjNIcLEri
        vDcKF8YJCaQnlqRmp6YWpBbBZJk4OKUamFgK/y+axJUTeYal0tum9t7yRwaMG7YohFdyNbQZ
        mBjnf3/C2xb872HX62suayNZe548ci9vctLNCpxZ3pPRfsW/Y5JK9RYdv28fb8o2aMZ8mSe1
        QG8rcynnN32Nxe2cbyt/nfpw/O4jRy5em5Z4zqJTxocTOde33jpw6z7DmuZ5zFwTloY3a1U2
        dj4wMlaTM/A7uPGW5MoVzNMb4/51tu46PTf0yd09hxfvNdPo6Jm00fYBT+3ZzaclX61lsFa/
        aZmTn6kfosa0NlXLk7+F5Zvisfnb+cy2Ptk2bcZRSZv9Mp+S97cu2pPXZXZJso5TQVx5770c
        pw6/dwFHLsX87lS8N7vvzseW5RLWmYtalViKMxINtZiLihMBs/vDhRgDAAA=
X-CMS-MailID: 20200914000327epcas1p4d83c4cf93f3661c3c8787b2261b8a526
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955
References: <20200908102447.15097-1-cw00.choi@samsung.com>
        <CGME20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955@epcas1p4.samsung.com>
        <20200908102447.15097-4-cw00.choi@samsung.com> <20200910120812.GC2206@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/10/20 9:08 PM, Krzysztof Kozlowski wrote:
> On Tue, Sep 08, 2020 at 07:24:47PM +0900, Chanwoo Choi wrote:
>> Previously, devfreq core support 'devfreq-events' property in order to get
>> the devfreq-event device by phandle. But, 'devfreq-events' property name is
>> not proper on devicetree binding because this name doesn't mean
>> the any h/w attribute.
>>
>> The devfreq-event core hand over the rights to decide the property name
>> for getting the devfreq-event device on devicetree. Each devfreq-event driver
>> will decide the property name on devicetree binding and then pass
>> the their own property name to devfreq_event_get_edev_by_phandle function.
>>
>> And change the prototype of devfreq_event_get_edev_count function
>> because of used deprecated 'devfreq-events' property.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c         | 14 ++++++++------
>>  drivers/devfreq/exynos-bus.c            |  5 +++--
>>  drivers/devfreq/rk3399_dmc.c            |  2 +-
>>  drivers/memory/samsung/exynos5422-dmc.c |  6 ++++--
>>  include/linux/devfreq-event.h           | 14 ++++++++++----
>>  5 files changed, 26 insertions(+), 15 deletions(-)
>>
> 
> Feel free to take it via devfreq tree. I don't expect conflicts around
> memory/samsung/exynos5422-dmc.c.
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Thanks for review. Applied them to devfreq-next.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
