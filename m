Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4250394D65
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE2RMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhE2RMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515ECC061574;
        Sat, 29 May 2021 10:10:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w7so9239728lji.6;
        Sat, 29 May 2021 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bC+dOUhRCq/1bKn4niqw6YKq8uPyTradsF1YvAsjLg=;
        b=TU7CwRj3JlJ/fyRWTw6x32GoStINr3n5UINwPKoflQUFKM/WyxTsnS8E8kn4M8TFAG
         MN1pJCGVMw73DOP1Qs7BkG7AIwCX1cBF7NyzqBdFaMfJFWOamtwvvhDjp14eXPFfrLzK
         +k44w6RubFHDxTDvAuUWQqwQZEilOT6xPoqkRNJ9arM0DdYt/HwnXQ6r73+UPwyBMb31
         R4pEx8EdH0qUirxur7GxUR71g+81NI1fAIhP7FGwbN1QZHirrJkZfKlehCpxkVg6jtDs
         21Vz48HnOzDpquGAbZNqZbnsPaE2pHFOt5FjVqL31KaT6fPzIdw1kQerc1e9JQf8caX1
         RKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bC+dOUhRCq/1bKn4niqw6YKq8uPyTradsF1YvAsjLg=;
        b=sk0ek77Wdex5nbu1f2EogT000ctjSrDcituIhzeGSTcVPe05VgpAOj1aaVl9HVmTZ8
         GpAzcZUdRbWsc742BBhuHWn5SoDyPqwUo33LYCuTEf6kjTlm7jONOWM/N7GlrEZa5FDJ
         yDLJtRxphpr6Q883HObLo5+lmWa7b/qTeG8e1XEl3Gtv/Htw8lNMLkqx82CMbDR607nP
         93g8JNu0KFFpsbXO2hSxXlotMJFphozBlX7S/zHlfvvJ4nJbZZLt645q5nlf9dSpE4MC
         Q5rLW3bQyM9mENG3VTc8irmwOB0LpJ6pLoft7xoRixwS5m9KKR9yJNG9mFnSHp7776s+
         K4xw==
X-Gm-Message-State: AOAM5306Oqb+wtbC9gsaOvSe+xZTbNIRG1upRxRcBEXfQwdeVV3r0qnR
        4dwYrKST5uLHx/BzqwaFIAc=
X-Google-Smtp-Source: ABdhPJzvSzL5UOhAsqKTJ49NjvkBRqZmE6cd4CRPWtL+0OwCrbt34t37fsvcsEyEakD4cFJKELIX4Q==
X-Received: by 2002:a2e:7f0f:: with SMTP id a15mr10379750ljd.387.1622308238672;
        Sat, 29 May 2021 10:10:38 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:38 -0700 (PDT)
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/7] Add driver for NVIDIA Tegra30 SoC Thermal sensor
Date:   Sat, 29 May 2021 20:09:48 +0300
Message-Id: <20210529170955.32574-1-digetx@gmail.com>
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

Please note that this series is made on top of ACMTON patches! [1].
Otherwise tegra30.dtsi will fail to compile.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=243115

Changelog:

v3: - No code changes. CC'ed linux-pm, which was previously missed by accident.
      Not sure how much that is important for the thermal patches, but won't
      hurt to re-send since only DT binding was reviewed so far.

v2: - Made a very minor improvement to one error message, it now prints
      number of channel at which error occurred.

    - Added r-b from Rob Herring to the binding.

Dmitry Osipenko (7):
  dt-bindings: thermal: Add binding for Tegra30 thermal sensor
  thermal: thermal_of: Stop zone device before unregistering it
  thermal/core: Export thermal_cooling_device_stats_update()
  thermal/drivers/tegra: Add driver for Tegra30 thermal sensor
  ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
  ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
  ARM: tegra: Add SoC thermal sensor to Tegra30 device-trees

 .../thermal/nvidia,tegra30-tsensor.yaml       |  78 ++
 arch/arm/boot/dts/tegra30-ouya.dts            |  16 +
 arch/arm/boot/dts/tegra30.dtsi                |  93 ++-
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 drivers/thermal/tegra/Kconfig                 |   7 +
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/tegra30-tsensor.c       | 736 ++++++++++++++++++
 drivers/thermal/thermal_of.c                  |   3 +
 drivers/thermal/thermal_sysfs.c               |   1 +
 10 files changed, 933 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
 create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c

-- 
2.30.2

