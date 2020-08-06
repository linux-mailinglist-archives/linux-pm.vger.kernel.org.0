Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA523E307
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHFUTJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHFUTH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 16:19:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA1C061574
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 13:19:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so9898163wmd.4
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jN6H7gSQ3+o0bH9j1Dm5F5mz7YQDGK2LdjSj6lic1YU=;
        b=e/GerVru/dRsJppM3t9SU+1h2Q9ppkZ6tLjpCU5onl8i989Z+aPGwbG3MKkP+4O/ks
         FFTZ9ZQyH7/D7DgqBxy7OhXBl1Agtj0y9vFOxf6k5tS5ayKKxnT8ME/JUC/XG8AzzAEU
         wLmqZn3Tidd3V9nf8LYyYtvKJVE6jI/gN93qG4YLksF+5+C9lK/JnhD9/6ediQDlnPcs
         7KRDTGq8bOKa9D1c1Id9Ic8E/9sPJajEaZBo1xlUgzwfY2BdXPjvNmq2ipSrd/gQix2G
         eTgEQCREIEpMX4eRwBcSBk+rm9/kobEfDrHnRolVuz4Zay9C+m9c2aCIVmoqjc6K5j2Q
         fG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jN6H7gSQ3+o0bH9j1Dm5F5mz7YQDGK2LdjSj6lic1YU=;
        b=FcusQa+a2MoHfWLHDGAJLI4NoLIeLxfSsWxQPScuLVFI0wvCjmePEarDx7zT3o/W5R
         paE8x+8rGsbvmrKSHzBcCHZgECcEzT6GSs6H1qHnlnFrCPzD8HN8mZBfvHFjkGqoN3KP
         wmY9VFIz6c9ex3aDe1Ej46MOLiTpgbVMmTa+5NI9Xfg813B3NgbGyxj4WRoacao6E9I8
         S700aUgSlMBPQnLu/JXSjZg04NP9o+6K47xwnlOUn5t6StU9JHH2Bgi0EzgO3uTjJmM2
         4ad+/2b1etzZuEm7nfF3OOEaVcujApgjKeI/8xgwUQ/KhNK938PhEYKxAw4D497Ov60N
         R33Q==
X-Gm-Message-State: AOAM533KJB8gMX03RORQ7FjDugst4ezVv0eAMbUaxJdGMPER7O7auGWb
        x786p86/732EPAE5olFeSwf9Nw==
X-Google-Smtp-Source: ABdhPJxPWiGvLzQjFl3tbtdsnigcN9QOJmStwA5cx3B/6QfmsG1TNEsOS+99IoiD2C2pV6KWqh0wCw==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr9335187wmb.179.1596745145990;
        Thu, 06 Aug 2020 13:19:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f457:5fc1:5262:84c? ([2a01:e34:ed2f:f020:f457:5fc1:5262:84c])
        by smtp.googlemail.com with ESMTPSA id w1sm7809139wmc.18.2020.08.06.13.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 13:19:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
Date:   Thu, 6 Aug 2020 22:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.9-rc1

for you to fetch changes up to c569e805c7bcebdd069e5c97ce5f8543f6d02433:

  thermal: intel: intel_pch_thermal: Add Cannon Lake Low Power PCH
support (2020-08-04 10:43:03 +0200)

----------------------------------------------------------------
- Add support to enable/disable the thermal zones resulting on core code and
  drivers cleanup (Andrzej Pietrasiewicz)

- Add generic netlink support for userspace notifications: events,
temperature
  and discovery commands (Daniel Lezcano)

- Fix redundant initialization for a ret variable (Colin Ian King)

- Remove the clock cooling code as it is used nowhere (Amit Kucheria)

- Add the rcar_gen3_thermal's r8a774e1 support (Marian-Cristian Rotariu)

- Replace all references to thermal.txt in the documentation to the
  corresponding yaml files (Amit Kucheria)

- Add maintainer entry for the IPA (Lukasz Luba)

- Add support for MSM8939 for the tsens (Shawn Guo)

- Update power allocator and devfreq cooling to SPDX licensing (Lukasz Luba)

- Add Cannon Lake Low Power PCH support (Sumeet Pawnikar)

- Add tsensor support for V2 mediatek thermal system (Henry Yen)

- Fix thermal zone lookup by ID for the core code (Thierry Reding)

----------------------------------------------------------------
Amit Kucheria (2):
      thermal/drivers/clock_cooling: Remove clock_cooling code
      dt-bindings: thermal: Get rid of thermal.txt and replace references

Andrzej Pietrasiewicz (14):
      acpi: thermal: Fix error handling in the register function
      thermal: Store thermal mode in a dedicated enum
      thermal: Add current mode to thermal zone device
      thermal: Store device mode in struct thermal_zone_device
      thermal: remove get_mode() operation of drivers
      thermal: Add mode helpers
      thermal: Use mode helpers in drivers
      thermal: Explicitly enable non-changing thermal zone devices
      thermal: core: Stop polling DISABLED thermal devices
      thermal: Simplify or eliminate unnecessary set_mode() methods
      thermal: Rename set_mode() to change_mode()
      acpi: thermal: Don't call thermal_zone_device_is_enabled()
      thermal: imx: Use driver's local data to decide whether to run a
measurement
      thermal: Make thermal_zone_device_is_enabled() available to core only

Anson Huang (1):
      thermal: imx8mm: Support module autoloading

Colin Ian King (1):
      thermal: core: remove redundant initialization of variable ret

Dan Carpenter (1):
      thermal: ti-soc-thermal: Fix reversed condition in
ti_thermal_expose_sensor()

Daniel Lezcano (9):
      thermal: core: Add helpers to browse the cdev, tz and governor list
      thermal: core: Get thermal zone by id
      thermal: core: genetlink support for events/cmd/sampling
      thermal: core: Add notifications call in the framework
      thermal: netlink: Fix compilation error when CONFIG_NET=n
      net: genetlink: Move initialization to core_initcall
      thermal: netlink: Improve the initcall ordering
      thermal: core: Move initialization after core initcall
      thermal: core: Add thermal zone enable/disable notification

Henry Yen (2):
      thermal: mediatek: Prepare to add support for other platforms
      thermal: mediatek: Add tsensor support for V2 thermal system

Konrad Dybcio (1):
      dt-bindings: tsens: qcom: Document MSM8939 compatible

Lukas Bulwahn (1):
      MAINTAINERS: update entry to thermal governors file name prefixing

Lukasz Luba (2):
      MAINTAINERS: Add maintenance information for IPA
      thermal: Update power allocator and devfreq cooling to SPDX licensing

Marian-Cristian Rotariu (1):
      thermal: rcar_gen3_thermal: Add r8a774e1 support

Niklas Söderlund (1):
      thermal: rcar_gen3_thermal: Do not shadow thcode variable

Shawn Guo (1):
      thermal: qcom: tsens-v0_1: Add support for MSM8939

Sumeet Pawnikar (2):
      thermal: int340x: processor_thermal: fix: update Jasper Lake PCI id
      thermal: intel: intel_pch_thermal: Add Cannon Lake Low Power PCH
support

Thierry Reding (1):
      thermal: core: Fix thermal zone lookup by ID

 Documentation/devicetree/bindings/arm/arm,scmi.txt |   2 +-
 Documentation/devicetree/bindings/arm/arm,scpi.txt |   2 +-
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   2 +-
 .../arm/marvell/ap80x-system-controller.txt        |   2 +-
 .../arm/marvell/cp110-system-controller.txt        |   2 +-
 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   3 +-
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   4 +-
 .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   2 +-
 .../devicetree/bindings/hwmon/gpio-fan.txt         |   3 +-
 Documentation/devicetree/bindings/hwmon/lm90.txt   |   4 +-
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   2 +-
 .../bindings/thermal/amazon,al-thermal.txt         |   2 +-
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |   2 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |   2 +-
 .../bindings/thermal/hisilicon-thermal.txt         |   2 +-
 .../bindings/thermal/max77620_thermal.txt          |   6 +-
 .../bindings/thermal/mediatek-thermal.txt          |   2 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  10 +-
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |   2 +-
 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |   2 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../bindings/thermal/rockchip-thermal.txt          |   2 +-
 .../devicetree/bindings/thermal/tango-thermal.txt  |   2 +-
 .../bindings/thermal/thermal-generic-adc.txt       |   2 +-
 .../devicetree/bindings/thermal/thermal.txt        | 586
-------------------
 MAINTAINERS                                        |   8 +
 drivers/acpi/thermal.c                             |  76 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |   8 +
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  91 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   9 +-
 drivers/platform/x86/acerhdf.c                     |  33 +-
 drivers/platform/x86/intel_mid_thermal.c           |   6 +
 drivers/power/supply/power_supply_core.c           |   9 +-
 drivers/thermal/Kconfig                            |  20 +-
 drivers/thermal/Makefile                           |   6 +-
 drivers/thermal/armada_thermal.c                   |   6 +
 drivers/thermal/clock_cooling.c                    | 445 --------------
 drivers/thermal/da9062-thermal.c                   |  16 +-
 drivers/thermal/devfreq_cooling.c                  |  10 +-
 drivers/thermal/dove_thermal.c                     |   6 +
 drivers/thermal/gov_power_allocator.c              |   9 +-
 drivers/thermal/hisi_thermal.c                     |   6 +-
 drivers/thermal/imx8mm_thermal.c                   |   1 +
 drivers/thermal/imx_thermal.c                      |  60 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  38 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   5 +
 .../int340x_thermal/processor_thermal_device.c     |   2 +-
 drivers/thermal/intel/intel_pch_thermal.c          |   8 +
 drivers/thermal/intel/intel_quark_dts_thermal.c    |  34 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c         |   3 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   6 +
 drivers/thermal/kirkwood_thermal.c                 |   7 +
 drivers/thermal/mtk_thermal.c                      | 234 ++++++--
 drivers/thermal/qcom/tsens-v0_1.c                  | 144 ++++-
 drivers/thermal/qcom/tsens.c                       |   3 +
 drivers/thermal/qcom/tsens.h                       |   2 +-
 drivers/thermal/rcar_gen3_thermal.c                |  10 +-
 drivers/thermal/rcar_thermal.c                     |   9 +-
 drivers/thermal/rockchip_thermal.c                 |   6 +-
 drivers/thermal/spear_thermal.c                    |   7 +
 drivers/thermal/sprd_thermal.c                     |   6 +-
 drivers/thermal/st/st_thermal.c                    |   5 +
 drivers/thermal/thermal_core.c                     | 174 +++++-
 drivers/thermal/thermal_core.h                     |  15 +
 drivers/thermal/thermal_helpers.c                  |  13 +-
 drivers/thermal/thermal_netlink.c                  | 647
+++++++++++++++++++++
 drivers/thermal/thermal_netlink.h                  | 104 ++++
 drivers/thermal/thermal_of.c                       |  41 +-
 drivers/thermal/thermal_sysfs.c                    |  52 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   2 +-
 include/linux/clock_cooling.h                      |  57 --
 include/linux/devfreq_cooling.h                    |   9 +-
 include/linux/thermal.h                            |  31 +-
 include/uapi/linux/thermal.h                       |  89 ++-
 net/netlink/genetlink.c                            |   2 +-
 75 files changed, 1632 insertions(+), 1609 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt
 delete mode 100644 drivers/thermal/clock_cooling.c
 create mode 100644 drivers/thermal/thermal_netlink.c
 create mode 100644 drivers/thermal/thermal_netlink.h
 delete mode 100644 include/linux/clock_cooling.h

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
