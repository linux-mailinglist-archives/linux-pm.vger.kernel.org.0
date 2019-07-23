Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0A717F5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbfGWMUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38662 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389556AbfGWMUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122023euoutp018948777602e0f1b4fe67524d73a03f64~0CJkAsx8d2875728757euoutp01S
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122023euoutp018948777602e0f1b4fe67524d73a03f64~0CJkAsx8d2875728757euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884423;
        bh=E/h0xeZuDlNNpc19sQ9I4e8CfCTnOd78afTD5lcFh3M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pPAsus1DBleQ6S8y5rermerrTyuGuh8KA86IlfNttrx3SsT70dFDlokUXrKMAmhTz
         6s1kMTKHhe0xWel0esD7M8F1H+E3n7q1mFSJtGKrEq8l9ZVQPBmSFZd1rQCgZQxtx8
         PRdxuz1Qz4jKXKJSzJMu/7pvTWBn4LdOVAllPjNA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122023eucas1p14e0b1f612566a63f236384b167998f5d~0CJjR-aG73225832258eucas1p1M;
        Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FF.4B.04298.68BF63D5; Tue, 23
        Jul 2019 13:20:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5~0CJinGERD2753327533eucas1p2K;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122022eusmtrp1e012e5e4af5b700844603da16e8bca7f~0CJicZZZb2487524875eusmtrp1g;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-75-5d36fb866a77
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.D8.04140.68BF63D5; Tue, 23
        Jul 2019 13:20:22 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122021eusmtip2f9a8f6ab49accc2bea0b902873bf9f4f~0CJhzpRHb1612616126eusmtip2H;
        Tue, 23 Jul 2019 12:20:21 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 00/11] Simple QoS for exynos-bus driver using
 interconnect
Date:   Tue, 23 Jul 2019 14:20:05 +0200
Message-Id: <20190723122016.30279-1-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7ptv81iDX5+1rM4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        exSXTUpqTmZZapG+XQJXRuOWpYwF/yUr+o//YGpg3CjaxcjJISFgIrH/y0LWLkYuDiGBFYwS
        Gzc+ZYFwvjBKfDjayg7hfGaUOHjiBgtMS9fGHqiq5YwSJ98fZ4ZrefjgEBNIFZuAp0TPxB1g
        g0UEjjBKTF7wHqyFWWAVkPN9GyNIlbBAgMSXQ81gHSwCqhI3HtwCs3kFHCUO/n8DtU9eYvWG
        A8wQcUGJkzOfgMWZgeLNW2czQ9RcY5eY+yUEwnaROPzyOjuELSzx6vgWKFtG4vTkHqiZxRJP
        d94Hu05CoIFRYtOyI1CDrCUOH78IlOAAWqApsX6XPkTYUeL4kjfsIGEJAT6JG28FIU7gk5i0
        bTozRJhXoqNNCMLUkljwOxqiUUKiafU1qNkeErfPvQQ7RkggVuLq6juMExgVZiH5axaSv2Yh
        nLCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYDo7/e/4px2MXy8lHWIU4GBU4uHd
        sMc0Vog1say4MvcQowQHs5IIb2CDWawQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJ
        JanZqakFqUUwWSYOTqkGRp5b1xXn3Lnms+VgbuEj3xZpXpN+Nharrm0Ll9cFLD8VbrylTdGP
        I/h5zfmixStMC7f8kjngOmfBssXpgQt2ZH9/JH9BZlXl7MeiEcH9P5kdM65s3OHW+uV7wLrC
        NKbzs6SvHdc9Gc7Hk+KxgMf2sVHqPUb2kI4H/3c6pQdUi6zfmX9Cz2lKuBJLcUaioRZzUXEi
        APXghPVjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7ptv81iDc7cYLM4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRuOW
        pYwF/yUr+o//YGpg3CjaxcjJISFgItG1sYeli5GLQ0hgKaNE7/y1zBAJCYmP62+wQtjCEn+u
        dbFBFH1ilFh3/D9YEZuAp0TPxB2sIAkRgVOMEluXnwOrYhbYxChx9/hEdpAqYQE/iS1HTrCA
        2CwCqhI3HtxiArF5BRwlDv5/wwKxQl5i9YYDzBBxQYmTM58AxTmABqlLrJ8nBBJmBipp3jqb
        eQIj/ywkVbMQqmYhqVrAyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMO62Hfu5ZQdj17vg
        Q4wCHIxKPLwb9pjGCrEmlhVX5h5ilOBgVhLhDWwwixXiTUmsrEotyo8vKs1JLT7EaAr0wkRm
        KdHkfGBKyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKhfrc22
        QHBfS/r2adPnBlrvbf5myrtp0atZ16Jk3370eNdxXeDrs7R2rsO6P3rdNqnWFPg0JvFMKuO2
        aQu5ofssqHTVr79CgnuvMK79b9Dm+PbUzP+H9/x4Gvxxacs3VYGjDX8OK5g8f2H7SuCj/HTH
        hKh7e1YdPqt6wEC34co96+kF4c4XWJ8psRRnJBpqMRcVJwIAZRGfl9ECAAA=
X-CMS-MailID: 20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5
References: <CGME20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following patchset adds interconnect[1][2] framework support to the
exynos-bus devfreq driver. Extending the devfreq driver with interconnect
capabilities started as a response to the issue referenced in [3]. The
patches can be subdivided into four logical groups:

(a) Refactoring the existing devfreq driver in order to improve readability
and accommodate for adding new code (patches 01--04/11).

(b) Tweaking the interconnect framework to support the exynos-bus use case
(patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
avoid hardcoding every single graph edge in the DT or driver source, and
relaxing the requirement contained in that function removes the need to
provide dummy node IDs in the DT. Adjusting the logic in
apply_constraints() (drivers/interconnect/core.c) accounts for the fact
that every bus is a separate entity and therefore a separate interconnect
provider, albeit constituting a part of a larger hierarchy.

(c) Implementing interconnect providers in the exynos-bus devfreq driver
and adding required DT properties for one selected platform, namely
Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
generic driver for various Exynos SoCs, node IDs are generated dynamically
rather than hardcoded. This has been determined to be a simpler approach,
but depends on changes described in (b).

(d) Implementing a sample interconnect consumer for exynos-mixer targeted
at the issue referenced in [3], again with DT info only for Exynos4412
(patches 10--11/11).

Integration of devfreq and interconnect functionalities comes down to one
extra line in the devfreq target() callback, which selects either the
frequency calculated by the devfreq governor, or the one requested with the
interconnect API, whichever is higher. All new code works equally well when
CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
interconnect API functions are no-ops.

---
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

---
References:
[1] Documentation/interconnect/interconnect.rst
[2] Documentation/devicetree/bindings/interconnect/interconnect.txt
[3] https://patchwork.kernel.org/patch/10861757

Artur Świgoń (10):
  devfreq: exynos-bus: Extract exynos_bus_profile_init()
  devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
  devfreq: exynos-bus: Change goto-based logic to if-else logic
  devfreq: exynos-bus: Clean up code
  icc: Export of_icc_get_from_provider()
  icc: Relax requirement in of_icc_get_from_provider()
  icc: Relax condition in apply_constraints()
  arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
  devfreq: exynos-bus: Add interconnect functionality to exynos-bus
  arm: dts: exynos: Add interconnects to Exynos4412 mixer

Marek Szyprowski (1):
  drm: exynos: mixer: Add interconnect support

 .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
 arch/arm/boot/dts/exynos4412.dtsi             |  10 +
 drivers/devfreq/exynos-bus.c                  | 296 ++++++++++++++----
 drivers/gpu/drm/exynos/exynos_mixer.c         |  68 +++-
 drivers/interconnect/core.c                   |  12 +-
 include/linux/interconnect-provider.h         |   6 +
 6 files changed, 314 insertions(+), 79 deletions(-)

-- 
2.17.1

