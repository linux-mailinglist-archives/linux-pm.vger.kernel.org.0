Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E038D2B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfFGOfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:35:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50197 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfFGOfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143535euoutp01aea02e7d35d129969e8ce2868914946a~l8Uej28Jd0066800668euoutp01k
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143535euoutp01aea02e7d35d129969e8ce2868914946a~l8Uej28Jd0066800668euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918135;
        bh=XPlbzfyPq+2tb60F1xt6+L5cVtwUM4v/x4YUlMpHRb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWKQeSD5Cagr2monoHa9NAwUaL0sJ5USCSqP06DbhS9bpstrH3xF7RFDXTxt6v+yp
         Yb5wp3b9MrYYJuR0ma3N35TQWZSOkTdeCRM2VGZOREAsPslNUTyecO/KmFV0vTnuKJ
         z2xCiYD1RcBpLcyKSbQcAW05pzwekeci2apndMwY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143535eucas1p2607c6f6279a9319db4110a294f07ffd3~l8Ud71cmJ2700727007eucas1p2b;
        Fri,  7 Jun 2019 14:35:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 31.E0.04325.6367AFC5; Fri,  7
        Jun 2019 15:35:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143534eucas1p24e5bf121447c6e9a7ef546cf15f3d6fa~l8UdE73a02699926999eucas1p2q;
        Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143534eusmtrp2a391362055a4d32d8d61ce5cbc8fa5a1~l8Uc1Tthb1494514945eusmtrp2C;
        Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-a6-5cfa76362c1b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.56.04146.5367AFC5; Fri,  7
        Jun 2019 15:35:34 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143533eusmtip1f3f6f839bd417272146dd9f0eaaf27f6~l8Ub78pXd2929529295eusmtip1C;
        Fri,  7 Jun 2019 14:35:33 +0000 (GMT)
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
Subject: [PATCH v9 11/13] ARM: dts: exynos: add syscon to clock compatible
Date:   Fri,  7 Jun 2019 16:35:05 +0200
Message-Id: <20190607143507.30286-12-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7vPaZPbrDyZaAyUMjNLiwNKGBTc/KsoEMqolReVnNWurtIe
        U8nlcloaKpragzBmZU2zKaH5oIlmy2bPpa3sRalTp9FDrV2v0X+f3/d8f9/f7xwOjckdhC+d
        lJLKqVOUyQrSA294+NO6ar3mV1zY2MdIdKe0lkAvJj4TqKrjMYFqxgYByr5aS6KirgoJenRW
        hQoGv2HIar1NoZ6sIQq91vqhsbwBAtmaLpLIZegAqNTaLEE3O/op1Nu1Gdkzr5OofUhHoJnn
        d3DU0heD7L+90PfO9yDah/0+WYizzpenKbZc24uzjWX9FGsy5pJsS8UNijVkj5Bs68h9CZtf
        bwRsXXcG6zL5b/Xc6REVzyUnaTj16g17PRKd1hfEocfSo4aCSlwLTtN6IKUhEwGNla24HnjQ
        cuY6gHZXLyEWEwBO3WoEYuECcKDSRvxrufYqe5blTDWAWfVIZHeHrX2HHtA0yYRCs/GwIC9k
        SgEs/7JdyMGYexgctr8BgsebiYG611sED84EwivOltlIGRMNdZZ+UhwVAGtuP8AElrr18gYz
        KeRAxkDDgaw+XDRtgj2tU3O7ecOvlnpKZD/4p7FKIjIPtYbLQOTjcLCgYs4TCdstwo1p93Ir
        YG3TalHeCO3jvRJBhowXfDm8QJAxNxY2lGCiLINncuSiezmsz3syN2gxrL5RPBfOQkt/ASW+
        YBGA+tFz5DkQUPZ/2CUAjMCHS+NVCRwfnsIdCeWVKj4tJSF0/0GVCbj/XfeMZdIMmqf2tQGG
        Bor5Mpb6GScnlBr+mKoNQBpTLJRpnvyIk8vilcfSOfXBPeq0ZI5vA0tpXOEjy5jn2CVnEpSp
        3AGOO8Sp/51KaKmvFpScDGumMp0XP6Rv0NcFfVo0vS0kIrKzPH5JlGtxccRgaqxOEjTh6NQ8
        6p6uKwuf2miXjwSzOeGO0iCqJmo435Qb90xSZUMl598bdzu2X/B/B1J9x0Y3d/m8HS88+jDW
        c2UsFt0zZLzbnpYZMnAqcDhH9/XNCat57dPJdcu8ApeMKnA+UbkmGFPzyr/ibswgcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7pmZb9iDJrbmSw2zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFhdPuVrcblzBZnH4TTurxb9rG1ks9l/xsrj9m8/i24lHjA7i
        Ht++TmLxeH+jld1jdsNFFo+ds+6ye2xa1cnmsX/uGnaP3uZ3bB4H3+1h8ujbsorRY/Ppao/P
        m+QCuKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        Mt6fv85acI6zord/HksDYytHFyMnh4SAicTSm82sXYxcHEICSxkl/q6+zwqREJOYtG87O4Qt
        LPHnWhcbRNEnRomXv74xdjFycLAJ6EnsWFUIEhcRmMMo8bNrGyOIwyxwllli94o3TCBFwgJe
        Eu23PEEGsQioSix6vx9sAa+Ag0T78btsEAvkJVZvOMAMYnMCxWdv28EG0iokYC+x6rnDBEa+
        BYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjcNuxn5t3MF7aGHyIUYCDUYmH14HhZ4wQ
        a2JZcWXuIUYJDmYlEd6yCz9ihHhTEiurUovy44tKc1KLDzGaAt00kVlKNDkfmB7ySuINTQ3N
        LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw5kaJTvD/tSbp8iHn4rjOjAfL
        Y8Wr+Z+KVu3nihf8FT6NmaU+eTd7ZdSjI21OO24zPeCSy92eHX3+CL+ZVt3ySR23ij05X8w7
        evB8mpvZy7fnNZIE5TPihbwOm6xlzHmzzzA4vnT9sks+zn7pqg0rZfJKXPb7hJ5q96y79HPB
        Q9PFl57vm6KvxFKckWioxVxUnAgATafAytcCAAA=
X-CMS-MailID: 20190607143534eucas1p24e5bf121447c6e9a7ef546cf15f3d6fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143534eucas1p24e5bf121447c6e9a7ef546cf15f3d6fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143534eucas1p24e5bf121447c6e9a7ef546cf15f3d6fa
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143534eucas1p24e5bf121447c6e9a7ef546cf15f3d6fa@eucas1p2.samsung.com>
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

