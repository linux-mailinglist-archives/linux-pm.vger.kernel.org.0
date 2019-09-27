Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5FC0603
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfI0NIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 09:08:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:20275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfI0NIm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 09:08:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 06:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="341791735"
Received: from baoyuyan-mobl.ccr.corp.intel.com ([10.255.31.72])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2019 06:08:39 -0700
Message-ID: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.4-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Fri, 27 Sep 2019 21:08:39 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-
5.4

to receive the latest Thermal Management updates for v5.4-rc1 with
top-most commit 0f84d1d18c46d0f995962c876c8b2900fd183fd7:

  Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into
for-5.4 (2019-09-24 09:56:37 +0800)

on top of commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

One thing to mention is that, all the patches have been tested in
linux-next for weeks, but there is a conflict detected, because
upstream has took commit eaf7b46083a7e34 ("docs: thermal: add it to the
driver API") from jc-docs tree while I'm keeping a wrong version of the
patch, so I just rebased my tree to fix this.

Specifics:
 - Add Amit Kucheria as thermal subsystem Reviewer. (Amit Kucheria)
 - Fix a use after free bug when unregistering thermal zone devices.
(Ido Schimmel)
 - Fix thermal core framework to use put_device() when
device_register() fails. (Yue Hu)
 - Enable intel_pch_thermal and MMIO RAPL support for Intel Icelake
platform. (Srinivas Pandruvada)
 - Add clock operations in qorip thermal driver, for some platforms
with clock control like i.MX8MQ. (Anson Huang)
 - A couple of trivial fixes and cleanups for thermal core and
different soc thermal drivers.(Amit Kucheria, Christophe
JAILLET, Chuhong Yuan, Fuqian Huang, Kelsey Skunberg, Nathan
Huckleberry, Rishi Gupta, Srinivas Kandagatla)

thanks,
rui

----------------------------------------------------------------
Amit Kucheria (2):
      thermal: Add some error messages
      MAINTAINERS: Add Amit Kucheria as reviewer for thermal

Anson Huang (5):
      thermal: qoriq: Add clock operations
      thermal: qoriq: Fix error path of calling
qoriq_tmu_register_tmu_zone fail
      thermal: qoriq: Use devm_platform_ioremap_resource() instead of
of_iomap()
      thermal: qoriq: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
      dt-bindings: thermal: qoriq: Add optional clocks property

Christophe JAILLET (1):
      thermal: tegra: Fix a typo

Chuhong Yuan (1):
      thermal: intel: Use dev_get_drvdata

Fuqian Huang (1):
      thermal: rcar_gen3_thermal: Replace devm_add_action() followed by
failure action with devm_add_action_or_reset()

Ido Schimmel (1):
      thermal: Fix use-after-free when unregistering thermal zone
device

Kelsey Skunberg (1):
      thermal: intel: int340x_thermal: Remove unnecessary
acpi_has_method() uses

Nathan Huckleberry (1):
      thermal: armada: Fix -Wshift-negative-value

Rishi Gupta (1):
      thermal: intel: int3403: replace printk(KERN_WARN...) with
pr_warn(...)

Srinivas Kandagatla (1):
      drivers: thermal: qcom: tsens: Fix memory leak from qfprom read

Srinivas Pandruvada (2):
      drivers: thermal: processor_thermal_device: Export sysfs
interface for TCC offset
      thermal: int340x: processor_thermal: Add Ice Lake support

Stefan Mavrodiev (1):
      thermal_hwmon: Sanitize thermal_zone type

Yue Hu (1):
      thermal/drivers/core: Use put_device() if device_register() fails

Zhang Rui (2):
      Merge branches 'thermal-soc-misc' and 'thermal-soc-qoriq' into
thermal-soc
      Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc'
into for-5.4

 .../devicetree/bindings/thermal/qoriq-thermal.txt  |  1 +
 MAINTAINERS                                        |  1 +
 drivers/thermal/armada_thermal.c                   |  5 +-
 .../intel/int340x_thermal/acpi_thermal_rel.c       |  6 --
 .../intel/int340x_thermal/int3403_thermal.c        |  2 +-
 .../int340x_thermal/processor_thermal_device.c     | 96
+++++++++++++++++++++-
 drivers/thermal/intel/intel_pch_thermal.c          |  6 +-
 drivers/thermal/qcom/tsens-8960.c                  |  2 +
 drivers/thermal/qcom/tsens-v0_1.c                  | 12 ++-
 drivers/thermal/qcom/tsens-v1.c                    |  1 +
 drivers/thermal/qcom/tsens.h                       |  1 +
 drivers/thermal/qoriq_thermal.c                    | 45 ++++++----
 drivers/thermal/rcar_gen3_thermal.c                |  3 +-
 drivers/thermal/tegra/soctherm.c                   |  2 +-
 drivers/thermal/thermal_core.c                     | 44 ++++++----
 drivers/thermal/thermal_hwmon.c                    |  8 +-
 16 files changed, 178 insertions(+), 57 deletions(-)

