Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1374CE74EB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfJ1PVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:21:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58413 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfJ1PVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:21:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191028152100euoutp02445888376aa4977504b0f35ecd5c51da~R2L8VbDFJ2321623216euoutp02e
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:21:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191028152100euoutp02445888376aa4977504b0f35ecd5c51da~R2L8VbDFJ2321623216euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572276060;
        bh=wJ9m7VVZ4WFJVI4+6XzPvBgxm09HzDNGI/DagvZj8nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2if/0/BRVOO3pKBDS+hf7wyxd+Eq0zVZigj253m+sVHjz5f79opy36zQ9aivpv77
         RJ2/PES9IzfvUYeembneaN/bLG5YNMaqo1629ZLVutR8GdWWDHBFSD6MTElpwLduKq
         OCinUUrSPo4V8Z5bhSBOOdfuiRIFum6fswTUR0Es=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191028152059eucas1p18784affb3c15e45baba16a2ab069ef75~R2L71p8oz0793307933eucas1p13;
        Mon, 28 Oct 2019 15:20:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.CC.04309.B5707BD5; Mon, 28
        Oct 2019 15:20:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee~R2L7YwrbH1157011570eucas1p2v;
        Mon, 28 Oct 2019 15:20:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191028152059eusmtrp165e9b8a3df6b40dab7c05e0d5730406d~R2L7YGTFy1764317643eusmtrp1X;
        Mon, 28 Oct 2019 15:20:59 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-fc-5db7075bfa06
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.25.04166.A5707BD5; Mon, 28
        Oct 2019 15:20:58 +0000 (GMT)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028152058eusmtip14f3fd8a44c7001a1e2b3d97c5128c652~R2L60_fzs2501825018eusmtip1l;
        Mon, 28 Oct 2019 15:20:58 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/3] ARM: dts: exynos: Remove syscon compatible from chipid
 node on Exynos5
Date:   Mon, 28 Oct 2019 16:20:49 +0100
Message-Id: <20191028152050.10220-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028152050.10220-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd1o9u2xBkeWKFhsnLGe1WL+kXOs
        FufPb2C32PT4GqvF594jjBYzzu9jslh75C67ReveI+wWh9+0s1psfnCMzYHLY9OqTjaPzUvq
        Pfq2rGL0+LxJLoAlissmJTUnsyy1SN8ugSvj1seLLAVb2SseNvo1ME5n62Lk5JAQMJE49nE6
        YxcjF4eQwApGiXtnZ0A5XxglpmyczQrhfGaUOPlpP1zLwVO/2SASyxkl5s/ezAzX0vLvAhNI
        FZuAoUTv0T5GEFtEQF2ie88UdpAiZoE/jBKtWyYwgySEBWIlPn6byw5iswioSpzY0McKYvMK
        WEv8vnSAHWKdvMTqDQfA6jkFbCQWT2xnhYj/ZpP43+ACYbtI3L81kwXCFpZ4dXwLVK+MxOnJ
        PSwgiyUEmhklenbfZodwJjBK3D++gBGiylri8PGLQFM5gM7TlFi/Sx8i7Chx/eRBNpCwhACf
        xI23giBhZiBz0rbpzBBhXomONiGIahWJ36umM0HYUhLdT/5DneMhcWnVP2iY9jNKdP1dyjiB
        UX4WwrIFjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPH6X/Hv+xg3PUn6RCjAAej
        Eg/vi6vbYoVYE8uKK3MPMUpwMCuJ8F48AxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpI
        ID2xJDU7NbUgtQgmy8TBKdXAuMyQUYUnKrtRxmvqMr2Ejtl+P89afP2u/jJ2tt+xvXXrX22N
        FVC80FwxP4Rtxg5+CYW1N+8XfTAIe/t2+9S3ORtzHgbo3J2gfGLiKu8P+Ye7cwx4TlgcmzTp
        4w1v5s0/ehbtnqNn32zfxvHi030d3aXv9N+8bbha/29vqseE/p0cn8Mb8p1XeimxFGckGmox
        FxUnAgB+QupwGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xu7pR7NtjDX69tbHYOGM9q8X8I+dY
        Lc6f38BusenxNVaLz71HGC1mnN/HZLH2yF12i9a9R9gtDr9pZ7XY/OAYmwOXx6ZVnWwem5fU
        e/RtWcXo8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
        Zllqkb5dgl7GrY8XWQq2slc8bPRrYJzO1sXIySEhYCJx8NRvIJuLQ0hgKaNEw4z7QA4HUEJK
        Yn6LEkSNsMSfa11QNZ8YJRb9u8UCkmATMJToPdrHCFIvIqApcW6hGUiYWaCFSWLdUUcQW1gg
        WmLKo6Vg5SwCqhInNvSxgti8AtYSvy8dYIeYLy+xesMBZhCbU8BGYvHEdrAaIaCa7xcWsExg
        5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMIC3Hfu5eQfjpY3BhxgFOBiVeHgnXN4W
        K8SaWFZcmXuIUYKDWUmE9+IZoBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbnA6MrryTe0NTQ
        3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY82MXt7KNSxXKyc3Bvy4PXv1
        smznVZcWH9x+8vzP1aeuTTbJ9RY/xt/SuiVd5Y97m2Gpbqnae9l332vzzx01+VG75rVjTOOZ
        HXUS2T1TtaQUrwTHty+OP75lhTP3VfsZYbZMPzRcBdZUGU+Y/N2BPfPCQu/Y0vyb7+88lP95
        7Vpe9pYvlw/PnKbEUpyRaKjFXFScCADqr5qtdgIAAA==
X-CMS-MailID: 20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee
References: <20191028152050.10220-1-s.nawrocki@samsung.com>
        <CGME20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "syscon" compatible string was introduced in commit ("cdcce1ee977b
ARM: dts: exynos: Add "syscon" compatible string to chipid node on Exynos5")
to allow sharing of the CHIPID IO region between multiple drivers.
However, such sharing can be also done without an additional compatible
so remove the syscon entry.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 4801ca759feb..22eb951c614c 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -36,7 +36,7 @@
 		ranges;
 
 		chipid: chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid", "syscon";
+			compatible = "samsung,exynos4210-chipid";
 			reg = <0x10000000 0x100>;
 		};
 
-- 
2.17.1

