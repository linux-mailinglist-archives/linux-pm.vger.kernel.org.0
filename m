Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9455F2984CC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419743AbgJYXCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419706AbgJYXCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 19:02:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F4C061755;
        Sun, 25 Oct 2020 16:02:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so9500461lfl.2;
        Sun, 25 Oct 2020 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbzvvYGKKMfpmx3pIvBmQ61xeNW9Lag/xRbU4s7rjuI=;
        b=m0j5XyuC8vlADticqZVzVlEVOLCibba0i8gXHDJRPXgqBXNc1QTo404Uxyb4HBNysd
         kXS2XxSocyqii+raUjVl3YJGysSVcCNomo9Aav5JS5FUDaq100q9phma8Dd0ajytDpEG
         V5pUg4ja/Rm8i1PfnfBSpifIxyky45TeQFK9H/xkigK3H700TLHmwcH11PGJE0VAhygM
         JCXXz4XAS0PA7Lj0bP+x7fc+FdmN18saU/52dFzUIM/tziQPTf4sx3EvcnvTHtv9T3Oz
         O6UB2faz1FuEvNx8OKwqubQrBbpA8inLHDjDuw9RTWL4p4iPSjAVdKzJIchzzLzFzkc0
         QsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbzvvYGKKMfpmx3pIvBmQ61xeNW9Lag/xRbU4s7rjuI=;
        b=FND10oihPlCsXu3PJfKb+6okb4LmIeN8BhUAEe8uar4jZFU/9meXXMitS6MmcWUnI8
         3EAz2L5uB3u/laQmPSCFmdtv/ED71mDxTTGFfkqJYwwQSVmv7/NGxhjVN3aKAfSEJN4I
         zqDX49nXo+EdJI+8XnkLQh6nbb2uV5bSxWGbSCZWozBm0+CYJ3OfbGe+X9CiBYT2l+8N
         TLTaXyATy2Jw5rf6nHR5TgsuhogFhjfHmgIAQHQcplSmSgqlf5iR6ozvkQV9sKJOPdcl
         jWxDJkNB6MYPvRQy231DMrEmiiVPEyn7wHGUbW9lTwGKkXrIN+gN/M1ABW5M7PKnSkO9
         1bJw==
X-Gm-Message-State: AOAM532zuTfsax12Oq38y43fozAG5t/N16XCwY832+Uyr+kxGI35GMUn
        3rFFuq/GbNUCxPutrhExaaY=
X-Google-Smtp-Source: ABdhPJzDhZB2vCnNiCNXx0lWj3WgBhl+HF/pK6nabp9NdGc67Kz/+BI2TfF/EUPXIkVIBYiJB9D6rA==
X-Received: by 2002:ac2:4d0c:: with SMTP id r12mr3770613lfi.74.1603666919851;
        Sun, 25 Oct 2020 16:01:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id j16sm949619ljh.48.2020.10.25.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 16:01:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/4] Introduce Embedded Controller driver for Acer A500
Date:   Mon, 26 Oct 2020 02:01:49 +0300
Message-Id: <20201025230153.11729-1-digetx@gmail.com>
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
Please review and apply, thanks in advance!

Changelog:

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

