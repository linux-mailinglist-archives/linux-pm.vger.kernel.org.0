Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077992E65F5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393456AbgL1QG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 11:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393365AbgL1QG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 11:06:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3DC06179A;
        Mon, 28 Dec 2020 08:06:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x20so24822927lfe.12;
        Mon, 28 Dec 2020 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLh0QpsCd9OrmRyukAVsjurqv+HRFzes5LCotbb5RJ8=;
        b=rmgmZ0DjB9XoRC9isfDn+QOHo4UOpjUsW5j6PCCgPXnNRxAHfawouTFTIh7G2afjNv
         y9grkZM6VkPhN7KFY9R/Ixm8pGd5CLKY+QSY9ACBHZwQ57a5i1y5jbmqPDV/VDXi8fHI
         NDCuTdeQLBg3DiQrUoGdFts8JUzg5WEIlXL2m23iNyutXJFwLK37pSBwI2Ufu6QEoLXo
         QJQTgU3225tw81+ira/yOqxh/UaSH28hMdC7rkTnoBPtEPACy0hxE7jT3zW366vWKsLl
         MIRGDCXDsDEjOuuN1zNR79D95U0kt2IZ56NkcKMU1J+Kac8vK6jlKK6RDDBtTRFAlUQZ
         n6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLh0QpsCd9OrmRyukAVsjurqv+HRFzes5LCotbb5RJ8=;
        b=UjGGPeIA9UEMjyg1/nxNNBN4N9ibT9hzwt1ei8K8bo2fKa5GJC0+Jbr3lqO95+Kx2e
         lMKYshBfVlYORtqZkhT+4oZW5jXzO6/9v1tFOStw2FD+OdbQI4EgsUKgBZuGqTWHsKqz
         Vg4KKAJvjQ7E71XS0L/Mn11eBa0uYAg0lYXZf3JCoQ4kTgon378qS1zsqXchcGoxKTbH
         Dl73SPjVrhZsIooFnz2U5JO/r0aTXJ7rzuf/CLoKLAgB8iR0J6n6HFlboLaSLy+B1Kct
         CqMUFgJD9PxXN/BPihUpk5kht4f1hJqNkRY7DoKUZA7Nl0VVK2HkX+jo4h9QnF3QbbUe
         23PQ==
X-Gm-Message-State: AOAM532bUtT0EzXCpWT4YEE3UIC/65MUk7rvn7h+zsBz5SRORXFVE8lT
        umUtOyVl1SRQwZg3lwgLZDY=
X-Google-Smtp-Source: ABdhPJykASQRrZuu8pgpmv8hsQQirEcTyxl8Csyq3q/V72g/SyAd/Uln/N//1f3moHsftS4ktDKRBA==
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr18811103lff.288.1609171563846;
        Mon, 28 Dec 2020 08:06:03 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id v28sm5338837lfd.57.2020.12.28.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:06:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] Introduce Embedded Controller driver for Acer A500
Date:   Mon, 28 Dec 2020 19:05:44 +0300
Message-Id: <20201228160547.30562-1-digetx@gmail.com>
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

v8: - This series partially missed v5.11 kernel release, hence resending
      for v5.12.

      Please note that Thierry Reding already applied the v7 DT patch which
      added the EC node to the Acer A500 device-tree, this change presents
      in v5.11.

v7: - Improved MFD Kconfig entry by adding explicit dependency on OF and
      by rewording the help message, matching it to the other MFD drivers.

    - Improved comments in the code by removing unnecessary comments, adding
      necessary and rewording some others.

    - Added expressive defines for the command opcodes.

    - Fixed alphabet order of the MFD driver includes.

    - Removed unnecessary size checks which are already done by regmap core.

    - Renamed 'rmap' variable to 'regmap'.

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


Dmitry Osipenko (3):
  dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  65 ++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 202 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 7 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.29.2

