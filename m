Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092F840D834
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhIPLRB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 07:17:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57179 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhIPLRA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 07:17:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210916111535euoutp01674f2dd8d3c578b932f0699eefc8764c~lSTXHnQoz0588105881euoutp01E
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 11:15:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210916111535euoutp01674f2dd8d3c578b932f0699eefc8764c~lSTXHnQoz0588105881euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631790935;
        bh=yZ91VPl7cTh5Ls9cFXddR4PJtoTgFav69EjZZYSJALM=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=R+yEHs9JS/DtCHxhnTIxOAFQtk3j9RwwNom7mUwgLsfu0+nNf++XKawiSSu+G+To4
         j0QwfmgAAGoSrJdKhVln+R+/5j3IBP97NWJrb+XLs5+xniOoH4YqXKFUJpnrkZc7T6
         pli8m7a3yIuuXlkz740+vN447/n5suPIzQ/NTeJ0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210916111534eucas1p167eb21fe292147bc6c99939372e65309~lSTWmkj613218432184eucas1p1D;
        Thu, 16 Sep 2021 11:15:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E9.A3.45756.65723416; Thu, 16
        Sep 2021 12:15:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210916111534eucas1p21dc35b47d2540e26f4d1ad262840fdd1~lSTV7EJ8i2816728167eucas1p2m;
        Thu, 16 Sep 2021 11:15:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210916111534eusmtrp1d6fdffb8f58172bad6de80cce0e57d3a~lSTV6HM1o1455514555eusmtrp1K;
        Thu, 16 Sep 2021 11:15:34 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-bf-614327560678
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.84.31287.55723416; Thu, 16
        Sep 2021 12:15:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210916111533eusmtip1342e6688169fe7baed3ef9e7b5cc7cfb~lSTVJDeLS2104121041eusmtip1O;
        Thu, 16 Sep 2021 11:15:33 +0000 (GMT)
Subject: Re: (subset) [PATCH v2 4/4] ARM: dts: exynos: align PPMU event node
 names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9ed20f4b-ca45-54d3-2577-976a9e55eb9d@samsung.com>
Date:   Thu, 16 Sep 2021 13:15:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <163169222223.16372.15525688455985156121.b4-ty@canonical.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7ph6s6JBq0NWhbXvzxntZh/5Byr
        xca3P5gszja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PFwqYWdovbjSvYLFr3HmF34PZYM28N
        o8eshl42j02rOtk8Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mznlr2QoOslY0HJ7E
        1MC4gaWLkZNDQsBE4m5PD1MXIxeHkMAKRokzV1cwQjhfGCWmnl/JCuF8ZpTY3vGGHable9Ny
        ZojEcqDElBdsEM5HRokDG9Yyg1QJCyRJ7J5zHaxKRGAhs8SvuV/A2tkEDCW63naxgdi8AnYS
        He8OM4LYLAKqEr83fWUCsUUFkiWm/W1ihqgRlDg58wnYtZwCXhJHP+wGizMLyEtsfzsHyhaX
        uPVkPtgXEgIfOCT6fs1mgrjVReLxritsELawxKvjW6B+kJE4PbmHBaKhmVHi4bm17BBOD6PE
        5aYZjBBV1hJ3zv0C6uYAWqEpsX6XPkTYUWLPt53sIGEJAT6JG28FIY7gk5i0bTozRJhXoqNN
        CKJaTWLW8XVwaw9euMQMYXtIbG0/xzSBUXEWkjdnIXltFpLXZiHcsICRZRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZg4jr97/inHYxzX33UO8TIxMF4iFGCg1lJhPdCjWOiEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd5Vs9fECwmkJ5akZqemFqQWwWSZODilGpgkOE0YHhoFfHbzW/9u
        upup0AqX7Xox1nGTTT61VE6R3+qVd9fBtUR+7iK5J5J2JwU9OI8Y+3//kcZ7be07NWvNg4tr
        G0PTNr9QKw/hvXBZ97U319tjXNMjVyadEc6famvwLj40Qs5JlVF3x8525qX3/q11cxDtkPJo
        WF17MPdbbmxL89fzAh75OWtmqKy4XPJM+l6qdhXPOeGAU6kL3DVV3X7ZJLs/zD228seuIzk8
        V3u01weHZMw/tkfum16Te6jCG6VpK3Sj9xu3re6zWT193h2/U6lHzRryRB11uVzE1zLPSLU4
        t6QnLc+MsV/6b36hkK/8qXtWDUsZmrwcuQ9fC2bR3lUq5zstKWyFEktxRqKhFnNRcSIAX0E+
        rMsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7qh6s6JBlvWWlpc//Kc1WL+kXOs
        Fhvf/mCyONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWC5ta2C1uN65gs2jde4Tdgdtjzbw1
        jB6zGnrZPDat6mTz2Lyk3qNvyypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws
        9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyOuetZSs4yFrRcHgSUwPjBpYuRk4OCQETie9Ny5m7
        GLk4hASWMkqc2L2aFSIhI3FyWgOULSzx51oXG0TRe0aJH4/eM4EkhAWSJHbPuQ7WLSKwmFli
        zd9zTBBVM5kkOn8/AdvBJmAo0fUWpJ2Tg1fATqLj3WFGEJtFQFXi96avYJNEBZIl3r7+zgRR
        IyhxciZEL6eAl8TRD7uZQWxmATOJeZsfQtnyEtvfzoGyxSVuPZnPNIFRcBaS9llIWmYhaZmF
        pGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwIjcduzn5h2M81591DvEyMTBeIhRgoNZ
        SYT3Qo1johBvSmJlVWpRfnxRaU5q8SFGU6B/JjJLiSbnA1NCXkm8oZmBqaGJmaWBqaWZsZI4
        79a5a+KFBNITS1KzU1MLUotg+pg4OKUamAwiHN9sLxD7v9b053a9C1tn+797dKJjkf0xhnN6
        MZklG5LONEsq1uxtapm4v+em55Rru6cvWP5BatOi7zNmGQRuYzcT6DZ5f+X9cRvL9qjEB4sz
        mzP2Pf8tuSDiLtdKT8uZp6P/MP/ivnPz8PugbKbPqsq9pcHuqxgOMerM4az8o/h23obm1Osh
        2gtcVGNCtNryM/49NOZLX+Z261C69qVVi+2tWponaTX2nzfvOL4sqkh7eqqQXfTOvW879x54
        NmV9cP3Wn4lXHJ53P1n353fJc1E271qD+95KBh/vlIZa12y5mZ6z2ya+IkHvzEWbEw8tG26v
        TvR7N8U+6erhOl2j2oIzrnM7PSPjjq+sW6LEUpyRaKjFXFScCABJec0HUQMAAA==
X-CMS-MailID: 20210916111534eucas1p21dc35b47d2540e26f4d1ad262840fdd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210915075117eucas1p11e3c07d77f1f0dc43c9e4685665eb494
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210915075117eucas1p11e3c07d77f1f0dc43c9e4685665eb494
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com>
        <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
        <CGME20210915075117eucas1p11e3c07d77f1f0dc43c9e4685665eb494@eucas1p1.samsung.com>
        <163169222223.16372.15525688455985156121.b4-ty@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 15.09.2021 09:50, Krzysztof Kozlowski wrote:
> On Fri, 20 Aug 2021 17:03:53 +0200, Krzysztof Kozlowski wrote:
>> Use hyphen instead of underscore and align the PPMU event node name with
>> dtschema.
>>
>>
> Applied, thanks!
>
> [4/4] ARM: dts: exynos: align PPMU event node names with dtschema
>        commit: fb9b199e562d66af90f61d70eb737fa5e4deac2c
>
This breaks probing of Exynos event counters, which are needed by the 
Exynos DMC driver on Odroid XU3/XU4/HC1 boards. Just check the today's 
linux-next. I had no time to analyze which part of the code depends on 
the node names though...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

