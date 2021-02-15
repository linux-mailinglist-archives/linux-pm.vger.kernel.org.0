Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D031C1DE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 19:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhBOSp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 13:45:57 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44364 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhBOSox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 13:44:53 -0500
Received: by mail-oi1-f179.google.com with SMTP id r75so8683437oie.11;
        Mon, 15 Feb 2021 10:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DDCV8C+Jq3CN6OdY1fHK7NOVkMPNMGAd4t2cTCfawEA=;
        b=nE9JzU0WK3csyXPJNZ8EBNXh/P8lXGQRsIbbio51rmBsq7B6Vb80vMsecOWvHsYjZY
         O8VkbvYL0YMMEt6X8FTAd192Deu3z5qUXCaOCpCcdkvIFlMBrsbtYxJk7RoSPzcbPIi8
         1Dv+5JZOPd4ya0XftdqM3ES37eENXMZvUGhkGIV5wUTZSXgA5eB4e4y48Xc+uJoC2v6Z
         dLeZ7/72byWHg7CaTwN/wyoT88TMBnwtT+5uUN2gEdHRd42XUbE6J3CMzx5uni4aaKNV
         bS6gXhnO++Lm9l1QOoRiNGVElDUWCjDK5e8f5qzDJQ5KTy0jNEg+VMJo3Q6XEBhU2HG6
         Sr+A==
X-Gm-Message-State: AOAM531s2cKQcbRh0zKJFCYXzDkdjvq0k0qwZCPSoSHlcnKlhhIP/Ka+
        NlQ8XThjG0hB7Ms+7z3vmjT7Jljn8OS4QPR83iDQ2kZUAng=
X-Google-Smtp-Source: ABdhPJxFnrDffc2yGMOcMsm8RKI4WDjbZkd7+c3ldKXSDcDw5/03xXd1/o3JKXNLQcGMh+StG8CAfBR5R39RDPSEkDg=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr171782oij.69.1613414650563;
 Mon, 15 Feb 2021 10:44:10 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Feb 2021 19:43:59 +0100
Message-ID: <CAJZ5v0jG3apd6f6zsyd4JeGJ5cK14DMQJAmNx5jrnMtMiXhQDw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.12-rc1

with top-most commit a9a939cb34dfffb9f43b988a681d2566ca157b74

 Merge branches 'powercap' and 'pm-misc'

on top of commit d11a1d08a082a7dc0ada423d2b2e26e9b6f2525c

 cpufreq: ACPI: Update arch scale-invariance max perf ratio if CPPC is not there

to receive power management updates for 5.12-rc1.

These add a new power capping facility allowing aggregate power
constraints to be applied to sets of devices in a distributed manner,
add a new CPU ID to the RAPL power capping driver and improve it,
drop a cpufreq driver belonging to a platform that is not supported
any more, drop two redundant cpufreq driver flags, update cpufreq
drivers (intel_pstate, brcmstb-avs, qcom-hw), update the operating
performance points (OPP) framework (code cleanups, new helpers,
devfreq-related modifications), clean up devfreq, extend the PM
clock layer, update the cpupower utility and make assorted janitorial
changes.

Specifics:

 - Add new power capping facility called DTPM (Dynamic Thermal Power
   Management), based on the existing power capping framework, to
   allow aggregate power constraints to be applied to sets of devices
   in a distributed manner, along with a CPU backend driver based on
   the Energy Model (Daniel Lezcano, Dan Carpenter, Colin Ian King).

 - Add AlderLake Mobile support to the Intel RAPL power capping
   driver and make it use the topology interface when laying out the
   system topology (Zhang Rui, Yunfeng Ye).

 - Drop the cpufreq tango driver belonging to a platform that is not
   supported any more (Arnd Bergmann).

 - Drop the redundant CPUFREQ_STICKY and CPUFREQ_PM_NO_WARN cpufreq
   driver flags (Viresh Kumar).

 - Update cpufreq drivers:

   * Fix max CPU frequency discovery in the intel_pstate driver and
     make janitorial changes in it (Chen Yu, Rafael Wysocki, Nigel
     Christian).

   * Fix resource leaks in the brcmstb-avs-cpufreq driver (Christophe
     JAILLET).

   * Make the tegra20 driver use the resource-managed API (Dmitry
     Osipenko).

   * Enable boost support in the qcom-hw driver (Shawn Guo).

 - Update the operating performance points (OPP) framework:

   * Clean up the OPP core (Dmitry Osipenko, Viresh Kumar).

   * Extend the OPP API by adding new helpers to it (Dmitry Osipenko,
     Viresh Kumar).

   * Allow required OPPs to be used for devfreq devices and update
     the devfreq governor code accordingly (Saravana Kannan).

   * Prepare the framework for introducing new dev_pm_opp_set_opp()
     helper (Viresh Kumar).

   * Drop dev_pm_opp_set_bw() and update related drivers (Viresh
     Kumar).

   * Allow lazy linking of required-OPPs (Viresh Kumar).

 - Simplify and clean up devfreq somewhat (Lukasz Luba, Yang Li,
   Pierre Kuo).

 - Update the generic power domains (genpd) framework:

   * Use device's next wakeup to determine domain idle state (Lina
     Iyer).

   * Improve initialization and debug (Dmitry Osipenko).

   * Simplify computations (Abaci Team).

 - Make janitorial changes in the core code handling system sleep
   and PM-runtime (Bhaskar Chowdhury, Bjorn Helgaas, Rikard Falkeborn,
   Zqiang).

 - Update the MAINTAINERS entry for the exynos cpuidle driver and
   drop DEBUG definition from intel_idle (Krzysztof Kozlowski, Tom
   Rix).

 - Extend the PM clock layer to cover clocks that must sleep (Nicolas
   Pitre).

 - Update the cpupower utility:

   * Update cpupower command, add support for AMD family 0x19 and clean
     up the code to remove many of the family checks to make future
     family updates easier (Nathan Fontenot, Robert Richter).

   * Add Makefile dependencies for install targets to allow building
     cpupower in parallel rather than serially (Ivan Babrou).

 - Make janitorial changes in power management Kconfig (Lukasz Luba).

Thanks!


---------------

Abaci Team (1):
      PM: domains: Simplify the calculation of variables

Arnd Bergmann (1):
      cpufreq: remove tango driver

Bhaskar Chowdhury (1):
      PM: runtime: Fix resposible -> responsible in runtime.c

Bjorn Helgaas (2):
      PM: sleep: Use dev_printk() when possible
      PM: runtime: Fix typos and grammar

Chen Yu (1):
      cpufreq: intel_pstate: Get per-CPU max freq via
MSR_HWP_CAPABILITIES if available

Christophe JAILLET (2):
      cpufreq: brcmstb-avs-cpufreq: Free resources in error path
      cpufreq: brcmstb-avs-cpufreq: Fix resource leaks in ->remove()

Colin Ian King (1):
      powercap/drivers/dtpm: Fix size of object being allocated

Dan Carpenter (3):
      powercap/drivers/dtpm: Fix a double shift bug
      powercap/drivers/dtpm: Fix some missing unlock bugs
      powercap/drivers/dtpm: Fix an IS_ERR() vs NULL check

Daniel Lezcano (5):
      units: Add Watt units
      Documentation/powercap/dtpm: Add documentation for dtpm
      powercap/drivers/dtpm: Add API for dynamic thermal power management
      powercap/drivers/dtpm: Add CPU energy model based support
      powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod
unresolved symbols

Dmitry Osipenko (15):
      cpufreq: tegra20: Use resource-managed API
      PM: domains: Make set_performance_state() callback optional
      PM: domains: Make of_genpd_add_subdomain() return -EPROBE_DEFER
      PM: domains: Add "performance" column to debug summary
      opp: Fix adding OPP entries in a wrong order if rate is unavailable
      opp: Filter out OPPs based on availability of a required-OPP
      opp: Correct debug message in _opp_add_static_v2()
      opp: Add dev_pm_opp_find_level_ceil()
      opp: Add dev_pm_opp_get_required_pstate()
      opp: Add dev_pm_opp_sync_regulators()
      opp: Add devm_pm_opp_register_set_opp_helper
      opp: Add devm_pm_opp_attach_genpd
      opp: Handle missing OPP table in dev_pm_opp_xlate_performance_state()
      opp: Print OPP level in debug message of _opp_add_static_v2()
      opp: Make _set_opp_custom() work without regulators

Ivan Babrou (1):
      cpupower: add Makefile dependencies for install targets

Krzysztof Kozlowski (1):
      MAINTAINERS: cpuidle: exynos: include header in file pattern

Lina Iyer (2):
      PM: domains: inform PM domain of a device's next wakeup
      PM: domains: use device's next wakeup to determine domain idle state

Lukasz Luba (3):
      PM / devfreq: Correct spelling in a comment
      PM: EM: update Kconfig description and drop "default n" option
      PM: Kconfig: remove unneeded "default n" options

Nathan Fontenot (7):
      cpupower: Update msr_pstate union struct naming
      cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
      cpupower: Remove unused pscur variable.
      cpupower: Update family checks when decoding HW pstates
      cpupower: Condense pstate enabled bit checks in decode_pstates()
      cpupower: Remove family arg to decode_pstates()
      cpupower: Add cpuid cap flag for MSR_AMD_HWCR support

Nicolas Pitre (1):
      PM: clk: make PM clock layer compatible with clocks that must sleep

Nigel Christian (1):
      cpufreq: intel_pstate: Remove repeated word

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Always read hwp_cap_cached with READ_ONCE()
      cpufreq: intel_pstate: Change intel_pstate_get_hwp_max() argument
      cpufreq: intel_pstate: Rename two functions

Rikard Falkeborn (1):
      PM: sleep: Constify static struct attribute_group

Robert Richter (1):
      cpupower: Correct macro name for CPB caps flag

Saravana Kannan (3):
      OPP: Add function to look up required OPP's for a given OPP
      PM / devfreq: Cache OPP table reference in devfreq
      PM / devfreq: Add required OPPs support to passive governor

Shawn Guo (1):
      cpufreq: qcom-hw: enable boost support

Tom Rix (1):
      intel_idle: remove definition of DEBUG

Viresh Kumar (25):
      opp: Staticize _add_opp_table()
      opp: Create _of_add_table_indexed() to reduce code duplication
      opp: Defer acquiring the clk until OPPs are added
      opp: Add dev_pm_opp_of_add_table_noclk()
      opp: Prepare for ->set_opp() helper to work without regulators
      opp: Rename _opp_set_rate_zero()
      opp: No need to check clk for errors
      opp: Keep track of currently programmed OPP
      opp: Split _set_opp() out of dev_pm_opp_set_rate()
      opp: Allow _set_opp() to work for non-freq devices
      opp: Allow _generic_set_opp_regulator() to work for non-freq devices
      opp: Allow _generic_set_opp_clk_only() to work for non-freq devices
      opp: Update parameters of  _set_opp_custom()
      opp: Implement dev_pm_opp_set_opp()
      cpufreq: qcom: Migrate to dev_pm_opp_set_opp()
      drm: msm: Migrate to dev_pm_opp_set_opp()
      devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
      opp: Remove dev_pm_opp_set_bw()
      opp: Allow lazy-linking of required-opps
      opp: Update bandwidth requirements based on scaling up/down
      opp: Don't ignore clk_get() errors other than -ENOENT
      opp: Fix "foo * bar" should be "foo *bar"
      opp: Replace ENOTSUPP with EOPNOTSUPP
      cpufreq: Remove CPUFREQ_STICKY flag
      cpufreq: Remove unused flag CPUFREQ_PM_NO_WARN

Yang Li (1):
      PM / devfreq: rk3399_dmc: Remove unneeded semicolon

Yunfeng Ye (2):
      powercap: intel_rapl: Use topology interface in rapl_add_package()
      powercap: intel_rapl: Use topology interface in rapl_init_domains()

Zhang Rui (1):
      powercap/intel_rapl: add support for AlderLake Mobile

Zqiang (1):
      PM: sleep: No need to check PF_WQ_WORKER in thaw_kernel_threads()

pierre Kuo (1):
      PM / devfreq: Replace devfreq->dev.parent as dev in devfreq_add_device

---------------

 Documentation/power/index.rst                |   1 +
 Documentation/power/powercap/dtpm.rst        | 212 +++++++
 Documentation/power/runtime_pm.rst           |  14 +-
 MAINTAINERS                                  |   1 +
 drivers/base/power/clock_ops.c               | 223 ++++++--
 drivers/base/power/domain.c                  |  87 ++-
 drivers/base/power/domain_governor.c         | 102 +++-
 drivers/base/power/main.c                    |   9 +-
 drivers/base/power/runtime.c                 |   2 +-
 drivers/clk/clk.c                            |  21 +
 drivers/cpufreq/Kconfig.arm                  |   5 -
 drivers/cpufreq/Makefile                     |   1 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c        |  24 +-
 drivers/cpufreq/cpufreq-dt-platdev.c         |   2 -
 drivers/cpufreq/cpufreq-dt.c                 |   2 +-
 drivers/cpufreq/cpufreq.c                    |   3 +-
 drivers/cpufreq/davinci-cpufreq.c            |   2 +-
 drivers/cpufreq/intel_pstate.c               |  46 +-
 drivers/cpufreq/loongson1-cpufreq.c          |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c           |   2 +-
 drivers/cpufreq/omap-cpufreq.c               |   2 +-
 drivers/cpufreq/pmac32-cpufreq.c             |   3 +-
 drivers/cpufreq/qcom-cpufreq-hw.c            |  10 +-
 drivers/cpufreq/s3c24xx-cpufreq.c            |   2 +-
 drivers/cpufreq/s5pv210-cpufreq.c            |   2 +-
 drivers/cpufreq/sa1100-cpufreq.c             |   2 +-
 drivers/cpufreq/sa1110-cpufreq.c             |   2 +-
 drivers/cpufreq/scmi-cpufreq.c               |   2 +-
 drivers/cpufreq/scpi-cpufreq.c               |   2 +-
 drivers/cpufreq/spear-cpufreq.c              |   2 +-
 drivers/cpufreq/tango-cpufreq.c              |  38 --
 drivers/cpufreq/tegra186-cpufreq.c           |   2 +-
 drivers/cpufreq/tegra194-cpufreq.c           |   3 +-
 drivers/cpufreq/tegra20-cpufreq.c            |  45 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c       |   3 +-
 drivers/devfreq/devfreq.c                    |  11 +-
 drivers/devfreq/governor.h                   |   2 +-
 drivers/devfreq/governor_passive.c           |  44 +-
 drivers/devfreq/rk3399_dmc.c                 |   2 +-
 drivers/devfreq/tegra30-devfreq.c            |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c        |   8 +-
 drivers/idle/intel_idle.c                    |   2 +-
 drivers/opp/core.c                           | 798 +++++++++++++++++++--------
 drivers/opp/of.c                             | 230 ++++++--
 drivers/opp/opp.h                            |  17 +-
 drivers/powercap/Kconfig                     |  13 +
 drivers/powercap/Makefile                    |   2 +
 drivers/powercap/dtpm.c                      | 480 ++++++++++++++++
 drivers/powercap/dtpm_cpu.c                  | 257 +++++++++
 drivers/powercap/intel_rapl_common.c         |   9 +-
 include/asm-generic/vmlinux.lds.h            |  11 +
 include/linux/clk.h                          |  24 +-
 include/linux/cpufreq.h                      |  30 +-
 include/linux/cpuhotplug.h                   |   1 +
 include/linux/devfreq.h                      |   2 +
 include/linux/dtpm.h                         |  77 +++
 include/linux/pm.h                           |   2 +
 include/linux/pm_domain.h                    |  12 +
 include/linux/pm_opp.h                       | 112 +++-
 include/linux/units.h                        |   4 +
 kernel/power/Kconfig                         |  12 +-
 kernel/power/main.c                          |   2 +-
 kernel/power/process.c                       |   2 +-
 tools/power/cpupower/Makefile                |   8 +-
 tools/power/cpupower/bench/Makefile          |   2 +-
 tools/power/cpupower/utils/cpufreq-info.c    |   3 +-
 tools/power/cpupower/utils/helpers/amd.c     |  65 +--
 tools/power/cpupower/utils/helpers/cpuid.c   |  20 +-
 tools/power/cpupower/utils/helpers/helpers.h |  14 +-
 tools/power/cpupower/utils/helpers/misc.c    |   9 +-
 70 files changed, 2532 insertions(+), 640 deletions(-)
