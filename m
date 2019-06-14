Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7236945996
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFNJyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:54:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54512 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfFNJx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095326euoutp02a7611d5bc9c38ccf33111af4105e658d~oB-H6CH_p1770917709euoutp02C
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614095326euoutp02a7611d5bc9c38ccf33111af4105e658d~oB-H6CH_p1770917709euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506006;
        bh=V2RxqnmrrTg838z/OUohhOWlIB6UFsk0++imMcaiW7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EISvg+X6sMh/bEZAtt4Y4SDAlnc34k69JJRC/R8ndtNjMwrlrPGBCuS/dI6tT8KYh
         CxmutZjQ62sY1wytcJpQg2WL4XGDq+BjDDx2Pf8nxlQm+EQBYvSbDOlqatsgump787
         M7AO27qDCviDTQbRrg7H1KByoMiXtXimyk4BczEg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095325eucas1p17a76899b483bd548c7881b38c4afc8e0~oB-G-yM291133311333eucas1p1c;
        Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E2.F1.04325.59E630D5; Fri, 14
        Jun 2019 10:53:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095324eucas1p247ee87a9ca69733e7aebd601f5d96a94~oB-GN28p-0495004950eucas1p2B;
        Fri, 14 Jun 2019 09:53:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095324eusmtrp2f9f81e2a4fdaff2ea3e577ef9611731e~oB-F9iMyp2148521485eusmtrp25;
        Fri, 14 Jun 2019 09:53:24 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-15-5d036e95a93a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.40.04146.49E630D5; Fri, 14
        Jun 2019 10:53:24 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095323eusmtip2313b2f8017cd1795998122da6d712ddf~oB-FDUi9V2320823208eusmtip2P;
        Fri, 14 Jun 2019 09:53:23 +0000 (GMT)
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
Subject: [PATCH v10 05/13] dt-bindings: ddr: add LPDDR3 memories
Date:   Fri, 14 Jun 2019 11:53:01 +0200
Message-Id: <20190614095309.24100-6-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/etObkty4Op0SJ7UPamQ0ZWJFz6ozcEldTKi4pu5q4zy/5Y
        2sOm66GkopmVhras6TQfEWWmLWa2RuEjNUsJw9eyWaGZ5fVO+u9zvt/v73x/HA6Dy7tJHyZS
        Hcdr1MpoBeVOVL4cta24rsZDV1375YPKsk0kahnpJVF+/RsS3R/uASi5wEShDGsehl6nqtCV
        nn4c2WylNGpKGqDRB50vGk77SKJ3j29QyGmoByjb9hRDD+o7aWS3hqD2s8UUejFwkUQTzWUE
        evZ+B2r/7Yl+vuoGW7y5nz/SCc7Rep7mcnV2gqvJ6aQ5s/ESxT3LK6E5Q/IQxT0feoJxlyuM
        gCtvTOScZv/dMw+6bwrjoyPjec3KzUfdIwzZjdSJsoCEP33jtA50+euBGwPZdfBRygipB+6M
        nC0GcKLQiUuHEQBNqfUuxwlg0q9hbHpkqOoVJRlFAFrHvk8ZUyOjjjV6wDAUGwirjbGi7MVm
        A5j7dZ+Yx9kqHA62dwDRmM1ugWODtbTIBLsIdtTqCZFlbDBsK7hMS2Xz4f3SWlxkt8l8Q/7A
        VDFkLzHQWtiES6Ht8FrzPULi2bDPUuEa9oV/a/JdWwtQZ7gNJD4De67kuTJB8IXFTopL4+xS
        aHq8UpK3Qv2XGkyUIesJWwdniTI+iemVWbgky2DKBbmUXgIr0t66iubCopJM1+UcHDaWYtJT
        ZQA4NubEroL5Of/LbgFgBN68VlCF88JaNX8yUFCqBK06PPB4jMoMJn9e44TlRzV4On6sDrAM
        UHjIajdioXJSGS+cUtUByOAKL9nNIDxULgtTnjrNa2KOaLTRvFAH5jGEwluWOOPTITkbrozj
        o3j+BK+ZdjHGzUcHmnV+bz6Zi9rKs86lKFru2tItmoY5pd/X3zmwa16ENWwk3iEE39zQUK7p
        VHvtX9A1mJaCbH29hvbdn8PTWxb7lHhcONx/1MFYvj00248YfTNVC7Eo73Htkz2xWiq5yiPE
        0bOtuu3weOzSgAT73spEedPO4haVf8wqv+WOssIhE6sghAjl6mW4RlD+A6z9UHJ1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7pT8phjDW6/VrHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y+idcZqtYKNaxd9Xf9gbGO/LdTFyckgImEi8236CrYuRi0NIYCmjxJ8T55ghEmISk/ZtZ4ew
        hSX+XOuCKvrEKPHxVR9LFyMHB5uAnsSOVYUgcRGBOYwSP7u2MYI4zAJnmSV2r3jDBNItLOAg
        8evtAbBJLAKqEncOdLGA2LwC9hI3F/dBbZCXWL3hANhmTqD6o/PfsIEsEAKq+T6DfwIj3wJG
        hlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBUbjt2M/NOxgvbQw+xCjAwajEw3vAiilWiDWx
        rLgy9xCjBAezkgjvPGvmWCHelMTKqtSi/Pii0pzU4kOMpkA3TWSWEk3OByaIvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjKlnHp0SytxbqtSh4ssdZKXyh0G2
        tKv9U7SM8pYnqxK/8u/7FvqmSUDrcVnTtvgL3/dJpzWI7uXhTxRqL5q3Vu5T/0GLrZ+3m2ny
        6fxb6PPqpOpWxuk5DEFJr55d0o9taX5dt0r78rbs1liuCwx7uCxer7rw9/bdt7eOrWNh+KuX
        xbGwnn9vshJLcUaioRZzUXEiAMZaAnHYAgAA
X-CMS-MailID: 20190614095324eucas1p247ee87a9ca69733e7aebd601f5d96a94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095324eucas1p247ee87a9ca69733e7aebd601f5d96a94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095324eucas1p247ee87a9ca69733e7aebd601f5d96a94
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095324eucas1p247ee87a9ca69733e7aebd601f5d96a94@eucas1p2.samsung.com>
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

