Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8978C34EA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfJAMzG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 08:55:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36794 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbfJAMys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 08:54:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191001125446euoutp02e8a7922bd3387ceef084ca53bb92665e~JhxkCRb4j2342323423euoutp022
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 12:54:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191001125446euoutp02e8a7922bd3387ceef084ca53bb92665e~JhxkCRb4j2342323423euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569934486;
        bh=PpWKyDmydHtOPxqWzMFW/iVCNPUXbzoiAejFA8kjhHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DURd+T4ui7IDAlN0MsZCENj80/rt892dPP6s000aspUWJIvH3ijxfkEResWPG6Q7U
         Z0ghPYdO80P4iHved3NyHfvLG8X8uJJVwC8vruhG9lWJ3fgBd4LafhDqEpKY/0GQxr
         D22M9DVvZ/OWeEMZSYMby/G7YGnCDiGm3Wz+c8io=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191001125446eucas1p16aee0a57fcdaa144e77435816b0b3f50~JhxjnVzyn2261922619eucas1p1V;
        Tue,  1 Oct 2019 12:54:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.E6.04469.69C439D5; Tue,  1
        Oct 2019 13:54:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191001125445eucas1p21ea21a92cec96d660994d8d7f91128e0~JhxjP5Bko2030020300eucas1p2y;
        Tue,  1 Oct 2019 12:54:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001125445eusmtrp159ce962d55950884ef059f9b8e54fcf3~JhxjPOtSR1469914699eusmtrp1u;
        Tue,  1 Oct 2019 12:54:45 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-9d-5d934c9622ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.D5.04117.59C439D5; Tue,  1
        Oct 2019 13:54:45 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001125444eusmtip13eee4dda350294e71d313d53522657ab~JhxidadUa2359723597eusmtip1M;
        Tue,  1 Oct 2019 12:54:44 +0000 (GMT)
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
Subject: [PATCH v2 2/4] ARM: dts: exynos: Add interrupt to DMC controller in
 Exynos5422
Date:   Tue,  1 Oct 2019 14:54:34 +0200
Message-Id: <20191001125436.24086-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001125436.24086-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87rTfCbHGjyYz2yxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGV+/bmIt+MZeMXPGbpYGxpNsXYycHBICJhI9F5qY
        uxi5OIQEVjBK7L30lAXC+cIocWLdCSYI5zOjxPdvn4BaOMBani0qgYgvZ5TYuvEfI1zHjAlv
        WUCK2AT0JHasKgRZISKwmFHi2+EokBpmgW1MEg9WfWMFSQgLREp83PmTHcRmEVCVWNmzCewm
        XgF7ifPXr7NA3CcvsXrDAWYQm1PAQWLZpa2sIIMkBM6xS/y7/JERoshFYs75l8wQtrDEq+Nb
        2CFsGYnTk3ugBhVLNPQuhKqvkXjcPxeqxlri8PGLrCBHMwtoSqzfpQ/xpKPEpod8ECafxI23
        giDFzEDmpG3TmSHCvBIdbUIQMzQktvRcYIKwxSSWr5kGNdtD4unTPmh4TmaUmHR6DvsERvlZ
        CLsWMDKuYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExKp/8d/7SD8eulpEOMAhyMSjy8
        Fs8nxgqxJpYVV+YeYpTgYFYS4bX5MylWiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0
        xJLU7NTUgtQimCwTB6dUA2PLFJXqz1cW2b5V+yu++PdFjld3Ft3UTaqr0hXQbnM+nJ+oUBsa
        /WDdi4RU419vFSfFCLnsFlF42Rs61yriYt+b00dv/F2+4XT64aMurwyVJrza9u/g3o1n3+6N
        kb7v0GC7teKZoeBKJv8tcyO0zB5G+Dgu2bk+3UZ3SWJNGVegZoiehjFH7GQlluKMREMt5qLi
        RACj95jYRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7pTfSbHGvSeUbfYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jK9fN7EWfGOvmDljN0sD40m2LkYODgkBE4lni0q6GLk4hASWMkosmt/D3sXICRQX
        k5i0bzuULSzx51oXG0TRJ0aJU9fOMII0swnoSexYVQgSFxFYzihxbNVbZhCHWeAIk8TR1dcY
        QbqFBcIlftw6wARiswioSqzs2cQGYvMK2Eucv36dBWKDvMTqDQeYQWxOAQeJZZe2soLYQkA1
        U/a9ZpzAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYKRsO/Zzyw7GrnfBhxgFOBiV
        eHgtnk+MFWJNLCuuzD3EKMHBrCTCa/NnUqwQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wOj
        OK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Nc++L96eUx/zZF
        3KxfGlmdfLy6Zdra0Mvh6f96jS9uvpj45p+Ex9Mb7UvjeY+mKopH2N2OfOyXMd1ly8cHAgkK
        K/a9+6uh69uTfajEZ/qDNYuKHj6QsXyy5tP7xMYupmvrHZeyt0pypsdGNL/jE+DyNP6ZepPR
        ua3rw6offgZKxXIXHSb2rlZiKc5INNRiLipOBADmPvGqqgIAAA==
X-CMS-MailID: 20191001125445eucas1p21ea21a92cec96d660994d8d7f91128e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191001125445eucas1p21ea21a92cec96d660994d8d7f91128e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191001125445eucas1p21ea21a92cec96d660994d8d7f91128e0
References: <20191001125436.24086-1-l.luba@partner.samsung.com>
        <CGME20191001125445eucas1p21ea21a92cec96d660994d8d7f91128e0@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
XU3-family boards. It will be used instead of devfreq polling mode
governor. The interrupt is connected to performance counters private
for DMC, which might track utilisation of the memory channels.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ac49373baae7..45f63cd82e56 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -240,6 +240,9 @@
 		dmc: memory-controller@10c20000 {
 			compatible = "samsung,exynos5422-dmc";
 			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 0>, <16 1>;
+			interrupt-names = "drex_0", "drex_1";
 			clocks = <&clock CLK_FOUT_SPLL>,
 				 <&clock CLK_MOUT_SCLK_SPLL>,
 				 <&clock CLK_FF_DOUT_SPLL2>,
-- 
2.17.1

