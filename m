Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B300A2A6ED5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 21:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgKDUeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 15:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 15:34:19 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF53C0613D3;
        Wed,  4 Nov 2020 12:34:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 184so28913162lfd.6;
        Wed, 04 Nov 2020 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0mitIGetUGfuuO4VScfLcyzD4ue3QtNkT908OKoYnY=;
        b=fd5ouJ4+u2b/v1cNp08C5IZeNh8UNObZ9G5gda+RSLQVT2Z8nIfmTrnx5jKEG9q++C
         Vr+jNeV5T4twoBYbHlcFVMgxoRi+kGMHeH1Ha9IfbPzeNyUu4Dskwb5PPV3bJ+oNWxY+
         LJKrvs3FpF9c5sCch2v7KogZbQHxyXb81kSDuWHVSY6A8AyEaTw/vsC2Z+OxKf41QK7B
         GVdl74YnhBefgGTaMq81TU+qgXuoVoFPHg50Phycws4p9+nhga2fF7Ju6yi8bMP5UeGj
         dadQtaND9A/Diz8p47qYIeKtB4KwHLUK0dLY8foCOLbwB2lHbdnk3lI/eEmyf1DDcKYe
         YDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0mitIGetUGfuuO4VScfLcyzD4ue3QtNkT908OKoYnY=;
        b=gla9HHxiytntyYyBgduYqqOncHx/aOrfVUfVd/eOiS9AcXxDoHsM4IqRPVccB8M2O7
         YMMR7K4uTEtHsUwsZiAovMqJKqzgq83XTsKqJJD24GBqjOQkHy6wCyPRnZv8iMMVBx5m
         JOJVNLkAxNRYln1dD/stwKFinsEG4ObJ6ew81/HpzYz9YElQiMfHp0AA4EOL+xRB0WcB
         5Ma5h81AhARGNa0Ld18oxkXQGj9WqUvkdAc9aKh5PeEoVp2UWvWNgxeCGyFZbOsFrHDM
         0yEYQYuTRfwPXLsfKSE1IkbDugqNwbHZ1Ep3ZWBa38LTvLnidks7Zcx6SJjMu0+afPm3
         /e7w==
X-Gm-Message-State: AOAM5337C3sxFzRjedc7Deowv4dqoHPuiHGth3y+XaerAdz+nNjkWgii
        YPndLxbrSPnfqj0Y27XCOKo=
X-Google-Smtp-Source: ABdhPJzKX/6wU0RqPpkY/32d3YiyYJIXCCOvwfbfeiW8IJ0CDJZ+fdPpDkOiaUjKGSP14GU5aU9MKA==
X-Received: by 2002:a19:8741:: with SMTP id j62mr337990lfd.449.1604522057422;
        Wed, 04 Nov 2020 12:34:17 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id u22sm615084ljk.45.2020.11.04.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Introduce Embedded Controller driver for Acer A500
Date:   Wed,  4 Nov 2020 23:33:59 +0300
Message-Id: <20201104203403.24937-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

This series adds support for the Embedded Controller which is found on
Acer Iconia Tab A500 (Android tablet device).

The Embedded Controller is ENE KB930 and it's running firmware customized
for the A500. The firmware interface may be reused by some other sibling
Acer tablets, although none of those tablets are supported in upstream yet.

Changelog:

v5: - No changes. Re-sending again in order to check whether dtschema-bot
      warning is resolved now, which didn't happen in v4 because bot used
      older 5.9 kernel code base instead of 5.10.

v4: - No code changes. Added r-b from Rob Herring and Sebastian Reichel.
      Re-sending for 5.11.

    - The v3 of LED driver was applied by Pavel Machek and already presents
      in v5.10 kernel.

v3: - Rebased on a recent linux-next. Fixed new merge conflict and dropped
      "regmap: Use flexible sleep" patch because it's already applied.

v2: - Factored out KB930 device-tree binding into a separate file, like it
      was suggested by Lubomir Rintel.

    - Switched to use regmap API like it was suggested by Lubomir Rintel.

    - Added patch "regmap: Use flexible sleep" which allows not to hog
      CPU while LED is switching state.

    - Corrected MODULE_LICENSE to use "GPL" in all patches.

    - Corrected MFD driver Kconfig entry like it was suggested by
      Lubomir Rintel, it now depends on I2C.

    - Switched to use I2C probe_new() in the MFD driver.

    - Renamed the global pm_off variable, like it was suggested by
      Lubomir Rintel and Lee Jones.

    - Dropped serial number from the battery driver because I realized
      that it's not a battery serial, but a device serial.

    - Battery driver now uses dev_err_probe(), like it was suggested by
      Sebastian Reichel.

    - Dropped legacy LED_ON usage from the LED driver and renamed the
      LEDs, like it was suggested by Pavel Machek. I also checked whether
      LED-name customization via device-tree could be needed by other
      potentially compatible devices and it shouldn't be needed, anyways it
      won't be difficult to extend the code even if I'm wrong.


Dmitry Osipenko (4):
  dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500
  ARM: tegra: acer-a500: Add Embedded Controller

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  66 ++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 203 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 8 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.27.0

