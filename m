Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB9407645
	for <lists+linux-pm@lfdr.de>; Sat, 11 Sep 2021 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhIKLeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Sep 2021 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKLeB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Sep 2021 07:34:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77728C061574
        for <linux-pm@vger.kernel.org>; Sat, 11 Sep 2021 04:32:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u15so505240wru.6
        for <linux-pm@vger.kernel.org>; Sat, 11 Sep 2021 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vxsbFoIk9HYRD3XO/1KdRiZnBW38kIVj5TBw1w/MO6E=;
        b=XiV+5KhOru+hWb6Yv9sNlSDz4UicdyfmjrVLCqu9D406hVMBk5vGzGp9Z6UWIzSr5i
         4kPjqbxix3vp8AMrWgSIYPn+5FMqJjyd54PG/ETNG8bT97imQ5n1uPL0Clejg576PDqu
         XTjfBJUtQUe9Ci91Ww4848LViW1HShACPjCCVQf62CPSFKfTxo9l1tMUdBMy4K0xtbQT
         F0qQ6UOPckofcnTqO2FH4bG9Kb8PDeXatjFxoi7W5CtGO/qaFiRg6JYD0TIxQasdkob1
         m8brTfJBjMLbYOhbw0S8WRycA4h7Ug1uOSz2IIEbUISQL2nueOQL3VGzLOKxqv5z3F+U
         SVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vxsbFoIk9HYRD3XO/1KdRiZnBW38kIVj5TBw1w/MO6E=;
        b=QoDs4uLzBjr488kMfXiSIWzEsHI7W94Bo/AeL5VjkaS3rz3Hpfp18ElgULS01EIxr+
         rkf7IBeR+FtsOdTMru2wG5I+GrEe8mGJ7kvfvZjJDsdWpb2NtalU94JF6QbgjvA203zj
         YYKQAkrq8jo4zkorHoJIBszBem8h5HfCENTcbTJDKlvOF6qZs2cLjuqmgHzfG7hAx2cI
         ICVZaSUlHDa3tRWXg1aDmzogxj/vt2/qs1z8bpGeiDINkdCh/HQ1TWzuHFP8na0YB67e
         Czl1YcohhNAco+7pcfmikrSJlWelMFwRh6DgXj/NEFeTF8Me3APd9KEGuY1Cybcs1/5i
         6/vA==
X-Gm-Message-State: AOAM531LYrRW6R/uWyNEyI8PQx80cjnl3WOp7ZESEUXPld4Pil+ReCtM
        J68vOqoC0mhp6iRNXTszHKOv8w==
X-Google-Smtp-Source: ABdhPJwjMBzR2ffn8jAGFh1AbITe77/i8s+3mSlG9ck2W5/+LbpKcGvQF2SC8tbu3kaeL9bsC7HUvQ==
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr2784474wra.258.1631359966747;
        Sat, 11 Sep 2021 04:32:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d36c:3c0c:8588:75db? ([2a01:e34:ed2f:f020:d36c:3c0c:8588:75db])
        by smtp.googlemail.com with ESMTPSA id f23sm1216764wmc.3.2021.09.11.04.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 04:32:46 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.15-rc1
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <1fc67de6-86b4-3ed5-cab0-cb8412c8e22a@linaro.org>
Date:   Sat, 11 Sep 2021 13:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.15-rc1

for you to fetch changes up to 70ee251ded6ba24c15537f4abb8a318e233d0d1a:

  thermal/drivers/qcom/spmi-adc-tm5: Don't abort probing if a sensor is
not used (2021-09-09 16:33:29 +0200)

----------------------------------------------------------------
- Add the tegra3 thermal sensor and fix the compilation testing on
  tegra by adding a dependency on ARCH_TEGRA along with COMPILE_TEST
  (Dmitry Osipenko)

- Fix the error code for the exynos when devm_get_clk() fails (Dan
  Carpenter)

- Add the TCC cooling support for AlderLake platform (Sumeet Pawnikar)

- Add support for hardware trip points for the rcar gen3 thermal
  driver and store TSC id as unsigned int (Niklas Söderlund)

- Replace the deprecated CPU-hotplug functions get_online_cpus() and
  put_online_cpus (Sebastian Andrzej Siewior)

- Add the thermal tools directory in the MAINTAINERS file (Daniel
  Lezcano)

- Fix the Makefile and the cross compilation flags for the userspace
  'tmon' tool (Rolf Eike Beer)

- Allow to use the IMOK independently from the GDDV on Int340x (Sumeet
  Pawnikar)

- Fix the stub thermal_cooling_device_register() function prototype
  which does not match the real function (Arnd Bergmann)

- Make the thermal trip point optional in the DT bindings (Maxime
  Ripard)

- Fix a typo in a comment in the core code (Geert Uytterhoeven)

- Reduce the verbosity of the trace in the SoC thermal tegra driver
  (Dmitry Osipenko)

- Add the support for the LMh (Limit Management hardware) driver on
  the QCom platforms (Thara Gopinath)

- Allow processing of HWP interrupt by adding a weak function in the
  Intel driver (Srinivas Pandruvada)

- Prevent an abort of the sensor probe is a channel is not used
  (Matthias Kaehlcke)

----------------------------------------------------------------
Arnd Bergmann (1):
      thermal/core: Fix thermal_cooling_device_register() prototype

Dan Carpenter (1):
      thermal/drivers/exynos: Fix an error code in exynos_tmu_probe()

Daniel Lezcano (1):
      MAINTAINERS: Add missing userspace thermal tools to the thermal
section

Dmitry Osipenko (3):
      thermal/drivers/tegra: Add driver for Tegra30 thermal sensor
      thermal/drivers/tegra: Correct compile-testing of drivers
      thermal/drivers/tegra-soctherm: Silence message about clamped
temperature

Geert Uytterhoeven (1):
      thermal: Spelling s/scallbacks/callbacks/

Matthias Kaehlcke (1):
      thermal/drivers/qcom/spmi-adc-tm5: Don't abort probing if a sensor
is not used

Maxime Ripard (1):
      dt-bindings: thermal: Make trips node optional

Niklas Söderlund (2):
      thermal/drivers/rcar_gen3_thermal: Add support for hardware trip
points
      thermal/drivers/rcar_gen3_thermal: Store TSC id as unsigned int

Rolf Eike Beer (2):
      thermal/tools/tmon: Improve the Makefile
      tools/thermal/tmon: Add cross compiling support

Sebastian Andrzej Siewior (1):
      thermal/drivers/intel_powerclamp: Replace deprecated CPU-hotplug
functions.

Srinivas Pandruvada (1):
      thermal/drivers/intel: Allow processing of HWP interrupt

Sumeet Pawnikar (2):
      drivers/thermal/intel: Add TCC cooling support for AlderLake platform
      thermal/drivers/int340x: Use IMOK independently

Thara Gopinath (3):
      firmware: qcom_scm: Introduce SCM calls to access LMh
      thermal/drivers/qcom: Add support for LMh driver
      dt-bindings: thermal: Add dt binding for QCOM LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml      |  82 +++
 .../devicetree/bindings/thermal/thermal-zones.yaml |   2 +-
 MAINTAINERS                                        |   1 +
 drivers/firmware/qcom_scm.c                        |  58 ++
 drivers/firmware/qcom_scm.h                        |   4 +
 .../intel/int340x_thermal/int3400_thermal.c        |  14 +-
 drivers/thermal/intel/intel_powerclamp.c           |   4 +-
 drivers/thermal/intel/intel_tcc_cooling.c          |   2 +
 drivers/thermal/intel/therm_throt.c                |   7 +-
 drivers/thermal/intel/thermal_interrupt.h          |   3 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/lmh.c                         | 232 +++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   6 +
 drivers/thermal/rcar_gen3_thermal.c                | 110 +++-
 drivers/thermal/samsung/exynos_tmu.c               |   1 +
 drivers/thermal/tegra/Kconfig                      |   9 +-
 drivers/thermal/tegra/Makefile                     |   1 +
 drivers/thermal/tegra/soctherm.c                   |   4 +-
 drivers/thermal/tegra/tegra30-tsensor.c            | 673
+++++++++++++++++++++
 include/linux/qcom_scm.h                           |  14 +
 include/linux/thermal.h                            |   7 +-
 tools/thermal/tmon/Makefile                        |  10 +-
 23 files changed, 1230 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
 create mode 100644 drivers/thermal/qcom/lmh.c
 create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
