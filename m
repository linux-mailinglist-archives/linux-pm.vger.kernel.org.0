Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA843C1628
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhGHPnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHPnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 11:43:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70548C061574
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 08:40:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d2so8134035wrn.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7o3jCjF52vu1m+SPPYBNztcE1ZA7aixghKNxFppt9FA=;
        b=z7Al6ICQJ+HJIkOrOcnpLbbNFf9wnKaNtjdk1nbOInTWoa9aW75evFkjor7Nc4rXiQ
         +CrZ2r8wyukbPoDnUAw5f4GrrT2Ce6ThW0bj2Z4aw+ESq0sbzW7MXh6ZFUQIVsvQBQLA
         9eMIcpwGLczwuumvCv4YguZaMOkDHNmVic/k0Hteul8go1xo8HsO+fZMg5pzbmAFmrlr
         VG0aLYLwoAmuhwi7U4817zsWXmu8tSEef8GAxMpA3t7/hHiblTztCvIztmjkgCWb9Q4v
         Y2Ui9yvHc9GeNchHImvAoE6LMaa8NYFMY6GhGgNk8mbrrvHnq/rmA7z5gyVoyjGkBr5p
         Kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7o3jCjF52vu1m+SPPYBNztcE1ZA7aixghKNxFppt9FA=;
        b=FDF+Ahqzfzcb0gyBrLKZWMfMyZzelO+4HLKzwENY/ccDJnl83ggSvlmkhw22YHCxKa
         TtKoGKeB6vl9vO+yohuZozFULQ76kMR3fod09KQJ/+C6sXJlCmiKxGN3wlX5X8LuMHBa
         DRu91uFRCexxjPyPyqCL8SAe8kXASBMyz6gUFaGM4U6gKhccPVFCcsCoMznXKP6nf9YJ
         RDzLd3VSN4SQXtvCjLqgiYFssUg+P3sZNK3tLYiN0ZqnEszdSYBMJW/tnFbOYus6crXa
         YKfU5+QsSlMGG0jr9sggzOWr1HRzrVF5kCjcIdh2cQB59aLLvBAr/jedRO1pflYg8ggs
         1oRw==
X-Gm-Message-State: AOAM5305g5edyTLD8wBrbJ6pHBGxJrqn/BDXM4uJqAuEnI6qeG8QMjl6
        ElrYdBeMZ1SMm2yGPplCaaTkFQ==
X-Google-Smtp-Source: ABdhPJwc87XRDZHEogMOh/eC4F2mcM/rap/waYz412NYfVxrKC3dF/C/EEt838n88wHEvFObtl6sLQ==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr34860965wrt.67.1625758839754;
        Thu, 08 Jul 2021 08:40:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b33a:9c9a:b724:1957? ([2a01:e34:ed2f:f020:b33a:9c9a:b724:1957])
        by smtp.googlemail.com with ESMTPSA id n18sm8258196wms.3.2021.07.08.08.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 08:40:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.14-rc1 #2
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
Message-ID: <8b2470a5-3090-87c3-0fad-d8eefdf54f4f@linaro.org>
Date:   Thu, 8 Jul 2021 17:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,


here is the second PR for v5.14-rc1.

I removed the two patches responsible of the compilation issue.

The branch was several days in linux-next before sending this PR in
addition to several local testing.

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.14-rc1

for you to fetch changes up to fe6a6de6692e7f7159c1ff42b07ecd737df712b4:

  thermal/drivers/int340x/processor_thermal: Fix tcc setting (2021-07-04
18:28:04 +0200)

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

- Add tegra3 thermal sensor DT bindings (Dmitry Osipenko)

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

Dmitry Osipenko (2):
      dt-bindings: thermal: Add binding for Tegra30 thermal sensor
      thermal/core/thermal_of: Stop zone device before unregistering it

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

 .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |  73 ++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
 .../bindings/thermal/rockchip-thermal.txt          |  85 -----
 .../bindings/thermal/rockchip-thermal.yaml         |  96 ++++++
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/thermal/imx_sc_thermal.c                   |   3 +
 drivers/thermal/intel/int340x_thermal/Makefile     |   3 +
 .../intel/int340x_thermal/int3401_thermal.c        |  82 +++++
 .../int340x_thermal/processor_thermal_device.c     | 309 +++--------------
 .../int340x_thermal/processor_thermal_device.h     |   9 +
 .../int340x_thermal/processor_thermal_device_pci.c | 373
+++++++++++++++++++++
 .../processor_thermal_device_pci_legacy.c          | 163 +++++++++
 .../intel/int340x_thermal/processor_thermal_mbox.c |  12 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |  55 +++
 drivers/thermal/intel/intel_soc_dts_iosf.c         |  15 +-
 drivers/thermal/mtk_thermal.c                      |   6 +
 drivers/thermal/rcar_gen3_thermal.c                |   7 +-
 drivers/thermal/rockchip_thermal.c                 | 121 +++++++
 drivers/thermal/sprd_thermal.c                     |  16 +-
 drivers/thermal/st/st_thermal_memmap.c             |  13 +-
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/thermal/thermal_of.c                       |   3 +
 22 files changed, 1066 insertions(+), 384 deletions(-)
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


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
