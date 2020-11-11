Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2292AE5C1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgKKBPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732471AbgKKBPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:10 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AFC0613D3;
        Tue, 10 Nov 2020 17:15:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so557184wmd.2;
        Tue, 10 Nov 2020 17:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWy0jS3uOBmOClD+6tlZ3ZyzkxvorDo2b8v+9CLbSUY=;
        b=ZeXs811qmAd8eFTi3qIsbEfXYdu2cgoWjmZTdwr17unMQcI5e15tFGnNjAor8PUQYv
         ldXZ9w3u4wX2Iij5QDdvNOS0obd/0MgzNaO20nssVCtadSAeyxsdCPzwgQssVx/rl+Zh
         pjZ/+nDS0K5TJnIsM4ZWXEslg3ZhBP+YD38lYww9cleitLMR43ddnfncUUkWLyLs+u28
         RlFBcxgBZRx6NUFWZXtZ1qP2r08q6P4hnvmeoijdDelfgObkGk5MFwiAjYUjIrmzkW+E
         HVxi/DZYNd558CoMlIUhaUTIobalgek/Seeh5kKWxW6YDztIpm/vyFoOXNaO50kUZJhp
         r/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWy0jS3uOBmOClD+6tlZ3ZyzkxvorDo2b8v+9CLbSUY=;
        b=la3qQkLUJ8ZIvePqezbTIuR8PEnpTVQLudNS9TDaPMv+qGciwgAHTGr7CkpElVwURM
         BK/YG3ypdb/01KRz8Ut1U8AfkAA3TDzxamFguN1b3+OUAP2AiYCMJsjWE89l5MaZB2x1
         PI28NsabnFageFHM5DLUHrmMYP3J7btm+6m3DjGU0NK64txqnQAcl8N99WopQABhnyal
         RD0LQr9dM6XqfxXjBozOh+5LbOOGUk2mL+Za3OALkvbsuTHUt4YokYm2x54rLH358JWB
         stXISL+Pyzjuy/n1VfsowJoxT5U+PyYgS7cetRnj2KSCksYSh4jG+Eq80CyKD067VMS3
         Mg4Q==
X-Gm-Message-State: AOAM533R+XOHZ1wOXwEk7LBbJjwD2C2pX7ljS+SxCaPBs81Zm90pfu0S
        O/Cs43gMp5FOqqtV+bY/OmI=
X-Google-Smtp-Source: ABdhPJwfFe41HRMpB4RcaGsjLNpSv1VBTsXR2iVFVBGsBpIcOU2lcc40D6Nj2ZSCL+ZpUoRkL1c9xg==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr918758wmf.111.1605057308488;
        Tue, 10 Nov 2020 17:15:08 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 00/26] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Wed, 11 Nov 2020 04:14:30 +0300
Message-Id: <20201111011456.7875-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series brings initial support for memory interconnect to Tegra20,
Tegra30 and Tegra124 SoCs.

For the starter only display controllers and devfreq devices are getting
interconnect API support, others could be supported later on. The display
controllers have the biggest demand for interconnect API right now because
dynamic memory frequency scaling can't be done safely without taking into
account bandwidth requirement from the displays. In particular this series
fixes distorted display output on T30 Ouya and T124 TK1 devices.

Changelog:

v8: - Patches that are already applied by Krzysztof Kozlowski not included.

    - Removed tegra20-devfreq.c from MAINTAINERS, suggested by Chanwoo Choi.

    - The patch "memory: tegra20-emc: Add devfreq support" now removes
      PM_OPP for Tegra20 EMC driver from Kconfig, suggested by Chanwoo Choi.

    - Now using devm_devfreq_add_device() for Tegra20 devfreq, suggested by
      Chanwoo Choi.

    - Added acks from Chanwoo Choi. Although, devfreq patches probably
      should go via devfreq tree in order to avoid conflicts with the
      other previously-applied patches by Chanwoo.

    - Dropped superfluous dev_pm_opp_get_opp_table() from patch "devfreq:
      tegra30: Support interconnect and OPPs from device-tree".

    - Silenced another minor W=1 compilation warning reported by kernel
      test robot.

    - Added couple extra minor clean-up changes, including those that will
      ease further code changes. Added these new patches:

        memory: tegra20-emc: Remove IRQ number from error message
        memory: tegra20-emc: Factor out clk initialization
        memory: tegra30-emc: Factor out clk initialization

      Note that some of the new T124 changes are compile-tested only,
      but I expect that we will re-test them fully soon.

    - Added patch that fixes compilation of a non-Tegra kernels.

        memory: tegra: Correct stub of devm_tegra_memory_controller_get()

    - Replaced dev_pm_opp_get_opp_table() with dev_pm_opp_set_clkname(),
      as was suggested by Viresh Kumar in other thread.

    - Added patch that will allow T124 EMC driver to probe even if DT
      doesn't have memory timings, this was missed by accident previously.

        memory: tegra124-emc: Continue probing if timings are missing in device-tree

Dmitry Osipenko (26):
  memory: tegra: Correct stub of devm_tegra_memory_controller_get()
  memory: tegra20-emc: Use dev_pm_opp_set_clkname()
  memory: tegra20-emc: Factor out clk initialization
  memory: tegra20-emc: Add devfreq support
  memory: tegra20-emc: Remove IRQ number from error message
  memory: tegra30: Add FIFO sizes to memory clients
  memory: tegra30-emc: Make driver modular
  memory: tegra30-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra30: Support interconnect framework
  memory: tegra30-emc: Factor out clk initialization
  memory: tegra124-emc: Make driver modular
  memory: tegra124-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra124: Support interconnect framework
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Extend debug stats with total number of events
  PM / devfreq: tegra30: Support interconnect and OPPs from device-tree
  PM / devfreq: tegra30: Separate configurations per-SoC generation
  PM / devfreq: tegra20: Deprecate in a favor of emc-stat based driver
  ARM: tegra: Correct EMC registers size in Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra30 device-tree
  ARM: tegra: Add interconnect properties to Tegra124 device-tree
  ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC
    device-tree
  ARM: tegra: Add DVFS properties to Tegra20 EMC device-tree node
  ARM: tegra: Add DVFS properties to Tegra30 EMC and ACTMON device-tree
    nodes
  ARM: tegra: Add DVFS properties to Tegra124 EMC and ACTMON device-tree
    nodes

 MAINTAINERS                                   |   1 -
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi    |   8 +
 .../arm/boot/dts/tegra124-jetson-tk1-emc.dtsi |   8 +
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi  |  10 +
 .../arm/boot/dts/tegra124-nyan-blaze-emc.dtsi |  10 +
 .../boot/dts/tegra124-peripherals-opp.dtsi    | 419 ++++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi               |  31 ++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   7 +
 arch/arm/boot/dts/tegra20-colibri.dtsi        |   4 +
 arch/arm/boot/dts/tegra20-paz00.dts           |   6 +
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi |  92 ++++
 arch/arm/boot/dts/tegra20.dtsi                |  33 +-
 .../tegra30-asus-nexus7-grouper-common.dtsi   |   4 +
 ...30-asus-nexus7-grouper-memory-timings.dtsi |  12 +
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 383 ++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |  33 +-
 drivers/clk/tegra/Makefile                    |   3 +-
 drivers/clk/tegra/clk-tegra124-emc.c          |  41 +-
 drivers/clk/tegra/clk-tegra124.c              |  27 +-
 drivers/clk/tegra/clk.h                       |  16 +-
 drivers/devfreq/Kconfig                       |  10 -
 drivers/devfreq/Makefile                      |   1 -
 drivers/devfreq/tegra20-devfreq.c             | 210 ---------
 drivers/devfreq/tegra30-devfreq.c             | 154 ++++---
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 359 +++++++++++++++
 drivers/gpu/drm/tegra/dc.h                    |  19 +
 drivers/gpu/drm/tegra/drm.c                   |  14 +
 drivers/gpu/drm/tegra/hub.c                   |   3 +
 drivers/gpu/drm/tegra/plane.c                 | 121 +++++
 drivers/gpu/drm/tegra/plane.h                 |  15 +
 drivers/memory/tegra/Kconfig                  |   9 +-
 drivers/memory/tegra/mc.c                     |   3 +
 drivers/memory/tegra/tegra124-emc.c           | 395 +++++++++++++++--
 drivers/memory/tegra/tegra124.c               |  82 +++-
 drivers/memory/tegra/tegra20-emc.c            | 192 ++++++--
 drivers/memory/tegra/tegra30-emc.c            | 406 +++++++++++++++--
 drivers/memory/tegra/tegra30.c                | 239 +++++++++-
 include/linux/clk/tegra.h                     |   8 +
 include/soc/tegra/emc.h                       |  16 -
 include/soc/tegra/mc.h                        |   2 +-
 41 files changed, 2971 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
 delete mode 100644 drivers/devfreq/tegra20-devfreq.c
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.29.2

