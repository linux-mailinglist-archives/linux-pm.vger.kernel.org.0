Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7721E88C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGNGs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 02:48:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51104 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgGNGs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 02:48:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200714064825euoutp015e825ca0585f07c5483db024bef37723~hi6oKNLlK1736817368euoutp01A
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 06:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200714064825euoutp015e825ca0585f07c5483db024bef37723~hi6oKNLlK1736817368euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594709305;
        bh=ktQQIQEMhkR4F9kpdyKQJsHX/Rt+fNec/hA6GOQDIDo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KnFLWT9eNSHFdbpy9cpUFYwAWafrfbss2bYHW6WMcqUHuR8oA/4wD3RgLLVaKDsrj
         oeNKula/6yFuaUGYR/f8OWsWjwwnT716ZLxhwdp5p/aHt5nR73xWJ+g4e7ZRtOoJPe
         b0fkw3OZXOAgeu7WFSEBCJfpujLazgGJjxNI9SpA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200714064824eucas1p26ebecc4a1e3f27faa81ae62b7a853164~hi6npld3e1846918469eucas1p2A;
        Tue, 14 Jul 2020 06:48:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 55.AA.06318.8355D0F5; Tue, 14
        Jul 2020 07:48:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104~hi6nRJW4M3028930289eucas1p2F;
        Tue, 14 Jul 2020 06:48:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200714064824eusmtrp1acc85bb4bcfb81bf88cd5c6a6bf0ac99~hi6nQflzQ2736027360eusmtrp1q;
        Tue, 14 Jul 2020 06:48:24 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-a8-5f0d55381fe0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.F6.06017.8355D0F5; Tue, 14
        Jul 2020 07:48:24 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200714064824eusmtip1439d6154bd89a5cef462cde69ec5befc~hi6m2prql0479804798eusmtip19;
        Tue, 14 Jul 2020 06:48:24 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] ARM: dts: exynos: Disable frequency scaling for FSYS bus
Date:   Tue, 14 Jul 2020 08:47:59 +0200
Message-Id: <20200714064759.31772-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7oWobzxBqtemVlsnLGe1eL6l+es
        FufPb2C3uLxrDpvF594jjBYzzu9jslh75C67xfppP1ktvp14xOjA6bFz1l12j02rOtk8+ras
        YvT4vEkugCWKyyYlNSezLLVI3y6BK2Nq5yu2gm98Ffsu3WFpYNzB08XIwSEhYCKxo8m8i5GL
        Q0hgBaPElXVz2LoYOYGcL4wSayanQCQ+M0rcWdfEAtPQ/jEMIr6cUWLTtIdMEA5Qwy6gq0C6
        2QQMJbredoFNEhGIl3jUf5cFpIhZoJ9J4vGZrYwgCWEBT4nGVbNYQGwWAVWJXe+7mEBsXgFb
        iea9X8BqJATkJVZvOMAM0iwhcJ9NYsXPqywQCRegbYeYIGxhiVfHt7BD2DISpyf3sEA0NDNK
        PDy3lh3C6WGUuNw0A2qstcSdc7/YQB5iFtCUWL9LHyLsKHGns5cV4k8+iRtvBUHCzEDmpG3T
        mSHCvBIdbUIQ1WoSs46vg1t78MIlZgjbQ+Jt02N2SDDGStyd8oJtAqPcLIRdCxgZVzGKp5YW
        56anFhvnpZbrFSfmFpfmpesl5+duYgQmhdP/jn/dwbjvT9IhRgEORiUeXgl/nngh1sSy4src
        Q4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbL
        xMEp1cC47vST0EXt02SnBc1MPp1gr77pfEXFPc7JRddiTL3zJjo4fmo7e5jJUv3N43n3rCPF
        2xyPW77p8/2WPLfVLy541Y2HYX1LijZz1ZQIpP29VyrvN9Pw/brwvkMRcUn3H6oeD5lg8OnN
        5Qfhb049znm249TjpetOXO5PnLOuLLFq9erbyndL2u6uV2Ipzkg01GIuKk4EAErnwcwGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xu7oWobzxBlMXyFtsnLGe1eL6l+es
        FufPb2C3uLxrDpvF594jjBYzzu9jslh75C67xfppP1ktvp14xOjA6bFz1l12j02rOtk8+ras
        YvT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL2Nq5yu2gm98Ffsu3WFpYNzB08XIwSEhYCLR/jGsi5GLQ0hgKaPEnX9tbF2MnEBxGYmT
        0xpYIWxhiT/Xutggij4xSsz+fZAdJMEmYCjR9bYLrEFEIFFi9sfZYEXMApOZJM4cPgLWLSzg
        KdG4ahYLiM0ioCqx630XE4jNK2Ar0bz3CyPEBnmJ1RsOME9g5FnAyLCKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMBy3Hfu5ZQdj17vgQ4wCHIxKPLwS/jzxQqyJZcWVuYcYJTiYlUR4nc6e
        jhPiTUmsrEotyo8vKs1JLT7EaAq0fCKzlGhyPjBW8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYI
        CaQnlqRmp6YWpBbB9DFxcEo1ME6XPSgaOs3ZIndhgoDxjYlz52496L+JbTFr0M85Ezb+Z9B+
        4DDp9qRH3qXsq9cruH60vhX2x/iQaPefVpZVJS9vK/y7bPnhruMu6XQ+8V2dttNqDFVvpmiE
        OfI1fS2UTzmi1ZypsFF/1w3bL7eThdp+Zc8vsPhV37QqiWlS1C2uR82uJkm6E5VYijMSDbWY
        i4oTAV32XFRdAgAA
X-CMS-MailID: 20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104
References: <CGME20200714064824eucas1p2ea0d2ee2c109c351fe489050905b4104@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the
values correct for Exynos5422 Odroids") changed the parameters of the
OPPs for the FSYS bus. Besides the frequency adjustments, it also removed
the 'shared-opp' property from the OPP table used for FSYS_APB and FSYS
busses.

This revealed that in fact the FSYS bus frequency scaling never worked.
When one OPP table is marked as 'opp-shared', only the first bus which
selects the OPP sets the rate of its clock. Then OPP core assumes that
the other busses have been changed to that OPP and no change to their
clock rates are needed. Thus when FSYS_APB bus, which was registered
first, set the rate for its clock, the OPP core did not change the FSYS
bus clock later.

The mentioned commit removed that behavior, what introduced a regression
on some OdroidXU3 boards. Frequency scaling of the FSYS bus causes
instability of the USB host operation, what can be observed as network
hangs. To restore old behavior, simply disable frequency scaling for the
FSYS bus.

Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Fixes: 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the values correct for Exynos5422 Odroids")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index ab27ff8bc3dc..afe090578e8f 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -411,12 +411,6 @@
 	status = "okay";
 };
 
-&bus_fsys {
-	operating-points-v2 = <&bus_fsys2_opp_table>;
-	devfreq = <&bus_wcore>;
-	status = "okay";
-};
-
 &bus_fsys2 {
 	operating-points-v2 = <&bus_fsys2_opp_table>;
 	devfreq = <&bus_wcore>;
-- 
2.17.1

