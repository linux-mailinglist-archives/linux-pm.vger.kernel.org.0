Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF8113C52
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 08:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEH1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 02:27:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:18797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfLEH1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 02:27:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 23:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; 
   d="scan'208";a="243148474"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2019 23:27:46 -0800
Message-ID: <e04fa1e5eb6b81dd99097d1fb41fd04daf44c235.camel@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.5-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu, 05 Dec 2019 15:27:45 +0800
In-Reply-To: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
References: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-04 at 14:16 +0800, Zhang Rui wrote:
> Hi, Linus,
> 
> Please pull from
>   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> thermal/next
> 
> to receive the latest Thermal Management updates for v5.5-rc1 with
> top-most commit 163b00cde7cf2206e248789d2780121ad5e6a70b:
> 
>   thermal: Fix deadlock in thermal thermal_zone_device_check (2019-
> 11-
> 14 22:41:09 +0800)
> 
> on top of commit a99d8080aaf358d5d23581244e5da23b35e340b9:
> 
>   Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)
> 
I still have some patches pending, which includes
changes of MAINTAINER file to remove Eduardo Valentin <
edubezval@gmail.com> from the co-maintainer of thermal subsystem
because his email is bouncing, and to add Daniel Lezcano <
daniel.lezcano@linaro.org> as the co-maintainer.
And also another Kconfig warning fix. So there should be a second PR
once this is merged.

thanks,
rui

> Specifics:
> 
> - Fix a deadlock regression in thermal core framework, which is
> introduced in 5.3. (Wei Wang)
> 
> - Initialize thermal control framework earlier to enable thermal
> mitigation during boot. (Amit Kucheria)
> 
> - Convert the Intelligent Power Allocator (IPA) thermal governor to
> follow the generic PM_EM instead of its own Energy Model. (Quentin
> Perret)
> 
> - Introduce a new Amlogic soc thermal driver. (Guillaume La Roque)
> 
> - Add interrupt support for tsens thermal driver. (Amit Kucheria)
> 
> - Add support for MSM8956/8976 in tsens thermal driver.
> (AngeloGioacchino Del Regno)
> 
> - Add support for r8a774b1 in rcar thermal driver. (Biju Das)
> 
> - Add support for Thermal Monitor Unit v2 in qoriq thermal driver.
> (Yuantian Tang)
> 
> - Some other fixes/cleanups on thermal core framework and soc thermal
> drivers. (Colin Ian King, Daniel Lezcano, Hsin-Yi Wang, Tian Tao)
> 
> thanks,
> rui
> 
> ----------------------------------------------------------------
> Amit Kucheria (13):
>       drivers: thermal: tsens: Get rid of id field in tsens_sensor
>       drivers: thermal: tsens: Simplify code flow in tsens_probe
>       drivers: thermal: tsens: Add __func__ identifier to debug
> statements
>       drivers: thermal: tsens: Add debugfs support
>       dt-bindings: thermal: tsens: Convert over to a yaml schema
>       drivers: thermal: tsens: Create function to return sign-
> extended
> temperature
>       drivers: thermal: tsens: Add interrupt support
>       thermal: Remove netlink support
>       thermal: Initialize thermal subsystem earlier
>       cpufreq: Initialize the governors in core_initcall
>       cpufreq: Initialize cpufreq-dt driver earlier
>       clk: qcom: Initialize clock drivers earlier
>       cpufreq: qcom-hw: Move driver initialization earlier
> 
> AngeloGioacchino Del Regno (2):
>       thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976
>       dt: thermal: tsens: Document compatible for MSM8976/56
> 
> Biju Das (2):
>       thermal: rcar_gen3_thermal: Add r8a774b1 support
>       dt-bindings: thermal: rcar-gen3-thermal: Add r8a774b1 support
> 
> Colin Ian King (2):
>       thermal: qcom: tsens-v1: Fix kfree of a non-pointer value
>       drivers: thermal: tsens: fix potential integer overflow on
> multiply
> 
> Daniel Lezcano (2):
>       thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
>       thermal: cpu_cooling: Reorder the header file
> 
> Guillaume La Roque (3):
>       dt-bindings: thermal: Add DT bindings documentation for Amlogic
> Thermal
>       thermal: amlogic: Add thermal driver to support G12 SoCs
>       MAINTAINERS: add entry for Amlogic Thermal driver
> 
> Hsin-Yi Wang (1):
>       thermal-generic-adc: Silent error message for EPROBE_DEFER
> 
> Quentin Perret (4):
>       arm64: defconfig: Enable CONFIG_ENERGY_MODEL
>       PM / EM: Declare EM data types unconditionally
>       thermal: cpu_cooling: Make the power-related code depend on IPA
>       thermal: cpu_cooling: Migrate to using the EM framework
> 
> Tian Tao (1):
>       thermal: no need to set .owner when using
> module_platform_driver
> 
> Wei Wang (1):
>       thermal: Fix deadlock in thermal thermal_zone_device_check
> 
> Yuantian Tang (1):
>       thermal: qoriq: add thermal monitor unit version 2 support
> 
>  .../bindings/thermal/amlogic,thermal.yaml          |  54 +++
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  55 ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml    | 170 +++++++
>  .../bindings/thermal/rcar-gen3-thermal.txt         |   1 +
>  Documentation/driver-api/thermal/sysfs-api.rst     |  26 +-
>  MAINTAINERS                                        |  10 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/clk/qcom/clk-rpmh.c                        |   2 +-
>  drivers/clk/qcom/gcc-qcs404.c                      |   2 +-
>  drivers/clk/qcom/gcc-sdm845.c                      |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +-
>  drivers/cpufreq/cpufreq_conservative.c             |   2 +-
>  drivers/cpufreq/cpufreq_ondemand.c                 |   2 +-
>  drivers/cpufreq/cpufreq_performance.c              |   2 +-
>  drivers/cpufreq/cpufreq_powersave.c                |   2 +-
>  drivers/cpufreq/cpufreq_userspace.c                |   2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c                  |   2 +-
>  drivers/thermal/Kconfig                            |  12 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/amlogic_thermal.c                  | 333
> +++++++++++++
>  drivers/thermal/cpu_cooling.c                      | 404 +++++++----
> -----
>  drivers/thermal/qcom/tsens-8960.c                  |   4 +-
>  drivers/thermal/qcom/tsens-common.c                | 529
> +++++++++++++++++++--
>  drivers/thermal/qcom/tsens-v0_1.c                  |  11 +
>  drivers/thermal/qcom/tsens-v1.c                    | 198 +++++++-
>  drivers/thermal/qcom/tsens-v2.c                    |  13 +
>  drivers/thermal/qcom/tsens.c                       |  62 ++-
>  drivers/thermal/qcom/tsens.h                       | 288 +++++++++--
>  drivers/thermal/qoriq_thermal.c                    | 120 ++++-
>  drivers/thermal/rcar_gen3_thermal.c                |   4 +
>  drivers/thermal/thermal-generic-adc.c              |   9 +-
>  drivers/thermal/thermal_core.c                     | 107 +----
>  drivers/thermal/thermal_mmio.c                     |   1 -
>  include/linux/cpu_cooling.h                        |  18 +-
>  include/linux/energy_model.h                       |   3 +-
>  include/linux/thermal.h                            |  11 -
>  kernel/sched/cpufreq_schedutil.c                   |   2 +-
>  37 files changed, 1878 insertions(+), 589 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-
> tsens.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-
> tsens.yaml
>  create mode 100644 drivers/thermal/amlogic_thermal.c
> 

