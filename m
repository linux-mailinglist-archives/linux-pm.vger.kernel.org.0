Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAA22A05D4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJ3Mwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:52:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60541 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgJ3Mwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:52:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125226euoutp027efb1f10039203b497138fcee76b6215~CxjSz_dMV0138901389euoutp02B
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030125226euoutp027efb1f10039203b497138fcee76b6215~CxjSz_dMV0138901389euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062346;
        bh=MdlvHCkxwzi+Lsf2RfNJVwa956ltLv5/RWj75/qo/FE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AvmcHun+FctARQpNrpwj/JFTy2IwQ9QWiPu+wN2v4RRV8KEZ5UCYbecISUgxNSjCD
         H5FyVjr7LNc08Wp4V7cszC/0+Fm2WX61oIWLVckbrO/grJQX4cOh87m7YD6Yo/2BOE
         mOIQ4BIPG0vrbfZyUlkP6uQOlHuVMZVWVn1KcE90=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030125221eucas1p27a2700d748fcc8df9d07b68d896f0bef~CxjN5n8Sp0094600946eucas1p2U;
        Fri, 30 Oct 2020 12:52:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.0F.05997.58C0C9F5; Fri, 30
        Oct 2020 12:52:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776~CxjNY-tNp2028320283eucas1p1N;
        Fri, 30 Oct 2020 12:52:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125221eusmtrp1efe6517d0b0af8eebcec72b24d0b7f36~CxjNYN3lx0172901729eusmtrp1R;
        Fri, 30 Oct 2020 12:52:21 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-69-5f9c0c85ab82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.27.06017.48C0C9F5; Fri, 30
        Oct 2020 12:52:21 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125220eusmtip21f5a277f5158bd2cbe3dc9f27e1e57cc~CxjMp7mGY1363513635eusmtip2V;
        Fri, 30 Oct 2020 12:52:20 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 0/6] Exynos: Simple QoS for exynos-bus using interconnect
Date:   Fri, 30 Oct 2020 13:51:43 +0100
Message-Id: <20201030125149.8227-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHffZe9ipNX6fgyTJrXivSLD88VuQMP4yyKCgIycvSF5V0yqZm
        QWENtbyj1KZ5LUJdhJdMxUsXtYaZDlLSnDkLtWZGlBZUYjlfLb/9/uec/7nAYQjxS8qZiVMk
        c0qFPF5C25Atz38admVsKIvYPVTsjU0VGQg3auspPLLwgcKVvYMUHv7+hcaariYaF5kKSWww
        NAjxUHsZjefzehHWGh4J8P3et0JsvFJL44yuXiHumcuisLbYTEtZWZPuOi0bf91Jy0w5eoEs
        v1mHZPNNW45ToTYHorn4uFRO6Xsw0ia2prUEJQ27p82N6Oh0NOCSjawZYP0hZ7yBzEY2jJit
        RVCe/QbxYgFB3fMbFC/mEXycKqDWLD2jWQI+UYOgxmAk/lkmNXqBpYpm/SDvWT6ysCMbDJnT
        FaSFCfa9ANSVhIUd2BDQlo0JLUyyHvBpcHKFRew+KH3ah/hprnCv4QnBx+2hr2RqtY8rqB/e
        WhkM7AshjFfnLpuZZREMxuoo3usAs/pmIc+bob84l+Tr1QhyO4xCXhQiMOmrVqfth/HBX7Sl
        EcFuh/p2Xz4cBOaiKxTf3xZGP9vzO9hCUYuG4MMiuJYp5qvd4bdOI+DZGXKm/pA8y6BgaGJl
        HTEbBkvlZagQbS1dd1npustK/+9QhQgdcuJSVAkxnGqPgjvvo5InqFIUMT5RiQlNaPnH+pf0
        C22offFsN2IZJNkgkrreihBT8lTVhYRuBAwhcRQdGugPF4ui5RcucsrECGVKPKfqRpsYUuIk
        2nvbHCZmY+TJ3DmOS+KUa1kBY+2cjtqvXh6a9QxWS03SE3lenAI6G8LHUmZsvaze/WibDpVr
        T9lttIo9eibEjH8f+xowIe077OZ8ujHNbTEw2niz7uRUoPtdott8aUIkmGYevIL0DpRcXhh5
        xMPQZadhKv23ZXrfkXB2377sDMp4rA5Y8oh1DHjpP1NxqVXr4xKQ6CkhVbFyvx2EUiX/CwiX
        GbRfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7qtPHPiDe67Wdyf18posXHGelaL
        61+es1rMP3KO1eLK1/dsFtP3bmKzmHR/AovF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x
        u3EFm0Xr3iPsFofftLNazJj8ks1BwGPTqk42jzvX9rB53O8+zuTRt2UVo8fnTXIBrFF6NkX5
        pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gcu3z2QsuKJS
        8eb6KrYGxrOyXYycHBICJhKHb7QzdTFycQgJLGWU+LtrInsXIwdQQkpifosSRI2wxJ9rXWwQ
        NZ8YJa7sessOkmATMJToPdrHCGKLCHhInGpdywpSxCzwgUli7YNesISwgI/EjDm3wBpYBFQl
        Xp97AGbzClhJzDp4khFig7zE6g0HmCHighInZz5hATmCWUBdYv08IZAwM1BJ89bZzBMY+Wch
        qZqFUDULSdUCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG27djPLTsYu94FH2IU4GBU
        4uF1kJ8dL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAL0xklhJNzgcm
        gbySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxuy6+yBDtudC9s
        KuJ/ajv9u+3Oy442iZeC3zvMW9FlLfZnTo1jzc4GGxtljiCj7XwFE+UVXS/4+J15MWHbaweL
        +euZHY55zZkv+JShQvK6Xfu20D8ZLyZzWnzMEmr/x/jeiN0k83/i31lijxfaltuW6apGzZ05
        MXp32uu7eluYnI21U/UFG5RYijMSDbWYi4oTAbQHyB/KAgAA
X-CMS-MailID: 20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776
References: <CGME20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776@eucas1p1.samsung.com>
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

A sample interconnect consumer for exynos-mixer is added in patches 5/6,
6/6, it is currently added only for exynos4412 and allows to address the
mixer DMA underrun error issues [1].

Changes since v6:
 - the interconnect consumer DT bindings are now used to describe dependencies
   of the interconnects (samsung,exynos-bus nodes),
 - bus-width property replaced with samsung,data-clk-ratio,
 - adaptation to recent changes in the interconnect code
   (of_icc_get_from_provider(), icc_node_add()).

The series has been tested on Odroid U3 board. It is based on v5.10-rc1.

--
Regards,
Sylwester


Changes since v5:
 - addition of "bus-width: DT property, which specifies data width
   of the interconnect bus (patches 1...2/6),
 - addition of synchronization of the interconnect bandwidth setting
   with VSYNC (patch 6/6).

Changes since v3 [4] (v4 skipped to align with patchset [1]), detailed
changes are listed in each patch:
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

Sylwester Nawrocki (5):
  dt-bindings: devfreq: Add documentation for the interconnect
    properties
  interconnect: Add generic interconnect driver for Exynos SoCs
  PM / devfreq: exynos-bus: Add registration of interconnect child
    device
  ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
  drm: exynos: mixer: Add interconnect support

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  68 ++++++-
 arch/arm/boot/dts/exynos4412.dtsi                  |   7 +
 drivers/devfreq/exynos-bus.c                       |  17 ++
 drivers/gpu/drm/exynos/exynos_mixer.c              | 146 ++++++++++++++-
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/exynos/Kconfig                |   6 +
 drivers/interconnect/exynos/Makefile               |   4 +
 drivers/interconnect/exynos/exynos.c               | 198 +++++++++++++++++++++
 9 files changed, 438 insertions(+), 10 deletions(-)
 create mode 100644 drivers/interconnect/exynos/Kconfig
 create mode 100644 drivers/interconnect/exynos/Makefile
 create mode 100644 drivers/interconnect/exynos/exynos.c

--
2.7.4

