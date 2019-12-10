Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDA11869F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJLku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:40:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44508 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJLki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:40:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191210114036euoutp01ab2919760ea335271a8bd1a172e6ad23~e-6ypbEzv1696816968euoutp01h
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191210114036euoutp01ab2919760ea335271a8bd1a172e6ad23~e-6ypbEzv1696816968euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575978036;
        bh=JtCJWwEi1CPoda3M+GLc9u0h5w24RpweKEwZL1HKZEk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I0EFpuvEazSmsGnyqKB56Ujf8phQCvQlPTK22/2INI1xjM7ViOKqklRayZi9NJfbi
         Pz1PcQIQ6/6Jt+O6Tko40kxP+GADYgA1LlyS0JxZT/v7dYfmDis5q1U9SjAm20hp3P
         j3/BKtznqrR7V2zYql3BH1WjpIM19cux9Ya915CE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210114036eucas1p1b6c95c79043519d983936bd1bc3e8052~e-6yXYkw31996319963eucas1p1D;
        Tue, 10 Dec 2019 11:40:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.12.60679.4348FED5; Tue, 10
        Dec 2019 11:40:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28~e-6x2oviZ1762217622eucas1p2C;
        Tue, 10 Dec 2019 11:40:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210114035eusmtrp15b1aedd6a70c05ef76dce6c22634f581~e-6x1zXcX2588725887eusmtrp1Q;
        Tue, 10 Dec 2019 11:40:35 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-99-5def843473a6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.BF.08375.3348FED5; Tue, 10
        Dec 2019 11:40:35 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210114035eusmtip11301166fc8e654d698753be197bc39be~e-6xXZDBv2202322023eusmtip1C;
        Tue, 10 Dec 2019 11:40:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Andreas Faerber <afaerber@suse.de>,
        Arjun K V <arjun.kv@samsung.com>
Subject: [PATCH 0/2] Increase CPU frequency in Exynos5422/5800 SoCs
Date:   Tue, 10 Dec 2019 12:40:25 +0100
Message-Id: <20191210114027.14910-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOV2TlvexBj8fClg0byq2WL5yF4vF
        xhnrWS2uf3nOanF22UE2iwWfZrBanD+/gd3i8q45bBafe48wWsw4v4/JYu2Ru+wO3B6zGy6y
        eGxa1cnm0bdlFaPH5tPVHp83yQWwRnHZpKTmZJalFunbJXBlLDm8n71gE0/F2T9zWBsYG7i6
        GDk4JARMJFZcsO9i5OQQEljBKDH5I3sXIxeQ/YVRYn3PA1YI5zOjxJLtu1hBqkAabtzdyQKR
        WM4oceT6QRa4lsZlS9lBqtgEDCW63naxgdgiAvESj/rvghUxC1xikljS+B2sSFjAWeLZ5Pdg
        Y1kEVCXWvu9gArF5BWwlnrTNY4dYJy+xesMBZpBmCYH3bBInJrQyQyRcJH5veQJ1k7DEq+Nb
        oBpkJE5P7mGBaGhmlHh4bi07hNPDKHG5aQYjRJW1xOHjF1lBQcAsoCmxfpc+RNhRYt7em4yQ
        kOGTuPFWECTMDGRO2jadGSLMK9HRJgRRrSYx6/g6uLUHL1yCOs1DonXHP3ZIoMZKrH5+nW0C
        o9wshF0LGBlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaM0/+Of9nBuOtP0iFGAQ5G
        JR7eBQ7vYoVYE8uKK3MPMUpwMCuJ8B5vAwrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZI
        ID2xJDU7NbUgtQgmy8TBKdXA2N5Wm+GXH6S2uu/D2yfty2r0Q66w/S1ZdHL9jCrNf+uXP3ki
        tcoogLtxb8RC6Xsz3sx1P6A1746h1+y59rvLDs2Z2/6Kk2n+qZlry86XezF1LNPXtT++p33B
        BpHoq1fDTjp+cdiqKjtbX/JcYsNU7rM18U81a6pcCyb+k97XW3lhV/yqgmZvdiWW4oxEQy3m
        ouJEACIOCugUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xu7rGLe9jDa7e1bdo3lRssXzlLhaL
        jTPWs1pc//Kc1eLssoNsFgs+zWC1OH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kduD1mN1xk
        8di0qpPNo2/LKkaPzaerPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLWHJ4P3vBJp6Ks3/msDYwNnB1MXJySAiYSNy4u5Oli5GLQ0hg
        KaPE56uvmSASMhInpzWwQtjCEn+udbFBFH1ilFg9awo7SIJNwFCi6y1IgpNDRCBRYvbH2WBF
        zAI3mCQuvZ0DNklYwFni2eT3YJNYBFQl1r7vAIvzCthKPGmbxw6xQV5i9YYDzBMYeRYwMqxi
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIDNVtx35u3sF4aWPwIUYBDkYlHt4FDu9ihVgTy4or
        cw8xSnAwK4nwHm8DCvGmJFZWpRblxxeV5qQWH2I0BVo+kVlKNDkfGEd5JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYzVsdPfSdebk5uVPaIt+WbNaL/2L5161J
        x0L9/otn6j8O/2t5aMY3QVV+6QN97w8vllkta+NavmKxsdm6K8tPRy68959d+47akvn5cbPf
        f3BR2ZMqVrgn1G1WuIsEf+zHjeny6lnnGXQ8yxa9fuz04eTkDNdVOhMt49t3enz6tunGd55w
        3sUHlViKMxINtZiLihMBSCqCE2sCAAA=
X-CMS-MailID: 20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28
References: <CGME20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear All,

This patchset is a resurrection of the patch posted about 3 years ago:
https://patchwork.kernel.org/patch/9475909/

That time it was not possible to merge it, because a few minor pieces
were still missing in mainline kernel. This has been finally resolved
and there should be no blockers for adding the higher CPU frequencies
in Exynos5422/5800 SoCs:

1. support for coupled regulators (and all its dependencies) landed
   in the regulator framework and patch #1 adds needed coupling for
   the Exynos5422/5800 based boards;

2. support for the Exynos ASV has been merged to v5.4

Patches has been rebased onto the v5.5-rc1 kernel release. They were
tested on the following boards: Odroid XU3, XU3-lite, XU4, HC1 and
Chromebook Pi.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Bartlomiej Zolnierkiewicz (1):
  ARM: dts: exynos: Add missing CPU frequencies for Exynos5422/5800

Marek Szyprowski (1):
  ARM: dts: exynos: Add initial data for coupled regulators for
    Exynos5422/5800

 arch/arm/boot/dts/exynos5420.dtsi             | 34 ++++----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 64 +++++++--------
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 78 +++++++++----------
 .../boot/dts/exynos5422-odroidxu3-lite.dts    | 58 ++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 13 ++++
 arch/arm/boot/dts/exynos5800.dtsi             | 52 +++++++++----
 7 files changed, 199 insertions(+), 104 deletions(-)

-- 
2.17.1

