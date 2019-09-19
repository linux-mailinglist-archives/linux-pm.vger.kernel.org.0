Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B29B7C1D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbfISOX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46438 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390469AbfISOXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142322euoutp01b82574b8e916690b4f206b23934968f5~F3Pf9w_PM2118221182euoutp01k
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142322euoutp01b82574b8e916690b4f206b23934968f5~F3Pf9w_PM2118221182euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903002;
        bh=yCJyZaAISj2X2sPtGhkorDCVQ2B6gi5BHvQF0QJ1smU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EeKYrf/GwEKA9IiQuVxqXdB4nZiKN0lQ9DtSZQm//KXsSr3kkHfTNjZC/FB9VmDXm
         GirPgx7m4IjeAE+gXVWnKxmpWvkrtSY8KRhXaMFJrMsrciUJDLJtlfIlJIrC8SiKyC
         PflnOzmst25DTDmyGX/vQ4UrpEh/I8UNsKyPMa1Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142322eucas1p265abed8b4159482c9ee0b03baeaafd4b~F3PfKNRD53082530825eucas1p2c;
        Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6B.59.04374.95F838D5; Thu, 19
        Sep 2019 15:23:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec~F3PeY7cSX0293102931eucas1p1K;
        Thu, 19 Sep 2019 14:23:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190919142320eusmtrp2d172b9e3a280dbdf5169de5adbc67d41~F3PeKxg7n3074530745eusmtrp2Z;
        Thu, 19 Sep 2019 14:23:20 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-ec-5d838f59baf4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.0F.04166.85F838D5; Thu, 19
        Sep 2019 15:23:20 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142320eusmtip122eb1934da667f679df296a20dfbdd57~F3PdbuISJ3161631616eusmtip1a;
        Thu, 19 Sep 2019 14:23:20 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
Date:   Thu, 19 Sep 2019 16:22:25 +0200
Message-Id: <20190919142236.4071-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO2fn7LicHJflm4rFoiBBa934oDCliBP9iYJATWrlQcVrO5pd
        ELXltSzRvGtekCaK2NYyN8q8DJcVDdNUKpthFlleQi2isnTHyn/P+zzf8zzvCx9DKvopDyYy
        NoHXxKqjlbRM0tL93eYbdF0bulX3zRfbb6YjrC9ppvDg7AcKV1meUbh/borGxQ8MNM6350mw
        zXZbiuuHv1DYMDpA4T5zBY1nci0Il9jaCNxkGZbiV2n1NC4p+EgHsJyhIZvmXg/cpzn7FSvB
        3alL4fSTrQR3zdiAuBmD92FpsGxPGB8deZbXbPE/KYsYf3yVijd6n5u2NkpTUdHaHOTEALsD
        TOn3JTlIxijYegRD7xtIcZhFYJzPQeIwg8CUOS35a3lzeZYSBR0C3fwc8c+SMzrheEWzgZBf
        OCJdFNxYC4KC6ilHC8lWEJCVrVsYGGYVexT66nYuGiTsRsiqfyddxHIWw+Cbz1Kxbh003m4n
        Rd4VekrfOQrIBV57t9yxLLAvpWC1dVOLmcDuh3kzFr2rYNxqXMrxgt+mKkLEAoyZ7JToTUVg
        uGUhRWE3dFl7HTkkuxmazVtEOhCaPpmX4l1gaMJVXMEF8luKSZGWQ1aGQoRKMJe6iEaAS40D
        S9kcjNX9cmAFGwr33qaReWh92bK7ypbdVfZ/hWpENiB3PlGICeeF7bF8kp+gjhESY8P9TsfF
        GNDCX3syb51rRW0/T3UilkFKZ/n6JG2oglKfFc7HdCJgSKWbvGLnpVCFPEx9/gKviTuhSYzm
        hU7kyUiU7vKLK0ZCFGy4OoGP4vl4XvNXJRgnj1RUrIqKL3w63rXrXHB0UGb+Gr22tiZXVT0R
        oJW7K55vczo02eH5qGnHcZ/+FOJCSPM+tSr50ytZMddY67X6BxV3YmVKYhF7wKvGOLpB1b69
        clPZwe95W/dW1zz82jGV2h14pkdfnuFPDDsfqXQNOhXce2ysNvlihBX3VH28MbT/RaZdKREi
        1CofUiOo/wD6xdsIZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7oR/c2xBj1vzC3uz2tltNg4Yz2r
        xfUvz1kt5h85x2px5et7NovpezexWUy6P4HF4vz5DewWK+5+ZLXY9Pgaq8XlXXPYLD73HmG0
        mHF+H5PF2iN32S1uN65gs5gx+SWbg4DHplWdbB53ru1h87jffZzJY/OSeo+N73YwefRtWcXo
        8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7Gq1M9rAVb5Co+HF/N3sA4TbKLkZNDQsBE4l7LF1YQW0hgKaNE6/YgiLiExMf1N1ghbGGJ
        P9e62LoYuYBqPjFK/GztYAFJsAk4Skya+oAdJCEicIpRYuvyc2wgCWaBFUwS/XOEQWxhgUCJ
        C2eWgMVZBFQlOlY8YQexeQUsJK7fe8MOsUFeYvWGA8wQcUGJkzOfAC3gAJqjLrF+nhDESHmJ
        5q2zmScw8s9CUjULoWoWkqoFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNv27Gfm3cw
        XtoYfIhRgINRiYdXobw5Vog1say4MvcQowQHs5II7xzTplgh3pTEyqrUovz4otKc1OJDjKZA
        L0xklhJNzgcmhrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwR
        jcVpFQ5NkfZBh/QKLFf7JLhv9WK6u8Y9benkmJj59UIL33z9vPi9cvGdRitv4R13bfQ+rXfa
        a7p3qcC1I/P0uSK8Ez9e6g0Rbgx8oC4+Z/ae2p37MrXZjy24tqVnz63XS0vW+dheu1GtNz9J
        YcojNV6Bhc8jHXYbTSxK37FwsnGw658Vqw8osRRnJBpqMRcVJwIACdB0JNQCAAA=
X-CMS-MailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
References: <CGME20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec@eucas1p1.samsung.com>
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

Integration of devfreq and interconnect functionalities is achieved by
using dev_pm_qos_*() API[5]. All new code works equally well when
CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
interconnect API functions are no-ops.

This patchset depends on [5].

--- Changes since v1 [6]:
* Rebase on [4] (coupled regulators).
* Rebase on [5] (dev_pm_qos for devfreq).
* Use dev_pm_qos_*() API[5] instead of overriding frequency in
  exynos_bus_target().
* Use IDR for node ID allocation.
* Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
* Reverse order of multiplication and division in
  mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.

---
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

---
References:
[1] Documentation/interconnect/interconnect.rst
[2] Documentation/devicetree/bindings/interconnect/interconnect.txt
[3] https://patchwork.kernel.org/patch/10861757/ (original issue)
[4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
[5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
[6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)

Artur Świgoń (10):
  devfreq: exynos-bus: Extract exynos_bus_profile_init()
  devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
  devfreq: exynos-bus: Change goto-based logic to if-else logic
  devfreq: exynos-bus: Clean up code
  interconnect: Export of_icc_get_from_provider()
  interconnect: Relax requirement in of_icc_get_from_provider()
  interconnect: Relax condition in apply_constraints()
  arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
  devfreq: exynos-bus: Add interconnect functionality to exynos-bus
  arm: dts: exynos: Add interconnects to Exynos4412 mixer

Marek Szyprowski (1):
  drm: exynos: mixer: Add interconnect support

 .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
 arch/arm/boot/dts/exynos4412.dtsi             |  10 +
 drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
 drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
 drivers/interconnect/core.c                   |  12 +-
 include/linux/interconnect-provider.h         |   6 +
 6 files changed, 327 insertions(+), 92 deletions(-)

-- 
2.17.1

