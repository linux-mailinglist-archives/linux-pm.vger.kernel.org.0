Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E231C5BC9C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGANMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49170 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfGANLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131153euoutp028f81927e232eead7cdcd3dc0ed28db65~tSqPGpLoo1098810988euoutp02P
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190701131153euoutp028f81927e232eead7cdcd3dc0ed28db65~tSqPGpLoo1098810988euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986713;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uL+Vq78rWlTkWirhueJNd/n2ozK3Ixf/aFsdH53d3yL+WaC7UiMe54Uxn3yxWQNsa
         BOLm+iMVt45y6/pD7WNtAnLqDroAdNLgOH92OJ36dsx9OEx1ckpaGxznL6jDFAKADb
         ShldxJz+u2txycO+MgGTb5aggSR4eN6yHf5PJH0E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701131152eucas1p113f79b9b0affd2f6ff7e7c177e60c463~tSqOSS5dn1001910019eucas1p1J;
        Mon,  1 Jul 2019 13:11:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.77.04325.7960A1D5; Mon,  1
        Jul 2019 14:11:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701131151eucas1p2b9f0982ed2d285d212964d7857e6ed8a~tSqNg8ODM1085710857eucas1p2F;
        Mon,  1 Jul 2019 13:11:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131151eusmtrp29fb24a7bc0cedec4a96bb0c96504c64c~tSqNSuyww0788807888eusmtrp26;
        Mon,  1 Jul 2019 13:11:51 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-d4-5d1a06975ab5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.02.04146.7960A1D5; Mon,  1
        Jul 2019 14:11:51 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131150eusmtip149a6f1edec1697042f7eb6848979667b~tSqMZqBIW2623726237eusmtip1b;
        Mon,  1 Jul 2019 13:11:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v11 2/9] dt-bindings: ddr: add LPDDR3 memories
Date:   Mon,  1 Jul 2019 15:11:31 +0200
Message-Id: <20190701131138.22666-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeyxVcRzvd8/TrWuny/JLFu6iSHq331YrvbZTy9bW+iOxOupQy0X3oIf+
        uHVR5KZodSOJiF3qInmVt8WShJJn7tBLyorbeirH0frv8/08vp/tuy+NKc2EPX04OIzXBHNB
        KlKOFz/63rLkKmnvt+xSzUpUYDAR6OX4WwKl1T8lUO7nQYB0t0wkSnqcKkNPzqtRwuAHDLW0
        5FOo+cwIhbq1Duhz/CsCtZdfJ9GYvh4gQ0ulDN2p76NQ6+OtqOd0DonqRs4SaKKjAEdVz7ej
        np/W6GvjAPCyY79aEnF2tDOaYlO0rThbltxHsYXGWJKtSs2jWL3uE8nWfHooYy8UGQF7rymS
        HSucv3Omj3zdQT7ocASvWbp+v/yQ3tBEhha4Hv89/IvSgv75cYCmIbMKdk+cjANyWsnkAPhC
        Z6KkYXxyGM2QScMYgNHjWjIOWE0lvjcPkJKQDaAuY4gShanIQOlucS3JeMJS41GRtmUMAKa8
        2yX6MaYEgx97eoEo2DDrYW9U4lQWZ1xgXXU+LmYVzAbY1Xlc6nKEufnVmIitGC/YZumb6oXM
        JRqOtBsxybQFmoeTcQnbwOGGIkrCDvBPWZpMwgLU6tOBhE/BwYTUac9aWNfQSoi9GOMGTeVL
        JXojvNt+m5QuZA07P84WaWwSJhZfxSRaAc/FKCX3IlgU/2y6aA7MzrsyvZyFhgT99D2TAKyq
        tOAXgWPy/7KbABiBHR8uqAN5YWUwf8xT4NRCeHCg54EQdSGY/LumiQZLKaj85V8LGBqoZim0
        vdBPSXARwgl1LYA0prJVVOXM9VMqDnInTvKakH2a8CBeqAXzaFxlp4icYd6rZAK5MP4Iz4fy
        mn+qjLay1wKrTQE6H7Oz056KGVr/ELe6yMxGeZnTlcx034BvaaOuxOotsc07PBzzeu/Hfpib
        77xtcWhH1+vGNYLZZoX1hazyEaLExZzq5GH5Ur1g7E3lun5b/FrF+ze6xHPeKEPD+XJtP9xu
        XH7l7lrsmBUz5B2VUmwi8+w2b461XdjDnHpQFKPChUPccndMI3B/ARVusy1zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7rT2aRiDQ5eZLbYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y+idcZqtYKNaxd9Xf9gbGO/LdTFyckgImEj8PPuIrYuRi0NIYCmjxLNz81khEmISk/ZtZ4ew
        hSX+XOuCKvrEKHH0/n7mLkYODjYBPYkdqwpB4iICcxglfnZtYwRxmAXOMkvsXvGGCaRbWMBO
        4k7LJLBJLAKqEocPbGABaeYVsJe4eaMCYoG8xOoNB5hBbE4BB4lLX++ygdhCQCXrFt9gnMDI
        t4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgFG479nPzDsZLG4MPMQpwMCrx8GrckogV
        Yk0sK67MPcQowcGsJMK7f4VkrBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnAxNEXkm8oamh
        uYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxqm+h3OFa2U69ntI/MzYv6dl
        3rTJjVx33N4runROszo8+0bP+q+6NRo79/tfOFr9Knids1PtubOTaj2Mmu4ebb3M/WT2/KcP
        7nR5VQlcdzQI8T/Iv3DZTQHfLxO1s04cvsL9mnf50QvGWSGHC0XNfpx02b35/c3jC98l53J/
        Zqpoby5wnbv+3mklluKMREMt5qLiRABO4naY2AIAAA==
X-CMS-MailID: 20190701131151eucas1p2b9f0982ed2d285d212964d7857e6ed8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131151eucas1p2b9f0982ed2d285d212964d7857e6ed8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131151eucas1p2b9f0982ed2d285d212964d7857e6ed8a
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131151eucas1p2b9f0982ed2d285d212964d7857e6ed8a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specifies the AC timing parameters of the LPDDR3 memory device.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../bindings/ddr/lpddr3-timings.txt           | 58 +++++++++++
 .../devicetree/bindings/ddr/lpddr3.txt        | 97 +++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt

diff --git a/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
new file mode 100644
index 000000000000..84705e50a3fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
@@ -0,0 +1,58 @@
+* AC timing parameters of LPDDR3 memories for a given speed-bin.
+
+The structures are based on LPDDR2 and extended where needed.
+
+Required properties:
+- compatible : Should be "jedec,lpddr3-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
+- reg : maximum DDR clock frequency for the speed-bin. Type is <u32>
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds).
+- tRFC
+- tRRD
+- tRPab
+- tRPpb
+- tRCD
+- tRC
+- tRAS
+- tWTR
+- tWR
+- tRTP
+- tW2W-C2C
+- tR2R-C2C
+- tFAW
+- tXSR
+- tXP
+- tCKE
+- tCKESR
+- tMRD
+
+Example:
+
+timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
+	compatible	= "jedec,lpddr3-timings";
+	reg		= <800000000>; /* workaround: it shows max-freq */
+	min-freq	= <100000000>;
+	tRFC		= <65000>;
+	tRRD		= <6000>;
+	tRPab		= <12000>;
+	tRPpb		= <12000>;
+	tRCD		= <10000>;
+	tRC		= <33750>;
+	tRAS		= <23000>;
+	tWTR		= <3750>;
+	tWR		= <7500>;
+	tRTP		= <3750>;
+	tW2W-C2C	= <0>;
+	tR2R-C2C	= <0>;
+	tFAW		= <25000>;
+	tXSR		= <70000>;
+	tXP		= <3750>;
+	tCKE		= <3750>;
+	tCKESR		= <3750>;
+	tMRD		= <7000>;
+};
diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
new file mode 100644
index 000000000000..3b2485b84b3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
@@ -0,0 +1,97 @@
+* LPDDR3 SDRAM memories compliant to JEDEC JESD209-3C
+
+Required properties:
+- compatible : Should be  - "jedec,lpddr3"
+- density  : <u32> representing density in Mb (Mega bits)
+- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
+- #address-cells: Must be set to 1
+- #size-cells: Must be set to 0
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+- tRFC-min-tck
+- tRRD-min-tck
+- tRPab-min-tck
+- tRPpb-min-tck
+- tRCD-min-tck
+- tRC-min-tck
+- tRAS-min-tck
+- tWTR-min-tck
+- tWR-min-tck
+- tRTP-min-tck
+- tW2W-C2C-min-tck
+- tR2R-C2C-min-tck
+- tWL-min-tck
+- tDQSCK-min-tck
+- tRL-min-tck
+- tFAW-min-tck
+- tXSR-min-tck
+- tXP-min-tck
+- tCKE-min-tck
+- tCKESR-min-tck
+- tMRD-min-tck
+
+Child nodes:
+- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
+  "lpddr3-timings" provides AC timing parameters of the device for
+  a given speed-bin. Please see Documentation/devicetree/
+  bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
+
+Example:
+
+samsung_K3QF2F20DB: lpddr3 {
+	compatible	= "Samsung,K3QF2F20DB", "jedec,lpddr3";
+	density		= <16384>;
+	io-width	= <32>;
+	#address-cells	= <1>;
+	#size-cells	= <0>;
+
+	tRFC-min-tck		= <17>;
+	tRRD-min-tck		= <2>;
+	tRPab-min-tck		= <2>;
+	tRPpb-min-tck		= <2>;
+	tRCD-min-tck		= <3>;
+	tRC-min-tck		= <6>;
+	tRAS-min-tck		= <5>;
+	tWTR-min-tck		= <2>;
+	tWR-min-tck		= <7>;
+	tRTP-min-tck		= <2>;
+	tW2W-C2C-min-tck	= <0>;
+	tR2R-C2C-min-tck	= <0>;
+	tWL-min-tck		= <8>;
+	tDQSCK-min-tck		= <5>;
+	tRL-min-tck		= <14>;
+	tFAW-min-tck		= <5>;
+	tXSR-min-tck		= <12>;
+	tXP-min-tck		= <2>;
+	tCKE-min-tck		= <2>;
+	tCKESR-min-tck		= <2>;
+	tMRD-min-tck		= <5>;
+
+	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
+		compatible	= "jedec,lpddr3-timings";
+		reg		= <800000000>; /* workaround: it shows max-freq */
+		min-freq	= <100000000>;
+		tRFC		= <65000>;
+		tRRD		= <6000>;
+		tRPab		= <12000>;
+		tRPpb		= <12000>;
+		tRCD		= <10000>;
+		tRC		= <33750>;
+		tRAS		= <23000>;
+		tWTR		= <3750>;
+		tWR		= <7500>;
+		tRTP		= <3750>;
+		tW2W-C2C	= <0>;
+		tR2R-C2C	= <0>;
+		tFAW		= <25000>;
+		tXSR		= <70000>;
+		tXP		= <3750>;
+		tCKE		= <3750>;
+		tCKESR		= <3750>;
+		tMRD		= <7000>;
+	};
+}
-- 
2.17.1

