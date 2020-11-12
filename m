Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3B2B1216
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 23:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKLWth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 17:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgKLWth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 17:49:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A382C0613D1;
        Thu, 12 Nov 2020 14:49:37 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so4714909lfr.7;
        Thu, 12 Nov 2020 14:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRRndN9/UEYEu3XOF4YS3nhu9zqLn65PBOWVgCTZnIE=;
        b=JsLA4C9Vc4ei9b7IMzUQkm97p+fdH8lzlCwNFNdB8JW6I/k1o4PJaprSUTuR22Dj/L
         tV26fqARhKHX8M86SxqR2wWfet0lZaKj59VPs+aqeGzvhoWCfcWUtwA+KZu84T6L0Gs+
         B9QX8oSzx4RK6LPogfy0RjH9E/jCqgBNVXTHK3kScLmEcHu61cWB0AmdzlLJ/ag2xzb7
         4yOuW6CrVg/qQKh3CqTHuL9/kYsL38jnynMSVkVTvdLTISM+o6H2oYKO85kZMlCwZTHZ
         /RBrfrfd5fRSKLJhwopiYigIGxsKF4S8ITHQ9X8zm1v2wQxWax/B4CvHbzFQzLIZeYOx
         l+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRRndN9/UEYEu3XOF4YS3nhu9zqLn65PBOWVgCTZnIE=;
        b=pDXVFC4yUPWwp2trdKAZTSQ7CLhATUHXg41k9NRGfWt7vDjl5p2bB4sOUU+y1yrB5l
         yEF4I0jyWITjm91WspGuKltP1mq7K8w3Rak4qYcvdf8jfvQICX3xyE7OPDMMZeb4iJ6l
         L2G/3aa3+iKEv1KjFk//n7Hr622VfpP+QvmY2Nme7dLuiSgYDRahBenUr8JDQW1PTRaX
         y/P2hqjX3NGISu8WaUc5dsoEMIdio6ERYBN7yS6BZYx/CQ549ROsw6U+GFNwjmGPBTp5
         Vk6dqft3bJYpOMJXDj4OBS7uO9NpnnfEeNemyy2D1F+Low078zMiYtn413kcl+LB8STy
         9jzA==
X-Gm-Message-State: AOAM5324DTWFSqNykjK7rr9bq+TpPav88QU4Q/dMkhAp8Nm+saV8cgGM
        R/fDa3Iumdqo5B9SymZP5Ug=
X-Google-Smtp-Source: ABdhPJzqMHciZtLA09dlBKKcc8/W6mwRKVJimZ7efGgp43lQlr3Z1CkeXygF1oL9zW64dwTQyzUagA==
X-Received: by 2002:a19:e08:: with SMTP id 8mr581771lfo.441.1605221375534;
        Thu, 12 Nov 2020 14:49:35 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id z187sm1006536lfc.126.2020.11.12.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:49:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Introduce Embedded Controller driver for Acer A500
Date:   Fri, 13 Nov 2020 01:49:19 +0300
Message-Id: <20201112224923.4028-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds support for the Embedded Controller which is found on
Acer Iconia Tab A500 (Android tablet device).

The Embedded Controller is ENE KB930 and it's running firmware customized
for the A500. The firmware interface may be reused by some other sibling
Acer tablets, although none of those tablets are supported in upstream yet.

Changelog:

v6: - Fixed dtschema-checker warning about a wrong indentation, reported
      by kernel bot for v5.

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

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  65 ++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 203 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 8 files changed, 602 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.29.2

