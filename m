Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E39BE250
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505119AbfIYQSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 12:18:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59802 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502081AbfIYQSq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 12:18:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925161844euoutp01e93b60d61602a38614a23503c9848960~Hur76vJQJ0250602506euoutp01Q
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 16:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925161844euoutp01e93b60d61602a38614a23503c9848960~Hur76vJQJ0250602506euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569428324;
        bh=aUsdMGonTqAWq+GWFlk5Uy2pEHFhH5/xFpuHLZ6vFFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7AeI6SlNTG8WsbnNhk3dK78xsqcmVRLFRvd2HID3cdfgj4fHG5iEU4kSNogecSxR
         oUoe/qI71nqc7EET1Z3SVSr/rRN63dLA6shO8CDjyswEMdUVF9FEiiBzohilnrUKN5
         K7whOHGA6Jm8R+5cqkqfbhVv1I0m0mI4wvQVatsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190925161843eucas1p244d94d9f0c07f565f2443d631724623d~Hur7WM4ZD0603606036eucas1p2k;
        Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.FC.04469.3639B8D5; Wed, 25
        Sep 2019 17:18:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190925161843eucas1p1abaa1aaa20fcf5c55c9e52bb6a491317~Hur62C0Iz0799507995eucas1p1y;
        Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925161843eusmtrp10b96972ed299b44f2e62cc2aef086b89~Hur61KknF0531705317eusmtrp1m;
        Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-2f-5d8b93630c27
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.14.04166.3639B8D5; Wed, 25
        Sep 2019 17:18:43 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925161842eusmtip1e57b81fb6968461fac7aa18c6ea00622~Hur6FGMp70353003530eusmtip1Y;
        Wed, 25 Sep 2019 16:18:42 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 2/3] ARM: dts: exynos: map 0x10000 SFR instead of 0x100 in
 DMC Exynos5422
Date:   Wed, 25 Sep 2019 18:18:12 +0200
Message-Id: <20190925161813.21117-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925161813.21117-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87rJk7tjDW5vNLXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujNtzvjEVXGWveHOni6mBcQNbFyMHh4SAiURXP0sX
        IyeHkMAKRoktM4O6GLmA7C+MEo8PH2KEcD4zShzffo0ZpAqkYdnTJWwQieWMEm2nD7PAtdxa
        PQ9sLJuAnsSOVYUgDSICixklvh2OAqlhFtjGJPFg1TdWkISwQLTEgj07wGwWAVWJHZ+3M4LY
        vAL2Es/bWlggtslLrN5wAGwzp4CDxKe3O5lABkkIHGOXaL48G+okF4m3sy6wQ9jCEq+Ob4Gy
        ZSROT+6BGlQs0dC7kBHCrpF43D8XqsZa4vDxi6wgRzMLaEqs36UPCRZHiX/7qiFMPokbbwVB
        ipmBzEnbpjNDhHklOtqEIGZoSGzpucAEYYtJLF8zDWq2h8TsydOZIKEzmVFi9btPrBMY5Wch
        7FrAyLiKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMCWd/nf80w7Gr5eSDjEKcDAq8fAe
        COuOFWJNLCuuzD3EKMHBrCTCO0umK1aINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTE
        ktTs1NSC1CKYLBMHp1QDo4vOkfel10xtLrR+FrqT5tqhxjrjRfCTnJfhwh5GTJqWeY9Wp8/g
        vNbzO3OZzNmeINnZOgo9V+ds4uQtre5xzFUMP7ZlkqLTt3Jug8uNO8y+cb6WKNmTXm8uq7JR
        bX9IffPSjrZCtTjn3LrkOXvruT8/DorZPOXKNNVLkxa8yucUDM7+fWqHEktxRqKhFnNRcSIA
        4ilE2UUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7rJk7tjDZ6+FLXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jNtzvjEVXGWveHOni6mBcQNbFyMnh4SAicSyp0uAbC4OIYGljBJfVt9jgkiISUza
        t50dwhaW+HOtC6roE6PEujm9QAkODjYBPYkdqwpB4iICyxkljq16ywziMAscYZI4uvoaI0i3
        sECkxJeuuWDrWARUJXZ83g4W5xWwl3je1sICsUFeYvWGA8wgNqeAg8SntzvBrhACqVlzgmkC
        I98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgbGy7djPzTsYL20MPsQowMGoxMN7IKw7
        Vog1say4MvcQowQHs5II7yyZrlgh3pTEyqrUovz4otKc1OJDjKZAR01klhJNzgfGcV5JvKGp
        obmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkaBP/GTv7s9nSfBz2B3f9Wp
        6cy1zk8DJb8tncbGX31B79qrG00H5xh+vxtw+VFt99oHDkrcPy0XZ6TcmzZvLef/hDc2Qi4v
        Fomq9kYEH37u4/nxQEb1Y/48f7/fAY7nExLeMrx8nnH335WNzgESp844bVo2b+PNknW76tqe
        T2p2WLRrylxza25rJZbijERDLeai4kQAJo2teqsCAAA=
X-CMS-MailID: 20190925161843eucas1p1abaa1aaa20fcf5c55c9e52bb6a491317
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190925161843eucas1p1abaa1aaa20fcf5c55c9e52bb6a491317
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190925161843eucas1p1abaa1aaa20fcf5c55c9e52bb6a491317
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
        <CGME20190925161843eucas1p1abaa1aaa20fcf5c55c9e52bb6a491317@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a need to access registers at address offset near 0x10000.
These registers are private DMC performance counters, which might be used
as interrupt trigger when overflow. Potential usage is to skip polling
in devfreq framework and switch to interrupt managed bandwidth control.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 72738e620d11..b695f07f7eed 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -239,7 +239,7 @@
 
 		dmc: memory-controller@10c20000 {
 			compatible = "samsung,exynos5422-dmc";
-			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 0>;
 			clocks = <&clock CLK_FOUT_SPLL>,
-- 
2.17.1

