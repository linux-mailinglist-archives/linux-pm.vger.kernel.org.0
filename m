Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6312722D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLTASX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63860 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfLTASJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:09 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191220001805epoutp02f146f33e1712f90a42786f8c933c2b24~h7DuKVpqw0799007990epoutp02F
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191220001805epoutp02f146f33e1712f90a42786f8c933c2b24~h7DuKVpqw0799007990epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801085;
        bh=ST4juyyqbRKOEVcJd7O2Zg5VVn33eRk21NfRErVuSO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9C72ojyzjD+ZbmbSl1fv5YkL7E6qWpG6eBxEAvnIKBsChJZ9q4Osoxd3/WI8allO
         uu82omR1mq99GUJPYDGk8Z8Huu77q4TxjGjzDUScGVe3QdmOLECmN8YrW9zKCIJsc8
         As9bEgQrYO1TiFHm2rEIWuMv412jkALbc7qL/NYQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220001804epcas1p4af83559c1be11b8f5ab9b68b35d2c813~h7DtPzcu92970029700epcas1p4_;
        Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47f8Th3NbWzMqYkk; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.14.48498.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epcas1p364322170854fdd171c43f6b1de2b61a4~h7DpibDmt0867408674epcas1p3Z;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001800epsmtrp1b76d09859300f0741048cf388d0760bd~h7DphRx_q1705617056epsmtrp1S;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-5c-5dfc1338f545
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.7C.06569.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip1b705f29b4fb8736ba97cfd0da8887f11~h7DpUaRWj1958919589epsmtip1P;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 06/11] dt-bindings: memory: exynos5422-dmc: Replace the
 deprecated 'devfreq-events' property
Date:   Fri, 20 Dec 2019 09:24:25 +0900
Message-Id: <20191220002430.11995-7-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmrq6F8J9Yg8W7pC3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjOOdSQVPBeq2NzXzNrA+J2/i5GTQ0LAROLUwdnsXYxcHEICOxgl
        Hv14wAaSEBL4xCjRst0AIvGNUeLKru9AVRxgHfNbBCDiexklLvR9YoVwvjBKdH7ZxArSzSag
        JbH/xQ2wSSICGRIzX18GK2IW+Mgk0bXtLlhCWKBQYvehs2BTWQRUJboPyYCYvAJWEh++xkFc
        Jy+xesMBZhCbU8BaYsuzh2CXSgj8Z5OYsGU/E0SRi8Ss9TNYIGxhiVfHt7BD2FISL/vboOxq
        iZUnj7BBNHcwSmzZf4EVImEssX/pZCaQxcwCmhLrd+lDhBUldv6eywhiMwvwSbz72sMK8Tyv
        REebEESJssTlB3ehTpCUWNzeyQZhe0i0ftrAAgmTPkaJpoe32Scwys1C2LCAkXEVo1hqQXFu
        emqxYYERcnxtYgQnUi2zHYyLzvkcYhTgYFTi4XVI+x0rxJpYVlyZe4hRgoNZSYT3dsfPWCHe
        lMTKqtSi/Pii0pzU4kOMpsCAnMgsJZqcD0zyeSXxhqZGxsbGFiaGZqaGhkrivBw/LsYKCaQn
        lqRmp6YWpBbB9DFxcEo1MB68mJl8eVeHi0xY+EbmYpdDSyf6rTxcKZzvKzyL513wQ47rzVeW
        e0bxqjVwF53wtJkSVvim0UnXtEjfaHPmwmmyraLzZ/xWq9ryatH7DL/d+2MLGN6csHObO1lY
        +3+8bfTCMKZpttOV1+gqhJ6e4Hhv+omP3DxbfpVYcq1YmfUxzTeH+evBdCWW4oxEQy3mouJE
        AGGzO1y6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK658J9Yg6WtNhb357UyWlz/8pzV
        Yv6Rc6wW/x+9ZrXof/ya2eL8+Q3sFmeb3rBbrLj7kdVi0+NrrBaXd81hs/jce4TR4tOD/8wW
        M87vY7JY2NTCbrH2yF12i6XXLzJZ3G5cwWbRuvcIu4OQx5p5axg9Nq3qZPPYvKTeY+O7HUwe
        fVtWMXpsvzaP2ePzJrkA9igum5TUnMyy1CJ9uwSujGMdSQXPhSo29zWzNjB+5+9i5OCQEDCR
        mN8i0MXIxSEksJtRYsO1JqYuRk6guKTEtItHmSFqhCUOHy6GqPnEKPFtegszSA2bgJbE/hc3
        2EBsEYE8iU0bvzKDFDEL/GeS+H7yASNIQlggX+LLQRCbg4NFQFWi+5AMiMkrYCXx4WscxCp5
        idUbDoCN5BSwltjy7CE7iC0EVPLy/AXWCYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al
        6yXn525iBIe7ltYOxhMn4g8xCnAwKvHwOqT9jhViTSwrrsw9xCjBwawkwnu742esEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkaJpb4Kjks+ahXX1xZy
        Hb6yRfWGZ32rj8AH/vfB8ufEuuKOpumZ7i1en3qIrzDtamf8xZtaWjr7f71TzD1h/v6R1bcZ
        a0T1+F80vWK52yH4vDXaqOvg41n5D07a1oguu5y+se3f72N9GuyLf/7J7mm39hf1VvKbUxXz
        i9+iq/bwnr1HAgur5yuxFGckGmoxFxUnAgA6+mBLcwIAAA==
X-CMS-MailID: 20191220001800epcas1p364322170854fdd171c43f6b1de2b61a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001800epcas1p364322170854fdd171c43f6b1de2b61a4
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001800epcas1p364322170854fdd171c43f6b1de2b61a4@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the deprecated 'devfreq-events' property with 'exynos,ppmu-device'
property. But, to guarantee the backward-compatibility, keep the support
of 'devfreq-events' property.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/memory-controllers/exynos5422-dmc.txt        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
index 02e4a1f862f1..fbecbcc00adb 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -17,14 +17,14 @@ Required properties for DMC device for Exynos5422:
 - clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
   "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
   "mout_mclk_cdrex"  entries
-- devfreq-events : phandles for PPMU devices connected to this DMC.
+- exynos,ppmu-device : phandles for PPMU devices connected to this DMC.
 - vdd-supply : phandle for voltage regulator which is connected.
 - reg : registers of two CDREX controllers.
 - operating-points-v2 : phandle for OPPs described in v2 definition.
 - device-handle : phandle of the connected DRAM memory device. For more
 	information please refer to documentation file:
 	Documentation/devicetree/bindings/ddr/lpddr3.txt
-- devfreq-events : phandles of the PPMU events used by the controller.
+- exynos,ppmu-device : phandles of the PPMU events used by the controller.
 - samsung,syscon-clk : phandle of the clock register set used by the controller,
 	these registers are used for enabling a 'pause' feature and are not
 	exposed by clock framework but they must be used in a safe way.
@@ -73,8 +73,8 @@ Example:
 			      "mout_mx_mspll_ccore",
 			      "mout_mclk_cdrex";
 		operating-points-v2 = <&dmc_opp_table>;
-		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
-				 <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+		exynos,ppmu-device = <&ppmu_event3_dmc0_0>, <&ppmu_event3_dmc0_1>,
+				     <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
 		device-handle = <&samsung_K3QF2F20DB>;
 		vdd-supply = <&buck1_reg>;
 		samsung,syscon-clk = <&clock>;
-- 
2.17.1

