Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC97E37368D
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhEEIpc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhEEIp1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 May 2021 04:45:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD5C0613ED
        for <linux-pm@vger.kernel.org>; Wed,  5 May 2021 01:44:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n205so926097wmf.1
        for <linux-pm@vger.kernel.org>; Wed, 05 May 2021 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eRyJCCqX++ZMTMmbDA1BtpKtMGNYR5O5IumovGrqjZE=;
        b=kPGY1mqR1zCkDmG+YWtt8MdCaHQzAg3hCsR/mx9FORjd+Y1kaYjyiEruSjMW5aPjVq
         Eeiqus7E9BKtqaLF1Cmrw+Mjv8jDmqltpotVfmQjMxnOkkK362dgAaUQ3/SU0htMZbOS
         an32rpaFuWHWjYx6vzwzzHUdNUXfX5qGuWERsPk6UH4BTEYsH9A89mxFOpXSVrsQmMul
         2Z925fBaanWoClhJxZFe8DwExdAaGU3SvxBo0wcQ9afX5GcHGdFj4sPAKdksoaSj/O7K
         WeASYHyt2r0jAw1zlq2/bHHjpPxado/KpYyCxIRhZYR/q9t6CpRIuWUgceZ3G4blW9Mc
         BoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eRyJCCqX++ZMTMmbDA1BtpKtMGNYR5O5IumovGrqjZE=;
        b=bfbtGSXl8h33rgoAKoQ9sfY6VZ6cGtK4pbo/qQok6Jk4OGScpT2E8SJSLgXmYP/pIG
         jQKe1TxyYyBJIb+4MIDOD0uyx/RzOxduwjliZ/aPQ6Pi9w7HUg2oCC4816DO0O1rT0Ke
         I3wzcZh4woUOjb5rZBMlEwLlFInLbMcTmFuJdgQs5Z2IxaT+1u8v2zP8b04pD8W7OknY
         rJf9jdVKppmwpTN9eM6TW5GV8/RB6V6zxp2oUkeGkQaBQ39JbbQPegaGhAmH41AlhtNP
         mg2pNBmm3D2AsEYNUmMRSJg8qL0/bTuIrJSIade5kx+/ZiMmCFSCuW7zP6i0XLzFIcmk
         WREw==
X-Gm-Message-State: AOAM531oz1mF/QeTwrffE0eiTUNOO8fLIBkGU/eWCOZEnhMyF498KK4C
        CL8VzEbPv/gcP7EleApjPlJWiw==
X-Google-Smtp-Source: ABdhPJwRiGN+664q0jJYpBQBS9k04dPBzpvSRA/5ECjk9lCtruz23j9gPPHfKN21mMTMCa2v3XpGFg==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr32632646wme.172.1620204268191;
        Wed, 05 May 2021 01:44:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:55a2:904c:d91e:5ce4? ([2a01:e34:ed2f:f020:55a2:904c:d91e:5ce4])
        by smtp.googlemail.com with ESMTPSA id b6sm4642618wmj.2.2021.05.05.01.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 01:44:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        unixbhaskar@gmail.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, zhang.yunkai@zte.com.cn,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Colin King <colin.king@canonical.com>,
        =?UTF-8?B?6auY5LqR6ZyEIChKZXNvbiBH?= =?UTF-8?B?YW8p?= 
        <jeson.gao@unisoc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        brian-sy yang <brian-sy.yang@mediatek.com>,
        David Collins <collinsd@codeaurora.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        zhuguangqing83 <zhuguangqing83@gmail.com>,
        Robert Foss <robert.foss@linaro.org>, gongruiqi1@huawei.com,
        yebin10@huawei.com, dingsenjie@yulong.com,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        rafal@milecki.pl, Lin Ruizhe <linruizhe@huawei.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [git pull] Thermal material for v5.13-rc
Message-ID: <aaa1d843-a8fc-ed31-495d-45080a944558@linaro.org>
Date:   Wed, 5 May 2021 10:44:25 +0200
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

please consider these thermal changes for v5.13-rc1

Thanks

  -- Daniel

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.13-rc1

for you to fetch changes up to c310e546164d5cca4c12faf9582b75989b030b68:

  thermal/drivers/mtk_thermal: Remove redundant initializations of
several variables (2021-04-22 23:51:32 +0200)

----------------------------------------------------------------
- Remove duplicate error message for the amlogic driver (Tang Bin)

- Fix spellos in comments for the tegra and sun8i (Bhaskar Chowdhury)

- Add the missing fifth node on the rcar_gen3 sensor (Niklas
  Söderlund)

- Remove duplicate include in ti-bandgap (Zhang Yunkai)

- Assign error code in the error path in the function
  thermal_of_populate_bind_params() (Jia-Ju Bai)

- Fix spelling mistake in a comment 'disabed' -> 'disabled' (Colin Ian
  King)

- Use the device name instead of auto-numbering for a better
  identification of the cooling device (Daniel Lezcano)

- Improve a bit the division accuracy in the power allocator governor
  (Jeson Gao)

- Enable the missing third sensor on msm8976 (Konrad Dybcio)

- Add QCom tsens driver co-maintainer (Thara Gopinath)

- Fix memory leak and use after free errors in the core code (Daniel
  Lezcano)

- Add the MDM9607 compatible bindings (Konrad Dybcio)

- Fix trivial spello in the copyright name for Hisilicon (Hao Fang)

- Fix negative index array access when converting the frequency to
  power in the energy model (Brian-sy Yang)

- Add support for Gen2 new PMIC support for Qcom SPMI (David Collins)

- Update maintainer file for CPU cooling device section (Lukasz Luba)

- Fix missing put_device on error in the Qcom tsens driver (Guangqing
  Zhu)

- Add compatible DT binding for sm8350 (Robert Foss)

- Add support for the MDM9607's tsens driver (Konrad Dybcio)

- Remove duplicate error messages in thermal_mmio and the bcm2835
  driver (Ruiqi Gong)

- Add the Thermal Temperature Cooling driver (Zhang Rui)

- Remove duplicate error messages in the Hisilicon sensor driver (Ye
  Bin)

- Use the devm_platform_ioremap_resource_byname() function instead of
  a couple of corresponding calls (dingsenjie)

- Sort the headers alphabetically in the ti-bandgap driver (Zhen Lei)

- Add missing property in the DT thermal sensor binding (Rafał
  Miłecki)

- Remove dead code in the ti-bandgap sensor driver (Lin Ruizhe)

- Convert the BRCM DT bindings to the yaml schema (Rafał Miłecki)

- Replace the thermal_notify_framework() call by a call to the
  thermal_zone_device_update() function. Remove the function as well
  as the corresponding documentation (Thara Gopinath)

- Add support for the ipq8064-tsens sensor along with a set of
  cleanups and code preparation (Ansuel Smith)

- Add a lockless __thermal_cdev_update() function to improve the
  locking scheme in the core code and governors (Lukasz Luba)

- Fix multiple cooling device notification changes (Lukasz Luba)

- Remove unneeded variable initialization (Colin Ian King)

----------------------------------------------------------------
Ansuel Smith (9):
      thermal/drivers/tsens: Don't hardcode sensor slope
      thermal/drivers/tsens: Convert msm8960 to reg_field
      thermal/drivers/tsens: Add VER_0 tsens version
      thermal/drivers/tsens: Use init_common for msm8960
      thermal/drivers/tsens: Fix bug in sensor enable for msm8960
      thermal/drivers/tsens: Replace custom 8960 apis with generic apis
      thermal/drivers/tsens: Drop unused define for msm8960
      thermal/drivers/tsens: Add support for ipq8064-tsens
      dt-bindings: thermal: tsens: Document ipq8064 bindings

Bhaskar Chowdhury (2):
      thermal: Fix a typo in the file soctherm.c
      thermal: Fix couple of spellos in the file sun8i_thermal.c

Colin Ian King (2):
      thermal: Fix spelling mistake "disabed" -> "disabled"
      thermal/drivers/mtk_thermal: Remove redundant initializations of
several variables

Daniel Lezcano (8):
      thermal/drivers/core: Use a char pointer for the cooling device name
      thermal/drivers/cpufreq_cooling: Use device name instead of
auto-numbering
      thermal/drivers/devfreq_cooling: Use device name instead of
auto-numbering
      thermal/drivers/cpuidle_cooling: Use device name instead of
auto-numbering
      thermal/drivers/cpufreq_cooling: Remove unused list
      thermal/core: Fix memory leak in the error path
      thermal/drivers/devfreq_cooling: Fix wrong return on error path
      thermal/drivers/cpuidle_cooling: Fix use after error

David Collins (1):
      thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 1
PMIC peripherals

Guangqing Zhu (1):
      thermal/drivers/tsens: Fix missing put_device error

Hao Fang (1):
      thermal/drivers/hisi: Use the correct HiSilicon copyright

Jia-Ju Bai (1):
      thermal: thermal_of: Fix error return code of
thermal_of_populate_bind_params()

Konrad Dybcio (3):
      thermal/drivers/qcom/tsens_v1: Enable sensor 3 on MSM8976
      dt-bindings: tsens: qcom: Document MDM9607 compatible
      thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607

Lin Ruizhe (1):
      thermal/drivers/ti-soc-thermal/bandgap Remove unused variable 'val'

Lukasz Luba (7):
      MAINTAINERS: update thermal CPU cooling section
      thermal/core: Create a helper __thermal_cdev_update() without a lock
      thermal/core/power_allocator: Maintain the device statistics from
going stale
      thermal/core/power_allocator: Update once cooling devices when
temp is low
      thermal/core/fair share: Lock the thermal zone while looping over
instances
      thermal/core/fair share: Use the lockless __thermal_cdev_update()
function
      thermal/core/power allocator: Use the lockless
__thermal_cdev_update() function

Niklas Söderlund (2):
      thermal: rcar_gen3_thermal: Add support for up to five TSC nodes
      dt-bindings: thermal: rcar-gen3-thermal: Support five TSC nodes on
r8a779a0

Rafał Miłecki (2):
      dt-bindings: thermal: thermal-sensor: require "#thermal-sensor-cells"
      dt-bindings: thermal: brcm,ns-thermal: Convert to the json-schema

Robert Foss (1):
      dt-bindings: thermal: qcom-tsens: Add compatible for sm8350

Ruiqi Gong (2):
      thermal/drivers/thermal_mmio: Remove redundant dev_err call in
thermal_mmio_probe()
      thermal/drivers/bcm2835: Remove redundant dev_err call in
bcm2835_thermal_probe()

Tang Bin (1):
      thermal: amlogic: Omit superfluous error message in
amlogic_thermal_probe()

Thara Gopinath (4):
      MAINTAINERS: Add co-maintainer for Qualcomm tsens thermal drivers
      iwlwifi: mvm: tt: Replace thermal_notify_framework
      thermal/core: Remove thermal_notify_framework
      Documentation: driver-api: thermal: Remove
thermal_notify_framework from documentation

Ye Bin (1):
      thermal/drivers/hisi: Remove redundant dev_err call in
hisi_thermal_probe()

Zhang Rui (1):
      thermal/drivers/intel: Introduce tcc cooling driver

Zhang Yunkai (1):
      thermal:ti-soc-thermal: Remove duplicate include in ti-bandgap

Zhen Lei (1):
      thermal/drivers/ti-soc-thermal/ti-bandgap: Rearrange all the
included header files alphabetically

brian-sy yang (1):
      thermal/drivers/cpufreq_cooling: Fix slab OOB issue

dingsenjie (1):
      thermal/drivers/tegra: Use devm_platform_ioremap_resource_byname

jeson.gao (1):
      thermal/core/power_allocator: Using round the division when
re-divvying up power

 .../bindings/thermal/brcm,ns-thermal.txt           |  37 ----
 .../bindings/thermal/brcm,ns-thermal.yaml          |  60 ++++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  59 +++++-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  43 +++-
 .../bindings/thermal/thermal-sensor.yaml           |   3 +
 Documentation/driver-api/thermal/sysfs-api.rst     |  12 +-
 MAINTAINERS                                        |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   4 +-
 drivers/thermal/amlogic_thermal.c                  |   4 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   1 -
 drivers/thermal/cpufreq_cooling.c                  |  49 ++---
 drivers/thermal/cpuidle_cooling.c                  |  37 ++--
 drivers/thermal/devfreq_cooling.c                  |  25 +--
 drivers/thermal/gov_fair_share.c                   |  11 +-
 drivers/thermal/gov_power_allocator.c              |  32 ++-
 drivers/thermal/hisi_thermal.c                     |  10 +-
 drivers/thermal/intel/Kconfig                      |  11 +
 drivers/thermal/intel/Makefile                     |   1 +
 drivers/thermal/intel/intel_tcc_cooling.c          | 129 +++++++++++
 drivers/thermal/mtk_thermal.c                      |  12 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  91 +++++---
 drivers/thermal/qcom/tsens-8960.c                  | 235
++++++++++-----------
 drivers/thermal/qcom/tsens-v0_1.c                  |  98 ++++++++-
 drivers/thermal/qcom/tsens-v1.c                    |   4 +-
 drivers/thermal/qcom/tsens.c                       | 165 ++++++++++++---
 drivers/thermal/qcom/tsens.h                       |   6 +-
 drivers/thermal/rcar_gen3_thermal.c                |   3 +-
 drivers/thermal/sun8i_thermal.c                    |   4 +-
 drivers/thermal/tegra/soctherm.c                   |  15 +-
 drivers/thermal/thermal_core.c                     |  57 ++---
 drivers/thermal/thermal_core.h                     |   1 +
 drivers/thermal/thermal_helpers.c                  |  27 ++-
 drivers/thermal/thermal_mmio.c                     |   5 +-
 drivers/thermal/thermal_of.c                       |   7 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  37 ++--
 include/linux/thermal.h                            |   7 +-
 include/uapi/linux/thermal.h                       |   2 +-
 38 files changed, 863 insertions(+), 446 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
 create mode 100644 drivers/thermal/intel/intel_tcc_cooling.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
