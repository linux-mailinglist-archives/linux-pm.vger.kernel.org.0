Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F744229515
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgGVJiJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 05:38:09 -0400
Received: from foss.arm.com ([217.140.110.172]:52972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVJiJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jul 2020 05:38:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F932101E;
        Wed, 22 Jul 2020 02:38:08 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B09853F66F;
        Wed, 22 Jul 2020 02:38:06 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, linux@armlinux.org.uk
Cc:     mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 0/7] cpufreq: improve frequency invariance support
Date:   Wed, 22 Jul 2020 10:37:25 +0100
Message-Id: <20200722093732.14297-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

Please find below the changes to this series:

v1 -> v2:
 - v1 can be found at [1]
 - No cpufreq flags are introduced
 - Previous patches 2/8 and 3/8 were squashed in this series under 1/7,
   to ensure bisection.
 - 2/7 was introduced as a proposal for Viresh's suggestion to use
   policy->cur in the call to arch_set_freq_scale() and is extended to
   support drivers that implement the target() callback as well
 - Additional commit message changes are added to 1/7 and 2/7, to
   clarify that the definition of arch_set_freq_scale() will filter 
   settings of the scale factor, if unwanted
 - 3/7 disables setting of the scale factor for
   CONFIG_BL_SWITCHER, as Dietmar suggested
 - Small change introduced in 4/7 to disable cpufreq-based frequency
   invariance for the users of the default arch_set_freq_scale() call
   which will not actually set a scale factor
 - build issue solved (reported by 0day test)
 - v2 is based on linux-next 20200716
 - all functional tests in v1 were repeated for v2

[1] https://lore.kernel.org/lkml/20200701090751.7543-1-ionela.voinescu@arm.com/


Let me know what you think!

Thank you,
Ionela.

Ionela Voinescu (3):
  cpufreq: set invariance scale factor on transition end
  arch_topology: disable frequency invariance for CONFIG_BL_SWITCHER
  cpufreq: report whether cpufreq supports Frequency Invariance (FI)

Valentin Schneider (4):
  cpufreq: move invariance setter calls in cpufreq core
  arch_topology,cpufreq,sched/core: constify arch_* cpumasks
  arch_topology,arm,arm64: define arch_scale_freq_invariant()
  cpufreq: make schedutil the default for arm and arm64

 arch/arm/include/asm/topology.h        |  1 +
 arch/arm64/include/asm/topology.h      |  1 +
 arch/arm64/kernel/topology.c           |  9 ++++-
 drivers/base/arch_topology.c           | 12 +++++--
 drivers/cpufreq/Kconfig                |  2 +-
 drivers/cpufreq/cpufreq-dt.c           | 10 +-----
 drivers/cpufreq/cpufreq.c              | 46 ++++++++++++++++++++++++--
 drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +----
 drivers/cpufreq/scmi-cpufreq.c         | 12 ++-----
 drivers/cpufreq/scpi-cpufreq.c         |  6 +---
 drivers/cpufreq/vexpress-spc-cpufreq.c |  5 ---
 include/linux/arch_topology.h          |  6 ++--
 include/linux/cpufreq.h                |  8 ++++-
 kernel/sched/core.c                    |  2 +-
 14 files changed, 81 insertions(+), 48 deletions(-)


base-commit: 4c43049f19a280329c1d01699f3cc8ad6910cbbe
-- 
2.17.1

