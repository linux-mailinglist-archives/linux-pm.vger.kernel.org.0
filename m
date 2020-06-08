Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC13C1F12CE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 08:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFHGXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 02:23:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35870 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 02:23:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200608062306euoutp01097cc799d12b77a7fe410a73e93de17d~WfWPxrwL_0227402274euoutp01t
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 06:23:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200608062306euoutp01097cc799d12b77a7fe410a73e93de17d~WfWPxrwL_0227402274euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591597386;
        bh=Ed//Cd6z0QIrLCNML1qOtIZ7Khf+C73RK+aUB8WgLdc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l/n+9q1EAcWiTLoeOjHk+8I5uRWNa8bKeYta0aUSD0yHAlyW81lN89zFbib6mF7mE
         z+W6GVEsMQz24PXwOCh94okBMBELwX8wLNeULXwm57yo1yHLMKVFkyGGjsF8xIMOvl
         4gYRxDL2ORTD68QOUxeL5FJqtQwkhhlN5F+Tu/FI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200608062306eucas1p1f86b3c42ac7a5e0c433bf0a5c9e50512~WfWPjONb92277922779eucas1p1q;
        Mon,  8 Jun 2020 06:23:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.1C.60679.A49DDDE5; Mon,  8
        Jun 2020 07:23:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200608062305eucas1p275aa4db597e18b8fa8afd3e7cf372906~WfWPKhZVY2738627386eucas1p26;
        Mon,  8 Jun 2020 06:23:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200608062305eusmtrp15e4b93a89aab197728ab25f9c65d0466~WfWPJ7b3e0747607476eusmtrp1H;
        Mon,  8 Jun 2020 06:23:05 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e6-5eddd94a9027
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 64.92.08375.949DDDE5; Mon,  8
        Jun 2020 07:23:05 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200608062305eusmtip10b36ebd707cbc4d2a66a1b369d4a8d31~WfWOuZhSY1716417164eusmtip11;
        Mon,  8 Jun 2020 06:23:05 +0000 (GMT)
Subject: Re: [PATCHv2 0/2] SBS battery PEC support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <be2a9fd5-9646-5e13-209a-6072a00d1b08@samsung.com>
Date:   Mon, 8 Jun 2020 08:23:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200605230625.192427-1-sebastian.reichel@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87peN+/GGTRN5bN42vWWzWLzuR5W
        i8u75rBZfO49wmhx97WfxendJQ5sHjvuLmH02LSqk83j8ya5AOYoLpuU1JzMstQifbsEroxl
        93ewFdzkrLiwfwtjA+ND9i5GTg4JAROJX+vWsnQxcnEICaxglLi0dB4zhPOFUeLZl8+sEM5n
        RonJzw+xwbRcaGyGqlrOKPH10R4o5z2jROudbmaQKmEBI4kzW9aAtYsIdDBKHFy0nxEkwSwQ
        JDFrwXQwm03AUKLrbRfYWF4BO4mFN+6xgNgsAioSf3feB6sRFYiV6Fu6AKpGUOLkzCdgNZwC
        bhLn9u5lgpgpL7H97RxmCFtc4taT+UwgiyUEprNL9Ez6ywhxt4vEj6/XoH4Qlnh1fAs0CGQk
        Tk/uYYFoaGaUeHhuLTuE08MocblpBlS3tcSdc7+AujmAVmhKrN+lD2JKCDhKLGlwgTD5JG68
        FYS4gU9i0rbpzBBhXomONiGIGWoSs46vg9t68MIl5gmMSrOQfDYLyTezkHwzC2HtAkaWVYzi
        qaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFJ5vS/4192MO76k3SIUYCDUYmHl0PsbpwQa2JZ
        cWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBa
        BJNl4uCUamDsWRNn9Dq3smGr1p57/xVl+BQu//JY9jXrYKH9nCDbp+pGa1s/M4T3Z0yUO5Pp
        ER575o9kXXzFc+VtyxoMIjpPGdntlI37WX9UybMx2n3y5JCo6ctvPz5gqMnOwvHM3nNiybRZ
        /lp66yfs/ypktPi3UbH3+rDK/7d6OpQsAy+2Nqyco83NHKTEUpyRaKjFXFScCACtF9YqLgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7qeN+/GGWzdoW/xtOstm8Xmcz2s
        Fpd3zWGz+Nx7hNHi7ms/i9O7SxzYPHbcXcLosWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnL7u9gK7jJWXFh/xbGBsaH7F2M
        nBwSAiYSFxqbmUFsIYGljBKX30lCxGUkTk5rYIWwhSX+XOti62LkAqp5yyjx9+I5NpCEsICR
        xJkta1hBEiICHYwSz188YwRJMAsESczc95kdomMmo8SEo9PB1rEJGEp0ve0C6+YVsJNYeOMe
        C4jNIqAi8XfnfbBmUYFYiW/3tkDVCEqcnPkErIZTwE3i3N69TBALzCTmbX7IDGHLS2x/OwfK
        Fpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNq
        27Gfm3cwXtoYfIhRgINRiYeXQ+xunBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pz
        UosPMZoCPTeRWUo0OR8Y8Xkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqY
        ODilGhgFD5hHJvDKXZ+o9dLgT+/l108celdU2aa9iCg4emXr+9ij4b8uXT17uWjezWcrtux9
        G1ClOfv+1kmfVj34mfVOce2c+RoR0hJcXhfYVvzMDFyt71LI81v1A7fJnNM7H6za+iXtQ7z+
        1OoTF1gmz2F+uL7cdkLRofP9uz8bLX622u+2+/7eLzpTeJVYijMSDbWYi4oTAZOFCAnAAgAA
X-CMS-MailID: 20200608062305eucas1p275aa4db597e18b8fa8afd3e7cf372906
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200605230641eucas1p199386d808ad8ce83006092da23e48bb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200605230641eucas1p199386d808ad8ce83006092da23e48bb5
References: <CGME20200605230641eucas1p199386d808ad8ce83006092da23e48bb5@eucas1p1.samsung.com>
        <20200605230625.192427-1-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 06.06.2020 01:06, Sebastian Reichel wrote:
> Second try to enable PEC for SBS battery. Mainline currently
> has 3 different platforms using sbs-battery with an I2C driver
> not implementing I2C_M_RECV_LEN:
>
>   * i2c-exynos5
>   * i2c-rk3x
>   * i2c-tegra
>
> On those platforms PEC will be temporarly disabled for SBS
> functions requesting strings. I considered moving the emulation
> to I2C core, but it's specific to the SBS battery. The hack
> only works because the strings are constant.

Thanks for the update. Works fine on Samsung Exynos-based Chromebooks: 
Snow, Peach-Pit and Peach-Pi.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Changes since PATCHv1:
>   * dropped all applied changes
>   * rebased on top of power-supply's for-next branch
>   * keep existing string reading method as fallback
>
> -- Sebastian
>
> Sebastian Reichel (2):
>    power: supply: sbs-battery: use i2c_smbus_read_block_data()
>    power: supply: sbs-battery: add PEC support"
>
>   drivers/power/supply/sbs-battery.c | 89 +++++++++++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 2 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

