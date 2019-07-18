Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64EF6CFD7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfGROby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:31:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52678 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390797AbfGRObj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143138euoutp0279fb66615f1c6314786f6d578e5af805~yhtugO_jF3112231122euoutp02T
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718143138euoutp0279fb66615f1c6314786f6d578e5af805~yhtugO_jF3112231122euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460298;
        bh=VeOq8z3CUoZm2MZaPTACd0Fl7Ktn1jOuA+cXroSdAnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BicJAMhnnQe+GtZiHjI4Tk172nd1eccqCWWieYe2W0y55GXGwFeiWBQXDDZqNXxUL
         VJAQJh5eHTibPsjMaznC8glx5vdAw8CnhrGZgdMZXpUxscF67wUm6voTTgX1elYtIc
         /z89qNzD3gls68FHRuhxsydNSphGOTtCgZoFIV6g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718143137eucas1p26f38652c14fc89df0676efeabe31ce6c~yhttnCdB43227832278eucas1p2v;
        Thu, 18 Jul 2019 14:31:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D0.30.04325.9C2803D5; Thu, 18
        Jul 2019 15:31:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718143136eucas1p2cedfe5ed5e8e6316e82b30a565dc4855~yhts41akz3227832278eucas1p2u;
        Thu, 18 Jul 2019 14:31:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718143136eusmtrp249c2743ef7e228b9cb2f622da93afaa5~yhtsqyt-X0338803388eusmtrp2Q;
        Thu, 18 Jul 2019 14:31:36 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-e1-5d3082c9ae6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.B6.04140.8C2803D5; Thu, 18
        Jul 2019 15:31:36 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143135eusmtip11c933c0688eeb1b4cc2d60f7085409aa~yhtsEcM791531015310eusmtip1V;
        Thu, 18 Jul 2019 14:31:35 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 8/9] ARM: dts: Add "syscon" compatible string to chipid
 node
Date:   Thu, 18 Jul 2019 16:30:43 +0200
Message-Id: <20190718143044.25066-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7onmwxiDU6/4bfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxrPXCgXT2Ss+3Ytq
        YPzI2sXIwSEhYCLR3azaxcjFISSwglFiypNV7BDOF0aJIw9+MkE4nxkl3p5rBMpwgnXc3D6R
        ESKxnFGi+fsDZriW1U9vgFWxCRhK9B7tYwSxRQSEJe4tXQ42l1ngHpPE6adnmUASwgKBEue+
        PgZrYBFQlWh+eAnM5hWwluhbs5IRYp28xOoNB5hBbE4BG4nDd5+CrZYQmMwusWXGOjaIIheJ
        V2sPQ9nCEq+Ob4G6VUbi/875TBANzYwSPbtvs0M4Exgl7h9fALXCWuLw8Yvg8GAW0JRYv0sf
        Iuwo8eZ5DzSY+CRuvBUECTMDmZO2TWeGCPNKdLQJQVSrSPxeNZ0JwpaS6H7ynwWixEPi/nUT
        SAD1M0q8mnOHcQKj/CyEXQsYGVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEppTT/45/
        3cG470/SIUYBDkYlHt6AXINYIdbEsuLK3EOMEhzMSiK8t1/qxwrxpiRWVqUW5ccXleakFh9i
        lOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg9E9md/JIfH4n+u3UHvaSJ6Hf6xsycwu5
        np9ibix74n12+qprb+zENlRphoe/2/xPNTz3zsHu9CdfTXZ2HNTRne5j680y6Xf5BLFbm/5M
        Oh8r8FN9u/uBA+9Wfrk9uVb7/bxkk7WcydvXV8TlyN6vfdrwYW/5EcYjk2+xlqjklvz90Rxr
        /2X9OSWW4oxEQy3mouJEAOhmo7MlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7onmgxiDc5PkrPYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrPXCgXT2Ss+3YtqYPzI2sXIySEhYCJxc/tExi5G
        Lg4hgaWMEi8fXQdKcAAlpCTmtyhB1AhL/LnWxQZR84lR4tyiOWwgCTYBQ4neo32MILYIUNG9
        pcvZQYqYBV4xSdye958JZJCwgL9Ea4seSA2LgKpE88NL7CA2r4C1RN+alYwQC+QlVm84wAxi
        cwrYSBy++xQsLgRUM/vlNcYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBIb3tmM/
        t+xg7HoXfIhRgINRiYc3INcgVog1say4MvcQowQHs5II7+2X+rFCvCmJlVWpRfnxRaU5qcWH
        GE2BjprILCWanA+MvbySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxS
        DYwrvQ4wTD4Qprzxqi8jL7ebwpTqGVm+u8r1RB+umfcj74iV314mJsH9c97fvfIi4LdNhb6P
        3avpNzycnszgqM18k/lhyy/2JLW0Lear8o1W3nrubsqg6rpCO7lucnPR/ldlm15ZsJy+enyJ
        ye0f6fP1gp05TRJ9PGtWL3d2fL4sItVCdvvKMHUlluKMREMt5qLiRAD+gqS6hQIAAA==
X-CMS-MailID: 20190718143136eucas1p2cedfe5ed5e8e6316e82b30a565dc4855
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143136eucas1p2cedfe5ed5e8e6316e82b30a565dc4855
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143136eucas1p2cedfe5ed5e8e6316e82b30a565dc4855
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143136eucas1p2cedfe5ed5e8e6316e82b30a565dc4855@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CHIP ID block in addition to exact chip revision information
contains data and control registers for ASV (Adaptive Supply Voltage)
and ABB (Adaptive Body Bias). Add "syscon" compatible so the CHIPID
block can be shared by respective drivers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - new patch
---
 arch/arm/boot/dts/exynos5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 67f9b4504a42..4801ca759feb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,8 +35,8 @@
 		#size-cells = <1>;
 		ranges;
 
-		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+		chipid: chipid@10000000 {
+			compatible = "samsung,exynos4210-chipid", "syscon";
 			reg = <0x10000000 0x100>;
 		};
 
-- 
2.17.1

