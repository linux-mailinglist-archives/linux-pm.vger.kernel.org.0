Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0C2A61E5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKDKhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:37:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47683 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgKDKhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103724euoutp02fa43e18a1181248e9e7a2a228663d0d6~ER70Yobec2966229662euoutp02Y
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201104103724euoutp02fa43e18a1181248e9e7a2a228663d0d6~ER70Yobec2966229662euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486244;
        bh=4jDdkOF9KeaEav3yECAHUsBxo9tM3wtiBUfvzdDFRkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyL1nUWR6947aKNv8qUlW5DBXHxQZQu95Cd+l26ywZIWYsGBH7LSBgmCExUa5UjxQ
         Khjqv1Loiprl2p/QioOqfnnqhQho0/jB+GiKFiZN/7s64QgQlW7D8jsJ4ZDP8QIPKS
         /vOhZqr6SXpKm3wIaOcz1b9mGFNbeknewZrJL0Dw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201104103719eucas1p2198ed14bf3f225a0c2098e5aa63a9e96~ER7vSYIQ41146911469eucas1p2i;
        Wed,  4 Nov 2020 10:37:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.0A.06318.F5482AF5; Wed,  4
        Nov 2020 10:37:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d~ER7vAzdL91562315623eucas1p1I;
        Wed,  4 Nov 2020 10:37:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103718eusmtrp187d459d3c57732985efa60614a7bcab6~ER7vAHWqL0575105751eusmtrp1J;
        Wed,  4 Nov 2020 10:37:18 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-7d-5fa2845f005e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.75.06314.E5482AF5; Wed,  4
        Nov 2020 10:37:18 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103718eusmtip25006f9bb88eff50476c174c7a16ba0f7~ER7uR07EW1402114021eusmtip2F;
        Wed,  4 Nov 2020 10:37:18 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 1/7] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Date:   Wed,  4 Nov 2020 11:36:51 +0100
Message-Id: <20201104103657.18007-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZeN5q9m5IHu+HoQkVesA9PaVlisE8h9CGyy3rTF610k71e
        i0hbZnnDlJqXULMr66bzgl3UmssVkjMVE1xpaJRWSE0JKzLna+W3/znn93/+58DDEup+yo89
        ok8WjHo+QUMryKaO6a6NujM1uqCnjV54qDIb4brS+xR+PfmBwlX2Lgr3TU3Q2NxipXHxUBGJ
        nc5aBltH+inc+/Ayjd0FdoRLna0yfNf+hsGDWbdonN1iZ3D75xwKl5aM0dtVWqvlPK119T+m
        tUN5Dpm2/topbWGDBWnd1hVRdLQiLFZIOJIqGAO3HVLEl1W8pZKcq9I7Gkx0JnItz0VyFrhN
        UND/nc5FClbN3ULQVvFgvphEUHW1kpEKN4Lv9c3kX8sFp2ueuomgp+AB+c9S3WOSeSiaC4aC
        Z4XIo324SDj7vnIOIrhzBDQ1FxOegTfHw6fuccajSW41PHcOz5mVXChk17XPx62E27VP5ng5
        Fwav3CZGYlTwomx0jiFmGVNjBeEJAG6KgYnJe7RkjgRHVhkhaW8YdzQwkl4GnSX5pGQwIch/
        NMhIRRGCIUc1kqhQcHX9mH2JnY1YB/cfBkrtHTDcNkx52sB5wcAXlbSEFxQ3mQmprYRzZ9US
        vQp+WswySftB3ugMKSFasJdQRci/fME15QuuKf8fW40IC/IVUsTEOEEM0QtpASKfKKbo4wJi
        DIlWNPvbOn87pppR66/DNsSxSLNI+aTpik5N8aliRqINAUtofJQRLzsPqpWxfMZxwWjQGVMS
        BNGGlrKkxlcZUjN2QM3F8cnCMUFIEox/pzJW7peJws3Rqq/hRzdndH8cPZC5VkGc2DJyI5Sk
        OqpMIUi193bfkqLcwobpb7ssOq/p63tOm6JTgE9tt23tvTRp2OMjbojx9zFU5uxzsYuXhlVc
        zD5pHovyLvXVr07TybtbttbY3qULY9Gve2Z2a3f6uyPagmuLQ4O61+z/MXDqzo3LzbEaUozn
        g9cTRpH/A8myVXFpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pxLYviDdrXmVrcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925is5h0fwKLxfnzG9gtNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2Cxa9x5htzj8pp3VYsbkl2wOgh6bVnWyedy5tofN4373cSaPzUvqPfq2rGL0
        +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
        QS9j5ux7rAXnVSqObWlma2C8I9vFyMkhIWAiMfH8HbYuRi4OIYGljBKPT+xn7WLkAEpIScxv
        UYKoEZb4c62LDcQWEvjEKHH5BFicTcBQovdoHyOILSLgIXGqdS0riM0sMINZ4vQsUxBbWCBe
        Yu+302BxFgFViRPnHzCB2LwC1hKtGw+zQMyXl1i94QAziM0pYCNx8XMzO8Qua4nFz89B1QtK
        nJz5hAXkNGYBdYn184QgVslLNG+dzTyBUXAWkqpZCFWzkFQtYGRexSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERip24793LyD8dLG4EOMAhyMSjy8B7YtjBdiTSwrrsw9xCjBwawkwut09nSc
        EG9KYmVValF+fFFpTmrxIUZToNcmMkuJJucDk0heSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQbGyJwjvcysdZWHF0/ZI/lv11nnek+H45NFM2dt25LC1nstYYuw
        hNbNkmmi535eqrt7OOSvaJLocwajGce3JKZcODtb48LpvDnfFUUlFzx4flnif+ZEkfwZ7w8s
        9q9/Nj9wj4vJ1Em/11ybxiZ8eXaSSb935pKGuWtXLvbetTAs9nGdY5z9pXXFT5RYijMSDbWY
        i4oTAfJNaOnqAgAA
X-CMS-MailID: 20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation for new optional properties in the exynos bus nodes:
interconnects, #interconnect-cells, samsung,data-clock-ratio.
These properties allow to specify the SoC interconnect structure which
then allows the interconnect consumer devices to request specific
bandwidth requirements.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v8:
 - updated description of the interconnects property,
 - fixed typo in samsung,data-clk-ratio property description.

Changes for v7:
 - bus-width property replaced with samsung,data-clock-ratio,
 - the interconnect consumer bindings used instead of vendor specific
   properties

Changes for v6:
 - added dts example of bus hierarchy definition and the interconnect
   consumer,
 - added new bus-width property.

Changes for v5:
 - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 71 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index e71f752..bcaa2c0 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -51,6 +51,19 @@ Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
 
+Optional properties for the interconnect functionality (QoS frequency
+constraints):
+- #interconnect-cells: should be 0.
+- interconnects: as documented in ../interconnect.txt, describes a path at the
+  higher level interconnects used by this interconnect provider.
+  If this interconnect provider is directly linked to a top level interconnect
+  provider the property contains only one phandle. The provider extends
+  the interconnect graph by linking its node to a node registered by provider
+  pointed to by first phandle in the 'interconnects' property.
+
+- samsung,data-clock-ratio: ratio of the data throughput in B/s to minimum data
+   clock frequency in Hz, default value is 8 when this property is missing.
+
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
 	VDD_MIF |--- DMC
@@ -135,7 +148,7 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- PERIC (Fixed clock rate)
 		|--- FSYS  (Fixed clock rate)
 
-Example1:
+Example 1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
 	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
@@ -184,7 +197,7 @@ Example1:
 	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
 	----------------------------------------------------------
 
-Example2 :
+Example 2:
 	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
 	is listed below:
 
@@ -419,3 +432,57 @@ Example2 :
 		devfreq = <&bus_leftbus>;
 		status = "okay";
 	};
+
+Example 3:
+	An interconnect path "bus_display -- bus_leftbus -- bus_dmc" on
+	Exynos4412 SoC with video mixer as an interconnect consumer device.
+
+	soc {
+		bus_dmc: bus_dmc {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DIV_DMC>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_dmc_opp_table>;
+			samsung,data-clock-ratio = <4>;
+			#interconnect-cells = <0>;
+		};
+
+		bus_leftbus: bus_leftbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DIV_GDL>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			#interconnect-cells = <0>;
+			interconnects = <&bus_dmc>;
+		};
+
+		bus_display: bus_display {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_ACLK160>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_display_opp_table>;
+			#interconnect-cells = <0>;
+			interconnects = <&bus_leftbus &bus_dmc>;
+		};
+
+		bus_dmc_opp_table: opp_table1 {
+			compatible = "operating-points-v2";
+			/* ... */
+		}
+
+		bus_leftbus_opp_table: opp_table3 {
+			compatible = "operating-points-v2";
+			/* ... */
+		};
+
+		bus_display_opp_table: opp_table4 {
+			compatible = "operating-points-v2";
+			/* .. */
+		};
+
+		&mixer {
+			compatible = "samsung,exynos4212-mixer";
+			interconnects = <&bus_display &bus_dmc>;
+			/* ... */
+		};
+	};
-- 
2.7.4

