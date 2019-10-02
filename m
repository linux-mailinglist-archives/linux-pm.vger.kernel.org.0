Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923FAC476B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfJBGFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:05:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45484 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfJBGFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:05:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060507euoutp01e21248e877e3a8b517858e2bcfb43b2f~Jv1K2SJri1736217362euoutp01F
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:05:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060507euoutp01e21248e877e3a8b517858e2bcfb43b2f~Jv1K2SJri1736217362euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996307;
        bh=EWFRg+8V3OIo8aFqoZNFtrRcYuntoN7h44TTPr+nrkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srGpCNttP6knCQUBgx3jYWeZbfPEaAKrS7qx8qysBSbViBo00ivTjspdRAwDuxPJi
         +uWHQv3DGoBjnyZ3w28mcMnCXGabocJT2jJa5EYWqUFC46V9J7pW7cYafPWqqDwCKh
         vukt60F2RZz0ZmWxpAuOE6BPN7KfEiVNrmu+txNc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191002060506eucas1p22ee956f1587f12b3d3abd7a8976ff2f5~Jv1KkE9mL1656116561eucas1p2e;
        Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.D9.04309.21E349D5; Wed,  2
        Oct 2019 07:05:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60~Jv1KLbs6B1257012570eucas1p2q;
        Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002060506eusmtrp2eaee2dd30c61388f9b0a599dc2edd12f~Jv1KKwCew0112001120eusmtrp24;
        Wed,  2 Oct 2019 06:05:06 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-60-5d943e126bc1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.24.04166.21E349D5; Wed,  2
        Oct 2019 07:05:06 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060505eusmtip2fac233f17aa68714e6d59812cf48e561~Jv1JTt1rw0033000330eusmtip2D;
        Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
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
Subject: [PATCH v3 3/4] ARM: dts: exynos: map 0x10000 SFR instead of 0x100
 in DMC Exynos5422
Date:   Wed,  2 Oct 2019 08:04:54 +0200
Message-Id: <20191002060455.3834-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002060455.3834-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29m5aE6OU/RzWeIgqTCtVPpKMwOLBUIRQWBorTyoeN9xliU0
        Q8tJanhJkUxNTZuGtnTeo+ZISdSGoJKJtx+B99S85LB22rH+Pe9zeZ+Xj4/CxM24hIqKS2IU
        cfIYKWEt1H3aGjgqDigIPaZa8UBvixtwNLL2HUdlhgEc5c7MYWhwsJFE/Q/nSfRV5YK0M8M4
        Gmp/TqDVbANAxYPvBeiNYZxE1SNGARpLqyVQRpeBRN3zj3G03jsNAu1k9S/qgaytZJyUaTVq
        Qvau6oHs42KnQJbTpAGyVe2By2SItX84ExOVzCi8Am5aRy4vpYOEafLuq8KXhAp0EFnAioK0
        DzROVZixNSWmawHsn1ELLMMagNOZOcAyrJoVU7pgN7Ixm867agDc2NaDf5FldatZoSiC9oSt
        mkQu4EBXArjeHcJ5MFongJOadZwT7OkwmPGr6+8hQvogzBidEHJYRAfAXpNJaGlzhXWNHzAO
        W9Fn4eLEKMYtgvRnElY3bwOLKQiub47wAXs429NEWrAL/N1Wxp/NQlV2Be9PhTO5pbzHD3b3
        GHHuaIw+DBvavSz0OWjoXMY4GtK2cHTBjqMxM8zTFfG0CGY+Elvch2DTky98kSOsqX/GL5fB
        qpYS/q3yAOwdLwBPgWvJ/7JyADTAiVGysREMeyKOuePJymNZZVyE5+34WC0wf6a+nZ61VtBu
        uqUHNAWkNiLVlfxQMS5PZlNi9QBSmNRB5G/KCxWLwuUp9xhF/A2FMoZh9WAfJZQ6ie7vmbwu
        piPkSUw0wyQwil1VQFlJVEAZovFounjB9/VydN+Wd6Bv3cCUW4X+p6MkJssQpM1vWEgpLAr4
        Id3xVbc0EO6baZSR6Kg0OQ+X0rZGZfeKtzu2oPZ1XOr7VpOTOLd36FLQ+ZMFY7pKKu/qmVSv
        0hzJ6fnyoWD9QovfoI9XsMkpNHpKnKQANqfcnPfLr4UZaqVCNlJ+/AimYOV/AER5huVIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7pCdlNiDVb85rfYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jA/vWxgLHrFXLJu6iK2BcTdbFyMnh4SAicT3Vy1MXYxcHEICSxklJv39zgyREJOY
        tG87O4QtLPHnWhcbRNEnRomdP1+zdDFycLAJ6EnsWFUIEhcRWM4ocWzVW2YQh1ngCJPE0dXX
        GEG6hQViJJb8/gm2jkVAVaL1xn0WEJtXwE7ixJ8/LBAb5CVWbzgAtplTwF7i3f0bzCALhIBq
        /p+pnMDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgpGw79nPzDsZLG4MPMQpwMCrx
        8DYETY4VYk0sK67MPcQowcGsJMJr82dSrBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnA6M4
        ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo6igfm/kRsUAR9vi
        /301pryb/t2Jq9j/fdUBgZqpre8ZBJ+2p+7p9ahWDXoySeBv0pNkka1u58MsVrdK9HZ9/P5y
        q4GhoEQ/Z2yD43+Nfp1FPxnsUj3Wlr99Ov38lYLnkg4PVm3iWl8hu+xOvcSTmLDmLuOeHet+
        M3o1qLgeFG24NGmb9Ku/SizFGYmGWsxFxYkAP+hTaKoCAAA=
X-CMS-MailID: 20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
        <CGME20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60@eucas1p2.samsung.com>
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
index 98f6c71f57d8..c829bbdc5711 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -239,7 +239,7 @@
 
 		dmc: memory-controller@10c20000 {
 			compatible = "samsung,exynos5422-dmc";
-			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 0>, <16 1>;
 			interrupt-names = "drex_0", "drex_1";
-- 
2.17.1

