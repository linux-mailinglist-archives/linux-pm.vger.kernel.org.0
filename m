Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A767014FB1
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEFPMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35536 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfEFPMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151214euoutp012a26445259fc7d45ca2b29cc5e87b17b~cILVw0fcC1904419044euoutp014
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506151214euoutp012a26445259fc7d45ca2b29cc5e87b17b~cILVw0fcC1904419044euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155534;
        bh=OCpXS+Jb9Fk3/oWkOFw8iN+37kpPT5cCAUph8JfvjHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzpsWhFQDKz+8ubr6X3jlH/KJmBlnr2QAjc7+6Nj5qosteEBlRdYB6RcbPGJEI7vT
         Z1KxbZ5DEM/ZWi8xtxvQe8MwmEIDa0yHaI7L+y/T+E79Ury3J0ZYzGrUJiKYxGsn8S
         tf0KEtmTW7mzIN2Kawv3P5Sb0kOIjGBCkfuHZ+Oo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151214eucas1p248c5fc62f3437b4629003764bf966225~cILVESlH60846408464eucas1p2Z;
        Mon,  6 May 2019 15:12:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.A3.04377.DCE40DC5; Mon,  6
        May 2019 16:12:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654~cILUM3wL50624506245eucas1p2Z;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151213eusmtrp2fb5f389df628cd86efafc58d47fadd46~cILUMVFYc0409004090eusmtrp2Q;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-7f-5cd04ecd207a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.5D.04146.DCE40DC5; Mon,  6
        May 2019 16:12:13 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151212eusmtip150339d5024b91c7b0c514f035abe58a9~cILTb-3ow3248532485eusmtip1s;
        Mon,  6 May 2019 15:12:12 +0000 (GMT)
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
Subject: [PATCH v7 04/13] dt-bindings: ddr: rename lpddr2 directory
Date:   Mon,  6 May 2019 17:11:52 +0200
Message-Id: <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7pn/S7EGNzeq2uxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+XQJXxs3pPAVn/CpW/9rP
        2MC43b6LkZNDQsBE4s2Uq2wgtpDACkaJAzvKuxi5gOwvjBIPT01mhHA+M0p8vfibEaZj2e19
        UInljBKv+j6zwrXs3dHE3sXIwcEmoCexY1UhSIOIQLXEnev7mUFqmAXeMEmc/fWDBSQhLOAs
        8WzxPHYQm0VAVeLDun/MIDavgJfE7G27oLbJSdw81wkW5xTwlvjbcQhss4TALXaJFa8uM0EU
        uUhMfzuHDcIWlnh1fAs7hC0j8X/nfKiaYomG3oVQQ2skHvfPhaqxljh8/CIryNHMApoS63fp
        Q4QdJRYtvwf2i4QAn8SNt4IgYWYgc9K26cwQYV6JjjYhiGoNiS09F6AWiUksXzMNqtND4t1n
        DkjozGOUuHriG8sERvlZCLsWMDKuYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExap/8d
        /7KDcdefpEOMAhyMSjy8E5wuxAixJpYVV+YeYpTgYFYS4U18di5GiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA6Osqtmid1t44qXkM0WKXcS82SexChel
        LniZ8WLSsZq+/ntti75VfNn+73l6U4Xj/4Z76/9Z2e39rx/+TuvF+s0dnC8bkxb980mWNGd2
        n7m0q32K04IbTjuWnHowjfuRvXEZT7fW9qtLtoR7fo/qsS2cwqoarOKt1mOi3mZt/kU2Mlz3
        bXhHjBJLcUaioRZzUXEiAHuG1J5WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7pn/S7EGDy/wmqxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexs3pPAVn/CpW/9rP2MC43b6LkZNDQsBEYtntfYxd
        jFwcQgJLGSW2L3vKCJEQk5i0bzs7hC0s8edaFxtE0SdGiQUPO4GKODjYBPQkdqwqBKkREaiX
        6H9zCayGWaCBWWLN9qusIAlhAWeJZ4vngQ1iEVCV+LDuHzOIzSvgJTF72y6oZXISN891gsU5
        Bbwl/nYcAosLAdXs+/ibZQIj3wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBkbTt2M/N
        OxgvbQw+xCjAwajEw/vA9kKMEGtiWXFl7iFGCQ5mJRHexGfnYoR4UxIrq1KL8uOLSnNSiw8x
        mgIdNZFZSjQ5HxjleSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUa
        GGtrHk3O2aPGweTv+8HaRXp/19ENnXu2SVsJPmD6HDknN7Q6+VFD0K5bhyw2Fc1aq/lAQ+bp
        YrXyHH6hd/8XLOe0l57eXH9EYJPhDfsCnuIFKpolkp8U1u5dF6wyJ2tXFtPJyhUZcRl/K6UV
        3wTfdqqyNdc68SPRcz1nuq7a1WPnf3PnvRBKUmIpzkg01GIuKk4EACndG7S6AgAA
X-CMS-MailID: 20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change directory name to be ready for new types of memories.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/ddr/lpddr2-timings.txt     |  52 +++++++++++
 Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 +++++++++++++++++++++
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |  52 -----------
 .../devicetree/bindings/lpddr2/lpddr2.txt          | 102 ---------------------
 4 files changed, 154 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt

diff --git a/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
new file mode 100644
index 0000000..9ceb19e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
@@ -0,0 +1,52 @@
+* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
+
+Required properties:
+- compatible : Should be "jedec,lpddr2-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
+- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds). Parameters with
+a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
+- tRCD
+- tWR
+- tRAS-min
+- tRRD
+- tWTR
+- tXP
+- tRTP
+- tDQSCK-max
+- tFAW
+- tZQCS
+- tZQinit
+- tRPab
+- tZQCL
+- tCKESR
+- tRAS-max-ns
+- tDQSCK-max-derated
+
+Example:
+
+timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+	compatible	= "jedec,lpddr2-timings";
+	min-freq	= <10000000>;
+	max-freq	= <400000000>;
+	tRPab		= <21000>;
+	tRCD		= <18000>;
+	tWR		= <15000>;
+	tRAS-min	= <42000>;
+	tRRD		= <10000>;
+	tWTR		= <7500>;
+	tXP		= <7500>;
+	tRTP		= <7500>;
+	tCKESR		= <15000>;
+	tDQSCK-max	= <5500>;
+	tFAW		= <50000>;
+	tZQCS		= <90000>;
+	tZQCL		= <360000>;
+	tZQinit		= <1000000>;
+	tRAS-max-ns	= <70000>;
+};
diff --git a/Documentation/devicetree/bindings/ddr/lpddr2.txt b/Documentation/devicetree/bindings/ddr/lpddr2.txt
new file mode 100644
index 0000000..ddd4012
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2.txt
@@ -0,0 +1,102 @@
+* LPDDR2 SDRAM memories compliant to JEDEC JESD209-2
+
+Required properties:
+- compatible : Should be one of - "jedec,lpddr2-nvm", "jedec,lpddr2-s2",
+  "jedec,lpddr2-s4"
+
+  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
+
+  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
+
+  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
+
+- density  : <u32> representing density in Mb (Mega bits)
+
+- io-width : <u32> representing bus width. Possible values are 8, 16, and 32
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+- tRRD-min-tck
+- tWTR-min-tck
+- tXP-min-tck
+- tRTP-min-tck
+- tCKE-min-tck
+- tRPab-min-tck
+- tRCD-min-tck
+- tWR-min-tck
+- tRASmin-min-tck
+- tCKESR-min-tck
+- tFAW-min-tck
+
+Child nodes:
+- The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
+  "lpddr2-timings" provides AC timing parameters of the device for
+  a given speed-bin. The user may provide the timings for as many
+  speed-bins as is required. Please see Documentation/devicetree/
+  bindings/ddr/lpddr2-timings.txt for more information on "lpddr2-timings"
+
+Example:
+
+elpida_ECB240ABACN : lpddr2 {
+	compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+	density		= <2048>;
+	io-width	= <32>;
+
+	tRPab-min-tck	= <3>;
+	tRCD-min-tck	= <3>;
+	tWR-min-tck	= <3>;
+	tRASmin-min-tck	= <3>;
+	tRRD-min-tck	= <2>;
+	tWTR-min-tck	= <2>;
+	tXP-min-tck	= <2>;
+	tRTP-min-tck	= <2>;
+	tCKE-min-tck	= <3>;
+	tCKESR-min-tck	= <3>;
+	tFAW-min-tck	= <8>;
+
+	timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+		compatible	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <400000000>;
+		tRPab		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <7500>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQCL		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+	timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
+		compatible	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <200000000>;
+		tRPab		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <10000>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQCL		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+}
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
deleted file mode 100644
index 9ceb19e..0000000
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
-
-Required properties:
-- compatible : Should be "jedec,lpddr2-timings"
-- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
-- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
-
-Optional properties:
-
-The following properties represent AC timing parameters from the memory
-data-sheet of the device for a given speed-bin. All these properties are
-of type <u32> and the default unit is ps (pico seconds). Parameters with
-a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
-- tRCD
-- tWR
-- tRAS-min
-- tRRD
-- tWTR
-- tXP
-- tRTP
-- tDQSCK-max
-- tFAW
-- tZQCS
-- tZQinit
-- tRPab
-- tZQCL
-- tCKESR
-- tRAS-max-ns
-- tDQSCK-max-derated
-
-Example:
-
-timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
-	compatible	= "jedec,lpddr2-timings";
-	min-freq	= <10000000>;
-	max-freq	= <400000000>;
-	tRPab		= <21000>;
-	tRCD		= <18000>;
-	tWR		= <15000>;
-	tRAS-min	= <42000>;
-	tRRD		= <10000>;
-	tWTR		= <7500>;
-	tXP		= <7500>;
-	tRTP		= <7500>;
-	tCKESR		= <15000>;
-	tDQSCK-max	= <5500>;
-	tFAW		= <50000>;
-	tZQCS		= <90000>;
-	tZQCL		= <360000>;
-	tZQinit		= <1000000>;
-	tRAS-max-ns	= <70000>;
-};
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
deleted file mode 100644
index 58354a0..0000000
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-* LPDDR2 SDRAM memories compliant to JEDEC JESD209-2
-
-Required properties:
-- compatible : Should be one of - "jedec,lpddr2-nvm", "jedec,lpddr2-s2",
-  "jedec,lpddr2-s4"
-
-  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
-
-  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
-
-  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
-
-- density  : <u32> representing density in Mb (Mega bits)
-
-- io-width : <u32> representing bus width. Possible values are 8, 16, and 32
-
-Optional properties:
-
-The following optional properties represent the minimum value of some AC
-timing parameters of the DDR device in terms of number of clock cycles.
-These values shall be obtained from the device data-sheet.
-- tRRD-min-tck
-- tWTR-min-tck
-- tXP-min-tck
-- tRTP-min-tck
-- tCKE-min-tck
-- tRPab-min-tck
-- tRCD-min-tck
-- tWR-min-tck
-- tRASmin-min-tck
-- tCKESR-min-tck
-- tFAW-min-tck
-
-Child nodes:
-- The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
-  "lpddr2-timings" provides AC timing parameters of the device for
-  a given speed-bin. The user may provide the timings for as many
-  speed-bins as is required. Please see Documentation/devicetree/
-  bindings/lpddr2/lpddr2-timings.txt for more information on "lpddr2-timings"
-
-Example:
-
-elpida_ECB240ABACN : lpddr2 {
-	compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
-	density		= <2048>;
-	io-width	= <32>;
-
-	tRPab-min-tck	= <3>;
-	tRCD-min-tck	= <3>;
-	tWR-min-tck	= <3>;
-	tRASmin-min-tck	= <3>;
-	tRRD-min-tck	= <2>;
-	tWTR-min-tck	= <2>;
-	tXP-min-tck	= <2>;
-	tRTP-min-tck	= <2>;
-	tCKE-min-tck	= <3>;
-	tCKESR-min-tck	= <3>;
-	tFAW-min-tck	= <8>;
-
-	timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
-		compatible	= "jedec,lpddr2-timings";
-		min-freq	= <10000000>;
-		max-freq	= <400000000>;
-		tRPab		= <21000>;
-		tRCD		= <18000>;
-		tWR		= <15000>;
-		tRAS-min	= <42000>;
-		tRRD		= <10000>;
-		tWTR		= <7500>;
-		tXP		= <7500>;
-		tRTP		= <7500>;
-		tCKESR		= <15000>;
-		tDQSCK-max	= <5500>;
-		tFAW		= <50000>;
-		tZQCS		= <90000>;
-		tZQCL		= <360000>;
-		tZQinit		= <1000000>;
-		tRAS-max-ns	= <70000>;
-	};
-
-	timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
-		compatible	= "jedec,lpddr2-timings";
-		min-freq	= <10000000>;
-		max-freq	= <200000000>;
-		tRPab		= <21000>;
-		tRCD		= <18000>;
-		tWR		= <15000>;
-		tRAS-min	= <42000>;
-		tRRD		= <10000>;
-		tWTR		= <10000>;
-		tXP		= <7500>;
-		tRTP		= <7500>;
-		tCKESR		= <15000>;
-		tDQSCK-max	= <5500>;
-		tFAW		= <50000>;
-		tZQCS		= <90000>;
-		tZQCL		= <360000>;
-		tZQinit		= <1000000>;
-		tRAS-max-ns	= <70000>;
-	};
-
-}
-- 
2.7.4

