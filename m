Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32FB38D54
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfFGOg4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50147 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfFGOfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143530euoutp0111c756d6a0d78aa87ac34e81421d09bd~l8UZHieY30114101141euoutp01y
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143530euoutp0111c756d6a0d78aa87ac34e81421d09bd~l8UZHieY30114101141euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918130;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI6SrE5wuTWqwQ5XNP+XhICRKecmaoFg+CyAwjBTJ7M9AisufxtHLtfQ3E/1u33SW
         FMio5cEKcdFRdt5l+OkPdENFtSxC+uR6JXD+D6x9MNNJ6+f6leXivU5S28JC5GjCyw
         /YthoYEwTAnWYCVtrnPreeowQMrjCwU+3gjhu7PY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143529eucas1p1a4fb2c852eb836319cf4e1cf6ff75581~l8UYRLoXJ1208812088eucas1p1S;
        Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.D0.04325.0367AFC5; Fri,  7
        Jun 2019 15:35:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143527eucas1p2afb1f2b11a16d61ad802f1a0c53cf880~l8UWvQpet2700727007eucas1p2Q;
        Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143527eusmtrp25ceccf865a8aadbb3500ee326ad6d8a7~l8UWfg5yT1494514945eusmtrp28;
        Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-93-5cfa7630b141
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.56.04146.F267AFC5; Fri,  7
        Jun 2019 15:35:27 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143526eusmtip107934ec825ea4ee3988d607168e02cab~l8UVnfoh02927929279eusmtip1x;
        Fri,  7 Jun 2019 14:35:26 +0000 (GMT)
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
Subject: [PATCH v9 04/13] dt-bindings: ddr: rename lpddr2 directory
Date:   Fri,  7 Jun 2019 16:34:58 +0200
Message-Id: <20190607143507.30286-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUwTURSFfZ3OQml1rESeuNeYiIngGp8LKlHiBDVq+GGiTbTIiEQK2KG4
        JxXBBUFMUZYCshigFhQERKDIUlAMIJUgYkAUxH1FqUSxAVum6L/v3XPuPTc3j8KkfbgbFRQS
        zqpCFMEyQiQse/C7ddHiiGH54sz2Feh2ciGOOi3vcJTR0Iqj/O/9AJ25XkighKZ0AWq5qETx
        /Z8wZDYXkehR5GcSdWlmoO+xL3DUXplGoMG4BoCSzdUCdLOhh0RtTT6o+7SeQPWfz+Fo5Olt
        Iap54ou6/0xEQw9fgQ2uzNBPrZD59iyaZFI1bUKmQtdDMsWGCwRTk15AMnFnvhJM3dcqAXOp
        1ACYkuYTzGDxrB3Ou0VrA9jgoAhW5blun+igoc6AhUVJjhbk3cE04J5zDHCiIL0cWrPNmJ2l
        tB5AbYJXDBDZ2AJgaskgwT8GbULGKDHe8S3vmpAX8gBs7agV/GuJ76qyKRRF0B6w3HDY3uBC
        J9tGvfezezD6Lga/dD8HdmEKvRF237GOZQvp+bBaX0/aWUKvh6/TbmB82myYX1Q7xk70Bpha
        Vj62EqTjKFiYUkTypk3wldmK8zwFfmwsddRnwNGKDAHPHNTEZQGeT8L++HSHZw2sb2zD7Utj
        tDssrPS0I6S94VXdTB4nwmdfJtvNmA21ZUkYX5bA82el/IwFsDT2sSNnKswrSHTMZqBJ9wbn
        r5MAoFH7g7wMZuv+Z2UCYACurJpTBrLcshD2iAenUHLqkECP/aHKYmD7eM0jjT/LQbXV3wRo
        CsjEEob8LZfiigjumNIEIIXJXCQRj3/JpZIAxbHjrCp0r0odzHImMJ0SylwlJyb07pHSgYpw
        9hDLhrGqcVVAOblpgNh5X8zKpCwytzlHHZY+yUIahxpeejNz05LeWgQefmL56Y5W5Uxuc2/W
        rep3PuL7iT9W50fNq8w81dRVFdB543yfentLrl7jf+XDNt8cnQ84EN6ya8m0aONA6ipj81Zv
        r6hhZO2ds2VYE7V0UW3kSLa6ZoBpO+Iui2xJ2an1ikmQCbmDiiULMRWn+AstgYsFdAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7r6Zb9iDJpu8FtsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        Zaw6uIq5oIW3Ys3yrcwNjHu5uxg5OSQETCTeL5/H0sXIxSEksJRRYt7H6+wQCTGJSfu2Q9nC
        En+udbFBFH1ilHj17BRQgoODTUBPYseqQpC4iMAcRomfXdsYQRxmgbPMErtXvGEC6RYWcJa4
        vfUPM4jNIqAqsW/FYbCpvAL2Ek/mrGSG2CAvsXrDATCbU8BBYva2HWwgC4SAalY9d5jAyLeA
        kWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYBRuO/Zz8w7GSxuDDzEKcDAq8fA6MPyMEWJN
        LCuuzD3EKMHBrCTCW3bhR4wQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wMTRF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkYj9hxxL5EcNY752UYhj4KeOLWu
        bW85teg1s8b9yZNyGR9/nPqt+K5Cclz66/nmVcf+pbrtuOcbtkZT69jFFgbm2FlFOQaZcQ9m
        hx4J2fLtv+Se9Cxt9aNfF0t/n//ln5SSNL+qr7hcwQQ2pZTHDSu+MCSH8Ezd8eu2Vm7b22Xc
        4cf6L/J+8VdiKc5INNRiLipOBABnr0R92AIAAA==
X-CMS-MailID: 20190607143527eucas1p2afb1f2b11a16d61ad802f1a0c53cf880
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143527eucas1p2afb1f2b11a16d61ad802f1a0c53cf880
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143527eucas1p2afb1f2b11a16d61ad802f1a0c53cf880
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143527eucas1p2afb1f2b11a16d61ad802f1a0c53cf880@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change directory name to be ready for new types of memories.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt      | 0
 Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)

diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
similarity index 100%
rename from Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
rename to Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt b/Documentation/devicetree/bindings/ddr/lpddr2.txt
similarity index 96%
rename from Documentation/devicetree/bindings/lpddr2/lpddr2.txt
rename to Documentation/devicetree/bindings/ddr/lpddr2.txt
index 58354a075e13..ddd40121e6f6 100644
--- a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
+++ b/Documentation/devicetree/bindings/ddr/lpddr2.txt
@@ -36,7 +36,7 @@ Child nodes:
   "lpddr2-timings" provides AC timing parameters of the device for
   a given speed-bin. The user may provide the timings for as many
   speed-bins as is required. Please see Documentation/devicetree/
-  bindings/lpddr2/lpddr2-timings.txt for more information on "lpddr2-timings"
+  bindings/ddr/lpddr2-timings.txt for more information on "lpddr2-timings"
 
 Example:
 
-- 
2.17.1

