Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E321FAAD6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFPIM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 04:12:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54740 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFPIMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 04:12:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200616081251euoutp0224925d38174b5a14dbcdc293d60799b7~Y_AWg93-w2285522855euoutp02D
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 08:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200616081251euoutp0224925d38174b5a14dbcdc293d60799b7~Y_AWg93-w2285522855euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592295171;
        bh=t+LeSgDb8yZiggnUrlN5WU6K26V0DBW3GJJdVArjas0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+jCOQIWkDGe9XGLIqdRn3w3dPjQyrpSKh2T4lHysEkAI0fN6GtaoskT83MfGVXv+
         gWeajrzI0vI/B/8AhaLm9bdPL6Tuu3vSGvUbT6I9J3dkep1w1JtfOQsjMdb8GBKzgQ
         Jl1jzPiRNtruHSWgiMvwqzzutkHR0VngL6gAfYtY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200616081250eucas1p2448a2a68035538b80b7a0ade6d623821~Y_AWLczxx2000720007eucas1p2F;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.5E.60698.20F78EE5; Tue, 16
        Jun 2020 09:12:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3~Y_AV5DEGu0048500485eucas1p2o;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616081250eusmtrp11e628046414c848eeef3b46c4e5d342c~Y_AV4dJ0E1314613146eusmtrp1s;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f8-5ee87f02c16d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.4A.07950.20F78EE5; Tue, 16
        Jun 2020 09:12:50 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081250eusmtip269bdae8437e63967952de0a9644e93bb~Y_AVXwV1D0491904919eusmtip2j;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable big.LITTLE cpuidle
 driver
Date:   Tue, 16 Jun 2020 10:12:30 +0200
Message-Id: <20200616081230.31198-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616081230.31198-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOV2m+hdxBrN3WlhsnLGe1WLeZ1mL
        8+c3sFtsenyN1eJz7xFGixnn9zFZvPn9gt1iYVMLu8XaI3fZHTg91sxbw+ixaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujFdHH7EWnGatOLt3MnsD4xeWLkZODgkB
        E4m1/5aB2UICKxglOibadDFyAdlfGCXufrvNDuF8ZpS4P2sJM0zHnm1LoRLLGSXWfPvPDNdy
        dd9bsCo2AUOJrrddbCC2iEC6xL2/S8A6mAUmMEm8ae5n7WLk4BAWCJCYe6AGpIZFQFVizbIW
        sHpeAVuJY7v+s0Nsk5dYveEA2ExOATuJZZufM4HMkRBoZpc4unEmI0SRi8TTmXOZIGxhiVfH
        t0A1y0icntzDAtXAKPHw3Fp2CKeHUeJy0wyobmuJO+d+sYFcxCygKbF+lz5E2FHi7dtuJpCw
        hACfxI23giBhZiBz0rbpzBBhXomONiGIajWJWcfXwa09eOESNLQ8JGZc/MwKCaCJQCd8fcQ2
        gVF+FsKyBYyMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQITyOl/x7/uYNz3J+kQowAH
        oxIPL0PA8zgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQy
        VkggPbEkNTs1tSC1CCbLxMEp1cDYuFwpojD2gdyP3fkpvemnNW45KemL31j3b86SKVsyzK90
        sm3glHpxosxUO156z36v06q9Rz9UTyj/u/GXvQij0d47586edyldki/WK3Myedet9Lk8seVd
        Ag7vLv7o3lq3+qiY1VrHhu7p654eNbr8/nXvl1sTEs8ZipQ7L2L0MxLM4go9Ha+jxFKckWio
        xVxUnAgAxvgoMhwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xe7pM9S/iDJZMULXYOGM9q8W8z7IW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyePP7BbvFwqYWdou1R+6yO3B6rJm3htFj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6Ga+OPmItOM1acXbvZPYGxi8sXYycHBICJhJ7ti1l72Lk4hASWMoosenk
        dkaIhIzEyWkNrBC2sMSfa11sEEWfGCWOflwLlmATMJToeguS4OQQEciUWHjuJtgkZoEpTBI7
        3u0ESwgL+Emc3TyRHcRmEVCVWLOsBSzOK2ArcWzXf3aIDfISqzccYAaxOQXsJJZtfs4EYgsB
        1Sw7e5F5AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEBve3Yzy07GLveBR9iFOBg
        VOLhjQh6HifEmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4H
        RlteSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGzPMiHCVJYq82
        eG0TEbk96/Pe7yGnref2NJt8Vu/XPX0qMOnj3h8V7Wymt0QXHP8hVRDa94fvx4e7Ue/LZ3t8
        ktMz9Cou2tRWWFPvE90y6aibVpP0w2NXz2+4uUB+rsO0OA45F5aLSmqWr9YpWpxYcHhNeF5v
        4QZ7vqe3G3U33p+64s96zxfrlViKMxINtZiLihMBc07dp34CAAA=
X-CMS-MailID: 20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable big.LITTLE cpuidle driver, which can be used on Exynos-based
Peach Pit/Pi Chromebooks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 95543914d3c7..6a922a8ef712 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -111,6 +111,7 @@ CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_ARM_TEGRA_CPUIDLE=y
-- 
2.17.1

