Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0234F7C295
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfGaNBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 09:01:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38477 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfGaNBA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 09:01:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190731130059euoutp028a623fc48774b824137f406352ff94da~2f3SuDAb_1307613076euoutp02c
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 13:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190731130059euoutp028a623fc48774b824137f406352ff94da~2f3SuDAb_1307613076euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564578059;
        bh=sYKGsWtGJ4TQpv6om4+mpD+czgFv0SgtP4v8p2BxWRc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PPknhESAOOlCRF6Ro5Lt3dK5cCDfT4cs95UE68TgmIM7EsHxKd5MKl4YrzEqeaxnk
         pLn2Xf0MLzsbYvowlQOL52vOMEu3CCXH+R2hjXqQuGKaeBBksOjBiWSFnRoQJ9eaaw
         XVJ34F0IsMUVUIee++06eWLvsgkRMOjiDkuFfa+Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190731130058eucas1p2d6d3566af0adf524aa00aef148404b80~2f3SAJLWI3272032720eucas1p2Y;
        Wed, 31 Jul 2019 13:00:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.3B.04325.A01914D5; Wed, 31
        Jul 2019 14:00:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190731130057eucas1p1dbc0f96212e96ceac96daede85f71e9e~2f3RIjytP1120011200eucas1p13;
        Wed, 31 Jul 2019 13:00:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190731130057eusmtrp1ffe2e1501174ab8d64867c381f28eaf3~2f3Q6Q9RD2484424844eusmtrp1J;
        Wed, 31 Jul 2019 13:00:57 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-96-5d41910a6337
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.1A.04146.901914D5; Wed, 31
        Jul 2019 14:00:57 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190731130057eusmtip194ae2facf90fd2df4e18896b0f9f9975~2f3QVouLZ2612526125eusmtip1m;
        Wed, 31 Jul 2019 13:00:57 +0000 (GMT)
Message-ID: <73b8c7078b2378921e841b5bd02bd617cc2143be.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com,
        =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Date:   Wed, 31 Jul 2019 15:00:56 +0200
In-Reply-To: <20190724192426.GJ14346@kozik-lap>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt/vYdTa9zsAPs6KhQlY+SuGCUmmvkRBmgZFarbxo5VR2fWRJ
        aommlk/KJ6SoNSwfTQ2VfIvLNFdZWmlMMh8ZVjKlwpScd1L/ne+c3/nO+eBHYZIuwpq6EBbJ
        KsPkoVJShD/p+T2wU5TtGehcUWDLPM6vIZjh+SmCudc9QDBvFr6TTF6LmmRydFk4o9XWChn1
        +BDBDDYXk4z+djdi8rWtAqaq+6OQGUlUkUx+7hdyn5lMXZlKykaHnpIyXbpGIKsrj5dl1Fci
        mV692Yc8JfIIYkMvRLNKpz1nRSELLemCiCXx5YLBUiwBlZumIRMKaFdo071FaUhESWgVguSi
        TOMwj6A9NRvjBz0C/cuvgjVLj36O5IUHCMr6Mwl+mETQOpOxYqEoMe0D3/JWDZZ0EEy3vkAG
        TNKHYXnqDWHAG+htMLz0c9WL0e0YdLTcERoEnLaDoskSzIBNaCdQJfVifPIOmH2egfP7LWCp
        0dJAY/QWuNFQtNoU6A9CqB1rF/LvD4CmdhDnsSXMaOqNvA305d4y8hxMNOkI3pyAQH2/2xjm
        Dl2aV4QhDFtpWtPsxNOeMN+XstoBaDN4N2vBdzCDnCd5GE+L4WayhIcOULLozxsBrj8cMu6W
        Qd3EIzILbS38d0vhf7cU/kstQVglsmKjOEUwy+0OY2McObmCiwoLdjwfrlCjla/Vt6xZaESt
        f851IppC0vXiZ6megRJCHs3FKjoRUJh0g7jMam+gRBwkj73CKsPPKKNCWa4TbaRwqZX46rox
        fwkdLI9kL7FsBKtcUwWUiXUCanpg+fqHrdivr3/EpHrhUJ2o2O1uQ0D/8q7Pzrr320d7UUvp
        4o4qd++jiQGqisFNx9ncgmr7+WsDChmy9/jc1XFMi/uWvboY5+vqEeo75zzm4hWTcBD396mI
        O+JtU+nX45aynz6ZbTZ52iXefMbctLM8rkp74te4tt8r6ZOdedu0FOdC5C4OmJKT/wVKrNeP
        VgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qcEx1jDfYu1rbYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWMya/ZHPg89i0qpPN4861PWwe97uPM3lsXlLv0bdlFaPH501yAWxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlf93YzFfzlrZh5eSFz
        A+MS7i5GTg4JAROJY58/snUxcnEICSxllDi+ei8LREJC4uP6G6wQtrDEn2tdUEVPGCXe7HzF
        1MXIwcErECDxbjoTSI2wQIrEi31nGUFsNgF3iX/Pr4D1ighoSlz/+50VpJdZ4BCzxLoD3WAJ
        FgFVidnPFjCD2JwC+hIrWk4yQyz4CrRg0x2wK5iBulu3/2aHuEJH4u2pPhaIxYISf3cIQ5TI
        SzRvnc08gVFwFpKOWQhVs5BULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYkduO/dy8
        g/HSxuBDjAIcjEo8vCc6HWOFWBPLiitzDzFKcDArifAuFrePFeJNSaysSi3Kjy8qzUktPsRo
        CvTPRGYp0eR8YLLIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXA
        2J9m+/Xsc6Fvq9dMvSPKycY8s5PvYMexZaH8SkX95jU9W9RLuBIslSbdvn+94FtJyQOFDvZM
        kznzJqTHrk9d+vLkxopT/1rPWZamhTkuVPuxy6DSs7GjUlRm0pnJM0qfLLxW88tQ23OJ+Trt
        Oetby1nuTXp15ZG7MNc7eZmQ0mPsZh5q+x51KrEUZyQaajEXFScCAC2JLOveAgAA
X-CMS-MailID: 20190731130057eucas1p1dbc0f96212e96ceac96daede85f71e9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
        <20190723122016.30279-9-a.swigon@partner.samsung.com>
        <20190724192426.GJ14346@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-24 at 21:24 +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 23, 2019 at 02:20:13PM +0200, Artur Świgoń wrote:
> > This patch adds two fields tp the Exynos4412 DTS:
> 
> tp->to

Fixed. Thanks for catching the typo :)

> >   - parent: to declare connections between nodes that are not in a
> >     parent-child relation in devfreq;
> 
> Is it a standard property?
> The explanation needs some improvement... why are you adding parent to a
> devices which are not child-parent?

This is not a standard property. I actually wanted to call it 'neighbor' at first. If you take a look at [1] and search for 'Exynos4x12', you will see that there are two power lines, and each has exactly one parent block (the rest are modelled in devfreq as its children). In [2], the parent of each child is indicated using the 'devfreq' property, e.g.,

&bus_display {
	devfreq = <&bus_leftbus>;
	status = "okay";
};

The single piece missing to make this topology a connected graph (for
interconnect QoS purposes) is the 'parent' property I proposed in this patch.
bus_leftbus is dependent on bus_dmc, therefore using the term 'parent' is
justified IMHO.

The explanation could be improved by adding what Chanwoo Choi <
cw00.choi@samsung.com> expressed in a parallel reply to this patch:
> - If 'devfreq' property is used between buses,
>   it indicates that there are requirement of sharing of power line.
> - If 'parent' property is used between buses,
>   it indicates that there are requirement of interconnect connection.

[1] Documentation/devicetree/bindings/devfreq/exynos-bus.txt
[2] arch/arm/boot/dts/exynos4412-odroid-common.dtsi (subject of this patch)

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

