Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474672107AD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgGAJJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:55 -0400
Received: from foss.arm.com ([217.140.110.172]:47936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbgGAJJu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2FE01424;
        Wed,  1 Jul 2020 02:09:49 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE3533F68F;
        Wed,  1 Jul 2020 02:09:47 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] cpufreq: make schedutil the default for arm and arm64
Date:   Wed,  1 Jul 2020 10:07:51 +0100
Message-Id: <20200701090751.7543-9-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

schedutil is already a hard-requirement for EAS, which has lead to making
it default on arm (when CONFIG_BIG_LITTLE), see:

  commit 8fdcca8e254a ("cpufreq: Select schedutil when using big.LITTLE")

One thing worth pointing out is that schedutil isn't only relevant for
asymmetric CPU capacity systems; for instance, schedutil is the only
governor that honours util-clamp performance requests. Another good example
of this is x86 switching to using it by default in:

  commit a00ec3874e7d ("cpufreq: intel_pstate: Select schedutil as the default governor")

Arguably it should be made the default for all architectures, but it seems
better to wait for them to also gain frequency invariance powers. Make it
the default for arm && arm64 for now.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index e91750132552..2c7171e0b001 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -37,7 +37,7 @@ config CPU_FREQ_STAT
 choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if BIG_LITTLE
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
 	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
-- 
2.17.1

