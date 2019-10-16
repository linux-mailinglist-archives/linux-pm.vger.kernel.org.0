Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66237D947E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbfJPO6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:58:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60026 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbfJPO6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:58:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191016145807euoutp01750ddfc0617c7606ab610d4365c8487a~OKIizG8Pf2498824988euoutp01L
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 14:58:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191016145807euoutp01750ddfc0617c7606ab610d4365c8487a~OKIizG8Pf2498824988euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571237887;
        bh=JoncVjC24KKiQlne8enrxBMTgaWnwTqTsB0Y6vkF3D4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=W1mLcDpAkTbhx7u3RSLkQsdair8sLShVUbYO2GGrwHwlJDMykV/jh8j7JtEshyxdC
         cGcifTJ/zeTb02W4J9luoPWQ/TgZKc9946PjdDONyHlibTj1+UKvzMaj9Pqv5MNwCM
         SD0SJ7PSXbl9yUYFmREFjeALsHqH3OMn+xR0ifHk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191016145807eucas1p2fcf58664104fe0626ed54bacb5cb2724~OKIidPp332484024840eucas1p2n;
        Wed, 16 Oct 2019 14:58:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 66.FF.04309.FFF27AD5; Wed, 16
        Oct 2019 15:58:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191016145806eucas1p2d522901fc79e1ca6e03f1bb516a81370~OKIiOa-_n2480624806eucas1p2s;
        Wed, 16 Oct 2019 14:58:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191016145806eusmtrp285c288b5253066094ea66dc8d39dd4a2~OKIiNqFVL2395523955eusmtrp2X;
        Wed, 16 Oct 2019 14:58:06 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-1b-5da72fff42c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.0E.04166.EFF27AD5; Wed, 16
        Oct 2019 15:58:06 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191016145806eusmtip2d2c6d98211d8ee8d35793b9b4aeed72a~OKIhro0oC0671206712eusmtip2g;
        Wed, 16 Oct 2019 14:58:06 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, roger.lu@mediatek.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 0/4] Exynos Adaptive Supply Voltage support
Date:   Wed, 16 Oct 2019 16:57:52 +0200
Message-Id: <20191016145756.16004-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd3/+stjDW4/57bYOGM9q8X8I+dY
        Lc6f38BusenxNVaLz71HGC1mnN/HZLH2yF12i9a9R9gtLj/eyGZx+E07q8W/axtZLDY/OMbm
        wOOxaVUnm8fmJfUeLSf3s3j0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxur1q1gKrgtUrJg7
        m72BsYm3i5GTQ0LAROL45SeMXYxcHEICKxgl+h6+ZoFwvjBKtDzbxwrhfGaU6N0yn62LkQOs
        ZWaXEUR8OaPE9+5OVpBRYB2rbhWD2GwChhK9R/sYQepFBKwlPp0UA6lnFpjIJPFidhc7SI2w
        gJ3Ey+Mb2UBsFgFViYmz77GA2LxA9Y9+9LFAnCcvsXrDAWaQZgmB/2wSUxpfsEMkXCS+nWln
        grCFJV4d3wIVl5H4v3M+E0RDM6NEz+7b7BDOBEaJ+8cXMEJUWUscPn6RFeQ8ZgFNifW79CHC
        jhLX23pYIb7kk7jxVhAkzAxkTto2nRkizCvR0SYEUa0i8XvVdKgTpCS6n/yHutlDYsXGbWyQ
        MImV+PToDtsERrlZCLsWMDKuYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwdp/8d/7KD
        cdefpEOMAhyMSjy8L5iXxwqxJpYVV+YeYpTgYFYS4Z3fsiRWiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA2PhhqnXDCR3sT1bkarn0nEt/XBs2nWB3L2d
        dg7JwrzlvscWhWzcHLbvw4FdK4OeyS8yn+yftWS1shRDwd62b1Pad2y5IluwdFO6yePJnDEt
        ac4bLD+lzaq2W1iwrex5dqfaco/KxI4Yp69PpnivY1ZPKhXcVznZIWy73D/lE98t5tjaipbP
        3qPEUpyRaKjFXFScCADnQN0DGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xe7r/9JfHGnx9Z26xccZ6Vov5R86x
        Wpw/v4HdYtPja6wWn3uPMFrMOL+PyWLtkbvsFq17j7BbXH68kc3i8Jt2Vot/1zayWGx+cIzN
        gcdj06pONo/NS+o9Wk7uZ/Ho27KK0ePzJrkA1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jNXrV7EUXBeoWDF3NnsDYxNvFyMHh4SAicTMLqMu
        Ri4OIYGljBLP/+xghYhLScxvUepi5AQyhSX+XOtiA7GFBD4xSrw+Yw5iswkYSvQe7WMEKRcR
        sJfY/k0EZAyzwGwmiTO/ellBaoQF7CReHt8I1ssioCoxcfY9FhCbV8Ba4tGPPhaI+fISqzcc
        YJ7AyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYLhuO/Zz8w7GSxuDDzEKcDAq8fBO
        YFweK8SaWFZcmXuIUYKDWUmEd37Lklgh3pTEyqrUovz4otKc1OJDjKZAyycyS4km5wNjKa8k
        3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PL988WC/bahO/qFnLe
        f0iCQyuXRXpCpUrKg2bfvifBbXMC66o3blQ4ekmw+M/3fosbxyufTd30ryT9zL3uH6e2i766
        bN3/b8lB75NvrZ4YTr7ykavg8TWNs5cYOb9LR35REDwQusj/jUjFLiY7Nfu5ez65L6qQU47a
        G+J/bXn4F8PTby9c4DytxFKckWioxVxUnAgAMsEoIm0CAAA=
X-CMS-MailID: 20191016145806eucas1p2d522901fc79e1ca6e03f1bb516a81370
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191016145806eucas1p2d522901fc79e1ca6e03f1bb516a81370
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191016145806eucas1p2d522901fc79e1ca6e03f1bb516a81370
References: <CGME20191016145806eucas1p2d522901fc79e1ca6e03f1bb516a81370@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series adds ASV (Adaptive Supply Voltage) support
for Exynos SoCs. Previous version can be found at:
https://lore.kernel.org/linux-arm-kernel/20190917181322.GA683@bogus/t/

The first one is a patch for drivers/opp adding support for adjusting
OPP voltage at runtime [1], including my update to also handle OPP min/max
voltage.

The dt-bindings patch has been converted to YAML and needs to be aplied
to Rob's tree as it depends on a patch already applied there
("daa629cdba21 dt-bindings: arm: samsung: Convert Exynos Chipid bindings
to json-schema").

Already applied dts patches were dropped from the series.

The patch set is based on for-next branch,
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git

Tested on Odroid XU3, XU3 Lite, XU4.

[1] "[PATCH v4 6/8] PM / OPP: Support adjusting OPP voltages at runtime"
    https://lore.kernel.org/linux-arm-kernel/1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com

Stephen Boyd (1):
  PM / OPP: Support adjusting OPP voltages at runtime

Sylwester Nawrocki (3):
  dt-bindings: arm: samsung: Update the CHIPID binding for ASV
  soc: samsung: Add Exynos Adaptive Supply Voltage driver
  ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS

 .../bindings/arm/samsung/exynos-chipid.yaml   |  31 +-
 arch/arm/mach-exynos/Kconfig                  |   1 +
 drivers/opp/core.c                            |  69 +++
 drivers/soc/samsung/Kconfig                   |  10 +
 drivers/soc/samsung/Makefile                  |   3 +
 drivers/soc/samsung/exynos-asv.c              | 179 ++++++
 drivers/soc/samsung/exynos-asv.h              |  82 +++
 drivers/soc/samsung/exynos5422-asv.c          | 509 ++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h          |  25 +
 include/linux/pm_opp.h                        |  13 +
 10 files changed, 919 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h

--
2.17.1

