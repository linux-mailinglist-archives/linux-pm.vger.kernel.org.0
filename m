Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21BB3018A6
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbhAWWT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:19:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07AC0613D6
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p21so7485664lfu.11
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuzrSh9DV5NeRS6vSmPIUQn7/gIkMFfQQN91c4hi3rg=;
        b=lLUpr6J+cII/f+if1E3XCWeANU8AXjwVDrJjGtGUOrNz4S3bq3z2mUj6OT+xnN0VIg
         Bhbszf/WWtUTgXKj6Z6QeJrWUP3cNz5veNQ5AKSEMCj/JKpNzrcx6VGsVYedgNsTWcYK
         nsZtSqQ3ilN0u0UdZUA+8xnZaDJCDXoHItYEq4JKJimN6biU8WylR7wh647Tc/xd/4pR
         lbm63S5+axFOkKq0VbkGjY2L8K1qRgc5ZTdFqd1MFxGhYOxeGFimuO+NNau+NvKQLzAL
         IsBDaHRoKI5BttM6taSSQZVRfk6oMqm8Y/akWKy0Wdr+xZ9sSv+P5wFTltM3M14qmlTk
         jVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuzrSh9DV5NeRS6vSmPIUQn7/gIkMFfQQN91c4hi3rg=;
        b=hkdm125YT/1JelqNw49Kc7YaMmahmmLWBIj+X57/WhLwTan+96q3ZfzKyCDIz9sTiy
         bz+GEf7U14i9m84ZMdfz+wdzlHWvJz8CZh34+KKMIrves0dRJGaMLC2/8QMFdZN2Bmyk
         dX+7pR6V+bCIR7vP4NrvLzqEYcCALotXKiqwD4t0wGqN3tInakPrWYDpFVZRuDfHuqqw
         m13tSTgryEixFGb48jnGxvmiLF0NMmeFIfzv4kQ1TK0V6yYyZsBRrWmDYKYZ5mWj4Ymf
         LJ71FpcQ+oHcNLFqd1+uS3OIiWF2yaGMoXRNw671BGKwAj9oP35HQiHpIlFZfKWCRJMl
         YYgA==
X-Gm-Message-State: AOAM533CPz3lsgGsLfydO0Y1jQJ+d3fTbXZnvmVrXxl2GKAmCNkguMxZ
        /4OS4a9OV1nwD1tvMOyJvM9vugtZKQb78px7
X-Google-Smtp-Source: ABdhPJx+FmpHaWvlPI10TTOqoJaOxjXRn4prKKPQIyLsEkd2nRGjuYbSDvReMQGmjM5NkUFET80hbQ==
X-Received: by 2002:a05:6512:3157:: with SMTP id s23mr221945lfi.275.1611440355283;
        Sat, 23 Jan 2021 14:19:15 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:14 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/10] power: supply: ab8500: refactor and isolate
Date:   Sat, 23 Jan 2021 23:18:58 +0100
Message-Id: <20210123221908.2993388-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AB8500 code was merged in 2012 and hasn't seen
much love in the years since that, but the code is
needed by the PostmarketOS community.
commit a1149ae975547142f78e96745a994cb9b0e98fd2
("ARM: ux500: Disable Power Supply and Battery Management by default")
disabled the use of the code in 2013 mentioning that
"drivers are more than a little bit broken".

Charging is nice. The platform is not unused. Let's
begin to fix this.

This patch set does a bunch of things to the AB8500
charger code:

- Cleans out non-devicetree code as we are now always
  probing Ux500 and AB8500 from the device tree.

- Breaks the ties to the MFD subsystem and pushes the
  charging-related headers down to power/supply/*
  these headers were shared in include/linux/mfd in
  order to support board files, and with device tree
  that is unnecessary.

- Bind all subdrivers using the driver component
  model which is common in the DRM subsystem, and as
  a consequence we know the order the subdrivers are
  initialized and we can cut the code that is just
  there to satisfy the case where the drivers probe
  in different order.

- Add some minor code that makes the drivers actually
  work (it was very close).

Right now it has dependencies on the MFD tree (this
series is based on thefor-mfd-next branch) due to a
renaming of the cell macro so the best would be if Lee
could merge it, at least partly. I am also fine if
we only merge patches 1 thru 4 into MFD this merge
window to isolate the charger code into drivers/power
so we can continue next merge window with the rest
of the code.

Linus Walleij (10):
  power: supply: ab8500: Require device tree
  power: supply: ab8500: Push data to power supply code
  power: supply: ab8500: Push algorithm to power supply code
  power: supply: ab8500: Push data to power supply code
  power: supply: ab8500: Move to componentized binding
  power: supply: ab8500: Call battery population once
  power: supply: ab8500: Avoid NULL pointers
  power: supply: ab8500: Enable USB and AC
  power: supply: ab8500: Drop unused member
  power: supply: ab8500_bmdata: Use standard phandle

 drivers/mfd/ab8500-core.c                     |  17 +-
 drivers/power/supply/Kconfig                  |   2 +-
 .../power/supply}/ab8500-bm.h                 | 298 ++++++++++++-
 .../power/supply/ab8500-chargalg.h            |   6 +-
 drivers/power/supply/ab8500_bmdata.c          |   6 +-
 drivers/power/supply/ab8500_btemp.c           | 162 +++----
 drivers/power/supply/ab8500_charger.c         | 406 ++++++++++--------
 drivers/power/supply/ab8500_fg.c              | 154 +++----
 drivers/power/supply/abx500_chargalg.c        | 129 +++---
 drivers/power/supply/pm2301_charger.c         |   4 +-
 include/linux/mfd/abx500.h                    | 276 ------------
 11 files changed, 720 insertions(+), 740 deletions(-)
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (58%)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)

-- 
2.29.2

