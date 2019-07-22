Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7966FCA4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfGVJrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42180 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfGVJre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094733euoutp022ed1a4cdb5b54349dc0fcaea9453f85e~zsa0_WnHS2886828868euoutp02l
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094733euoutp022ed1a4cdb5b54349dc0fcaea9453f85e~zsa0_WnHS2886828868euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788853;
        bh=780SP4kncWfgZ+yoXX6+SOGKZxP85S28KmhHTw/7MOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaDiKXk2HvB5xSmOpXfMRnuVIaJAY+NPfxP5SEqjlqhEIgKzSnt/rOprjlHsmI5vQ
         WYaHj12tWpYw4oVzyGESdQEqSBTUhB6cQBmntnC8vMOZ6U++WCRD5JrGGzOnqVseOH
         IJbCoDDHODinildeM8RwNdxYDvac8M/P/kt0W8jE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722094732eucas1p2ebd25dc937462bb723fcb78fe5e9c5fd~zsaz63lu32318723187eucas1p2Z;
        Mon, 22 Jul 2019 09:47:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 43.50.04325.336853D5; Mon, 22
        Jul 2019 10:47:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094731eucas1p20a1dd09d90eef3415a37e7fc86efe2df~zsazGwidZ2318723187eucas1p2Y;
        Mon, 22 Jul 2019 09:47:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722094731eusmtrp24f036f018636ee420e6334fbfc2bfa51~zsay4l3Q72448224482eusmtrp2w;
        Mon, 22 Jul 2019 09:47:31 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-0d-5d35863313fa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.E1.04146.236853D5; Mon, 22
        Jul 2019 10:47:30 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094730eusmtip225d3ea854d2c31f98152991d467c8dbe~zsax8XL911053010530eusmtip2G;
        Mon, 22 Jul 2019 09:47:29 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 7/9] ARM: dts: exynos: add syscon to clock compatible
Date:   Mon, 22 Jul 2019 11:46:44 +0200
Message-Id: <20190722094646.13342-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRz3e557Xrq6PJ3GTyXbYaOll1X85jXGPJjN5C+WnHqU1V11jxCx
        U4pyXVa4ppertaQXqist6b0jFV1NU5MMzVRC9LJRStdz+O/z/Xw/L/v+9qNx6RjhQJ9SnuZU
        SnmYjBSLqp7+NK33SvDx94g1eaLy9FIC9U58IpDe2Emg4u+DAMXllZIorT0LQ8+vK1DK4Gcc
        mUxlFHoRO0qh12on9F3zlkAvazJJNJ5sBCjdVI+h+8YBCuX3dmOou3036r98j0TxdUYKtYxe
        JdDsq3IRaujZh/qnbdHUsw/Adzlbkl0C2KnJVBH7rS+eYjPU3SL20Z0BijUUJZJsQ1YJxSbH
        fSXZpq+1GKutLAJsRccFdtzgfNDmiHhLEBd26gynct92XBxi/HIXRHRanet98wtTg3g6CVjR
        kPGGM/UZeBIQ01LmHoDlI4mWYQLAwtrnhDCMA/jpzUPw11KX2mJZFAA4pNVT/yyN14ZESYCm
        ScYNVhdFmg32TDqAGUN+Zg3OvMeh9n7mQtISZi+8equOMGMRswbGXula4CXMdqhP1eJC20pY
        XNaImzOtGF843Kow50Aml4YFeTqLZhccymwjBbwEjrRWUgJ2gnOP9JiAeahOzrVcEAMHU7Is
        ms2wpbWbMOfjzDpYWuMu0Dtg9ou2hVMgYwv7vtiZaXweplbpcIGWwGsJUkG9FlZquixFS2FB
        yW1KkLBw8KGj8DhpAOpq58ANsPLO/64cAIrAMi6KVwRzvJeSO+vGyxV8lDLYLTBcYQDz/7Bj
        tnWyGtTPnGgGDA1kNhKPKm9/KSE/w0crmgGkcZm9ROnh4y+VBMmjz3Oq8ABVVBjHNwNHWiRb
        Jrmw6N1RKRMsP82FclwEp/q7xWgrBzWozjkWLF3KRV9csaGsCdd4u7rst75k2G8dMVxsK4kY
        GXnXFRaT4bG44qWf9pvXjLOzIWC20W3MWn9gT3baoVj3BxNkvqux83bLJmZAs8YrcPjk2s+S
        H9M9ddiB36MJkZjrqpsVW302fozThTzZ+Xi1XYq9Rn24MKiwONQoTjPlLVLKRHyI3NMFV/Hy
        P3QZHPKDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pGbaaxBscbbCw2zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFkuvX2SyuHjK1eJ24wo2i9a9R9gtDr9pZ7X4d20ji8X+K14W
        t3/zWXw78YjRQdJjzbw1jB7fvk5i8Xh/o5XdY3bDRRaPnbPusntsWtXJ5rF/7hp2j97md2we
        B9/tYfLo27KK0WPz6WqPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DKOvF3GWHCOs+L6nV9MDYytHF2MnBwSAiYSeycdZu1i5OIQEljK
        KLH+xQ92iISYxKR926FsYYk/17rYIIo+MUo8WrCApYuRg4NNQE9ix6pCkLiIwBxGiZ9d2xhB
        HGaB38wSB+/2g3ULC3hKtE/dywpiswioSjS1XGAEsXkF7CXmT+pjhtggL7F6wwFmkKGcAg4S
        L4/ngoSFgEr2v9jOOIGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAGN127OfmHYyX
        NgYfYhTgYFTi4TXYZhIrxJpYVlyZe4hRgoNZSYQ3z8A0Vog3JbGyKrUoP76oNCe1+BCjKdBN
        E5mlRJPzgekjryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDI8sq
        Oa2Z7ssvztCrslTXlfvgl7b/dmZ5vtO5ah/etZE+M76eilwbwOVVV/By5/SWKuvL13Tyj2/f
        P+vZlGDVbyyS/35l5uixS09brH/VRa753sxVzPcXnNxdckbr69ZbuXdd2JhW7es2uTLLppX3
        o7jsxs1Veg+nfs0/b7feZdUl0fbHfLsrpJVYijMSDbWYi4oTAR7cXJLnAgAA
X-CMS-MailID: 20190722094731eucas1p20a1dd09d90eef3415a37e7fc86efe2df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094731eucas1p20a1dd09d90eef3415a37e7fc86efe2df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094731eucas1p20a1dd09d90eef3415a37e7fc86efe2df
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094731eucas1p20a1dd09d90eef3415a37e7fc86efe2df@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get the clock by phandle and use it with regmap it needs to be
compatible with syscon. The DMC driver uses two registers from clock
register set and needs the regmap of them.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 55d4dbf6f83a..97dc10915680 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -175,7 +175,7 @@
 		};
 
 		clock: clock-controller@10010000 {
-			compatible = "samsung,exynos5420-clock";
+			compatible = "samsung,exynos5420-clock", "syscon";
 			reg = <0x10010000 0x30000>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b319fd65..0a2b3287ed92 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,7 +17,7 @@
 };
 
 &clock {
-	compatible = "samsung,exynos5800-clock";
+	compatible = "samsung,exynos5800-clock", "syscon";
 };
 
 &cluster_a15_opp_table {
-- 
2.17.1

