Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FEB4B38BD
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiBMAJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMAJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:09:14 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410035FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:10 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o17so17440730ljp.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLt50JzsWsixW/2tSVuSqmC56fFPezJAVQxGaquDSR0=;
        b=Jef1zSLYjgpPcFTdAGggcNj647U8QaSq6e8m0777QhGPWL0b0tJhnidEG3FHLYnDmA
         831hzP43YPhj/nAu/kVp4f678xh4bDhiyKTWJEeDkkpdjuizfvYOGS3DHjeRuTuDW/Zz
         dFmAYewAzTMOybWdHRylfGR/T2dyz2O3Upg2CY3KFiwooigUInfYw+/dTcrdI6ITEFhI
         LaPp3OyRCQwS5Rb8g1R1Ocl9tTHgIWzsJpfEDYoLVXIDkOILrD+GBob6Df1QZXbEg7Mp
         JhjwBqWLhyhLSc9h9Ib9fpoU4NNWCddpQQA99RZzzYdUiTMkQgvQiZSq913cmFOIz5My
         6G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLt50JzsWsixW/2tSVuSqmC56fFPezJAVQxGaquDSR0=;
        b=m7TLDruNjUgAhL2zgqtHxdFHvzz8xThZMqK3dxz5WF4m5vN69XslLIvZsqMk6u5FmH
         AFPF9STxQl53bQ7m8wYrMJ2RM4fg7/PmKEY8velU+Tf/Q8O+1d3mfPQ48/CfRiSCqroJ
         VAlFdAcfkK3yJkxrLzYeKKJhgTTf7rxQLIDT/0VaSE2O+nNeijBKGM1fyVCzrgJVPAdQ
         UU/cIncs9jQvwxBrlpppwpsKNKG1RpzmH9BI8m9MWpgbUSYw0WRFqPR9WsETaO3jtN8E
         CZ22zBhKY4v464G3TP3SdtkXqQDcVjMhdG2fEY+3VzeKAt+646l9Biy0ediBQOfWL/6B
         sYng==
X-Gm-Message-State: AOAM531hhe3VxOtxJZaucyNStAcJFULj8PKmWlSV6anhVi2pCEP7rljE
        jEIdNOHEbqLYjnNfKMaiwjD6Bg==
X-Google-Smtp-Source: ABdhPJytKdzXzMnbbwKCXDO78LONYp4alDa1tiyJ8oUnf/pcXItj72V4hdXDUjz7+fYqKrZQ97pK+Q==
X-Received: by 2002:a05:651c:4d0:: with SMTP id e16mr4862389lji.321.1644710948365;
        Sat, 12 Feb 2022 16:09:08 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g30sm382292lja.39.2022.02.12.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:09:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6 v2] AB8500 charging, the final steps
Date:   Sun, 13 Feb 2022 01:06:57 +0100
Message-Id: <20220213000703.772673-1-linus.walleij@linaro.org>
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
 drivers/power/supply/ab8500_chargalg.c     |  89 ++-
 drivers/power/supply/ab8500_fg.c           |  35 +-
 drivers/power/supply/power_supply_core.c   | 136 +++-
 drivers/power/supply/samsung-sdi-battery.c | 686 +++++++++++++++++++++
 drivers/power/supply/samsung-sdi-battery.h |  13 +
 include/linux/power_supply.h               | 207 ++++++-
 11 files changed, 1163 insertions(+), 106 deletions(-)
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h

-- 
2.34.1

