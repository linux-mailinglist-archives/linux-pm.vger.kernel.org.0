Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E612290022
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394789AbgJPIrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394788AbgJPIrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 04:47:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DBBC0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 01:47:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so1818988wrl.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=26IH4G1N/Js32Z6Db8oxyYdX3MbO7EjY0dLYS0HR0pY=;
        b=wwixGbOeBb+X2TxLeHVlysxw0H3LCvLuAMJHZEhQYSIuxEghJrN6flDtshl8ua6JWp
         36sTJWpk1fEkD5Kl33vc0MVwas7YoL2fQVdXbXZ/7xktJKRKPnk4q+P6goGcFmvrdhVj
         ehIbgdtoagmToDKtRrZca4w6U8DdD1SOQbRfqVV6GWEHVKPewuamwoyOaV0xexhUMX2C
         Aj4F841srlb5eGcXuyHs7vIcI1aJ0YPL/dSjNdidpmc81jr467KFncKdtXs1/1OSVI0o
         11FMWtAXPeedH/Ny7khGk5qqUtyYLNQ+/Z6Q3VsiZkoRuuVU0sGeGIQTvqYwhgjY4gh5
         AcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=26IH4G1N/Js32Z6Db8oxyYdX3MbO7EjY0dLYS0HR0pY=;
        b=Tbxy2Cfwo0SqrxcJ1Kv78qgcCyDSrtRbXn0XBhohJWcCN/YvAdW1/0SUTMnUeLUm2U
         clz9jE9JoIKcxy2W5na+v2Akig7203wTeelV8WqcamDIqPmQCDpJ9HQvz33o/2pyqJDW
         yzka483QVhSEOboKazEYFyuWg/0sM2bHw2ipOampUNOSKX8N2tFvLMWQDFDjbBXfryaN
         G0sBLfJveMDqoFVDl17dC49yrwQwEMeDcvl8mqi5+KDfG3VbLa6cebV5GOCdDBSHKlPj
         oHBvICEXWpZ5TzJdhzDhp9CFrHMGbM+ZUiB5+GoW0y8HyiTtWj6w+mj7MNyN+/cMy7pK
         L8+g==
X-Gm-Message-State: AOAM530rH2/ZI4ZQgcNKMttPEGAl4UM9H5h+G0jmQ73VBFb+c7yWG7t+
        vMR75qBM2VamfQUL8CmZ8Kdx8mgYuvEPuQ==
X-Google-Smtp-Source: ABdhPJwpxfPndPflMtom/crYO9+pMokVWyonyRJCg5829T7aatR+zjjeBAlinTCHGYbuauGU74zuaw==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr2793141wrn.188.1602838023583;
        Fri, 16 Oct 2020 01:47:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d8:1700:5168:39b? ([2a01:e34:ed2f:f020:c9d8:1700:5168:39b])
        by smtp.googlemail.com with ESMTPSA id f14sm2602050wrt.53.2020.10.16.01.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 01:47:02 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Colin King <colin.king@canonical.com>,
        Anson Huang <anson.huang@nxp.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        zhuguangqing@xiaomi.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Adam Ford <aford173@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.10-rc1
Message-ID: <ff1ca9b4-51fa-209a-b047-17dcc2e74720@linaro.org>
Date:   Fri, 16 Oct 2020 10:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.10-rc1

for you to fetch changes up to 48b458591749d35c927351b4960b49e35af30fe6:

  thermal: core: Adding missing nlmsg_free() in
thermal_genl_sampling_temp() (2020-10-12 12:08:36 +0200)

----------------------------------------------------------------
- Fix Kconfig typo "acces" -> "access" (Colin Ian King)

- Use dev_error_probe() to simplify the error handling on imx and imx8
  platforms (Anson Huang)

- Use dedicated kobj_to_dev() instead of container_of() in the sysfs
  core code (Tian Tao)

- Fix coding style by adding braces to a one line conditional
  statement on rcar (Geert Uytterhoeven)

- Add DT binding documentation for the r8a774e1 platform and update
  the Kconfig description supporting RZ/G2 SoCs (Lad Prabhakar)

- Simplify the return expression of stm_thermal_prepare on the stm32
  platform (Qinglang Miao)

- Fix the unit in the function documentation for the idle injection
  cooling device (Zhuguang Qing)

- Remove an unecessary mutex_init() in the core code (Qinglang Miao)

- Add support for keep alive events in the core code and the specific
  int340x (Srinivas Pandruvada)

- Remove unused thermal zone variable in devfreq and cpufreq cooling
  devices (Zhuguang Qing)

- Add the A100's THS controller support (Yangtao Li)

- Add power management on the omap3's bandgap sensor (Adam Ford)

- Fix a missing nlmsg_free in the netlink core error path (Jing Xiangfeng)

----------------------------------------------------------------
Adam Ford (1):
      thermal: ti-soc-thermal: Enable addition power management

Anson Huang (2):
      thermal: imx: Use dev_err_probe() to simplify error handling
      thermal: imx8mm: Use dev_err_probe() to simplify error handling

Colin Ian King (1):
      drivers: thermal: Kconfig: fix spelling mistake "acces" -> "access"

Geert Uytterhoeven (1):
      thermal: rcar_thermal: Add missing braces to conditional statement

Jing Xiangfeng (1):
      thermal: core: Adding missing nlmsg_free() in
thermal_genl_sampling_temp()

Lad Prabhakar (2):
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a774e1 support
      thermal: Kconfig: Update description for RCAR_GEN3_THERMAL config

Qinglang Miao (2):
      thermal: stm32: simplify the return expression of
stm_thermal_prepare()
      thermal: core: remove unnecessary mutex_init()

Srinivas Pandruvada (3):
      thermal: int340x: Provide notification for OEM variable change
      thermal: core: Add new event for sending keep alive notifications
      thermal: int340x: Add keep alive response method

Tian Tao (1):
      thermal: Use kobj_to_dev() instead of container_of()

Yangtao Li (3):
      dt-bindings: thermal: sun8i: Add binding for A100's THS controller
      thermal: sun8i: add TEMP_CALIB_MASK for calibration data in
sun50i_h6_ths_calibrate
      thermal: sun8i: Add A100's THS controller support

zhuguangqing (2):
      thermal/idle_inject: Fix comment of idle_duration_us and name of
latency_ns
      thermal: cooling: Remove unused variable *tz

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  6 ++-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  1 +
 drivers/thermal/Kconfig                            |  6 +--
 drivers/thermal/cpufreq_cooling.c                  |  8 +---
 drivers/thermal/cpuidle_cooling.c                  |  2 +-
 drivers/thermal/devfreq_cooling.c                  |  3 --
 drivers/thermal/gov_power_allocator.c              |  6 +--
 drivers/thermal/imx8mm_thermal.c                   | 10 ++--
 drivers/thermal/imx_thermal.c                      | 22 +++------
 .../intel/int340x_thermal/int3400_thermal.c        | 51
+++++++++++++++-----
 drivers/thermal/rcar_thermal.c                     |  4 +-
 drivers/thermal/st/Kconfig                         |  2 +-
 drivers/thermal/st/stm_thermal.c                   |  7 +--
 drivers/thermal/sun8i_thermal.c                    | 16 ++++++-
 drivers/thermal/thermal_core.c                     | 13 ++----
 drivers/thermal/thermal_core.h                     |  4 +-
 drivers/thermal/thermal_netlink.c                  |  3 +-
 drivers/thermal/thermal_sysfs.c                    |  2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 54
+++++++++++++++++++++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  6 +++
 include/linux/idle_inject.h                        |  2 +-
 include/linux/thermal.h                            | 10 ++--
 22 files changed, 156 insertions(+), 82 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
