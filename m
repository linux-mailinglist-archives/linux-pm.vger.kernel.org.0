Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7733877E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 09:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhCLIgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 03:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhCLIgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 03:36:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E5C061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:36:10 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a1so5697156ljp.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em7dfJLsuPWNoBZ5RIglWlkFRGvmQrMQ7HhOt27sGkg=;
        b=KTwtsgfyiGwQF6XJDg2CkwPV+PNOhi0ZuS3gk4R5yeKgmlDmTeuxGyt6C5TDsrCQIS
         89Z680OPXy4aWZd3KtXazaVSqOlOh5y6jYfcUqNH7BaoVG9BUVnzcIUaRCm25dVpi3b9
         IZK4TyOe6TzqU63FFP33TMDkcRecrkOfjictUgiEwkB9/gUWm1hjkVi+MHWpus8WPee7
         yCFNJk3c83FyhEjlTkaFK/aqokWlgz5cYeJ5yx7d9dvE6Qb3z4MU7+LtNF7CVEvkCGUc
         SaSVGdKncOxbKcDcInz854nBrnZFsqjpw3bPTbbPfcbl88wtMc9n5H0oILrVA6BorOWH
         mV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em7dfJLsuPWNoBZ5RIglWlkFRGvmQrMQ7HhOt27sGkg=;
        b=lbdgNDnEBIFap+ouPz1EWBxBiYpuLGoYWatr3D9/lyogqB9WGYZw7HI2mU+GeZA2Ye
         9qBZgSrSnbXZwSOHMv/1XzRJHr4eCcWmmNKDaL2D+zOMbcuptRpAsz8Gy8dKGBtt3SwF
         pl6dIO4XNFy9GzKvmqcnYRjqz+LTcxgeocoioQsW5nRre/SLTA0qC9c+2kmjFUOzWZmH
         zSarsy6jHoYnVrxxGTlTme/0fucKbNdB5kYP/Z+GRR0oXEs2fBZlCydyX46ctFQI7Vry
         eSTmac3IBCs/NOzldhfGwZ1wb/KGz5gaOIJHCjVwyce5GhMDLECtU1yEqD4QU/0Yv235
         ZWMA==
X-Gm-Message-State: AOAM530BHRPQ2DY604IsQ8ebgkzmLVArVjmcEgkHIswFdEH9gTbtH4X8
        1oB3cYc/jppxIvY+4y5K1OtZpw==
X-Google-Smtp-Source: ABdhPJwudCeMpAQ/FIhQYdxteL/3mQVeO5HwZMu2xEg2lOFOrphhSNdVU9afiBQ1dWr+s+ZrgTWoRw==
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr1741074ljm.324.1615538169164;
        Fri, 12 Mar 2021 00:36:09 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id p6sm1617532lfc.71.2021.03.12.00.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:36:08 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] mfd/power: Push data into power supply
Date:   Fri, 12 Mar 2021 09:36:00 +0100
Message-Id: <20210312083604.3708890-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series pushes some AB8500 power supply headers down
into the power supply subsystem so the power supply code
becomes independent from the other AB8500 stuff.

The first patch makes the code require device tree so
that the series make sense: once all data for the power
supply comes from device tree, it makes sense for that
code to not require global headers for platform data
etc.

This is in preparation for some finalization of the AB8500
power code, as merge strategy I think it is best if:

- The power maintainer (Sebastian) provide an ACK

- The MFD matinainer (Lee) merges this and provide an
  immutable branch that the power maintainer can possibly
  pull as a base for his tree

I hope both subsystems are happy with the changes.

One of the patches already has Lee's Acked-for-MFD, but I
got a bit stressed out in the last kernel cycle. Let's
take this stepwise, first these four patches. No hurry.

Linus Walleij (4):
  mfd/power: ab8500: Require device tree
  mfd/power: ab8500: Push data to power supply code
  mfd/power: ab8500: Push algorithm to power supply code
  mfd/power: ab8500: Push data to power supply code

 drivers/mfd/ab8500-core.c                     |  17 +-
 drivers/power/supply/Kconfig                  |   2 +-
 .../power/supply}/ab8500-bm.h                 | 297 ++++++++++++++++--
 .../power/supply/ab8500-chargalg.h            |   6 +-
 drivers/power/supply/ab8500_bmdata.c          |   3 +-
 drivers/power/supply/ab8500_btemp.c           |  45 +--
 drivers/power/supply/ab8500_charger.c         |  27 +-
 drivers/power/supply/ab8500_fg.c              |  20 +-
 drivers/power/supply/abx500_chargalg.c        |  22 +-
 drivers/power/supply/pm2301_charger.c         |   4 +-
 include/linux/mfd/abx500.h                    | 276 ----------------
 11 files changed, 326 insertions(+), 393 deletions(-)
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (58%)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)

-- 
2.29.2

