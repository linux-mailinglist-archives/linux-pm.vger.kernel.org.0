Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A57256FC7
	for <lists+linux-pm@lfdr.de>; Sun, 30 Aug 2020 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH3SzG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Aug 2020 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgH3SzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2020 14:55:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957DC061573;
        Sun, 30 Aug 2020 11:55:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so2318593lfj.1;
        Sun, 30 Aug 2020 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KB/orVYY3/iyi1+OEIa3l5Zb1NRAkevYQaE0xhLNDhY=;
        b=VGHVZ9FEWLfnTHug243P4hrtTxperC/kE3E0vF1ZeYaI0NEfmOXsDz/tlFNOyyoXJO
         VHVbFyRVRpJGdnfBBnhG5nIx4FwKXEfDs4oPII6dsE354utxZJavTfqHr2bERsDWi19N
         5ffZpKRR7KeVCo2el9CMtjXlZ/zj+KTbnPWgb+fhnUNsFSvOg+4Q+G28wxoRfD92xGeP
         zJQAlhJW73evGxJ+4MwHpo5qjU/vI7OzbB8Xu1ei0lpV0r2q1by9iOAULtX9cXi2cCt5
         d2SiqViqCGZI+ZjjcBe8ays+IdqFBa7y0JfZHzs5diwS3G9QFRrUHws/dkwBLl8oQpWf
         eBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KB/orVYY3/iyi1+OEIa3l5Zb1NRAkevYQaE0xhLNDhY=;
        b=qSZ8OmOeIP7SDgIn9MBEUlg3r72XdAnQsF0TYiZqjOGGM8kEhBnV7gCNeYLl4J/+j9
         ixK3u+YPRgNZKvuJhQN2gRWA91vE9QF8t/aU7Q9YBtkZL7ojNoUoKuM70KkFvnAqJqlH
         AxVBEj8TsS7pz9hal5C3ZOMElkPlouurDFLl8PtziyG7kugHGLNH7DmzpAQzyZ3ESTcY
         ZbIKthr0p1VwAQ+lMCWWPPLGNEnjhoFk0C84MbqGO54cGIULc7+ehVmFeRdVVo9SD61e
         fR5HoGipL9mwoVG7FiRRhLEHr0DvVXEstoXjCjAeegBHj42IzWmYTgA3CtOC63ih+Z7V
         7RhQ==
X-Gm-Message-State: AOAM5304v27W9h2U5wX0UUpU897ZC/qs7dMZdmjLP6fOqSs40imRJuhY
        +zm2rvHJQoSy6nTdJtq8PRY=
X-Google-Smtp-Source: ABdhPJxGQoR/UevvS7mGsEvM7E+6XaqGsRNUGzs6zBl/GWHaA1SVMDWljN1/Xw5Fab/puIiqg7EYNw==
X-Received: by 2002:ac2:4d0f:: with SMTP id r15mr3955240lfi.114.1598813702322;
        Sun, 30 Aug 2020 11:55:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n21sm21630ljc.89.2020.08.30.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Introduce Embedded Controller driver for Acer A500
Date:   Sun, 30 Aug 2020 21:53:50 +0300
Message-Id: <20200830185356.5365-1-digetx@gmail.com>
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

Dmitry Osipenko (6):
  dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
  regmap: Use flexible sleep
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500
  leds: Add driver for Acer Iconia Tab A500
  ARM: tegra: acer-a500: Add Embedded Controller

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  66 ++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/base/regmap/regmap.c                  |   4 +-
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-acer-a500.c                 | 130 ++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 203 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 12 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/leds/leds-acer-a500.c
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.27.0

