Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93BA38BA06
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhETXKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhETXKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619AC061574;
        Thu, 20 May 2021 16:08:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i22so26749669lfl.10;
        Thu, 20 May 2021 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrrcU9jLz61VdzpobjeyvSAGoanum5pEXO2oYz7aogA=;
        b=Cnaxqwhie0dabWkl4lN4j4TwTg4AWhS84yz7kkWBXvWXtoORpvvt4evf9/YdQg13Od
         vIIk7PQ7mss8ByzJdeB8DaY59/39CaYyKRwUbY3m0nZse/N7Su4RNUzkEcCO6dnW0cgj
         OwwM08Y2MgmWKq+OzZSsL/9C8db5uWFaXiZntsqcHHBCYrW3dgCDVzDHQ9NNRf5SUeoc
         pfLnmlihSm1H0yUmMU/9OBVogw1aStoWOzI4sJgZTsGJ7cUO55AxGE5FUyBg6Bgujfzx
         dc6ASguFf7jSL3iI8DDgahANjxEF2AiZ3Q4Y8rJ9Ndczqi6ZJ+Pi2YZF425NPB4tE86J
         lEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrrcU9jLz61VdzpobjeyvSAGoanum5pEXO2oYz7aogA=;
        b=bo1Ewn+pwmI5GSMn3hDOU1fZeShvLJXnUKActY2oOQ0U20x6p5tMcHQ/aK00Me4MTJ
         OmCnjpie1NWx+HoS6h0wbiD5mY3yW4CxNNILrUelghOUKrU324LaUM6AEDYK6RlGEs+f
         KFbL/1z5oWigj5f7AS9rM7XqDCe+X0vOaR/6QLWdlaeVc+2LWZ/ciU4Gg2zZk32TixON
         zqaJFqAMvhThyg8Kdnq1rELsGezoKeoNlfmbC2T3XR1LiWSH6kg+oGW4Yum0XUYHuuPn
         HMTNliUhoqKFGLHHtvunQAwaLQA01kmM0HvmDkgmchk9wM+7LZeI8tfRtFY06TGB11+e
         iMwQ==
X-Gm-Message-State: AOAM531G/Bf1qOwJvPfZm3bZKNkSnt+2CdHF1faT2E9ZXAe5Ko/6NI3/
        RugChy9tG1G2IQB4SCNxQOg=
X-Google-Smtp-Source: ABdhPJxXpXS/MrO7jLaz8Zth6Grt4rS+JNTDqz4PO2r6RwWJI0PsSiKjZGrKSetDPrRb1VCp/xic3A==
X-Received: by 2002:a19:7e8f:: with SMTP id z137mr4680277lfc.466.1621552117781;
        Thu, 20 May 2021 16:08:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:37 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 00/13] NVIDIA Tegra memory and power management changes for 5.14
Date:   Fri, 21 May 2021 02:07:38 +0300
Message-Id: <20210520230751.26848-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series is a continuation of the previous patches that I previously
tried to separate into smaller subsets, but all these patches are actually
very dependent on each other and I was messing up the dependencies because
there are too many of them and it's too difficult to keep them all in sync.
So I merged the patches into a single series again.

This series:

  1. Adds CPU/core voltage bump before system is rebooted.
  2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
     Tegra memory drivers to use it.
  3. Adds compile-testing support to the Tegra memory drivers.
  4. Adds Tegra SoC core power domain support.

I'll send the GPU/clk/video-dec/OPP-tables patches that will update
power management of the corresponding drivers and enable core voltage
scaling on T20/30 once this series will be merged.

Changelog:

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

Dmitry Osipenko (13):
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
 drivers/soc/tegra/regulators-tegra30.c        |  96 +++++++++++-
 include/linux/clk/tegra.h                     |  28 +++-
 include/linux/regulator/driver.h              |   1 +
 include/soc/tegra/common.h                    |  38 +++++
 include/soc/tegra/fuse.h                      |  20 ++-
 15 files changed, 600 insertions(+), 109 deletions(-)

-- 
2.30.2

