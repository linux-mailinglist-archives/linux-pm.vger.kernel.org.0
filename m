Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A282129B4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGBQhv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:37:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36672 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgGBQhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:37:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163747euoutp02d7ae514c27b629c79c19bcfc7916855d~d-NyZuHCI0804708047euoutp02A
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200702163747euoutp02d7ae514c27b629c79c19bcfc7916855d~d-NyZuHCI0804708047euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707867;
        bh=i9GtKm4WhJUsYZQ05oW3SlZXUj0Qjrx/Pp5bCy+19KQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qpFHFS7+DUX9FL9a6ErWeYP543XRytezjtJdl41sJZDLVOZIHTR9y6VF8JS1REE2k
         zIXhaNm7SpV9Yr8xKgxYLjVQ5YCTRRHQprcDg3GUWnPvweJ2Gw8olIczFePhn4TRoh
         13OEr5uyEYe5nIECfMERvqkvl8x3T8FUGw5HmixU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702163746eucas1p22e462edeeaa7b44c660f9f64da1d31a7~d-NxxFd472646326463eucas1p2j;
        Thu,  2 Jul 2020 16:37:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.5A.06318.A5D0EFE5; Thu,  2
        Jul 2020 17:37:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163746eucas1p2363251b3b6fb6084123cedd67fa132d5~d-NxZPRal2646326463eucas1p2i;
        Thu,  2 Jul 2020 16:37:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163746eusmtrp118c2d8325d59fa423234d57a9276acf9~d-NxYffo21333013330eusmtrp1k;
        Thu,  2 Jul 2020 16:37:46 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-45-5efe0d5a798b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.9B.06314.A5D0EFE5; Thu,  2
        Jul 2020 17:37:46 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163745eusmtip2c9eb3169ca506724fb79dd5218c7d0e4~d-NwqGR5g2242122421eusmtip2h;
        Thu,  2 Jul 2020 16:37:45 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 0/6] Exynos: Simple QoS for exynos-bus using
 interconnect
Date:   Thu,  2 Jul 2020 18:37:18 +0200
Message-Id: <20200702163724.2218-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b27u65uXK+SD6YVy7CCNNPozSwq/DHwjxRGGFpLbyo6lU0r
        +1HWmN+FKOQ0LRNTmZVzqZilia2WWVpYKula4LSU7IMpkZ+5Xfv4d57znPM+58BLE9w7sSed
        kJzGq5IVSTJKSrY8+9W3PZJZjN7RPLATW29oEW7UNYjx4PQnMb5p6hXjtzPfKFzSbqRwkbWQ
        xH19Bgk2jg6IcX9bOYXtV0wI6/o6RPiuySLBw5fqKKxtN0nwky/ZYqwrnqAOuMqN+lxKPjLw
        iJJb880i+f3qi/KrTXoktxvXh1OR0pBYPinhDK/y339SGl9j/ypKzfc5V/96nspENd55yIUG
        NgjyOicleUhKc2wdgvaCQSQM0wjMSwuUMNgR3FvUEnmIdlpqKn0FvhbBg6xx4q/jo8FCON6l
        2AC48vQqcmB3NhSyxm6QDhHB5hDQ0lrkFLmxhyGn6rHIgUl2M/Rr50WOCwwbDL3fg4R8G6De
        0OmUM6wrdJfaSAcmlnlN83XnYWDfS+CW8bNEMITCVNYgErAbTJqbVngv6CkuIAWDBkHBw2GJ
        MBQisJorVxx7YaR3lnKkINit0NDmL9AHocJSvlJ/DQxNuQoh1kBRS8kKzUBOFieofWBOXyIS
        sCfk25ZIActBX1rn7MKxUTBWMUQVoo1l/1Ur+69a2b8MlYjQIw8+Xa2M49WByfxZP7VCqU5P
        jvOLSVEa0fJn61k0z7SijvlTXYilkWw187l7IZoTK86oM5RdCGhC5s4cetUTzTGxiozzvCrl
        hCo9iVd3oXU0KfNgAqsmojg2TpHGJ/J8Kq/6sxXRLp6Z6Jp0oEnT9mKu373bUG46zr0xXKgb
        7diSHeoZFJ+bu+nIy1sfdp+WBZPzjN+BCO/9FlX19x/htt3PbV4/TSENq/Y1Jkb3NrnrNLqv
        yoN30mc711t3pd62VR0LO9rwQVOb6WsJ45YgQDse3jI4FlLvm7IponChYk/M2uKEqBpRt8dl
        GamOVwRsI1RqxW8rOVu8aAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7pRvP/iDLYsFbO4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7Gss/vmAq6VSpWX/jD1sC4TLaLkYNDQsBEYtkC9S5GLg4hgaWMEhe332CCiEtJzG9R6mLk
        BDKFJf5c62KDqPnEKLFr+ic2kASbgKFE79E+RhBbRMBD4lTrWlYQm1lgBrPE6VmmILawQIDE
        gWOXmEBsFgFVicutf8Dm8wpYSZz7YAIxX15i9YYDzCA2r4CgxMmZT1hASpgF1CXWzxOCmCgv
        0bx1NvMERv5ZSKpmIVTNQlK1gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmDcbTv2c/MO
        xksbgw8xCnAwKvHwTjj+N06INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhN
        gT6YyCwlmpwPTAl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY
        J3q388nfXL62N0gtesE5dlktYx1FVz7Wvz9nCH3f9n7jFKlGz9Dqip6nbOEP13rwllc8yFA8
        fJ75nNiXO++Vdk6YHK/lKaszw+5sh0y87r93M5e9yCn2Xmm5ejXvh/sai7XaulV9fZbPnDP5
        VZ/yun2H33FXv7AuD021a+hpEJRkv8n5gT9RiaU4I9FQi7moOBEAgL/8XdECAAA=
X-CMS-MailID: 20200702163746eucas1p2363251b3b6fb6084123cedd67fa132d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163746eucas1p2363251b3b6fb6084123cedd67fa132d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163746eucas1p2363251b3b6fb6084123cedd67fa132d5
References: <CGME20200702163746eucas1p2363251b3b6fb6084123cedd67fa132d5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
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

Main changes since v5 [3] is an addition of "bus-width: DT property, which
specifies data width of the interconnect bus (patches 1...2/6 and addition
of synchronization of the interconnect bandwidth setting with VSYNC
(patch 6/6).

The series has been tested on Odroid U3 board. It is based on icc-next
branch, which already includes required patches [2]:
 26c205e interconnect: Allow inter-provider pairs to be configured
 0db4ee05 interconnect: Relax requirement in of_icc_get_from_provider()
 6998a7c interconnect: Export of_icc_get_from_provider()

--
Regards,
Sylwester


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
  dt-bindings: exynos-bus: Add documentation for interconnect properties
  interconnect: Add generic interconnect driver for Exynos SoCs
  PM / devfreq: exynos-bus: Add registration of interconnect child
    device
  ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
  drm: exynos: mixer: Add interconnect support

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  68 +++++++-
 arch/arm/boot/dts/exynos4412.dtsi                  |   7 +
 drivers/devfreq/exynos-bus.c                       |  17 ++
 drivers/gpu/drm/exynos/exynos_mixer.c              | 150 +++++++++++++++-
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/exynos/Kconfig                |   6 +
 drivers/interconnect/exynos/Makefile               |   4 +
 drivers/interconnect/exynos/exynos.c               | 192 +++++++++++++++++++++
 9 files changed, 436 insertions(+), 10 deletions(-)
 create mode 100644 drivers/interconnect/exynos/Kconfig
 create mode 100644 drivers/interconnect/exynos/Makefile
 create mode 100644 drivers/interconnect/exynos/exynos.c

--
2.7.4

