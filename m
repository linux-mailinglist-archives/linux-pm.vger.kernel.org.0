Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6050F14F88
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEFPMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49975 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfEFPMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151216euoutp0260f54343782e1fc6a9111c1f988f793a~cILXQJaJR3068630686euoutp02N
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151216euoutp0260f54343782e1fc6a9111c1f988f793a~cILXQJaJR3068630686euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155536;
        bh=dUZfqSXJsaz56c/7kRGHkvXlW7LHNJPdaGMb6gGbx68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQgolwaeGP7J9DecYoyjZH3FMcWyhiIZUIwjARe90jgFHmcWPDJCTFyidAKazlBYo
         qX5U3FO9fD5hTncmM+/tkcKyA6XYFrieKcM8HY9DRsPs3HyjLFmq91S87YpgROvx2K
         hKEypid8ymFTk7yGW61rS/Z3W4cLnljgo6rj9/no=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506151215eucas1p1a290a0836c8affdc98c7e42a22b44f06~cILWJIwVR1902819028eucas1p1s;
        Mon,  6 May 2019 15:12:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.A3.04377.ECE40DC5; Mon,  6
        May 2019 16:12:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838~cILVKIQE91902819028eucas1p1p;
        Mon,  6 May 2019 15:12:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151213eusmtrp2fb10c26316455ab506cb8fba8c3a76b3~cILU8EWUD0409004090eusmtrp2U;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-80-5cd04eced59e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.5D.04146.DCE40DC5; Mon,  6
        May 2019 16:12:13 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151213eusmtip171ab8c5ad539595e8c9882e10a422c2b~cILUMQvI30071300713eusmtip1P;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v7 05/13] dt-bindings: ddr: add LPDDR3 memories
Date:   Mon,  6 May 2019 17:11:53 +0200
Message-Id: <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTURj07Xa3S7XNUoy8CGJSYzwSQQ0mz2rwjhtUYvSPQRItsgGVcnSp
        iHhUtByVKmqCcqloolgxyCFiY2osBTyQFoUARYWIiHITijco6xb9NzPfzDdfXh6Fy2uI2dT+
        mARWE6OKVpASUWXtd/uShhBH2NLzRQiVXi4hUIurh0BXbQ0EujPSBdDF5wUYqj+jRue6+nBk
        t98To5cp/WLk1Pmi1+Z8Eo0abQBdtlswdNf2VozaTxaRqLo/jUCPm4JR+08Z+vL0PVjrxXwZ
        uyBi8nSNIuZh7lsxU2bKIBnjqUGSeTL4CGPOVpgAU/4imRkt89vuESpZHcFG7z/EagKC9kqi
        2nQOIm5o/uHbz8pIHbjrZwAeFKQDYcmNFNwAJJScLgIw87qZFIgLwLTuDpFARgEc+tRDTEX0
        rbliYXALwMHG+9i/yLfP9klCUSTtD6tM8XxgJp0M37Q8/tuB0/0YfPnjm4j3eNFrYG/eCd4j
        oudDU5NTzGMpHQzLm8dJocwPtjVk4Dz2oLfA8XQr4PdA+p0Y9gxbcMG0Edr6eoCAvWBvXYVY
        wL7w98OrmIA5qDMWuj1HYde5ArdnFayuayT4e3B6ESwxBwjyOug8PQh4GdIy2Drgycv4JLxQ
        eQkXZClMT5UL7oWwItPhLpoFbxVnu5czMMNmA8LrXAHQmN5JZIG5uf/LrgFgAt6sllNHstzy
        GDbRn1OpOW1MpP++WHUZmPxcLybqXFXA/CvcCmgKKGZIs9Y7wuSE6hCXpLYCSOGKmVLVx4Yw
        uTRClXSE1cTu0WijWc4KfCiRwluaPK1zt5yOVCWwB1k2jtVMTTHKY7YOrHQEla7/wIYo68dv
        WpdOSxxINGdXPzAW7JrjLM5pPv5mg/eCHdh0V07UtcJis6ch88dA7+2a6Bas+4BsZWh9/LOA
        n/k7thqPjflY51m3yPR6y6tgRdSmJKDf2TYh8VzUF68PNHQ4lLX6bGVO6gpl1vC2zZb0kfNt
        gVpXuNOi/KoQcVGqZYtxDaf6A9vhVpNYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7pn/S7EGLxsMbfYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBaH37SzWuy/4mVx+zefxbcTjxgdhD2+fZ3E4jG74SKLx85Zd9k9Nq3q
        ZPPobX7H5nHw3R4mj74tqxg9Np+u9vi8SS6AM0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv42bDBdaC96oVK09uYmtgXCvXxcjJISFgItF6YxZ7
        FyMXh5DAUkaJu2uXs0EkxCQm7dvODmELS/y51sUGUfSJUeLixLusXYwcHGwCehI7VhWC1IgI
        1Ev0v7kEVsMs0MAssWb7VbAaYQF7iVez60FqWARUJVZduQU2k1fAS2Lz1b9Qu+Qkbp7rZAax
        OQW8Jf52HGIEsYWAavZ9/M0ygZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBI2nbs
        5+YdjJc2Bh9iFOBgVOLhfWB7IUaINbGsuDL3EKMEB7OSCG/is3MxQrwpiZVVqUX58UWlOanF
        hxhNgY6ayCwlmpwPjPK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2MZldfph+w2jV33vaUOT9WPpgjOEd6gV2tVmv7fsfiac63E/QaV/nr+hRI/9u5McH0dluK
        /7MVWw+/e8sbLvJ4/51F2fsvvjh1YLqyxaNP2/cur+A99+vX55U7lT67ZB+2abtx1OaQkVbq
        jPhSicK7izZLdZuWlG3/ZyGbJHjprktN6k8z2WeMNUosxRmJhlrMRcWJAMP+RKy6AgAA
X-CMS-MailID: 20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specifies the AC timing parameters of the LPDDR3 memory device.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/ddr/lpddr3-timings.txt     | 58 +++++++++++++
 Documentation/devicetree/bindings/ddr/lpddr3.txt   | 97 ++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt

diff --git a/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
new file mode 100644
index 0000000..3a2ef3a
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
+timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
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
index 0000000..0dc86a3
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
+	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
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
2.7.4

