Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B6C4779
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfJBGF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:05:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45472 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfJBGFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:05:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060506euoutp019edddd4ed4104578a6771208593a099b~Jv1KV6zNF1488514885euoutp01X
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060506euoutp019edddd4ed4104578a6771208593a099b~Jv1KV6zNF1488514885euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996306;
        bh=vznnw8/ZImwrHPelkoL0LBLjMQ+XqOxLrcrGR3tiPIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLHUbwM0uLNcb8eksqDDnzQN1W2LJ+771grSSjkQuimvUjlGgY5f5x+BAfZc8Qbkx
         /TQXEyGW+oeTDU5ICipZEo0z++AwQ6LS5W8qhcRpHGDgqrHJwuVp45x8/zB/Nu55cd
         j2zIMnlsLPYPJgIS/ohjykh5CCBl0NBDReU2f/5E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002060506eucas1p1c302ac36b85ec6e83325c0351ac37669~Jv1J6yd9Q0353603536eucas1p1z;
        Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 64.62.04374.11E349D5; Wed,  2
        Oct 2019 07:05:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b~Jv1JUx3S40451004510eucas1p2x;
        Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002060505eusmtrp2d6cec5606a70442d5ce7a351c4767788~Jv1JUEe4Z0112001120eusmtrp20;
        Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-a2-5d943e110fc0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FE.14.04166.11E349D5; Wed,  2
        Oct 2019 07:05:05 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060504eusmtip22e10129d7ab4a3a21f1dcfc74dff71c9~Jv1If9uHN3226032260eusmtip2f;
        Wed,  2 Oct 2019 06:05:04 +0000 (GMT)
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
Subject: [PATCH v3 2/4] ARM: dts: exynos: Add interrupt to DMC controller in
 Exynos5422
Date:   Wed,  2 Oct 2019 08:04:53 +0200
Message-Id: <20191002060455.3834-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002060455.3834-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTYRTGe3d3d6/m4jojD6UJo8CCNLHiDXUVCY0IKrA/UlbOvE3JTdtV
        0wqafarlB/Zly7Qw0eZCm8Om+dVcTjFboqQUUWmYlBoxXYitcl6t/57znN95n8PhpQlJPbma
        Ttaks1qNMkUq8hY2ds06NklkNxSb9fvwk9I6Eg9NfyFxhe0ViYtGvxHY4aincN/5CQq/1QVg
        0+gbEg80l4mws8CGcKmjTYAf295TuGqoX4Df5dSI8KVWG4U7J66Q2NU9gnb6yo3lRiRv0r+n
        5CZDnkje8PCc/PlUi0BeaDYgudO09gAV6x2ZyKYkZ7LaUFm8d9Ll9glRmovKqq3ooXSoR5SP
        vGhgtkBNlY3KR960hKlB0Np1l+SLaQSzOWVCvnAi6Cl1oKWRIptRxDeqETjqB4X/Rp4a7UQ+
        omkREwIWw0nPwEqmEoGrM9bDEEyjAD4aXKSH8WMOQ3GXzCOFzHoo7KU8UszIwD0YxkcFQW19
        B+HRXswOmPowTHheAcZKgb7tGsFD0eA2Dyzu5gdf7WaK1wHwp6lCwGsOdAUPFpmzMFp0b5GJ
        gE57/8I2BLMB6ppDeXsXjJUPL9jArIDhSV+PTczLksbbBG+LIfeyhKeDwXzt9WLQKqg23qJ4
        RA6TN8P505QgGH/RTRSjIP3/rPsIGZA/m8GpVSwXrmFPhXBKNZehUYUcS1Wb0Pw/6v1tn7Gg
        tl8JVsTQSOojHo65rpCQykwuW21FQBPSleLIXyUKiThRmX2a1aYe1WaksJwVraGFUn/xmWUf
        4ySMSpnOnmDZNFa71BXQXqt1iP4cY8Fn9B2zCbRTMWcy9oxYrmqOfB/Xpgfun0skfI7T96Xr
        VC+tyO6OeqTdFmF/tn3H3rzczJGauIvxdYa5zGb3aLilZffZnPzAPsXBnyZcEtX4bS5i8E5W
        0Lr1/YdapyUNJ4J1ipn4jrGtldC9XLGHaA/8cSGaEjgV0Y5PUiGXpAzbSGg55V8/NAtnQwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7qCdlNiDSa/E7fYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jLb9b9gKvrFXrJ5/kr2B8SRbFyMnh4SAiUT/kTVANheHkMBSRolTJ74yQiTEJCbt
        284OYQtL/LnWBVX0iVHi788bQAkODjYBPYkdqwpB4iICyxkljq16ywziMAscYZI4uvoa2CRh
        gXCJS3vbmEEaWARUJfpOg/XyCthJ/L1iCDFfXmL1hgPMIDangL3Eu/s3wKqFgEr+n6mcwMi3
        gJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmCUbDv2c/MOxksbgw8xCnAwKvHwNgRNjhVi
        TSwrrsw9xCjBwawkwmvzZ1KsEG9KYmVValF+fFFpTmrxIUZToIsmMkuJJucDIzivJN7Q1NDc
        wtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjp966Ta9DDvvtcmRVsWd9ckVC
        dc1ZUT3Xjz/+yTyUnKG37JJW8+/VXz5EF3AssRY5Ge1oaX70Wfja+b/NTh2PPTwziCXxYvid
        W+YPbm5/xNr+h81nya5ne0zZrwksnXmdzVQ47qhnc0WFihRn0NNTTgwNj7Q0j/ae1yk/mrZY
        I6xqXsXa1qnySizFGYmGWsxFxYkA3EL4bKgCAAA=
X-CMS-MailID: 20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
        <CGME20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b@eucas1p2.samsung.com>
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
index 92c5e0d8a824..98f6c71f57d8 100644
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

