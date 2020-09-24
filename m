Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97407277105
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIXMao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:30:44 -0400
Received: from foss.arm.com ([217.140.110.172]:44598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgIXMao (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:30:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9515113E;
        Thu, 24 Sep 2020 05:30:43 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DC063F73B;
        Thu, 24 Sep 2020 05:30:42 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH 0/2]cpufreq,topology,arm: disable FI for BL_SWITCHER
Date:   Thu, 24 Sep 2020 13:30:14 +0100
Message-Id: <20200924123016.13427-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series is the result of the discussions ([1], [2]) around the
complications that the BL_SWITCHER poses when it comes to Frequency
Invariance (FI) and it aims to restart the discussions.

To properly scale its per-entity load-tracking signals, the task
scheduler needs to be given a frequency scale factor, i.e. some image of
the current frequency the CPU is running at, relative to its maximum
frequency.

But (reiterating the message in the changelog of patch 2/2), big.LITTLE
switching complicates the setting of a correct cpufreq-based frequency
invariance scale factor due to (as observed in
drivers/cpufreq/vexpress-spc-cpufreq.c):
 - Incorrect current and maximum frequencies as a result of the
   exposure of a virtual frequency table to the cpufreq core,
 - Missed updates as a result of asynchronous frequency adjustments
   caused by frequency changes in other CPU pairs.
More information on this feature can be found at [3].

Given that its functionality is atypical in regards to FI and that this
is an old technology, patch 2/2 disable FI for when big.LITTLE switching
is configured in to prevent incorrect scale setting.

For this purpose patch 1/2 changes the way arch_set_freq_scale() is
defined in architecture code which brings it in line with the logic of
other architectural function definitions while allowing for less invasive
filtering of FI support.

In the discussions at [2], three possible solutions were suggested:
 - (1) conditioning FI by !CONFIG_BL_SWITCHER
 - (2) leave as is with note in driver specifying this FI broken
   functionality
 - (3) removing full BL_SWITCHER support

This series restructures the solution at (1). The reason for it is that
the new patch limits the ifdef filtering to the arm topology include file,
a location where frequency invariance functions are defined. Therefore,
this seems more appropriate given that the b.L switcher is an arm
technology and that the new FI filtering location seems more natural for
conditioned FI disabling.

Solutions (2) and (3) were not implemented given that there might be some
remaining users of this technology (Samsung Chromebook 2 - Samsung Exynos
5 Octa 5420, Samsung Exynos 5 Octa 5800) and therefore leaving this
broken (2) seems equally bad to removing support for it (3).

[1] https://lore.kernel.org/lkml/20200701090751.7543-5-ionela.voinescu@arm.com/
[2] https://lore.kernel.org/lkml/20200722093732.14297-4-ionela.voinescu@arm.com/
[3] https://lwn.net/Articles/481055/

Many thanks,
Ionela.


Ionela Voinescu (2):
  cpufreq,arm,arm64: restructure definitions of arch_set_freq_scale()
  arm: disable frequency invariance for CONFIG_BL_SWITCHER

 arch/arm/include/asm/topology.h   |  4 ++++
 arch/arm64/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      |  4 ++--
 drivers/cpufreq/cpufreq.c         |  7 -------
 include/linux/arch_topology.h     |  2 ++
 include/linux/cpufreq.h           | 11 ++++++++---
 6 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.17.1

