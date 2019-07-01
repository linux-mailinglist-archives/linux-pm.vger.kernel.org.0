Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601B15BC9D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfGANMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49166 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfGANLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131152euoutp02f2e283d15ab0db047ddebe3df186e8f9~tSqOxED8U1093010930euoutp02Z
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190701131152euoutp02f2e283d15ab0db047ddebe3df186e8f9~tSqOxED8U1093010930euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986712;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEuLrMZel4VvlnGrt1JLBwfa7krJJd342Pu/75rNH4DjwesTzqnNakpl20SDpPpE1
         rAYaNVdXZcjcYJj7iG70FLxBS/J0wxzuThr5y4K4J55ZzIV6XOKdtTYm5ViskeyHvd
         xEc+IcKz15S5rxmOr5zgBFDp4AgWwTfGptO2U7BE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701131151eucas1p28ed18a39d8065f8aab98dcd658375aea~tSqNsjqsJ1085710857eucas1p2G;
        Mon,  1 Jul 2019 13:11:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.77.04325.7960A1D5; Mon,  1
        Jul 2019 14:11:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131150eucas1p158e1d6065775d48edabfc360cbb882b1~tSqMsJyDm0999809998eucas1p1C;
        Mon,  1 Jul 2019 13:11:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131150eusmtrp22346077023e68efa883c3408dd6acddc~tSqMdxWhR0782307823eusmtrp2Y;
        Mon,  1 Jul 2019 13:11:50 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d1-5d1a069753ef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DE.DA.04140.6960A1D5; Mon,  1
        Jul 2019 14:11:50 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131149eusmtip14b432c187ab7cdb16bc5f22b19bb1418~tSqLhSnHk2637626376eusmtip1b;
        Mon,  1 Jul 2019 13:11:49 +0000 (GMT)
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
Subject: [PATCH v11 1/9] dt-bindings: ddr: rename lpddr2 directory
Date:   Mon,  1 Jul 2019 15:11:30 +0200
Message-Id: <20190701131138.22666-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0xNcRzvd889j66Ojhv6Spi72RTKa/Mzr5jHWWvLPGa0xqWzy+om9/RA
        ZjcpSsliSmopo9xqvW5P0pOolBSaykx5RCLXbUsW3e7Bf5/f5/H7fPbbjyGUfaQTcyQwWNAF
        qgNUlEJe+nC0dUkS5eS79KLJDhcm55P45Y8PJE5vaCVxznAfwpE38yl8uSlNhlsuaHFC32cC
        t7UV0PjJmUEav9I74+G41yTuqEylsCm+AeHktvsynNfQS+P2pi24OyKbwvWD50g8/qJQjqs7
        PXH32FQ88ugt8nDkR8yJcv5rVxTNX9e3y/mKlF6aLzLEUHx1Wi7Nx0cOUXzt0D0Zf9FoQHxx
        czhvKpq7fco+xVo/IeBIqKBzX39AcdhQayCCzrLHc7NKCD2qmhKLbBngVoL5fRQZixSMkstG
        UP/+FmU9/ECQaRySFBOC/pHHsr+R2yl3JSELQUlhp/xf5E7SOzoWMQzFuUG54ZglMJ1LRnD9
        406Lh+DKCPjS3YMsggO3CRoGByaxnFsAmT0Rkw0stwE6mh5Q1rZ5kFNQQ1iwLecBz8y9k/uA
        i2cg+kyLNGkzdEV3SAEH+NRopK3YGX5XpEseEfTxGciKT0FfQprkWQP1je2kZTTBuUB+pbuV
        3ghZEdeQhQZuKnR9mWahiQmYWJpEWGkWzkcrre6FYIx7KhXNhKzcq9LlPPRkjEovehlBTP+A
        7BKal/K/7AZCBuQohIhajSCuCBTC3ES1VgwJ1LgdOqotQhNfr3m80VyO7v86WIc4BqnsWH0P
        +CpJdah4QluHgCFU09nq7Fm+StZPfeKkoDu6XxcSIIh1aDYjVzmy4TZvfJScRh0s+AtCkKD7
        q8oYWyc9UhQrnFIDzDHerl6h4zXmtEe7ORefbwl7qnzveJvKF/sYNAmG8zVzSuy9y0572fuv
        jvhQ4dm/a757qjebtzq4q1i3TQi6sKjt5ydjnCwqbK+yMHQj0vgl7nq5aUaMyWt0h50s7Ar7
        3CZxzLnz+fJBel21zXciaeXWxQWlLrGrRqtWqeTiYfUyV0Inqv8AhDEx1XYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rT2KRiDVpvsFlsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        Zaw6uIq5oIW3Ys3yrcwNjHu5uxg5OSQETCSWzdrN2sXIxSEksJRR4vzh7YwQCTGJSfu2s0PY
        whJ/rnWxQRR9YpR49302UIKDg01AT2LHqkKQuIjAHEaJn13bGEEcZoGzzBK7V7xhAukWFnCS
        OPLmJdhUFgFViUV3GsHivAL2EpdPHWWD2CAvsXrDAWYQm1PAQeLS17tgcSGgmnWLbzBOYORb
        wMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAOtx37uWUHY9e74EOMAhyMSjy8GrckYoVY
        E8uKK3MPMUpwMCuJ8O5fIRkrxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnAFJFXEm9oamhu
        YWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFxSmBForxVYdgi8edfoyczzlkp
        lGMtn7T0zplnGa+9lmavaD8uu9tJafexRyWfltTLKPZPEoz6ItykqBBi/E/RKeDHoWmhylXT
        whZuuMFs9Cvyd57D8bqT93YevBChznDosoXkouuTJ1nv2D3T9jXXo0XWp2YkyiUq//+0/HE/
        w4Wgd+HnbrPVKLEUZyQaajEXFScCAPeoG9rZAgAA
X-CMS-MailID: 20190701131150eucas1p158e1d6065775d48edabfc360cbb882b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131150eucas1p158e1d6065775d48edabfc360cbb882b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131150eucas1p158e1d6065775d48edabfc360cbb882b1
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131150eucas1p158e1d6065775d48edabfc360cbb882b1@eucas1p1.samsung.com>
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

