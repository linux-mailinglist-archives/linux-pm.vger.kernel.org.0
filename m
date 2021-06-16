Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1B3AA3C3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFPTHh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFPTHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E0C061574;
        Wed, 16 Jun 2021 12:05:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n17so5346332ljg.2;
        Wed, 16 Jun 2021 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtJY5flZe37khK4mqWdfiiEYsdpOKZYMDHCXniEQmfo=;
        b=s27Yhv4wGkshgOvdJeLFBfIbEqtaqnjR05vIj/+jjNYu9vdFXfYezVZW+dFOGB7Ymg
         p+7EsCB48hbFJbBAfoYZ9vB0n45QIcjpje8YZuNgyvVOkqtmdRErWaZ+jaLHUACfKurS
         mUCHtc87iIiBZsVvkd/6J2/leNFBMTp/FHs4YZavx2gz2NixOIs6vmyCxNMagzjcnVXe
         PEo/RArkcS78AbUbqfGDm3oZhwXKwmyUx06xfoXIvq2Wj/q/RRKyXLB3cM8LwblloKwl
         TqQCzkphiWkv+7jM8K5aluD6H+Vg/CxPINuTvVeGPxFbK4sXjzmRDzoC92e6MockNt/p
         YdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtJY5flZe37khK4mqWdfiiEYsdpOKZYMDHCXniEQmfo=;
        b=sdcr9GWEVpiu6s5jo0BkVujIphgS2fevnl8Vd6mIoKme0b0fKtbOByRx1STpLsEG+d
         h2hTGVb9xvtae21LmFg+Jf6kpk2EoqzxWkdJl9jKTsOmXBACGb64RsXb8lndYMnYmxxc
         fm/HTmEHwgyvYPFMe/Z4hPShmQtYI3i0qYirUTUoOzCZ72GVr2g7q5YqqPbfGTVZQXx/
         qhE9n7P5rnfm1wJJsSBuwKbckMFgMpPGxQjI0gTot65K/FIKmJsxK7bwlLTq1K0d7s83
         9vsk9A+9rv8bMBRx71DdQsaJ8cfUkPBc28QIJ4WmTROTWEu3M68s2ycvs+VGZcHY1yJP
         n2cw==
X-Gm-Message-State: AOAM532n5u8OfAMEBbPSvPBWPq7Dd3ynhvo7bqIpE4BNfWb/Xs01mA28
        fcJvHSxlEX3PxpQxxQ2MKYY=
X-Google-Smtp-Source: ABdhPJxp9eXcNuLNvaf5Npy4dCg3qGjjED2cpTjcnQTJJ4Z4Smd0H9kVsgjjdt+JfsBACOQKCZm03Q==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr1197147ljn.204.1623870328322;
        Wed, 16 Jun 2021 12:05:28 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 0/6] Add driver for NVIDIA Tegra30 SoC Thermal sensor
Date:   Wed, 16 Jun 2021 22:04:11 +0300
Message-Id: <20210616190417.32214-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds support for the thermal sensor that is found on NVIDIA
Tegra30 SoC. Sensor monitors temperature and voltage of the SoC, it also
emits signals to the power management and clock controllers that are
performing the emergency shut down and the CPU frequency throttling
when a pre-programmed temperature levels are reached.

Changelog:

v4: - Removed DIV2 CPU frequency throttling and cooling device part as was
      suggested by Daniel Lezcano since we need to notify cpufreq about the
      updated frequency and change the thermal pressure. The thermal pressure
      change should co-exists with the cpufreq_cooling. This all needs some
      more thought, so the DIV2 mitigation will come sometime later.

    - Added ack from Thierry Reding.

    - Changed default TZ trips in the device-tree to the silicon temperature
      levels, instead of the average device levels.

v3: - No code changes. CC'ed linux-pm, which was previously missed by accident.
      Not sure how much that is important for the thermal patches, but won't
      hurt to re-send since only DT binding was reviewed so far.

v2: - Made a very minor improvement to one error message, it now prints
      number of channel at which error occurred.

    - Added r-b from Rob Herring to the binding.

Dmitry Osipenko (6):
  dt-bindings: thermal: Add binding for Tegra30 thermal sensor
  thermal: thermal_of: Stop zone device before unregistering it
  thermal/drivers/tegra: Add driver for Tegra30 thermal sensor
  ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
  ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
  ARM: tegra: Add SoC thermal sensor to Tegra30 device-trees

 .../thermal/nvidia,tegra30-tsensor.yaml       |  73 ++
 arch/arm/boot/dts/tegra30.dtsi                |  87 ++-
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 drivers/thermal/tegra/Kconfig                 |   7 +
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/tegra30-tsensor.c       | 673 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  |   3 +
 8 files changed, 842 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
 create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c

-- 
2.30.2

