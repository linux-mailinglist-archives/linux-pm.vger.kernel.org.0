Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006692B517E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgKPTsh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 14:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPTsg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 14:48:36 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A0C0613CF;
        Mon, 16 Nov 2020 11:48:36 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so21505655ljj.6;
        Mon, 16 Nov 2020 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kk7qn8x4pb8QvY94Ose3MchmOrRHIg4B+dgYdR+rLis=;
        b=IyEmGN46uxQzV9DaknZb5x4mPIaNNZ8c4Lveyr+w6oJWq4TpvrX6UcZQGVcX2tFQKh
         EY8hORk9xCO0LLT/zQh3IVa7RqXENiDUMuq6iO40WZsGycA/HUqTQ8dxW9BFR3aAcOo4
         zD1tRP3oA4izmC3VEzdCsYHMjLKtQjiiAXZ0p2wrJJHVU8xRfdSV2iizG6BjK5V7aKQd
         nTDiguLBwr3x6KPHMAU8afF6oVxNcaO+bFYXoZzoC9z5Rrdx5e2wXa56zGi+SE8DFRBR
         QHYm0RmR/ghPl/Lb2ZhJoBTdhthONDeVhw0TrOBGhiBP5q1gxz5Tt44hlZB1SPRfWeF3
         Jb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kk7qn8x4pb8QvY94Ose3MchmOrRHIg4B+dgYdR+rLis=;
        b=m1yUJV8GqBz/ANJ5nN+913YjOGhM+IiutYaayaL0nzMKC1H2rZUxsOUzhv4b/qsFEZ
         HhDEepUl/lxUP9dGfx0VfxdrhyPSdVjbUhmoYxnjv5O9/2FpPfwjDT+iP+MeIm84ovtP
         TdzirpZDz1Wf3Be6pe+5qPFO8xHMHcnmb1vwReiN4l353pnlsbDey86wnh9HltQEFiH+
         2QVf5om09tTKSr9yhk9P4pzUzHCbeRNTgmxZl/O1oYhWYGWrHG2ZVsDRs2pPZgCRTklW
         EywCUOe9Zzyw5jEWFZWvdrfewBOdgP7GhtjNT03l4rN0jrttelR93v2oWGTOp/R/yH++
         lsQg==
X-Gm-Message-State: AOAM5332dhSsAuiK4iUf2laHGDm+Uei7bOWh6qF3QMX/zyEL0hlfN5YK
        TElmb0EJ5dgoqGSwCmjlRzU=
X-Google-Smtp-Source: ABdhPJzIzS3xHE6Jv4dmOYyDlUj0oHjh6PP/ui3/2L7pYz3L1FSKZpvG8omKw3Ja/UrEg5qiyeVS7Q==
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr375005ljl.453.1605556113523;
        Mon, 16 Nov 2020 11:48:33 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id n5sm2864286lfb.306.2020.11.16.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:48:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Introduce Embedded Controller driver for Acer A500
Date:   Mon, 16 Nov 2020 22:48:23 +0300
Message-Id: <20201116194827.28947-1-digetx@gmail.com>
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


Dmitry Osipenko (4):
  dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
  mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
  power: supply: Add battery gauge driver for Acer Iconia Tab A500
  ARM: tegra: acer-a500: Add Embedded Controller

 .../devicetree/bindings/mfd/ene-kb930.yaml    |  65 ++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  17 +
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/acer-ec-a500.c                    | 202 ++++++++++++
 drivers/power/supply/Kconfig                  |   6 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/acer_a500_battery.c      | 297 ++++++++++++++++++
 8 files changed, 600 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/mfd/acer-ec-a500.c
 create mode 100644 drivers/power/supply/acer_a500_battery.c

-- 
2.29.2

