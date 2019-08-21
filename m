Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA24797772
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfHUKoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:44:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35673 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfHUKnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104321euoutp0266ffc59e0fbdbafc89bc57155a6f9b12~86iHP8Qx50294502945euoutp02a
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104321euoutp0266ffc59e0fbdbafc89bc57155a6f9b12~86iHP8Qx50294502945euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384201;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNKmox1N5UytW/PTTA1ZEZzT2V2yOzFq/U0BSumeGjczHamUQZovbKI3BwcmNZR1F
         piExUVYIYhE2zNqUIBTmNUrzYrfWzCTKH0I5Z8SJ5Deqqpo6zIZdxVRORzzm2ry34f
         Iuxy2lhwYNqx5pzVKkJP0NgQM3NFCPAQIWu2dr+8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821104320eucas1p1ed71e72e6e8ab4265f7d91cb2dd0cb4e~86iGPaL5F0727407274eucas1p1u;
        Wed, 21 Aug 2019 10:43:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.0C.04309.7402D5D5; Wed, 21
        Aug 2019 11:43:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821104319eucas1p10db51f7a181cae024465cc775292d2b1~86iFZ3PL41124011240eucas1p1V;
        Wed, 21 Aug 2019 10:43:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104319eusmtrp2c9ef838381444376c27fa59dbf91f273~86iFLr9sM2827428274eusmtrp26;
        Wed, 21 Aug 2019 10:43:19 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-3d-5d5d20474f9e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.38.04117.6402D5D5; Wed, 21
        Aug 2019 11:43:19 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104317eusmtip221f1e7e384a831f5024b51e5df9568a7~86iEEROLI1735217352eusmtip2q;
        Wed, 21 Aug 2019 10:43:17 +0000 (GMT)
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
Subject: [PATCH v13 2/8] dt-bindings: ddr: add LPDDR3 memories
Date:   Wed, 21 Aug 2019 12:42:57 +0200
Message-Id: <20190821104303.32079-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa1CMYRTHPfte22nNa4XjFtYwruU25nEZYlye8cGYCR80YfFOpXbLvoow
        ZlnXVSFNorJkyGybLppUE6V2RKXk1tII5bKzym3TjMFiexfffuec//n/zzzz8JT6EzOMj9Jv
        Fw16bYyGVdKlt781TV0+Ojx8mss5BxdlFDC4tecdgy32Jgbnfe5E2HSxgMWn6rMVuPGYDh/v
        fE/h5uZCDt/b38XhZ8YR+HNSO4MfVmSx2J1sRzij+aYC59ufc/hSa4sCt9QvxW37rrD44A07
        h2u7DjPY86SIxlWPVuC27/1x750OFDKU2M7ZEOn9mkqTj46DHMk0ttCk/OxzjhRbj7KkKtvG
        kWTTB5bc+lCpICklVkSuNewm7uLAVf7rlPO3iDFRCaIheMFGZWRyRgMbVzR+50/XD86IXgSa
        kR8PwiyorKllzUjJq4UrCF7fuuErehA4O9IouXAjSHd/RGbE96007tsm93MRnHQ70L+N7O63
        fSJWCIIy6zZvRICQgSDTGerVUMIrClLys5B3MFBYACntXxgv08I46LGk97FKWAiWtExavm8U
        5BVWU172E0LAc+Iu4zUC4QIPrxxtlHzREnj8YrWsHwiuuhJO5hHwq9yikFkCY/IFJPMe6Dye
        7dPMg9q6FsZrQwkToaAiWG4vgpL6HEZ27w+O7gHeNvUHU0tP+0JVcOSQWlZPgJKk+76gwZBr
        S/eZE8jx5Pue8BSCXkc1fQKNOvs/7DxCVjREjJd0EaI0Qy/uCJK0OileHxG0OVZXjP78wwZP
        XU8ZqvixqQYJPNL4q8qehoWrGW2ClKirQcBTmgDVzqx14WrVFm3iLtEQu8EQHyNKNWg4T2uG
        qHb3exmmFiK028VoUYwTDX+nCt5vmBEdDU2LTNy7VYDmkJxWTc65VXbF17wgDKlR0ctYK0o4
        9qZh6GzPmY6AkSbTgZFjnF2XmhpdsfujJn9f7CxNW7po9ZwplcHUmfa3l7vWF1omx4XN6J4b
        ekRZ3FhlWRhpJrZq84Hocv/xSabc6ysfEG3g3ZV3yKA19NqwqzNd7fqxRENLkdrpkyiDpP0N
        VCdrOYMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7ruCrGxBhu3MFlsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GX0zjjNVrBRreLvqz/sDYz35boYOTgkBEwkzjQWdjFycQgJLGWU
        WLntCmMXIydQXExi0r7t7BC2sMSfa11sEEWfGCW+ze1gA2lmE9CT2LEKrFlEYA6jxM+ubYwg
        DrPAb2aJg3f7wbqFBewk+u59YgWxWQRUJb7MnwZm8wrYS8yfMpsFYoO8xOoNB5hBbE4BB4l/
        E06C1QgB1Uzd8JZ1AiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIExuu3Yzy07GLve
        BR9iFOBgVOLh3XEzOlaINbGsuDL3EKMEB7OSCG/FnKhYId6UxMqq1KL8+KLSnNTiQ4ymQEdN
        ZJYSTc4Hpo+8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MOnNs
        S59YTOf80THJQfdoRlpCqOTqYIFjT79OzEy8sFzzwazHJ4oFs43KjcrXGe6/x+ThtaktwPXS
        HE6V2dsXa/J12UnW391lYjPL4MDCa/Mv3cqIi1/AsJKnpF3oxjG5ay55xfbxvzLq2mdOOpS3
        p4zr22czFcWDd5VEGTYnXu7MvLCvqPCWEktxRqKhFnNRcSIAFojHLucCAAA=
X-CMS-MailID: 20190821104319eucas1p10db51f7a181cae024465cc775292d2b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104319eucas1p10db51f7a181cae024465cc775292d2b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104319eucas1p10db51f7a181cae024465cc775292d2b1
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104319eucas1p10db51f7a181cae024465cc775292d2b1@eucas1p1.samsung.com>
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

