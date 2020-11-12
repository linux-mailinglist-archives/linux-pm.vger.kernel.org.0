Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4671E2B074A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKLOLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 09:11:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54878 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgKLOLG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 09:11:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112141054euoutp01174616adffd45a1f6b77237f61779aec~GyAgrCBJA1450314503euoutp014
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 14:10:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112141054euoutp01174616adffd45a1f6b77237f61779aec~GyAgrCBJA1450314503euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605190254;
        bh=QORsv+NFm7ed8zna1XYeYDqutWdFBZ6zuTzS36JM28I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXwappiZIdObB+0tJw7GycyCYj2nrexEyXWTWBOaaTlUBSQvvJj+NbXmFalmhXQNA
         RQvkjynfae/MKpdXwR99jQbJ/07GTbrnTvkLhHgsbdkLoS6QsOOJR4A1JH5C5xEcjP
         o85XtofwlnMGxSdud+8RBqRVJi0Olkx5IqnXLyUU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112141048eucas1p19ada42b97eee736e84fae8e08b56d4b4~GyAatp3Er1700317003eucas1p1i;
        Thu, 12 Nov 2020 14:10:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 07.B9.44805.8624DAF5; Thu, 12
        Nov 2020 14:10:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201112141047eucas1p1f4294148c61b778bbb321863b8ef0092~GyAaSyM0f1700417004eucas1p1q;
        Thu, 12 Nov 2020 14:10:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201112141047eusmtrp13cc13660f9f3050649c3f0194f0ba211~GyAaR8rHV1178311783eusmtrp1y;
        Thu, 12 Nov 2020 14:10:47 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-56-5fad42684c45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.11.21957.7624DAF5; Thu, 12
        Nov 2020 14:10:47 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201112141046eusmtip24a2a8b36b6e1942d6e6c539ff5c5a9e8~GyAZcLzK-3179531795eusmtip2N;
        Thu, 12 Nov 2020 14:10:46 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v9 1/5] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Date:   Thu, 12 Nov 2020 15:09:27 +0100
Message-Id: <20201112140931.31139-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112140931.31139-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7oZTmvjDW78Z7O4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABbFJdNSmpOZllqkb5dAlfG5D3nGQs2qFVsuXqQqYFxrnwXIyeHhICJxL7T+xi7GLk4
        hARWMEr8br4I5XxhlDg+cTsLSJWQwGdGiYb/UjAdR65tZYcoWs4o0bW/nxmu4+y9w4wgVWwC
        hhK9R/uAbA4OEQFPiZMN+iA1zALNzBINzZvAaoQFEiWWrtvODGKzCKhKzH79BWwbr4C1xIQP
        39khtslLrN5wAKyGU8BGYu7TVjaIGkGJkzOfgNUzA9U0b50NdoSEwHxOia7VH1kgml0krl7/
        yQhhC0u8Or4FaqiMxOnJPSwQDc2MEj27b7NDOBMYJe4fXwDVYS1x59wvNpAXmAU0Jdbv0ocI
        O0p8efqaFSQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0j8XjWdCcKWkuh+8h/qNA+JbUff
        sE1gVJyF5J1ZSN6ZhbB3ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMDEdvrf8S87
        GJe/+qh3iJGJg/EQowQHs5IIr7LDmngh3pTEyqrUovz4otKc1OJDjNIcLErivElbgFIC6Ykl
        qdmpqQWpRTBZJg5OqQam2S2Pq7171+wt7S9qn+zdEBS662lAyuZtf6f+bnr0Vc/hk6rIgYA4
        u7S4Jcul2HMO6Z4pD5yoLuVue5a90/5qhU7WnhMdAZf9VrnLvVGrl/9sNvnvz/49qYfWT/vR
        VDMx1KulUGbZfNe9WxNVvvPuPd6v1cVn97g9/tMn7bV3j99N0xL9YPHusrTiCSmWOW/Ev+sc
        ehgx2aPlp3l9z7v7HrPrfmWeeMSnfPPOkm8Of1kXLPj/KzHs99cLtYzCchWLP0778u/wza49
        Sme2HGEu93p5f+OljADHedlrKgx2fFVJ6lwj8uPj8XOpO88nKmd2qpaseKUSn7bo+gtpJllB
        rmMa20onWF2eaSfMKpaxXYmlOCPRUIu5qDgRADN6jALbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rpTmvjDfrfKVvcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925is5h0fwKLxfnzG9gtNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2Cxa9x5htzj8pp3VYsbkl2wOgh6bVnWyedy5tofN4373cSaPzUvqPfq2rGL0
        +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
        QS9j8p7zjAUb1Cq2XD3I1MA4V76LkZNDQsBE4si1rexdjFwcQgJLGSWa3v5n7GLkAEpIScxv
        UYKoEZb4c62LDaLmE6PEj9/trCAJNgFDid6jfYwgtoiAr8Tqk5NYQIqYBSYzSzy63cIGkhAW
        iJfYveIUmM0ioCox+/UXFhCbV8BaYsKH7+wQG+QlVm84wAxicwrYSMx92gpWLwRUs7+7jQmi
        XlDi5MwnLCDHMQuoS6yfJwQSZgZqbd46m3kCo+AsJFWzEKpmIalawMi8ilEktbQ4Nz232FCv
        ODG3uDQvXS85P3cTIzBatx37uXkH47xXH/UOMTJxMB5ilOBgVhLhVXZYEy/Em5JYWZValB9f
        VJqTWnyI0RTom4nMUqLJ+cB0kVcSb2hmYGpoYmZpYGppZqwkzrt1LlCTQHpiSWp2ampBahFM
        HxMHp1QDk0ZI9tSH3/S1qzfyalmdZ2Xda1vFN9fNq4yb+5zGnn3+N9WtOU+tEfnOKrLHZk/L
        3MwPvAyNn2etup64bvHHjWyH+aem+Pa2bd66clZEyKR9/S7Ogs7s6qcfWi76bdRiobTmw4xE
        Z4cjszj+hD4XiL9ovnBC82annE1/ZO44z19pkiB+RUTpQ7CAq/i19EML7zCf9XXe5G3SsSXk
        9F2jGZ55LZ6BDputW09f9bofP8lzygyHztzu+j9GazdZbQ28tO2PefWvqm6jujXfHs0tZ880
        T5HjzNu09HvP5cOl3l2s60rlXObLVstmmzB92pix6sOFGf41uukObxeY3zmzv8FwUTynw4+5
        MltOangEKLEUZyQaajEXFScCADTJNVZfAwAA
X-CMS-MailID: 20201112141047eucas1p1f4294148c61b778bbb321863b8ef0092
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112141047eucas1p1f4294148c61b778bbb321863b8ef0092
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112141047eucas1p1f4294148c61b778bbb321863b8ef0092
References: <20201112140931.31139-1-s.nawrocki@samsung.com>
        <CGME20201112141047eucas1p1f4294148c61b778bbb321863b8ef0092@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation for new optional properties in the exynos bus nodes:
interconnects, #interconnect-cells, samsung,data-clock-ratio.
These properties allow to specify the SoC interconnect structure which
then allows the interconnect consumer devices to request specific
bandwidth requirements.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v9:
 - added Ack tags

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

