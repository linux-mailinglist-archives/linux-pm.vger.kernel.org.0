Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2698F6FCC2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfGVJsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:48:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42173 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfGVJra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094728euoutp02168a8a22f6b89ae6284252f4e74dbb07~zsawbVVsF2893128931euoutp02M
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094728euoutp02168a8a22f6b89ae6284252f4e74dbb07~zsawbVVsF2893128931euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788848;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+peawCAFI4wHk/nLOHZKWP8uzawCQ84OZoEQ6DQYKhc6RqQew7ZBllNaLH/+r3IK
         dihoeoXGwVCS76lCWqM8rW8tF8bq3a+JPLKoHLN2ouEsHMA0ror2aK/b3axojPrJT2
         X0zPdRe8QkXvflPtZzDdpSalJfn7i8dGRkGV4mnE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722094727eucas1p172b6e41a8083ef30b6f7c441a6ef108f~zsavNzyNg1118511185eucas1p1Y;
        Mon, 22 Jul 2019 09:47:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.40.04325.E26853D5; Mon, 22
        Jul 2019 10:47:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094726eucas1p2471055ae10f65df44fa1e640491e528f~zsaudkWwg2048020480eucas1p2O;
        Mon, 22 Jul 2019 09:47:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722094725eusmtrp1a6b6cb132700f8cacbe9c65c70984405~zsauE4qP63266032660eusmtrp1r;
        Mon, 22 Jul 2019 09:47:25 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-fa-5d35862ee99c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.2A.04140.D26853D5; Mon, 22
        Jul 2019 10:47:25 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094724eusmtip2a5eef1354f5f1e50bb1451a3d2fa137f~zsatFmKOI1004610046eusmtip2U;
        Mon, 22 Jul 2019 09:47:24 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 2/9] dt-bindings: ddr: add LPDDR3 memories
Date:   Mon, 22 Jul 2019 11:46:39 +0200
Message-Id: <20190722094646.13342-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzHfe/5Wet4XNQnwlzYMVLJ9h1WDNszW83or9I4PCvTHe6pJDYX
        q0inaOMmpbTUrkvKqTSKarIuXTeNdPIrltKPURpTpqcn/Pf6vj/v9/uzffZlCdUItYA9pI8X
        DHptnJp2J6uf/HSs8U9bHx2Q0hGIK80VFH451kfhG83tFC772ovw2aIKGue05ilw2wUdzur9
        QmCH4w6Dn50ZZHC30Rd/zXxD4ed112k8ampG2OyoV+Dy5h4GF790KrCzdTt2pZTSOPVhM4Ob
        BtMp/PtFJYkbOndg16/ZePzpB7TZh7fmWxE//v0yyY90pTJ8rtFJ8vev9TB8leU8zTfkWRne
        dHaY5h8PP1DwF20WxN+1n+RHqxbv9Ih033RQiDuUKBjWhuxzjzWZ7fTRyhVJkwMTjBG9XZyB
        3FjggqGzrp+WWMWVInjV4ZeB3Kd4DEF7SgmSH6MIfrW7qL+Jbz+zFfKgBEH9j27yX+RRV+tU
        hGVpzh9qLcekwDzOjCD3827JQ3DvCbhYfh1JA08uBMqemKd3k9xySH+Yzkis5ELBOnGJlLct
        gbI7jwip043bDP0tOqkHuEIWPrmKKUkHbhtkN4bKdk8YaLExMvuCPSdzpkYEo6kQyXwKerPy
        ZjwboanFOV1DcCuhom6tLG8Bl22clNtnQ9fQXEkmpvBy9VVClpVwLk0luzVgy+xQyOwFJdYr
        M+U8PG/LoOXj5CBoKh+jstGSa/+XFSBkQd5CgqiLEcR1euG4v6jViQn6GP8DR3RVaOob2n+3
        fK9F9RP7GxHHIrWHMqA6OFpFaRPFE7pGBCyhnqfUB6yPVikPak8kC4Yjew0JcYLYiBaypNpb
        eXLWuygVF6ONFw4LwlHB8HeqYN0WGNEGTZtT3FOwetAa6905XJMdUBjZWxzuczt8u6Nrcnnp
        R6+thkuaqiSN7675mtOeYetSJ7NC88PYhLIIYVFl7bZEi/CM8SmZsObes6b5Zby2B5lsDRWR
        SR5FgX3LYuNrLN+KUFHPrX0paRFzkoGKGr06HEXMXarVjRRcCBq6qQxUk2KsNnAVYRC1fwBS
        Wun+ggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7q6baaxBrun6FtsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GX0zjjNVrBRreLvqz/sDYz35boYOTkkBEwkPv2cwARiCwksZZS4
        MC0SIi4mMWnfdnYIW1jiz7Uuti5GLqCaT4wSr460MHcxcnCwCehJ7FhVCBIXEZjDKPGzaxsj
        iMMs8JtZ4uDdfrBuYQE7idXHZrCB2CwCqhLte9vB4rwC9hJr/kxkgdggL7F6wwGwoZwCDhIv
        j+dCHGQvsf/FdsYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbotmM/t+xg7HoX
        fIhRgINRiYf3xmaTWCHWxLLiytxDjBIczEoivHkGprFCvCmJlVWpRfnxRaU5qcWHGE2BbprI
        LCWanA9MHnkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjDHLt1
        1yzoZKnk/i2mw6/wYOGxcy9LFLlzlm7beEKrJCMyMHuBsttTn+onFy4c7NrcWr95y7mKdw0H
        pt5+qpKsM3PJtfey9x9dlexW2vC/44ePZcHD9X2CzOfYFubx7ONgz10dI5Qp67x1YYzHvI0Z
        Jmm79v58Kua/wPjXNH4tmweSRxZI7FJSYinOSDTUYi4qTgQA95o6vuYCAAA=
X-CMS-MailID: 20190722094726eucas1p2471055ae10f65df44fa1e640491e528f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094726eucas1p2471055ae10f65df44fa1e640491e528f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094726eucas1p2471055ae10f65df44fa1e640491e528f
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094726eucas1p2471055ae10f65df44fa1e640491e528f@eucas1p2.samsung.com>
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

