Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446F21CA82
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jul 2020 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgGLQ7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jul 2020 12:59:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgGLQ7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Jul 2020 12:59:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9299D30E;
        Sun, 12 Jul 2020 09:59:31 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B043E3F7D8;
        Sun, 12 Jul 2020 09:59:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2 0/3] sched, arch_topology: Thermal pressure configuration cleanup
Date:   Sun, 12 Jul 2020 17:59:14 +0100
Message-Id: <20200712165917.9168-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

This stems from this thread [1] on the list. TL;DR: the thermal pressure config
has no helpful documentation, and figuring out if the right dependencies are in
place is not easy for a regular user. 

The current landscape also paints an odd picture: arch_set_thermal_pressure() is
hardcoded in sched/core.c, and is *not* architecture-definable, while
arch_get_thermal_pressure() is. Patch 1 is tackling this, the rest is Kconfig
stuff.

Cheers,
Valentin

[1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk

Revisions
=========

v1 -> v2
--------

o Remove cpufreq_cooling.c weak function; use #define stub in sched/topology.h
  (Vincent)
o Hinge arm SCHED_THERMAL_PRESSURE selection on ARM_CPU_TOPOLOGY

Valentin Schneider (3):
  arch_topology, sched/core: Cleanup thermal pressure definition
  sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
  arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE

 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/topology.h   |  3 ++-
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/topology.h |  3 ++-
 drivers/base/arch_topology.c      | 11 +++++++++++
 include/linux/arch_topology.h     |  4 ++--
 include/linux/sched/topology.h    |  7 +++++++
 init/Kconfig                      | 15 ++++++++++++++-
 kernel/sched/core.c               | 11 -----------
 9 files changed, 40 insertions(+), 16 deletions(-)

--
2.27.0

