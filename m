Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E999038D50
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfFGOgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50190 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfFGOfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143530euoutp019e150dea856ada142f6a1fb6b74078d8~l8UZwAnZF0066800668euoutp01b
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143530euoutp019e150dea856ada142f6a1fb6b74078d8~l8UZwAnZF0066800668euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918130;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUd3DJDFydRgIRb1wSmlJBbQ4sLJo330xv0S6aN8QIx9pGrbs88Mbgjm1V9qa+wRj
         4mvQmuGqoRcrvmL1bRyWM5/YQhXJTDKQ/UHncY6H+v1gNx8R6al1WDBdLoNk7C5rTC
         bgn/zA0UUny+GGFPpZAY/dpEHGkNr3VyRJQ99uMs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143529eucas1p2f1942131f42508dc3fbad6e2b96e3f77~l8UYgLPAs2697326973eucas1p2X;
        Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.D0.04325.1367AFC5; Fri,  7
        Jun 2019 15:35:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143528eucas1p12875b8f2043264a452da2720195f629e~l8UXsmBcR0689306893eucas1p1J;
        Fri,  7 Jun 2019 14:35:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143528eusmtrp12e45643bf05350efcaef04c0c5f2fe80~l8UXc3VHa1284512845eusmtrp1W;
        Fri,  7 Jun 2019 14:35:28 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-96-5cfa76318c1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.C0.04140.0367AFC5; Fri,  7
        Jun 2019 15:35:28 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143527eusmtip1100954d82fb8c7f2fa2af89594ded323~l8UWgL4uq2464524645eusmtip1W;
        Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
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
Subject: [PATCH v9 05/13] dt-bindings: ddr: add LPDDR3 memories
Date:   Fri,  7 Jun 2019 16:34:59 +0200
Message-Id: <20190607143507.30286-6-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRz3e557Xjpde1zot6TsRmKTjD9+G1It2+Nlw/BHyTh5FtNddY8i
        sl01UTpZSacXSUu5anWppFn0Qi+XrpZelGRqO1J5uRxSTddz+O/z/Xw+39/ns+9+NC4dIZzp
        08qznEopD5WRYlH1i18dGzZFTQd56Sx2SK8tI1DflIlAuU0dBCr+OgJQfH4ZidLacjDUfk2B
        UkY+4choLKfQy7hxCg2oXdDX5LcE6q7NJpFZ0wSQ1liHodKmIQp1te1Eg7FFJGocv0KguV69
        CD19tRsN/nZAlpb3wMeJtXxPFbGf+y9TbJa6S8Q+zhyi2ApdIsk+zSmhWE38JMnWTz7B2OuV
        OsA+NFxkzRWu+xcHired5EJPR3Gqjd7Hxac0WgMZrnc/Pzs2Q6nBsGsSsKMhswVWVBXjSUBM
        S5kiAPOq7mDCMAXgtz4zIQxmAFtiTaK/K916HSkIhQDG3e4h/6186ZuhkgBNk4wnrNFFWBeW
        MloAsz4ctHpw5hEOJwbfAKvgyOyAo3OPF7CIWQOH49tIK5bM8x9zsnAhzQ0Wlz9bwHaMD8yq
        rlkIg4yGhtqPFkww+cO2HzO2eo5wrLmSErALNKQl23geqjV5QMAxcCQlx+bZChubuwhraZxZ
        B8tqNwq0L+wYaMWsNGQcYP/EEiuNz8PU6gxcoCXwaoJUcHvAyuROW5nlsLDklu1xFt57W2c7
        bxqAjYYC4gZwy/wfdhcAHXDiInlFCMdvVnLnPHm5go9UhngGhykqwPzXM8w1f68BdTMnGgBD
        A5m9hKV+BUkJeRQfrWgAkMZlSyVRnT+DpJKT8ugLnCrsmCoylOMbwApaJHOSXFz07oiUCZGf
        5c5wXDin+qtitJ2zGhi1BxLaXcJ2BbEOWEp5wd2A1ex2PCb3U/3WeCo6Mfl3QcxAVcRs4VRA
        YLBJGeuzx7HbafGefPEtD9Nz1XB6OMas1Y2+Sl/mlTfmnf1oLHB4rsVv2tfoc8l/X+u3CdLd
        fOi8vvSBqXfvzaNxH6pXHp7l/VZZ7Idueufef53xs6feIhPxp+Sb1uMqXv4HheIP2nYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7oGZb9iDOZs47HYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y+idcZqtYKNaxd9Xf9gbGO/LdTFyckgImEhc3riKrYuRi0NIYCmjxNbzRxkhEmISk/ZtZ4ew
        hSX+XOuCKvrEKHFp8xnmLkYODjYBPYkdqwpB4iICcxglfnZtYwRxmAXOMkvsXvGGCaRbWMBe
        4sm/nWBTWQRUJe43n2IDsXmB4i/nzmaG2CAvsXrDATCbU8BBYva2HWwgC4SAalY9d5jAyLeA
        kWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYBRuO/Zzyw7GrnfBhxgFOBiVeHhnMP2MEWJN
        LCuuzD3EKMHBrCTCW3bhR4wQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wMTRF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkazGOu9NYzKSs/ynIWvv9YSYb5+
        83VpZNqhxq1bRT///f656duTpuPrOBY3LTrKZqnPlbxi8Rqhsxxin9519286wX/mZvHP/zme
        0XKuXnJzzgU23ppjmqtTlNQ/Y1bb5DWl4czzcw/MaWB/c2Dr1vI1+UkiSxl22yWa5oTGm3lm
        975+eEPxUKgSS3FGoqEWc1FxIgDWIVCK2AIAAA==
X-CMS-MailID: 20190607143528eucas1p12875b8f2043264a452da2720195f629e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143528eucas1p12875b8f2043264a452da2720195f629e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143528eucas1p12875b8f2043264a452da2720195f629e
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143528eucas1p12875b8f2043264a452da2720195f629e@eucas1p1.samsung.com>
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

