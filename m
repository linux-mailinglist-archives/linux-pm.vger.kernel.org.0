Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3D2A05F7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgJ3Mxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33920 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgJ3Mx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125308euoutp01ec32d1aa3825c06c9ecd5cc4ef944d5a~Cxj5VLUDr0058200582euoutp01N
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201030125308euoutp01ec32d1aa3825c06c9ecd5cc4ef944d5a~Cxj5VLUDr0058200582euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062388;
        bh=Ow4Lt+fSEz1IW4V5nviqEEPVM0xYn9tb2RT6kaXWDGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWGl5v3w9+8ziD2UT9PQg/ll12tj6l7cDV9+HcX9HxnsFb8DR9g0GHgUSWVdOFIdJ
         Hhx03saj4Ct1WBnx+tJ3PrLYcCwJdxHb/DW4mqE9z+G/N6J/FOZSfQf0XVfnWB+4o2
         fv+IL43AxX1h5I0fvdH/Ze03GZr7YJCTnosdg8Ks=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201030125257eucas1p1ffcac6882167ee387f682b29066d0d52~CxjvYCYWI1801418014eucas1p17;
        Fri, 30 Oct 2020 12:52:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.2F.05997.9AC0C9F5; Fri, 30
        Oct 2020 12:52:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830~CxjvAP6nC1110711107eucas1p2V;
        Fri, 30 Oct 2020 12:52:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125257eusmtrp1925359b91772649796f3dbe24a203418~Cxju7NssW0319303193eusmtrp1f;
        Fri, 30 Oct 2020 12:52:57 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-ea-5f9c0ca965c4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.47.06017.9AC0C9F5; Fri, 30
        Oct 2020 12:52:57 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125256eusmtip27b6e264b0d8ca5524ddd3eb520fb0916~CxjuRlRJZ1667716677eusmtip2G;
        Fri, 30 Oct 2020 12:52:56 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 1/6] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Date:   Fri, 30 Oct 2020 13:51:44 +0100
Message-Id: <20201030125149.8227-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRTu3Xd1OPmcQidNpVVENy0VeskIK8FFFCZdqChb+qWSTtmcZWho
        XvLeULw0RU2CmRmaqYhZ1FyNsBxYmaU2UtOUIkrNS6I1v1X+e57zPs85zzm8LCHtpFzYSGUc
        r1IqomS0mGx5Nmveetu+PGTbwH0PbKlIR/heaT2F306OUrjS2EXh11PfaFzysJHGBRYtic3m
        Bga/aiun8USeEeFS8yMRvmscYHBfSg2N0x8aGdzx5RqFSwvHaH9O3libRcv7e9ppuSXHJJLn
        N9Ui+USjexB1UrwrjI+KjOdVXrvPiiNGFg1kbIHs0q2KaSYZ9bpmI5YFzhdGDFuzkZiVcjUI
        MhfyGIFMIpi5WoYEMoGgskhPZCO7JcfQVIVNpUdwM6WO/md539xHW1U0tx3ynuYjK3bmAiDj
        UwVpxQQ3KILUyqVOTpwCetI/UVZMcuuhTm9a8kq4nVA0+M42zQPuNDxewnacH2Rn9YoEjSM8
        vzFs6+kBqc1lhDUEcGMMzPV/FgnmAPj4os3WyAnGTU2MgFdDZ2EuKRhSEeQ+6GMEokVgMVUh
        QeUH/V1ztPVMBLcR6tu8hPIe+DndzgjXc4Der45CCAcoaCkhhLIEMjOkgnod/KotscVxgZzh
        RVKQyOFed6AWrdEt20a3bBvd/7FViKhFK3mNOjqcV3sr+YueakW0WqMM9wyNiW5Ef75Y54Jp
        shW1zZ8zII5FMnuJv0dZiJRSxKsTog0IWELmLNn7svOMVBKmSLjMq2JCVJooXm1AriwpWynx
        qR47LeXCFXH8BZ6P5VV/X0WsnUsy4oYuTZgSVySJfI7oR9GPYK278btsH/Stnd9x0NkTH7Ls
        D7mg32vXcSBtxxU3J2pD60xHpHdo8eGomIvHG0SnkLsk9smT7tlB7y2rzO1zscP5gVPVpfGJ
        yrhpTY2v+Ktj8BtNd9XgseK0zdJWt8ij57t0SUHV11oKtSfOjJ9H1z/ISHWEYvsmQqVW/AaI
        e8CKXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7oreebEGzyYzW5xf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFscftPOajFj8ks2BwGPTas62TzuXNvD5nG/+ziTR9+WVYwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU8+3+IpWCS
        UsWSed/ZGxhvSHcxcnJICJhIPP46j72LkYtDSGApo0TjjaVADgdQQkpifosSRI2wxJ9rXWwQ
        NZ8YJQ5Ma2UHSbAJGEr0Hu1jBLFFBDwkTrWuZQUpYhb4wCSx9kEvWEJYIF5iwrN7YDaLgKrE
        muXH2UBsXgEriamPbjJDbJCXWL3hAJjNKWAt0dV5gwnkCCGgmrcHqiDKBSVOznzCAhJmFlCX
        WD9PCCTMDNTZvHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZG
        YGRuO/Zzyw7GrnfBhxgFOBiVeHgd5GfHC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++
        qDQntfgQoynQZxOZpUST84FJI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoR
        TB8TB6dUA6PKhWiX/e0m1ziTrKYXHL3RFnSy8NATrm3nV3uqCrOnPcne3vE+2cteoVCg3ELk
        Xl7wD+3vN4pmME/YY9nSMuHX2UbT/isb43P/it14ruPuOnnrmxNMahemzak9fOrhXWk7g9cH
        mllkri/1bApgKGHpX/5wR/rvoNNvfbes3/OuaW1Qr3Rl2jUlluKMREMt5qLiRADQU3/74gIA
        AA==
X-CMS-MailID: 20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830@eucas1p2.samsung.com>
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
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index e71f752..e34175c 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -51,6 +51,16 @@ Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
 
+Optional properties for interconnect functionality (QoS frequency constraints):
+- #interconnect-cells: should be 0.
+- interconnects: as documented in ../interconnect.txt, describes a path
+  at the higher level interconnects used by this interconnect provider.
+  If this interconnect provider is a parent of a top level interconnect
+  provider the property contains only one phandle.
+
+- samsung,data-clock-ratio: ratio of the data troughput in B/s to minimum data
+   clock frequency in Hz, default value is 8 when this property is missing.
+
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
 	VDD_MIF |--- DMC
@@ -135,7 +145,7 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- PERIC (Fixed clock rate)
 		|--- FSYS  (Fixed clock rate)
 
-Example1:
+Example 1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
 	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
@@ -184,7 +194,7 @@ Example1:
 	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
 	----------------------------------------------------------
 
-Example2 :
+Example 2:
 	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
 	is listed below:
 
@@ -419,3 +429,57 @@ Example2 :
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

