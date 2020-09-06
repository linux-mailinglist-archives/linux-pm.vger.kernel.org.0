Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF725F046
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgIFTv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFTvZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 15:51:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA08C061573;
        Sun,  6 Sep 2020 12:51:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so1077320ljk.0;
        Sun, 06 Sep 2020 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKOOgijjR/92Dyk3rP5J/nsEG2qLUBoxqdTru9X+hgI=;
        b=lFFOmnBe2UZCUQKrBPxMkjUS4KBZG9dLjwTtEYeXoNaZE0tSNH3zkX5ZAyzDQ5rTUJ
         C+NuFRwWxLEB5dZLrqQW0ucODz9NpBUDPtDxih8F05CDK29OfgFanQDAheLqoW4pSiEO
         s9Mckd6SrWobS33yGOc3GdQ1Ck/r8l4+fgdWBMTi3R8gMNsHkPHmJ6dP6rKrPfmYX6sC
         L0O6ovOLJp8Y8ulVjnboJDV2K3NWwHZpm2mglrFag70/TakY41NaDYbSYHk/8z3GepaW
         WjLMZJnkNV4GeVkDZS/FBJWQD7/BtTGTB1qkXVLJYqw5n5WQDZ8uKkK1fO5MDHtxMqnU
         AdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKOOgijjR/92Dyk3rP5J/nsEG2qLUBoxqdTru9X+hgI=;
        b=udewuvjashe4+cfDliWqRjTTo45l9q3IQkkLKeFy2V2TjsOzezC2Tx+TttdEfu9nua
         RBGN9LZTWfeQfIP2YFi5o6BwsjbuufsX1h5AwEkhs96a/3yH44mponEvSF32PAI7zclp
         uQNjBlIaD73Rzfm6alom1LXNeOTolXW20Uh+YVeRAlliQpa1xT5IsABRFMJcvrLcZ6ML
         otDIO3tmNfm0fPiMzYtpQSwCROLiB0zoy2MRbKUmSJBQqw/pidwA+5lEGNA4dEqYMbTu
         KMiUIXMLzaPxEmBjV4ZDbT5ILG8ia4+Lw4Om23mSYJv/l/fsxyBMgHEe9C79L18Xr5ds
         PR4g==
X-Gm-Message-State: AOAM530I5aqg2cLI2B+TA3I7JimxXpn2mafHAyNPfWsQ0/3nBovV3/dI
        caNfo/C2COjjV67TrtqzjF9PqN/YI1M=
X-Google-Smtp-Source: ABdhPJzAEdF4AUFyTVhOHqZygcOU4OH4QMk+olkQY9XA4FzMWKvcUKQi62sBm06iwGewygR7RrGPcg==
X-Received: by 2002:a2e:8182:: with SMTP id e2mr8707788ljg.142.1599421882162;
        Sun, 06 Sep 2020 12:51:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b7sm4942574lfq.36.2020.09.06.12.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:51:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Introduce Embedded Controller driver for Acer A500
Date:   Sun,  6 Sep 2020 22:50:58 +0300
Message-Id: <20200906195103.1347-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

This series adds support for the Embedded Controller which is found on
Acer Iconia Tab A500 (Android tablet device).

The Embedded Controller is ENE KB930 and it's running firmware customized
for the A500. The firmware interface may be reused by some other sibling
Acer tablets, although none of those tablets are supported in upstream yet.
Please review and apply, thanks in advance!

Changelog:

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

Dmitry Osipenko (5):
  dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500
  leds: Add driver for Acer Iconia Tab A500
  ARM: tegra: acer-a500: Add Embedded Controller

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  66 ++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-acer-a500.c                 | 129 ++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 203 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 11 files changed, 740 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/leds/leds-acer-a500.c
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.27.0

