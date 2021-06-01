Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DF396B22
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFACfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhFACfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED7C061574;
        Mon, 31 May 2021 19:33:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a5so19409051lfm.0;
        Mon, 31 May 2021 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvTdwZdAJ2DmLegabHWlUrEKLwcXvFLWgzWPD50sn9c=;
        b=VkyJWUispNEgyoDyPA71A5QsDRN/WXnXKj0f3HWjlg4QtccbgHKrAg6eI61XsgN7p8
         fhI6QUTS+5aVLqBZrpnJStBmsPcH5c5KO5xm58PiqxHV9fjBW4Jl+IIdNSg3ryCq9WlO
         WebxkJeLPubED8ukkZhdLRjnhuYdHeN7nxPxGfjol2qs7OURWXkN2TOrim9SCHUqPk39
         PIywyc+TY+/cqMVzutEIB2AV106T+0YVOzPGSg8VyffYwPPuee+U+V4niNG63yYO24xu
         FC43yAt7AvjTJ+LqzOahXoTdpG8BWOYX1/pK05Un83zimGd5NHjJhk1pl5N0R6DuoB3K
         OJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvTdwZdAJ2DmLegabHWlUrEKLwcXvFLWgzWPD50sn9c=;
        b=NE+ifOsuk9gXWdy1J5OvcZUUZ0sPazRWQ1VMgXOf6/x2odfqAjYYEUofOMBJSZUDqP
         npoPXs1QJe2jKquWGQ/gcBNr7caq+VbwPtoRj66160jmLcJQzTdWQVxP0ZbX1zMsAxb6
         utmnjyMok6bx08xSkUcgUmNIIXyrfDxgBTjcC54+cyTZdh0h89m9D88/mvL56cz6zwST
         SHOPgB9D/QAAPGFkMi0K2QLUIbSgGxhBGL0CCR6awXwaLXl7Z/ouMcBq04FpIJcPxEZJ
         J3ZoScUs2VYW7tg+f3IpgvVVwRbc2FmEvXugriLhyIots4BrCZGwm6csTuuEIwHaGp+z
         mvTQ==
X-Gm-Message-State: AOAM531q3upWO63QbzN2lpU45PN/+NLFXhIup1R5O3By+mRrZ9xzX/aE
        7WydnxzI8TJJRV6BSCXLgn0=
X-Google-Smtp-Source: ABdhPJx/IOs31MpWPs8bb+R704MRuOZ7462F/N74vKYZCjdQpSK+/irJkB0bmPfm/12TiX3qXqx/Zg==
X-Received: by 2002:ac2:455b:: with SMTP id j27mr16307931lfm.587.1622514803621;
        Mon, 31 May 2021 19:33:23 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:23 -0700 (PDT)
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
Subject: [PATCH v6 00/14] NVIDIA Tegra memory and power management changes for 5.14
Date:   Tue,  1 Jun 2021 05:31:05 +0300
Message-Id: <20210601023119.22044-1-digetx@gmail.com>
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

v6: - Fixed another compile-test trouble reported for v5. I double checked
      the clk stubs this time and compiled them locally.

    - Moved the Kconfig properties required for the core power domain
      to the PMC Kconfig entry. This was suggested by Thierry Reding.

v5: - Fixed compile-test warning reported for v3 which happened due to
      copy-paste typo around new tegra210_clk_emc_attach() stub.

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
 drivers/memory/tegra/tegra30-emc.c            |  52 +-----
 drivers/regulator/core.c                      |  23 +++
 drivers/soc/tegra/Kconfig                     |   2 +
 drivers/soc/tegra/common.c                    |  97 ++++++++++++
 drivers/soc/tegra/pmc.c                       | 148 +++++++++++++++++-
 drivers/soc/tegra/regulators-tegra20.c        |  94 ++++++++++-
 drivers/soc/tegra/regulators-tegra30.c        |  93 ++++++++++-
 include/linux/clk/tegra.h                     | 100 +++++++++---
 include/linux/regulator/driver.h              |   1 +
 include/soc/tegra/common.h                    |  31 ++++
 include/soc/tegra/fuse.h                      |  20 ++-
 include/soc/tegra/pmc.h                       |   7 +
 16 files changed, 640 insertions(+), 131 deletions(-)

-- 
2.30.2

