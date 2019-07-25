Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4847519C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfGYOoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:44:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41865 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGYOn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:43:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190725144325euoutp02819e1248d73d6ff8c215cdbd2800fc93~0rZBMCS3A1229012290euoutp02h
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 14:43:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190725144325euoutp02819e1248d73d6ff8c215cdbd2800fc93~0rZBMCS3A1229012290euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564065805;
        bh=fTxsTItMIO6fk/T/Y/JJ5cFwuR3QiqOaNKtLjYnGyLk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XRHtCxDONwi74D0Km6mjvW2+TKkaJgV9GypOJ3Y7l/mnPZLO7vL3zKluDnNl1ook0
         GtlgsM8YLDhXiMfUkfHQuH11FJ8VwJhN/N5/tSob+6TKmlMsgmCWt1L8+BIJWzH2mE
         dKhMnmer50Mq055wGlQBsvIFAyozpzOihVkGJiiM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190725144325eucas1p18cf1b48a38ea5edc5ca14cfb02667bd9~0rZAcUfzw0610606106eucas1p1q;
        Thu, 25 Jul 2019 14:43:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.CA.04377.C00C93D5; Thu, 25
        Jul 2019 15:43:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190725144324eucas1p211802237e336852ea3d1aa003e4d5d04~0rY-ufs-E1530115301eucas1p2j;
        Thu, 25 Jul 2019 14:43:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725144324eusmtrp1574d00d9799d7541f670120b75db0286~0rY-gBYh00712207122eusmtrp1g;
        Thu, 25 Jul 2019 14:43:24 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-8f-5d39c00c32a1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.2E.04146.B00C93D5; Thu, 25
        Jul 2019 15:43:24 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190725144323eusmtip1e5504cd19a90caef2209149ce0b9ebce~0rY_yRF4u0146301463eusmtip1j;
        Thu, 25 Jul 2019 14:43:23 +0000 (GMT)
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
Subject: [PATCH v4 0/5] add coupled regulators for Exynos5422/5800
Date:   Thu, 25 Jul 2019 16:42:55 +0200
Message-Id: <20190725144300.25014-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3d2do6y2XEKvmmYLYQM1OyCrxSieWFfhKg+dEFq5UElrzte
        WkGZZV5S08SczkwrUdRS5zWnZrqcZma2vBXmwPKSFpQL0sy17Vj57ff8n+f/8PzhITHhFG5P
        hkfF0dIoSYSIZ8lt7l0ecuV3eQXvvtnjjurltTga08/i6J76FY6yOw0A3ZpewNDQUB2BBpMX
        CaScHsWRtq2Yh5ay1ADJhzo56JF6kkDlY8Mc9P5qJQ8t/hzkoJQONYHWRuu5qEHXy/MRimtK
        aoBYWZXOEzc8vCJ+9rWdI85urAJizXgLR7ykdDxMnLQ8GEJHhCfQUnfvM5Zhmpx2ImZceKHk
        xxRIAimbM4AFCal9sHhghcgAlqSQqgRwoqmMwxZ6AJOGZzC2WAKwYuSXcYw0W7R9nqxeAaDq
        7Szxz5GiL8JNe3mUM2yUzxMmtqV2wLwPBeZNGLXMhXXaenPDhjoE07sqzcw1GuSK+5iJBZQ/
        VKkmAXvgNpjequKyujXsL/xoZsyoX2tSmJdCapSAfdV1HNbgD+UvvnNZtoGfNY0Ey1vhQF7m
        up4IP5VlE6z5OoC61G/rjQOwRzOMm3JilAusbXNnZV/4JDUNsPGt4PgXa/YGK3i72RTMJAtg
        2g0hO+0KSwwvcZYdYIbh8TqL4ZunqeaIQioY5j5YwHKAU9GGZEUbkhX9v6EUYFXAjo5nIkNp
        Zk8UnejGSCKZ+KhQt3PRkUpgfLuBNY2+FbStnu0GFAlEfMHOKq9gIS5JYGSR3QCSmMhW0NRq
        lAQhEtlFWhp9WhofQTPdwIHkiuwElzbpTgmpUEkcfZ6mY2jp3y6HtLBPAmEG/m+D7PiK1aw+
        JLVFI5d5xxUe6XZ4l6tyLF/NSppPqM7vcVHqBrUBPgOOFRkdBVZ+eHvu7POsEcrudUTm3MTl
        UmdRYFD2Xa2bYq9Hf/Sx5PhYBeXnELj9hDv/Du4tZ7aEBqliDUpyZF43l59T6Rl+NJjvu39U
        0d7l1DMTIOIyYRKPXZiUkfwBwuj3Z3IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7o8ByxjDRqeM1psnLGe1eL6l+es
        FvOPnGO16Nv3n9Gi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        LL1+kcniduMKNos3P84yWbTuPcJu8e/aRhaLzQ+OsTkIeayZt4bRY9OqTjaPzUvqPQ6+28Pk
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQyzg+YQ97wQ2hinlf7zM2MLbydzFycEgImEhcPmHexcjFISSwlFHiXesH
        9i5GTqC4tETj6dVMELawxJ9rXWwQRZ8YJS5NOc4KkmATUJXYMuMlWIOIgLLE5HvTmUGKmAU6
        WSVWPDnCBpIQFnCS6DywAqyIBahhxuxFzCA2r4CLxO7ddxkhNshLdO7YzQIRF5Q4OfMJmM0M
        FG/eOpt5AiPfLCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG2bZjPzfvYLy0
        MfgQowAHoxIP74XllrFCrIllxZW5hxglOJiVRHi37gAK8aYkVlalFuXHF5XmpBYfYjQFOnYi
        s5Rocj4wAeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCsl9/2
        TW4Ol888OwO/7MIHe5ikAwse71vZeG1xrSff/qAL8fO4f8hX+u7NOvvqtveL8wurWoTWHmg2
        DD9dutcp9ZJDE/Pp+qSLgraGanfVDolttZmebbKYkWeyN8s0dz6fgzsnPN83x+96+fWiv7Pn
        2VyakdnQYxW+lacj88ijYxoPHv2cELtPiaU4I9FQi7moOBEA3JUTeMgCAAA=
X-CMS-MailID: 20190725144324eucas1p211802237e336852ea3d1aa003e4d5d04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725144324eucas1p211802237e336852ea3d1aa003e4d5d04
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725144324eucas1p211802237e336852ea3d1aa003e4d5d04
References: <CGME20190725144324eucas1p211802237e336852ea3d1aa003e4d5d04@eucas1p2.samsung.com>
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

Kamil Konieczny (4):
  devfreq: exynos-bus: correct clock enable sequence
  devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
  dt-bindings: devfreq: exynos-bus: remove unused property
  devfreq: exynos-bus: remove exynos_bus_passive_target()

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

