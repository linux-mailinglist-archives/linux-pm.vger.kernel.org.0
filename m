Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F321D03F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGMHLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 03:11:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30056 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgGMHLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 03:11:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200713071149epoutp04c52e7ba61d2667184aa1236acaaee0d2~hPlx3aOzV1818518185epoutp04U
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 07:11:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200713071149epoutp04c52e7ba61d2667184aa1236acaaee0d2~hPlx3aOzV1818518185epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594624309;
        bh=fvdb8j9PaoYsFszqN6un92aMnmzVWaQh86O7KCfShUw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rY0Gf63BuEPUQRO6aK6FEJQoYomddTxLHrWiWrFLzhGBlS9jQLyHVzci+aQY/xKWG
         xBxOzn9iPtOgsxYRhaenryGZ35JMSDwmT8dcXxNLY7eGlZdiOG8TOoh1S/x/W2OGqS
         KPmFZ8FbgJ3aNbkHLbxVuWGxMN527PRPbzCKJiXQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200713071149epcas1p4e16fc830bef8d6680486e068559dc1c2~hPlxOVvkM1177611776epcas1p4_;
        Mon, 13 Jul 2020 07:11:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B4vw163j2zMqYly; Mon, 13 Jul
        2020 07:11:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.86.18978.1390C0F5; Mon, 13 Jul 2020 16:11:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200713071145epcas1p4e85b274131cc673354e22a70d06470d6~hPltlcWIq0908309083epcas1p4k;
        Mon, 13 Jul 2020 07:11:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200713071145epsmtrp17ad310682ea1085d6f33635242848158~hPltkur6D0449404494epsmtrp10;
        Mon, 13 Jul 2020 07:11:45 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-6a-5f0c09314e3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.DC.08303.1390C0F5; Mon, 13 Jul 2020 16:11:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713071145epsmtip2dbdb3fa43942b6cafe6e075c1694278a~hPltWpsbK2500625006epsmtip2a;
        Mon, 13 Jul 2020 07:11:45 +0000 (GMT)
Subject: Re: [PATCH] dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu
 phandle
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        heiko@sntech.de, maz@kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <95cd1315-3253-7b70-f648-717e36d4a6b9@samsung.com>
Date:   Mon, 13 Jul 2020 16:23:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200709090529.1404999-1-enric.balletbo@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnq4hJ0+8wYO5Bhbzj5xjtTi77CCb
        xZrbhxgtlux6w2bx/9FrVovN53qAEk1v2C0u75rDZvG59wijxc45J1ktbjeuYLNo3XuE3eL/
        nh3sDrwesxsusnjsuLuE0WPTqk42j74tqxg9tl+bx+zxeZNcAFtUtk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0KVKCmWJOaVAoYDE4mIlfTubovzS
        klSFjPziElul1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMpQ/OsRQ0CVW837mdvYFx
        IX8XIyeHhICJxPZT7WxdjFwcQgI7GCU+njvFAuF8YpSY3/KSDaRKSOAzo8SG2bIwHTtuTGCH
        KNrFKLHk/nyoovdAzr0IEFtYIFDi9YSZLCC2iECkxKT2j4wgDcwCX5kkfs/+DdbAJqAlsf/F
        DTCbX0BR4uqPx4wgNq+AncSun+/YQWwWAVWJhvZvYINEBcIkTm5rgaoRlDg58wlYnFPAReLg
        hy4wm1lAXOLWk/lMELa8RPPW2cwgiyUEznBI/Jq3jgniBReJu1eaWCBsYYlXx7ewQ9hSEi/7
        26DsaomVJ4+wQTR3MEps2X+BFSJhLLF/6WSgQRxAGzQl1u/ShwgrSuz8PZcRYjGfxLuvPawg
        JRICvBIdbUIQJcoSlx/chTpBUmJxeyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRi
        wwJD5NjexAhOxVqmOxgnvv2gd4iRiYPxEKMEB7OSCG+0KGe8EG9KYmVValF+fFFpTmrxIUZT
        YABPZJYSTc4HZoO8knhDUyNjY2MLE0MzU0NDJXHef2fZ44UE0hNLUrNTUwtSi2D6mDg4pRqY
        uln9XYt36JzaZxjLu/NWIq+b6GS1DaeeGBjovxFiXGDO9fx05TKP8P8Z8dFG6Q5TdpQ435xk
        2K9xY4/0ojchc+tYvWZt2XtU2/HXErn2yrWXmfYLM91TtJp+6nv6N/cfXayGjwqmtUw4dMNK
        i9moTHLVs7JPSbbv+QR17P9d1Ldp/Ot5PXnV66N3Jz+5NSF2ddr8XUv0r7sdvxTAs8dzelyX
        gb+FsBPD05/mszI8WXw5VZ3Ou7xWXno+quyNuEO293bDb/Icshblqja3z1b1sL16F+apP2uq
        SmkM754T/4uuKGUWRiUsv1Z1M937nz1XbE/57JsflF+dfnY5Zdf6Tyohbs+bJm9Q+PxejWWn
        EktxRqKhFnNRcSIALSds404EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvK4hJ0+8weWTfBbzj5xjtTi77CCb
        xZrbhxgtlux6w2bx/9FrVovN53qAEk1v2C0u75rDZvG59wijxc45J1ktbjeuYLNo3XuE3eL/
        nh3sDrwesxsusnjsuLuE0WPTqk42j74tqxg9tl+bx+zxeZNcAFsUl01Kak5mWWqRvl0CV8bS
        B+dYCpqEKt7v3M7ewLiQv4uRk0NCwERix40J7CC2kMAORonbt1Ig4pIS0y4eZe5i5ACyhSUO
        Hy7uYuQCKnnLKHH55X0WkBphgUCJ1xNmgtkiApESxzYvYAcpYhb4yiSx/Ps2RoiO6YwSc7c1
        MoJUsQloSex/cYMNxOYXUJS4+uMxWJxXwE5i1893YFewCKhKNLR/A5sqKhAmsXPJYyaIGkGJ
        kzOfgMU5BVwkDn7oArOZBdQl/sy7xAxhi0vcejKfCcKWl2jeOpt5AqPwLCTts5C0zELSMgtJ
        ywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFRqaW1g3HPqg96hxiZOBgPMUpw
        MCuJ8EaLcsYL8aYkVlalFuXHF5XmpBYfYpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJg1Oq
        gUkuNvjcTWGOT41/fTqT+5+u5zyxM0B3/pV7VrbJ++yObdRXN79848mPCUGdf7eHTSl41fGE
        y3zz6orw+4aeyUqXKk1P/s37diq8abaR7AaNN/FFocbnfm245bQ/UTHy1QQ7S87cGP91y19s
        tu2sXTmv0kBmekmMMG8x67Zz5xu88pzYpTc7LefeNoXzfoXs1jLOa573aqusq48emCMr4r16
        nZk/v/cTl4kcyvmH/r453dK6SkufaVZn6v1gOX0loeteadxWN/ymXjpov1PQItq4tjqVwWFG
        04PrikeEW+6wHGR7bejmumHFf/fSa9YW/H8X7/2Zk/N+pulGJTvb7h3rXTQ3NVZm/FKQF8i3
        VGIpzkg01GIuKk4EAJHMl2g5AwAA
X-CMS-MailID: 20200713071145epcas1p4e85b274131cc673354e22a70d06470d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709090541epcas1p1b5d1c5ab9b3c1409d59257035b104747
References: <CGME20200709090541epcas1p1b5d1c5ab9b3c1409d59257035b104747@epcas1p1.samsung.com>
        <20200709090529.1404999-1-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric,

On 7/9/20 6:05 PM, Enric Balletbo i Serra wrote:
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> Following the discussion in [1] and after having [2] accepted, this
> patch is a RESEND of a patch [3] that has already all the acks but for
> some reason and my bad, I lost the tracking, didn't land. The patch adds
> documentation for an already property implemented in the driver, so
> resend the patch again. There is a slighty modification, the rockchip,pmu
> property has been moved to be optional as is not really required.
> 
> Thanks,
>   Enric
> 
> [1] https://protect2.fireeye.com/v1/url?k=0a124f1c-57c247d0-0a13c453-000babff3793-37ca8c47e6666c09&q=1&e=40f33cd6-b2d6-4de2-a309-fbf8645f89f9&u=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F6%2F22%2F692
> [2] https://protect2.fireeye.com/v1/url?k=1aca44e8-471a4c24-1acbcfa7-000babff3793-6f0cff085cef3454&q=1&e=40f33cd6-b2d6-4de2-a309-fbf8645f89f9&u=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F6%2F30%2F367
> [3] https://patchwork.kernel.org/patch/10901593/
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index 0ec68141f85a..a10d1f6d85c6 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -18,6 +18,8 @@ Optional properties:
>  			 format depends on the interrupt controller.
>  			 It should be a DCF interrupt. When DDR DVFS finishes
>  			 a DCF interrupt is triggered.
> +- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
> +			 files".
>  
>  Following properties relate to DDR timing:
>  
>

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
