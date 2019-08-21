Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC49776D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfHUKn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35655 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfHUKnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104320euoutp02f1a0e19178e284eeb9c876bd11956f8a~86iGFWCGw0225802258euoutp02f
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104320euoutp02f1a0e19178e284eeb9c876bd11956f8a~86iGFWCGw0225802258euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384200;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXbjAUdlL/dg8Yw2RjjZ2haB2aliZvxnCSxmgTG+zjqOSFcA1UCJZqlpWbj479OM6
         T1jbNJTW8ZW/OaCkJ9UtJxJs0WKM+XT28OYB5KHlhl4mUBYWljJ9cDc6aI2ilIBnhF
         //IKYS1j6p0+jMujRMabOwoGl5ti10l3sNcvyYis=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821104319eucas1p22915aa532a3cde552f31d52ce60d05ed~86iFJrNsd0983609836eucas1p25;
        Wed, 21 Aug 2019 10:43:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0A.48.04469.6402D5D5; Wed, 21
        Aug 2019 11:43:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821104318eucas1p1065a4a9d8366095e4d758519f88e8aba~86iESgvTP1320113201eucas1p1r;
        Wed, 21 Aug 2019 10:43:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104317eusmtrp23097d2e210a06edb66307cacf4d23123~86iEEEfUE2827428274eusmtrp23;
        Wed, 21 Aug 2019 10:43:17 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-23-5d5d20466d48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.38.04117.5402D5D5; Wed, 21
        Aug 2019 11:43:17 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104316eusmtip2ef5a25d421588eff26411d58636276ab~86iDAzoLZ1276412764eusmtip2b;
        Wed, 21 Aug 2019 10:43:16 +0000 (GMT)
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
Subject: [PATCH v13 1/8] dt-bindings: ddr: rename lpddr2 directory
Date:   Wed, 21 Aug 2019 12:42:56 +0200
Message-Id: <20190821104303.32079-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1zbQz02pxbIk+V7BR4xIRl+AzrhgwI4mJiT9ErTrqCERatWNd
        wMQqVgRbN4w2SkVjoFCrLYgNEjdKtUhRLBhcwaUmbnXBAhE1KGWq/p17lntuXh6Fy9vFw6gM
        zVZOq2EzlYRU5LrT3Th5UaxKFf88bzoqNzvE6FHHWzEq8twXowvtAYByzjsIVFBvwVDDQTU6
        HPiIo8ZGJ4nu7Q2S6Kl+BGo3tolRc3UhgUImD0DmxhsYuuhpJVHxIz+G/PXJ6NmeUgIZrntI
        VBvMFaOelnIRuvkwBT37GYW66l6DBUMZ+xk7YLo6j4mYL48NJHNa7xcxV0+1kkyFLY9gblrs
        JGPK+UwwNZ+vYcyhShtgLvuymVDFqKUDlkvnrOcyM7Zx2inz1kjTbTU2fPM+2Q679QquB9f7
        5wMJBekZsLnzuDgfSCk5XQpgW1kNIQwdAPpMHbgwhAD8afLifyO1HxtIQbAC6N3zhPwXaX5z
        oHcZRRF0HKyybQkHomkzgKffLQt7cPoVDg9dLARhQUEvhKZqIxbGInosrAu2gHBWRs+H5luz
        hLIYeMF5q69YQi+APUfu9t0K6WIKmozvCMGUBAteNGECVsAP3kpSwCPg76tFEZ6HetM5IOBd
        MHDYEvHMhrVef9/NOD0BOqqnCHQibN3n66MhHQUffxoUpvFeeMx1EhdoGTywXy64x8NK44NI
        0WBotZ+ILGfg/Wo7JrxOAYAlZVewIyDm1P+yswDYwBBOx6vTOH6qhtsex7NqXqdJi1u3SV0B
        ej+ir8f7rQp0Nq11A5oCygGyqicrVHIxu43fqXYDSOHKaNmOwuUquWw9uzOL025ardVlcrwb
        DKdEyiGy7H4vV8jpNHYrt5HjNnPavypGSYbpgW1LwY/dA3XWhIQ1TV20vDshN5CVP6bfW1Vq
        5/D545wvko4aN9zOTsQc3mTfzFCyJJj1KbHMpThomJ2TweaWt4UaVo3URqW/sqZs/K5Dl8aa
        Fz/clUd9dTNuLHba2vclR7+MnlS85Lfa4LSsTEk1uBRz47tbfmlcoxZJ+8dH82+UIj6dnToR
        1/LsH7p9s/yEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7quCrGxBltWmFtsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GWsOriKuaCFt2LN8q3MDYx7ubsYOTkkBEwkDr8+w97FyMUhJLCU
        UeJjxyQ2iISYxKR929khbGGJP9e62CCKPjFKbNnQz9zFyMHBJqAnsWNVIUhcRGAOo8TPrm2M
        IA6zwG9miYN3+8G6hQWcJHp39TCB2CwCqhIn3lxjBGnmFbCXmHHAEmKBvMTqDQeYQWxOAQeJ
        fxNOsoLYQkAlUze8ZZ3AyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIxuO/Zzyw7G
        rnfBhxgFOBiVeHh33IyOFWJNLCuuzD3EKMHBrCTCWzEnKlaINyWxsiq1KD++qDQntfgQoynQ
        TROZpUST84HpI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6NY
        nPV66cIHcVsXBv5pUDANKHqqweh9fce1zH8CZituGwX/danSm7T5Bo/HEm7JaN2Xj1680uRr
        /X47JuRtvgXTpgeflq/f6tq2tcZr59urexgY/whbH5giZ3tsiQ5b+u7b3svq+jmf+S5V39t4
        mE/vIG/7/4Om38R+NhxewCv+8tCiRXvifeWVWIozEg21mIuKEwHtua9Z5wIAAA==
X-CMS-MailID: 20190821104318eucas1p1065a4a9d8366095e4d758519f88e8aba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104318eucas1p1065a4a9d8366095e4d758519f88e8aba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104318eucas1p1065a4a9d8366095e4d758519f88e8aba
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104318eucas1p1065a4a9d8366095e4d758519f88e8aba@eucas1p1.samsung.com>
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

