Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D06CFE1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfGROcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:32:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52656 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390712AbfGRObe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143133euoutp02c56b89375ce81f2d707ad277d639c07e~yhtpu2kLl3113431134euoutp02J
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718143133euoutp02c56b89375ce81f2d707ad277d639c07e~yhtpu2kLl3113431134euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460293;
        bh=IH91+EfknxCsZpO+Zji3RgL1+95VctT4V130EAJU9ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqFRYXzRYbvplU/HNqs9HGtWqxhe62hFgP3PZ6ZfaoRi8binGM9l3LYK/9AQerRTq
         5JB0tdbVaRu9DXh9fYmhKqUZ8WuNjBuHLUG22iPTzPmZ5+CenZ4Ek4+n0n8cyeGchQ
         2LVBGaHZCJvKsrx0Mgtsqq45sl4/XsOeC7B7uK74=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718143132eucas1p2ff278faf206eb76eba69f83739616c85~yhto_0OWi1436114361eucas1p2h;
        Thu, 18 Jul 2019 14:31:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.55.04377.4C2803D5; Thu, 18
        Jul 2019 15:31:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718143131eucas1p2e1afc9fe816fff52ee4d12e0979eeb4c~yhtoJrM_m2850128501eucas1p2u;
        Thu, 18 Jul 2019 14:31:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718143131eusmtrp1e4fa6d101fd4a18f7b97ec7892a804b1~yhtn7lXpE1897918979eusmtrp1Z;
        Thu, 18 Jul 2019 14:31:31 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-24-5d3082c40352
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.3E.04146.3C2803D5; Thu, 18
        Jul 2019 15:31:31 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143130eusmtip18ac100e5aea7cd9e756191bf98b4a8e2~yhtnSP8yY1655816558eusmtip1y;
        Thu, 18 Jul 2019 14:31:30 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 4/9] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Thu, 18 Jul 2019 16:30:39 +0200
Message-Id: <20190718143044.25066-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87pHmgxiDaYv4bPYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxt+F59kLJrJXfN2y
        i62BsZWti5GDQ0LARGL2B98uRi4OIYEVjBLzth5i6mLkBHK+MEq8eOUOkfjMKHFt7hkWkARI
        w49Zr9khEssZJdacXccK4QB1zDz2gh2kik3AUKL3aB8jiC0iICxxb+lysA5mgXtMEqefngXb
        ISzgKfG9/wNYEYuAqsTB721gNq+AtcT1BS/ZIdbJS6zecIAZxOYUsJE4fPcpI8ggCYHJ7BJL
        LnazQhS5SHTdWQl1n7DEq+NboJplJE5P7mGBaGhmlOjZfZsdwpnAKHH/+AJGiCpricPHL7KC
        goNZQFNi/S59iLCjxKfFb9khocQnceOtIEiYGcictG06M0SYV6KjTQiiWkXi96rpTBC2lET3
        k/9Q53hI7Lk6GxpC/YwSr/6/YZ7AKD8LYdkCRsZVjOKppcW56anFRnmp5XrFibnFpXnpesn5
        uZsYgWnl9L/jX3Yw7vqTdIhRgINRiYc3INcgVog1say4MvcQowQHs5II7+2X+rFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGP290149VXJeHaq5ckH2
        lX/9fgLH5mTWr9t9d/a/YJGlO7M5hZ8sOmnvv63P7qcYe/r3Hvune/4+uM/dGxb3r9wzNTKl
        9OWey43LZLLPTXLlNc5WfBH7bx7zY3XxTUqSv9eVuZ6xsz1gpRtT4nvb8W1X0+PXb7aU/9gU
        IM8e+3y2CecJvYCXDEosxRmJhlrMRcWJAAa/MNEnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7qHmwxiDb6vEbXYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJext+F59kLJrJXfN2yi62BsZWti5GTQ0LAROLHrNfs
        XYxcHEICSxklJqxbwdLFyAGUkJKY36IEUSMs8edaFxtEzSdGiYU3LrOAJNgEDCV6j/Yxgtgi
        QEX3li4HG8Qs8IpJ4va8/0wgCWEBT4nv/R/AilgEVCUOfm8Ds3kFrCWuL3jJDrFBXmL1hgPM
        IDangI3E4btPwWqEgGpmv7zGOIGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAIN92
        7OfmHYyXNgYfYhTgYFTi4Q3INYgVYk0sK67MPcQowcGsJMJ7+6V+rBBvSmJlVWpRfnxRaU5q
        8SFGU6CjJjJLiSbnAyMwryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMH
        p1QDo+XFEFXPw0sFu/8LzNQ1mf5K0qhGg19EjlnFq4i/Wz9v72ENn3a+8kCmy+y8zD+FfuvO
        rBBT9173Rsx32XufgKCE2tSCW4t+7QuzV1B+lLakpkzn30mz98Y3kwQPHuW0cjSx4HnpcXz1
        FA/br3MmaT0Le2wQfOS+osrV49L96rddvzKfjKtXYinOSDTUYi4qTgQA1kFPpIgCAAA=
X-CMS-MailID: 20190718143131eucas1p2e1afc9fe816fff52ee4d12e0979eeb4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143131eucas1p2e1afc9fe816fff52ee4d12e0979eeb4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143131eucas1p2e1afc9fe816fff52ee4d12e0979eeb4c
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143131eucas1p2e1afc9fe816fff52ee4d12e0979eeb4c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

As now we have chipid driver to initialize SoC related information
let's include it in build by default.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - none
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1c518b8ee520..6fc4af312361 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
-- 
2.17.1

