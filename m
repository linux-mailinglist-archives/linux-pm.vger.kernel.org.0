Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E812437910
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhJVOep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhJVOeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 10:34:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F15C061764
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 07:32:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso3609053wmd.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PNcwmUDAOK4zi7Fdx67XtZH80G3RW8rJDdaDa8v/yQw=;
        b=MmpSVY2TH/DDOuA9JovvGgJFC72YPMEPlm0V/LiD8UqFSOfLtV6C/zRlc0K8EI4Dyq
         f9wGp74Jsv7wTmULQoHNVl0c2/Dl470ObJLpkmPtFQW5x7Aa6TIU0dN0bqdasA2cyAQT
         UkOlg9oNkwL6IWTQ9u1kSOhKt1LH59WudWh6pl3mAUssedYzJlqRwhlbtj/1KIWaI42G
         2qxZlmQGDn5QcBrb7vYrDiSequFAFC+x/yFG/rmj3YoacPJLYYH+Us7l41oi5q2ato4d
         /X+7tYGj2on3glbmJWWIKxTJ3ObiElbLyibbEWEyVCXEE/NAOuMHGYQEbGyAFKQ5fUTT
         HDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PNcwmUDAOK4zi7Fdx67XtZH80G3RW8rJDdaDa8v/yQw=;
        b=f/7rwVr+9Jq5481YM1l5ZNdtGfe5AGRBus/QLlISjrP8FoKD3fByYPdxWuuLmy3uQE
         cToD4GbxDzFylys+4cgf1s87p5EJaq1v8Kr2S8NFSkOEaivLk+VQXft1Pr66vYezfSBl
         BdReU24smnERIRVlsbmczwqQfHTFDpJv0clz6KJYIQ1iCiLGBiMvbLHfN7WY3btcn58u
         LQhG7fFMYiQ0N/POn92SCifVijguag9m+DMI7xkexvtW7a7+ACtm1KsgKD25d1O2/7bd
         cFTp9Vs581Ocn/He56KttQMxDNUEIZEeLAqD9AUjckMnaqRwc7EB+ZAzHWcfhVrcOjMq
         TE+w==
X-Gm-Message-State: AOAM533vAP6kSr+wyo/rc9+Fg3ySOE2t456hN1fkf1OEK3qy4CcEi/P9
        5BkPzQRgxomyxnYtCHF9XuBErA==
X-Google-Smtp-Source: ABdhPJxB8HEaQtwmTUt3EAgd10zj7wUooGeYa3l8fx3eWKufh+9hESqQlK5PrevfDHs8ZWFiZhC2mQ==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr28799320wmq.171.1634913144442;
        Fri, 22 Oct 2021 07:32:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a691:2666:4ecf:26e9? ([2a01:e34:ed2f:f020:a691:2666:4ecf:26e9])
        by smtp.googlemail.com with ESMTPSA id r4sm10578304wrz.58.2021.10.22.07.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 07:32:23 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        liuyun01@kylinos.cn, Johan Jonker <jbx6244@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.16
Message-ID: <60a16c62-d14d-6943-f163-b2cc3d05c3b0@linaro.org>
Date:   Fri, 22 Oct 2021 16:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.16-rc1

for you to fetch changes up to a67a46af4ad6342378e332b7420c1d1a2818c53f:

  thermal/core: Deprecate changing cooling device state from userspace
(2021-10-21 17:35:11 +0200)

----------------------------------------------------------------
- Constify a variable in thermal mmio driver (Rikard Falkeborn)

- Add the current temperature in the netlink message when crossing a
  trip point in order to prevent useless back and forth reading from
  userspace (Daniel Lezcano)

- Add support for the 'HC' variant on PM8998 pmic in order to support
  vadc channels on recent QCom boards (Bjorn Andersson)

- Add support of calibration values from hardware when they are fused
  (Niklas Söderlund)

- Fix NULL pointer dereference from the thermal_release callback when
  an error occured in the thermal_zone_device_register() function
  (Yuanzheng Song)

- Fix use after free call in the __thermal_cooling_device_register()
  function in the error path (Ziyang Xuan)

- Fix compilation error for the LMh driver when CONFIG_QCOM_SCM is not
  set (Jackie Liu)

- Add a timeout when reading a register which can block forever under
  certain circumstances in the tsens driver (Ansuel Smith)

- Add DT binding for the reset lines and use them in the rockchip
  sensor driver (Johan Jonker)

- Add new uniphier NX1 SoC temperature sensor (Kunihiko Hayashi)

- Save and restore the TCC value in the int340x driver (Antoine
  Tenart)

- Deprecate the cooling device state sysfs file writable and the user
  space governor (Daniel Lezcano)

----------------------------------------------------------------
Ansuel Smith (1):
      thermal/drivers/tsens: Add timeout to get_temp_tsens_valid

Antoine Tenart (1):
      thermal/drivers/int340x: Improve the tcc offset saving for
suspend/resume

Bjorn Andersson (2):
      dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor
bindings
      thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant

Daniel Lezcano (3):
      thermal/drivers/netlink: Add the temperature when crossing a trip
point
      thermal/core: Make the userspace governor deprecated
      thermal/core: Deprecate changing cooling device state from userspace

Jackie Liu (1):
      thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM

Johan Jonker (3):
      dt-bindings: thermal: allow more resets for tsadc node in
rockchip-thermal.yaml
      dt-bindings: thermal: remove redundant comments from
rockchip-thermal.yaml
      thermal/drivers/rockchip_thermal: Allow more resets for tsadc node

Kunihiko Hayashi (2):
      dt-bindings: thermal: uniphier: Add binding for NX1 SoC
      thermal/drivers/uniphier: Add compatible string for NX1 SoC

Niklas Söderlund (2):
      thermal: rcar_gen3_thermal: Store thcode and ptat in priv data
      thermal: rcar_gen3_thermal: Read calibration from hardware

Rikard Falkeborn (1):
      thermal/drivers/thermal_mmio: Constify static struct thermal_mmio_ops

Yuanzheng Song (1):
      thermal/core: Fix null pointer dereference in thermal_release()

Ziyang Xuan (1):
      thermal/core: fix a UAF bug in __thermal_cooling_device_register()

 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
     | 149
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
     |  23 +++++++++++++----------
 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml   |   1 +
 drivers/thermal/gov_user_space.c
     |   9 +++++++++
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c
     |   8 +++++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
     |  36 ++++++++++++++++++++++++++++--------
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
     |   1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
     |  18 +++++++++++++++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c |   8 +++++++-
 drivers/thermal/qcom/Kconfig
     |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
     |  41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c
     |  29 ++++++++++++++---------------
 drivers/thermal/rcar_gen3_thermal.c
     | 113
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/thermal/rockchip_thermal.c
     |   2 +-
 drivers/thermal/thermal_core.c
     |  22 ++++++++++++++++------
 drivers/thermal/thermal_mmio.c
     |   2 +-
 drivers/thermal/thermal_netlink.c
     |  11 ++++++-----
 drivers/thermal/thermal_netlink.h
     |   8 ++++----
 drivers/thermal/thermal_sysfs.c
     |   3 +++
 drivers/thermal/uniphier_thermal.c
     |   4 ++++
 20 files changed, 408 insertions(+), 82 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
