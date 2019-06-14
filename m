Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2459457E5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFNIwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 04:52:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43254 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFNIwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 04:52:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614085206euoutp0141b0f768fa7ca5c1a6f1f12be89bffe4~oBJk1I4cn0773907739euoutp01M
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 08:52:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614085206euoutp0141b0f768fa7ca5c1a6f1f12be89bffe4~oBJk1I4cn0773907739euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560502326;
        bh=cdMYdgdAyCPxYcT1PWJdhYey1Rxfn3a4RP/Hu/5h1FI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JyXhDr8qvphKmR98fDRHkmdmX/6E9FW5z14zmqqpebvvT7fEFsksxkTjtGK5CKiwz
         wh1B01GcfkUzcyU+ct/vX7HTUJ4KR2g+Zguvl0z67luHwOen5Qb8deL7cyb1QP0qxx
         cc6/aYtMtg6bVo4V1CtyL3D3J/IdTO+rNLZUFaBY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614085205eucas1p12129e7648760d86e435992c6fcb43d91~oBJjoTZJC2083720837eucas1p1H;
        Fri, 14 Jun 2019 08:52:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.D8.04325.530630D5; Fri, 14
        Jun 2019 09:52:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614085204eucas1p212b92409f17b156ed8ac2225892035f3~oBJi2K4ji0578705787eucas1p2X;
        Fri, 14 Jun 2019 08:52:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614085204eusmtrp28fb3734765ed74dfe821b690696b15ef~oBJimQ4ix1839818398eusmtrp2c;
        Fri, 14 Jun 2019 08:52:04 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-ba-5d036035a769
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.86.04146.430630D5; Fri, 14
        Jun 2019 09:52:04 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614085203eusmtip2529b2d757d6bab06fb8ae01ea9889c42~oBJhsiWjO1997619976eusmtip2X;
        Fri, 14 Jun 2019 08:52:03 +0000 (GMT)
Subject: Re: [PATCH v9 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org,
        kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <91ba13c8-bbfe-ea3a-7912-98d213ea3029@partner.samsung.com>
Date:   Fri, 14 Jun 2019 10:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611224319.GA7484@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju27k6mnzOyhe70YGiC1mRwUeGJF041I/8UdFNcuVJIzdrR+36
        w4rMSm1o2ZppScFsVsvlZbNIm5I2l5skaVkRGQSphXiJMrpsZ5H/nu99Lu/7wMdT2nw2mt9v
        yJSMBl26wKrpuqfffYtXJFNJS2vfTSPVZjtDukc+MeR6SwdDqob6EDl9086SYk+Zingv6MnF
        vn6K+Hz3OfL81ABHhvLfMeRFwzWWDBe0IGL2PVaRuy1vOdLpWUd6T1ay5PcjJ0eaB84y5NfL
        apo0dm0gvePhZKztA1odJY6NFtHi154znFia00mLLstbTnTYzrFiY9kdTiw4/YUVC2tsSHzQ
        flwcdsxKVO9Qr0qR0vdnS8Yl8cnqNFOrlztoZY60u8apHGSnz6MwHnAs1HqcqvNIzWtxJYI3
        bS5OeYwgqB14EmKGEQyM3EL/LF31TZRCWBG4Ck0hyyACZ10RE1BF4n1gLegOOqbgOTCeW8IE
        RBSuoCG3tPBvLs+zOAactkMBqMHrYfRHdEBO47nwraYkeN9UvA1GXI5gjAZHwLOrH4PzMLwQ
        LplesgFM4Sh4/fG6SsGzoX7wWvA4wG08DJ3pZwL5gNdC902dUiASPrfWcAqeAb9dihewDDkF
        FaGSJ6DvYllIEwfNrZ3BGAovAHvDEmWcAHm2XlpJD4eewQjlgnAoqrtCKWMN5OVqFfV8qMn3
        hxZNA+udEs6EBMuEXpYJXSwTulj+772BaBuKkrJkfaokLzdIh2NknV7OMqTG7M3QO9DfP9r+
        q3XUiR7/3ONGmEfCZE3TSlWSltFly0f1bgQ8JUzRlMdRSVpNiu7oMcmYsduYlS7JbjSdp4Uo
        zfFJ73dqcaouUzogSQcl4z9WxYdF56DG1NEZkWveT906zISnbFnQkOz/eikx4dY3U8tebzVT
        lN291T/Td5slD3u0m71zlsePVSY0b3FvOLxoW6J+7ZfS7IiKnV1VCZGe6rR5KwwdeeomwfyQ
        1A/e21VG92vFuNjL/u1+c9xG7yZHsV1fXkVOLKZOCsXu+FNWs3Db7Xkl0HKabtlCyijr/gCw
        3o5OnwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XauWqvTUfND6OIgDKFjx0t+LpWCskNESVcpx1x60tC52plS
        iTCz0tbNS0XNa0RaWiyd5IXwMiVNraWZhaJRRhGZImkXF5bTAv/7wfP84H3hoTG2lPCijyYb
        RH2yJklBuuJdM+3D6wJjMNX6V5YVqOqGhUCvJz8RqKTtOYEqJ0YAyrxtIVF+Z5EMdV/Qoisj
        XzBktz+k0LPToxSauDhMoJcNhST6dqkNoBv2Rhl60DZEoZ7OrWgw4y6J/jyuo1DraBaBZvqr
        cNTUtx0NOpag7x3vwSZP4ftUHi6MvzlLCQXGHlyoNw9RQnXFeVJoKrpPCZcyx0jhck0FEKxd
        acK36pWRrge5UL0uxSCuTtBJhjDFIR75c3wI4vwDQzg+IFil9A9S+IWHxolJR1NFvV94DJeQ
        095NHSsnTnTVOzAjsOAm4EJDJhD21TZjJuBKs8wdAK0j09R8sBzmNdb+Yzf4u99Ezpe+AHjP
        WI45AzfmCHxWb5c52Z3xho5z1wlnCWNu4XDaYpuzWeYzgIWjm02ApkmGg3UVx50oZyLg1LSX
        s4Eza+CPmutzB3kwUbCgwTjHcmYZfHrzwxy7ML7wak4/6WSM2QCLre+wefaEAx9KZPO8CtZ+
        LcRyAGteoJsXKOYFinmBUgrwCuAupkjaeK3Ec5JGK6Ukx3OxOm01mF3Hoye/rHWgt2qPDTA0
        UCyWNytlKpbQpEontTYAaUzhLi/eiKlYeZzm5ClRr1PrU5JEyQaCZp/Lxbw8YnWzW0s2qPkg
        PhiF8MEBwQEbkMJTns20RLNMvMYgJoriMVH/35PRLl5GsE8wcB3+Lxw/45UHvNvsrxwT9WVC
        pDJqci2xg5Nf3uXde62MT3yfFrFFe1i9Ol1UVaLtrePKsFTVSwe7bb/n8eGyvNy3WTt0jugB
        n47BjzKfGWu1o8RvxmZSn1k0lLNzwOPmmDp77+7cpUHpILPAp3esOX/8aktGUX6siV0cqMCl
        BA3vi+klzV8lKEImMwMAAA==
X-CMS-MailID: 20190614085204eucas1p212b92409f17b156ed8ac2225892035f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a@eucas1p1.samsung.com>
        <20190607143507.30286-8-l.luba@partner.samsung.com>
        <20190611224319.GA7484@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/12/19 12:43 AM, Rob Herring wrote:
> On Fri,  7 Jun 2019 16:35:01 +0200, Lukasz Luba wrote:
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../memory-controllers/exynos5422-dmc.txt     | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob. I have added it into the next version.

Regards,
Lukasz Luba

