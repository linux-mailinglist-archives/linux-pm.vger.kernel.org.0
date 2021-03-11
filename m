Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE833812C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 00:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCKXPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 18:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhCKXPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:15:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80967C061574;
        Thu, 11 Mar 2021 15:15:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so731476wro.7;
        Thu, 11 Mar 2021 15:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y0TGOgSlWiwp+UtOL9hMKxVKRcQgfo1+IEksLgy5FE=;
        b=D7pE4PJUAXZY8lBo5tIwYrFcXc/m+25PgL/SF1bnIq5m5FJ+M2Vz3sl2VIB25fZhVP
         C8yvx1bwNDcAlKPhQtp/AsAhFJnSfOdV7TBAjMbTZRLwZS65QnhLbaU7c+vHsLXlYPjc
         zv4aQ66TuYC4MhclEXRQ4Z2H9JXJLVcB7oEs+9mCqS1YY/BtaptWK7FIimQJnEGW0ViV
         Hn1mcMr6ZRF78gS364rsaUrdif0PlXCDO/Hwjq9GFKji54Sh3OUdWo8BxyRbKlrptjzE
         ixfDsAdu5MTIil3o0sfrhAoFZiTLTdglGbEm4Muz3TCvswwQSJLS8LNsT59P6WkD2LJl
         MWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y0TGOgSlWiwp+UtOL9hMKxVKRcQgfo1+IEksLgy5FE=;
        b=gF2WD0AMbSr/NHTsnkqZKlW+zrdJUNOBzrsOjKl0hWXilAS9Oyp1hQ6R/av3sDAHjw
         1naoJbTqs1iXcG3gqvOOQisaJF9zIgOHEUKppOYoRsxq+0K97pcdwYiSmBhQNCK+Qrxq
         OPTUrkQlIWhO1qIlCMluh+iG8beFlhGt67yVjSkHv99DOL2sx4XPBvFjuquhdhSZMZAw
         qsp9k+fLxa8d6nyO8WUuMmn6yAw8rRlSwChLc69Gzk7HFEPuhCtVdOKPLlT902Djle9k
         eFIMBhES73H8vrH5thi3/g5qrumEMji9loiXYN0lHZEBB2OYqvAavETFv8uICwggVfUC
         G8OQ==
X-Gm-Message-State: AOAM532Yobdy/3rUOKbXfbh3d0NjZcBe3BAHbcdjHGIg2y2j/o9mRvZB
        4ayV8fMc3nx++RF578E6lFDH4M0yOwA=
X-Google-Smtp-Source: ABdhPJyJrxLpRLdzDswOw1vbrbTC8YVVF3iqqq7rbjlR1HPs5+KQqztUeJ0czC62uHo/gNqZNeokyA==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr10637376wro.79.1615504523049;
        Thu, 11 Mar 2021 15:15:23 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id j203sm263918wmj.40.2021.03.11.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:15:22 -0800 (PST)
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
Subject: [PATCH v3 0/6] NVIDIA Tegra core power domain driver and OPP helper
Date:   Fri, 12 Mar 2021 02:12:02 +0300
Message-Id: <20210311231208.18180-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
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

[1] https://patchwork.kernel.org/project/linux-pm/list/?series=446525

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

 .../power/nvidia,tegra20-core-domain.yaml     |  52 ++++++
 drivers/soc/tegra/Kconfig                     |  19 +++
 drivers/soc/tegra/Makefile                    |   1 +
 drivers/soc/tegra/common.c                    | 138 ++++++++++++++++
 drivers/soc/tegra/core-power-domain.c         | 154 ++++++++++++++++++
 drivers/soc/tegra/pmc.c                       |  16 ++
 drivers/soc/tegra/regulators-tegra20.c        |  19 ++-
 drivers/soc/tegra/regulators-tegra30.c        |  18 +-
 include/soc/tegra/common.h                    |  36 ++++
 9 files changed, 451 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
 create mode 100644 drivers/soc/tegra/core-power-domain.c

-- 
2.29.2

