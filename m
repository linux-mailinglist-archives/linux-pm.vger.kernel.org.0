Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648C745978
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFNJx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54619 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfFNJxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095331euoutp02b74587aab4054c818a2ae80ffa47cc78~oB-MtSU311768017680euoutp02S
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614095331euoutp02b74587aab4054c818a2ae80ffa47cc78~oB-MtSU311768017680euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506011;
        bh=3WP8EDAu+5H7APsQt9nFgGZ+xA43IHtfClvOa7dqrls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBoSP/JfJJTRgXu0aKvZ/4X9ssVCKBtOs7zD0rbMszqWiCklG5z3OUGy2w+O+b941
         CjqsGDBKsPEyBspJ4nvIeTEQEgvYEjQrk4sAOnHnJuEMfTBJb8nSJ+Hm95Dg3K+/TZ
         FO569DTUyEyVJDHEEu0bB2hYGVt+GpxufZRxY+eM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095330eucas1p1484189a2d0e7f14ae2ed9a6567e31d47~oB-L2A05u1135711357eucas1p1U;
        Fri, 14 Jun 2019 09:53:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.F1.04325.A9E630D5; Fri, 14
        Jun 2019 10:53:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095329eucas1p267244e53d4f5612c46d6cc2c6bc0ed75~oB-K1Qhk20481304813eucas1p2E;
        Fri, 14 Jun 2019 09:53:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095329eusmtrp2a2f884bccaf5c5740f0273008ab65404~oB-Klccoq2148621486eusmtrp2E;
        Fri, 14 Jun 2019 09:53:29 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-27-5d036e9ab2a2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 19.EA.04140.99E630D5; Fri, 14
        Jun 2019 10:53:29 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095328eusmtip25b243a5db5b914867ff8f07033c2204d~oB-JotxdA2320823208eusmtip2S;
        Fri, 14 Jun 2019 09:53:28 +0000 (GMT)
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
Subject: [PATCH v10 10/13] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Fri, 14 Jun 2019 11:53:06 +0200
Message-Id: <20190614095309.24100-11-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3Z2Lq4mxyn5ZVGwblY4uxEfWlmRcIqCQDQyRq08qbhN21HT
        jFjKrKxVJNmy5rTswso0XZZWXqZmrMuyiUVmaAuM1Mx0gqSWp7Pqv+d93t/7Pu8HH4XJuvEg
        KlGbyuq0KrWckIirn469CinUYsrlnUML0D1TOY7ejvTiyNL8Cke3h9wA5VwrJ1C+wyxCL05p
        0Fl3H4aczgoSvczuJ9F7/Rw0dPojjly1Vwg0bGwGyOSsE6Gy5i4StTkiUeexWwRq6j+Oo8mO
        e2JU374Vdf70RaPPPoENgcyo57yYGXxnIJnL+jYxU1PYRTKV1pMEU2++QzLGnG8E0/jtsYg5
        Y7MCpup5FjNcOXfH9FjJ2jhWnZjO6kLX75UkOFo8WMoLIqO92AP0wIbnAR8K0quhJbeDzAMS
        SkbfArB97CUQihEA9YMluFAMA3j8e6soD1B/RpoeJAv+TQAdJof430Rxn5nkIYJWwIfWg3xE
        AG0C8PKXKJ7B6AcYHOj8AHjGn46G9w1JPCOmF8LxMZeI11J6AzT1NAPhvHnwdkUDxmufKb/F
        0k/weyBtpGBVj0EkQJuhte8kJmh/+LXVRgp6DvxVY/EyHNQbS7xLj0D3WbOXCYdNrW04fw9G
        L4HltaGCvRGea+z1vtcXvhvw421sSp6vvogJthSeyJUJdDC0nX7tDZoJb94p8C5n4If7RQSv
        ZXQ+gCOl88+BeYX/s4oBsIJANo3TxLPcKi17SMGpNFyaNl6xP1lTCab+3fPJVs9DUDe+zw5o
        CshnSBvCREoZrkrnMjV2AClMHiAtCseUMmmcKvMwq0veo0tTs5wdzKbE8kBp1rTu3TI6XpXK
        JrFsCqv72xVRPkF6sLMkaKhhZd3VjTMsE1HVs4wTbMiWiAhnmvJLr2ua+sbrTa7DCmlWU3Qw
        5nGlLI2N3V61+FNPTJmsfCGM6fh8gUvfNPdRtq85MnLZyusKv5yquz6ll7b1F7l3/Xjiv843
        UvnGXJERZjAdKMg+FbfG7uyWLBo+at+n9ntryLCsComOlou5BNWKpZiOU/0GuqDQ5HMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7oz85hjDVqfKFpsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZZw6+pW54AxbxZUFXxkbGLewdjFycEgImEgc3p7fxcjFISSwlFGi5+oepi5GTqC4mMSkfdvZ
        IWxhiT/XuthAbCGBT4wS7x66gvSyCehJ7FhVCNIrIjCHUeJn1zZGEIdZ4CyzxO4Vb8AGCQsE
        S8y89hOsmUVAVeLPz8tgcV4BB4kZD48wQiyQl1i94QAziM0JFD86/w0byAIhAXuJ7zP4JzDy
        LWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYgduO/dyyg7HrXfAhRgEORiUe3gNWTLFC
        rIllxZW5hxglOJiVRHjnWTPHCvGmJFZWpRblxxeV5qQWH2I0BbppIrOUaHI+MDnklcQbmhqa
        W1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgnNjlpVqiWWz1Vvi9+7RClr6w
        k78nOGR91Cra++UcV97r6xtr5uv94rq5eI+12qRdGRM+/lDrzIiMiVMNfOaXqHdXlEsm5MuG
        b+v/bfGunNo/oangoWncfRbJqFtCttKh0zpPFxjs2XSL93TQBSG7BrllWSUFuvuUIjf2/V2m
        do7nuemnDQZ+SizFGYmGWsxFxYkAOuKcwdYCAAA=
X-CMS-MailID: 20190614095329eucas1p267244e53d4f5612c46d6cc2c6bc0ed75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095329eucas1p267244e53d4f5612c46d6cc2c6bc0ed75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095329eucas1p267244e53d4f5612c46d6cc2c6bc0ed75
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095329eucas1p267244e53d4f5612c46d6cc2c6bc0ed75@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the chipid label which allows to use it in phandle from other device.
Use syscon in compatible to get the regmap of the device register set.
The chipid is used in DMC during initialization to compare compatibility.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
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

