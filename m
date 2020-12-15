Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE82DB671
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgLOWSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgLOWSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 17:18:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEBC061793
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 14:17:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m5so21323132wrx.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 14:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2WAtyH/h8YJYHOGr/C+Qo9+OJ3Kr2EO8OXwRFWCRBrE=;
        b=PdZKNQW8zERGU9kHLf5x9fdEMpEyC9HTa1l85T5+T5iiQ8UWM5IQVniVBx9768+UvV
         CI0NpiqQMGYTxW2/9r2IY5+YUHj/T1B5dEuzfuZrd+wV3b9L1ts1O9n7uTx9+SpfRtLg
         46DzAaDo+HnIj8g1LOdegS2wlDuaif9uPbBiFp/Pa7AODPOWxvk7+2nKke/Gwl1C2Aup
         zg2wgm3xDZlRw5LH6baG/e21uQjoEpyhtiKRluuTe0TAlY8MxyzLPtomVpdALRoI9F+K
         OAtv7qcG3ueqNJM5dpPs+KbelLbIC23kb/n2LdZHkg9wiZsV90a89LPKocfWatfOuSb7
         2RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2WAtyH/h8YJYHOGr/C+Qo9+OJ3Kr2EO8OXwRFWCRBrE=;
        b=s2xvSZc2EkhcUeU3BGuCPGvA/AoPJaN2feJa+zqbXcgxYiJSZ5IybvG/Glz/Luc89n
         X4ISvsE73qiMWnsshJ4WO0MlEGUpIO/5ClzNcejwvMhxeIBAVdwhf1E2HWc/KlHd+xUo
         mNfpnR6eVMdVLskpSx3XoB+u9LQiGexqFRk4vlI3/4A+imGpdY4gq+qnMrAp/53/CgiI
         lYOB2nU3M3/To72K0ZlsWvgEdH/NCBf8Ok01OQ4OArDcR1+iRm7Y3m2dYTjgPPfZavrF
         SO5j3vvS8gbohtvL/yJJgcfbUXPIBnq3fSX/sm/zLtu0cSge9bA4rmRKRBjCQiGrW8u1
         8dug==
X-Gm-Message-State: AOAM531YuQwDb7OQTaBRaZL1DsoEozSfDR9epcj/bL8CuIkvbTtN6fc7
        /xVcaC3LZ0eL201hR59sd1PLuA==
X-Google-Smtp-Source: ABdhPJxK1xsP6H2KYU4UGYruK6E/A7qoNO6jsE8PahNgQaWl3Lg6Mm55nmgsjg3RVarHrfKxR7L0Xw==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr4469753wrx.34.1608070654063;
        Tue, 15 Dec 2020 14:17:34 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3? ([2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3])
        by smtp.googlemail.com with ESMTPSA id w21sm85148wmi.45.2020.12.15.14.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 14:17:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "michael.kao" <Michael.Kao@mediatek.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>, Bernard <bernard@vivo.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhuguangqing <zhuguangqing@xiaomi.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andres Freund <andres@anarazel.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        rikard.falkeborn@gmail.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        zhengyongjun3@huawei.com
Subject: [GIT PULL] thermal for v5.11
Message-ID: <9a2b3f9e-458a-bb66-2c38-db6cbf5a6c73@linaro.org>
Date:   Tue, 15 Dec 2020 23:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.11-rc1

for you to fetch changes up to 4401117bf7fc11dc738c0963fa0c94814abc8dcd:

  thermal/drivers/devfreq_cooling: Fix the build when !ENERGY_MODEL
(2020-12-15 17:03:56 +0100)

----------------------------------------------------------------
- Add upper and lower limits clamps for the cooling device state in
  the power allocator governor (Michael Kao)

- Add upper and lower limits support for the power allocator governor
  (Lukasz Luba)

- Optimize conditions testing for the trip points (Bernard Zhao)

- Replace spin_lock_irqsave by spin_lock in hard IRQ on the rcar
  driver (Tian Tao)

- Add MT8516 dt-bindings and device reset optional support (Fabien
  Parent)

- Add a quiescent period to cool down the PCH when entering S0iX
  (Sumeet Pawnikar)

- Use bitmap API instead of re-inventing the wheel on sun8i (Yangtao
  Li)

- Remove useless NULL check in the hwmon driver (Bernard Zhao)

- Update the current state in the cpufreq cooling device only if the
  frequency change is effective (Zhuguangqing)

- Improve the schema validation for the rcar DT bindings (Geert
  Uytterhoeven)

- Fix the user time unit in the documentation (Viresh Kumar)

- Add PCI ids for Lewisburg PCH (Andres Freund)

- Add hwmon support on amlogic (Martin Blumenstingl)

- Fix build failure for PCH entering on in S0iX (Randy Dunlap)

- Improve the k_* coefficient for the power allocator governor (Lukasz
  Luba)

- Fix missing const on a sysfs attribute (Rikard Falkeborn)

- Remove broken interrupt support on rcar to be replaced by a new one
  (Niklas Söderlund)

- Improve the error code handling at init time on imx8mm (Fabio
  Estevam)

- Compute interval validity once instead at each temperature reading
  iteration on acerhdf (Daniel Lezcano)

- Add r8a779a0 support (Niklas Söderlund)

- Add PCI ids for AlderLake PCH and mmio refactoring (Srinivas
  Pandruvada)

- Add RFIM and mailbox support on int340x (Srinivas Pandruvada)

- Use macro for temperature calculation on PCH (Sumeet Pawnikar)

- Simplify return conditions at probe time on Broadcom (Zheng Yongjun)

- Fix workload name on PCH (Srinivas Pandruvada)

- Migrate the devfreq cooling device code to the energy model API
  (Lukasz Luba)

- Emit a warning if the thermal_zone_device_update is called without
  the .get_temp() ops (Daniel Lezcano)

- Add critical and hot ops for the thermal zone (Daniel Lezcano)

- Remove notification usage when critical is reached on rcar (Daniel
  Lezcano)

- Fix devfreq build when ENERGY_MODEL is not set (Lukasz Luba)

----------------------------------------------------------------
Andres Freund (1):
      thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.

Bernard Zhao (2):
      drivers/thermal/core: Optimize trip points check
      thermal/drivers/hwmon: Cleanup coding style a bit

Daniel Lezcano (5):
      platform/x86/drivers/acerhdf: Use module_param_cb to set/get
polling interval
      platform/x86/drivers/acerhdf: Check the interval value when it is set
      thermal/core: Emit a warning if the thermal zone is updated
without ops
      thermal/core: Add critical and hot ops
      thermal/drivers/rcar: Remove notification usage

Fabien Parent (3):
      dt-bindings: thermal: mediatek: make resets property optional
      dt-bindings: thermal: mediatek: add documentation for MT8516 SoC
      thermal: mtk_thermal: make device_reset optional

Fabio Estevam (2):
      thermal: imx8mm: Print the correct error code
      thermal: imx8mm: Disable the clock on probe failure

Geert Uytterhoeven (1):
      dt-bindings: thermal: rcar-thermal: Improve schema validation

Lukasz Luba (12):
      thermal: power_allocator: Respect upper and lower bounds for
cooling device
      thermal: core: Remove unused functions in power actor section
      thermal: core: Move power_actor_set_power into IPA
      thermal: power allocator: change the 'k_i' coefficient estimation
      thermal: power allocator: refactor sustainable power estimation
      thermal: power allocator: change the 'k_*' always in
estimate_pid_constants()
      thermal: devfreq_cooling: change tracing function and arguments
      thermal: devfreq_cooling: use a copy of device status
      thermal: devfreq_cooling: add new registration functions with
Energy Model
      thermal: devfreq_cooling: remove old power model and use EM
      drm/panfrost: Register devfreq cooling and attempt to add Energy Model
      thermal/drivers/devfreq_cooling: Fix the build when !ENERGY_MODEL

Martin Blumenstingl (1):
      thermal: amlogic: Add hwmon support

Michael Kao (1):
      thermal: core: Add upper and lower limits to power_actor_set_power

Niklas Söderlund (3):
      thermal: rcar_gen3_thermal: Do not use interrupts for normal operation
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support
      thermal: rcar_gen3_thermal: Add r8a779a0 support

Randy Dunlap (1):
      thermal: intel_pch_thermal: fix build for ACPI not enabled

Rikard Falkeborn (1):
      thermal: core: Constify static attribute_group structs

Srinivas Pandruvada (5):
      thermal: int340x: processor_thermal: Refactor MMIO interface
      thermal: int340x: processor_thermal: Add AlderLake PCI device id
      thermal: int340x: processor_thermal: Add RFIM driver
      thermal: int340x: processor_thermal: Add mailbox driver
      thermal: int340x: processor_thermal: Correct workload type name

Sumeet Pawnikar (2):
      thermal: intel: pch: fix S0ix failure due to PCH temperature above
threshold
      thermal: intel: pch: use macro for temperature calculation

Tian Tao (1):
      thermal/drivers/rcar: Replace spin_lock_irqsave by spin_lock in
hard IRQ

Viresh Kumar (1):
      docs: thermal: time_in_state is displayed in msec and not usertime

Yangtao Li (1):
      thermal: sun8i: Use bitmap API instead of open code

Zheng Yongjun (1):
      thermal: broadcom: simplify the return expression of
bcm2711_thermal_probe()

Zhuguangqing (1):
      thermal/drivers/cpufreq_cooling: Update cpufreq_state only if
state has changed

 .../bindings/thermal/mediatek-thermal.txt          |   3 +-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  17 +-
 .../devicetree/bindings/thermal/rcar-thermal.yaml  |  48 ++-
 Documentation/driver-api/thermal/sysfs-api.rst     |   3 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |   2 +-
 drivers/platform/x86/acerhdf.c                     |  30 +-
 drivers/thermal/amlogic_thermal.c                  |   4 +
 drivers/thermal/broadcom/bcm2711_thermal.c         |   6 +-
 drivers/thermal/cpufreq_cooling.c                  |   4 +-
 drivers/thermal/devfreq_cooling.c                  | 390
++++++++++-----------
 drivers/thermal/gov_power_allocator.c              | 116 ++++--
 drivers/thermal/imx8mm_thermal.c                   |   7 +-
 drivers/thermal/intel/int340x_thermal/Kconfig      |   6 +-
 drivers/thermal/intel/int340x_thermal/Makefile     |   3 +
 .../int340x_thermal/processor_thermal_device.c     | 282 +++++----------
 .../int340x_thermal/processor_thermal_device.h     |  82 +++++
 .../intel/int340x_thermal/processor_thermal_mbox.c | 212 +++++++++++
 .../intel/int340x_thermal/processor_thermal_rapl.c | 134 +++++++
 .../intel/int340x_thermal/processor_thermal_rfim.c | 244 +++++++++++++
 drivers/thermal/intel/intel_pch_thermal.c          | 103 +++++-
 drivers/thermal/mtk_thermal.c                      |   2 +-
 drivers/thermal/rcar_gen3_thermal.c                | 115 +-----
 drivers/thermal/rcar_thermal.c                     |  24 +-
 drivers/thermal/sun8i_thermal.c                    |  33 +-
 drivers/thermal/thermal_core.c                     | 143 ++------
 drivers/thermal/thermal_core.h                     |   6 -
 drivers/thermal/thermal_hwmon.c                    |   3 +-
 drivers/thermal/thermal_sysfs.c                    |   6 +-
 include/linux/devfreq_cooling.h                    |  27 +-
 include/linux/thermal.h                            |   3 +
 include/trace/events/thermal.h                     |  19 +-
 31 files changed, 1278 insertions(+), 799 deletions(-)
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
