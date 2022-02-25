Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D254C5213
	for <lists+linux-pm@lfdr.de>; Sat, 26 Feb 2022 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiBYXak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 18:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiBYXak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 18:30:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79D19E73E
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e5so11827400lfr.9
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UJOzgUJW4LngXLFrBHAT46k/XaNa4vcSKPQr1mpqMM=;
        b=Umo8CxibsQBFUXs03kEQ9ybhHUzV/TN4ebo8SSHyzGbfEjEjfCIs6Fseoui37fT9jU
         +TGkpfA6/J9M/x1re63IE/KrrbZwfzbBq7+ljgydK13B/8Dz6HhEjvg/p997Vpei1hj7
         obrIR5Uq1R1Jjn6BXkL/bVhebDsWeqSSsAZvqik67VFZsnu2OPWuiizLgCx39abE9U91
         YWROiFIOeC8BeQgVC4OF2cfenJixouDzfCxKubd6UhF12+j0cs7hXR8GxO+Tejofhoe6
         hVGOvL9SAf3CtbP8vYmxp2VKQGsJsCRvtX7Wwh7+D0CrjztLEGUrFAEn/joogd50bDFf
         SKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UJOzgUJW4LngXLFrBHAT46k/XaNa4vcSKPQr1mpqMM=;
        b=NyHqZkA6Ip88w+tC/S8IhyA0BghLgzb4lpyTMdqQ8jquXRpnVdYh5ZnoNGCMjL29Yb
         aHti/uATZ1CqAVKY+WWi0hORUCAH5uHKh9MY/x2ckZH2Bz6sq8p64MbYjqVPz1onLJ3U
         iI633eUUHCFJvC0P7V/2vHa5dg2OOuuRcS1USSUvSVVj/67m3LJ7/AHchAXcPTFEkRri
         x83E7R3IBZ8A/THk1ExMrSfoLviyZhQh/Az52Pc+bYNgpY9rC7bMmf4WbTpe1rO1BLZl
         AkLo4RVBbn2vELG6cMa82IRSrmAIWexrDJ57BdmRyWyVffSoNGC+3yFA2MnjN1byMWvK
         tpWA==
X-Gm-Message-State: AOAM5332KiMn8ydncoLfpPf3RhxsBTgfuDAzmyRe1FNZEjDPq+Zx85k3
        yaR5TbzLiIIgHsFY4aAJjhXwRA==
X-Google-Smtp-Source: ABdhPJx3NQTOSBYOKwUJkYLiFDWYeqQV4mxi7KCbY5a1TNytqYK70CouvyEjP7trLiduw9qodTf3UA==
X-Received: by 2002:ac2:4a90:0:b0:444:a22:cbdb with SMTP id l16-20020ac24a90000000b004440a22cbdbmr6379660lfp.217.1645831805236;
        Fri, 25 Feb 2022 15:30:05 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u9-20020ac251c9000000b00443dc755dfdsm313524lfm.215.2022.02.25.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:30:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6 v4] AB8500 charging, the final steps
Date:   Sat, 26 Feb 2022 00:27:54 +0100
Message-Id: <20220225232800.2021909-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Samsung Galaxy Ace 2
Samsung Galaxy S Advance
Samsung Galaxy S III mini
Samsung Galaxy Xcover 2
Samsung Galaxy Beam
Samsung Galaxy Exhibit
Samsung Galaxy Amp

The steps are as follows:

- Add charging setting for maintenance charging in two steps.
  After this we fall back to discharging to the restart threshold.

- Add optional alert mode charging when the battery is alert warm
  or cold, so as to mitigate the condition. I suspect mostly the
  battery gets alert warm and then this will pull down the charging
  current a bit.

- Add BTI (Battery Type Indicator) resistance fields.

- Add VBAT-to-Ri internal resistance look-up and interpolation.
  Samsung seem to use this on all the Samsung SDI battery
  charging code I have seen.

- Add the static data for all the Samsung batteries and detect
  them from compatible property.

All of this is enabled in the AB8500 simultaneously so for each
new feature a user is introduced.

ChangeLog v3->v4:
- Rebase on Sebastians linux-power-supply tree.
- Fix a small bug in the Samsung static data.

ChangeLog v2->v3:
- Collect Matti's review tags
- Fix up Samsung battery data tables

ChangeLog v1->v2:
- Address review comments
- Split alert charging mode in one for low resp high temp
- Fix build errors with Samsung static data


Linus Walleij (6):
  power: supply: ab8500: Standardize maintenance charging
  power: supply: ab8500: Standardize alert mode charging
  power: supply: ab8500: Standardize BTI resistance
  power: supply: Support VBAT-to-Ri lookup tables
  power: supply: ab8500_fg: Use VBAT-to-Ri if possible
  power: supply: Static data for Samsung batteries

 drivers/power/supply/Kconfig               |   6 +
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/ab8500-bm.h           |  30 -
 drivers/power/supply/ab8500_bmdata.c       |  52 +-
 drivers/power/supply/ab8500_btemp.c        |  14 +-
 drivers/power/supply/ab8500_chargalg.c     |  89 +-
 drivers/power/supply/ab8500_fg.c           |  35 +-
 drivers/power/supply/power_supply_core.c   | 116 ++-
 drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
 drivers/power/supply/samsung-sdi-battery.h |  13 +
 include/linux/power_supply.h               | 207 ++++-
 11 files changed, 1386 insertions(+), 96 deletions(-)
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h

-- 
2.34.1

