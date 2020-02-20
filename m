Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67400165AA5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBTJ5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 04:57:03 -0500
Received: from foss.arm.com ([217.140.110.172]:39232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgBTJ5D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 04:57:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8236930E;
        Thu, 20 Feb 2020 01:57:02 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7E613F703;
        Thu, 20 Feb 2020 01:56:58 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [RESEND PATCH v2 2/2] ARM: exynos_defconfig: Enable SCHED_MC and ENERGY_MODEL
Date:   Thu, 20 Feb 2020 09:56:36 +0000
Message-Id: <20200220095636.29469-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095636.29469-1-lukasz.luba@arm.com>
References: <20200220095636.29469-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) is needed to run Energy Aware Scheduler (EAS).
Enable ENERGY_MODEL to make that happen. This will increase energy
efficiency of the big.LITTLE platform by smart decisions in scheduling
tasks in non-heavy workloads.

Add SCHED_MC in order to create another level in scheduling domains: 'MC'.
This improves scheduler's decisions on platforms with CPU clusters, such
as big.LITTLE.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c8e0c14092e8..90d376eb333b 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -8,6 +8,7 @@ CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y
 CONFIG_SMP=y
+CONFIG_SCHED_MC=y
 CONFIG_BIG_LITTLE=y
 CONFIG_NR_CPUS=8
 CONFIG_HIGHMEM=y
@@ -17,6 +18,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_ENERGY_MODEL=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-- 
2.17.1

