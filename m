Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C022A61F8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKDKiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:38:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47749 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgKDKhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:50 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103737euoutp020e89d5abaa19caba0aa1bf8331699bfd~ER8AHzZXe2966229662euoutp02h
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201104103737euoutp020e89d5abaa19caba0aa1bf8331699bfd~ER8AHzZXe2966229662euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486257;
        bh=aZmZ/FoJqHoTLO4+zTXCxyBDyba175tSw0+4Qh3yg/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9wfqEt6qAT+pKKEhnoQaVC+qaDumQUydWRotqO5H+f8wqF24AOjBqU/NQV1pRJ4h
         l2/0ADfWLoV3FFc2z+FHWnbBXRqsAwSqWxKDpDDK/PQnCAO4QRUWeWY0aE83DmaeI8
         eU69BeMwhZll5vsXKUiOdFu5HCtYfDwpu9zie+d8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103728eucas1p12484f8ca9c1e09fafe1fa34a67a648ec~ER74QFEaW3078630786eucas1p1w;
        Wed,  4 Nov 2020 10:37:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.8F.06456.86482AF5; Wed,  4
        Nov 2020 10:37:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e~ER731CdZL1145311453eucas1p2u;
        Wed,  4 Nov 2020 10:37:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103728eusmtrp1354338b1fa5706d47c202e785aaad583~ER73z6Xdg0620706207eusmtrp1E;
        Wed,  4 Nov 2020 10:37:28 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-24-5fa284683a0e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.85.06314.86482AF5; Wed,  4
        Nov 2020 10:37:28 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103727eusmtip2586e9f806ee1ec4683732c23bd18e85b~ER73BceSb0884408844eusmtip2P;
        Wed,  4 Nov 2020 10:37:27 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 6/7] ARM: dts: exynos: Add interconnects to Exynos4412
 mixer
Date:   Wed,  4 Nov 2020 11:36:56 +0100
Message-Id: <20201104103657.18007-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3pdCAWh4LhgkZigw+YsCmaGzYRiam8iAlPGIQKEyCypcMi
        PCCERSxLEAwgGEA0EaoEaKFBFsPSWkiBBkGQgBYDxKAgaCFsAaQdVN7+c+53/3P+m0tigo9c
        OzI6LpGWxIljhIQ5rny/pXOKyq4LdZ0bdUX66hyAWiqauGhy7RsX1ahGuGh8fYVA5d1yApXo
        i3Gk0zXzkHxugovGOp4RyFCoAqhC946DGlWfeWg6s55AOd0qHupfeshFFaWLhK+lSC57RIhm
        JroIkT5fwxEpXj4QFbXKgMggPxNIBJt7RdAx0cm0xMUnzDzq8bKSSBgi79fsbBEZoIonBWYk
        pNxhe4MMSIE5KaDqARzWKzhssQageiofZwsDgNrcEkwKSNOVUYM3238FoGFogPh3o6FFihl9
        CcoNFqqLgFFbU/4wd6Ha5IRReRhUtpeYICvqFqxtmcKNGqfOwco3YybNpzzh9Owyzi5oD183
        95h4M8rrYHIWj2Us4eDTeRODHTBZbVWYcQCkfvHg29lmHruqP1SPnGR9rOB3Teth6NNQW1qA
        s3wWgAWd0zy2KAZQr6kFLOUJZ0a2CaMRRjnCpg4Xtn0Vdg9WHz6FBfy0bMnuYAFLlOWHbT7M
        yxWwtAPckZVzWG0H8+f3D2OJoK52DCsGZyuPpKk8kqby/9xagMmADZ3ExEbSjFscneLMiGOZ
        pLhI5/D4WDk4+GzaPc3vdrD+4W4foEggPM7vUT4PFXDFyUxqbB+AJCa05vsNa+8I+BHi1DRa
        Eh8qSYqhmT5wisSFNvyLdYshAipSnEjfo+kEWvL3lEOa2WWAoBeXbXe/MCEr9vl4kO/e6o+F
        oKnrg6v1a9zNtr3+Y4qAUfUVBTPpUDb3BEx7WCxlpXgoyhrr413ChqU3gwd8A7J73dO8Oj2/
        hjrt794oDsy0iS/TXUj/GejSeyLdb3ZjeyXFUW+bp7Jmeto5FhvXti75BNzWpmx6j4Mufnp4
        nhBnosRu5zEJI/4D7fsP5GgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7oZLYviDZ7/FrK4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7GxLfb2ArOcFTM//2TrYFxNnsXIweHhICJxMXPtl2MXBxCAksZJbpuTWKBiEtJzG9R6mLk
        BDKFJf5c62KDqPnEKDHz0woWkASbgKFE79E+RhBbRMBD4lTrWlYQm1lgBrPE6VmmIHOEBfwl
        Vj9lAgmzCKhKzFpzGayVV8Ba4vaDtywQ8+UlVm84wAxicwrYAJ3TzA5iCwHVLH5+jgmiXlDi
        5MwnYKcxC6hLrJ8nBLFJXqJ562zmCYyCs5BUzUKomoWkagEj8ypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzAON127OfmHYyXNgYfYhTgYFTi4T2wbWG8EGtiWXFl7iFGCQ5mJRFep7On44R4
        UxIrq1KL8uOLSnNSiw8xmgK9NpFZSjQ5H5hC8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MEpcEXBSeKP9YMniaPVeu5Wvzjx96Lw6xPHpeWst/5t+qm5fpHyv
        rXrDLXq4a5fKorQ5rS7vPrVluRubd7AUlc87cTfSS2qe8e6aOMYtKbJBDepb+Zv7llSnZcpw
        RXWsjdyfdk9JderGdzu9H6/0iL3vrna1NEaKzWtBMn/wAtPYON8Srj9TlViKMxINtZiLihMB
        UkZdHOkCAAA=
X-CMS-MailID: 20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch adds an 'interconnects' property to Exynos4412 DTS in order to
declare the interconnect path used by the mixer. Please note that the
'interconnect-names' property is not needed when there is only one path in
'interconnects', in which case calling of_icc_get() with a NULL name simply
returns the right path.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v8...v5:
 - none.
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 4999e68..d07739e 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -779,6 +779,7 @@
 	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
 	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
 };
 
 &pmu {
-- 
2.7.4

