Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C18BC96
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfHMPJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:09:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45907 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfHMPI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:08:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190813150858euoutp012ef20877e2fe8a3d871379fa325d1166~6g-varaGr2748427484euoutp01F
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190813150858euoutp012ef20877e2fe8a3d871379fa325d1166~6g-varaGr2748427484euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565708938;
        bh=K7jItQOOvz9Ceb8IAXpYUbZlk9d9PnUjesgsb/SQnsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3lr+ggSmEuJxxeuCz/xkIQ4CiP3hcaF8Ci4E4RWsfOHEgVXFPRwrLvOLPJs9bkno
         BTzfD4s6EDUKPFQVB3Frd+NOxAmr2z6/EHqH9lNqhtXwZGk/soy9q067oLeE03Mcfn
         /W+wTYISrCnbwPe1lemXt1COn8KWCpuuMGo/g1Xw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813150857eucas1p275b4ea9a3fc17fa41089ecde9c3ab917~6g-uhxHqC2658426584eucas1p2B;
        Tue, 13 Aug 2019 15:08:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.FA.04374.882D25D5; Tue, 13
        Aug 2019 16:08:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b~6g-taGfGB2550825508eucas1p1H;
        Tue, 13 Aug 2019 15:08:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813150855eusmtrp29c37f17c000d252e6f976d1bd1fe35ff~6g-tKgdIW2922129221eusmtrp2s;
        Tue, 13 Aug 2019 15:08:55 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-0a-5d52d288f4c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.23.04117.782D25D5; Tue, 13
        Aug 2019 16:08:55 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150855eusmtip29b6434756033654280e3626a789ba6a3~6g-sjoaS01406314063eusmtip2e;
        Tue, 13 Aug 2019 15:08:55 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 5/9] ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Tue, 13 Aug 2019 17:08:23 +0200
Message-Id: <20190813150827.31972-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813150827.31972-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87odl4JiDU7+MbXYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsLHL1kLmtkrfl3q
        Y2pg/MvaxcjJISFgInF6/1/2LkYuDiGBFYwS9ybdZ4NwvjBK7Ft5CMr5zCjRerUHqIwDrOX9
        lXSI+HJGiRXPX7DCdVx59gJsLpuAoUTv0T5GEFtEQFji3tLlYDuYBe4xSZx+epYJJCEs4C2x
        /dUTsAYWAVWJ5q7HYDavgLXEnOVfGCEOlJdYveEAM4jNKWAjsXP6e7BtEgKT2SX2TFvEAlHk
        IrF06jFmCFtY4tXxLewQtozE/53zmSAamhklenbfZodwJjBK3D++AGqFtcTh4xdZQZ5jFtCU
        WL9LHyLsKPHkyQMWiJ/5JG68FQQJMwOZk7ZNZ4YI80p0tAlBVKtI/F41nQnClpLofvIf6jQP
        iWOrZkODsZ9R4tP76UwTGOVnISxbwMi4ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCx
        nP53/OsOxn1/kg4xCnAwKvHwBmwJihViTSwrrsw9xCjBwawkwjvhIlCINyWxsiq1KD++qDQn
        tfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDI1dtTsTytgXqs8P1F+xe/fzjBm1O
        1sjfs6bsPn/i6JEyw71Cp6dI8dZf7vx1Vi1Jw/mczZe2a2dbs+uuzp4pvqgr52Od+MMbazlF
        FgjfTmrUnFvb+aiX3X/9jhfr10mva8phFv298mqG1sLXPEvmvxCbkOT3WfqEoLtvWeFGjoCp
        OWKbGnUtJiqxFGckGmoxFxUnAgAUb5euKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7rtl4JiDe4f17HYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsLHL1kLmtkrfl3qY2pg/MvaxcjBISFgIvH+SnoX
        IxeHkMBSRolXJ/+xQcSlJOa3KHUxcgKZwhJ/rnWxQdR8YpR4s/I8C0iCTcBQovdoHyOILQJU
        dG/pcnaQImaBV0wSt+f9ZwJJCAt4S2x/9YQVxGYRUJVo7noMZvMKWEvMWf6FEWKDvMTqDQeY
        QWxOARuJndPfg9UIAdU8fbeeeQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBIb7t
        2M8tOxi73gUfYhTgYFTi4Q3YEhQrxJpYVlyZe4hRgoNZSYR3wkWgEG9KYmVValF+fFFpTmrx
        IUZToKMmMkuJJucD4y+vJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwen
        VAOjlFhG6O+1x0rz16yoSEtZL7Z+VaP2lebDb7qPXsgXvVGT+XF++JKpxyNvT7mZPed1xBSx
        yt2Htjpurfmx+MLua29L6mVez92syRvyb6W25RMWLj2Vqzsf3bR79elmFrtkxO7glB6O9+FW
        j53uBB3/IO33xOB2+vs0hqtiaVtPe76Ovhki+L2FX4mlOCPRUIu5qDgRAG55G+qHAgAA
X-CMS-MailID: 20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
        <CGME20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch enables exynos_chipid driver for ARCH_EXYNOS
based SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - none
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c775de1b..8a098fb4f04c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -77,6 +77,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1

