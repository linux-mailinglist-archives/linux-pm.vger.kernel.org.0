Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F720DBB7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbgF2UIY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:08:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35543 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732890AbgF2TaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:30:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200629100232euoutp01962471a895a789e50bd3edb49599fc7f~c_40wlfXh2577025770euoutp01R
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 10:02:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200629100232euoutp01962471a895a789e50bd3edb49599fc7f~c_40wlfXh2577025770euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593424952;
        bh=okS5KJEik3Mhl0JO7rzq1gAczBX0ZJOrlQAhid5KQSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLR5e7pPMFZTMfIAm0SvZOPpgX+jvSfl9nLuDBL71cbD5B/nY/f6Mp6keSG9MnPU/
         TAVhV0eLuKM27PqK3ENuWidyWGqyPGY8Bp8wy+XVer+TEWO9QMmPzU9a+dPEndRmbj
         ZebvIyI8gLfABHHc+xsyGlEcJMp87DqCwJK03CK4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629100231eucas1p2e0aa31baf3b4ce8608f03c55ba7485cb~c_40bJQHP1896918969eucas1p2B;
        Mon, 29 Jun 2020 10:02:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A4.8A.06456.73CB9FE5; Mon, 29
        Jun 2020 11:02:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518~c_4zn0Kd_1824218242eucas1p12;
        Mon, 29 Jun 2020 10:02:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200629100230eusmtrp2d3aabf143c37de217069c044b99459e5~c_4znKU1y0124201242eusmtrp2P;
        Mon, 29 Jun 2020 10:02:30 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-98-5ef9bc379f65
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.20.06017.63CB9FE5; Mon, 29
        Jun 2020 11:02:30 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629100230eusmtip24c664fc175d77af51f2ff13f8a71baa0~c_4zFV5GQ1379413794eusmtip2D;
        Mon, 29 Jun 2020 10:02:30 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/4] ARM: exynos: MCPM: Restore big.LITTLE cpuidle
 support
Date:   Mon, 29 Jun 2020 12:02:18 +0200
Message-Id: <20200629100218.6267-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629091343.GA16015@kozik-lap>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzneV3zPT/jDObPFLXYOGM9q8W8z7IW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyePP7BbvFwqYWdou1R+6yO3B6rJm3htFj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGZ8ftjEW7BeqePrsLnsD41L+LkYODgkB
        E4krDUZdjFwcQgIrGCUa5vxkhXC+MEr8W3qaBcL5zCixr62PuYuRE6zjxoFj7BCJ5YwSc/+t
        Y4Jr2fZxNjtIFZuAoUTX2y42EFtEIF3i3t8lYB3MAhOYJN4097OCJIQF/CVufzwK1sAioCqx
        9NgMMJtXwEZi+p8pbBDr5CVWbzgAtppTQF/i+rflLBDxdnaJ688kIGwXiQtrnzFB2MISr45v
        YYewZST+75wPdp2EQDOjxMNza9khnB5GictNMxghqqwl7pz7xQYKDmYBTYn1u/Qhwo4S3Rt/
        sUBCiU/ixltBkDAzkDlp23RmiDCvREebEES1msSs4+vg1h68cAkaWh4Sxzcsg4ZWE6PEizm7
        WScwys9CWLaAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYAI5/e/4px2MXy8lHWIU
        4GBU4uF1uPgjTog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0X
        vYwVEkhPLEnNTk0tSC2CyTJxcEo1MDo35Wctvtv8xorPzbHz7YS5t3ON1yq8vOzVOI9tU4Fm
        qf9l0S0HMjSWC52s7z3QsaDhX+yxxHgTiV61m2/mL8mYffum0L0J9x4vfiSVLsU69bLwyvCE
        1yUyakJRrVOf1oWwn9xXJOKypU36dUb1lkVXJtb5td5nvdstV/3bodYkQFPepyY6TomlOCPR
        UIu5qDgRAIg19uocAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xe7pme37GGay9r2WxccZ6Vot5n2Ut
        zp/fwG6x6fE1VovPvUcYLWac38dk8eb3C3aLhU0t7BZrj9xld+D0WDNvDaPHplWdbB53ru1h
        89i8pN6jb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mj4/bGMs2C9U8fTZXfYGxqX8XYycHBICJhI3Dhxj72Lk4hASWMoosfXo
        ZUaIhIzEyWkNrBC2sMSfa11sEEWfGCUOdjSwgyTYBAwlut6CJDg5RAQyJRaeuwk2iVlgCpPE
        jnc7wRLCAr4SH7eeYwKxWQRUJZYemwHWzCtgIzH9zxQ2iA3yEqs3HGAGsTkF9CWuf1vOAmIL
        CehJXP/3jHUCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgQG97djPLTsYu94FH2IU
        4GBU4uF1uPgjTog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWa
        nA+MtrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYw7bn1ijpxx
        UUaoyklzWXFa4227RdV3gq2dXu/v2a535P78O4F/NY4yzyrwmea3gElmica17qyZH7yvrpp9
        ZqH72WhL5ZVyMycKPJ62J2tvdZ9S6Y12kQU5N6omPs6a3yw9UXXOPTuxvz4v93bW9ORwa7+5
        cXVrTMa8T/W/l34xuLXpml/A/cZCJZbijERDLeai4kQA3CsDzH4CAAA=
X-CMS-MailID: 20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518
References: <20200629091343.GA16015@kozik-lap>
        <CGME20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Call exynos_cpu_power_up(cpunr) unconditionally. This is needed by the
big.LITTLE cpuidle driver and has no side-effects on other code paths.

The additional soft-reset call during little core power up has been added
to properly boot all cores on the Exynos5422-based boards with secure
firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
CPUidle driver, which worked only on boards without secure firmware (like
Peach-Pit/Pi Chromebooks). Apply the workaround only when board is
running under secure firmware.

Fixes: 833b5794e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- adjusted patch subject to better describe the change
- added a comment about exynos_cpu_power_up(cpunr) call
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

