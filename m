Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7514ABCD
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 22:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA0VzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 16:55:25 -0500
Received: from foss.arm.com ([217.140.110.172]:49542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgA0VzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jan 2020 16:55:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C957B101E;
        Mon, 27 Jan 2020 13:55:24 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 214493F68E;
        Mon, 27 Jan 2020 13:55:18 -0800 (PST)
From:   lukasz.luba@arm.com
To:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH 1/3] ARM: exynos_defconfig: Enable SCHED_MC
Date:   Mon, 27 Jan 2020 21:54:51 +0000
Message-Id: <20200127215453.15144-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127215453.15144-1-lukasz.luba@arm.com>
References: <20200127215453.15144-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Since the 'capacities-dmips-mhz' are present in the CPU nodes, make use of
this knowledge in smarter decisions during scheduling.

The values in 'capacities-dmips-mhz' are normilized, this means that i.e.
when CPU0's capacities-dmips-mhz=100 and CPU1's 'capacities-dmips-mhz'=50,
cpu0 is twice fast as CPU1, at the same frequency. The proper hirarchy
in sched_domain topology could exploit the SoC architecture advantages
like big.LITTLE. Enabling the SCHED_MC will create two levels in
sched_domain hierarchy, which might be observed in:

grep . /proc/sys/kernel/sched_domain/cpu*/domain*/{name,flags}
/proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
/proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE
...
/proc/sys/kernel/sched_domain/cpu0/domain0/flags:575
/proc/sys/kernel/sched_domain/cpu0/domain1/flags:4223

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e7e4bb5ad8d5..1db857056992 100644
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
-- 
2.17.1

