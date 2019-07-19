Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5546E7C0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfGSPGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:06:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40823 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfGSPF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 11:05:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719150554euoutp0223983a76b0353c584efddf538259915c~y107-xRnY1490214902euoutp02E
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 15:05:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719150554euoutp0223983a76b0353c584efddf538259915c~y107-xRnY1490214902euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563548754;
        bh=jeFX2U5pvynczFNKiJiwvxKE4yjad+CXSaSviMj87sw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XaVUGanpO46EAY82NJfM7ylne9GEl+QF/1Yt+3aJPa7ssraj4Dca28gfSsiGQ2TXq
         wAqc3IB5IWwJYi6LTVlTqr0zTV4Qe+XIrQaPRS7LzUGs1+MfEDBFj9HmFeX2NRuPVg
         78SJaGGqGpC12os87ATsI5p5JaIgoEhHwElXk6kQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190719150553eucas1p1cc26e201dfcc1e9767f995a4a85353a9~y107GI5Ir0634306343eucas1p14;
        Fri, 19 Jul 2019 15:05:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.09.04377.15CD13D5; Fri, 19
        Jul 2019 16:05:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150553eucas1p142b965afae13224712d51f9c28162165~y106ROdDH3032530325eucas1p1t;
        Fri, 19 Jul 2019 15:05:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719150552eusmtrp26e77e72562961e85c1ebe460b9bdbddf~y106AU4Iz3114831148eusmtrp28;
        Fri, 19 Jul 2019 15:05:52 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-71-5d31dc51d88f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.F6.04140.05CD13D5; Fri, 19
        Jul 2019 16:05:52 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150551eusmtip13b1975a61126609daf2c674be6794fda~y105N_wS72820728207eusmtip1i;
        Fri, 19 Jul 2019 15:05:51 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
Subject: [PATCH v3 0/5] add coupled regulators for Exynos5422/5800
Date:   Fri, 19 Jul 2019 17:05:30 +0200
Message-Id: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87qBdwxjDSZ91LTYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAldF0aRdLwT3+ilW9L1kbGNfwdDFyckgI
        mEhMaDvHCmILCaxglFj+jL2LkQvI/sIosfPVcSjnM6PEpPs7gRwOsI7FS3wg4ssZJS48f8sG
        17HpXw8jyCg2AVWJLTNesoPYIgLKEpPvTWcGKWIW+MkiseHyRrCEsICTxIujy8F2swA17P/e
        zAJi8wq4SOz4eYoF4j55ic4du6HighInZz4Bs5mB4s1bZ4MNlRC4xi6xpWsXK0QDUPPZtewQ
        trDEq+NboGwZif875zNB2OUSTxf2sUM0tzBKPGj/CLXNWuLw8YusIH8yC2hKrN+lDxF2lHhw
        fhsTxPt8EjfeCkLcwCcxaRvIYyBhXomONiGIal2Jef/PQF0jLdH1fx2U7SFx4vElZkhQx0rM
        2XeBcQKjwiwkn81C8tkshBsWMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEx1p/8d
        /7KDcdefpEOMAhyMSjy8H24ZxgqxJpYVV+YeYpTgYFYS4b39Uj9WiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+NUzUKmpen75bbttjnCKfHjVGpvxv+W
        maFKeatZIvwMD2gFfedr2J3AZfD0SDaLWUB4hegx917G+kNXq5weL9OJPrYubPKrCRtr1baw
        vLcu/Dcl3/FRaG+6TKGJ5CUmCw3VNJ+Jf2V+5wY91Lhnob/kp3jx5lkSG7h6tGct+v1TM7sh
        IOZZuRJLcUaioRZzUXEiAGIVwbtxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oBdwxjDZrPa1lsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy2i6tIul4B5/xarel6wNjGt4uhg5OCQETCQWL/HpYuTiEBJYyihxfecJ
        li5GTqC4tETj6dVMELawxJ9rXWwQRZ8YJRrmfGMGSbAJqEpsmfGSHcQWEVCWmHxvOjNIEbNA
        J6vEiidH2EASwgJOEi+OLmcFsVmAGvZ/bwbbwCvgIrHj5ymobfISnTt2Q8UFJU7OfAJmMwPF
        m7fOZp7AyDcLSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgVG27djPLTsYu94F
        H2IU4GBU4uH9cMswVog1say4MvcQowQHs5II7+2X+rFCvCmJlVWpRfnxRaU5qcWHGE2Bjp3I
        LCWanA9MAHkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhnLTl7
        KKrkvcezz663f8dIP7kstDFUKqzHUunNJ21PBmsx5g6LfwkTYn5VPpznfHhzjMCMyW6vMqJK
        5vp1vFc5ovj8TN/MyuSz228qaD/KvJjWsHfSu5eb3bZMZtTWmyYfvGpt3wzRw/ku2jJfNxrL
        Myi6bN58rpb9wNyeRze2r9JWOieZ3laoxFKckWioxVxUnAgAUdvfXsgCAAA=
X-CMS-MailID: 20190719150553eucas1p142b965afae13224712d51f9c28162165
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150553eucas1p142b965afae13224712d51f9c28162165
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150553eucas1p142b965afae13224712d51f9c28162165
References: <CGME20190719150553eucas1p142b965afae13224712d51f9c28162165@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The main purpose of this patch series is to add coupled regulators for
Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
and vdd_int to be at most 300mV. In exynos-bus instead of using
regulator_set_voltage_tol() with default voltage tolerance it should be
used regulator_set_voltage_triplet() with volatege range, and this is
already present in opp/core.c code, so it can be reused. While at this,
move setting regulators into opp/core.

This patchset was tested on Odroid XU3.

The DTS coupled regulators patch depends on 2nd and 3rd patches.

Changes:
v3:
- added new exynos-bus patch to correct clock and regulator enabling
  and disabling sequence as suggested by Chanwoo Choi
- corrected error path in enable and improved commit message in opp/core
- improve comment in devfreq/exynos-bus.c before devfreq_recommended_opp()
- change cover letter as there is new patch
- added note before Signed-off-by in 4th patch
v2:
- improve regulators enable/disable code in opp/core as suggested by
  Viresh Kumar
- add new patch for remove unused dt-bindings as suggested by Krzysztof
  Kozlowski

Regards,
Kamil

Kamil Konieczny (4):
  devfreq: exynos-bus: correct clock enable sequence
  opp: core: add regulators enable and disable
  devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
  dt-bindings: devfreq: exynos-bus: remove unused property

Marek Szyprowski (1):
  ARM: dts: exynos: add initial data for coupled regulators for
    Exynos5422/5800

 .../bindings/devfreq/exynos-bus.txt           |   2 -
 arch/arm/boot/dts/exynos5420.dtsi             |  34 ++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   4 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   4 +
 arch/arm/boot/dts/exynos5800.dtsi             |  32 ++--
 drivers/devfreq/exynos-bus.c                  | 181 ++++++------------
 drivers/opp/core.c                            |  16 +-
 7 files changed, 113 insertions(+), 160 deletions(-)

-- 
2.22.0

