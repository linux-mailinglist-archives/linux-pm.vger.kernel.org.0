Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE5277130
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgIXMkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:40:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgIXMkD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:40:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391B2113E;
        Thu, 24 Sep 2020 05:40:02 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 701B03F73B;
        Thu, 24 Sep 2020 05:40:00 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 0/3] condition EAS enablement on FI support
Date:   Thu, 24 Sep 2020 13:39:34 +0100
Message-Id: <20200924123937.20938-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Given the maturity gained by cpufreq-based Frequency Invariance (FI)
support following the patches at [1], this series conditions Energy
Aware Scheduling (EAS) enablement on a frequency invariant system.

Currently, EAS can be enabled on a system without FI support, leading
to incorrect (energy-wise) task placements. As no warning is emitted,
it could take some debugging effort to track the behavior back to the
lack of FI support; this series changes that by disabling EAS
(and advertising it) when FI support is missing.

The series is structured as follows:
 - 1/3 - create function that can rebuild the scheduling and EAS'
   performance domains if EAS' initial conditions change
 - 2/3 - condition EAS enablement on FI support
 - 3/3 - arm64: rebuild scheduling and performance domains in the
         case of late, counter-driven FI initialisation.

This series is dependent on the patches at [1] and based on linux-next
20200918.

[1] Most recent version at:
https://lore.kernel.org/lkml/20200901205549.30096-1-ionela.voinescu@arm.com/

Ionela Voinescu (3):
  sched/topology,schedutil: wrap sched domains rebuild
  sched/topology: condition EAS enablement on FIE support
  arm64: rebuild sched domains on invariance status changes

 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      | 10 ++++++++++
 include/linux/sched/topology.h    |  1 +
 kernel/sched/cpufreq_schedutil.c  |  9 +--------
 kernel/sched/topology.c           | 26 +++++++++++++++++++-------
 5 files changed, 32 insertions(+), 15 deletions(-)


base-commit: b652d2a5f2a4e93d803cc33eb57fdc41ee528500
prerequisite-patch-id: 592324cdfe0735a845d827d23f4d042b66e480ae
prerequisite-patch-id: b232a586616b573b7fc320df2dcf4783f26dc169
prerequisite-patch-id: 8a8238e55f4e522eb0ee44c1d4a083cac019959a
prerequisite-patch-id: 8edd7fc97f15c7f737339d3e07dbcd6c6d99d986
prerequisite-patch-id: b24b28cd2ec4c929b770f5dd3eeb30f839f8d6ab
-- 
2.17.1

