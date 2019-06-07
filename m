Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4238D2F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfFGOgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50260 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfFGOfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143535euoutp016a5c4db20fb2c3ed241c11227752902c~l8UeINqxJ0177101771euoutp01L
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143535euoutp016a5c4db20fb2c3ed241c11227752902c~l8UeINqxJ0177101771euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918135;
        bh=3WP8EDAu+5H7APsQt9nFgGZ+xA43IHtfClvOa7dqrls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CASbRO6bne+AKXcLqtSKKK0L1LI8E09gye6ZYl7eVMkOmoqg5xD7mDfII9sNKbWTZ
         ebiZG3Bfte8cmm7aw9wVBBy6n31mIZ8Jl2e5JlVOeq2RIPH5ZxOcioOHHUjan2iqBX
         aQqMXOhEjfPk7X/k8i+mgpm50OFNnl0gAPUj1ciY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143534eucas1p1cd2502bda19c9ed1a14d96ebf7b560ac~l8UdNWnxF1837618376eucas1p1N;
        Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9F.D0.04325.6367AFC5; Fri,  7
        Jun 2019 15:35:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143533eucas1p15b29a74650422ff1eb1fec4307333e8d~l8UcPP4nk0703007030eucas1p1S;
        Fri,  7 Jun 2019 14:35:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143533eusmtrp2479ff2d4fc4843495a1dde9eb6caaa41~l8Ub-h4jE1498514985eusmtrp21;
        Fri,  7 Jun 2019 14:35:33 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-a3-5cfa76367dfd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.56.04146.5367AFC5; Fri,  7
        Jun 2019 15:35:33 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143532eusmtip162083ae74dbdd3284b983ecc035457a0~l8UbBRqxR2644726447eusmtip1x;
        Fri,  7 Jun 2019 14:35:32 +0000 (GMT)
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
Subject: [PATCH v9 10/13] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Fri,  7 Jun 2019 16:35:04 +0200
Message-Id: <20190607143507.30286-11-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURz27O4+nM5u09ovs4xRUYaW9OBADzQKLv0VGARlj1k3tdysXV3a
        i5mUr8wyKtPsHYkVTh1mFpmPMqa2WfZAMzIjo/Ix50QtLbc767/v953v8TuHwxCKTtKfidUm
        8DqtOk5FyaQVz0deBq/Qj0YuuThA49K8EhK/G+wm8dX6lyS+a+tCOPVmCYXPmQsluClLg3O6
        fhDYYjHSuPn4Txq3GQKw7dRHEr+uukxhe3Y9wnmWJxJ8v76Dxi3m9bg9pYjCdT/TSDz+tlSK
        q1s34PZfPnjoxWcUpuSGHLlSru/9CZorMLRIuYf5HTRXVpxBcdWF92guO7WX4mp6H0u406Zi
        xJU3HubsZbM3em2RrdrNx8Xqed3iNTtlMeZnDmJ/E5XUes2BDMhEZiJPBthlUJNxi8pEMkbB
        FiHo/5bvHgYR5I6lEeJgR9B4vxFNWmrTUlxYwd5B8Ows+8/RYbXQmYhhKDYEKosPODV+bB6C
        gm8RTg3BPiCgp/2Dy+zLboKe85UuLGXnQdsNC+HEcjYMzFcuU2JZINw1PnXxnhN8QUWlaz1g
        sxmoqm9AzjJg18H4oFrU+8L3BhMt4gD48/CqRMQCGLKvuy9wBLpyCt2alVDX0EI6Ywh2IZRU
        LRbpcDAPPCDFdB943zPVSRMTMLfiIiHSckg/qRDVC8B0yuoumg537l1wh3NQ8sa5jPN1ziEY
        s92kz6DA/P9l1xAqRko+UdBE88JSLX8wRFBrhERtdMiueE0Zmvh4jeMNjkr05HdULWIZpPKW
        c/RIpIJU64VkTS0ChlD5yfXW4UiFfLc6+RCvi9+hS4zjhVo0k5GqlPLDHp+2KthodQK/j+f3
        87rJUwnj6W9AMTOy9MdWlzZlJW0PXzslSeId3yfJZPNsCREDQXN9e/f4wqwlgXbqdkD3Xiaj
        7cBQZ1RfwUIYylhfNBysHFxkDe3sdCiZoy/sx788H7301R4esHVc2+w31WZsfbXZOCcnNbnC
        I6zGaJi/PN1ek+BxwuoTNm2RbNsjrCk3jXjx/SqpEKMODSJ0gvovOsr6SnQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7qmZb9iDD7sZ7XYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        yzh19CtzwRm2iisLvjI2MG5h7WLk5JAQMJE41N7I2MXIxSEksJRR4u+9n4wQCTGJSfu2s0PY
        whJ/rnWxQRR9YpS4ffcGUIKDg01AT2LHqkKQuIjAHEaJn13bwCYxC5xllti94g0TSLewQJDE
        8eefwWwWAVWJW4vOM4PYvAIOEqfmzWGD2CAvsXrDAbA4J1B89rYdbCALhATsJVY9d5jAyLeA
        kWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYBRuO/Zz8w7GSxuDDzEKcDAq8fA6MPyMEWJN
        LCuuzD3EKMHBrCTCW3bhR4wQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wMTRF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkb74PpYn59f31/03/DhwZk7xf3q
        v+paopU+7atnPL1GhOMO+5f5h+8Hu+1oKWd+bPVwbaOapugtxkrWCdezvZau3/60t6rC9o22
        67aI7wWhMbVMr9dY3axaefxrUvM/zfzHTC5H17+cJ/fkj3VBtKenRmRTWLzA5XPa71aZNT0K
        cu+Qsej9eVOJpTgj0VCLuag4EQDY+7Fs2AIAAA==
X-CMS-MailID: 20190607143533eucas1p15b29a74650422ff1eb1fec4307333e8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143533eucas1p15b29a74650422ff1eb1fec4307333e8d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143533eucas1p15b29a74650422ff1eb1fec4307333e8d
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143533eucas1p15b29a74650422ff1eb1fec4307333e8d@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the chipid label which allows to use it in phandle from other device.
Use syscon in compatible to get the regmap of the device register set.
The chipid is used in DMC during initialization to compare compatibility.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 67f9b4504a42..4801ca759feb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,8 +35,8 @@
 		#size-cells = <1>;
 		ranges;
 
-		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+		chipid: chipid@10000000 {
+			compatible = "samsung,exynos4210-chipid", "syscon";
 			reg = <0x10000000 0x100>;
 		};
 
-- 
2.17.1

