Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6AAEA9B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404411AbfIJMgq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 08:36:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37713 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404419AbfIJMgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 08:36:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190910123644euoutp01ff4e140ab4a3a87a72819cee21addce7~DE_06Jb-L1102311023euoutp01Z
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 12:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190910123644euoutp01ff4e140ab4a3a87a72819cee21addce7~DE_06Jb-L1102311023euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568119004;
        bh=8YP4+xlfEaAfg5XUJ7zuT9F9MelFu1bjKK5ChWjCJ0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8cPsGK0bpbY5gYXlpqskhDkQWoSqePqRbZh7vl82qAlaip1lKHps8lcnXYTuPZUF
         BR0sG3tsyuBsQIbVfVPSSfCmQd69Z264CoydEgPDl658l5F79SfZQPxYTE+4ZPJ0d1
         viKpHDncxdLLPjjFyiKOlkwmJaBiEjGNXedS4qMs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190910123643eucas1p13159f926fb492df74da85d64d1e23acc~DE_0EZqW03111931119eucas1p12;
        Tue, 10 Sep 2019 12:36:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.8B.04374.BD8977D5; Tue, 10
        Sep 2019 13:36:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190910123643eucas1p2666bc55d5b36efbbb02565793a2c1f86~DE_zTyRqX1358613586eucas1p2-;
        Tue, 10 Sep 2019 12:36:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910123642eusmtrp1a759c272203dad370b333da88a91ad0f~DE_zFhrn_2381323813eusmtrp1L;
        Tue, 10 Sep 2019 12:36:42 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-e4-5d7798db73bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.EC.04117.AD8977D5; Tue, 10
        Sep 2019 13:36:42 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123642eusmtip1bf306ff4d31bb286429f739389964b05~DE_ye0b5w0745507455eusmtip1O;
        Tue, 10 Sep 2019 12:36:42 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org
Cc:     robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4 4/6] ARM: EXYNOS: Enable exynos-asv driver for
 ARCH_EXYNOS
Date:   Tue, 10 Sep 2019 14:36:16 +0200
Message-Id: <20190910123618.27985-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910123618.27985-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3bM8pjDdY+1rTYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y27RuvcIu8XhN+2sFpsfHGNz
        4PHYtKqTzWPzknqPvi2rGD0+b5ILYInisklJzcksSy3St0vgyjjZspC54CtLxZ1H+5gaGLtZ
        uhg5OSQETCQ2ddxn6mLk4hASWMEoMXXrFkYI5wujxMGzc9ghnM+MEpu/fmXuYuQAa7l40Bci
        vpxRYt+Zm0xwHWdfrWAGmcsmYCjRe7SPEcQWEVCXeHXqPzNIEbPAOiaJZbOWMYJMEhbwl/g6
        RRfEZBFQlbh0MQWknFfAWmLmi4lMEOfJS6zecABsJKeAjcSp3bvAdkkIdLNLvHl9GuoHF4l1
        D/ZBNQhLvDq+hR3ClpE4PbmHBaKhmVGiZ/dtdghnAqPE/eMLGCGqrCUOH7/ICnIFs4CmxPpd
        +hBhR4l5j36xQHzMJ3HjrSBImBnInLRtOjQgeCU62oQgqlUkfq+aDnWClET3k/9Qp3lIPLh6
        iQ0SPv2MEk0/P7JPYJSfhbBsASPjKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMBUcvrf
        8a87GPf9STrEKMDBqMTD29FSHivEmlhWXJl7iFGCg1lJhPd6X2msEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsZg1ouLo0pWP/Ga+4mXi8FQwo+T8c28
        sumBX+PYzzoe+vjrwOSpDrOSU5Pa/pSzKGxNv3a0alHYGs3Mh1Wztv73eZGp5CRePPGk/vNv
        juJ71rTe/GffeX8t+9HXC2aKy8UeXPFK64vPscTCd+eu7vJtmHDtf+JG/rQ3ju7To/lbXz/b
        o9Hy+YK6EktxRqKhFnNRcSIAlxlyOSEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7q3ZpTHGmy/b2ixccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl3GyZSFzwVeWijuP9jE1MHazdDFycEgImEhcPOjbxcjFISSw
        lFHi8K43jBBxKYn5LUpdjJxAprDEn2tdbBA1nxglZrz+xwqSYBMwlOg92gdWLyKgKbF3HVgN
        s8AOJom9z/6ygdQIC/hK3P0ykxmkhkVAVeLSxRSQMK+AtcTMFxOZIObLS6zecIAZxOYUsJE4
        tXsXWFwIqOb1xymsExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgM6m3Hfm7Zwdj1
        LvgQowAHoxIPb0dLeawQa2JZcWXuIUYJDmYlEd7rfaWxQrwpiZVVqUX58UWlOanFhxhNgW6a
        yCwlmpwPjLi8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mzg5d
        G7LXvwtUWLrij7l0szPHmXf2n2SYhdYqLIqSTg+Qfrxmlm6ftcXWfBcxx6Yp2j63hfulk2XM
        C7Jitr5XeO/wfALbPfsdT5PYTxoclC6r9BWJXe8XfqTmf9Re69/dHyIsa3S6Ba0+fTgx03xK
        4/e+f7KnK/NOvJ96Nite6C+jteAdFTclluKMREMt5qLiRADt9B+9gAIAAA==
X-CMS-MailID: 20190910123643eucas1p2666bc55d5b36efbbb02565793a2c1f86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123643eucas1p2666bc55d5b36efbbb02565793a2c1f86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123643eucas1p2666bc55d5b36efbbb02565793a2c1f86
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123643eucas1p2666bc55d5b36efbbb02565793a2c1f86@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable exynos-asv driver for Exynos 32-bit SoCs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - none
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index f83786640f94..bba61354c340 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_ASV
 	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
-- 
2.17.1

