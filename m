Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87954C51FC
	for <lists+linux-pm@lfdr.de>; Sat, 26 Feb 2022 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiBYXVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 18:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 18:21:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486751E59
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:21:20 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u7so9359150ljk.13
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ohe6RRx0KJn2KCA5MuO/0KAGsWiC4x8YVPtZs88R4M=;
        b=vWARONwH4L+DcP9QRKSkhIHiLx8X3dcRCJ+ypp9eDWUmwOK/ypeKYPrIsQTfWUdjD5
         nXXfX2YEC8i1XjA4ZRhHZOut8Wj6ccjPECeAr+ixVIXa19lr0CWkLVRuVb1+0O9semni
         Z4qFTpxcPWouqahiRJyqe3kALhKBk0KLtVbIhCfQ2Dowd85eTKTNYaZgO9807w/+nchd
         mBsgyPgN1SMdbkgofUgPUAwvB0++Ro4C4ixgfdXTVfCe2I7iJwAC01ayhHrJuVyid1c9
         bdx/+oOUMG9rIU0ltFPLqzQlKJ5D5XF8veeAbjPbfY/tpb278bL626p4qKhUx/7NQNq9
         90cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ohe6RRx0KJn2KCA5MuO/0KAGsWiC4x8YVPtZs88R4M=;
        b=WGFyfw1uw2w0K9rZblToa0GDd5eUtbL8jHTSR/zuP3rSD8vHppZ/1OzXSFK6eqkkE9
         7wGaiqpwK7cErNrA8f7zOY64Ns8ExXv4EZ2GxhEEHLlBTWBCXuysTV1obnkALCx0GqIr
         BqTn5I00c8OIGOtAep6W99NOBRKzyyn5o3/9zIouhP6V2tJPWTLJHW5YjCPJnMbSThxB
         pTJk0/AVgMNUZoj/pWYo290nlSgfIad+Y7VvUK/cIzFXb/gAseptvO4JMxNmkVwYr6FI
         3Y/qUHcjSSBWeb6uNb1eb8vXDFPypybsxwSvi+IOZDQ6JhvyEofrzXSBQIiqRAtmgdSP
         WCWA==
X-Gm-Message-State: AOAM532P8dNuc2NzGORiAfW5nmDiK/wXwGHQU4F+Eo3AYwV8/CsG13Sm
        IsJsY9GBpMyFOPWZJ8vYJyUhUQ==
X-Google-Smtp-Source: ABdhPJxH/BM5/SnBCtKQ9zVW8M/IwPlE6zopVZkrvuf6RZgtVTFEKCNZVySbibs+q5KN3TZE9sSlsQ==
X-Received: by 2002:a2e:808d:0:b0:23e:f35:506b with SMTP id i13-20020a2e808d000000b0023e0f35506bmr6805691ljg.285.1645831279005;
        Fri, 25 Feb 2022 15:21:19 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s4-20020a2eb8c4000000b002465e87fc81sm385378ljp.43.2022.02.25.15.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:21:18 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6 v4] AB8500 charging, the final steps
Date:   Sat, 26 Feb 2022 00:19:10 +0100
Message-Id: <20220225231916.2012222-1-linus.walleij@linaro.org>
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

