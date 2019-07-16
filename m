Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92C6A43E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfGPIvR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 04:51:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:37992 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbfGPIvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 04:51:16 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190716085114epoutp01cd3bc6cf64362a7552e2a63c76d3f1a1~x1x8PfQis2980629806epoutp013
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 08:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190716085114epoutp01cd3bc6cf64362a7552e2a63c76d3f1a1~x1x8PfQis2980629806epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563267074;
        bh=ACmg7AjJRbmv8mGq5gKa0bJFXDdGLqITjtTawvIlASk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GCZq5KFIPo4mvLcEvanLtpAMSJvbHRzu71cmhopmN7nTdJ4PofBtMcknOsoauPPTo
         LkhzYjkevzg3gVYcmrYM91FNpWVnMLNYojp6fWIYaj8xgJJorbnAmRr7sv+HzsdD7v
         SZE8aqqkXT+JN6SeEpF6OrmBOJoMlnYIhUSSnIlA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716085113epcas1p212a4f08e0086b5c591090dd472431915~x1x7i9__D1067710677epcas1p26;
        Tue, 16 Jul 2019 08:51:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45nvJF6VyjzMqYlp; Tue, 16 Jul
        2019 08:51:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.7C.04075.BFF8D2D5; Tue, 16 Jul 2019 17:51:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716085106epcas1p4e767ed3858ed9cb3fa631460a2cdd7f5~x1x1evSBQ3230832308epcas1p4Q;
        Tue, 16 Jul 2019 08:51:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716085106epsmtrp2c953c1719788d049c8c59073b2b2ad00~x1x1dwKIU0187301873epsmtrp2i;
        Tue, 16 Jul 2019 08:51:06 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-96-5d2d8ffb8d9f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.A3.03638.AFF8D2D5; Tue, 16 Jul 2019 17:51:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716085106epsmtip1074ab7b2b284a61a7b4ff2438f449579~x1x1BTOw-2378423784epsmtip1-;
        Tue, 16 Jul 2019 08:51:06 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] dt-bindings: devfreq: exynos-bus: remove unused
 property
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <dd74212e-a422-13ab-8237-fcaf372ab3eb@samsung.com>
Date:   Tue, 16 Jul 2019 17:54:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715120416.3561-5-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmnu7vft1Yg4uXRCw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZz/r3Mxe856yY1bqAqYFxOUcXIyeHhICJxLrZC5i7GLk4hAR2MEp09k9h
        hHA+ATmrz7FBON8YJeb+eMMG03Jl/zx2iMReRok3S48xgiSEBN4zSrRfKQSxhQXCJG7OPswO
        YosImEo8Wt3ACtLALHCZRWLao0msIAk2AS2J/S9ugE3lF1CUuPrjMdggXgE7if2bngIdxcHB
        IqAq8e9DIEhYVCBC4tSReSwQJYISJ2c+AbM5BVwkfndfBRvJLCAucevJfCYIW16ieetssN8k
        BE6xS3xe2QH1gYvEql9/mSBsYYlXx7ewQ9hSEp/f7YWqqZZYefIIG0RzB6PElv0XWCESxhL7
        l05mAjmOWUBTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIscfnBXai1khKL2zvZ
        JjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxYYIcf2JkZw6tYy28G46JzPIUYBDkYl
        Hl6F/TqxQqyJZcWVuYcYJTiYlUR4bb9qxwrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBe
        ySuJNzQ1MjY2tjAxNDM1NFQS5533RzNWSCA9sSQ1OzW1ILUIpo+Jg1OqgXGXb9C7ZZ6GfFnB
        5u0sYcY9F8seia2NzvUxWRP3Jt5KPac5fd2x3zGHG91Dt99umLF3Qen/p0cOXnJz8nTjYrUS
        bzvy/LqpRlLJhYlRmyUNp7PtizzwYiuTVvGFd0LtU3v2J19m77rQa+Kxqs+goeTNLIfcpFmG
        CxZkh68+Uf4mvjtO9tDWbCWW4oxEQy3mouJEAOWvWCDzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnO6vft1Yg+3vNSw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APYoLpuU1JzMstQifbsEroxn/fuZC95zVsxqXcDUwLico4uRk0NCwETiyv55
        7F2MXBxCArsZJf4/n8AKkZCUmHbxKHMXIweQLSxx+HAxRM1bRolJOxezg9QIC4RJ3Jx9GMwW
        ETCVeLS6gRWkiFngKovE+Y1z2CA6LjJK7Dp0Emwqm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        +zc9BdvGIqAq8e9DIEhYVCBCYtK1nSwQJYISJ2c+AbM5BVwkfndfBRvJLKAu8WfeJWYIW1zi
        1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAiOYi2tHYwnTsQfYhTgYFTi4T2xRydWiDWxrLgy9xCjBAezkgiv7VftWCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MUnc55mkrTz69/eq/
        uZ9k+9/OY3SYdOeYhJzpc4ZtRf9/zi/x/qvjvevH66BvTXxTZPXXHHLa87WI2ZLj+WPRbV+Z
        rtax3j1WLx/LbdHkyLYg+3roRsfmSpGCdQz/MoxD/e7OPM35K6bKIkNnMqNpi+hx/mrvA4IJ
        GiaR9pt2/+E4zta7QDdWiaU4I9FQi7moOBEAUbNLAd4CAAA=
X-CMS-MailID: 20190716085106epcas1p4e767ed3858ed9cb3fa631460a2cdd7f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715120433eucas1p26681c5c2d87423253b651d88446c538c
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120433eucas1p26681c5c2d87423253b651d88446c538c@eucas1p2.samsung.com>
        <20190715120416.3561-5-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
> Remove unused DT property "exynos,voltage-tolerance".
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index f8e946471a58..e71f752cc18f 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -50,8 +50,6 @@ Required properties only for passive bus device:
>  Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>  			the performance count against total cycle count.
> -- exynos,voltage-tolerance: the percentage value for bus voltage tolerance
> -			which is used to calculate the max voltage.
>  
>  Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  - In case of Exynos3250, there are two power line as following:
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
