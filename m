Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E710745970
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfFNJxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35960 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfFNJxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095332euoutp01c418c7f534577cfe07c32e670d4b9df9~oB-NaYbE10765507655euoutp01h
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095332euoutp01c418c7f534577cfe07c32e670d4b9df9~oB-NaYbE10765507655euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506012;
        bh=XPlbzfyPq+2tb60F1xt6+L5cVtwUM4v/x4YUlMpHRb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiW9QC7jkimSEIlewiSdFaosQIWTnrQh51XDViIOWDR3FBKRstLnSdhlVqVydwyoF
         4N6KKQfY7DWlq5lnbYuGD8Thu0ZQdaINCzfzUx2w+5XSe6t9B2zLCA0QUriYQa1/Rq
         p0iyHE/e3+1A89mQHIXLUehcDOQfxG/q2G1BgCmg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095331eucas1p137e4eaa455ce37ff2a83602547e207b3~oB-MbDSbb1136911369eucas1p1b;
        Fri, 14 Jun 2019 09:53:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.30.04377.B9E630D5; Fri, 14
        Jun 2019 10:53:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614095330eucas1p1e5a73f31251af7d16caf951054ec9def~oB-Lslhg41132211322eucas1p1U;
        Fri, 14 Jun 2019 09:53:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095330eusmtrp2860581b0046f331e7b4c7da0e4e24230~oB-Lc2EHh2148621486eusmtrp2H;
        Fri, 14 Jun 2019 09:53:30 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-34-5d036e9b715e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.EA.04140.A9E630D5; Fri, 14
        Jun 2019 10:53:30 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095329eusmtip235d4f4c89b2f064166a50d31022a4e15~oB-KjK-v82261522615eusmtip2x;
        Fri, 14 Jun 2019 09:53:29 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v10 11/13] ARM: dts: exynos: add syscon to clock compatible
Date:   Fri, 14 Jun 2019 11:53:07 +0200
Message-Id: <20190614095309.24100-12-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzH+z6/7uk4e5zUd0rlNiu2fpnsSxgb9siYITYWjp6dpju5px8K
        2+VWka5aWVKdWHSpKAnVqCQuoZNQk0gpId2stNEPenou/nt/X5/3+/v+7Lsvjcs/kvPoUE0E
        p9UowxSUlLjz+FezV44GD/a1jsvRzaxSErUNfyZRXkMziYp/9ACkzy+lUEaTEUPPzqpRas83
        HFksZRL0/NSABL3VuaAfye9J1FqdS6EhQwNAWZYaDF1v6JSglqb1qCOukEIPBxJJNPHmJoFq
        XwWijtFZaKSxG6xxYkd+phOstT1ewuboWgi2KrtTwpYXnaHYWmOJhDXoByn2weA9jE2pKALs
        rafH2aFy160zdktXhnBhoVGc1mf1fukhq6WNDG+2P2ZIvUjoQDydBOxpyCyF554UEElASsuZ
        QgCv5mdR4mEYwHRjDyW45MwQgH29AdOJUUsGLppMAFpf/Zb8S3QXpE0maJpivGFl0VEh4MBk
        AZjTv13w4MxdHH7veAeEwRxmE3xZdgUTNMEshE1m41RWxqyBfambxTI3WFxWhwvafhI/yhuY
        2g4yBhrmd12hRNM6WDl+GhP1HPjVXCERtQv8U5Vn4zzUGS4DUZ+APalGmycAPjS3kEIvziyC
        pdU+Il4Lu2pMQMCQmQXbv88WMD4p0++cx0Usg6cT5KLbE1Ykv7AVOUJTSabtchZmNKbY3jMD
        wLTeOCINuGX/L7sEQBFw4iJ5tYrjl2i4aG9eqeYjNSrvg0fU5WDy4z2dMA9XguqxA/WAoYFi
        pqxuBRYsJ5VRfIy6HkAaVzjILgbgwXJZiDImltMe2aeNDOP4euBMEwon2XG7rj1yRqWM4A5z
        XDinnZ5itP08HXCu+WO65Gw9WIfdlxp1y5vdE/QnXPS3NzL983OD7La36m9kj/ENPn4Oez0U
        gwmqMfRoU8WqTP+TQOrh2+6VmDDT9cXqC7s8af+d/dc+STFHx7j8penWBZ6hX167t44GwNgN
        cwPVA9sat4yOZLP6jnU7TkVHLWurCvKiHsTqn38wKwj+kNJvMa7llX8BfNBSH3QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7qz8phjDR71y1lsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        Zbw/f5214BxnRW//PJYGxlaOLkZODgkBE4nf5yczdzFycQgJLGWUuP31FhNEQkxi0r7t7BC2
        sMSfa11sILaQwCdGiW9v+bsYOTjYBPQkdqwqBOkVEZjDKPGzaxsjiMMscJZZYveKN2CDhAW8
        JS5tWAJmswioSpw6PpcNpJlXwEHiWb8vxHx5idUbDjCD2JxA4aPz34CVCAnYS3yfwT+BkW8B
        I8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwAjcduznlh2MXe+CDzEKcDAq8fAesGKKFWJN
        LCuuzD3EKMHBrCTCO8+aOVaINyWxsiq1KD++qDQntfgQoynQSROZpUST84HJIa8k3tDU0NzC
        0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6NY76oplrMunVr2kCFIIzip44nu
        tAVHHV9M9+VLvu5+Ojaodcu1nXNZTaIONrXyr39v9uPx4XTrV8KbDBx5JZ53rpTY2rR//7cp
        Si/Krp2MODiHx/34/aW83SYxt34uVdG+cca75JjRiwXqaktu3+FRN9ZZdN7x9JP/VQpTvs3Z
        +Wue+/1HGgZXlViKMxINtZiLihMBkuS70tYCAAA=
X-CMS-MailID: 20190614095330eucas1p1e5a73f31251af7d16caf951054ec9def
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095330eucas1p1e5a73f31251af7d16caf951054ec9def
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095330eucas1p1e5a73f31251af7d16caf951054ec9def
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095330eucas1p1e5a73f31251af7d16caf951054ec9def@eucas1p1.samsung.com>
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
index 5fb2326875dc..d153617ff1a3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -173,7 +173,7 @@
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

