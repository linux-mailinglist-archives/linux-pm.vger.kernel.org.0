Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617A0AEA85
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393186AbfIJMgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 08:36:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46882 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbfIJMgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 08:36:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190910123633euoutp02691c7221e143b2eaa53a95b00ef62309~DE_qZ_UJf2682226822euoutp02O
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 12:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190910123633euoutp02691c7221e143b2eaa53a95b00ef62309~DE_qZ_UJf2682226822euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568118993;
        bh=Y/Kc6dTFeZXSi1OU5HZ66ZaTvZPyLltmtT+e/meu6CQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IkX4WY2MHFWldqO89EG+KsyWnF/l5US8PzEjYXxo12WFEdD5Bhz8629ksfs82DaUp
         LUq4GtBodJz+jkq+13Ds/S2JrFN4NLTRK0zcx1s16mrLuPFb6E3uUbNOedWiPbw+Fw
         br45l4cAO9m63YM/ykO7+QPnxSGLCzcQTSeAsDZI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190910123632eucas1p204ae2b6459bad41ae6d5a6032ad2f6a7~DE_poiKqD0844108441eucas1p2H;
        Tue, 10 Sep 2019 12:36:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F1.8B.04374.0D8977D5; Tue, 10
        Sep 2019 13:36:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190910123632eucas1p2cf941da5f74b892288dd5a92ff9fa9fb~DE_o_TGAD0226902269eucas1p2u;
        Tue, 10 Sep 2019 12:36:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910123631eusmtrp1ec363668d5068fd68bd2798fbafd2fda~DE_ovnGnY2381323813eusmtrp1i;
        Tue, 10 Sep 2019 12:36:31 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-c5-5d7798d0070e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.EC.04117.FC8977D5; Tue, 10
        Sep 2019 13:36:31 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123631eusmtip1be90af00cacb443319582d0e111d67a3~DE_oJ5Org1089210892eusmtip1Q;
        Tue, 10 Sep 2019 12:36:31 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org
Cc:     robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4 0/6] Exynos Adaptive Supply Voltage support
Date:   Tue, 10 Sep 2019 14:36:12 +0200
Message-Id: <20190910123618.27985-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned0LM8pjDU6ul7PYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y27RuvcIu8XhN+2sFpsfHGNz
        4PHYtKqTzWPzknqPvi2rGD0+b5ILYInisklJzcksSy3St0vgypj4+jpzwSqRiu23cxoY3/J3
        MXJwSAiYSHw4Ud7FyMUhJLCCUaJ9524WCOcLo8Tpf1uZIJzPjBJ9nQdYuxg5wTpervrDBpFY
        ziixru8XK1zLivYl7CBVbAKGEr1H+xhBbBEBdYlXp/4zgxQxC6xjklg2axkjyHJhATuJNa1g
        U1kEVCU+333NBmLzClhLHN58jxFim7zE6g0HwHolBD6zSUx5+BjqDBeJ5R8XMEHYwhKvjm9h
        h7BlJE5P7mGBaGhmlOjZfZsdwpnAKHH/+AKosUArjl9kBbmCWUBTYv0ufYiwo8TpC5fYICHD
        J3HjrSBImBnInLRtOjNEmFeio00IolpF4veq6VAnSEl0P/nPAmF7SKyZcRNsuJBArMTPCx4T
        GOVmIaxawMi4ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzBdnP53/OsOxn1/kg4xCnAw
        KvHwdrSUxwqxJpYVV+YeYpTgYFYS4b3eVxorxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0
        kEB6YklqdmpqQWoRTJaJg1OqgVF7ZpHmp3UVpnMS7BdufMop/FBkzrTl+xZtzuJNtL1zSn3R
        1tdL5vVmB3YWzc5NVDvEFtwfFigdIMR4wnzduRKpzTWVx0v5JrsVTkgwEk5fzMFh4OXPoPbx
        sMiVrfmrOBK3Gtzjfn/5ZYRbnL70hb5DZ5l325+tSCwNKReZvek0u/fGwpBppUosxRmJhlrM
        RcWJAFF2MOcTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xu7rnZ5THGjx/rGWxccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5eglzHx9XXmglUiFdtv5zQwvuXvYuTkkBAwkXi56g9bFyMXh5DA
        UkaJ572v2bsYOYASUhLzW5QgaoQl/lzrgqr5xChx6+B0RpAEm4ChRO/RPkaQehEBTYm968Bq
        mAV2MEnsffaXDSQuLGAnsaaVFaScRUBV4vPd12wgNq+AtcThzfcYIebLS6zecIB5AiPPAkaG
        VYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFBuu3Yzy07GLveBR9iFOBgVOLh7WgpjxViTSwr
        rsw9xCjBwawkwnu9rzRWiDclsbIqtSg/vqg0J7X4EKMp0PKJzFKiyfnACMoriTc0NTS3sDQ0
        NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBYYHrhufLnaU1NJXv8WB6LFFtv77nO
        Lrp22fXUZevjX19+LJnfrs8jL8w651HxsghzKyG5tXvvS056FrPr/wGxXXYb05uOTU3KFj0w
        Z3HPbo2GTc/fdshO8149Z4fE1L+971f2qH2SXyjM/SeTSyvo5S3D6AChxysuhMWsn2t6f82T
        CqdYBnsRJZbijERDLeai4kQAv6VF22gCAAA=
X-CMS-MailID: 20190910123632eucas1p2cf941da5f74b892288dd5a92ff9fa9fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123632eucas1p2cf941da5f74b892288dd5a92ff9fa9fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123632eucas1p2cf941da5f74b892288dd5a92ff9fa9fb
References: <CGME20190910123632eucas1p2cf941da5f74b892288dd5a92ff9fa9fb@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is fourth iteration of my patch series adding ASV (Adaptive Supply 
Voltage) support for Exynos SoCs. The previous one can be found at:
https://lkml.org/lkml/2019/8/13/808

Major change since v3 is a conversion to use dev_pm_opp_adjust_voltage(),
rather than removing and adding an OPP again. Hence the series now 
depends on patch [1].

I have included here a patch to address review comments
"opp: Handle target/min/max voltage in dev_pm_opp_adjust_voltage()",
which could be squashed with patch [1].

The CHIPID patches are dropped from the series as they have already 
been merged.

The patch set is based on for-next branch, 
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git

Tested on Odroid XU3, XU3 Lite, XU4.

One of the things on TODO list is support for the Adaptive Body Bias.
This would require modifications on the cpufreq driver side in order 
to support multiple voltage regulators as well as changes in the OPP 
framework to support adding OPPs with multiple voltages.

[1] "[v4, 6/8] PM / OPP: Support adjusting OPP voltages at runtime"
    https://lore.kernel.org/linux-arm-kernel/1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com

Sylwester Nawrocki (6):
  opp: Handle target/min/max voltage in dev_pm_opp_adjust_voltage()
  dt-bindings: samsung: Update the CHIP ID binding documentation
  soc: samsung: Add Exynos Adaptive Supply Voltage driver
  ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS
  ARM: dts: Add "syscon" compatible string to chipid node
  ARM: dts: Add samsung,asv-bin property for odroidxu3-lite

 .../bindings/arm/samsung/exynos-chipid.txt    |  10 +-
 arch/arm/boot/dts/exynos5.dtsi                |   4 +-
 .../boot/dts/exynos5422-odroidxu3-lite.dts    |   4 +
 arch/arm/mach-exynos/Kconfig                  |   1 +
 drivers/opp/core.c                            |  10 +-
 drivers/soc/samsung/Kconfig                   |  10 +
 drivers/soc/samsung/Makefile                  |   3 +
 drivers/soc/samsung/exynos-asv.c              | 179 ++++++
 drivers/soc/samsung/exynos-asv.h              |  82 +++
 drivers/soc/samsung/exynos5422-asv.c          | 509 ++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h          |  25 +
 include/linux/pm_opp.h                        |   3 +-
 12 files changed, 833 insertions(+), 7 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h

-- 
2.17.1

