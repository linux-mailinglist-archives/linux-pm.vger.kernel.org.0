Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E773361E5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfFEQzX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:55:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32892 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfFEQye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165432euoutp01afd2a2b1857983834207f93656f40c21~lW7N5zt8P3074630746euoutp01C
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165432euoutp01afd2a2b1857983834207f93656f40c21~lW7N5zt8P3074630746euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753672;
        bh=Q/+AVLIuT+hp4vYMuUP4aL41jpAGDZPWXeXLXgkKE2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnrPwDy0xcdoSo+5cpseBCQzfaL25tkMHQFFLVKNqRGSCrN+JMsByozYwG1RcYEnR
         oenZUrkzfHphr6QE7EPlLE5yhyBlX1oCXuy6LWtVvqkaehqAK1h7J8ARnlosmRhA3t
         fQrGKbwXCg2jniZBwIbEb4VVAIlbrx16aJ48tJ98=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165431eucas1p28d622bb5311f99666f6ec98704fac0cf~lW7NGLlMd0086300863eucas1p2T;
        Wed,  5 Jun 2019 16:54:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.4E.04377.7C3F7FC5; Wed,  5
        Jun 2019 17:54:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165430eucas1p1d3e42d3abbaefbdda9658cb814909fad~lW7MIq4640109401094eucas1p1b;
        Wed,  5 Jun 2019 16:54:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165430eusmtrp2cea836f9721f969a3a0f35be62c04419~lW7L5G8Pf2868028680eusmtrp2L;
        Wed,  5 Jun 2019 16:54:30 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-f0-5cf7f3c7dbbf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.4D.04140.6C3F7FC5; Wed,  5
        Jun 2019 17:54:30 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165429eusmtip143e0d15d7ba8f3ef71e4fd8d0efa762e~lW7K-vY6p0338903389eusmtip1K;
        Wed,  5 Jun 2019 16:54:29 +0000 (GMT)
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
Subject: [PATCH v8 04/13] dt-bindings: ddr: rename lpddr2 directory
Date:   Wed,  5 Jun 2019 18:54:01 +0200
Message-Id: <20190605165410.14606-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa1BMYRjHvXuula1ja/SqRmanXEK5ZHobhpoMZ0J80DRoRktHNdqwp9Dl
        wxYqXURrqklJyGbLdJWE0oVt1FoNTegyxkqD5LKrXKPtLL79nvf/f57/M8+8NCa5RzjRUTGx
        nCJGFi0lrfGG+9/0S7XGidBl+k4bVFNQRaA+0wiBSjoeEqjikwEg1YNiEerOlKMcwzsM6fXV
        FNKljFLoudIFPW4qIpExuwOgAn2zCF3rGKRQf3I5idpH0wjU8iQQ9f+wReOdL4GfPTv+JRdn
        zyl7cPZm4SDF1mpOkmz2sTGSbR27LWJP1WsAW9eVyBpr526z2mm9JpyLjjrMKbzWhllHalo1
        2MHj4qOV6uuYEtyxyQBWNGS8oepFGcgA1rSEKQdw+NckLhSmqcJ4xqIYAUy+2Ef9bclJOWsR
        1AB2P0il/rWUtZjIDEDTJOMJGzWHzA0OTCIc6GvBzB6MGRVB3fevuFmwZwKgqruXNDPOuEPV
        S810gphZB6+O3yCFNFdYUX0XM7MV4wfztHXT+0FmiIKq3mZcMK2HavVTQmB7+FZbb1nVBf6+
        WSISmIfK7FIgcBI05BRbPKthu7aHMC+NMYtgVZOXGSHjDw39+wS0hU/fzzKbsSnMbcjHhGcx
        TE+VCDMWwvqsR5ac2VBdmWeZzcLzH4ctB1UBmFLUg50GroX/sy4AoAGOXBwvj+D4FTHcEU9e
        JufjYiI89x6Q14Kpz9U1qTU1gqafe9oAQwPpTDGsmQiVELLDfLy8DUAakzqIZf2mUIk4XBaf
        wCkO7FbERXN8G3CmcamjOHHGi10SJkIWy+3nuIOc4q8qoq2clKBufkaIvTsddCg8fcJnbMfo
        duXGeDeXwGfROoNjkKHUs3F4wJlatWJ1b2Zz8CvfDaIq3dLl4ij3xYb8pEivEd2VANHlNJ8R
        RXGgm++PeZeCZxdXuIcs2DqSZedb1NQ49DZs8xvdeAJTuKTPrs65y5vw3/J5JUedmPMBbfLg
        X5en3pLifKRsuQem4GV/AGmrkLtYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7rHPn+PMZj+l8Vi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFUHVzEXtPBWrFm+lbmBcS93FyMnh4SAiUR/0xTG
        LkYuDiGBpYwSN76uZoNIiElM2redHcIWlvhzrYsNougTo8Tm6XOAHA4ONgE9iR2rCkFqRATq
        JfrfXAKrYRZoYJZYs/0qK0hCWMBZYvKZq2BDWQRUJSY/WgU2lFfAXmLlt+1Qy+QlVm84wAxi
        cwo4SEw7vpkFxBYCqrl0/TfzBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjadux
        n1t2MHa9Cz7EKMDBqMTDK7Hxe4wQa2JZcWXuIUYJDmYlEd7E219ihHhTEiurUovy44tKc1KL
        DzGaAh01kVlKNDkfGOd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4
        pRoY3VdJL13/Rl3xuKzXJSfPjEKOOarzZv55I22VLBkiUzuhzdJzSlbqZKkbrqV2x0+Zylot
        k2Gfu1r13O6d2b4m5g0VzKyHLlQYXK/4/rLkc1+ofdXTUjdN866gh3+7q1r17p+QKdUONZp8
        W1ry5VTt49zbbF/mf1Jv8Nq4TTVSTsd899lDt+YosRRnJBpqMRcVJwIA0TxNy7sCAAA=
X-CMS-MailID: 20190605165430eucas1p1d3e42d3abbaefbdda9658cb814909fad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165430eucas1p1d3e42d3abbaefbdda9658cb814909fad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165430eucas1p1d3e42d3abbaefbdda9658cb814909fad
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165430eucas1p1d3e42d3abbaefbdda9658cb814909fad@eucas1p1.samsung.com>
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

