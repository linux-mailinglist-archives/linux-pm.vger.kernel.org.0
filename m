Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0303B38DDB5
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhEWXPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhEWXPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92EC061574;
        Sun, 23 May 2021 16:13:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w7so17766816lji.6;
        Sun, 23 May 2021 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9TDs1IAuMTt6gby5ta7NVUMJ5XPCBAna36AQ7KVr83o=;
        b=lyrKSMXHrbOdnfD1gaEYeGAfa2LIOGMcOtHP+USmjM/zk0CRAJfZ2wcH3SwVPwLz8R
         /i5F7C2o+x5JWZL8U242sJbwwiaJmiyWmXbf+fvYtZ3OydpbHr8dpIOXJ/811XMGyaXi
         dg9CxqhX6o0pFm32CjAa7k57osEM9hYTdQdfA3mT4ecIXamq+qcN8N/B6HU1qw5SiUM/
         JvesnZsb+N8sLjH0JmZnGAplu6FJngT32y0rjcU99RNkL+xmpK3it5j7x0XD4iNitlh9
         pLGTKIdaLawBkALufqo1THA11G0SlPDc7GpNN9k6mY+VBl7QWZFelFl56lNLrdha0TzO
         VjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9TDs1IAuMTt6gby5ta7NVUMJ5XPCBAna36AQ7KVr83o=;
        b=aYf8Ov2kecDzjF3CM3WIwHq4F228ig5B8XxqzY+9qWDGW7NyJ4NkayWHcE15hKKTaU
         bVM1/gVl6PaqDltL4h+TQPv0k+mweRuNcOzggBwUNPoIL2CB0xV68AC06tjLYA98/hZS
         SauTFGJeTygxYIagP5FfvrWzHsBv3jKBrjiGfd3iPhQudwyGbstYrMDGOjPw1txEz3OO
         Wvn/YcJiMSo8RGKCOTPr3qQs/bqFbjvWN6TR+I2t6V2ofF25wLen6mvC/4d25JaYykO5
         tliHf1pI0JUEzyLv8ICnxPV3wEM4PdG/zoeGjlIMrIlGI3cH4+3lnbgT4MipSBpyyltX
         5zHA==
X-Gm-Message-State: AOAM532HI6+BBN5BAY47L8biSl1IpO7+mC7Qzg8Twp/l6alqnZJyhPtj
        apQ2pIvxDxqvqHNqIBk9L1A=
X-Google-Smtp-Source: ABdhPJyIl0e0RtyHHomQK9YyIH1PJZ8hNKhrksCU8b/rx2eg8Sm5HzEg0cBbW8tHO22veni57ChuMw==
X-Received: by 2002:a2e:850d:: with SMTP id j13mr14926426lji.19.1621811626771;
        Sun, 23 May 2021 16:13:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:46 -0700 (PDT)
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
Subject: [PATCH v2 00/14] NVIDIA Tegra memory and power management changes for 5.14
Date:   Mon, 24 May 2021 02:13:21 +0300
Message-Id: <20210523231335.8238-1-digetx@gmail.com>
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
  regulator: core: Detach coupled regulator before coupling count is
    dropped
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
 drivers/regulator/core.c                      |  37 ++++-
 drivers/soc/tegra/Kconfig                     |  14 ++
 drivers/soc/tegra/common.c                    |  97 ++++++++++++
 drivers/soc/tegra/pmc.c                       | 143 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra20.c        |  97 +++++++++++-
 drivers/soc/tegra/regulators-tegra30.c        |  96 +++++++++++-
 include/linux/clk/tegra.h                     |  82 +++++++---
 include/linux/regulator/driver.h              |   1 +
 include/soc/tegra/common.h                    |  38 +++++
 include/soc/tegra/fuse.h                      |  20 ++-
 15 files changed, 650 insertions(+), 130 deletions(-)

-- 
2.30.2

