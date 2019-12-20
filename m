Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD760127A7E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLTMBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:01:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36362 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLTMBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120141euoutp015a15e05e072f72591697e743174c0f6f~iEqDhQMEO1021410214euoutp01A
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120141euoutp015a15e05e072f72591697e743174c0f6f~iEqDhQMEO1021410214euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843301;
        bh=o8kqTbI3GWwahjeMr7ptW3eNW7y3qIfdXJX6mSqJ8GU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fRG9JCy6XCwtp4ZdCi7PJzn3R5kwHooe2fVk+33c3GV2959QFdWTCqaNwlbgWfID7
         x7aVTbQ7JBD6/EAlSUIW/oDTWydvAN84A76DH2owSsHzXq6WucpD3pTV6Ldm9YRMrt
         /K4K6HSAMKBeJ35F+6m9rHHNYXmHBfhWHPQ219uo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220120141eucas1p1346b57898e6b86bf808788dc151be72e~iEqDHDdLL2294822948eucas1p15;
        Fri, 20 Dec 2019 12:01:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.84.60679.528BCFD5; Fri, 20
        Dec 2019 12:01:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91~iEqC0-4Uz1895118951eucas1p1f;
        Fri, 20 Dec 2019 12:01:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120140eusmtrp2e53173ce4cb4fe4f518a9ac1d5e90469~iEqC0RcnC2149221492eusmtrp2q;
        Fri, 20 Dec 2019 12:01:40 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-18-5dfcb8251d32
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.58.07950.428BCFD5; Fri, 20
        Dec 2019 12:01:40 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120140eusmtip2d5da1c65c2cb57bed1af99b2eb661293~iEqCD-7rN2783527835eusmtip2t;
        Fri, 20 Dec 2019 12:01:40 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 0/7] PM / devfreq: Simple QoS for exynos-bus using
 interconnect
Date:   Fri, 20 Dec 2019 12:56:46 +0100
Message-Id: <20191220115653.6487-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3u3l1XG3dT6LReNhJKqGUW/KJlT+pC9KKIiEZNu6jkVuxm
        pQVNI7GVJSvxkahUpJiyuXzMsSRkZA/UzEfho4WPSqOsfESmmbdrj/++53vO5/zOOfxoQt1C
        auhY80nOYjbGaSm5tPLR98ZlIe5xw4qer0rsz7uIcFmWg8Qvh9+RON/XQOKWkUEKZz5wUdju
        T5fixkanDBd1fSGxq6eNxM2eXAoPpfkQzmqskeBSX5cMdyQVUTjrej+1gWFdxZcotrPNS7H+
        y3US9v6d82zZJ7eEvVpejNgh14LdsoNy/VEuLvYUZ9FFHJHHZLb60YnWhWeeVDVRVuTV2BBN
        A7MK7Jl7bUhOq5kiBKMTo0gMhhHYurtkNhQwFQwhGOnfKWgBqM9Io8SiQgQp7fXkX6Jiwi8R
        qihmI9gz3siERBDjQ3C9YFAqBASTK4HUS4VSoSqQOQAjpQ2/CSkTArc9DkLQCgZD37U3EvG9
        hXDP+XDaV8GT7N7fLDHlX6i4SQhNgWmXwQuHG4nAFuj61kuJOhAG6splop4Hk9X500156Kv2
        kyJsReC66yPExFrobBijhNMQzFJweHSivREmur0y8WJKePVRJc6gBHtlJiHaCkhNUYtSC55s
        pQgCJN9rm+7NwttnkxLxogboaXIQ6Sg457/Fcv5bLOffCAWIKEazuXjeFM3xK83c6eW80cTH
        m6OXRx03udDUX3v2s27YjTzjkbWIoZF2luJ91A+DmjSe4hNMtQhoQhuk6Ej9blArjhoTEjnL
        8cOW+DiOr0Vzaal2tiL8Vr9BzUQbT3LHOO4EZ/mTldABGiuqeD4+4+zoxZr1j8dG9gWXbK5/
        XaA5xxauduq/lfCqqjrLoq1Rm3evzGtODI9xNkekdG5KomynN7lqmcjPyvnjQVd026t3ZHeH
        vQ70WZ9GDSzRx9+YGVl5O91btV8+FjrnzoKBdWkBW8N20TElodt0KoN6W0pG1p416/XJi999
        KFUd0kr5GGNYKGHhjb8ABpOM6GcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oqO/7EGnR+sbC4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbrLj7kdVi0+NrrBaXd81hs/jce4TR
        Ysb5fUwWa4/cZbe43biCzWLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j02vtvB5NG3ZRWj
        x+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2
        CXoZ06/eZyy4Kl9xcvtFtgbGPVJdjJwcEgImEmen9rJ1MXJxCAksZZT4e/U6K0RCQuLj+htQ
        trDEn2tdUEWfGCXe/H/IBpJgE3CUmDT1ATtIQkTgFKPE1uXnwBLMAiuYJPrnCHcxcnAIC4RJ
        TGu0AwmzCKhKLN61nhnE5hWwkHja/4AJYoG8xOoNB6DighInZz5hAWllFlCXWD9PCGKivETz
        1tnMExj5ZyGpmoVQNQtJ1QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bft2M8tOxi7
        3gUfYhTgYFTi4XVI+x0rxJpYVlyZe4hRgoNZSYT3dsfPWCHelMTKqtSi/Pii0pzU4kOMpkAv
        TGSWEk3OByaGvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjBr2
        Dx57/DiTwdi84qhswTQp9p3WRiujzs2c/+KI4zWmvcc1OhiTQ2v0wj+knFu91eJd/sTTP1Zt
        7Pm+9EJZo5lGfvjPwy9+iB2rfv+/pufUhxunrvouOjPTze+tQkHsvXlvnHwD9t7azCASW594
        /MOvhKlBNUrfreqDP7zZJLbTaiZ/kHXW791KLMUZiYZazEXFiQAR5L591AIAAA==
X-CMS-MailID: 20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91
References: <CGME20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following patchset adds interconnect[1][2] framework support to the
exynos-bus devfreq driver. Extending the devfreq driver with
interconnect functionality started as a response to the issue referenced
in [3]. The patches can be subdivided into three groups:

(a) Tweaking the interconnect framework to support the exynos-bus use
case (patches 01--03/07). Exporting of_icc_get_from_provider() allows to
avoid hardcoding every single graph edge in the DT or driver source, and
relaxing the requirement on #interconnect-cells removes the need to
provide dummy node IDs in the DT. A new field in struct icc_provider is
used to explicitly allow configuring node pairs from two different
providers.

(b) Implementing interconnect providers in the exynos-bus devfreq driver
and adding required DT properties for one selected platform, namely
Exynos4412 (patches 04--05/07). Due to the fact that this aims to be a
generic driver for various Exynos SoCs, node IDs are generated
dynamically (rather than hardcoded).

(c) Implementing a sample interconnect consumer for exynos-mixer
targeted at solving the issue referenced in [3], again with DT
properties only for Exynos4412 (patches 06--07/07).

Integration of devfreq and interconnect frameworks is achieved by using
the dev_pm_qos_*() API. When CONFIG_INTERCONNECT is 'n' (such as in
exynos_defconfig) all interconnect API functions are no-ops.

This series depends on these three patches (merged into devfreq-next[6]):
* https://patchwork.kernel.org/patch/11279087/
* https://patchwork.kernel.org/patch/11279093/
* https://patchwork.kernel.org/patch/11293765/
and on this series:
* https://patchwork.kernel.org/cover/11304545/
(which does not apply cleanly on next-20191220, adding
--exclude=arch/arm/boot/dts/exynos5422-odroid-core.dtsi to 'git am' is a
quick workaround)

---
Changes since v2 [5]:
* Use icc_std_aggregate().
* Implement a different modification of apply_constraints() in
  drivers/interconnect/core.c (patch 03).
* Use 'exynos,interconnect-parent-node' in the DT instead of
  'devfreq'/'parent', depending on the bus.
* Rebase on DT patches that deprecate the 'devfreq' DT property.
* Improve error handling, including freeing generated IDs on failure.
* Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().

---
Changes since v1 [4]:
* Rebase on coupled regulators patches.
* Use dev_pm_qos_*() API instead of overriding frequency in
  exynos_bus_target().
* Use IDR for node ID allocation.
* Reverse order of multiplication and division in
  mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.

---
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

---
References:
[1] Documentation/interconnect/interconnect.rst
[2] Documentation/devicetree/bindings/interconnect/interconnect.txt
[3] https://patchwork.kernel.org/patch/10861757/ (original issue)
[4] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
[5] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)
[6] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next

Artur Świgoń (6):
  interconnect: Export of_icc_get_from_provider()
  interconnect: Relax requirement in of_icc_get_from_provider()
  interconnect: Allow inter-provider pairs to be configured
  arm: dts: exynos: Add interconnect bindings for Exynos4412
  devfreq: exynos-bus: Add interconnect functionality to exynos-bus
  arm: dts: exynos: Add interconnects to Exynos4412 mixer

Marek Szyprowski (1):
  drm: exynos: mixer: Add interconnect support

 .../boot/dts/exynos4412-odroid-common.dtsi    |   5 +
 arch/arm/boot/dts/exynos4412.dtsi             |   1 +
 drivers/devfreq/exynos-bus.c                  | 144 ++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_mixer.c         |  71 ++++++++-
 drivers/interconnect/core.c                   |  16 +-
 include/linux/interconnect-provider.h         |   8 +
 6 files changed, 232 insertions(+), 13 deletions(-)

--
2.17.1

