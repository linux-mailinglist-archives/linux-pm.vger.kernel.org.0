Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264AA3BA969
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jul 2021 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhGCQUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Jul 2021 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCQUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jul 2021 12:20:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E0C061762
        for <linux-pm@vger.kernel.org>; Sat,  3 Jul 2021 09:17:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l8so16319064wry.13
        for <linux-pm@vger.kernel.org>; Sat, 03 Jul 2021 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZdPNeZtD85HMHQMPlxPnkmLZsPVdIFskAC/aJLklqYc=;
        b=o1srpRp43tnjdCP4gzgpJ0j6YeHfZIRaM5ReH4SdcwHFr/65V818qXE3nFb6MyJIx/
         MR6XPuqI7bZEeyfcVJ6/sknftOTjyEJIfsWjkW/8ZrP/XgqVBhysIgKjxR3ugVJ3FoRO
         sK76SqePyPFJfTXIHlpQ3kGT+PhTL/+e2GIHMs5HWClaKEMp9OjOpcMRxQkL3/Tzpm0A
         Nvr+glFIvny162FobbUlBkE1k/w6sP3x8PPQqNAVjUKjutpPxBo2gidBtJtY+V8Nk4fb
         bLRQIUuAZgnrj3/1Ge9l1r7sJIZ0z2AyZn7aBkaEbJxR8qS1Pm0gHXsywqtUwFLW80zM
         78Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZdPNeZtD85HMHQMPlxPnkmLZsPVdIFskAC/aJLklqYc=;
        b=UV1nLDaLl67klDAOZi9EZ+skV3Osq+JsVHUPm+Yu9tGRizuwJGC4OOUcXD17RXYQ03
         e3iSlJyGPgbcRJdXBR73SGwvTgRfgsq30YVmusl/69jiM5927kShxn9kB/a2AzLPRBCZ
         GlLVaQy8+Rfw3v3hcT/MIHNgLBDddwkC2EmfNQvsP7hlO7PtBxUXrE+JE7rfz2yHbPeX
         7QOkjHj6Agvah4/oXpt0tjw7UC9ukzmPS93bn4XqLLib13kKX0dMd1fkIDbgLNnE1rMz
         9thz/cw1UeXKcLnh1/hsH60aGoyzl9465mHZAhNEsGds107kHLhmCsWrvACRdA8BPNKZ
         Zs3g==
X-Gm-Message-State: AOAM533vdRtr62uNj9xSDb9hjZG+mTbHgHc/subxPg+FUlr8tAxI15NQ
        rgxnkAbqORSTbCDmneCWG4I99w==
X-Google-Smtp-Source: ABdhPJznmqJqqPxclnzRZAwqxPFCb+0vQvuyIh3p4L42IifvuIhUEsliQDpdyy++Ncqz+q80qs4i0A==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr5992140wrp.148.1625329059804;
        Sat, 03 Jul 2021 09:17:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:11d:6696:65bb:ef7f? ([2a01:e34:ed2f:f020:11d:6696:65bb:ef7f])
        by smtp.googlemail.com with ESMTPSA id n29sm15448042wms.34.2021.07.03.09.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 09:17:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.14-rc1
Message-ID: <7a9ac752-2c1a-b05f-c5bd-9049c0bdd54e@linaro.org>
Date:   Sat, 3 Jul 2021 18:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.14-rc1

for you to fetch changes up to 1264017b3ab6d903760673a8515180af6e7a7f28:

  thermal/drivers/int340x/processor_thermal: Fix tcc setting (2021-06-29
08:15:53 +0200)

----------------------------------------------------------------
- Add rk3568 sensor support (Finley Xiao)

- Add missing MODULE_DEVICE_TABLE for the Spreadtrum sensor (Chunyan
  Zhang)

- Export additionnal attributes for the int340x thermal processor
  (Srinivas Pandruvada)

- Add SC7280 compatible for the tsens driver (Rajeshwari Ravindra
  Kamble)

- Fix kernel documentation for thermal_zone_device_unregister()	and
  use devm_platform_get_and_ioremap_resource() (Yang Yingliang)

- Fix coefficient calculations for the rcar_gen3 sensor driver (Niklas
  Söderlund)

- Fix shadowing variable rcar_gen3_ths_tj_1 (Geert Uytterhoeven)

- Add missing of_node_put() for the iMX and Spreadtrum sensors
  (Krzysztof Kozlowski)

- Correct compile-testing of tegra drivers, add tegra3 DT bindings and
  new thermal sensor for tegra3 (Dmitry Osipenko)

- Stop the thermal zone monitoring when unregistering it to prevent a
  temperature update without the 'get_temp' callback (Dmitry Osipenko)

- Add rk3568 DT bindings, convert bindings to yaml schemas and add the
  corresponding compatible in the Rockchip sensor (Ezequiel Garcia)

- Add the sc8180x compatible for the Qualcomm tsensor (Bjorn Andersson)

- Use the find_first_zero_bit()	function instead of custom code (Andy
  Shevchenko)

- Fix the kernel doc for the device cooling device (Yang Li)

- Reorg the processor thermal int340x to set the scene for the PCI
  mmio driver (Srinivas Pandruvada)

- Add PCI MMIO driver for the int340x processor thermal driver
  (Srinivas Pandruvada)

- Add hwmon sensors for the mediatek sensor (Frank Wunderlich)

- Fix warning for return value reported by Smatch for the int340x
  thermal processor (Srinivas Pandruvada)

- Fix wrong register access and decoding for the int340x thermal
  processor (Srinivas Pandruvada)

----------------------------------------------------------------
Andy Shevchenko (1):
      thermal/drivers/intel/intel_soc_dts_iosf: Switch to use
find_first_zero_bit()

Bjorn Andersson (1):
      dt-bindings: thermal: tsens: Add sc8180x compatible

Chunyan Zhang (1):
      thermal/drivers/sprd: Add missing MODULE_DEVICE_TABLE

Dmitry Osipenko (4):
      thermal/drivers/tegra: Correct compile-testing of drivers
      dt-bindings: thermal: Add binding for Tegra30 thermal sensor
      thermal/core/thermal_of: Stop zone device before unregistering it
      thermal/drivers/tegra: Add driver for Tegra30 thermal sensor

Ezequiel Garcia (2):
      dt-bindings: thermal: convert rockchip-thermal to json-schema
      dt-bindings: rockchip-thermal: Support the RK3568 SoC compatible

Finley Xiao (1):
      thermal/drivers/rockchip: Support RK3568 SoCs in the thermal driver

Frank Wunderlich (1):
      thermal/drivers/mediatek: Add sensors-support

Geert Uytterhoeven (1):
      thermal/drivers/rcar_gen3_thermal: Do not shadow rcar_gen3_ths_tj_1

Krzysztof Kozlowski (2):
      thermal/drivers/imx_sc: Add missing of_node_put for loop iteration
      thermal/drivers/sprd: Add missing of_node_put for loop iteration

Niklas Söderlund (1):
      thermal/drivers/rcar_gen3_thermal: Fix coefficient calculations

Rajeshwari Ravindra Kamble (1):
      dt-bindings: thermal: tsens: Add compatible string to TSENS
binding for SC7280

Srinivas Pandruvada (6):
      thermal/drivers/int340x: processor_thermal: Export mailbox interface
      thermal/drivers/int340x: processor_thermal: Export additional
attributes
      thermal/drivers/int340x/processor_thermal: Split enumeration and
processing part
      thermal/drivers/int340x/processor_thermal: Add PCI MMIO based
thermal driver
      thermal/drivers/int340x/processor_thermal: Fix warning for return
value
      thermal/drivers/int340x/processor_thermal: Fix tcc setting

Yang Li (1):
      thermal: devfreq_cooling: Fix kernel-doc

Yang Yingliang (2):
      thermal/core: Correct function name thermal_zone_device_unregister()
      thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()

 .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |  73 +++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
 .../bindings/thermal/rockchip-thermal.txt          |  85 ---
 .../bindings/thermal/rockchip-thermal.yaml         |  96 +++
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/thermal/imx_sc_thermal.c                   |   3 +
 drivers/thermal/intel/int340x_thermal/Makefile     |   3 +
 .../intel/int340x_thermal/int3401_thermal.c        |  82 +++
 .../int340x_thermal/processor_thermal_device.c     | 309 ++--------
 .../int340x_thermal/processor_thermal_device.h     |   9 +
 .../int340x_thermal/processor_thermal_device_pci.c | 373 ++++++++++++
 .../processor_thermal_device_pci_legacy.c          | 163 +++++
 .../intel/int340x_thermal/processor_thermal_mbox.c |  12 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |  55 ++
 drivers/thermal/intel/intel_soc_dts_iosf.c         |  15 +-
 drivers/thermal/mtk_thermal.c                      |   6 +
 drivers/thermal/rcar_gen3_thermal.c                |   7 +-
 drivers/thermal/rockchip_thermal.c                 | 121 ++++
 drivers/thermal/sprd_thermal.c                     |  16 +-
 drivers/thermal/st/st_thermal_memmap.c             |  13 +-
 drivers/thermal/tegra/Kconfig                      |   9 +-
 drivers/thermal/tegra/Makefile                     |   1 +
 drivers/thermal/tegra/tegra30-tsensor.c            | 673
+++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/thermal/thermal_of.c                       |   3 +
 25 files changed, 1748 insertions(+), 385 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
 delete mode 100644
Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
 create mode 100644 drivers/thermal/intel/int340x_thermal/int3401_thermal.c
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
 create mode 100644
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
 create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
