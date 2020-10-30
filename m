Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBC2A05E8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgJ3Mxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60847 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgJ3Mx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125307euoutp02ca89439c86c946b283f32ada74ed93a5~Cxj5CQyhl0138901389euoutp02g
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030125307euoutp02ca89439c86c946b283f32ada74ed93a5~Cxj5CQyhl0138901389euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062388;
        bh=fet2ponKEy0YryCgB52D90pw902HEnhsqFlkHJ+BVEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qm9htZ2AaUELvMpCWUjRl7Vw0jVOvm6EeaVDG7pfYxB2YRWBLEqpicaGpg91dBIKA
         KvyW3rKO2hnSwcmU/nqwv76tFm8bVvjAS31yhL5zF1jFtyHYYZDBG0etvBhXrboLyW
         m2aky8o5G5ug4xbiTHNJIjQddbFajE/DitwD3ve4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030125307eucas1p261962324a2a441dccc971c9d14835091~Cxj4pR8UA1110711107eucas1p2c;
        Fri, 30 Oct 2020 12:53:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.16.06456.3BC0C9F5; Fri, 30
        Oct 2020 12:53:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201030125307eucas1p14afc8cc8828f2bc838e769b77d7e9c95~Cxj4PGG_12028320283eucas1p16;
        Fri, 30 Oct 2020 12:53:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125307eusmtrp112e4707551c707b5ca2e7e864601955a~Cxj4H7ndB0319303193eusmtrp1C;
        Fri, 30 Oct 2020 12:53:07 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-ee-5f9c0cb35a61
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.3A.06314.2BC0C9F5; Fri, 30
        Oct 2020 12:53:06 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125306eusmtip2a9849176234987f2c2631d75b9758f26~Cxj3cVLtp1523015230eusmtip2-;
        Fri, 30 Oct 2020 12:53:06 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 5/6] ARM: dts: exynos: Add interconnects to Exynos4412
 mixer
Date:   Fri, 30 Oct 2020 13:51:48 +0100
Message-Id: <20201030125149.8227-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7qbeebEG/w5KGNxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFscftPOajFj8ks2BwGPTas62TzuXNvD5nG/+ziTR9+WVYwenzfJBbBGcdmk
        pOZklqUW6dslcGX8fHCSuWAyR8WsDw9ZGxifsnUxcnJICJhIfGmdwNTFyMUhJLCCUaJlw39W
        COcLo8SOactZIJzPjBJfdq1igWn5fHQ5VNVyoMSnhUxwLac33werYhMwlOg92scIYosIuEi0
        PZ0HFmcWeMQk0TyfGcQWFgiUaDq4E6yGRUBV4s7EC2BH8QpYSRw6N4UJYpu8xOoNB8DqOQWs
        Jbo6bzBB1AhKnJz5BGqmvETz1tnMIEdICLxkl2icCrKYA8hxkZjREQkxR1ji1fEt7BC2jMTp
        yT0sEPXNjBI9u2+zQzgTGCXuH1/ACFFlLXHn3C82kEHMApoS63fpQ8x0lLgwXxTC5JO48VYQ
        4gQ+iUnbpjNDhHklOtqEIGaoSPxeNR3qEymJ7if/oWHoIfFi1XnWCYyKs5A8MwvJM7MQ1i5g
        ZF7FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmMRO/zv+aQfj10tJhxgFOBiVeHgd5GfH
        C7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZ
        qakFqUUwWSYOTqkGxpy/qf6hCbvjHHeov3B7arul8WqrMLP08gLTwmUBDTwxT+rWT4059P8i
        X0jW2kqOZfPu69+121b975rNvcl1ztPrmCJOWM19k253StDUgO33/PsWYfrzFFZWH7Yykbja
        Lq4n1Dd12/X1Cy8bxq1wl4+3tgzg/LP35ZK7Vgy3Kuvlgk4/auj8qcRSnJFoqMVcVJwIAJt+
        ou5eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7qbeObEGxx9bmNxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFscftPOajFj8ks2BwGPTas62TzuXNvD5nG/+ziTR9+WVYwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8fHCSuWAy
        R8WsDw9ZGxifsnUxcnJICJhIfD66nBXEFhJYyigx53VxFyMHUFxKYn6LEkSJsMSfa11A5VxA
        JZ8YJXYu7mUBSbAJGEr0Hu1jBLFFBDwkTrWuZQUpYhb4wCSx9kEvWEJYwF9i/b5vYA0sAqoS
        dyZeAFvMK2AlcejcFCaIDfISqzccYAaxOQWsJbo6bzCBHCEEVPP2QBVEuaDEyZlPWEDCzALq
        EuvnCYGEmYE6m7fOZp7AKDgLSdUshKpZSKoWMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
        CIzLbcd+bt7BeGlj8CFGAQ5GJR5eB/nZ8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqP
        LyrNSS0+xGgK9NlEZinR5HxgysgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBa
        BNPHxMEp1cBYbXM2em/v1N0qGcdnvniteso04KfhswUl57POXj502/WnY4K7/Mvyqk9KvwXX
        TzxV53a69EXB+xKJTA3FA2Yl4TYFPxXOdCwL3xMXV8ZXHuo6QXXVHoXAPec2S3cfP2u2onjl
        tr8P0jiTLbjkJtVMfZy4P+BnzeNjPleSfdPdn6xYPPHyvJz/SizFGYmGWsxFxYkAyWvH7uEC
        AAA=
X-CMS-MailID: 20201030125307eucas1p14afc8cc8828f2bc838e769b77d7e9c95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125307eucas1p14afc8cc8828f2bc838e769b77d7e9c95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125307eucas1p14afc8cc8828f2bc838e769b77d7e9c95
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125307eucas1p14afc8cc8828f2bc838e769b77d7e9c95@eucas1p1.samsung.com>
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
Changes for v7, v6, v5:
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

