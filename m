Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA833FBC94
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhH3Smd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 14:42:33 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45694 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhH3Smd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 14:42:33 -0400
Received: by mail-ot1-f54.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso19536412otv.12;
        Mon, 30 Aug 2021 11:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a12sAAWnY24FkYzNdYZv9eBHcuK5LgwU3aNcX710ZsI=;
        b=B2kfkJMR4NBwSS6TWHolHC697fP5y9uccF6i9dVMz8sOnEulCC700zfmFcgHf+ekY5
         pmuI4/K+qosCBOhOt92qP7Ve+OtkIh3Omo4l2zqObAXlTfw7ZelmyyeXbH7kARmj5oaO
         lPInwU8vjsHgUga1VhdS9k/mI/1v6BL0+hULkuiAIvj4nPr40VdCEWg5gFs+vmlp0jJw
         47SOpH2fqFNJLGLh5LRs6ztb6SIE86K47vjvkTAnJFYwz/QVJBfcrlGTzO1LzmvLJ2a7
         XGNHKRxeyvgzYvqHf9D+o8losGo34DT7ZsGOliJhnD+7wcvBrC9+hhcyGeuLR0ORIszM
         CVJw==
X-Gm-Message-State: AOAM533wYfab0vFe/29FRTCOVIp1p6b+j399oGKft67H+0X9yu7anL+T
        XPMdraRowEafVyTBVQSyzSpcy7pcN6LNHaDU+dZhFg7zmi6kHQ==
X-Google-Smtp-Source: ABdhPJwcZiH6LamUWb2y07rVGxWqwk/8+DbNlrfz5Ml0h/YCe3gtfgbDOi1QnBjglu2qiKBV6we3cRU+H22h1VI4+V0=
X-Received: by 2002:a9d:7115:: with SMTP id n21mr15526909otj.321.1630348899304;
 Mon, 30 Aug 2021 11:41:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:28 +0200
Message-ID: <CAJZ5v0hqMbLjTO71URfxCiKv6+Ha9BMA0ive1tEcjP7VqA1XZg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.15-rc1
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
 pm-5.15-rc1

with top-most commit fe583359ddf0d509275b87b635fa8b2e3794321e

 Merge branches 'pm-pci', 'pm-sleep', 'pm-domains' and 'powercap'

on top of commit 7ee5fd12e8cac91bdec6de8417b030ed05d5d7ee

 Merge branch 'pm-opp'

to receive power management updates for 5.15-rc1.

These address some PCI device power management issues, add new
hardware support to the RAPL power capping driver, add HWP guaranteed
performance change notification support to the intel_pstate driver,
replace deprecated CPU-hotplug functions in a few places, update CPU
PM notifiers to use raw spinlocks, update the PM domains framework
(new DT property support, Kconfig fix), do a couple of cleanups in
code related to system sleep, and improve the energy model and
the schedutil cpufreq governor.

Specifics:

 - Address 3 PCI device power management issues (Rafael Wysocki).

 - Add Power Limit4 support for Alder Lake to the Intel RAPL power
   capping driver (Sumeet Pawnikar).

 - Add HWP guaranteed performance change notification support to
   the intel_pstate driver (Srinivas Pandruvada).

 - Replace deprecated CPU-hotplug functions in code related to power
   management (Sebastian Andrzej Siewior).

 - Update CPU PM notifiers to use raw spinlocks (Valentin Schneider).

 - Add support for 'required-opps' DT property to the generic power
   domains (genpd) framework and use this property for I2C on ARM64
   sc7180 (Rajendra Nayak).

 - Fix Kconfig issue related to genpd (Geert Uytterhoeven).

 - Increase energy calculation precision in the Energy Model (Lukasz
   Luba).

 - Fix kobject deletion in the exit code of the schedutil cpufreq
   governor (Kevin Hao).

 - Unmark some functions as kernel-doc in the PM core to avoid
   false-positive documentation build warnings (Randy Dunlap).

 - Check RTC features instead of ops in suspend_test Alexandre
   Belloni).

Thanks!


---------------

Alexandre Belloni (1):
      PM: sleep: check RTC features instead of ops in suspend_test

Geert Uytterhoeven (1):
      PM: domains: Fix domain attach for CONFIG_PM_OPP=n

Kevin Hao (1):
      cpufreq: schedutil: Use kobject release() method to free sugov_tunables

Lukasz Luba (1):
      PM: EM: Increase energy calculation precision

Rafael J. Wysocki (3):
      PCI: Use pci_update_current_state() in pci_enable_device_flags()
      PCI: PM: Avoid forcing PCI_D0 for wakeup reasons inconsistently
      PCI: PM: Enable PME if it can be signaled from D3cold

Rajendra Nayak (3):
      opp: Don't print an error if required-opps is missing
      PM: domains: Add support for 'required-opps' to set default perf state
      arm64: dts: sc7180: Add required-opps for i2c

Randy Dunlap (1):
      PM: sleep: unmark 'state' functions as kernel-doc

Sebastian Andrzej Siewior (3):
      powercap: intel_rapl: Replace deprecated CPU-hotplug functions
      cpufreq: Replace deprecated CPU-hotplug functions
      PM: sleep: s2idle: Replace deprecated CPU-hotplug functions

Srinivas Pandruvada (2):
      thermal: intel: Allow processing of HWP interrupt
      cpufreq: intel_pstate: Process HWP Guaranteed change notification

Sumeet Pawnikar (1):
      powercap: Add Power Limit4 support for Alder Lake SoC

Valentin Schneider (2):
      PM: cpu: Make notifier chain use a raw_spinlock_t
      notifier: Remove atomic_notifier_call_chain_robust()

---------------

 arch/arm64/boot/dts/qcom/sc7180.dtsi      | 24 +++++++++++++++
 drivers/base/power/domain.c               | 30 +++++++++++++++++--
 drivers/cpufreq/acpi-cpufreq.c            |  4 +--
 drivers/cpufreq/cpufreq.c                 |  6 ++--
 drivers/cpufreq/cpufreq_ondemand.c        |  4 +--
 drivers/cpufreq/intel_pstate.c            | 43 ++++++++++++++++++++++++--
 drivers/cpufreq/powernow-k8.c             |  6 ++--
 drivers/cpufreq/powernv-cpufreq.c         |  4 +--
 drivers/opp/of.c                          | 12 ++------
 drivers/pci/pci.c                         | 31 +++++++++++--------
 drivers/powercap/intel_rapl_common.c      | 50 +++++++++++++++----------------
 drivers/powercap/intel_rapl_msr.c         |  2 ++
 drivers/thermal/intel/therm_throt.c       |  7 ++++-
 drivers/thermal/intel/thermal_interrupt.h |  3 ++
 include/linux/energy_model.h              | 16 ++++++++++
 include/linux/notifier.h                  |  2 --
 include/linux/pm_domain.h                 |  1 +
 kernel/cpu_pm.c                           | 50 +++++++++++++++++++++++--------
 kernel/notifier.c                         | 19 ------------
 kernel/power/energy_model.c               |  4 ++-
 kernel/power/main.c                       |  2 +-
 kernel/power/suspend.c                    |  4 +--
 kernel/power/suspend_test.c               |  2 +-
 kernel/sched/cpufreq_schedutil.c          | 16 ++++++----
 24 files changed, 235 insertions(+), 107 deletions(-)
