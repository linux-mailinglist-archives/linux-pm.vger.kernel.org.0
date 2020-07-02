Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360F02129BD
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGBQhv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:37:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55038 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgGBQhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:37:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163749euoutp01cc115656ca428975e687264beb1fd36d~d-N0Slq3F1548815488euoutp014
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:37:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702163749euoutp01cc115656ca428975e687264beb1fd36d~d-N0Slq3F1548815488euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707869;
        bh=4eY6jX/WpmIZ9gh4ZWcep5FtwkUglG2OwAr9jd8P1eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkO0qgQI+XbFJkC04w6WowyyYFMRP4ZexxYE+rRCuF/RdlQtVINIebdk8HW0QrUJi
         k2KTEFg8r0QMXWfit+2z98bKnxg+3RUT/FhfaeMa5/Pb+TcUoET0aJrRp1HlgRclqV
         6p0KeyzvyAPI8bO74Ld0NhQRhgk8wjo4cnF6W+zs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702163749eucas1p2360f18da30d554a9b67de593e83cf7e2~d-N0APDUI2218422184eucas1p20;
        Thu,  2 Jul 2020 16:37:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.6A.06318.D5D0EFE5; Thu,  2
        Jul 2020 17:37:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3~d-Nzp9pl42625926259eucas1p2b;
        Thu,  2 Jul 2020 16:37:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163748eusmtrp1c6f5abbfb31957a3544afcf38b277477~d-Nzja0BV1333013330eusmtrp1s;
        Thu,  2 Jul 2020 16:37:48 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-4c-5efe0d5dd64b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D8.F9.06017.C5D0EFE5; Thu,  2
        Jul 2020 17:37:48 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163748eusmtip2d9395edeb9db3436967516b9a53d2648~d-Ny3lXLe0323303233eusmtip2H;
        Thu,  2 Jul 2020 16:37:48 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation for
 interconnect properties
Date:   Thu,  2 Jul 2020 18:37:19 +0200
Message-Id: <20200702163724.2218-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702163724.2218-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUiUURSGufOtTk59jpYHjdKhhIpS0eBiFhVDzY+giIgItCb9UMl1Rk3t
        R5m55N44panZJmQziNO4lJZSOrngBuWGCwNqi6WImYot2oyflv+ec8773vccuCwh7aWc2JDw
        aF4VrgyV0WKypnmxa6+fZMnfY2BpAzaXJCP8vKCCwv0/PlP4gamLwj1z0zTOrzfSWGPOJXF3
        t4HBxrE+Cn+oK6bxbJYJ4YLuBhEuN40weCixjMbJ9SYGN02mUrggb4I+bKcw6m7RiuG+17TC
        nNEiUlSWXlNkV+mQYta47RR9XuwbyIeGxPIq90MXxcGaol8oMtslrsNsZq6jG07pyIYFzhta
        /zTTVpZyZQj6tb7pSGzhHwimBrVIKGYtRc8gWnOk6+7TwuApgsmOcvTPclvzjrGqaM4Tst5l
        rzgcODmkfCwhrSKCSyOg5qWGsA7suUDoG9OsiEhuJ7xYvL+yiITzgdba6dW47aA3vLHoWdaG
        OwBNsxJBYgdt98ZJKxMWSVJ1EWF9H7gZBhJTpla9chgZMTEC28PXlqpV3grteZmkYEhCkPlq
        iBGKXATmloer7gMw3PWTtiYT3C6oqHMX2kfAsFwrsraB2wgDU3bCEhtBU5NPCG0JpKVIBfUO
        +KXLFwnsBBnjy6TACkhLTmRykWvhunMK151T+D/3ISJ0yJGPUYcF8WqvcP7KPrUyTB0THrQv
        ICLMiCyfrX2pZe4lavh9qRFxLJLZSr60/fGXUspYdXxYIwKWkDlIjna2+0slgcr4BF4VcUEV
        E8qrG5EzS8ocJV6PJ/ykXJAymr/M85G8am0qYm2crqNiMdTH629QZzZvGdDemWuoq1wK0cpL
        bE+oRkXi6bpgfdT7+axzMz4i54DT2Q8Wvnu/lp9Mvfmo/5O3flNOhcebnK49zzyXx9r2z5VW
        fot6wg4SPT4+bm6j/Z1vr7pkGOYPxukdjt35Hnx8YbLX9ayBsrl7ulCujUnPc6ytMlYnEDJS
        Haz03E2o1Mq/eMkMX2gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7oxvP/iDC5v0rW4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7GpNm/GQv6FCrO3L/P3sDYJNXFyMkhIWAi0bVqLlsXIxeHkMBSRok7u94DORxACSmJ+S1K
        EDXCEn+udUHVfGKU2Lp1FytIgk3AUKL3aB8jiC0i4CFxqnUtWJxZYAazxOlZpiC2sECSxIfF
        P5hBbBYBVYntP0GWcXLwClhJnNj5nhFigbzE6g0HmEH2cgpYSxz+zAsSFgIqOda/gB2iXFDi
        5MwnLCAlzALqEuvnCUFskpdo3jqbeQKj4CwkVbMQqmYhqVrAyLyKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMFK3Hfu5ZQdj17vgQ4wCHIxKPLwTjv+NE2JNLCuuzD3EKMHBrCTC63T2dJwQ
        b0piZVVqUX58UWlOavEhRlOgzyYyS4km5wOTSF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0
        xJLU7NTUgtQimD4mDk6pBsY5tzZ0//U/ZxWyaK3rJoukKPXWPW6VWjyBTQ/+FSia/v5ntFve
        +fCSQsaF6x4wxmoYWgjH3VynULDFelK0/ZXWS51GbeY/blnaGzd/3Myx5Knf/xyhEzIbJBm0
        j2a0e6XnFXoW7u1tK3oSdFbxfl+ypfZF1hOqkvIHebeWNUxNeLjCM8aMWYmlOCPRUIu5qDgR
        AG44LafqAgAA
X-CMS-MailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation for new optional properties in the exynos bus nodes:
samsung,interconnect-parent, #interconnect-cells, bus-width.
These properties allow to specify the SoC interconnect structure which
then allows the interconnect consumer devices to request specific
bandwidth requirements.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v6:
 - added dts example of bus hierarchy definition and the interconnect
   consumer,
 - added new bus-width property.

Changes for v5:
 - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index e71f752..4035e3e 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -51,6 +51,13 @@ Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
 
+Optional properties for interconnect functionality (QoS frequency constraints):
+- samsung,interconnect-parent: phandle to the parent interconnect node; for
+  passive devices should point to same node as the exynos,parent-bus property.
+- #interconnect-cells: should be 0.
+- bus-width: the interconnect bus width in bits, default value is 8 when this
+  property is missing.
+
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
 	VDD_MIF |--- DMC
@@ -135,7 +142,7 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- PERIC (Fixed clock rate)
 		|--- FSYS  (Fixed clock rate)
 
-Example1:
+Example 1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
 	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
@@ -184,7 +191,7 @@ Example1:
 	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
 	----------------------------------------------------------
 
-Example2 :
+Example 2:
 	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
 	is listed below:
 
@@ -419,3 +426,60 @@ Example2 :
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
+			bus-width = <4>;
+			#interconnect-cells = <0>;
+			status = "disabled";
+		};
+
+		bus_leftbus: bus_leftbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DIV_GDL>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			samsung,interconnect-parent = <&bus_dmc>;
+			#interconnect-cells = <0>;
+			status = "disabled";
+		};
+
+		bus_display: bus_display {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_ACLK160>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_display_opp_table>;
+			samsung,interconnect-parent = <&bus_leftbus>;
+			#interconnect-cells = <0>;
+			status = "disabled";
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

