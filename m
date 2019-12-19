Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7599125CAB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLSI3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 03:29:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43241 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfLSI3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 03:29:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219082939euoutp02f1afb7313d01fa797d528d8f2c9941fc~huHo5cQiE1763617636euoutp02M
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219082939euoutp02f1afb7313d01fa797d528d8f2c9941fc~huHo5cQiE1763617636euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576744179;
        bh=p1LIywHdkTfZ+S5wtThg7HFbv2fxoOEzXYDi6tOWudg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Nrb8jpMxC/8aqwaDcs2XH0MdMRxmmeeXg3m7w4p+EBLrP5y9L6YJZvN+OK3+2YhXN
         xfRvQN+1Nq1p39xIC68NrFjk23j3NfepmqCksqwyDrMTbU3DztB0Sazjk66rmVt8Mh
         aKh4HI8ae8eUtSD3HN7SgDkEq10gXuPXVw5u4OKs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191219082939eucas1p2adfb349fccfb175b858efbb4ea00a7b6~huHosPOb42046820468eucas1p2L;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.46.60698.3F43BFD5; Thu, 19
        Dec 2019 08:29:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191219082938eucas1p254fe738574f287a44630d5a7eef7385e~huHoJllW10073900739eucas1p2N;
        Thu, 19 Dec 2019 08:29:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219082938eusmtrp1e297cafe3cecfac39afde0375947b5dc~huHoI76Dq0048200482eusmtrp1t;
        Thu, 19 Dec 2019 08:29:38 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-48-5dfb34f3d64c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.F6.08375.2F43BFD5; Thu, 19
        Dec 2019 08:29:38 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219082938eusmtip1cc3e16352662dbd35a1a57b5395ea20d~huHnvx4cH1676616766eusmtip1F;
        Thu, 19 Dec 2019 08:29:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] Exynos5422: fix bus related OPPs for Odroid XU3/XU4/HC1
Date:   Thu, 19 Dec 2019 09:29:25 +0100
Message-Id: <20191219082927.11898-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djP87qfTX7HGjStELbYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZ27YvZy04w1+xbuZFxgbGCzxdjJwcEgImEte2nGXrYuTiEBJYwSix9/Bx
        dgjnC6PEy69HmSGcz4wSmyY9YoJpOXHwKlTVckaJXwduMMK1zLmxkRmkik3AUKLrbRcbiC0i
        EC/xqP8uC0gRs8BjRonj/06BjRIW8JGY9uQvWBGLgKrE+ouXwWxeAVuJuU/7WSDWyUus3nAA
        7A4JgTNsEod+PWGFSLhIvGraywZhC0u8Or6FHcKWkTg9uYcFoqGZUeLhubXsEE4Po8TlphmM
        EFXWEoePXwSaxAF0k6bE+l36EGFHiWu72tlBwhICfBI33gqChJmBzEnbpjNDhHklOtqEIKrV
        JGYdXwe39uCFS1AlHhIf95SBhIUEYiW6j39hm8AoNwth1QJGxlWM4qmlxbnpqcXGeanlesWJ
        ucWleel6yfm5mxiBSeD0v+NfdzDu+5N0iFGAg1GJh/eH669YIdbEsuLK3EOMEhzMSiK8tzt+
        xgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAaNqa/Crh
        h/j5047cn19fkebO0qutYl7HK/z774kf2qJhTg2VbHd5xCOFknILK/zzbsyepFD78a34xc36
        FQqfjT96N8Zd/870cPujWvWyWzP9GFZP/MfjuLV+kad4v8ej/XMEnRTuuDDM+PIv7evtz8IH
        uMqicy9Yrua10HX+eviTicmrDyLeSizFGYmGWsxFxYkAzeRfX/4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xu7qfTH7HGvTtMLDYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ27YvZy04
        w1+xbuZFxgbGCzxdjJwcEgImEicOXmUHsYUEljJK3FpeCxGXkTg5rYEVwhaW+HOti62LkQuo
        5hOjxKmuL0wgCTYBQ4mutyAJTg4RgUSJ2R9ngxUxCzxllFi1ZgpYt7CAj8S0J3/BilgEVCXW
        X7wMZvMK2ErMfdrPArFBXmL1hgPMExh5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM
        vW3Hfm7ewXhpY/AhRgEORiUe3h+uv2KFWBPLiitzDzFKcDArifDe7vgZK8SbklhZlVqUH19U
        mpNafIjRFGj5RGYp0eR8YFzklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLp
        Y+LglGpgjDwTX11zVzBgU6LNy54gx9YzD5xjUnXXeQh7Vp7Ye2/tiq6jDyS6StMOGzHn3bh8
        c+qzwvLPchWehktND/3gv8toM+vwZ62NiU2tktmXL2xfGzIxdVKIwx1D6eMzGcO2sUluu8HB
        6WVxOvRA02/markLQbUHmzPcH/MxX2ZttG1Mv7Cu0+KIEktxRqKhFnNRcSIAFfCIDlMCAAA=
X-CMS-MailID: 20191219082938eucas1p254fe738574f287a44630d5a7eef7385e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219082938eucas1p254fe738574f287a44630d5a7eef7385e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219082938eucas1p254fe738574f287a44630d5a7eef7385e
References: <CGME20191219082938eucas1p254fe738574f287a44630d5a7eef7385e@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear All,

Currently the only Exynos5422-based boards that support bus frequency
scaling are Hardkernel's Odroid XU3/XU4/HC1. The recent changes in the
devfreq framework revealed that some operating points for the defined
busses cannot be applied, because the rates defined in the OPPs cannot
be derived from the top PLL clocks (due to lack of common integer
dividers). This issue has been first noticed by Lukasz Luba in:
https://lkml.org/lkml/2019/7/15/276

To use the rates currently defined in the OPPs, one would need to change
the rate and the topology of the top PLL clocks. The best place for such
operation is the bootloader, because later when kernel boots, more and
more devices (like UART, MMC, and so on) are enabled and get the clocks
from those top PLLs. Changing the rate of the clock for the already
enabled/operating device is very tricky.

To avoid that issue I've decided to keep the current top PLL clocks
configuration prepared by the bootloader on Odroid XU3/XU4/HC1 boards and
adjust the OPPs for it. This means that the bus related OPPs are board
dependant, so I've moved the to the respective DTS files. For other
boards (for example Peach Pi/Pit Chromebooks), slightly different OPPs
might need to be defined due to different clock topology and top PLLs
rates configured by their bootloader.

The provided approach is probably the simplest fix to let all busses
operate on the highest possible speeds, which match the configuration
applied initially by the bootloader.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  ARM: dts: exynos: Move bus related OPPs to the boards DTS
  ARM: dts: exynos: Adjust bus related OPPs to the values correct for
    Odroids

 arch/arm/boot/dts/exynos5420.dtsi             | 259 ----------------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 276 +++++++++++++++++-
 2 files changed, 275 insertions(+), 260 deletions(-)

-- 
2.17.1

