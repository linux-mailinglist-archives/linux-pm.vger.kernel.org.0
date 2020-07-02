Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120E52129D6
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGBQi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:38:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55092 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGBQh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:37:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163757euoutp01cc4166129ae70557e921b8951b7d22b9~d-N7yVn891548715487euoutp01_
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702163757euoutp01cc4166129ae70557e921b8951b7d22b9~d-N7yVn891548715487euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707877;
        bh=PgZSLXZfKGDDVkfwIZQfiOnpY8SRsPagsq4j5xcQtGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gbv830o+C01jKn4sVLVrR1UMbap7FBD35K/e/w0PvF3Ny9y9TcgoaxsfUkUnMcNlz
         JiFt2rsztasogNg98+dwFBZASY8CtCNRzL0oqaREcXaZTL78CmId5NJP1zS/hnyUZQ
         tOD3LBDF6m7p+AAkAoQ/anR9EvQ2DbN4aOV4UOXU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702163757eucas1p172597795ac23cfee635714944eebb1bb~d-N7RQWBl0768807688eucas1p19;
        Thu,  2 Jul 2020 16:37:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 44.6A.06318.46D0EFE5; Thu,  2
        Jul 2020 17:37:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163756eucas1p282c6bc5a61f8dd7b6a5d59d92e92e2f1~d-N6zTiF12602726027eucas1p2j;
        Thu,  2 Jul 2020 16:37:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163756eusmtrp13e657d5b8537f2e413d7d2a9d6c3c8e6~d-N6yp9d_1333013330eusmtrp18;
        Thu,  2 Jul 2020 16:37:56 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-58-5efe0d64969c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.AB.06314.46D0EFE5; Thu,  2
        Jul 2020 17:37:56 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163755eusmtip28bd1b5471bd6ae156a0378be19d6b8b0~d-N6FBRho2919929199eusmtip2B;
        Thu,  2 Jul 2020 16:37:55 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 4/6] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
Date:   Thu,  2 Jul 2020 18:37:22 +0200
Message-Id: <20200702163724.2218-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702163724.2218-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SazBUYRjH591z2WNnl2O3yYPS2DKNpsRomnfSmGpMsx/7SFNqy5kldtMe
        l/KhCxEbtfGBVkUXk7YLNkkKtVZbI3ZMSEMpMWhSoU10dTq6fPs9z/P/v//nmXkZQvmU8mMS
        DCmc0aBNUtMysu7hjGsVp/gRG3olCA+cy0a4pqSKws8+jVC4zNFB4S73BxoXN9poXDhgJrHL
        VS3Ftjc9FH7acIbGUwUOhEtcTRJ83fFCivuOVNI4u9EhxS3vjlG4pGiM3uCtsVnzaE1/zz1a
        M3DcKdHcvHRIc6LWijRTtoAt9FbZ+jguKSGNM66O3CmL763uJJJveO1vfllDHEYNchPyYIBd
        A6PT48iEGEbJViKoDTQh2Rx+QlBzbYIWiykEg50nqT+GR6OvkDi4jOD2yB301zJbdFMiqGg2
        DApaTyCBF7BRkDN8jhREBJtLQF19ISEMVOxuON/bQgpMskFw9sZ7qcAKdh08f5iHxLglcLX6
        PiHs58FGQMuUQpR4w+PTQ7+txJwk61YpIbwPrFsKF5+YSNEbBe1vy+ZZBW+dtVKRF0FbUT4p
        GrIQ5N/tk4qFGcGAs3w+OQL6O2ZpIZlgg6GqYbXY3gjdX9xSoQ2sJ/SOe4tLeEJhXTEhthWQ
        m6MU1cvgq7VYIrIfHB/6Ob+OBvJLJkkzCrT8d47lv3Ms/3LLEWFFPlwqr9dxfLiBSw/htXo+
        1aAL2b1Xb0NzX63th9Ndj5q+7bIjlkFquWL08fdYJaVN4w/o7QgYQr1Asam9LVapiNMeyOCM
        e3cYU5M43o78GVLtowi/MLZdyeq0KVwixyVzxj9TCePhdxiZV23D0+3xhHzPRHTw2IfI1syE
        O8MqtnGfrCmaqg7tlw+u5GNUVfJW265Mw3JHT2JFptfB5qMPFs5YlgbGdYy8Miwr6yxWN7hK
        J7Vhrz3OBAR1mXzyvlboTmWkL41eu9i/a9PyUVVWkd1/XNlz5XP55MyKkM0xR7rNMb7Jvhkf
        w9UkH68NW0EYee0v6L6xymYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7opvP/iDLYulrO4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7GjQ0XmQvW8Vfsv7eRuYFxF08XIyeHhICJxIkXDxi7GLk4hASWMkr8fvoMyOEASkhJzG9R
        gqgRlvhzrYsNouYTo8TjDx9YQBJsAoYSvUf7GEFsEQEPiVOta1lBbGaBGcwSp2eZgswRFkiU
        mLlAECTMIqAqMXfdO3YQm1fASuLmsU5GiPnyEqs3HGAGKecUsJY4/JkXJCwEVHKsfwFUuaDE
        yZlPWEBKmAXUJdbPE4JYJC/RvHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYJxuO/Zz8w7GSxuDDzEKcDAq8fBOOP43Tog1say4MvcQowQHs5IIr9PZ03FC
        vCmJlVWpRfnxRaU5qcWHGE2BPpvILCWanA9MIXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhizGNdceVzJ/NCANzkzy8d5tY5cmweDubvi59n8F0oqT2cxCK9W
        m6TCXOeffv7h6XSh+j+WDq5CmhoTTnG7crlu1OsWsU722ZK8+e//hxWOol+1Pn3PfrBQ9tY6
        uzlBi8/ctbH6N7fG7dIqy8QHzV5H2mp0U3y1Ilj7F5758+TItKufp3QZblJiKc5INNRiLipO
        BABsxMos6QIAAA==
X-CMS-MailID: 20200702163756eucas1p282c6bc5a61f8dd7b6a5d59d92e92e2f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163756eucas1p282c6bc5a61f8dd7b6a5d59d92e92e2f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163756eucas1p282c6bc5a61f8dd7b6a5d59d92e92e2f1
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163756eucas1p282c6bc5a61f8dd7b6a5d59d92e92e2f1@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the following properties for Exynos4412 interconnect
bus nodes:
 - samsung,interconnect-parent: to declare connections between
   nodes in order to guarantee PM QoS requirements between nodes,
 - #interconnect-cells: required by the interconnect framework,
 - bus-width: the bus width in bits, required to properly derive
   minimum bus clock frequency from requested bandwidth for each
   bus.

Note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
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
index 4886894..24529d4 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -381,6 +381,8 @@
 			clocks = <&clock CLK_DIV_DMC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			bus-width = <4>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};

@@ -450,6 +452,8 @@
 			clocks = <&clock CLK_DIV_GDL>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			samsung,interconnect-parent = <&bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};

@@ -466,6 +470,8 @@
 			clocks = <&clock CLK_ACLK160>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_display_opp_table>;
+			samsung,interconnect-parent = <&bus_leftbus>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};

--
2.7.4

