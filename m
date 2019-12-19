Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8101125FDE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSKvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 05:51:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40672 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLSKvi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 05:51:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219105137euoutp02cded1669fba0196f8c69399e1ef0011f~hwDlgkMl41382813828euoutp02W
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 10:51:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219105137euoutp02cded1669fba0196f8c69399e1ef0011f~hwDlgkMl41382813828euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576752697;
        bh=eKuqKqF6Zf3VdrfAJAAbhWfEQqEDS8o77momAoIwge4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K4fQ8rJXE+j4zn3E6RAlxmQpu1d6kpLCQMWbxcrPV47NVncw5h3bPO5xgaKYi6nnI
         T1R9Omk78BxiN7O5G3wyYAy5aBzYuL5y7RlX/69ovYJS+HIvsf5mFZBtFbcEZlRCyk
         h70yh1R5/OWLcdTao46rDQDjfUrMrw3shI8G8DAw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191219105136eucas1p2a7aab45ff8de7bf0ed48bc84916b6b58~hwDlRfY270600306003eucas1p2k;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.11.60679.8365BFD5; Thu, 19
        Dec 2019 10:51:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105135eucas1p1f11713cb6c1583524ca8af0ba6a7e145~hwDkQAGpl1661316613eucas1p1b;
        Thu, 19 Dec 2019 10:51:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219105135eusmtrp1cecbc3fba78d22939c10ef9197a2d641~hwDkPXBHd2881728817eusmtrp1C;
        Thu, 19 Dec 2019 10:51:35 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e3-5dfb56386993
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.BB.08375.7365BFD5; Thu, 19
        Dec 2019 10:51:35 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105135eusmtip1554bd1c13703f0f4a1ae647dc3e2d9a5~hwDjvWuoM0871308713eusmtip1c;
        Thu, 19 Dec 2019 10:51:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/2] Exynos5422: fix bus related OPPs for Odroid
 XU3/XU4/HC1
Date:   Thu, 19 Dec 2019 11:51:28 +0100
Message-Id: <20191219105130.29394-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djP87oWYb9jDXq6rCw2zljPanH9y3NW
        iwWfZrBanD+/gd3i8q45bBafe48wWsw4v4/JYu2Ru+wOHB6bVnWyefRtWcXo8XmTXABzFJdN
        SmpOZllqkb5dAlfGta6nLAXLBCsaz0xka2Bs5eti5OSQEDCR+PJpPlsXIxeHkMAKRokDE5cw
        QjhfGCU6fzSzgVQJCXxmlLi+xBum4/3B31Adyxklvk+9zAbXse9kKwtIFZuAoUTX2y6wbhGB
        eIlH/XdZQIqYBR4zShz/d4oJJCEsECjxe8F2VhCbRUBVYvOrx2BxXgFbiS/b7rJCrJOXWL3h
        ADNIs4TACTaJrQ8/QiVcJBqnPYCyhSVeHd/CDmHLSJye3MMC0dDMKPHw3Fp2CKeHUeJy0wxG
        iCpricPHLwJ1cwDdpCmxfpc+RNhR4tzOa4wgYQkBPokbbwVBwsxA5qRt05khwrwSHW1CENVq
        ErOOr4Nbe/DCJWYI20Ni7+cb7JCgi5VYtOof0wRGuVkIuxYwMq5iFE8tLc5NTy02ykst1ytO
        zC0uzUvXS87P3cQITAKn/x3/soNx15+kQ4wCHIxKPLw/XH/FCrEmlhVX5h5ilOBgVhLhvd3x
        M1aINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGxsVzFbRT
        PGJUI5WPq885NmGuclr67ieLd4QfPzJBaaoye8icJY+9L6+1fPjnq1npvaxdcir+c1jLjXiK
        Y823yP1uEn2c+P2l3SVtF42rH8KdvAQt1I7P5jWWqatR0Tz12Oy4+Lno9ebX5u5Ys9y4oDLv
        xSf1yZsjQ34c8KzY9UTjp8UvJ8fCVCWW4oxEQy3mouJEANflSS/+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xu7rmYb9jDRZ+1LfYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ17qeshQs
        E6xoPDORrYGxla+LkZNDQsBE4v3B32wgtpDAUkaJ9efLIeIyEienNbBC2MISf651AdVwAdV8
        YpT40fsULMEmYCjR9bYLrFlEIFFi9sfZYEXMAk8ZJVatmQJWJCzgL7HzykUwm0VAVWLzq8dM
        IDavgK3El213oTbIS6zecIB5AiPPAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGht+3Y
        z807GC9tDD7EKMDBqMTD+8P1V6wQa2JZcWXuIUYJDmYlEd7bHT9jhXhTEiurUovy44tKc1KL
        DzGaAi2fyCwlmpwPjIu8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2MluvTw198Sa5NXT1rlj13CGtCwQ7Gty9bNwu6mPIWLzhzu78gSL518jP2LUXvf9lHLaiR
        2PFrj1/45v6NU5bdXVx1NFxi3qebZrrzjxZpiD+8GhF+e4Xfphs3bmw1jz6Y3rZiKZdH8o83
        D1YZJX9iCNzv8DJ4Y+rCmhWf+ONW8R4WXfxo3xJ5RiWW4oxEQy3mouJEAJyJNLRTAgAA
X-CMS-MailID: 20191219105135eucas1p1f11713cb6c1583524ca8af0ba6a7e145
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219105135eucas1p1f11713cb6c1583524ca8af0ba6a7e145
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219105135eucas1p1f11713cb6c1583524ca8af0ba6a7e145
References: <CGME20191219105135eucas1p1f11713cb6c1583524ca8af0ba6a7e145@eucas1p1.samsung.com>
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


Changelog:

v2:
- removed incorrect 'opp-shared' property from bus_fsys_apb_opp_table
- renamed dmc opp table to opp_table17
- added tags

v1: https://patchwork.kernel.org/cover/11302803/
- initial version

Patch summary:

Marek Szyprowski (2):
  ARM: dts: exynos: Move bus related OPPs to the boards DTS
  ARM: dts: exynos: Adjust bus related OPPs to the values correct for
    Odroids

 arch/arm/boot/dts/exynos5420.dtsi             | 259 -----------------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 275 +++++++++++++++++-
 2 files changed, 274 insertions(+), 260 deletions(-)

-- 
2.17.1

