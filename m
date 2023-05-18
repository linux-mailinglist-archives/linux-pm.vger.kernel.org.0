Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E604707B49
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjERHo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjERHoX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 03:44:23 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D72118
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 00:44:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230518074417euoutp018a777626c992323c4e318aeae5584ffa~gLRuYuZzV0715507155euoutp012
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 07:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230518074417euoutp018a777626c992323c4e318aeae5584ffa~gLRuYuZzV0715507155euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684395857;
        bh=SLVY/n0NOgJuLlPxSfHb8xa2VifNCuXjo5NyzsDrXr4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=b8ftHhStxzpUjLR/uNhBzBqUdU402ZwiVzV3/0K71PXTG+i8GN11M8ffpK6L2TYIn
         AG5FH+MkXxozqq+FjhxZoJYLmIjde3nOkQZz3zquGMHYt5zXZOEUj9O+y52VHI7hLB
         1ioqWGMIRx5f30hheoD7RXW4qzr2gDSKMcbfdn0M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230518074416eucas1p1547736fe516e6e923def1c977e8e6f08~gLRuMSi7a2266922669eucas1p1N;
        Thu, 18 May 2023 07:44:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.6B.35386.057D5646; Thu, 18
        May 2023 08:44:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e~gLRt_mABO2267322673eucas1p1U;
        Thu, 18 May 2023 07:44:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230518074416eusmtrp2b9512fd6c1228fb6288d529d651c5822~gLRt87B1x0474504745eusmtrp2Z;
        Thu, 18 May 2023 07:44:16 +0000 (GMT)
X-AuditID: cbfec7f4-cdfff70000028a3a-d2-6465d750f473
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.D3.14344.057D5646; Thu, 18
        May 2023 08:44:16 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230518074416eusmtip266789f297403e88dbd442292923aff3e~gLRte-d7M0852408524eusmtip2N;
        Thu, 18 May 2023 07:44:16 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] PM / devfreq: exynos: add Exynos PPMU as a soft module
 dependency
Date:   Thu, 18 May 2023 09:44:03 +0200
Message-Id: <20230518074403.2894799-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned2A66kpBp/2W1g8mLeNzeL6l+es
        Fntfb2W3+Nx7hNFixvl9TBZrj9xlt7jduILNgd3jzrU9bB59W1YxenzeJBfAHMVlk5Kak1mW
        WqRvl8CVca99NVPBfO6KM+1djA2Mpzi7GDk5JARMJO4f+c3SxcjFISSwglHiScsLNgjnC6PE
        ql1/mSCcz4wSmzcdYoNpudh6DKpqOaPE75n7GCGcViaJ//c+M4JUsQkYSnS97QLrEBFIl1hy
        /A9YEbPATkaJIwcbwRLCAiESJ1afArNZBFQl5uw6AGbzCthL7Pn+hx1inbzE/oNnmSHighIn
        Zz5hAbGZgeLNW2czgwyVEJjIITHhzCtGiAYXiUf/tkI1C0u8Or4FypaR+L9zPhNEQzujxILf
        96GcCYwSDc9vQXVbS9w59wvoDA6gFZoS63fpg5gSAo4S0zr1IEw+iRtvBSFu4JOYtG06M0SY
        V6KjTQhihprErOPr4LYevHCJGcL2kFh1ZjUriC0kECtxe+JrtgmMCrOQfDYLyWezEE5YwMi8
        ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzC1nP53/MsOxuWvPuodYmTiYDzEKMHBrCTC
        G9iXnCLEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBqcUz
        wWXZjPkbzn5tfHiA6Sf3Nk7ruoydqRrX3uuvXCB4ukf7p8sEGeY4nRX77jw81LZg+Rl2G18d
        bp+GJz1XBBsmPJshE5vs0OF5x9R0R+fDU/e7eGt4WXT1nnz08M7We3pgnXrPFNHzPlembFDp
        3vpo1qym48sC1V/byy91u3FV1JK5hTftZljN8rMFxVHTpjLfPf07MfuKQkNjWu+5PUo//nFM
        V/rNWS8bPOVBsKnBqY4stZmMGy0kJ15wfDvzcH/CNonYiQ+5uTMcl2pM3SwYtt4sxtVfqjWK
        5XCH0cv1MTNX9drInz6Xuc3zX+bqvZdDMz54uf0x74zcyX1yg+1vm0t7hE/LX5r4/KzMMiWW
        4oxEQy3mouJEAME8plicAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsVy+t/xe7oB11NTDObdVrN4MG8bm8X1L89Z
        Lfa+3spu8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7vHnWt72Dz6tqxi9Pi8SS6AOUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4177aqaC+dwVZ9q7
        GBsYT3F2MXJySAiYSFxsPcbWxcjFISSwlFHiyJ4WFoiEjMTJaQ2sELawxJ9rXVBFzUwSMxa9
        YQJJsAkYSnS9BUlwcogIZEpM+HONHaSIWWA3o8SsPwuZQRLCAkESP9t/gdksAqoSc3YdAGvg
        FbCX2PP9DzvEBnmJ/QfPMkPEBSVOznwCdgUzULx562zmCYx8s5CkZiFJLWBkWsUoklpanJue
        W2ykV5yYW1yal66XnJ+7iREY0tuO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8Ab2JacI8aYkVlal
        FuXHF5XmpBYfYjQFum8is5Rocj4wqvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NT
        C1KLYPqYODilGpg48rg2fVeUFPz5+phRPLNLh0ZQukbZKgEDoU6pEuXWz1fyF5Z9ven48Mdp
        l0NO17wfBjxz2fLpWsRCt8mtG5c1f9CbmW3PLc+1MmYRgwZTSFFam7vf6xNLC9avMrk5NSpZ
        WqTs+E+256cTZ+6fcW7n3oUyH3wUQ76oS0+SvtNS5KaT+yN5coXobmmnb1zRrZU/fkcrFTXI
        vrvPU7ZFOjWSy/7B+o63Xz4aRz2sk2j+7KtsNYPtRYlZQ3Xj8z2XNye9NdKboxtx6Jbg4oym
        N/+YRTq6i3Y/YffV3LnbVSspaen3RS97GMsy/F9lRbx8HbHSoXm7Rt/9A5uv8j+p+zdTbcPZ
        mjle0yVXVD4UO6jEUpyRaKjFXFScCAD5ad5z8gIAAA==
X-CMS-MailID: 20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e
References: <CGME20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit adf8238ef403 ("ARM: dts: exynos: move exynos-bus nodes out of soc
in Exynos4412") changed the order of the exynos-bus nodes, what results
in different probe order of the Exynos Bus devices. Although the driver
properly handles the deferred probe and all devices seems to be finally
properly registered, this change revealed some kind of a bug related to
PPMU counters registration and passive governor operation. Usually in 1
of 10 boots this results in complete board freeze during loading of the
kernel modules.

To avoid that freeze, ensure that the Exynos PPMU driver is already
loaded before the Exynos Bus driver starts probing.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This is a follow-up of the following discussion:
https://lore.kernel.org/all/d287ca9f-b056-d39a-aa93-b0e2cb279f73@linaro.org/
---
 drivers/devfreq/exynos-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 88414445adf3..245898f1a88e 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -518,6 +518,7 @@ static struct platform_driver exynos_bus_platdrv = {
 };
 module_platform_driver(exynos_bus_platdrv);
 
+MODULE_SOFTDEP("pre: exynos_ppmu");
 MODULE_DESCRIPTION("Generic Exynos Bus frequency driver");
 MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1

