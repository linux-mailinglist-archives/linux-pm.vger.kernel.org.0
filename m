Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF1127247
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLTASx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38171 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfLTASG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:06 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191220001803epoutp04df4cd035cd19e0253050335f320a292d~h7Ds-adv11373313733epoutp04F
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191220001803epoutp04df4cd035cd19e0253050335f320a292d~h7Ds-adv11373313733epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801083;
        bh=LsS7Y5v4gHckhscaO7bdEkbINdoC+Eq455a3ddtFDaw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KCLa9sKpoVl5USantYCzF0kCOE10VqlAPnQO8bG43OIz7Bowz38KdMOAgMElV5PrT
         CdZ3KfyhNqVzywda8JlGnUwgzmkgBjelMJvjPRnGzO7a+zYWP3hm5uSIuQbpVaJW8P
         xSR4OshR8cxg/40M9Auv4SqUsCzfrd+0VrNJzM/M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220001803epcas1p15df8d25bf26bac9f895d5955d02f1478~h7DsZMUeR3044730447epcas1p1O;
        Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47f8Th2gQZzMqYm1; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.14.48498.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epcas1p131a41a619847d80c64470f7c1920121f~h7Do4W95c3044730447epcas1p1F;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001759epsmtrp1ebc539bbaf257bc316b74055d8111222~h7Do3UZVZ1705617056epsmtrp1N;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-5b-5dfc1338e161
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.6C.06569.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip15e131ad165cc815dec38651f097c191a~h7DomX5g82050220502epsmtip1x;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsun.com>
Subject: [PATCH v2 00/11] PM / devfreq: Remove deprecated 'devfreq' and
 'devfreq-events' properties
Date:   Fri, 20 Dec 2019 09:24:19 +0900
Message-Id: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmnq6F8J9YgycrBSzuz2tltNj+rovJ
        4vqX56wW84+cY7X4/+g1q0X/49fMFufPb2C3ONv0ht1ixd2PrBabHl9jtbi8aw6bxefeI4wW
        nx78Z7aYcX4fk8XCphZ2i7VH7rJbLL1+kcniduMKNovWvUfYHYQ91sxbw+ixaVUnm8fmJfUe
        G9/tYPK4ffAzs0ffllWMHtuvzWP2+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+ghJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xo3OrUwF16UrFn5cz9LAeE20i5GTQ0LARGLG
        sk8sXYxcHEICOxgl/l3cxwjhfGKUeLf4AhuE841RYtGMFcwwLd2HZkMl9jJKLJ42mR0kISTw
        hVHi6h8ZEJtNQEti/4sbbCC2iECGxMzXl1lBGpgFpjFLNN/7xNTFyMEhLJAqcX9nDkgNi4Cq
        RH/XGbB6XgErict/Z7JDLJOXWL3hADNIr4TAdzaJTefOsUAkXCT+rP0PZQtLvDq+BapBSuJl
        fxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2L50MdgSzgKbE+l36EGFFiZ2/5zKC2MwCfBLvvvaw
        gpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyQZhe0jsOTOFBRIOsRJLHn1gnMAoOwthwQJGxlWM
        YqkFxbnpqcWGBUbIsbSJEZxItcx2MC4653OIUYCDUYmH1yHtd6wQa2JZcWXuIUYJDmYlEd7b
        HT9jhXhTEiurUovy44tKc1KLDzGaAkNvIrOUaHI+MMnnlcQbmhoZGxtbmBiamRoaKonzcvy4
        GCskkJ5YkpqdmlqQWgTTx8TBKdXA6LK0ZF2ovPAd99/V1z9WaD9mP37k84NFR+x2KMQcuq+o
        FhK/7SGnhG4A8+ZQwZreu/9iziRd+5B74OpD9Yfn/q7/dtBymxn/Ut+FUQ378rfWPF6nqVmc
        nDmRZ9+hXXu7xVNPvdA7lynPeqcnZmXf9EhxZmcWwz6N31NKJzic/v+w5J6k4JVaJSWW4oxE
        Qy3mouJEAHN6TIm6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnK658J9Yg1VXeS3uz2tltNj+rovJ
        4vqX56wW84+cY7X4/+g1q0X/49fMFufPb2C3ONv0ht1ixd2PrBabHl9jtbi8aw6bxefeI4wW
        nx78Z7aYcX4fk8XCphZ2i7VH7rJbLL1+kcniduMKNovWvUfYHYQ91sxbw+ixaVUnm8fmJfUe
        G9/tYPK4ffAzs0ffllWMHtuvzWP2+LxJLoAjissmJTUnsyy1SN8ugSvjRudWpoLr0hULP65n
        aWC8JtrFyMkhIWAi0X1oNlsXIxeHkMBuRok9t78zQiQkJaZdPMrcxcgBZAtLHD5cDFHziVHi
        y/8nrCA1bAJaEvtf3GADsUUE8iQ2bfzKDFLELLCMWWLC62awhLBAssS+T9PBGlgEVCX6u86A
        xXkFrCQu/53JDrFMXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93E
        CA5tLa0djCdOxB9iFOBgVOLhdUj7HSvEmlhWXJl7iFGCg1lJhPd2x89YId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyxO4KtbmndfTbX9f4JZ9Hk34tb
        jVm3bdIx9nPhr5bf7rnY3yUwaONbrpTGvS9k+W+sf7T31tIfZsJTHt/f8fTCrvMpZ4/n2dld
        +9o+IUdX9LJ9SlHYzrSFqwy/8q6fd07+/fxT57aGeU9emlVYvTx11rnHGkqvDi2vOLbu4F6d
        xcrp9Ts/fL3yT4mlOCPRUIu5qDgRABu9dCZpAgAA
X-CMS-MailID: 20191220001759epcas1p131a41a619847d80c64470f7c1920121f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001759epcas1p131a41a619847d80c64470f7c1920121f
References: <CGME20191220001759epcas1p131a41a619847d80c64470f7c1920121f@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsun.com>

The devfreq and devfreq-event subsystem provided the following two properties:
- Provide 'devfreq' property in order to get the parent devfreq device
  by devfreq_get_devfreq_by_phandle() if devfreq device use passive governor.
- Provide 'devfreq-events' property in order to get the devfreq-event device
  by devfreq_event_get_edev_by_phandle().

But, two properties name is not proper expressing the h/w
and 'devfreq' word is name of linux subsystem instead of any h/w name.

Hand over the rights for deciding the property name for getting
the devfreq/devfreq-event device on devicetree, to each devfreq driver.

So, replace 'devfreq' and 'devfreq-events' property with following property
name according to each devfreq driver:
--------------------------------------------------------------------
Old property  | New property       | Device driver name            |
--------------------------------------------------------------------
devfreq       | exynos,parent-bus  | exynos-bus.c                  |
              |                    |                               |
devfreq-events| exynos,ppmu-device | exynos-bus.c, exynos5422-dmc.c|
              | rockchip,dfi-device| rk3399_dmc.c                  |
--------------------------------------------------------------------

Changes from v1:
- Edit function name by removing '_by_node' postfix.
- Split out dt-binding patch to make it the separte patch.j
- Add Lukasz's tag for exynos5422-dmc

Chanwoo Choi (10):
  PM / devfreq: Remove devfreq_get_devfreq_by_phandle function
  PM / devfreq: event: Add devfreq_event_get_edev_by_node function
  dt-bindings: devfreq: exynos-bus: Replace deprecated 'devfreq' and 'devfreq-events' property
  dt-bindings: devfreq: rk3399_dmc:  Replace deprecated 'devfreq-events' property
  dt-bindings: memory: exynos5422-dmc: Replace the deprecated 'devfreq-events' property
  PM / devfreq: exynos-bus: Replace the deprecated 'devfreq' and 'devfreq-events' property
  PM / devfreq: rk3399_dmc: Replace the deprecated 'devfreq-events' property
  memory: samsung: exynos5422-dmc: Replace the deprecated 'devfreq-events' property
  ARM: dts: exynos: Replace deprecated property for Exynos bus and DMC
  arm64: dts: exynos: Replace deprecated property for Exynos bus on TM2

Leonard Crestez (1):
  PM / devfreq: Add devfreq_get_devfreq_by_node function

 .../bindings/devfreq/exynos-bus.txt           | 22 +++----
 .../bindings/devfreq/rk3399_dmc.txt           |  4 +-
 .../memory-controllers/exynos5422-dmc.txt     |  8 +--
 arch/arm/boot/dts/exynos3250-monk.dts         |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       | 18 +++---
 .../boot/dts/exynos4412-itop-scp-core.dtsi    | 16 ++---
 arch/arm/boot/dts/exynos4412-midas.dtsi       | 18 +++---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 18 +++---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 34 +++++------
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 20 +++----
 drivers/devfreq/devfreq-event.c               | 53 +++--------------
 drivers/devfreq/devfreq.c                     | 25 +++-----
 drivers/devfreq/exynos-bus.c                  | 58 ++++++++++++++++---
 drivers/devfreq/rk3399_dmc.c                  | 16 ++++-
 drivers/memory/samsung/exynos5422-dmc.c       | 37 ++++++++++--
 include/linux/devfreq-event.h                 | 14 ++---
 include/linux/devfreq.h                       |  6 +-
 17 files changed, 198 insertions(+), 171 deletions(-)

-- 
2.17.1

