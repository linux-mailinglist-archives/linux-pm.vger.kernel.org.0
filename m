Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC4C346D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfJAMiq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 08:38:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58913 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfJAMiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 08:38:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191001123845euoutp02868798649eb634b79a12e7a33a602e6f~JhjkmOK9y1528015280euoutp02P
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 12:38:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191001123845euoutp02868798649eb634b79a12e7a33a602e6f~JhjkmOK9y1528015280euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569933525;
        bh=P3LQEMEr2ElljIQFeYWukVZZz3LkJ8Ybhmdpwqsf1A0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Kc5elUoefFeEupRb9TuW6SBOmhq0W00Sgqtnjrb8pKXWT+NKi+hoJeb/qvF0gGVVG
         NoZI8p5nmKYN8hY5xHbJw4rqe5k9m1AVPqtoiECyhShwguXFa9/qdB9UXt6R3BTe+N
         OdQUq9BQutxwBb67S4dwN3H9dOtXYhYtoVKv6K8s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191001123844eucas1p24a109be47dc918a3c988aeeb63b7f6f0~JhjkOeLGg2967929679eucas1p2a;
        Tue,  1 Oct 2019 12:38:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EB.73.04374.4D8439D5; Tue,  1
        Oct 2019 13:38:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191001123844eucas1p1ab3cf26fa7a5ec8748b67f49df5aaa47~JhjjyhIH60392003920eucas1p1_;
        Tue,  1 Oct 2019 12:38:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001123844eusmtrp10339363d1656fab2f497e0178b59ca6e~JhjjxsAZZ0473004730eusmtrp1X;
        Tue,  1 Oct 2019 12:38:44 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-24-5d9348d4aacc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.0B.04166.4D8439D5; Tue,  1
        Oct 2019 13:38:44 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191001123843eusmtip237921a023022d439d4283e2bae0b2dd9~JhjjG90Ma1599415994eusmtip2u;
        Tue,  1 Oct 2019 12:38:43 +0000 (GMT)
Subject: Re: [PATCH 1/3] ARM: dts: exynos: Add interrupt to DMC controller
 in Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <16c56e81-d0a7-a405-fa12-83442364c260@partner.samsung.com>
Date:   Tue, 1 Oct 2019 14:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927085359.GA19131@pi3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29m5OJodp+WbhcEKUkMzKvgg8QIq+5XRrzBWrXZQyU3bmZYm
        5KWLzmtalqs0pZoMY2ViOkpBl1O6mOYtozCVpFKLZg3BLI/HyH/P+7zP+z7P+/ExhGKI9GOS
        9EbOoNckKymZtLlr/lXwgKpCHZo/sh0/vG4j8fDcFIlrHK9IXDrxlcC9vQ9o/DJ3msaNE0Mk
        fmO/SWFXsQPh671tEnzf8Z7Gd4f7JPhdTj2FLzx10Lhz+hKJf3WPo0hW1VDdgFSt5ve0qtFa
        QKke3TmnKmmyIpWr0f8AFS8L03LJSemcYWf4MVliSf2O1HbZmdqKQjIbdTImxDDA7oEnV3Um
        5MEo2HoETlOgCcmW8ByC9hdtlFi4EPTbZ0hBJQzk5UyQYsOCILfsrUQsZhCU5nykBZU3Gw8N
        rkGpgH3YQBj+7V6eJlgzAYM1QYI1xYZAi/WUQMvZWCirvCcRaCm7DS4WUAK9nj0EP8Y6SVHi
        BT1Vk8sbPZY2jtxYpMWNvjA6WSMR8RZ4PHOTEOIAm8OA6ZsTiaGjYd49KxGxN3xxNtEi3gzP
        K4qkIuYhu7h2RZ8FE6W3VjT7oNPZRwrZiCVjm32nSEdBV79FKj6iJ4zMeIkRPKG8+Roh0nLI
        v6gQ1QHQVPR6JcAGsDRU0mVIaV51mHnVMeZVx5j/+95GUivy5dJ4XQLH79Zzp0N4jY5P0yeE
        nEjRNaKl3/Z80fmzBbUtHO9ALIOUa+V46rJaQWrS+QxdBwKGUPrIwxbK1Qq5VpORyRlSjhrS
        kjm+A21ipEpf+dk1Y4cVbILGyJ3kuFTO8K8rYTz8slHcEKxxr1PRza37Y5SLan0wepeSanRE
        dEcfKd0b62+LURf98aprabI0X+juW7BndXwecGurAii/iO/h97e7t1SFvul5Vh1l4lsTvGxH
        XMYPYenedYu2SGvhp6nM+BPjwXULvv3G9vNbr+QRksKNEQfDb0BitU+c1t81SrGWWaWUT9Ts
        CiIMvOYvnYKBEGkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7pXPCbHGlz7x2WxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0bdC
        u2A/V8XCyd2sDYyHOboYOTkkBEwkmhsfs4LYQgJLGSWez3aBiItJTNq3nR3CFpb4c62LrYuR
        C6jmNaNEz7wvjCAJYYEoib3r54MViQhoSlz/+50VpIhZYBazxPorzSwQHS8YJa6caGfuYuTg
        YBPQk9ixqhCkgVfATWLCtGVMIGEWARWJtk42kLCoQITE4R2zGCFKBCVOznzCAmJzAs2/Mfsf
        2C5mATOJeZsfMkPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz0
        3GJDveLE3OLSvHS95PzcTYzAmN527OfmHYyXNgYfYhTgYFTi4Z3wcmKsEGtiWXFl7iFGCQ5m
        JRFemz+TYoV4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5hu8kriDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MHpxKDecfPNweoayqUnCvMmsm5R5mzvaJ28V+Ga8
        5+mzAwuvTFzWlsFswOb8audV/6uc4do3n7olV5Y/67GdWjWR+7uzyxpG89CdLw/tWhYcvvYr
        Z/h52xtRSTpfV83ICZ9aMEV/2VdR48Pad4SPxPvX+LO8VZjBOWmvbqtguYLziic/prJy6Cqx
        FGckGmoxFxUnAgDoPfRt/wIAAA==
X-CMS-MailID: 20191001123844eucas1p1ab3cf26fa7a5ec8748b67f49df5aaa47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
        <CGME20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f@eucas1p2.samsung.com>
        <20190925161813.21117-2-l.luba@partner.samsung.com>
        <20190927085359.GA19131@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/27/19 10:53 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 25, 2019 at 06:18:11PM +0200, Lukasz Luba wrote:
>> Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
>> XU3-family boards. It will be used instead of devfreq polling mode
>> governor. The interrupt is connected to performance counters private
>> for DMC, which might track utilisation of the memory channels.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index ac49373baae7..72738e620d11 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -240,6 +240,8 @@
>>   		dmc: memory-controller@10c20000 {
>>   			compatible = "samsung,exynos5422-dmc";
>>   			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
>> +			interrupt-parent = <&combiner>;
>> +			interrupts = <16 0>;
> 
> You register DMC for DREX0 and DREX1 but take only DREX0 interrupt. Why
> skipping second?
> 

Right, the second should also be there: <16 1>. The channel 1 has not
been triggered in CPU test cases but might be used by some other
NoC clients.
I will add it in the next version.

Regards,
Lukasz
