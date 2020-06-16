Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46F51FAAD5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFPIM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 04:12:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54733 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgFPIMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 04:12:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200616081250euoutp0279b821d8d4474d8e5bbc3f27170b6555~Y_AWLo3N42347523475euoutp02j
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200616081250euoutp0279b821d8d4474d8e5bbc3f27170b6555~Y_AWLo3N42347523475euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592295171;
        bh=AWAMWTUTIZzqNOG8Dq390F6D/G8wFyFWzK2NpqNDPCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht+bkG2qZ+OdHZWy9XAQH7cki5AfIkHJY7wUUVe05eA6b1kA5P4N5oohA/sdDlyA7
         l7s0WSg6861ROmUE4ibkt9Q8iLJE37LPVECyR1xKW2s3e8yPISSUz6rZx+nLtzN+V6
         1cGhqToESw0ytNrFLdxDrCrE29ulrvNsbMyy6pM0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200616081250eucas1p155fffc189a23ff88a3ef5203276ad644~Y_AV30mTb2187921879eucas1p1P;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.5E.60698.20F78EE5; Tue, 16
        Jun 2020 09:12:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081250eucas1p2de7110898dad050866d78cb5d5120422~Y_AVbP8hL0677406774eucas1p2P;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616081250eusmtrp1da8be45a72185c83dd86ddb56d9f3d18~Y_AVan3io1259512595eusmtrp1g;
        Tue, 16 Jun 2020 08:12:50 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f7-5ee87f02fbd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.4A.07950.20F78EE5; Tue, 16
        Jun 2020 09:12:50 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081249eusmtip288f3c5634c8d95b3191234c8ab2da204~Y_AU3w65N0387603876eusmtip24;
        Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/4] ARM: exynos_defconfig: Enable big.LITTLE cpuidle driver
Date:   Tue, 16 Jun 2020 10:12:29 +0200
Message-Id: <20200616081230.31198-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616081230.31198-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOV2m+hdxBp0PlC02zljPajHvs6zF
        +fMb2C02Pb7GavG59wijxYzz+5gs3vx+wW6xsKmF3WLtkbvsDpwea+atYfTYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxobnN9kK1rNWrH/F2sB4g6WLkZNDQsBE
        4lT7dFYQW0hgBaNE2yr/LkYuIPsLo8T5oyeYIJzPjBKrP+1ghemY8bmXHSKxnFHixcm7jHAt
        VyasYwSpYhMwlOh628UGYosIpEvc+7sErINZYAKTxJvmfrBRwgI+Es9vXWYCsVkEVCXOfv8J
        dBQHB6+ArcTDabUQ2+QlVm84wAxicwrYSSzb/BzsJAmB/2wSL6d/YoQocpFo27oH6jxhiVfH
        t7BD2DISpyf3sEA0NDNKPDy3lh3C6WGUuNw0A6rbWuLOuV9sIJuZBTQl1u/Shwg7SqzrvMcK
        EpYQ4JO48VYQJMwMZE7aNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKGsD0klm3/AA2tiYwSR04v
        ZprAKD8LYdkCRsZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgenj9L/jX3cw7vuTdIhR
        gINRiYeXIeB5nBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xov
        ehkrJJCeWJKanZpakFoEk2Xi4JRqYGT6qbX0zaUdTya+yo1/E2K56ON8xvUr9YQ2PSp4xxOd
        aLF9z0rxb09e5a3d5f1yfeshN/a42afzmdjnr+lvmfZv8r/JvWu35ttF+b5UdJS4OuFf0JvK
        Ul7OBwKLp2ieS8+POn/q/4Vpz1ie+L0x6Bcs1qg7I/tltV8i++esRtfjds39kodCrkxVYinO
        SDTUYi4qTgQAZqCw9hsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xe7pM9S/iDK4fZLHYOGM9q8W8z7IW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyePP7BbvFwqYWdou1R+6yO3B6rJm3htFj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GRue32QrWM9asf4VawPjDZYuRk4OCQETiRmfe9m7GLk4hASWMkqcebwF
        KiEjcXJaAyuELSzx51oXG0TRJ0aJ9dvPgyXYBAwlut6CJDg5RAQyJRaeuwk2iVlgCpPEjnc7
        wRLCAj4Sz29dZgKxWQRUJc5+/wm0gYODV8BW4uG0WogF8hKrNxxgBrE5Bewklm1+DlYuBFSy
        7OxF5gmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEBvO2Yz+37GDsehd8iFGAg1GJ
        hzci6HmcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5Hxhp
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGAUMJRe6GcZEh9bl
        Ha+5tnrCAps1Xl7772cvYN2ROMPS7WIYc7++1Hb92+ubFapTFPg6RWXVVTze7vn+bernBv+a
        r2I7fvVc5158Ltz8zKEQVcP4u8zVypGHl/45fufH0//T52U0ce7r5Wxl9rUJTn9ZsfShQ5Sz
        wII6MY5ophX3r0jzCdtOUmIpzkg01GIuKk4EABQx07p8AgAA
X-CMS-MailID: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081250eucas1p2de7110898dad050866d78cb5d5120422@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable big.LITTLE cpuidle driver, which can be used on Exynos-based
Peach Pit/Pi Chromebooks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 374fbff8eaa6..c928bc710c48 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -28,6 +28,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.17.1

