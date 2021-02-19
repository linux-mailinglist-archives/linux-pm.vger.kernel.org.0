Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696CC31F8B0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSLzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 06:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBSLzh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 06:55:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804FC061786
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 03:54:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a4so5796664wro.8
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WVap+CgS0aKP4VB39WJ3ROwZ5qQnMNgJg14pvUUYfLM=;
        b=WJ5bALL8CDSUuxSPCnH33fOSEwekh0NISWkzhmQfaBd2jVVNNc+GIbewK6wTihahvC
         eIV8PougWWOdMT1NuP5Iav7dGKP/LEPLleTPpbVm2beXKbApbpCIARMqakrPl2KbIx6H
         PeKdNJRzTTJEePxfkfutw1OGohMXAJepMkwr4hFZmGCe1RKoGlO6hOCpFFgdvBKni/9a
         /pohVTwQsmVzhjEaCOgaAABdwxuz6n2WeG1jNI09tAOq/aT6M8BoUZkiJkEJVC7DOObP
         jvBg6bgoVzYOlqm/RLhdI7bXyH2zbDuO4pzPtJyKO8EQuaG3tVhEgQSoWLbl+4f56pb6
         Qkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WVap+CgS0aKP4VB39WJ3ROwZ5qQnMNgJg14pvUUYfLM=;
        b=ODVSSzl/hLGJs0JYW/MJo+YV6m6fA2IM6Zg45c7ZGfqG6Nw4h3QeRkKSLEq6AN2aaK
         DmsrohOVPKPgZSIedcA2mOGh+pzGPlN7l8lTmGkkoIknUgCLzesqDdmSN0KKm2Z2G+l9
         8lzR9AB5rN53ZDESFemzQOvc1De4FkGlmLaVaFm2ThI1b5G2e/eVSMhkntdvH5jZaNTV
         NYGd0jiGegSo3LaKh7fGfdIBBEuLcioXUsLkuKrNPZKKrbVE1m2k+3SCWLAzZVP7rdzs
         gNL7XSS3/lHfW7HJ1+Yd1CDTRTVMtw5O7PMu/2xBq/vPUF3R37IV8Nsc5I9KS7xb5hq8
         I4NA==
X-Gm-Message-State: AOAM530Mb3HoXthX+KWK8sYcJYAlQqYLkAiWz4mLTM+I1kQY/iiyfq7k
        hLzYo3kdmh2KBc6Bit4tkgQyU/JkVfg1DQ==
X-Google-Smtp-Source: ABdhPJwTvfhzpasaVE3SxdtLzXJnSqK85eR9miUwxJ/bVWscpSumktEeu1xI/d230pouuqeArMsZNA==
X-Received: by 2002:adf:a384:: with SMTP id l4mr8963178wrb.228.1613735695704;
        Fri, 19 Feb 2021 03:54:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7551:7d42:6e1e:750? ([2a01:e34:ed2f:f020:7551:7d42:6e1e:750])
        by smtp.googlemail.com with ESMTPSA id l17sm1569567wmq.46.2021.02.19.03.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 03:54:55 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.12-rc1
Message-ID: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
Date:   Fri, 19 Feb 2021 12:54:53 +0100
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

please consider pulling these thermal changes for v5.12-rc1

Note a set of changes for the qcom adc driver rely on an immutable
branch from the iio tree:
	https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1


The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.12-rc1

for you to fetch changes up to a51afb13311cd85b2f638c691b2734622277d8f5:

  thermal: cpufreq_cooling: freq_qos_update_request() returns < 0 on
error (2021-02-17 18:53:19 +0100)

----------------------------------------------------------------
- Use the newly introduced 'hot' and 'critical' ops for the acpi
  thermal driver (Daniel Lezcano)

- Remove the notify ops as it is no longer used (Daniel Lezcano)

- Remove the 'forced passive' option and the unused bind/unbind
  functions (Daniel Lezcano)

- Remove the THERMAL_TRIPS_NONE and the code cleanup around this
  macro (Daniel Lezcano)

- Rework the delays to make them pre-computed instead of computing
  them again and again at each polling interval (Daniel Lezcano)

- Remove the pointless 'thermal_zone_device_reset' function (Daniel
  Lezcano)

- Use the critical and hot ops to prevent an unexpected system
  shutdown on int340x (Kai-Heng Feng)

- Make the cooling device state private to the thermal subsystem
  (Daniel Lezcano)

- Prevent to use not-power-aware actor devices with the power
  allocator governor (Lukasz Luba)

- Remove 'zx' and 'tango' support along with the corresponding
  platforms (Arnd Bergman)

- Fix several issues on the Omap thermal driver (Tony Lindgren)

- Add support for adc-tm5 PMIC thermal monitor for Qcom
  platforms. Please note those changes rely on an immutable branch:
  iio-thermal-5.11-rc1/ib-iio-thermal-5.11-rc1 from the iio tree
  (Dmitry Baryshkov)

- Fix an initialization loop in the adc-tm5 (Colin Ian King)

- Fix a return error check in the cpufreq cooling device (Viresh Kumar)

----------------------------------------------------------------
Arnd Bergmann (2):
      thermal/drivers/tango: Remove tango driver
      thermal/drivers/zx: Remove zx driver

Colin Ian King (1):
      thermal: qcom: Fix comparison with uninitialized variable
channels_available

Craig Tatlor (1):
      fixp-arith: add a linear interpolation function

Daniel Lezcano (14):
      thermal/drivers/acpi: Use hot and critical ops
      thermal/core: Remove notify ops
      thermal/core: Remove the 'forced_passive' option
      thermal/core: Remove unused functions rebind/unbind exception
      thermal/core: Remove pointless test with the THERMAL_TRIPS_NONE macro
      acpi/drivers/thermal: Remove TRIPS_NONE cooling device binding
      thermal/core: Remove THERMAL_TRIPS_NONE test
      thermal/core: Remove unused macro THERMAL_TRIPS_NONE
      thermal/core: Precompute the delays from msecs to jiffies
      thermal/core: Use precomputed jiffies for the polling
      thermal/core: Remove ms based delay fields
      thermal/core: Remove pointless thermal_zone_device_reset() function
      thermal/core: Make cooling device state change private
      Merge remote-tracking branch
'iio-thermal-5.11-rc1/ib-iio-thermal-5.11-rc1' into testing

Dmitry Baryshkov (11):
      iio: adc: qcom-vadc: move several adc5 functions to common file
      iio: adc: qcom-vadc-common: use fixp_linear_interpolate
      iio: adc: move qcom-vadc-common.h to include dir
      iio: adc: qcom-spmi-adc5: use of_device_get_match_data
      iio: provide of_iio_channel_get_by_name() and devm_ version it
      iio: adc: move vadc_map_pt from header to the source file
      iio: adc: qcom-vadc-common: rewrite vadc7 die temp calculation
      iio: adc: qcom-vadc-common: simplify qcom_vadc_map_voltage_temp
      iio: adc: qcom-vadc-common: scale adcmap_100k_104ef_104fb
      dt-bindings: thermal: qcom: add adc-thermal monitor bindings
      thermal: qcom: add support for adc-tm5 PMIC thermal monitor

Kai-Heng Feng (2):
      thermal: int340x: Fix unexpected shutdown at critical temperature
      thermal: intel: pch: Fix unexpected shutdown at critical temperature

Lukasz Luba (1):
      thermal: power allocator: fail binding for non-power actor devices

Tony Lindgren (4):
      thermal: ti-soc-thermal: Skip pointless register access for dra7
      thermal: ti-soc-thermal: Fix stuck sensor with continuous mode for
4430
      thermal: ti-soc-thermal: Simplify polling with iopoll
      thermal: ti-soc-thermal: Use non-inverted define for omap4

Viresh Kumar (1):
      thermal: cpufreq_cooling: freq_qos_update_request() returns < 0 on
error

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 153 +++++
 .../devicetree/bindings/thermal/tango-thermal.txt  |  17 -
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 116 ----
 Documentation/driver-api/thermal/sysfs-api.rst     |  13 -
 drivers/acpi/thermal.c                             |  49 +-
 drivers/hwmon/pwm-fan.c                            |   1 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   3 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |  95 +---
 drivers/iio/adc/qcom-spmi-vadc.c                   |   3 +-
 drivers/iio/adc/qcom-vadc-common.c                 | 279 +++++----
 drivers/iio/inkern.c                               |  34 +-
 drivers/platform/x86/acerhdf.c                     |   3 +-
 drivers/thermal/Kconfig                            |  17 -
 drivers/thermal/Makefile                           |   2 -
 drivers/thermal/cpufreq_cooling.c                  |   2 +-
 drivers/thermal/da9062-thermal.c                   |   4 +-
 drivers/thermal/gov_power_allocator.c              |  37 +-
 drivers/thermal/gov_step_wise.c                    |  14 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   6 +
 drivers/thermal/intel/intel_pch_thermal.c          |   6 +
 drivers/thermal/khadas_mcu_fan.c                   |   1 -
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 623
+++++++++++++++++++++
 drivers/thermal/tango_thermal.c                    | 126 -----
 drivers/thermal/thermal_core.c                     |  72 +--
 drivers/thermal/thermal_core.h                     |   7 +-
 drivers/thermal/thermal_helpers.c                  |   7 +
 drivers/thermal/thermal_sysfs.c                    |  85 +--
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   7 +-
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |   4 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  54 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   2 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   6 +-
 drivers/thermal/zx2967_thermal.c                   | 256 ---------
 include/linux/fixp-arith.h                         |  19 +
 .../linux}/iio/adc/qcom-vadc-common.h              |  31 +-
 include/linux/iio/consumer.h                       |  36 ++
 include/linux/thermal.h                            |  18 +-
 39 files changed, 1218 insertions(+), 1002 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
 delete mode 100644
Documentation/devicetree/bindings/thermal/tango-thermal.txt
 delete mode 100644
Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
 delete mode 100644 drivers/thermal/tango_thermal.c
 delete mode 100644 drivers/thermal/zx2967_thermal.c
 rename {drivers => include/linux}/iio/adc/qcom-vadc-common.h (92%)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
