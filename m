Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB001A5C35
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDLDcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:32:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55192 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgDLDcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:32:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 7692C20D01;
        Sun, 12 Apr 2020 03:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586661775; bh=Z4RAigTBiOP7VvrfTLiBE6exmQIE7e1mafncBvapIM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/40V0UJINdoLfz3CVg+vOTwg/UlBNYosFwSbKUPg+0bUj1Nr7BmT5c+H+R3qFWO7
         woPslrmOU1yrBoNztw3F6/JPqb5XcziGGOUMrjCdSOmV3UR5ubuZVeqxG5mZ0Ez7tD
         7P+ccYAJtXVbB5pisjQT/Z7KR8k6JTqfYWnNo6T7GwHdCSsw3wvBWQavMGjeMGl0Dk
         dQYSWHqYFCWRqVmUu8SlffBHQ1IrlzuaiA+Us23y/ENJq8VQKrsSNbpd4eKu6Ts/Uq
         HEhtagU/Sn58L2tKtG5b+8UfuP0aZBqQ5BWZwEBePewzivfyt4wZSKwtgAeELa8yML
         Jib2DP7XRlyZQ==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/11] MIPS: Topology & DeviceTree CPU rework v2
Date:   Sun, 12 Apr 2020 11:20:30 +0800
Message-Id: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: 20200408113505.2528103-1-jiaxun.yang@flygoat.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This set mainly added DeviceTree based CPU probe support and reworked
topology handling for MIPS. In order to prepare for pure DeviceTree
boot for Loongson64. It can also convinient Yanjie's Inegnic jz4780/X2000
SMP/SMT support.

I've done build test for bmips, nlm, ip27 and boot test for malta with
34Kf, I6400 in QEMU, Loongson64 on a Loongson-3B1500 real machine.

Thanks.

v2:
  - Fixes

Jiaxun Yang (11):
  MIPS: setup: Drop prefill_possible_map
  MIPS: prom: Add helper to parse CPU node in dt
  arch_topology: Make it avilable for MIPS
  arch_topology: Reset all cpus in reset_cpu_topology
  MIPS: Switch to arch_topology
  MIPS: Kernel: Switch to new topology interface
  MIPS: CPS & MT: Switch to new topology interface
  irqchip: mips-cpu: Switch to new topology interface
  MIPS: bmips: Switch to new topology interface
  MIPS: nlm: Switch to new topology interface
  MIPS: Loongson64: Switch to new topology interface

 arch/mips/Kconfig                             |   1 +
 arch/mips/include/asm/cpu-info.h              |  49 --------
 arch/mips/include/asm/mach-ip27/mmzone.h      |   2 +
 arch/mips/include/asm/mach-ip27/topology.h    |   2 +
 .../include/asm/mach-loongson64/topology.h    |   2 +
 arch/mips/include/asm/mips-cm.h               |   9 +-
 arch/mips/include/asm/mips-cps.h              |   2 +
 arch/mips/include/asm/prom.h                  |   6 +
 arch/mips/include/asm/smp-ops.h               |   2 -
 arch/mips/include/asm/smp.h                   |   2 -
 arch/mips/include/asm/sn/addrs.h              |   1 +
 arch/mips/include/asm/topology.h              |  68 +++++++++-
 arch/mips/kernel/cacheinfo.c                  |  19 +--
 arch/mips/kernel/cpu-probe.c                  |  43 -------
 arch/mips/kernel/mips-cm.c                    |   4 +-
 arch/mips/kernel/mips-cpc.c                   |   4 +-
 arch/mips/kernel/perf_event_mipsxx.c          |   4 +-
 arch/mips/kernel/pm-cps.c                     |  12 +-
 arch/mips/kernel/proc.c                       |   8 +-
 arch/mips/kernel/prom.c                       |  97 ++++++++++++++
 arch/mips/kernel/setup.c                      |  22 +---
 arch/mips/kernel/smp-bmips.c                  |   3 +-
 arch/mips/kernel/smp-cmp.c                    |   5 +-
 arch/mips/kernel/smp-cps.c                    |  41 +++---
 arch/mips/kernel/smp-mt.c                     |   3 +-
 arch/mips/kernel/smp.c                        |  55 +-------
 arch/mips/kernel/topology.c                   |  42 +++++++
 arch/mips/loongson64/smp.c                    |  20 +--
 arch/mips/mm/c-r4k.c                          |   4 +-
 arch/mips/mm/context.c                        |   4 +-
 arch/mips/netlogic/common/smp.c               |   4 +-
 arch/mips/oprofile/op_model_mipsxx.c          |   4 +-
 drivers/base/arch_topology.c                  | 118 +++++++++---------
 drivers/cpuidle/cpuidle-cps.c                 |   3 +-
 drivers/irqchip/irq-mips-cpu.c                |   2 +-
 35 files changed, 361 insertions(+), 306 deletions(-)

-- 
2.26.0.rc2

