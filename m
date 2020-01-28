Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB87C14B25B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgA1KN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 05:13:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50968 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgA1KN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 05:13:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so1855591wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=r3C3Y0IJstOFY21HYumFx0TAFpm3BHwTb33PtAff3GA=;
        b=UhZ6J8AWMcmbhT5+fVS+gWVBDEn87tEUDhojdj2ODQo05aVppMPYehF8WbohhpyTH/
         XlUHyidxY1ud+DWxTJNbeUPCS2EKAC/b3OFs6VzYBQ0F+S6XIl3hS9i57DPvgYnqxzjg
         4Bzk3vjk6ds4g+fEaoFcsIiNU7kuIu4ADZXzYMWHbojvuA7NC1I/OMw4tQvLtBDXE55j
         AXpp/eYsD+Qn0VFhMeLHJaIrmfbcZAqqKKZnUCTspAkKb5F3BFSwln9XDy5lTSNJhk5Y
         8uMBIQUG73af2WWAAGEssW+GWX7pYhv5uDH4ty59sZTG6rB8yjwEP0iBuREWyGFDcYT4
         fPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=r3C3Y0IJstOFY21HYumFx0TAFpm3BHwTb33PtAff3GA=;
        b=PBB5ebXFHU2olkhMeRfDK+FwblCwSjbSlWw1EO4XJBRfml6of7RUfFfj6sbXTs5IdL
         vURsx3J1KcMeeK63gsbp44syBjQSJs2NodfEkn3ZnDsrg83mcqvhNPakXsqooZnTYgfa
         iV+Im47EMcTJqwSIJN2Y6lYGE+tID32UV75rhue3CT8/56Vpbuj8M9noVtZT6f39WZA3
         5dHkhcb/C1KmlzE4ogXFFBdQD06SbeJtxis4kMcW77FW22+DsMu+CSFOX2wowTwh6SBA
         sUrauSZ2br39WNaKI2qep7gRYKfz+954SgrAeBJxkNuDTb3uDtIJkzFKd1qyCSWyuGmY
         WBQw==
X-Gm-Message-State: APjAAAVqngupCyrV95TQlrIo2QrlQYC+GUotNVJdBRX8qlafVgyaO4+N
        YKlJ6iXLhlhOr6a/S3v3ub6dg/CWzXBWHg==
X-Google-Smtp-Source: APXvYqxBwDLLhK98zySunj4zT8h2AhT62rsflVivfX968eEv/WjPSFvv7qBJuJGDgmQ1GLW9HO+56Q==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr4068532wmg.48.1580206433136;
        Tue, 28 Jan 2020 02:13:53 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f4af:286:d323:b6e2? ([2a01:e34:ed2f:f020:f4af:286:d323:b6e2])
        by smtp.googlemail.com with ESMTPSA id n3sm23429584wrs.8.2020.01.28.02.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 02:13:52 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] Thermal for v5.6-rc1
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <288933ba-a1fd-5954-df09-edaa4ea24abc@linaro.org>
Date:   Tue, 28 Jan 2020 11:13:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.6-rc1

for you to fetch changes up to 2f23e319b133c7392493e77f515a237c8e1e6dd6:

  thermal: stm32: Fix low threshold interrupt flood (2020-01-27 15:40:26
+0100)

Thanks!

----------------------------------------------------------------
- Depromote debug print on the db8500 platform (Linus Walleij)

- Fix compilation warning when compiling with make W=1 (Amit Kucheria)

- Code cleanup and refactoring, regmap conversion and add hwmon
  support on Qoriq (Andrey Smirnov)

- Add an idle injection cpu cooling device and its documentation,
  rename the cpu_cooling device to cpufreq_cooling device (Daniel
  Lezcano)

- Convert unexported functions to static, add the __init annotation in
  the thermal-of code and remove the pointless wrapper functions
  (Daniel Lezcano)

- Fix register offset for Armada XP and register reset bit
  initialization (Zak Hays)

- Enable hwmon on the rockchip (Stefan Schaeckeler)

- Add the thermal sensor for the H6/H5/H3/A64/A83T/R40 sun8i platform
  and their device tree bindings, followed by a fix for the ths number
  and the sparse warnings (Yangtao Li)

- Code cleanup for the sun8i and hwmon support (Yangtao Li)

- Silent some messages which are misleading given the changes made in
  the previous version on generic-adc (Martin Blumenstingl)

- Rename exynos to Exynos (Krzysztof Kozlowski)

- Add the bcm2711 thermal driver with the device tree bindings (Stefan
  Wahren)

- Use usleep_range() instead of udelay() as the call is always done in
  a sleep-able context (Geert Uytterhoeven)

- Do code cleanup and re-organization to set the scene for a new
  process for the brcmstb (Florian Fainelli)

- Fix bindings check issues on brcm (Stefan Wahren)

- Add Jasper Lake support on int340x (Nivedita Swaminathan)

- Add Comet Lake support on intel pch (Gayatri Kammela)

- Fix unmatched pci_release_region() on x86 (Chuhong Yuan)

- Remove temperature boundaries for rcar and rcar3 (Niklas Söderlund)

- Fix return value to -ENODEV when thermal_zone_of_sensor_register()
  is called with the of-node is missing (Peter Mamonov)

- Code cleanup, interrupt bouncing, and better support on stm32
  (Pascal Paillet)

----------------------------------------------------------------
Amit Kucheria (11):
      thermal: of-thermal: Appease the kernel-doc deity
      thermal: cpu_cooling: Appease the kernel-doc deity
      thermal: step_wise: Appease the kernel-doc deity
      thermal: devfreq_cooling: Appease the kernel-doc deity
      thermal: max77620: Appease the kernel-doc deity
      thermal: mediatek: Appease the kernel-doc deity
      thermal: rockchip: Appease the kernel-doc deity
      thermal: samsung: Appease the kernel-doc deity
      thermal: tegra: Appease the kernel-doc deity
      thermal: amlogic: Appease the kernel-doc deity
      thermal: zx2967: Appease the kernel-doc deity

Andrey Smirnov (12):
      thermal: qoriq: Add local struct device pointer
      thermal: qoriq: Don't store struct thermal_zone_device reference
      thermal: qoriq: Add local struct qoriq_sensor pointer
      thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
      thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
      thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
      thermal: qoriq: Drop unnecessary drvdata cleanup
      thermal: qoriq: Convert driver to use regmap API
      thermal: qoriq: Enable all sensors before registering them
      thermal: qoriq: Do not report invalid temperature reading
      thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
      thermal: qoriq: Add hwmon support

Chuhong Yuan (1):
      thermal: intel: Fix unmatched pci_release_region

Daniel Lezcano (6):
      thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
      thermal/drivers/cpu_cooling: Add idle cooling device documentation
      thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
      thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
      thermal/drivers/of-thermal: Make of_thermal_destroy_zones static
      thermal/drivers/of-thermal: Move the of_thermal_free_zone() to the
init section

Florian Fainelli (6):
      thermal: brcmstb_thermal: Do not use DT coefficients
      thermal: brcmstb_thermal: Prepare to support a different process
      dt-bindings: thermal: Define BCM7216 thermal sensor compatible
      thermal: brcmstb_thermal: Add 16nm process thermal parameters
      thermal: brcmstb_thermal: Restructure interrupt registration
      thermal: brcmstb_thermal: Register different ops per process

Gayatri Kammela (1):
      thermal: intel: intel_pch_thermal: Add Comet Lake (CML) platform
support

Geert Uytterhoeven (1):
      thermal: rcar_thermal: Use usleep_range() instead of udelay()

Krzysztof Kozlowski (1):
      thermal: exynos: Rename Samsung and Exynos to lowercase

Linus Walleij (1):
      thermal: db8500: Depromote debug print

Martin Blumenstingl (2):
      thermal: generic-adc: silence "no lookup table" on deferred probe
      thermal: generic-adc: silence info message for IIO_TEMP channels

Niklas Söderlund (2):
      thermal: rcar_thermal: Remove temperature bound
      thermal: rcar_gen3_thermal: Remove temperature bound

Pascal Paillet (6):
      thermal: stm32: Fix icifr register name
      thermal: stm32: Rework sensor mode management
      thermal: stm32: Disable interrupts at probe
      thermal: stm32: Handle multiple trip points
      thermal: stm32: Improve temperature computing
      thermal: stm32: Fix low threshold interrupt flood

Peter Mamonov (1):
      thermal: of: Make thermal_zone_of_sensor_register return -ENODEV
if a sensor OF node is missing

Stefan Schaeckeler (1):
      thermal: rockchip: Enable hwmon

Stefan Wahren (5):
      dt-bindings: Add Broadcom AVS RO thermal
      thermal: Add BCM2711 thermal driver
      ARM: dts: bcm2711: Enable thermal
      ARM: configs: Build BCM2711 thermal as module
      dt-bindings: brcm,avs-ro-thermal: Fix binding check issues

Swaminathan, Nivedita (1):
      thermal: int340x: processor_thermal: Add Jasper Lake support

Yangtao Li (6):
      thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40
      dt-bindings: thermal: Add YAML schema for sun8i-thermal driver
bindings
      thermal: sun8i: Fix r40 ths number
      thermal: sun8i: Fix using plain integer as NULL pointer in
sun8i_ths_resource_init
      thermal: sun8i: Remove unused variable and unneeded macros
      thermal: sun8i: Add hwmon support

Zak Hays (2):
      thermal: armada: Fix register offsets for AXP
      thermal: armada: Clear reset in armadaxp_init

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml | 160 ++++++
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  48 ++
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |   8 +-
 .../driver-api/thermal/cpu-idle-cooling.rst        | 189 ++++++
 .../driver-api/thermal/exynos_thermal.rst          |   8 +-
 MAINTAINERS                                        |  13 +-
 arch/arm/boot/dts/bcm2711.dtsi                     |  12 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |  35 +-
 drivers/thermal/Makefile                           |   4 +-
 drivers/thermal/amlogic_thermal.c                  |   6 +-
 drivers/thermal/armada_thermal.c                   |   5 +-
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c         | 123 ++++
 drivers/thermal/broadcom/brcmstb_thermal.c         |  96 ++--
 drivers/thermal/clock_cooling.c                    |   2 +-
 .../thermal/{cpu_cooling.c => cpufreq_cooling.c}   |   7 +-
 drivers/thermal/cpuidle_cooling.c                  | 232 ++++++++
 drivers/thermal/db8500_thermal.c                   |   4 +-
 drivers/thermal/devfreq_cooling.c                  |   3 +-
 drivers/thermal/fair_share.c                       |   4 +-
 drivers/thermal/gov_bang_bang.c                    |   4 +-
 .../int340x_thermal/processor_thermal_device.c     |   4 +
 drivers/thermal/intel/intel_pch_thermal.c          |  10 +-
 drivers/thermal/max77620_thermal.c                 |   2 +-
 drivers/thermal/mtk_thermal.c                      |  12 +-
 drivers/thermal/of-thermal.c                       |  70 +--
 drivers/thermal/qoriq_thermal.c                    | 337 ++++++-----
 drivers/thermal/rcar_gen3_thermal.c                |   4 +-
 drivers/thermal/rcar_thermal.c                     |   9 +-
 drivers/thermal/rockchip_thermal.c                 |  34 +-
 drivers/thermal/samsung/Kconfig                    |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |   9 +-
 drivers/thermal/st/stm_thermal.c                   | 388 ++++---------
 drivers/thermal/step_wise.c                        |   4 +-
 drivers/thermal/sun8i_thermal.c                    | 639
+++++++++++++++++++++
 drivers/thermal/tegra/soctherm.c                   |  15 +-
 drivers/thermal/thermal-generic-adc.c              |  20 +-
 drivers/thermal/thermal_core.h                     |   2 -
 drivers/thermal/thermal_hwmon.c                    |  28 +
 drivers/thermal/thermal_hwmon.h                    |   7 +
 drivers/thermal/user_space.c                       |   4 +-
 drivers/thermal/zx2967_thermal.c                   |   1 +
 include/dt-bindings/thermal/thermal_exynos.h       |   2 +-
 include/linux/clock_cooling.h                      |   2 +-
 include/linux/cpu_cooling.h                        |  24 +-
 48 files changed, 2012 insertions(+), 590 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
 create mode 100644
Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
 create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c
 rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (98%)
 create mode 100644 drivers/thermal/cpuidle_cooling.c
 create mode 100644 drivers/thermal/sun8i_thermal.c

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

