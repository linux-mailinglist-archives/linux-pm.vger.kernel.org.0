Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949394A2AB0
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiA2Avd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbiA2Avc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E2C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x7so15007049lfu.8
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=668BjFha/d0c78Jb+bPBZtB33wE1KONf0V7TWMhpmxY=;
        b=kuC3sd+SFY9wUn0TsAVxQkHeybarg06oc/Cjfytv1H70/bGXcl+tuWceXV4pmBOl5a
         2uPwFN8tORI7fgBysplbEZfE8VXKvxkWniRbsKVpVZ1sRcR04bMXTSHo5RBbqQhH9uGz
         09ttorMaWxbnzvMUP7u39KYYRL9Qckyga0HcS/zap9ropQq3aR2y7uzln20ne/4yft0N
         2lnku2kzETRHjvIeWzunZ6BGpmm7+8w30O8kV4kOoJ+K7BHcVr+dPog3FKrmGqb9TKfu
         VM/Nl5DBqs6vKi3E/+JTmruP10utsFmKzwartxcfU9kyvzWmNykbpBXR3YmbHAaNNzJg
         h28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=668BjFha/d0c78Jb+bPBZtB33wE1KONf0V7TWMhpmxY=;
        b=DOkWf5HHrE40I29xD48fewSjiuC8UXBdYcACt/Q60KcyZEH7xXUW18soTuUJPOxGKd
         hkO0Cm1h6E8S4ptqsaiHK04+H81i1C66spYzvVZIb0pYdldnNTaDibXzM9k4r0fWG2/S
         BgZvehavLEQeNmoh1qzna0SSQ0DmEtllb6I9d7gsLsrGKNrKbwBD/kwnxNC/zLUSLoMr
         nl+vDEpknu7Mgh01NYIYn+aPVqJXA0J18j2Z5k1bz7iEg8XdZ0JYey8tXV/k5kIAYu52
         5vXVW4AV6qsmZeLQ97dYfc6vjeMVhk7ylPTJpc3dV3Rhxm2+PUB1Jd2cF0H06JShqQpl
         ck0w==
X-Gm-Message-State: AOAM532ruBBAqxHCZWCdARNb/iwv4LOI86zz7yK3r0QnXrO/H0G/xj93
        N8yuRwhZqf8jSc/tYLM30EaSFRp5g5pQNg==
X-Google-Smtp-Source: ABdhPJxmoGtNb7CTrYA14yu6hf/VBg4u/V384OMs/z9a0n9Lu5HGh/Z6pprU/d33YE174WmcYT6cvQ==
X-Received: by 2002:a05:6512:3c93:: with SMTP id h19mr8084566lfv.510.1643417490571;
        Fri, 28 Jan 2022 16:51:30 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/11 v2] AB8500 charging fixes
Date:   Sat, 29 Jan 2022 01:49:14 +0100
Message-Id: <20220129004925.639684-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a first round of AB8500 charging patches for v5.18.

ChangeLog v1->v2:
- Patch 5 contained code based on a patch I will submit in
  the next iteration, now augmented to apply and build
  cleanly.

Linus Walleij (11):
  power: supply: ab8500: Drop BATCTRL thermal mode
  power: supply: ab8500: Swap max and overvoltage
  power: supply: ab8500: Integrate thermal zone
  power: supply: ab8500_fg: Break loop for measurement
  power: supply: ab8500_fg: Break out load compensated voltage
  power: supply: ab8500_fg: Safeguard compensated voltage
  power: supply: ab8500_fg: Drop useless parameter
  power: supply: ab8500_chargalg: Drop charging step
  power: supply: ab8500_chargalg: Drop enable/disable sysfs
  power: supply: ab8500_charger: Restrict ADC retrieveal
  power: supply: ab8500_charger: Fix VBAT interval check

 drivers/power/supply/Kconfig           |   2 +
 drivers/power/supply/ab8500-bm.h       |  49 ----
 drivers/power/supply/ab8500_bmdata.c   |  34 +--
 drivers/power/supply/ab8500_btemp.c    | 330 +++----------------------
 drivers/power/supply/ab8500_chargalg.c | 318 +-----------------------
 drivers/power/supply/ab8500_charger.c  |  43 ++--
 drivers/power/supply/ab8500_fg.c       |  96 ++++---
 7 files changed, 138 insertions(+), 734 deletions(-)

-- 
2.34.1

