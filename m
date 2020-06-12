Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA51F7DA5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLTcv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLTcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 15:32:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC563C08C5C1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2020 12:32:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t18so10976998wru.6
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2020 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tUqvqBVgxeRdW5EMIfy9jcDTOu5Jp/GlC+7mheXaX4o=;
        b=T21+HM0uG2C4M5Y48RMuRyTXBxi+8a616OxL7aL90/tJbqHM0cIOXn/mBTjLg21G8u
         iT0Uutjlr4xjHCikNOGgGL/hXHu9lwtf/sZtGc9RYchyHSeIKOqlH4o1iSSRdls9Xa9f
         ORWwOcEprWFemqNfzngTQ1OAEKJumfNxPzTo0/d/2OmT4FI94+G+IYJzvpygp4QMZRao
         xTXeQ3gMI4tkZRnwc7jZC5KjF+KqgOOVeb1jQqYSkvEwVMdiJ1QbIuXdz5t2dD1hLIZ8
         +COc+Zdd5zBqcFiIfaFm1ntnmKTnYWnI7n6kcimOSfD8xwsxEEzps8LyC/caRzcOi8c0
         J/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tUqvqBVgxeRdW5EMIfy9jcDTOu5Jp/GlC+7mheXaX4o=;
        b=OeINSSIZJI8SK8pbzQPMKzyojpQr+2Tr5eXmA7h58/vO2f7Zn4wRVRH4Hb/sO5W5l7
         cjebaHEQIkBs9DEwChls7pJL+kNsRz/o2yoNgLWyJdW1wYGPbvWZ4+NxA5YduzvaKRTo
         JV85DCaUFkCG9Vt/Bt2vjPNWVCfTHi2tzaxjXeDu9MX+90FVLMzCnDtMrJR7nX78jyOL
         Mt2YbFqMoEWb3qZDUFsfOsydhL05fFfoG8hlhPFRvuZLNfN57D7/10qQmKVZeTR0yLpa
         hgq1CZq61F78syiJ16U+i6FsU9B2UGhc3gwuXa3wXAHFlxF/AP7i/FlsJstI9LQGXpKz
         UxDg==
X-Gm-Message-State: AOAM5332ysJqseMYkGmxgpBHYmQVRC5D6clZrKNNdWIZ9SnpkG5jfA/1
        qgjvFtOhiI1hNU/yzUFpf02S50FnfoY=
X-Google-Smtp-Source: ABdhPJxEJRuwlj5haNUN+JzO7Ohx9NZF/MFacTOr7UBAEmJ1rTY8tnnWYapSH5pM+XXccyo1JQWkpg==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr461164wmm.158.1591990365821;
        Fri, 12 Jun 2020 12:32:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:47e:bdb2:db1c:9e86? ([2a01:e34:ed2f:f020:47e:bdb2:db1c:9e86])
        by smtp.googlemail.com with ESMTPSA id j11sm10837769wru.69.2020.06.12.12.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 12:32:45 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.8-rc1
Message-ID: <065248c0-668a-c84c-ae89-dcd29f0d09ac@linaro.org>
Date:   Fri, 12 Jun 2020 21:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.8-rc1

for you to fetch changes up to 8d485da0ddee79d0e6713405694253d401e41b93:

  thermal/int340x_thermal: Don't require IDSP to exist (2020-05-29
20:26:51 +0200)

----------------------------------------------------------------
- Add the hwmon support on the i.MX SC (Anson Huang)

- Thermal framework cleanups (self-encapsulation, pointless stubs,
  private structures) (Daniel Lezcano)

- Use the PM QoS frequency changes for the devfreq cooling device (Matthias
  Kaehlcke)

- Remove duplicate error messages from platform_get_irq() error handling
  (Markus Elfring)

- Add support for the bandgap sensors (Keerthy)

- Statically initialize .get_mode/.set_mode ops (Andrzej Pietrasiewicz)

- Add Renesas R-Car maintainer entry (Niklas Söderlund)

- Fix error checking after calling ti_bandgap_get_sensor_data() for the
TI SoC
  thermal (Sudip Mukherjee)

- Add latency constraint for the idle injection, the DT binding and the
change
  the registering function (Daniel Lezcano)

- Convert the thermal framework binding to the Yaml schema (Amit Kucheria)

- Replace zero-length array with flexible-array on i.MX 8MM (Gustavo A.
R. Silva)

- Thermal framework cleanups (alphabetic order for heads, replace
module.h by
  export.h, make file naming consistent) (Amit Kucheria)

- Merge tsens-common into the tsens driver (Amit Kucheria)

- Fix platform dependency for the Qoriq driver (Geert Uytterhoeven)

- Clean up the rcar_thermal_update_temp() function in the rcar thermal
driver
  (Niklas Söderlund)

- Fix the TMSAR register for the TMUv2 on the Qoriq platform (Yuantian Tang)

- Export GDDV, OEM vendor variables, and don't require IDSP for the int340x
  thermal driver - trivial conflicts fixed (Matthew Garrett)

----------------------------------------------------------------
Amit Kucheria (18):
      dt-bindings: thermal: Add yaml bindings for thermal sensors
      dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
      dt-bindings: thermal: Add yaml bindings for thermal zones
      thermal/core: Get rid of MODULE_* tags
      thermal/core: Replace module.h with export.h
      thermal/drivers/thermal_helpers: Sort headers alphabetically
      thermal/drivers/thermal_helpers: Include export.h
      thermal/drivers/thermal_hwmon: Sort headers alphabetically
      thermal/drivers/thermal_hwmon: Include export.h
      thermal/drivers/clock_cooling: Sort headers alphabetically
      thermal/drivers/clock_cooling: Include export.h
      thermal/drivers/cpufreq_cooling: Sort headers alphabetically
      thermal/drivers/cpufreq_cooling: Replace module.h with export.h
      thermal/drivers/of-thermal: Sort headers alphabetically
      thermal/drivers/user_space: Sort headers alphabetically
      thermal/governors: Prefix all source files with gov_
      thermal/of: Rename of-thermal.c
      drivers: thermal: tsens: Merge tsens-common.c into tsens.c

Andrzej Pietrasiewicz (1):
      thermal: int3400_thermal: Statically initialize
.get_mode()/.set_mode() ops

Anson Huang (1):
      thermal: imx_sc_thermal: Add hwmon support

Daniel Lezcano (15):
      thermal: core: Make thermal_zone_set_trips private
      thermal: core: Remove pointless debug traces
      thermal: Move default governor config option to the internal header
      thermal: Move struct thermal_attr to the private header
      thermal: Move internal IPA functions
      thermal: Move trip point structure definition to private header
      thermal: Move get_tz_trend to the internal header
      thermal: Move get_thermal_instance to the internal header
      thermal: Change IS_ENABLED to IFDEF in the header file
      thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
      thermal: Remove thermal_zone_device_update() stub
      powercap/drivers/idle_inject: Specify idle state max latency
      dt-bindings: thermal: Add the idle cooling device
      thermal/drivers/cpuidle_cooling: Change the registration function
      thermal: cpuidle: Register cpuidle cooling device

Geert Uytterhoeven (1):
      thermal: qoriq: Add platform dependencies

Gustavo A. R. Silva (1):
      thermal: imx8mm: Replace zero-length array with flexible-array

Keerthy (2):
      dt-bindings: thermal: k3: Add VTM bindings documentation
      thermal: k3: Add support for bandgap sensors

Markus Elfring (1):
      thermal: Delete an error message in four functions

Matthew Garrett (3):
      thermal/int340x_thermal: Export GDDV
      thermal/int340x_thermal: Export OEM vendor variables
      thermal/int340x_thermal: Don't require IDSP to exist

Matthias Kaehlcke (1):
      thermal: devfreq_cooling: Use PM QoS to set frequency limits

Niklas Söderlund (2):
      MAINTAINERS: Add entry for Renesas R-Car thermal drivers
      thermal: rcar_thermal: Clean up rcar_thermal_update_temp()

Sudip Mukherjee (1):
      thermal/drivers/ti-soc-thermal: Avoid dereferencing ERR_PTR

Yuantian Tang (1):
      thermal: qoriq: Update the settings for TMUv2

 .../bindings/thermal/thermal-cooling-devices.yaml  | 116 +++
 .../devicetree/bindings/thermal/thermal-idle.yaml  | 145 ++++
 .../bindings/thermal/thermal-sensor.yaml           |  72 ++
 .../devicetree/bindings/thermal/thermal-zones.yaml | 341 +++++++++
 .../bindings/thermal/ti,am654-thermal.yaml         |  56 ++
 MAINTAINERS                                        |   9 +
 drivers/cpuidle/cpuidle-arm.c                      |   3 +
 drivers/cpuidle/cpuidle-psci.c                     |   3 +
 drivers/powercap/idle_inject.c                     |  16 +-
 drivers/thermal/Kconfig                            |  14 +-
 drivers/thermal/Makefile                           |  11 +-
 drivers/thermal/clock_cooling.c                    |   3 +-
 drivers/thermal/cpufreq_cooling.c                  |  10 +-
 drivers/thermal/cpuidle_cooling.c                  |  63 +-
 drivers/thermal/devfreq_cooling.c                  |  70 +-
 drivers/thermal/{fair_share.c => gov_fair_share.c} |   0
 .../{power_allocator.c => gov_power_allocator.c}   |   0
 drivers/thermal/{step_wise.c => gov_step_wise.c}   |   0
 drivers/thermal/{user_space.c => gov_user_space.c} |   2 +-
 drivers/thermal/imx8mm_thermal.c                   |   2 +-
 drivers/thermal/imx_sc_thermal.c                   |   4 +
 .../intel/int340x_thermal/int3400_thermal.c        | 223 +++++-
 drivers/thermal/k3_bandgap.c                       | 264 +++++++
 drivers/thermal/qcom/Makefile                      |   4 +-
 drivers/thermal/qcom/tsens-common.c                | 843
---------------------
 drivers/thermal/qcom/tsens.c                       | 838
++++++++++++++++++++
 drivers/thermal/qcom/tsens.h                       |   5 -
 drivers/thermal/qoriq_thermal.c                    |  26 +-
 drivers/thermal/rcar_thermal.c                     |   9 +-
 drivers/thermal/rockchip_thermal.c                 |   4 +-
 drivers/thermal/st/st_thermal_memmap.c             |   4 +-
 drivers/thermal/st/stm_thermal.c                   |   4 +-
 drivers/thermal/thermal_core.c                     |  12 +-
 drivers/thermal/thermal_core.h                     |  52 ++
 drivers/thermal/thermal_helpers.c                  |  16 +-
 drivers/thermal/thermal_hwmon.c                    |   6 +-
 drivers/thermal/{of-thermal.c => thermal_of.c}     |  10 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   5 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   6 +-
 include/linux/cpu_cooling.h                        |  12 +-
 include/linux/idle_inject.h                        |   4 +
 include/linux/thermal.h                            |  84 +-
 42 files changed, 2303 insertions(+), 1068 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644
Documentation/devicetree/bindings/thermal/thermal-idle.yaml
 create mode 100644
Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644
Documentation/devicetree/bindings/thermal/thermal-zones.yaml
 create mode 100644
Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
 rename drivers/thermal/{fair_share.c => gov_fair_share.c} (100%)
 rename drivers/thermal/{power_allocator.c => gov_power_allocator.c} (100%)
 rename drivers/thermal/{step_wise.c => gov_step_wise.c} (100%)
 rename drivers/thermal/{user_space.c => gov_user_space.c} (100%)
 create mode 100644 drivers/thermal/k3_bandgap.c
 delete mode 100644 drivers/thermal/qcom/tsens-common.c
 rename drivers/thermal/{of-thermal.c => thermal_of.c} (100%)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
