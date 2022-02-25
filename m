Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D174C3A2F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 01:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiBYAPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 19:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBYAPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 19:15:50 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851D2692F8
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r20so5259049ljj.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPxhlcIQFX9MWq4VF9H597j0Li5efDt4k2ft/En+vAU=;
        b=IN0/JiCZXDHCiczVIcfmRGUuu+aIeA78LW5XvQMrZIvvgCymyJZ5C91m4POrrUqlrY
         pWw+N01OLzLjAOdLwpRbbkMqdyIO4+1Xz0InRTVRb/PFjuaJ6Hxx1NRKPT01Im5pNqLF
         +SXQ1eHTfEncq/onEsZ06b3QqTsVWCwMV1r7CzJfjr8DO3Mi5ued8tv2dfOpX5vbt+Og
         k7Cl4BBWl6bvvSIXs5ILNaf57xh3Tah54bfzly+DINMO6vSENayReXFarlLMgZfQx94+
         OcDv+Dul3MDv0uqY3UA5O9LoCAtFy/OO1wKPArnZWEm8AUAWEgsp226h+HsuvHb15rDU
         r08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPxhlcIQFX9MWq4VF9H597j0Li5efDt4k2ft/En+vAU=;
        b=HgVGToHqHgU/h+huIdb6GZNTqRkn2zfuDw02fLH58lHmMep80iWiNrzMVwyKrw471h
         t9SlTnw0xhLIzZZxlV8AZAEN0dQM6rGFP6IioZjHtgz4alOP2y1aN5hSaXZ6zo9lWiUo
         hSABO+zm+xiaUVuj5oPuTkf5fPnTGaUr0FZknG5p1yQe+qHKRA7sEeCNgbhUgWQXeeWP
         Cc69DOX9BoSgia/h0r+ev9Szo2awCxBV9MhCzXdbOjzsr7JUTv2/SxDhr0HpKUrbEDAC
         H6wgu5lhGQitqWLBt13OhPikTdctAibtbAqI/R+n49ZLajgVZSlBO2cJ9uQoyKMH1dc4
         6zqQ==
X-Gm-Message-State: AOAM530vFdFkJAjW6BREJW5zmbDXyxa4QmzNwhJtlnthE2xSgoGc8s62
        D4l20S6h6Jt7vlDRE6UjfZxztQ==
X-Google-Smtp-Source: ABdhPJwBlz6/wKT85PQwhoQj2qbRTKubEz+p4fXjnGEUyzPPVMgk9bgi/ySfPYz49x3I2xiF9I5N+A==
X-Received: by 2002:a2e:94cf:0:b0:244:6cf0:aa22 with SMTP id r15-20020a2e94cf000000b002446cf0aa22mr3624663ljh.91.1645748117674;
        Thu, 24 Feb 2022 16:15:17 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm55859lfq.114.2022.02.24.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:15:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6 v3] AB8500 charging, the final steps
Date:   Fri, 25 Feb 2022 01:13:08 +0100
Message-Id: <20220225001314.1881549-1-linus.walleij@linaro.org>
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

This makes AB8500 charge the Samsung batteries on the following
mobile phones:

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
 drivers/power/supply/power_supply_core.c   | 136 ++-
 drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
 drivers/power/supply/samsung-sdi-battery.h |  13 +
 include/linux/power_supply.h               | 207 ++++-
 11 files changed, 1396 insertions(+), 106 deletions(-)
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h

-- 
2.34.1

