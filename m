Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A760361C6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfFEQyx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33002 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfFEQyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165443euoutp01bb9e51fc03807b09cccf5f573a9ead5d~lW7YgWMvE0154201542euoutp01K
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165443euoutp01bb9e51fc03807b09cccf5f573a9ead5d~lW7YgWMvE0154201542euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753683;
        bh=Rv+G7xRM5W0qIJMO/1XEZpXdtXED3pTULKiTBpTxK9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlbgo/qEkH+LIQyln4XDrnOd8kUSB1uMoucsldVWa/anrVXif/iaswSsTrfnNmdfF
         WDbqYv5rpgMsgRNqrqOqywWJe1/vj+R68qRvbYM/1UqaVSfGo3H5lCSVhtw6Qnp1U2
         BvJbu/V16JYdPGmq/mmQ++3ivyIapxKPU/+AI8IY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165442eucas1p1c4d97cab15bac75809e045a0dbf2ded3~lW7XoJiYe0320603206eucas1p1q;
        Wed,  5 Jun 2019 16:54:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 64.5E.04377.2D3F7FC5; Wed,  5
        Jun 2019 17:54:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165441eucas1p1cf771211156e8aca384ed11c6498c263~lW7Wx7Nr-0347403474eucas1p1W;
        Wed,  5 Jun 2019 16:54:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165441eusmtrp20b1c7e327ea27d34e11e9fac674fe633~lW7WiIZOA2868028680eusmtrp2k;
        Wed,  5 Jun 2019 16:54:41 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-06-5cf7f3d2b5c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.B2.04146.1D3F7FC5; Wed,  5
        Jun 2019 17:54:41 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165440eusmtip11f3008f9bc1be6c8921c0547bb423e3f~lW7Vh6QDL0338903389eusmtip1Q;
        Wed,  5 Jun 2019 16:54:40 +0000 (GMT)
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
Subject: [PATCH v8 13/13] ARM: exynos_defconfig: enable DMC driver
Date:   Wed,  5 Jun 2019 18:54:10 +0200
Message-Id: <20190605165410.14606-14-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ2lw1IyFKMnrkkTjBrFNfEGlajxYWKMUR7UKIlWmSCxBewA
        AjValaCgLIIioAhqFCwS2WSLgBakpgpIERQQohBCRMSlZa2itFP17Tv/Of/9z725DCFvpOYx
        wSHhvCZEqVLQrmR542TzSrNlPGB1ScpCXJzxiMJvrYMUzmlopnDB936E00zZEvzqkhon938m
        cEtLkRQ3nRuW4i7dAtxWfZPGlsQGhDNaaiW4sKFHirvP5tO4fvgCheve7MDdNg889qIPbfHi
        xkZTSe6GrpXkqrJ6pFyJPp7mEs+P0NyzkScSLqlMj7jSl1rOUrJot8sB102BvCo4ktes8jvs
        eqzc9IQO+0ZFjWZ2kjqUTiUgFwbY9TA6YCYTkCsjZ/MRZEyPSMTCiiCu45OzsCDInJz6Z+l4
        kE2IjTwEI8Wd9D9L4kObNAExDM36QKX+hN0wm9XC+7d1DgPBDkugaWqCtDe82G1wazqWtjPJ
        ekOpzezQZewWuNjxnRDTFkNB0VMHu8zo6cZSx7LA9krh2mgRLQ5th6bBXKnIXjBkLHPyAvhd
        lSMRWQBd4m0k8inoT852zmyEemMrZV+aYJfBo+pVorwV3t155rgLsB7w7ounXSZmMLX8OiHK
        MrgYJxenl0LZ5dfOoDmQ9zDdeTgHuQN3kfg8aQgMVzrpFLQ4639YLkJ6NJePENRBvLA2hD/p
        IyjVQkRIkM/RUHUJmvldL6eN1kpU/fOIAbEMUrjLoHg8QE4pI4VotQEBQyhmy5Td1gC5LFAZ
        HcNrQg9pIlS8YEDzGVIxV6ad9eGgnA1ShvPHeT6M1/ztShiXeTp0usOktST5uzUl1W69enei
        b2LYZvNO6WpfUxG+z+2wp7nemOWj8vdM2jCRubPm6F7/dWf8UtzrSruJPQ8KnsuyIsPu1TQv
        QW7Tj31711pfDW7Wt9/39YqJXfpVZdDWrgdThVto/IrQyaihXY9/aAojl0dxhbb2XysaV3/c
        P9YQ32ZWkMIx5ZrlhEZQ/gGTmik4WQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7oXP3+PMbi5U95i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jG2n9rAVfGCt+DrzJksD4zTWLkZODgkBE4lrK+cy
        dzFycQgJLGWUON4xESohJjFp33Z2CFtY4s+1LjaIok+MEhN/bgMq4uBgE9CT2LGqEKRGRKBe
        ov/NJbAaZoEGZok126+CDRIWcJKY96+FDcRmEVCV2Pz7EguIzSvgINFx7SMzxAJ5idUbDoDZ
        nEDxacc3g9UICdhLXLr+m3kCI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgbG07djP
        zTsYL20MPsQowMGoxMMrsfF7jBBrYllxZe4hRgkOZiUR3sTbX2KEeFMSK6tSi/Lji0pzUosP
        MZoCHTWRWUo0OR8Y53kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhgXei0ucGDLld/oerfhzANdWb6Uz0kdq7xOvrntZ3fhWVpSvuGZjJdXlTweLTrL11Pckxd/
        QLLsjkt175mDywv3S7x/YWSSeKfwFY/4uue/gniyLdlipabavo663Onptze+ZUq0Z6Pheen+
        kxXFGmePOvitldizgbla+l/1f2HG90H7tD9v+K3EUpyRaKjFXFScCAC2qai3uwIAAA==
X-CMS-MailID: 20190605165441eucas1p1cf771211156e8aca384ed11c6498c263
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165441eucas1p1cf771211156e8aca384ed11c6498c263
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165441eucas1p1cf771211156e8aca384ed11c6498c263
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165441eucas1p1cf771211156e8aca384ed11c6498c263@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..0cd16c924941 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -290,6 +290,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.17.1

