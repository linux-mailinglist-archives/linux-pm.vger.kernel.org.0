Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3206CFBD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbfGRObV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:31:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34933 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfGRObU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143119euoutp01fe6054b01450212ab070a14dcce7bb44~yhtcuZ6VD1278312783euoutp01I
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718143119euoutp01fe6054b01450212ab070a14dcce7bb44~yhtcuZ6VD1278312783euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460279;
        bh=lD6bLpANu+5ltBJVIOr0PCIM8ELkyvdZoAaHhN8C3Jg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=S0DfXUlAgSWSm/GLBRG0xUgm8Cpf20zv1YldfDpk8h+c07xkFXU31NhNEe2XFm06J
         qMLdA4IY85DwIrBQ7UtXF/kipISXDvoc2Hy/hm8gYFe0OaBPd5zZV/aIMoRwIfaxUe
         M8+JUWUqXaGW85LE5b3oZi/f5Uv4a1XFL7OHxNDg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718143118eucas1p205fbd75b27b2c7eb53c2756ea866f6d4~yhtcBl5g-2850928509eucas1p2T;
        Thu, 18 Jul 2019 14:31:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AF.10.04325.6B2803D5; Thu, 18
        Jul 2019 15:31:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1~yhtbFH8gJ0452404524eucas1p1X;
        Thu, 18 Jul 2019 14:31:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718143117eusmtrp19ce23a7ee881378c77967c941689d7df~yhtbEkaf61897918979eusmtrp1t;
        Thu, 18 Jul 2019 14:31:17 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-a9-5d3082b68a85
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.2E.04146.5B2803D5; Thu, 18
        Jul 2019 15:31:17 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143116eusmtip184739922c1312cde680cce9e2904106b~yhtacPjzf0929109291eusmtip1j;
        Thu, 18 Jul 2019 14:31:16 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Date:   Thu, 18 Jul 2019 16:30:35 +0200
Message-Id: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned1tTQaxBr+3S1hsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdYtPULu0Xr3iPsFofftLNa
        bH5wjM2B12PTqk42j81L6j36tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEro6/hMlvBCvGKSW/f
        sTUwrhXqYuTkkBAwkfjVfpa1i5GLQ0hgBaPE/NsPmSCcL4wSbV+62CGcz4wSJz4tZoVpebrj
        F1RiOaNEx8bnLHAtDU1PWECq2AQMJXqP9jGC2CICwhL3li4H62AWuMckcfrpWSaQhLCAncT8
        BWvAGlgEVCUOtE8Cs3kFrCVunV7ECLFOXmL1hgPMIM0SAr/ZJDoP7YJKuEj87pnBAmELS7w6
        voUdwpaROD25hwWioZlRomf3bXYIZwKjxP3jC6C6rSUOH78I9BEH0E2aEut36UOEHSX6rhxh
        AglLCPBJ3HgrCBJmBjInbZvODBHmlehog4aeisTvVdOZIGwpie4n/6HO8ZCY+qwHbJGQQKzE
        oUn3WSYwys1C2LWAkXEVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYAI5/e/41x2M+/4k
        HWIU4GBU4uENyDWIFWJNLCuuzD3EKMHBrCTCe/ulfqwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxin+K7+K/89IKqqc3LD4osD/JeliEnuz2U4quFcx
        OvbyOPQu28q8Sbf0/68dT9Ju6a1MvzzV8VnNxwemfyap2+ZMPs32QCrK+NLOQ1vXe1Tc0s0L
        P7XQ4FFA4Isn3AvK7kzjn9hsEqgyNyxkdvvV1ZfMT5v0O2xM+CC4773krXmxJz4HSVTOf6zE
        UpyRaKjFXFScCAB9He85HAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xu7pbmwxiDVrXKVtsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdYtPULu0Xr3iPsFofftLNa
        bH5wjM2B12PTqk42j81L6j36tqxi9Pi8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo6/hMlvBCvGKSW/fsTUwrhXqYuTkkBAwkXi64xd7
        FyMXh5DAUkaJd2tfs3QxcgAlpCTmtyhB1AhL/LnWxQZR84lRYv70f4wgCTYBQ4neo31gtghQ
        0b2ly8EGMQu8YpK4Pe8/E0hCWMBOYv6CNSwgNouAqsSB9klgNq+AtcSt04sYITbIS6zecIB5
        AiPPAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFBu+3Yz807GC9tDD7EKMDBqMTDG5Br
        ECvEmlhWXJl7iFGCg1lJhPf2S/1YId6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDIyqvJN7Q
        1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj42q3x/J9laqVX3bOiy1Z
        GvbMh6uSa9El7em/Dh72mnprq2JIoQbTnLZnRvkLl77uUbR9oWTxNf7Zw+wTbYnrn98898LM
        5a70Wb5pahwnlRZuW2PS4drQc9Su5KLM4kuBaaaily30tHbqzFq1cd9hUVe7sC7hg8W3K2Uq
        tVj3fG933rKt50+yEktxRqKhFnNRcSIAdecUgHACAAA=
X-CMS-MailID: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is second iteration of patch series adding ASV (Adaptive Supply 
Voltage) support for Exynos SoCs. The first one can be found at:
https://lore.kernel.org/lkml/20190404171735.12815-1-s.nawrocki@samsung.com

The main changes comparing to the first (RFC) version are:
 - moving ASV data tables from DT to the driver,
 - converting the chipid and the ASV drivers to use regmap,
 - converting the ASV driver to proper platform driver.

I tried the opp-supported-hw bitmask approach as in the Qualcomm CPUFreq
DT bindings but it resulted in too many OPPs and DT nodes, around 200
per CPU cluster. So the ASV OPP tables are now in the ASV driver, as in
downstream kernels.  I might give it a try and restrucure these tables
to avoid data repetition.

This patch set includes Exynos CHIPID driver posted by Pankaj Dubey and
futher improved by Bartlomiej Zolnierkiewicz [1].

Tested on Odroid XU3, XU3 Lite, XU4.

One of the things on TODO list is support for the Adaptive Body Bias.
This will require modifications on the cpufreq driver side in order to 
support multiple voltage regulators and changes in the OPP framework 
to support adding OPPs with multiple voltages.

[1] https://lkml.org/lkml/2018/11/15/908

Pankaj Dubey (3):
  soc: samsung: Add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS

Sylwester Nawrocki (6):
  soc: samsung: Convert exynos-chipid driver to use the regmap API
  soc: samsung: Add Exynos Adaptive Supply Voltage driver
  ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS
  soc: samsung: Update the CHIP ID DT binding documentation
  ARM: dts: Add "syscon" compatible string to chipid node
  ARM: dts: Add samsung,asv-bin property for odroidxu3-lite

 .../bindings/arm/samsung/exynos-chipid.txt    |  10 +-
 arch/arm/boot/dts/exynos5.dtsi                |   4 +-
 .../boot/dts/exynos5422-odroidxu3-lite.dts    |   4 +
 arch/arm/mach-exynos/Kconfig                  |   2 +
 arch/arm64/Kconfig.platforms                  |   1 +
 drivers/soc/samsung/Kconfig                   |  16 +
 drivers/soc/samsung/Makefile                  |   5 +
 drivers/soc/samsung/exynos-asv.c              | 185 +++++++
 drivers/soc/samsung/exynos-asv.h              |  82 +++
 drivers/soc/samsung/exynos-chipid.c           | 104 ++++
 drivers/soc/samsung/exynos5422-asv.c          | 499 ++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h          |  25 +
 include/linux/soc/samsung/exynos-chipid.h     |  48 ++
 13 files changed, 981 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h
 create mode 100644 include/linux/soc/samsung/exynos-chipid.h

-- 
2.17.1

