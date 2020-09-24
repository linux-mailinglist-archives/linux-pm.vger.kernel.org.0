Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01053277109
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgIXMaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:30:55 -0400
Received: from foss.arm.com ([217.140.110.172]:44636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgIXMay (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:30:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566EB113E;
        Thu, 24 Sep 2020 05:30:54 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C202A3F73B;
        Thu, 24 Sep 2020 05:30:52 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH 2/2] arm: disable frequency invariance for CONFIG_BL_SWITCHER
Date:   Thu, 24 Sep 2020 13:30:16 +0100
Message-Id: <20200924123016.13427-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924123016.13427-1-ionela.voinescu@arm.com>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

big.LITTLE switching complicates the setting of a correct cpufreq-based
frequency invariance scale factor due to (as observed in
drivers/cpufreq/vexpress-spc-cpufreq.c):
 - Incorrect current and maximum frequencies as a result of the
   exposure of a virtual frequency table to the cpufreq core,
 - Missed updates as a result of asynchronous frequency adjustments
   caused by frequency changes in other CPU pairs.

Given that its functionality is atypical in regards to frequency
invariance and this is an old technology, disable frequency
invariance for when big.LITTLE switching is configured in to prevent
incorrect scale setting.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index e5e3d5ce4d55..470299ee2fba 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -7,10 +7,13 @@
 #include <linux/cpumask.h>
 #include <linux/arch_topology.h>
 
+/* big.LITTLE switcher is incompatible with frequency invariance */
+#ifndef CONFIG_BL_SWITCHER
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#endif
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
-- 
2.17.1

