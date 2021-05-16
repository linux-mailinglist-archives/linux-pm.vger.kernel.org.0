Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4C382206
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEPXUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 May 2021 19:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhEPXUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 May 2021 19:20:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64108C061573;
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w4so4993492ljw.9;
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92XJXUWDVnh19FZ6D34jVebLeAt3L2ZJpRJnMEsA3NA=;
        b=W4yTebA4aAm/ZZlzCzHcVzrv7QZnymij/yAkRiW0gkAPGERP5AmCzEUH2csru/X6Y0
         Dpb9nL3UGfC4Mkfr8k/6L1T/QMeEq0fvd1/4AazXHOhBIwNFCZsaKdccLCHdCCYVkn95
         n3spLBo6xrh13j3HEE6RQsY4i0iCpr5rpW/zYy9QNZ/uUbqvSacQ5H6R8KoLhYetPQx1
         btQ5BswjqhQvmXJXzzs1LPARPS52RppD69e8K5pqIKphGgQpV8jHepHLKOtwAW4RGSMQ
         oPEWwURqWTzAPzRi9wZZTc7y1hnUXOGYNmeg6uT9oh4bMS6NzWD7ZZaHTUssc/tBSFlA
         GuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92XJXUWDVnh19FZ6D34jVebLeAt3L2ZJpRJnMEsA3NA=;
        b=jbt6rm905tzuAbQaq/IWpYMl92+BSbLFco3G7Nw6dYAXoUvzWEYkqky7XoMArWgvkP
         CsisUnnHyuw6Pv2oTERTCYQFy2ZP+rckBP0pngGZTfm+g40ZaUA9a0qZMQkCVjvBi967
         RibQmanN9xzR3zz9KA1UnErhiItvY4Feh1imTGvtox6oRtCp3yjGXUhCyy3ppo71XdoS
         CBJ8e8iSXq0qtOLUypdW5pcUWkXIPv4HatMzEoIC08L0TOEcipX9PQOAjuL+6MaSe79X
         1S94XKiAHcSngDTymYkD0eE2qS/2BPzvvO5pNjyvIpWtWr1KUKFfDL/i3xIoOG15UQid
         Ys/g==
X-Gm-Message-State: AOAM532PbRVrQBsj0P8KXRpDEbGlk70lq9FS99bmNI/se5EZ9FsGmDhM
        xgrDnAUmg9oTFLLXZW5Ii0w=
X-Google-Smtp-Source: ABdhPJxl9QksxJ/8D/CfY4SrPwnj0NT9p1rHHz+nPcy54nB9GKrToAp5y5LNk/18HjGEUbY2aNMhoQ==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr47062977ljg.466.1621207124610;
        Sun, 16 May 2021 16:18:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id p6sm406478lfr.163.2021.05.16.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:18:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 0/3] Add support for NVIDIA Tegra SoC core power domain
Date:   Mon, 17 May 2021 02:17:52 +0300
Message-Id: <20210516231755.24193-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add GENPD driver for the core power domain of NVIDIA Tegra SoCs. It's
needed for enabling of SoC core voltage scaling, resolving overheating
problems of the Tegra SoCs.

Note that this series is made on top of [1]. It doesn't have any other
dependencies, core PD and voltage scaling will become active once all
other related patches will be applied, meaning that this series could be
applied at any time.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=244075

These and other power-related patches got more testing on more devices,
like Transformer and Lenovo tablets. I haven't updated tested-bys since
these devices are out-of-tree yet.

Ouya Tegra30 game console runs at 40C during system idle in oppose
to going over 60C with the enabled core voltage scaling. Matt Merhar
collected temperature stats on his Ouya [2], showing a very significant
improvement.

[2] https://imgur.com/a/z4NDWqk

Changelog:

v5: - The core power domain node is now placed within the PMC PDs.
      This was suggested by Thierry Reding to v4, we don't need to
      add a virtual device-tree node for the domain anymore.

v4: - Rebased on top of a new version of the OPP patches [1].

    - Fixed new DT binding warning which was reported by the bot for v3.

v3: - This series is a continuation of [3][4]. I factored out and grouped
      these soc/tegra patches since they have a common dependency on the
      OPP API patches [1] and the rest of PM patches depend on this series.

      [3] https://lore.kernel.org/lkml/20201217180638.22748-1-digetx@gmail.com/
      [4] https://lore.kernel.org/linux-pm/20210121191410.13781-1-digetx@gmail.com/

    - Added locking around regulators syncing, which was previously done by
      the OPP core, but then we (me and Viresh) figured out that it will be
      better to do it within the PD driver.

    - The Core-PD driver now restores the boot voltage level before
      shutdown/reboot, which may help some devices not to hang on reboot,
      like Nexus 7 for example.

    - Added r-b from Ulf Hansson to "regulators: Support Core domain state
      syncing" patch, which he gave to v2.

    - It should be cleaner to add the Core OPP tables and power domain to
      the device-trees once all drivers will get the PM support, so this
      series adds the driver and the binding for now.

    - Added t-b from Paul Fertser, who tested the complete patchset on his
      AC100 netbook and helped to spot compatibility problem with older DTBs
      in the patch that will add PM support to the GPU driver.

    - The DT binding now follows the power-domain spec, which was suggested
      by Krzysztof Kozlowski in his comment to v2.

Dmitry Osipenko (3):
  dt-bindings: soc: tegra-pmc: Document core power domain
  soc/tegra: pmc: Add core power domain
  soc/tegra: regulators: Support Core domain state syncing

 .../arm/tegra/nvidia,tegra20-pmc.yaml         |  35 +++++
 drivers/soc/tegra/Kconfig                     |  14 ++
 drivers/soc/tegra/pmc.c                       | 143 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra20.c        |  19 ++-
 drivers/soc/tegra/regulators-tegra30.c        |  18 ++-
 include/soc/tegra/common.h                    |   6 +
 6 files changed, 233 insertions(+), 2 deletions(-)

-- 
2.30.2

