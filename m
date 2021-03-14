Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA833A6D6
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhCNQsk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhCNQsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99FBC061574;
        Sun, 14 Mar 2021 09:48:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m22so53162239lfg.5;
        Sun, 14 Mar 2021 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOr012S5+S+c/Y9KC/ckdyVd30LgXDmuDZz9LPig/KE=;
        b=dRSfhk212idAeRc2iQWfm6IuTkje7IPXhJ7SCt20uGlkahy9TTk/t8odPQpiPHg4r2
         WwTCUORQpPT+UK7frBYM8G1n0QNYWP4ORLXW0K0o+waXjMZG0/4Ffm2x4/SIl4UtfbDv
         G3bSCLciVeG36iiFcrq01iwbZFg+k+0H8uomb6qF/urn/9yYKg3gs/BKrUqEbYgo5ORP
         vI6e0LKAehq+Vx3OPlx8nkA8oTcwppFtQ8kgA9/+YDfPE0gc/dXwakIPmVhJ7yEivUZE
         1Hbc5auPazB7G8zkKBmIr7M1o2TNYaB17F8n1d0h0ls4GVqexGxiJzdJHJ2/VboUrM0w
         Kq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOr012S5+S+c/Y9KC/ckdyVd30LgXDmuDZz9LPig/KE=;
        b=LlLUPaYTcPQXwqvNGdc0LOwO2MgLAJHKfT0appViEglBNziHM/z2kTEVj/EwEML3kl
         ybFzj5jPmNtEz8UpgXB+ec7/Qdd3xQRRpaHERronIN4LzYwpprGy//ygvfIpd6oan0pM
         kwkPWeN7/aWqcvUSiItXmdGGkSZHBeA8BkU2nLLl1Xlk1BKCymY2Y2b009yZVdajmQjB
         0ff3HVHCWQPg1eR4j7LshAOmSyg15QShNfVlwWFEqqJNqQjPSBEm4nRtlGZ0h/yjuptt
         Bo7KivxXICemP17XWAmoN0+d7H+59Ta6L1mVou9WCeSOyc1PQzDjAOuqxjw4TsID5WOb
         miqg==
X-Gm-Message-State: AOAM531VHJ9PWB+gn249gGBWbIRTiGn7MuE6MEwoJo6MkJTwNfjN/zy1
        SWGBBwm+mqZQLqP0h9vMlzc=
X-Google-Smtp-Source: ABdhPJw/rCyYFaQzMXxZBjSvAIBjgWaBfvsAys0OKCd7gOn11onyTiB6HIWvmvDYrX8YJV36mIwTNA==
X-Received: by 2002:a05:6512:3184:: with SMTP id i4mr5820273lfe.314.1615740497422;
        Sun, 14 Mar 2021 09:48:17 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] NVIDIA Tegra core power domain driver and OPP helper
Date:   Sun, 14 Mar 2021 19:48:04 +0300
Message-Id: <20210314164810.26317-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series adds Core power domain driver for NVIDIA Tegra SoCs and a
common OPP helper which initializes OPP table specifically for Tegra
drivers. The patches depend on the ongoing series [1] which adds
resource-managed OPP API.

[1] https://patchwork.kernel.org/project/linux-pm/list/?series=447801

NVIDIA Tegra SoCs have a dedicated "Core" power domain to which
majority of SoC peripherals belong. The core domain is connected to
a dedicated voltage rail, which is exposed as a voltage regulator to
the Linux kernel. Adding support for power management (i.e. voltage
scaling) of the Core domain allows to significantly improve power
consumption of the Tegra chip.

In particular this PM work solves the overheating problem on Tegra30
devices. It allows Ouya Tegra30 game console to run at 40C during system
idle in oppose to going over 60C. Matt Merhar collected temperature stats
on his Ouya [2] which show a very significant improvement.

[2] https://imgur.com/a/z4NDWqk

Changelog:

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


Dmitry Osipenko (6):
  soc/tegra: Add devm_tegra_core_dev_init_opp_table()
  soc/tegra: Add CONFIG_SOC_TEGRA_COMMON and select PM_OPP by default
  dt-bindings: power: tegra: Add binding for core power domain
  soc/tegra: Introduce core power domain driver
  soc/tegra: regulators: Support Core domain state syncing
  soc/tegra: pmc: Link children power domains to the parent domain

 .../power/nvidia,tegra20-core-domain.yaml     |  51 ++++++
 drivers/soc/tegra/Kconfig                     |  19 +++
 drivers/soc/tegra/Makefile                    |   1 +
 drivers/soc/tegra/common.c                    | 137 ++++++++++++++++
 drivers/soc/tegra/core-power-domain.c         | 153 ++++++++++++++++++
 drivers/soc/tegra/pmc.c                       |  16 ++
 drivers/soc/tegra/regulators-tegra20.c        |  19 ++-
 drivers/soc/tegra/regulators-tegra30.c        |  18 ++-
 include/soc/tegra/common.h                    |  36 +++++
 9 files changed, 448 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
 create mode 100644 drivers/soc/tegra/core-power-domain.c

-- 
2.30.2

