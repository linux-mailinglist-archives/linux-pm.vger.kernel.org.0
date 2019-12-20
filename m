Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4686A127A9E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLTMCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:02:19 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36387 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLTMBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120143euoutp01f93e5ecf5e967cdcf372563c72fd3f95~iEqFT0jRE1030410304euoutp01z
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120143euoutp01f93e5ecf5e967cdcf372563c72fd3f95~iEqFT0jRE1030410304euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843303;
        bh=PQklDJqR/G6046e9NnfXXWwzMEr/Gk3W/jdjCm+h/+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3P5ULxmMoUdKXz/BOCOK3/CSXGX0hHreWRDT/UZBvtFy4YLrZzfreJ/Ob8HvBGi/
         AH37qqH02KibFeByDSLRqlmBkDGoZ4vLyb1ABS5+hsaZDJg0MNl59uxQ5zuF1F5hPw
         u6RX1PYdC/bMSIl/PRxC+tsDPS/mixxG/wm0PMSE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220120143eucas1p17aa32b17eca0ed2bc744c6b98950424e~iEqE6wuLk1903419034eucas1p1S;
        Fri, 20 Dec 2019 12:01:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.FE.61286.728BCFD5; Fri, 20
        Dec 2019 12:01:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9~iEqEeIr4u1904419044eucas1p1M;
        Fri, 20 Dec 2019 12:01:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120142eusmtrp2e910750d60d4180ce0814f512362bffe~iEqEdfqBq2149221492eusmtrp2t;
        Fri, 20 Dec 2019 12:01:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-da-5dfcb8276ad7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.58.07950.628BCFD5; Fri, 20
        Dec 2019 12:01:42 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120141eusmtip2c7b8b86d637d9087cdf254161b9d59b0~iEqDmY0oK2848028480eusmtip2c;
        Fri, 20 Dec 2019 12:01:41 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 2/7] interconnect: Relax requirement in
 of_icc_get_from_provider()
Date:   Fri, 20 Dec 2019 12:56:48 +0100
Message-Id: <20191220115653.6487-3-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e0+Hc2uy+poLxpU9FSx4CeFGImsIogiKENq1s1ZPmpXe0H4
        iGqammmhTkvtoaKJbT6aUhFzpb20VqmlsvKRuDAr3R9aal5vWf99zznfz3nAYQllC+XJhkfF
        8LooTYSKlpM1T0aaVy8z/wrxrhljsf36OYSN2RUUbh3uo3C+tYnCb52DNM56YKJxhj2dxM3N
        dxlc0vmdwqbuFgq/qcuj8VCqFeHs5ocyXG7tZHB7QgmNszP76QBObSpNotUdLfdptf1ig0xd
        eStObfxqlqnTqkqResi0cDsTLN9wkI8IP87rvPz3y7VXLA7yaDpz0n6vg4xHiXQycmGBWwuG
        Lj1KRnJWyZUgsL7sJ6RgGEGhs5yWgiEEQ1e7ppHCRpNMKhQj6O4YkE0jH8puU6KL5jZCxtWP
        jFhw56wIMgsGSTEguDwZ6JOKSdE1i9sLRpuRETXJLYHaxzlTtILDkJIkriXOWwRldx8Ronbh
        /KDtnY2QPG7wNKdnqg8x6TlbnTu1OXBOBlrH6gkJDoQL1amkpGeBo6GKkfR8mKjNl0lagN5a
        OyXB8QhMRdY/8HroaBqdvJqdnLAcKuq8pPRG6PziYMQ0cK7QNuAm7eAKGTVZhJRWgP68UpIq
        qMtxlUCAxLKWP73V0Jd4mUpHiw3/HWP47xjDv7EFiChFc/lYITKMF3yi+BNrBE2kEBsVtuZA
        dKQJTX7b8/GGH2bktIVaEMci1QxFwKGfIUpKc1w4FWlBwBIqd0W7fiREqTioOXWa10Xv08VG
        8IIFzWNJ1VyF743+ECUXponhj/D8UV73typjXTzj0RZ5230L3Ak6rJ3I8CsNthmPrZxQ8h53
        9niFjsc+KU+67Kj0n7Mpl/wc81E/e7T31beEnrbMM3He/W+9s599KvLZPLJA6xHW+lAI9X3t
        pA4F3TOnmV8ErrLB7p0p7jtuXiK7A+u3vV/o2GU4UbN6qy+/DhW1VxhnLq26xtc2+mgbVaSg
        1fisIHSC5jcKXt4iaQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7pqO/7EGjzdp2pxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQyphx6xVIwgb3i/vY7LA2MTWxdjJwcEgImEgtPbGLqYuTiEBJYyijx4fEndoiEhMTH9TdY
        IWxhiT/Xutggij4xSlzcepEFJMEm4CgxaeoDdpCEiMApRomty8+BjWUWWMEk0T9HuIuRg0NY
        IFJixjFOkDCLgKrEzqMzwYbyClhI9HR2MEIskJdYveEAM4jNKWApcePqJTBbCKhm5+c+Joh6
        QYmTM5+wgIxkFlCXWD9PCGKTvETz1tnMExgFZyGpmoVQNQtJ1QJG5lWMIqmlxbnpucVGesWJ
        ucWleel6yfm5mxiB0brt2M8tOxi73gUfYhTgYFTi4XVI+x0rxJpYVlyZe4hRgoNZSYT3dsfP
        WCHelMTKqtSi/Pii0pzU4kOMpkCvTWSWEk3OByaSvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFC
        AumJJanZqakFqUUwfUwcnFINjNsZlmubZ7td/ePXn5WeNmOj3fuixkWlufJOU5/ZXL0p9979
        vOO7mgePPlkY1ai8a5nybpH4mdW5DaGrPyqbMp3WnbvTb8KqFxOOrVSZtaF9Rq+Y+1GLV19N
        7ZXPxKZstC6vlz6ckxLfsOXOFv6L58q+2ob8+2MmVyfQIFZwylOPqXmBpt3iX0osxRmJhlrM
        RcWJAMrn8RrsAgAA
X-CMS-MailID: 20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch relaxes the condition in of_icc_get_from_provider() so that it
is no longer required to set #interconnect-cells = <1> in the DT. In case
of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e6035c199369..74c68898a350 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -335,7 +335,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-- 
2.17.1

