Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E153284D9D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbfHGNjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 09:39:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58122 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbfHGNi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 09:38:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190807133857euoutp0145df3489600099fd292f9355922d8e75~4p5ccMtsq2498224982euoutp018
        for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2019 13:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190807133857euoutp0145df3489600099fd292f9355922d8e75~4p5ccMtsq2498224982euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565185138;
        bh=EmslgonStTRrL/u4P7UDkmcHxhjWmImBf/o0FvYqLms=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WQ2DUC/32VSo1KwDGi1q+kQuFkP+bYlB5kgPDRFUjpBbjF3GOaHbd3Y8M3hnKffoS
         hITqhtIq1lSh3ewezziW+aL1rB7g0vM6VE240GvDTd7V5ytK4mbl8k1J00PkvI/qCF
         mVlF75+rkMX0DAEyMHqJzW3dvJF2Q1Wxz4C+ITsU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807133857eucas1p2f55ef233cdb6008e414af50a35ceaee4~4p5bktSz61100111001eucas1p2M;
        Wed,  7 Aug 2019 13:38:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.F6.04374.074DA4D5; Wed,  7
        Aug 2019 14:38:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da~4p5amdPUC1968119681eucas1p1J;
        Wed,  7 Aug 2019 13:38:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190807133855eusmtrp144ac7bade6c0fb9ef41271cd4c3a5394~4p5aXxtZl3034030340eusmtrp1x;
        Wed,  7 Aug 2019 13:38:55 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-04-5d4ad470f051
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.AE.04166.F64DA4D5; Wed,  7
        Aug 2019 14:38:55 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133854eusmtip239525b74c72cfe59383812ea79a8ef1a~4p5ZqloQ71919719197eusmtip2b;
        Wed,  7 Aug 2019 13:38:54 +0000 (GMT)
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
Subject: [PATCH v5 0/4] add coupled regulators for Exynos5422/5800
Date:   Wed,  7 Aug 2019 15:38:34 +0200
Message-Id: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7oFV7xiDS6c1rLYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlfHgwTWWgqXCFVdbVrE2MB7h72Lk5JAQ
        MJFYtuIpYxcjF4eQwApGiUObTjCCJIQEvjBKtPwOg0h8ZpR40DoHKMEB1rHkEBdEfDmjxPfN
        i9ghHKCG2y/OsYJ0swmoSmyZ8ZIdxBYRUJaYfG86M0gRs8BPFokNlzeCJYQFnCTW7HzGBmKz
        ADVMWHMcbDWvgIvE9C/LWCDuk5fo3LGbBSIuKHFy5hMwmxko3rx1NthQCYFr7BK3Zq1mg2hw
        kdj+4iJUs7DEq+Nb2CFsGYnTk3ug4uUSTxf2sUM0twD91v4RKmEtcfj4RVaQP5kFNCXW79KH
        CDtK7Dm2hBXifT6JG28FIW7gk5i0DeQxkDCvREebEES1rsS8/2dYIWxpia7/66BsD4nPvWeh
        oRsrce9bB8sERoVZSD6bheSzWQg3LGBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGY
        6k7/O/51B+O+P0mHGAU4GJV4eBkueMUKsSaWFVfmHmKU4GBWEuG9V+YZK8SbklhZlVqUH19U
        mpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoFxo+Omk8+e8PcvbnB5pXjZqO35
        r9WzXzYZlX+LlL677dSi/1kH3k9fkLLX8Gfz0s/7/H6VaVqzvDTcWZURv2zr9dnmLR3fb7wS
        F47ysI30vfT8l9xTPaXiGpmayTorerYtTVILZC2z01dU2/LJfWJa8q2aBZG6np86au0/qp00
        Xi55fb3oGu+pSizFGYmGWsxFxYkA7/csynEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7r5V7xiDR436lhsnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy3jw4BpLwVLhiqstq1gbGI/wdzFycEgImEgsOcTVxcjFISSwlFFixduH
        zF2MnEBxaYnG06uZIGxhiT/Xutggij4xSlxcuQGsiE1AVWLLjJfsILaIgLLE5HvTmUGKmAU6
        WSVWPDnCBpIQFnCSWLPzGZjNAtQwYc1xRhCbV8BFYvqXZSwQG+QlOnfsZoGIC0qcnPkEzGYG
        ijdvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjbNuxn5t3MF7a
        GHyIUYCDUYmHl+GCV6wQa2JZcWXuIUYJDmYlEd57ZZ6xQrwpiZVVqUX58UWlOanFhxhNgY6d
        yCwlmpwPTAB5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY2SZm
        /ODl8XX57H+SoUyEN7Sk12DpcrEsvls+J9mSHSqmT/rtsz3Au3CX55oplYrCvLvnOu1ztrOa
        cdyD9f3ElaxV51LuLQo73rhkgjZf2oKcaxJ+GprlwXF5t/M+i85r5lg54ePlNb8vJMz7H/hj
        nsKF6ax3vzg8nWa0uGjZ+sliEfuWvjobosRSnJFoqMVcVJwIADSoXbPIAgAA
X-CMS-MailID: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
References: <CGME20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da@eucas1p1.samsung.com>
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

The DTS coupled regulators patch depends on previous patches.

Changes:
v5:
- squashed last patch "remove exynos_bus_passive_target()" into second
- added Acked-by to patch "correct clock enable sequence"
v4:
- removed "opp: core: add regulators enable and disable" from patchset
  as it was applied by Viresh Kumar and changed cover letter
- fix patch "devfreq: exynos-bus: correct clock enable sequence" to
  correct order of enable/disable
- removed unrelated changes in "devfreq: exynos-bus: convert to use
  dev_pm_opp_set_rate()"
- added new patch "devfreq: exynos-bus: remove exynos_bus_passive_target()"
  as suggested by Chanwoo Choi
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

Kamil Konieczny (3):
  devfreq: exynos-bus: correct clock enable sequence
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
 drivers/devfreq/exynos-bus.c                  | 153 +++++-------------
 6 files changed, 78 insertions(+), 151 deletions(-)

-- 
2.22.0

