Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949922A05F8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJ3Mxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33922 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgJ3Mx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125311euoutp01f776393facd95773e1cd32a4f2268a44~Cxj8Ci_g50058100581euoutp01Q
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201030125311euoutp01f776393facd95773e1cd32a4f2268a44~Cxj8Ci_g50058100581euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062391;
        bh=cRQaPfG8BF7tRwg45YbYTx6wg+Bhj1IaUDssAJxWNEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEUnSTdTM+9V7Ga6zuVMMncHSOCbpNfasW5wO5r3ZevfhQ1GRY7TLykuRunIThhiM
         lbiwqp27rnKgaYyU9zaw4bWMcdPZlj52kp3k8DEyHB7nnuQiKAkOoelxomG438NIUM
         hhMm3ki7zCnWkF8y7MskmtxAyio79ElJelV3x2CA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201030125305eucas1p200f9fc11dbb07ba033d8b80accae8e0e~Cxj3JChtj0096900969eucas1p2I;
        Fri, 30 Oct 2020 12:53:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1F.02.06318.1BC0C9F5; Fri, 30
        Oct 2020 12:53:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125305eucas1p2d61ba397d77a72e0d1dce8d30b278e16~Cxj2rYcgx0100501005eucas1p2K;
        Fri, 30 Oct 2020 12:53:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125305eusmtrp17870df56fb80be2752bd73c53af85b9c~Cxj2qsCNk0319303193eusmtrp16;
        Fri, 30 Oct 2020 12:53:05 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-dc-5f9c0cb1d384
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.3A.06314.1BC0C9F5; Fri, 30
        Oct 2020 12:53:05 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125304eusmtip2528da988a0f7422cf8f75a53af6e05ba~Cxj1-vJID1609116091eusmtip2H;
        Fri, 30 Oct 2020 12:53:04 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 4/6] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
Date:   Fri, 30 Oct 2020 13:51:47 +0100
Message-Id: <20201030125149.8227-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGOfv2XZRmpyn1Ypm1LmThraJOKaFhtIIgqL+iWks/VHImW1Z2
        Ec003dRsBtq8rRXlJVGHqZiKOW2K5ahMI41VmGUpFkvCrMz1afnf733O85z3fQ+Ho6RdtCcX
        HXuKV8cqY2SMq7ju0WSPb82CQkXA06KtxF6cikhNfhVN+r99oElJew9NeifGGZLXbGaI3p4j
        JjZbNUueNxYyxJHVjki+rUVEKttfs2QguZQhqc3tLLGMXqFJfu4IE4Ll5vIMRj7Y18TI7Tqr
        SJ5dW47kDvPy/fQh1+AIPib6NK/233HMNarvWT8dl4fPdt4oYJNQpkSLOA7wZriVJtYiV06K
        SxEYpy20UHxD0J2SwQqFA8HN77dFc4mn9ZSg30Uwda+G+pewVZfNJFw4BgdCVkc2crIHDoO0
        98ViJ1P4nQhSSignu2MFGBxvGCeL8RrIudTLOhtI8HbQ9rs7ZcDeUFHd+tfugoNAm/FS5GQJ
        XgRdN4Zmr/SGlPsFlOAfYWG89bzAYaCzlCGB3eGTtZYVeBl052b+XRlwCoLMBwOsUOQgsFuN
        s4kgGOz5wTgHorAPVDX6C3IoPLZUssJDuMHLsUXCDG6gr8ujBFkC6WlSwb0apsrzRAJ7gm5o
        WiywHEymYSoHrTTM28YwbxvD/75GRJWjJXy8RhXJazbF8mf8NEqVJj420i/8pMqMZj5Y92/r
        RANq+Xm8DWEOyRZIQrwLFFJaeVqToGpDwFEyD8nOJ91HpZIIZcI5Xn1SoY6P4TVtaCknli2R
        bDKNHJHiSOUp/gTPx/HquVMR5+KZhDoXD392a6vdvXdyeKjk09T1w+u2Ne8LDzJdfrFMX/R1
        8uHXLR87Es/oGscuKL0OGO58SWrCXtaE/cVdJHijUT9UZe5Y6X3loP7qqwB9j65+bXqoRXft
        enJm4uf836vQHm1CyK9nB3ddtG1wwcM+vg0Vib9CPijsneMLV7yOe1sxNpolE2uilIHrKbVG
        +Qepn62gXAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7obeebEG5zcI2Fxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFscftPOajFj8ks2BwGPTas62TzuXNvD5nG/+ziTR9+WVYwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcu3SdtWC6
        QMWJmbPZGxh7eLsYOTgkBEwkLm5n7mLk4hASWMoocXbzJzaIuJTE/BalLkZOIFNY4s+1LjaI
        mk9ANT/XMYMk2AQMJXqP9jGC2CICHhKnWteyghQxC3xgklj7oBcsISwQK/G2ewmYzSKgKjGh
        6Qo7yAJeASuJruvCEAvkJVZvOAA2k1PAWqKr8wYTSIkQUMnbA1UgYV4BQYmTM5+wgISZBdQl
        1s8TAgkzA3U2b53NPIFRcBaSqlkIVbOQVC1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GJXbjv3cvIPx0sbgQ4wCHIxKPLwO8rPjhVgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9f
        VJqTWnyI0RTosYnMUqLJ+cCEkVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUI
        po+Jg1OqgbEz48M6/ckxU4SN45MXndu94cIi9qXvo74uaHLZmr3p9J5d9qxZyf1p9dv6eg1Y
        misufCs1zfdfuGT7jAMK3x7WKb5kYTh342GreZrvY7YPCn0rp9QcyH8VqXPjnqezsNK3PVvM
        5a9VZM44HTNnD4veS4trVYvWeVy8ZHTC3/biMze9NRlT9fYqsRRnJBpqMRcVJwIAVBPJbOAC
        AAA=
X-CMS-MailID: 20201030125305eucas1p2d61ba397d77a72e0d1dce8d30b278e16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125305eucas1p2d61ba397d77a72e0d1dce8d30b278e16
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125305eucas1p2d61ba397d77a72e0d1dce8d30b278e16
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125305eucas1p2d61ba397d77a72e0d1dce8d30b278e16@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the following properties for Exynos4412 interconnect
bus nodes:
 - interconnects: to declare connections between nodes in order to
   guarantee PM QoS requirements between nodes,
 - #interconnect-cells: required by the interconnect framework,
 - samsung,data-clk-ratio: which allows to specify minimum data clock
   frequency corresponding to requested bandwidth for each bus.

Note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v7:
 - adjusted to the DT property changes: "interconnects" instead
   of "samsung,interconnect-parent", "samsung,data-clk-ratio"
   instead of "bus-width".

Changes for v6:
 - added bus-width property in bus_dmc node.

Changes for v5:
 - adjust to renamed exynos,interconnect-parent-node property,
 - add properties in common exynos4412.dtsi file rather than
   in Odroid specific odroid4412-odroid-common.dtsi.
---
 arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e76881d..4999e68 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -383,6 +383,8 @@
 			clocks = <&clock CLK_DIV_DMC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			samsung,data-clock-ratio = <4>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -452,6 +454,8 @@
 			clocks = <&clock CLK_DIV_GDL>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			interconnects = <&bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -468,6 +472,8 @@
 			clocks = <&clock CLK_ACLK160>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_display_opp_table>;
+			interconnects = <&bus_leftbus &bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.7.4

