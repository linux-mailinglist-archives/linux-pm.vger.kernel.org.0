Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF72F941
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfE3JUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 05:20:48 -0400
Received: from foss.arm.com ([217.140.101.70]:32998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfE3JUr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 05:20:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD60A78;
        Thu, 30 May 2019 02:20:47 -0700 (PDT)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FED33F59C;
        Thu, 30 May 2019 02:20:44 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quentin.perret@arm.com
Subject: [PATCH v5 0/3] Make IPA use PM_EM
Date:   Thu, 30 May 2019 10:20:35 +0100
Message-Id: <20190530092038.12020-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v5:
**************
 - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
   appropriate ifdefery (Daniel)
 - Rebased on 5.2-rc2

Changes in v4:
**************
 - Added Viresh's Acked-by to all 3 patches
 - Improved commit message of patch 3/3 to explain how it has no
   functional impact on existing users (Eduardo)

Changes in v3:
**************
 - Changed warning message for unordered tables to something more
   explicit (Viresh)
 - Changed WARN() into a pr_err() for consistency

Changes in v2:
**************
 - Fixed patch 01/03 to actually enable CONFIG_ENERGY_MODEL
 - Added "depends on ENERGY_MODEL" to IPA (Daniel)
 - Added check to bail out if the freq table is unsorted (Viresh)

Cover letter:
*************

The Intelligent Power Allocator (IPA) thermal governor uses an Energy
Model (or EM) of the CPUs to re-distribute the power budget. To do so,
it builds a table of <frequency, power> tuples where the power values
are computed using the 'dynamic-power-coefficient' DT property. All of
this is done in and only for the thermal subsystem, and more
specifically for CPUs -- the power of other types of devices is obtained
differently.

Recently, the CPU scheduler has seen the introduction of Energy Aware
Scheduling (EAS) patches, which also rely on an EM of the CPUs. This EM,
however, is managed by an independent framework, called PM_EM, aimed to
be used by all kernel subsystems interested in the power consumed by
CPUs, and not only the scheduler.

This patch series follows this logic and removes the (now redundant)
thermal-specific EM computation code to migrate IPA to use PM_EM
instead.

Doing so should have no visible functional impact for existing users of
IPA since:

 - during the 5.1 development cycle, a series of patches [1] introduced
   in PM_OPP some infrastructure (dev_pm_opp_of_register_em()) enabling
   the registration of EMs in PM_EM using the DT property used by IPA;

 - the existing upstream cpufreq drivers marked with the
   'CPUFREQ_IS_COOLING_DEV' flag all call dev_pm_opp_of_register_em(),
   which means they all support PM_EM (the only two exceptions are
   qoriq-cpufreq which doesn't in fact use an EM and scmi-cpufreq which
   already supports PM_EM without using the PM_OPP infrastructurei
   because it read power costs directly from firmware);

So, migrating IPA to using PM_EM should effectively be just plumbing
since for the existing IPA users the PM_EM tables will contain the
exact same power values that IPA used to compute on its own until now.
The only new dependency is to compile in CONFIG_ENERGY_MODEL.

Why is this migration still a good thing ? For three main reasons.

 1. it removes redundant code;

 2. it introduces an abstraction layer between IPA and the EM
    computation. PM_EM offers to EAS and IPA (and potentially other
    clients) standardized EM tables and hides 'how' these tables have
    been obtained. PM_EM as of now supports power values either coming
    from the 'dynamic-power-coefficient' DT property or obtained
    directly from firmware using SCMI. The latter is a new feature for
    IPA and that comes 'for free' with the migration. This will also be
    true in the future every time PM_EM gets support for other ways of
    loading the EM. Moreover, PM_EM is documented and has a debugfs
    interface which should help adding support for new platforms.

 3. it builds a consistent view of the EM of CPUs across kernel
    subsystems, which is a pre-requisite for any kind of future work
    aiming at a smarter power allocation using scheduler knowledge about
    the system for example.

[1] https://lore.kernel.org/lkml/20190204110952.16025-1-quentin.perret@arm.com/


Quentin Perret (3):
  arm64: defconfig: Enable CONFIG_ENERGY_MODEL
  thermal: cpu_cooling: Make the power-related code depend on IPA
  thermal: cpu_cooling: Migrate to using the EM framework

 arch/arm64/configs/defconfig  |   1 +
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 428 ++++++++++++++--------------------
 3 files changed, 178 insertions(+), 252 deletions(-)

-- 
2.21.0

