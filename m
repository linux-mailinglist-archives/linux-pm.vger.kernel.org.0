Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB627D953
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgI2UzP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 16:55:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgI2UzP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 16:55:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B510631B;
        Tue, 29 Sep 2020 13:55:14 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB18A3F73B;
        Tue, 29 Sep 2020 13:55:12 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 0/3] condition EAS enablement on FI support
Date:   Tue, 29 Sep 2020 21:54:39 +0100
Message-Id: <20200929205442.24792-1-ionela.voinescu@arm.com>
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
 - 2/3 - arm64: rebuild scheduling and performance domains in the
         case of late, counter-driven FI initialisation.
 - 3/3 - condition EAS enablement on FI support

This series is based on linux-next 20200928. This series depends on
patches at [1] which are now in the linux-next/20200928 base.

v1 -> v2:
 - v1 can be found at [2]
 - 1/2 - moved now "static inline" rebuild_sched_domains_energy() stub
   in sched/topology.h header, as suggested by Quentin.
 - Changed the order of 2/3 and 3/3 to maintain bisection as suggested
   by Quentin.
 - 3/3 - place the warning under sched_debug() as per Quentin and
   Dietmar's recommendations.

[1] Most recent version at:
https://lore.kernel.org/lkml/20200901205549.30096-1-ionela.voinescu@arm.com/
[2] https://lore.kernel.org/lkml/20200924123937.20938-1-ionela.voinescu@arm.com/

Many thanks,
Ionela.

Ionela Voinescu (3):
  sched/topology,schedutil: wrap sched domains rebuild
  arm64: rebuild sched domains on invariance status changes
  sched/topology: condition EAS enablement on FIE support

 arch/arm64/kernel/topology.c     | 10 ++++++++++
 include/linux/sched/topology.h   |  8 ++++++++
 kernel/sched/cpufreq_schedutil.c |  9 +--------
 kernel/sched/topology.c          | 27 ++++++++++++++++++++-------
 4 files changed, 39 insertions(+), 15 deletions(-)


base-commit: 663b07a45f972c23ac315fd690874bc00977fe99
-- 
2.17.1

