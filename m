Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB91FAAD1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgFPIMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 04:12:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42960 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFPIMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 04:12:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200616081249euoutp010bb94a6508f529ff8f83a76f61e6a9d9~Y_AUylDoF1800818008euoutp01D
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200616081249euoutp010bb94a6508f529ff8f83a76f61e6a9d9~Y_AUylDoF1800818008euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592295169;
        bh=122xkcSZ6not3U6lZOAxMuLg/4SWMmRDS+BIqk4WVkU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aMLuh1PlElG4O57HP+AmjtNXbEuT/Yg1Oty2iTCbMifIThZiZWp+Yu1e3SnasrsPc
         MgYp8WRjfffTQCWsH5BZ/iSc3fzlBBYk55km057a0cJ7PBLuN6Zs/dieSGdIuibL6a
         y3r6gIs6emm93qWpj9K8ebbD+J9kkhmZ/P9OUfuY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200616081249eucas1p2735465f1130251edf898292439e100b9~Y_AUWrKJu0702807028eucas1p2B;
        Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.49.60679.00F78EE5; Tue, 16
        Jun 2020 09:12:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c~Y_AT6PS-s0901609016eucas1p1F;
        Tue, 16 Jun 2020 08:12:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616081248eusmtrp14438154dbfef14344d3542f669f9dc3b~Y_AT5n2LU1314613146eusmtrp1l;
        Tue, 16 Jun 2020 08:12:48 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-d6-5ee87f0016ed
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.3A.07950.00F78EE5; Tue, 16
        Jun 2020 09:12:48 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081248eusmtip21c0577272d923dad351f1aeab7877c04~Y_ATagn430387603876eusmtip22;
        Tue, 16 Jun 2020 08:12:47 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/4] Restore big.LITTLE cpuidle driver for Exynos
Date:   Tue, 16 Jun 2020 10:12:26 +0200
Message-Id: <20200616081230.31198-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7oM9S/iDD5ONrfYOGM9q8W8z7IW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyePP7BbvFwqYWdou1R+6yO3B6rJm3htFj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGbt6LrMXvOaoWL/nLVMD4zT2LkZODgkB
        E4k3/w+xdDFycQgJrGCU2PRlHyuE84VRou/4JCjnM6NET+tyFpiW78cnM0IkljNK7Nsygw2u
        5fDCR4wgVWwChhJdb7vYQGwRgXSJe3+XsIMUMQtMYJJ409zPCpIQFnCUOPptFhOIzSKgKjH3
        zQ+wFbwCthJPdt1mhlgnL7F6wwFmkGYJgddsEh2PZjJCJFwkNt7ezARhC0u8Or4F6iUZidOT
        e1ggGpoZJR6eW8sO4fQwSlxumgHVbS1x59wvoPs4gG7SlFi/Sx8i7ChxsXEbC0hYQoBP4sZb
        QZAwM5A5adt0Zogwr0RHmxBEtZrErOPr4NYevHAJ6mYPiWV/L4HFhQRiJdZt288+gVFuFsKu
        BYyMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJTxel/x7/sYNz1J+kQowAHoxIPb0TQ
        8zgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEk
        NTs1tSC1CCbLxMEp1cCoUfOlXNxA92k7r+nfd91rdDbfk1Hqv3LTwIevQHWJfoZcbeVLqVVn
        jfiD1y91dQ70zv/GMetqydJbPhJFR+d9dhb7ZK4wS2GLDavYqUf6ujKqAYvCn19RqZGz2rFB
        1pWfMfu52RSrkBfmJYaFijynjhqY6J1QuafpnD3haY9H7vH+De9PzlFiKc5INNRiLipOBABY
        wv8kEQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xe7oM9S/iDFb3y1tsnLGe1WLeZ1mL
        8+c3sFtsenyN1eJz7xFGixnn9zFZvPn9gt1iYVMLu8XaI3fZHTg91sxbw+ixaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jF09l9kLXnNUrN/zlqmBcRp7FyMnh4SAicT345MZuxi5OIQEljJKdJ07
        yQSRkJE4Oa2BFcIWlvhzrYsNougTo8ThSdtZQBJsAoYSXW9BEpwcIgKZEgvP3WQHKWIWmMIk
        sePdTrCEsICjxNFvs8CmsgioSsx98wOsmVfAVuLJrtvMEBvkJVZvOMA8gZFnASPDKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMAA3Xbs55YdjF3vgg8xCnAwKvHwRgQ9jxNiTSwrrsw9xCjB
        wawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOUTmaVEk/OB0ZNXEm9oamhuYWlobmxubGah
        JM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHRdstpKX6Hit9ZZT7PE5ZzP1g9S9y3WNegqvWd
        ouL0gh07/Go4tMUcBB/znJu+xHDztFNKOltVuZUVDMMmKNcpR349pXJFI+HI7WlrC+dMC5qe
        43FN9XCj2pSZfr0vFV+oznz+7eOG4/cCd3MZ/SydXVr9sE5rX0+U8cnV6xk77l/uEPTrZ0xU
        YinOSDTUYi4qTgQAZ8R2XmYCAAA=
X-CMS-MailID: 20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c
References: <CGME20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ARM big.LITTLE cpuidle driver has been enabled and tested on Samsung
Exynos 5420/5800 based Peach Pit/Pi Chromebooks and in fact it worked
only on those boards.

However, support for it was broken by the commit 833b5794e330 ("ARM:
EXYNOS: reset Little cores when cpu is up") and then never enabled in the
exynos_defconfig. This patchset provides the needed fix to the common
code and restores support for it. Thanks to Lukasz Luba who motivated me
to take a look into this issue.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (4):
  ARM: exynos: Apply little core workaround only under secure firmware
  cpuidle: big.LITTLE: enable driver only on Peach-Pit/Pi Chromebooks
  ARM: exynos_defconfig: Enable big.LITTLE cpuidle driver
  ARM: multi_v7_defconfig: Enable big.LITTLE cpuidle driver

 arch/arm/configs/exynos_defconfig    |  1 +
 arch/arm/configs/multi_v7_defconfig  |  1 +
 arch/arm/mach-exynos/mcpm-exynos.c   | 10 +++++++---
 drivers/cpuidle/cpuidle-big_little.c |  3 +--
 4 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.17.1

