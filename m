Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175D2A61D4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgKDKhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:37:32 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47614 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgKDKhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103719euoutp022a846f2c35fcd1162a20246286430501~ER7vMxnwk2967529675euoutp02P
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201104103719euoutp022a846f2c35fcd1162a20246286430501~ER7vMxnwk2967529675euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486239;
        bh=thak1VuiILQ9qLLBa+Eo4p8aVTr6CXxVj9tuUnboVls=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KPW4fO403x6NXybQ3+exCKLnU7iW7n06ufS3gmnuraXFfSOgGYVwch0AaK1/2Y06x
         ht6OlYTF5tt9o//L866kNSDTX7ihu5jc9CyGNCgSRnBFgnpP5WkbGl5CMefZ/UifiJ
         pN1C+TaRwnNWzOUbLTIkHw2W+Aws0Z4SHVpqGjeY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103713eucas1p1b379de904e02ab5a1e1d7ba1f03b02ad~ER7qRyPFU1357613576eucas1p1v;
        Wed,  4 Nov 2020 10:37:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.7F.06456.95482AF5; Wed,  4
        Nov 2020 10:37:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e~ER7p2CQG81145311453eucas1p2d;
        Wed,  4 Nov 2020 10:37:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103713eusmtrp12b68274578a64866f37f519a352e07b8~ER7p1Pkt70575105751eusmtrp16;
        Wed,  4 Nov 2020 10:37:13 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-ec-5fa284598647
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.75.06314.95482AF5; Wed,  4
        Nov 2020 10:37:13 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103712eusmtip2a7e64e22b4f6a8b6a1b63c7175319f8c~ER7pJJUCC1010110101eusmtip2g;
        Wed,  4 Nov 2020 10:37:12 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 0/7] Exynos: Simple QoS for exynos-bus using interconnect
Date:   Wed,  4 Nov 2020 11:36:50 +0100
Message-Id: <20201104103657.18007-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH+95z9zyPm+NxbD6RaldttIVbP/YtTWX+uJWt/qg/aNLJMxTH
        7ol+rJYmKr+GWi4piorD6HCk/Ng5nRgXmW5hajGj1OTHiJLz6Md/78/r+/58vu/Pd1+akPaK
        XOhI1VlWrVJGyUixUP9q3rwt8NqjEO/+aTkeepCE8DNNhQi/mx4V4Xxjlwj3znwjcU6DjsTZ
        Q5lCbDZXUlj3qU+E39bnkXgq3YiwxtwowOXGQQr3Xy0mcVKDkcItX66LsObWGLnfQaHT3iQV
        A30vScVQqkmgqCq6osio1iLFlG79ETJIvDeMjYqMZ9VevifFEU3dbwSxd9zPGxMSiQRUuDEF
        2dDA7IDF0SwyBYlpKVOMoL3oM8UX0wh6xudEVpeUmUKQbiH+dIxrOwS86SmC6pIi8m9HpaYC
        WV0kI4f01owV7cT4Q/LIA6HVRDA3CNDXZa+McmQCoN7StmyiaSGzBW4bva1YwvhAe3cjxd+2
        AUormwmeO8Dru8NCqyaWeWLNvdVE7ynIGl3La39oe56yyh1h3FS9OmcddNxKW8kATCKCtBf9
        FF9kIhgyFSDe5QMDXT9IayCC8YCKei8eH4Cm1jaBFQNjB5YJBz6DHWTrcwgeS+BGspR3b4YF
        bY6A1y6QOrwk5LUCHucPkvyDBsN9TRWViTbm/rdZ7n+b5f7LUIAILXJm47jocJaTq9hznpwy
        motThXueionWoeW/1vHL9L0OzfSEGhBDI5mtpFn/MEQqUsZzF6INCGhC5iTx6+w4IZWEKS9c
        ZNUxIeq4KJYzIFdaKHOWbH80FixlwpVn2TMsG8uq/5wKaBuXBFQu2JTsMWvcRYUb/I6YLLF5
        Y+naD575tjYo+/BlU1Bk2rFj7nP2XjrXhpHagIn+sksttm5y34LqyTU7i5tm5fGVqGohVRka
        dumd/+5a/R7dwcDFNHGYoR0lK+YtXbRdHHe0pvRjyaTef12Z/cVOt69Lp6ueHC/M+LkvoPPQ
        F2OATMhFKOVbCTWn/A16NRyQZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7qRLYviDZa/FbO4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7G/osXmAqmaVQcaWhmbmBcrNDFyMkhIWAi8WrVaaYuRi4OIYGljBKTznxk72LkAEpIScxv
        UYKoEZb4c62LDaLmE6PEwz2v2UASbAKGEr1H+xhBbBEBD4lTrWtZQWxmgRnMEqdnmYLYwgI+
        ErtunGAEmckioCox5YgBSJhXwFri1MV97BDz5SVWbzjADBEXlDg58wkLSDmzgLrE+nlCEBPl
        JZq3zmaewMg/C0nVLISqWUiqFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMvG3Hfm7e
        wXhpY/AhRgEORiUe3gPbFsYLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCj
        KdAHE5mlRJPzgUkhryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        owlf+DdRhkz9Pxv/8mr1r5/P98rk7Ysr67qkznHkd66p1O56zWLKX7tgyQ5+X2/dSZ/mX9V9
        4ej6+pO3iV7VpNkTS9K+tEn2fd7vw1OQLtj49Y1rSNteU7XCY2wLyk2eK5353yU791aBLw9X
        +h6F43MUdJXWxG/0fzV74X2vb+Vz+VtNDlxpVWIpzkg01GIuKk4EAKX2bjfSAgAA
X-CMS-MailID: 20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e
References: <CGME20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds interconnect API support for the Exynos SoC "samsung,
exynos-bus" compatible devices, which already have their corresponding
exynos-bus driver in the devfreq subsystem.  Complementing the devfreq
driver with an interconnect functionality allows to ensure the QoS
requirements of devices accessing the system memory (e.g. video processing
devices) are fulfilled and aallows to avoid issues like the one discussed
in thread [1].

This patch series adds implementation of the interconnect provider per each
"samsung,exynos-bus" compatible DT node, with one interconnect node per
provider.  The interconnect code which was previously added as a part of
the devfreq driver has been converted to a separate platform driver.
In the devfreq a corresponding virtual child platform device is registered.
Integration of devfreq and interconnect frameworks is achieved through
the PM QoS API.

A sample interconnect consumer for exynos-mixer is added in patches 6/7,
7/7, it is currently added only for exynos4412 and allows to address the
mixer DMA underrun error issues [1].

Changes since v7:
 - drivers/interconnect/exynos renamed to drivers/interconnect/samsung,
 - added INTERCONNECT_SAMSUNG Kconfig symbol,
 - added missing driver sync_state callback,
 - improved the DT binding description,
 - added a patch adding maintainers entry,
 - updated comment in patch 7/7, typo fix (patch 1/7).

The series has been tested on Odroid U3 board. It is based on v5.10-rc1.

--
Regards,
Sylwester

Changes since v6:
 - the interconnect consumer DT bindings are now used to describe dependencies
   of the interconnects (samsung,exynos-bus nodes),
 - bus-width property replaced with samsung,data-clk-ratio,
 - adaptation to recent changes in the interconnect code
   (of_icc_get_from_provider(), icc_node_add()).

Changes since v5:
 - addition of "bus-width: DT property, which specifies data width
   of the interconnect bus (patches 1...2/6),
 - addition of synchronization of the interconnect bandwidth setting
   with VSYNC (patch 6/6).

Changes since v3 [4] (v4 skipped to align with patchset [1]), detailed
changes are listed in patches:
 - conversion to a separate interconnect (platform) driver,
 - an update of the DT binding documenting new optional properties:
   #interconnect-cells, samsung,interconnect-parent in "samsung,exynos-bus"
   nodes,
 - new DT properties added to the SoC, rather than to the board specific
   files.

Changes since v2 [5]:
 - Use icc_std_aggregate().
 - Implement a different modification of apply_constraints() in
   drivers/interconnect/core.c (patch 03).
 - Use 'exynos,interconnect-parent-node' in the DT instead of
   'devfreq'/'parent', depending on the bus.
 - Rebase on DT patches that deprecate the 'devfreq' DT property.
 - Improve error handling, including freeing generated IDs on failure.
 - Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().

Changes since v1 [6]:
 - Rebase on coupled regulators patches.
 - Use dev_pm_qos_*() API instead of overriding frequency in
   exynos_bus_target().
 - Use IDR for node ID allocation.
 - Reverse order of multiplication and division in
   mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.


References:
[1] https://patchwork.kernel.org/patch/10861757/ (original issue)
[2] https://www.spinics.net/lists/linux-samsung-soc/msg70014.html
[3] https://www.spinics.net/lists/arm-kernel/msg810722.html
[4] https://lore.kernel.org/linux-pm/20191220115653.6487-1-a.swigon@samsung.com
[5] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
[6] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)


Artur Świgoń (1):
  ARM: dts: exynos: Add interconnects to Exynos4412 mixer

Sylwester Nawrocki (6):
  dt-bindings: devfreq: Add documentation for the interconnect
    properties
  interconnect: Add generic interconnect driver for Exynos SoCs
  MAINTAINERS: Add entry for Samsung interconnect drivers
  PM / devfreq: exynos-bus: Add registration of interconnect child
    device
  ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
  drm: exynos: mixer: Add interconnect support

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  71 +++++++-
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   7 +
 drivers/devfreq/exynos-bus.c                       |  17 ++
 drivers/gpu/drm/exynos/exynos_mixer.c              | 146 ++++++++++++++-
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/samsung/Kconfig               |  13 ++
 drivers/interconnect/samsung/Makefile              |   4 +
 drivers/interconnect/samsung/exynos.c              | 199 +++++++++++++++++++++
 10 files changed, 456 insertions(+), 10 deletions(-)
 create mode 100644 drivers/interconnect/samsung/Kconfig
 create mode 100644 drivers/interconnect/samsung/Makefile
 create mode 100644 drivers/interconnect/samsung/exynos.c

-- 
2.7.4

