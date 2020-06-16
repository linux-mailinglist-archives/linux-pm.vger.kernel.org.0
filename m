Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BE1FAAD2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFPIMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 04:12:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42967 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFPIMv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 04:12:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200616081249euoutp01fb5bbb9d4b19e996cd9d0326768757d5~Y_AVG5VH_1793317933euoutp01S
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200616081249euoutp01fb5bbb9d4b19e996cd9d0326768757d5~Y_AVG5VH_1793317933euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592295169;
        bh=0or4auZ6DSYxblVQIydu+M854qGbuvo+O7Bd5hqqIdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vULBeR69LmBugIkWb5r/kMunskbjJAGt79zICxyfDI2WMdsBiqsXek6myjXEetjN7
         R3cOD0HlZbRwlT8Lw4ERW6cxaVJzj+Wg9tK6g5+ICsBAD/OzlTeSQIPVYxnnkDFMoc
         cTplSMjI6OTtcV5hsMkwbww85Yp89/6RZY3sTjuQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200616081249eucas1p2e59ec1dea95189a815a9ffe741961dd2~Y_AUyGChN0050300503eucas1p2o;
        Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 04.8C.61286.10F78EE5; Tue, 16
        Jun 2020 09:12:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3~Y_AUbVX5_2412724127eucas1p17;
        Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616081249eusmtrp1c344972407240afd798bd4f1029fb977~Y_AUakJ0v1259512595eusmtrp1c;
        Tue, 16 Jun 2020 08:12:49 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-8f-5ee87f0111ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.80.08375.00F78EE5; Tue, 16
        Jun 2020 09:12:48 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200616081248eusmtip22195a7010175d47c2b69c5eae933c63f~Y_AT6dVsQ0162901629eusmtip2e;
        Tue, 16 Jun 2020 08:12:48 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/4] ARM: exynos: Apply little core workaround only under
 secure firmware
Date:   Tue, 16 Jun 2020 10:12:27 +0200
Message-Id: <20200616081230.31198-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616081230.31198-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzneV3G+hdxBqsvSlpsnLGe1WLeZ1mL
        8+c3sFtsenyN1eJz7xFGixnn9zFZvPn9gt1iYVMLu8XaI3fZHTg91sxbw+ixaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujM0/Z7AUbBKoaJ46naWB8RBvFyMnh4SA
        icTzz0eYuxi5OIQEVjBKbH83Dcr5wiixe+ZnKOczo8S3lt/MMC1t37ewQiSWM0rsO76LHa7l
        yropjCBVbAKGEl1vu9hAbBGBdIl7f5eAFTELTGCSeNPczwqSEBaIlti1YTFYEYuAqsT8t/1M
        IDavgK3Em3W72SHWyUus3nAAbDWngJ3Ess3PmUAGSQj8Z5NYNm06VJGLxKHnp5kgbGGJV8e3
        QMVlJE5P7mGBaGhmlHh4bi07hNPDKHG5aQYjRJW1xJ1zv4DO4AC6T1Ni/S59iLCjxO5F55hA
        whICfBI33gqChJmBzEnbpjNDhHklOtqEIKrVJGYdXwe39uCFS9Dg8pA4tPguCySEJjJKrF77
        jmkCo/wshGULGBlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCaR0/+Of9rB+PVS0iFG
        AQ5GJR7eiKDncUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu8
        6GWskEB6YklqdmpqQWoRTJaJg1OqgTEy6cFcDzanJy8TC43vZ237vnV+XGrYi7zohJj/J55v
        4mpb9p5Bsv18/muH7v1rn+91PvuB46+AYMinCcklxSZTTjv/3/BG31bLsugeU4V77dw69bgT
        6zNi6l880Gf9rKYc9Wh9vWex6vfpb/puFhVnv3c7dODiIonMuruO4rxsH/5dWvrDZ5ESS3FG
        oqEWc1FxIgA4ku/KHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xe7qM9S/iDL6JWGycsZ7VYt5nWYvz
        5zewW2x6fI3V4nPvEUaLGef3MVm8+f2C3WJhUwu7xdojd9kdOD3WzFvD6LFpVSebx51re9g8
        Ni+p9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
        lNSczLLUIn27BL2MzT9nsBRsEqhonjqdpYHxEG8XIyeHhICJRNv3LawgtpDAUkaJrbOcIOIy
        EienNbBC2MISf651sUHUfGKUmPVOFcRmEzCU6HoLERcRyJRYeO4mexcjFwezwBQmiR3vdoIl
        hAUiJbZeXM4EYrMIqErMf9sPZvMK2Eq8WbebHWKBvMTqDQeYQWxOATuJZZufM0Ess5VYdvYi
        8wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECQ3nbsZ+bdzBe2hh8iFGAg1GJhzci
        6HmcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxhneSXx
        hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGGc9X7zryMMnky21Fm9I
        PiG0uvqu4hrmVbNPrT8az/9iqkPs9u0Jf+ZtkJ+q8VNMNZNJhU3zxLXOP6H2aZybaxMu7t86
        SyyPOzj2eenmm9vjv5uElm94WSj43KvslO66+Sc5nuTdCNJ7PFlslaz7qUniZx9LfXx7n9m+
        e30It7fdDyaftzFvmyOUWIozEg21mIuKEwHFCxw+ewIAAA==
X-CMS-MailID: 20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The additional soft-reset call during little core power up was needed
to properly boot all cores on the Exynos5422-based boards with secure
firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
CPUidle driver, which worked only on boards without secure firmware
(like Peach-Pit/Pi Chromebooks).

Apply the workaround only when board is running under secure firmware.

Fixes: 833b 5794 e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 9a681b421ae1..cd861c57d5ad 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -26,6 +26,7 @@
 #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
 
 static void __iomem *ns_sram_base_addr __ro_after_init;
+static bool secure_firmware __ro_after_init;
 
 /*
  * The common v7_exit_coherency_flush API could not be used because of the
@@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
 static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
+	bool state;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
 		cluster >= EXYNOS5420_NR_CLUSTERS)
 		return -EINVAL;
 
-	if (!exynos_cpu_power_state(cpunr)) {
-		exynos_cpu_power_up(cpunr);
-
+	state = exynos_cpu_power_state(cpunr);
+	exynos_cpu_power_up(cpunr);
+	if (!state && secure_firmware) {
 		/*
 		 * This assumes the cluster number of the big cores(Cortex A15)
 		 * is 0 and the Little cores(Cortex A7) is 1.
@@ -258,6 +260,8 @@ static int __init exynos_mcpm_init(void)
 		return -ENOMEM;
 	}
 
+	secure_firmware = exynos_secure_firmware_available();
+
 	/*
 	 * To increase the stability of KFC reset we need to program
 	 * the PMU SPARE3 register
-- 
2.17.1

