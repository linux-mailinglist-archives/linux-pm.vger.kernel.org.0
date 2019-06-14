Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9806D4598E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfFNJx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54542 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfFNJx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095325euoutp025090308ba0064bb90b9063138cba1262~oB-G4u9o51770917709euoutp02B
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614095325euoutp025090308ba0064bb90b9063138cba1262~oB-G4u9o51770917709euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506005;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5oXs0NMXbPia1X622D15B3Sbm/7Glx6IZHVXW+YfLVLkvFYB2d5xz/ZFxz6thZe5
         vlUWj7uBTaMYx+G3bmSbfeJX0QZQQf/dPc0U5sxBp0PRfAXFQ/wML991lzJ5YWNB42
         KGEouznLPuW2Qlc8z0Cv92Br85c8LdytPOaPdKOY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095324eucas1p1f7d84cef4ed1eb552cc7605d04e2ec5b~oB-GLFomN1137311373eucas1p1g;
        Fri, 14 Jun 2019 09:53:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F8.A5.04298.49E630D5; Fri, 14
        Jun 2019 10:53:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095324eucas1p2eab4def0ed8c912303e4bb3e422bb255~oB-FW51-p0490704907eucas1p2D;
        Fri, 14 Jun 2019 09:53:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095323eusmtrp2d1fa02cedd6037af72e18c7d354f14d5~oB-FHJFo42148621486eusmtrp22;
        Fri, 14 Jun 2019 09:53:23 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-2e-5d036e940b6e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.DA.04140.39E630D5; Fri, 14
        Jun 2019 10:53:23 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095322eusmtip2ebafa8178e1fe43289df42fdb413484c~oB-EK05gt2269122691eusmtip21;
        Fri, 14 Jun 2019 09:53:22 +0000 (GMT)
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
Subject: [PATCH v10 04/13] dt-bindings: ddr: rename lpddr2 directory
Date:   Fri, 14 Jun 2019 11:53:00 +0200
Message-Id: <20190614095309.24100-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ2lA1gyFpQbRNGKBjSCxCU34IIGk1EfJNEXMUSLTKiRVuhY
        FVmsFjdWF0QCIhgjkLbIYtkUZbUlCAJKFGWRAEZkE6wQjQFlHIxv3/nPf7abS2HSPsKZOq46
        xapV8jAZaYuXmX+2rk9VYUEbZlLdUHF6IYHeff9MoOyGVwQyTA4ApHtQSKJbTVki1JygRCkD
        IxhqbS0So5aLo2L0QeuCJhN7CfTmyV0SWZMaAEpvfS5CBQ09YtTetBt1XcgnUf3oFQLNvi3G
        UXXHXtT1yx5NN/YDPydmeuomznztvCRmMrXtOFOZ0SNmSvTXSKY6yyhmknTjJFM7XiVikk16
        wDx+GcVYS5YH2AXabg1hw46fZtVe24/aKvS1eiw8TnLWmFeKacEzu3hgQ0F6E2zTpeHxwJaS
        0vkAVrQkkkLwHcCMWQMQAiuAxt5BcTyg/pYMJjvw1VI6D8C0VFeB5wqqRtx5C0l7wgp9BC87
        0ukAZg4d4NtgdDkGx7q6AZ9woP3hpwkTwTNOr4b95l84zxJ6B/xRasWF7VyhoagG49mG9oMv
        skf/LgfpJAo+7ZjBBJM/LLrwkRTYAQ5bTGKBXeDvymyRwBzUJt0HAkfDgZSseY8vrLe0E/zS
        GO0BC594CfJOONFRIxLOtYedY4t4GZvDm2V3MEGWwKuXpYLbHZoS2+YHLYF5xrT55gxsL+Yv
        5F/wFoDZHfdF14Frxv9hOQDogROr4ZShLOetYs94cnIlp1GFeh47qSwBc//u5azlWwWYeh1c
        B2gKyBZKanxEQVJCfpqLVNYBSGEyR8k9XyxIKgmRR55j1SePqDVhLFcHllK4zEkStaDvsJQO
        lZ9iT7BsOKv+lxVRNs5acLB47yFJ8A2PZZ47tpW34es2eRWsd7v2c+O0udoSG5Mbhc40L3aP
        634fuKa65FGsecOloz2kY4DPxaqh33HDVz7l9jfisw9l3yzvfuhiErie/MFVa3TmCOl5Rawm
        eo/BLyxGdtuwcmWLXOHqu2+zIi9hOjRzhXGL//4c+y+7mqc0B2U4p5B7r8XUnPwP36mN/XMD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qT85hjDe68VLfYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y1h1cBVzQQtvxZrlW5kbGPdydzFycEgImEg86RPuYuTiEBJYyiix6GYbexcjJ1BcTGLSvu1Q
        trDEn2tdbBBFnxglNl9tYAZpZhPQk9ixqhAkLiIwh1HiZ9c2RhCHWeAss8TuFW+YQLqFBVwk
        nn7YwgpiswioSjw69psFxOYVsJf4sfUzC8QGeYnVGw4wg9icAg4SR+e/YQNZIARU830G/wRG
        vgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3DbsZ9bdjB2vQs+xCjAwajEw3vAiilW
        iDWxrLgy9xCjBAezkgjvPGvmWCHelMTKqtSi/Pii0pzU4kOMpkA3TWSWEk3OB6aHvJJ4Q1ND
        cwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjNOlSjKXFPOraooeU07WVxCd
        upbzyOpTE234j8dNz/zpu0sr6zxTvJtkRJWJFeNlhojVtg6VDckc/aqWAh6bz2aGu1vUz/R/
        aJvcmzGx8fjmBZbZrec81WZEsm/2WuUw++bWjtSWDf6VqecW7j3ymOlm0B+zg8+C72dM+ch0
        t+iT0EQpIUtZJZbijERDLeai4kQATkrqt9cCAAA=
X-CMS-MailID: 20190614095324eucas1p2eab4def0ed8c912303e4bb3e422bb255
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095324eucas1p2eab4def0ed8c912303e4bb3e422bb255
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095324eucas1p2eab4def0ed8c912303e4bb3e422bb255
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095324eucas1p2eab4def0ed8c912303e4bb3e422bb255@eucas1p2.samsung.com>
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

