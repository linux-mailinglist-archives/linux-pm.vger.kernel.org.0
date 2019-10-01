Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29DC34E8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfJAMzG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 08:55:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59273 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbfJAMys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 08:54:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191001125447euoutp01d8e24c20fbb218a8d35f32639952ffc5~JhxkjGUOH2364223642euoutp01E
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 12:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191001125447euoutp01d8e24c20fbb218a8d35f32639952ffc5~JhxkjGUOH2364223642euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569934487;
        bh=FRZw07xYV/3wwgOKgcBaHkQAtitosvAVLouSIu+mMzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfsJooGMhVFI1KEs0bQRPh7mZEpo7XSCG+O3lTHR1DSJwFtwK0L+KXhljY6OAs/Xu
         Z9h+uhrg9wp7OgQeb3pAprIG6sC9f/lJzwuRBhJgErNVbuWpsPXHzEv6UrdIUcgo0C
         GoYQIukxnaE/ubiiHQDKPbbn3/c4W0Terxk4ts6U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191001125446eucas1p1328389253e6441a21e3128788eed3da2~JhxkO-yxo2273722737eucas1p1J;
        Tue,  1 Oct 2019 12:54:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.FB.04309.69C439D5; Tue,  1
        Oct 2019 13:54:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191001125446eucas1p1fb2ad4c13feac8dfec8d5eeeeec0a64a~Jhxj569wP0786807868eucas1p1M;
        Tue,  1 Oct 2019 12:54:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001125446eusmtrp159943e5ef6acf48f09bd25ada70b427f~Jhxj5PbHB1469914699eusmtrp1y;
        Tue,  1 Oct 2019 12:54:46 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-6e-5d934c966cc2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.6D.04166.69C439D5; Tue,  1
        Oct 2019 13:54:46 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001125445eusmtip13bcde73093ffe8d4bfc91c2e04f40688~JhxjLfqXw2414524145eusmtip1S;
        Tue,  1 Oct 2019 12:54:45 +0000 (GMT)
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
Subject: [PATCH v2 3/4] ARM: dts: exynos: map 0x10000 SFR instead of 0x100
 in DMC Exynos5422
Date:   Tue,  1 Oct 2019 14:54:35 +0200
Message-Id: <20191001125436.24086-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001125436.24086-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7rTfCbHGtw/p2+xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGcfa/7AXPGKv+NS7mbGBcTdbFyMnh4SAiUTXv+vs
        XYxcHEICKxglfn9/wQThfAFybj1khHA+M0ocnvuECablQNdfFojEckaJJSsOMMO1/Jm5GqiK
        g4NNQE9ix6pCkAYRgcWMEt8OR4HUMAtsY5J4sOobK0hCWCBO4s3DXWA2i4CqxJZV28GO4hWw
        lzj+9SAjxDZ5idUbQBZwcnAKOEgsu7SVFWSQhMApdomjcw4yQxS5SCw+sgaqQVji1fEt7BC2
        jMTpyT0sEHaxREPvQqiaGonH/XOhaqwlDh+/yApyNLOApsT6XfoQYUeJL4tWg4UlBPgkbrwV
        BAkzA5mTtk1nhgjzSnS0CUFUa0hs6bkADR8xieVrprFDlHhItH5yg4TOZEaJn3fmskxglJ+F
        sGsBI+MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwLR0+t/xLzsYd/1JOsQowMGoxMM7
        4eXEWCHWxLLiytxDjBIczEoivDZ/JsUK8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCe
        WJKanZpakFoEk2Xi4JRqYFyucmTKIv07Ks0xq5Uendd71bbrdXxoevxHpa7ggJrtAmutPHhV
        thukL9L4acj6ZMcBuZmsX/prpdymnrz7fw/D5AXd+mbhGq4ZoX3NchbPK455hx4vfZZgyJBd
        e8a3s4DXgMHE6eecwobJTgVH+b2cc1W2vtm8tT2j737yoxcdi25V5YfKK7EUZyQaajEXFScC
        AKc7d31HAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7rTfCbHGty/IGmxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6Gcfa/7AXPGKv+NS7mbGBcTdbFyMnh4SAicSBrr8sXYxcHEICSxklpra9ZYRIiElM
        2redHcIWlvhzrYsNougTo8Tl+0+AEhwcbAJ6EjtWFYLERQSWM0ocW/WWGcRhFjjCJHF09TVG
        kCJhgRiJ7a0+IINYBFQltqzaDraZV8Be4vjXg1DL5CVWbzjADGJzCjhILLu0lRXEFgKqmbLv
        NeMERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNl27Gfm3cwXtoYfIhRgINRiYd3
        wsuJsUKsiWXFlbmHGCU4mJVEeG3+TIoV4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgFOeV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamAMCZl05NWkG6u56w9d
        5U6xOVoXfH+BKs9PuwaP2bM/5bY/vhKcMPPSNrnmRYUTm4OOPZupZxndWzb5dvHVpOXcKTf2
        pHU/7LWd9rPI5ia72eWwOz+iRHWFWhZf3rTAuSUksm5Ckn7Fwqe9UvvXrZNRmmN2Neb2lBP1
        bv++xXfv3Pq7WvdTImePEktxRqKhFnNRcSIA06hgvqoCAAA=
X-CMS-MailID: 20191001125446eucas1p1fb2ad4c13feac8dfec8d5eeeeec0a64a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191001125446eucas1p1fb2ad4c13feac8dfec8d5eeeeec0a64a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191001125446eucas1p1fb2ad4c13feac8dfec8d5eeeeec0a64a
References: <20191001125436.24086-1-l.luba@partner.samsung.com>
        <CGME20191001125446eucas1p1fb2ad4c13feac8dfec8d5eeeeec0a64a@eucas1p1.samsung.com>
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
index 45f63cd82e56..ac6dc44dbe4d 100644
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

