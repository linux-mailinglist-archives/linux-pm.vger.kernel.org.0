Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95E393751
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhE0Uta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhE0Ut3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0BC061574;
        Thu, 27 May 2021 13:47:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b12so2595582ljp.1;
        Thu, 27 May 2021 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6XYLh1xsU0IYTP+MRwPK4s+JoJz/GD/n26DAwUG3/U=;
        b=G1G+vfJswwk+rozkW+WEdxgpHHU+plUQ4ORzfZGu1PMRR+/UAk7MaetTvxldQDVWEs
         Fi+7+bGDMXoPhK1s6hDjnHZ3unpdNk48ANdLdPXAsCncuTaX+L+6Q/0zZcFCPyiZjBC1
         q33MF77CJ+hemLwh+8wviihF6Zqz+PcyEkySt8mWX9b4i7Vs4vCFDwHWYnkndXSwbMqL
         g1NyZIegndBbaJrz4x3buRGgmkMIMgyJbAQjnBxo52GUFX0orGU81qtlwxoXp6+G220P
         YEpU/yc8f8iCI8p/jxUHnzaR7DmEX6UHaMn3HsbnjQ3Jdub4T2MYIXVVC7DMQCmZ6vpY
         pkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6XYLh1xsU0IYTP+MRwPK4s+JoJz/GD/n26DAwUG3/U=;
        b=bRGvTDhb+0zuIeqwxy+cOQIstQw2oysDNOb7vhuh0q2mk5keuYrQbsp0CrBq/Kaa+d
         GikcV5/6bQCjjN00jqifylDCqSq9Oja1DYK8BqD5vv2uCrunJEh/XDjdX2LLJ/ei1Enn
         bStu0kr1ZeZUpxUTTbmPnai6KQyq7pWPdqUfZkqe4WeXgfASs9uySOxgvje53QPjTGmN
         Hh733HZmPBhGjSUmk9pQWpSQ3E3NEmFgsrd4q+wsgHLyyAeItxZIZg9gwwn6zF1qBoyP
         OjkiWusbQEf+3GHFVwq5w0hFTsohMssbq7M5054mRLSrsuYfcy3luX4mCLZNNfd/Qd7t
         q4OA==
X-Gm-Message-State: AOAM530251JzjjwCjfB39Jte9RM96DIaGxGfUzGUxwLbyECVusJtvwej
        pGIUAvM31cZJb1TI11wXawo=
X-Google-Smtp-Source: ABdhPJyi8sS76DRNiEIxSXwhc7gTO6BgdB5Vso6aUr4xGW+Yej3cyCZC1Oh3l2969uWldtr1vJA7CQ==
X-Received: by 2002:a2e:a41c:: with SMTP id p28mr4041248ljn.427.1622148473873;
        Thu, 27 May 2021 13:47:53 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:47:53 -0700 (PDT)
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
Subject: [PATCH v3 00/14] NVIDIA Tegra memory and power management changes for 5.14
Date:   Thu, 27 May 2021 23:47:28 +0300
Message-Id: <20210527204742.10379-1-digetx@gmail.com>
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
 include/soc/tegra/pmc.h                       |   6 +
 16 files changed, 647 insertions(+), 126 deletions(-)

-- 
2.30.2

