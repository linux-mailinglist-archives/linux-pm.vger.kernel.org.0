Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704C0361D7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfFEQzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:55:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51467 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfFEQye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165433euoutp020d6351e94ea30216072fd4f3e927a3c1~lW7Ou-i9x2954929549euoutp02c
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190605165433euoutp020d6351e94ea30216072fd4f3e927a3c1~lW7Ou-i9x2954929549euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753673;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Agd9Rgoyp7PhAUMM2NnZbaWXrtJRI+ujr5jnWCYqjcKcxVUe8PLIYJ8DyeIsfQCTo
         uUxLjB/0u+COlrlsQArPR/vN54uDzsJkj3eg1QvPbvjJXIxjlROIlL4YEzAeJUpTdd
         Z7VRMWCs+AncCjcA4x1bzdU4rHaqDEtzN4q1mERo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165432eucas1p22eed6861909024cee46b75919b07caa4~lW7N5MA4q0620806208eucas1p2A;
        Wed,  5 Jun 2019 16:54:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.A9.04298.7C3F7FC5; Wed,  5
        Jun 2019 17:54:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165431eucas1p12810093a1f81f5609782959d878782a0~lW7M-mV2X3163931639eucas1p16;
        Wed,  5 Jun 2019 16:54:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165431eusmtrp26a9e99a17881a2e62807d8e1a3b3b135~lW7MwDAK82868028680eusmtrp2P;
        Wed,  5 Jun 2019 16:54:31 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-0a-5cf7f3c70d9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 25.B2.04146.7C3F7FC5; Wed,  5
        Jun 2019 17:54:31 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165430eusmtip10a8c9bf792dd1a59d08245770ff49efe~lW7L0uU1M0165501655eusmtip12;
        Wed,  5 Jun 2019 16:54:30 +0000 (GMT)
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
Subject: [PATCH v8 05/13] dt-bindings: ddr: add LPDDR3 memories
Date:   Wed,  5 Jun 2019 18:54:02 +0200
Message-Id: <20190605165410.14606-6-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe3d2OS4nx2n5ZKIxuik0K4xeSsqoD6ciEsQPpVCrjhdyXnbS
        UgumieZlaQbey/qiMi2dSqik5jQV5yWzMFIzmqXYFHXeSq2cZ9K3//N7nuf/f3h5SUKqFziT
        oeG3GFW4IkwmFPNftf/qPdBpXgo8WFePsC6vUoAH58cFuLitV4DLZ40IP+56wsPd6UqcafxJ
        4L6+KhHuSTSJ8Ge1Cx5oKBJis6YN4by+Jh5+0TYiwkMJZULcakoR4OYP5/DQih1e7PyGfBzo
        xYVsPl2o7ufT9QUjIrpamyqkNfenhXTL9Gse/bBWi+gaQzxtrnb1tbks9r7BhIXGMCrPE1fF
        IZo8gzBSt/fO2uSqSI1GXdOQDQmUFzwfHyDSkJiUUmUInhoKhFwxjyA9O5nPFWYEiWUFos2V
        l6kVPIuWUqUIymdjOL2+UZN8OA2RpJCSQ502yoIdqXgYHmzeSCAoEw96fi/zLQ0H6iRMmRI2
        fPjUHhgytBEWLVnnuRP5iMtyg/KqNxvchvKBnI6ajYOA+iIC3YqGZwkD6gwYG0O5eQeY7Ki1
        3ukCf+uLeZxmQa15bvW8C8bMJ9aZ49Da0S+w2BCUO1Q2eHL4FPSn9Ao4dzv4NGVvwcS6zH6V
        S3BYAg+Spdz0fqjNeGcN2g6lFTlWcxrGBkcJ7nEeI3g2eD0LuRX8z3qGkBY5MdGsMphhD4Uz
        t+WsQslGhwfLr0coq9H6zzL86ZirQwvvr+kRRSKZrQR0S4FSgSKGjVXqEZCEzFGiGJoPlEpu
        KGLjGFXEFVV0GMPq0U6SL3OSxG/5GiClghW3mJsME8moNrs80sZZjbbEBTnVXPAbmchfPi8K
        tn+0eFZaslCkvXQEtZeeHpbPBflf1B0zF78NsZur2hYRhbeVGnyN/fK9Jd8/m8RJti0xZvBo
        Oroa79vIHszyb1jrGvXrTmryytB/DcgZwBG7vffFNm91XShU5+0Y88ohZXim72M1XHSfMdrf
        M/3Y5SvjsyGKQx6EilX8A5homk9VAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7rHP3+PMZjazWyxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRu+M02wFG9Uq/r76w97AeF+ui5GTQ0LARGJd5xqm
        LkYuDiGBpYwSZ292skAkxCQm7dvODmELS/y51sUGUfSJUWLeigVARRwcbAJ6EjtWFYLUiAjU
        S/S/uQRWwyzQwCyxZvtVVpCEsIC9xNs3jUwgNouAqsTt00eYQWxeoPj0FzMZIRbIS6zecAAs
        zingIDHt+GawI4SAai5d/808gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBY2nbs
        5+YdjJc2Bh9iFOBgVOLhldj4PUaINbGsuDL3EKMEB7OSCG/i7S8xQrwpiZVVqUX58UWlOanF
        hxhNgY6ayCwlmpwPjPO8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2M/ueuh1TVX95TV3hm+XbOQsbKv0usdwaY8n1bO0/CwO7Ecbd3/9brxp+20KqaezpvVslL
        /wWxLy3Xvdxy1jymTX/blrs18XPK9L121+3XdBQ5m9Oe6ZJw5uz0fdoyxjeFOAR+piw2DDe5
        /jnomVjji/+BZ0p8T/FGMV+9lzhHM/jw/d16dz5+VWIpzkg01GIuKk4EAA9FfTG7AgAA
X-CMS-MailID: 20190605165431eucas1p12810093a1f81f5609782959d878782a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165431eucas1p12810093a1f81f5609782959d878782a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165431eucas1p12810093a1f81f5609782959d878782a0
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165431eucas1p12810093a1f81f5609782959d878782a0@eucas1p1.samsung.com>
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

