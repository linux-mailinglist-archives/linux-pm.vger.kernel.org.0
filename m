Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36BD361BE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfFEQyn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32972 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfFEQym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165441euoutp01a4b589ec1981c93ddb8cfb441deed084~lW7WKGg2M0154201542euoutp01H
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165441euoutp01a4b589ec1981c93ddb8cfb441deed084~lW7WKGg2M0154201542euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753681;
        bh=XPlbzfyPq+2tb60F1xt6+L5cVtwUM4v/x4YUlMpHRb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgNCbn4MtujoNeAP6v6YhmZ392SdCF7TCdYzP39PMJKFkf1tYyE1k9bCfqeDxBG2K
         K9uhzQWIpIpJzW1vVgA7t6k+qIWRnT4UnyiEwsJWC1U5wI7Zk0s+qYbi0D2dN0eZjq
         Vb29SBNaqAo3HKh9kktIivtCk1koD6ItvISnEMsw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165440eucas1p2dc680f0292d31b6044082da5c7c2c5d3~lW7VWA5c60086300863eucas1p2d;
        Wed,  5 Jun 2019 16:54:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.08.04325.FC3F7FC5; Wed,  5
        Jun 2019 17:54:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165439eucas1p12d9b7aa025fd826d4f880fd7862add62~lW7UWqtue0350103501eucas1p1c;
        Wed,  5 Jun 2019 16:54:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165439eusmtrp22b4e90ee41e5428c6a5a40136bae476e~lW7UHGUq62868028680eusmtrp2g;
        Wed,  5 Jun 2019 16:54:39 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-41-5cf7f3cfe005
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.B2.04146.EC3F7FC5; Wed,  5
        Jun 2019 17:54:38 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165437eusmtip110e1e11cd04daf0a9f7b485d60650367~lW7S38EBW0391203912eusmtip1D;
        Wed,  5 Jun 2019 16:54:37 +0000 (GMT)
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
Subject: [PATCH v8 11/13] ARM: dts: exynos: add syscon to clock compatible
Date:   Wed,  5 Jun 2019 18:54:08 +0200
Message-Id: <20190605165410.14606-12-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2zlnO5MWxyn2Zl5gEF0oLUr6IomE0NMFCiS6aJeVB5Wc1k5a
        ZsGytLVcppaKteyiaNPSqXkrpk1tYbVlGou8FPmjqKWJl0rDch6tf8/7XN7n5eOjCXkb5U3H
        xh/n1PHKOIXYjax9+su2wj78I3KluTYYm/IrKOwY+UThwlYbhcuG+hHOaTeI8ItLKpzZ/5XA
        dnulBL9MdUrwO40P7my8IcbD+laE8+1mEb7f2ivB3WdLxbjFeYHCTV1bcPfEPDz27CPa6MGO
        jWaT7HVNB8k2FPRK2CrjRTGrPzcgZp8MPBaxl2uMiK1+nsIOV/ntkO51C47i4mKTOHXghoNu
        MYN2B3XUJj2pz7xJalAarUNSGpg1UPdAR+qQGy1nShH8fHedEIYRBLXWq0gYhhFkGkqp2Uif
        5dGMUILAaM4W/Yt0FZmmltG0mAmAeuMxV8CTSYEeR9P0WoJxiuDl+E/SJXgwW8BsLpveSjKL
        4GHeNeTCMmYjlLQUi4U2fyirbCZcWDrF51qrp48Fpk8C3+/dRYJpE/QUOwgBe8AXa41EwD7w
        p6FQJGAeNPrbM/7T0J9pmPGshxZrB+U6mmCWQkVjoECHwGutTuSigZkHb7+5u2hiCmbX5hEC
        LQNtulxwL4GajFczRV5QUp4rESwsfHq/S3idHAR6QyW6gvwL/nfdQsiI5nOJvCqa41fHcycC
        eKWKT4yPDjicoKpCU5/r+aR1tB6Zfx+yIIZGirkyMP2IlFPKJD5ZZUFAEwpPmbJ7JFIui1Im
        n+LUCQfUiXEcb0ELaVIxX5Yy50OEnIlWHueOcNxRTj2rimiptwZtW1imcU/faSzoLPbaHRb2
        uXdwKHD7mX1pkxNbow+tc2xe3rKqV7tuT5ZiwvbQfAeiqOY3Xj3JodV7cXvEs9ta34wiRyhT
        n9WeUOTFtQWFaGNxidr0Pty5dnHhVoPO9nRZ6uqIcNP5VD/3yfXNQSrneLn9hm+cpS1LvP+t
        8VbdAgXJxyhXLSPUvPIvYs7hFVgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7rnPn+PMTj3y9xi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jPfnr7MWnOOs6O2fx9LA2MrRxcjJISFgInHv0G7G
        LkYuDiGBpYwSz6dtZYFIiElM2redHcIWlvhzrYsNougTo8SFp8eAOjg42AT0JHasKgSpERGo
        l+h/cwmshlmggVlizfarrCAJYQEviX37VoPZLAKqElunT2UEsXkFHCSWH17KBrFAXmL1hgPM
        IDYnUHza8c1gRwgJ2Etcuv6beQIj3wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbTt
        2M/NOxgvbQw+xCjAwajEwyux8XuMEGtiWXFl7iFGCQ5mJRHexNtfYoR4UxIrq1KL8uOLSnNS
        iw8xmgIdNZFZSjQ5HxjneSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4
        OKUaGNO+meVpH+J/kliQrbT4xqdQ9cRjfGzyG0oerPj+cPLhudWtFyYcla+7+aApVKTiZby7
        JKfx/czzee+Evk6db1b5PeFOVVGP4B2hyyLqD36/bi08uby+LXVvqM6hkrOWGvEz10fJ7LNc
        KtivzZ/2a2vEfAsOscqZ6W61Hw7wpAX+vXFL39p0uRJLcUaioRZzUXEiAA69dgW7AgAA
X-CMS-MailID: 20190605165439eucas1p12d9b7aa025fd826d4f880fd7862add62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165439eucas1p12d9b7aa025fd826d4f880fd7862add62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165439eucas1p12d9b7aa025fd826d4f880fd7862add62
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165439eucas1p12d9b7aa025fd826d4f880fd7862add62@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get the clock by phandle and use it with regmap it needs to be
compatible with syscon. The DMC driver uses two registers from clock
register set and needs the regmap of them.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5fb2326875dc..d153617ff1a3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -173,7 +173,7 @@
 		};
 
 		clock: clock-controller@10010000 {
-			compatible = "samsung,exynos5420-clock";
+			compatible = "samsung,exynos5420-clock", "syscon";
 			reg = <0x10010000 0x30000>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b319fd65..0a2b3287ed92 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,7 +17,7 @@
 };
 
 &clock {
-	compatible = "samsung,exynos5800-clock";
+	compatible = "samsung,exynos5800-clock", "syscon";
 };
 
 &cluster_a15_opp_table {
-- 
2.17.1

