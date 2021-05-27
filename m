Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28239381E
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhE0Vp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhE0Vp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4BC061574;
        Thu, 27 May 2021 14:43:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a4so2722210ljd.5;
        Thu, 27 May 2021 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpKg7JupX016vkUr8LOBgfofAtv2uGPF5PgtxjtNaI0=;
        b=q48ZaJwOcW6DIZbMe4yJ397qZinEcuaakxc3qOiuHjGiAonqMfLueNuCYSOSGMMN40
         Z1enQcIXdclsZ0lqW0uwA0/uZWbzqzYO7S2wMCkBXKrugGHiV9VFD0dUZyuGBAZ63Ous
         PyFbnryMJq0LAl/J68ttdsQTo+Vhu1jPLvH+K/OhDlQHFeOJZgga43yFpCxq6T5kUSdI
         oQ+hlcr59g6pQbnUqiOaoOEADn8HuBzn+o4yxGrmJLWGro19+khhVYENnmqi81fccLbl
         46DFmNy/t5WwBXUDUnfthzjo2JfhtjJEgrWsFlEoRfDyvHenAM7+J5W9ppggz4tCCw2b
         UFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpKg7JupX016vkUr8LOBgfofAtv2uGPF5PgtxjtNaI0=;
        b=X8MtTPLSs10saApDUtZJUjub3LCEx7a9GYFtasJtjkmqy4YoA4wjvoStUKK3WE4kFa
         wOB8+aFHnAHep3L/zDv3NyVhe9hZ3ACJfpR89LevsS+Dcyy+LNKwo5bu2IAcpQ/CkXWe
         EtXWnLB2GLO0jtX10rNmf8OtosmXNBEDmiaa0RATZh3lqIMahnIPTMKBIv7wiAW8bNO1
         qOSVIyFOPQyu1+e1xc+iux7hHsyo98kTXDdo0EMn0V/VMDGEE0s4VZbB3joLdmcTKlg3
         s2CNZs7YkgrjU4Rn0GMK2aK9mLeVzPqHCX4aRJ1mVpEFOCDaHPpp4Z8ZjL+92WgaVcbt
         /zew==
X-Gm-Message-State: AOAM532/uCye/bEtHuPgvoWFsLAeAyHiwCBnuKppFa3EhA237NWc0RwD
        Fcm6tBpJ84lX7UGGYgrNBIM=
X-Google-Smtp-Source: ABdhPJz0SBD2NKypES3+FRERvocR1HDhJD13DgR4oIkb8gggc7e8g/B/P9TMGJRAwXEFVGQ59m0UvQ==
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr4172125ljp.128.1622151830017;
        Thu, 27 May 2021 14:43:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 00/14] NVIDIA Tegra memory and power management changes for 5.14
Date:   Fri, 28 May 2021 00:43:03 +0300
Message-Id: <20210527214317.31014-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series:

  1. Adds CPU/core voltage bump before system is rebooted.
  2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
     Tegra memory drivers to use it.
  3. Adds compile-testing support to the Tegra memory drivers.
  4. Adds Tegra SoC core power domain support.

Changelog:

v4: - Fixed misplaced prototypes of tegra_pmc_core_domain_state_synced(),
      which I noticed only after sending out v3. This fixes building with
      !CONFIG_PM_SLEEP.

v3: - Dropped "Detach coupled regulator before coupling count is dropped"
      patch that was added in v2 since it missed regulator locking and
      it should be more reasonable to add a new generic hook for syncing
      before detaching. For now it's optional to sync Tegra SoC regulators
      before detaching since it's not something that happens in practice,
      hence it's more optimal to simply drop that feature.

    - Added more stubs for T210 clk driver which should fix compile-testing
      problem reported for v2 by kernel robot.

    - Added COMMON_CLK for COMPILE_TEST of memory drivers since for
      today the problem of compile-testing of legacy platforms that use
      HAVE_LEGACY_CLK isn't solved, we will be able to remove it after
      fixing the legacy platforms.

    - Factored out new PMC driver state syncing feature into a separate
      patch "pmc: Add driver state syncing", which was requested by
      Ulf Hansson in a review comment to v2.

    - Added r-b from Ulf Hansson to the PMC binding-update patch that he
      gave to v2.

v2: - Added more clk stubs that should fix build error reported by the
      kernel bot to v1 for the T210 memory driver.

    - Added r-b from Krzysztof Kozlowski to the memory patches.

    - Added back voltage restore on detaching of coupled regulators to
      the T20 regulator coupler which previously got missed by accident.

    - Added new patch:

        regulator: core: Detach coupled regulator before coupling count is dropped

      It fixes skipped voltage balancing on detaching of regulators which I
      happened to notice due to the recent regression of the MAX77620 driver
      that made driver to re-probe and detach coupled regulators.

v1: - Merged previous patches into this single series.

    - Added ack from Rob Herring to the core domain DT binding patch.

    - Implemented suggestions that were given by Krzysztof Kozlowski:

        - Factored out soc_is_tegra() stub into standalone patch.
        - Updated tags of the "Fix compilation warnings on 64bit platforms"
          patch, added reported-by from lkp robot and removed suggested-by
          from Nathan Chancellor.
        - Switched to use use BIT() macro.

    - Added r-b from Krzysztof Kozlowski to "Enable compile testing for
      all drivers" patch.

    - Added r-b from Nathan Chancellor.

    - Dropped voltage floor/ceiling from devm_tegra_core_dev_init_opp_table()
      since only memory drivers now need to initialize voltage vote and they
      don't need floor/ceil. This was suggested by Viresh Kumar.

Dmitry Osipenko (14):
  regulator: core: Add regulator_sync_voltage_rdev()
  soc/tegra: regulators: Bump voltages on system reboot
  soc/tegra: Add stub for soc_is_tegra()
  soc/tegra: Add devm_tegra_core_dev_init_opp_table()
  soc/tegra: fuse: Add stubs needed for compile-testing
  clk: tegra: Add stubs needed for compile-testing
  memory: tegra: Fix compilation warnings on 64bit platforms
  memory: tegra: Enable compile testing for all drivers
  memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
  memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()
  dt-bindings: soc: tegra-pmc: Document core power domain
  soc/tegra: pmc: Add core power domain
  soc/tegra: pmc: Add driver state syncing
  soc/tegra: regulators: Support core domain state syncing

 .../arm/tegra/nvidia,tegra20-pmc.yaml         |  35 +++++
 drivers/memory/tegra/Kconfig                  |  16 +-
 drivers/memory/tegra/tegra124-emc.c           |   4 +-
 drivers/memory/tegra/tegra20-emc.c            |  48 +-----
 drivers/memory/tegra/tegra30-emc.c            |  52 +------
 drivers/regulator/core.c                      |  23 +++
 drivers/soc/tegra/Kconfig                     |  14 ++
 drivers/soc/tegra/common.c                    |  97 ++++++++++++
 drivers/soc/tegra/pmc.c                       | 143 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra20.c        |  94 +++++++++++-
 drivers/soc/tegra/regulators-tegra30.c        |  93 +++++++++++-
 include/linux/clk/tegra.h                     |  96 +++++++++---
 include/linux/regulator/driver.h              |   1 +
 include/soc/tegra/common.h                    |  31 ++++
 include/soc/tegra/fuse.h                      |  20 ++-
 include/soc/tegra/pmc.h                       |   7 +
 16 files changed, 648 insertions(+), 126 deletions(-)

-- 
2.30.2

