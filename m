Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660632129CF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGBQiQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:38:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36772 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGBQiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:38:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163759euoutp024df58e807f5cc709f4753617d15c7754~d-N9IzSu50961909619euoutp02V
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200702163759euoutp024df58e807f5cc709f4753617d15c7754~d-N9IzSu50961909619euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707879;
        bh=qN7gRsF1kjmKcFbEWpr933ax6DRMuFS/ibl+GWK81pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkFRU1pomKmHhR5zOgR6egnfekASSD1Hbl+mEbjPUwBdRmZeQJ/onBVx1MIEHCMsK
         t2I+IgXY9r2thmn7DEmMZWM3dlsVfuC/uhasNNI/esEC2B8gNH9X0irVzb5V4bljMI
         a5g68HhyCSnY0azsFCOBw28a5z9UNFHza/yyI/8s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702163758eucas1p117788b2c4926de912805887398959a09~d-N8kvwYH0768907689eucas1p1v;
        Thu,  2 Jul 2020 16:37:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.6A.06318.66D0EFE5; Thu,  2
        Jul 2020 17:37:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702163758eucas1p1e18d95f3dce34df1f4334da5462a04a2~d-N8Oyjjf0151101511eucas1p1H;
        Thu,  2 Jul 2020 16:37:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163758eusmtrp1addaf8abf74460dba058d495bbc01255~d-N8OIIX61333013330eusmtrp1-;
        Thu,  2 Jul 2020 16:37:58 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-5b-5efe0d66a914
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.F9.06017.66D0EFE5; Thu,  2
        Jul 2020 17:37:58 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163757eusmtip2c12b8db80e1ebc176525229fcd1bac83~d-N7efCvU2919929199eusmtip2C;
        Thu,  2 Jul 2020 16:37:57 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 5/6] ARM: dts: exynos: Add interconnects to
 Exynos4412 mixer
Date:   Thu,  2 Jul 2020 18:37:23 +0200
Message-Id: <20200702163724.2218-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702163724.2218-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3t3d10tr1PwYNJj5B891MzCHzkie8D+qBBBoiht6m2aTm1X
        LfdHbytbiqjko7B3iVHa0lHWVOZqmuQkXUUayxe5yAVtJlpazrse/33nO993vnPg0IS0VxhE
        p2XmsJpMZYaMEpOGF1PW0IOS2YS1122A7TUFCD+srBfit+5PQnzV3C3EfRNfKVxh1FO41F5C
        Yqu1QYT1w2+EuLf5CoVdRWaEK60tAnzf/EGE+0/WUrjAaBbh9i/nhLiyzEFt9lPo6wopxcCb
        Z5TCrrMIFI9uHVcUN9YhhUu/JJbaK5ansBlpeawmfNMBceq98mPZRfRR3eSeE2iIuoB8aGDW
        Q890EXkBiWkpU4tAV95C8YUbQVNbq4AvXAhaB43CP5Y7BZe8lrsI+p8Mkn8tbluHyKOimAgo
        el6MPDiA2QZnR2vmRQRzngDD41LC0/Bn4sHRPjQ/lmRCYKamcJ6XMBuh1jYu4uOWwr2Gtjme
        pn2YaGh3SXiJH3RWjZAeTMxJTjddJjzzgRkXgfuj2+vdBvfPOEke+8NnS6OXD4ausoskbziN
        4OLTfhFflCCwW64hXhUNA93TlCeZYFZCfXO4BwITAx12NQ8XwbtxP36HRVBqqCB4WgLnz0r5
        GSvgR12FgMdBoBv55d1GAbVlk4IStLz6v2uq/7um+l/sNUTUoUA2l1OrWC4ykz0SxinVXG6m
        Kiw5S61Hc6/WNWuZeIxafiaZEEMj2ULJWOdMglSozOPy1SYENCELkGx51ZUglaQo87WsJitR
        k5vBcia0mCZlgZLIG479UkalzGHTWTab1fzpCmifoBOIKWk0v6wvDpdTocZdx5NWhGstC4LF
        vuQ+o0OeWvWa3l0adsOZHvGt+vDtvo5lcRvytvjKU9es21NlitrB7TQQ1pj0eEqV/GDml8kY
        dCo2zhnVHaP+MZT//tTNAVqbaKBXjw6PTTmfLJk9NKS0fb8aGZKicZQzPYR4wrI1a7tWRnKp
        yohVhIZT/gZWTv82ZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7ppvP/iDFr7mC3uz2tltNg4Yz2r
        xfUvz1kt5h85x2px5et7NovpezexWUy6P4HF4vz5DewWmx5fY7W4vGsOm8Xn3iOMFjPO72Oy
        WHvkLrvF7cYVbBate4+wWxx+085qMWPySzYHQY9NqzrZPO5c28Pmcb/7OJPH5iX1Hn1bVjF6
        fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJexekpdQS9HRff3yAbGR2xdjJwcEgImEstap7F0MXJxCAksZZT4+XgVkMMBlJCSmN+iBFEj
        LPHnWhcbRM0nRomrj1cwgiTYBAwleo/2gdkiAh4Sp1rXsoLYzAIzmCVOzzIFsYUFgiXmPeph
        BrFZBFQl/s7rBLN5BawkVlx9yw6xQF5i9YYDzCB7OQWsJQ5/5gUJCwGVHOtfwA5RLihxcuYT
        sNOYBdQl1s8TgtgkL9G8dTbzBEbBWUiqZiFUzUJStYCReRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZglG479nPLDsaud8GHGAU4GJV4eCcc/xsnxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTK
        qtSi/Pii0pzU4kOMpkCfTWSWEk3OByaQvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZ
        qakFqUUwfUwcnFINjJs/7t9Zse3uM//0g66qbnXulxn3ahTwzi922CV2hr/sTOmFJ2zv+bK1
        vhko/0/my/nNMN/2YYWOj/iesHuPp1RPsI0POjg7me+RGssDd3n2ab52rx1mTOH+VnszeJVV
        nZr/V/4Au8izMZIzOPdZ1KZ1rj67S4rdXzNUkcsyur/hju1px3+FSizFGYmGWsxFxYkAe7DS
        GugCAAA=
X-CMS-MailID: 20200702163758eucas1p1e18d95f3dce34df1f4334da5462a04a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163758eucas1p1e18d95f3dce34df1f4334da5462a04a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163758eucas1p1e18d95f3dce34df1f4334da5462a04a2
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163758eucas1p1e18d95f3dce34df1f4334da5462a04a2@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch adds an 'interconnects' property to Exynos4412 DTS in order to
declare the interconnect path used by the mixer. Please note that the
'interconnect-names' property is not needed when there is only one path in
'interconnects', in which case calling of_icc_get() with a NULL name simply
returns the right path.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes for v5, v6:
 - none.
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 24529d4..e0be193 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -777,6 +777,7 @@
 	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
 	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
 };

 &pmu {
--
2.7.4

