Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E2231FB1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2N6t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 09:58:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2N6t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 09:58:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7721430E;
        Wed, 29 Jul 2020 06:58:48 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E4F93F66E;
        Wed, 29 Jul 2020 06:58:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>
Subject: [PATCH] arm, arm64: Fix selection of CONFIG_SCHED_THERMAL_PRESSURE
Date:   Wed, 29 Jul 2020 14:57:18 +0100
Message-Id: <20200729135718.1871-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qian reported that the current setup forgoes the Kconfig dependencies and
results in warnings such as:

  WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
    Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
    Selected by [y]:
    - ARM64 [=y]

Revert commit

  e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")

and re-implement it by making the option default to 'y' for arm64 and arm,
which respects Kconfig dependencies (i.e. will remain 'n' if
CPU_FREQ_THERMAL=n).

Fixes: e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/Kconfig   | 1 -
 arch/arm64/Kconfig | 1 -
 init/Kconfig       | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6cd0f9f086f6..809e8047d669 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -47,7 +47,6 @@ config ARM
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
-	select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2d4abbc9f8d0..baffe8b66da2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,7 +192,6 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
-	select SCHED_THERMAL_PRESSURE
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/init/Kconfig b/init/Kconfig
index 37b089f87804..f2244892d7a8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -493,6 +493,8 @@ config HAVE_SCHED_AVG_IRQ
 
 config SCHED_THERMAL_PRESSURE
 	bool
+	default y if ARM && ARM_CPU_TOPOLOGY
+	default y if ARM64
 	depends on SMP
 	depends on CPU_FREQ_THERMAL
 	help
-- 
2.27.0

