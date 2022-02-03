Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E586A4A89C0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Feb 2022 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352543AbiBCRSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Feb 2022 12:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352622AbiBCRSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Feb 2022 12:18:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E32C061714
        for <linux-pm@vger.kernel.org>; Thu,  3 Feb 2022 09:18:38 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c7so4829593ljr.13
        for <linux-pm@vger.kernel.org>; Thu, 03 Feb 2022 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRiJjtQ0xghFbImPbI4c+bn6fNY+q72vIJUH7J6LM24=;
        b=pTdDnfDjYQsd9znQ+8o+nfgV9llFQhD3jPwXcmsDYRhcwqVYYHdt5aq96X7AK7dWW7
         dvDEDuiu0lGFvXLaiOBXt80pnAwVeNIZGuIkv+ErVS8rNJlmnM+c/GqEbpLD6W5jS2Bu
         VkTt7BmKyxyvcYJIrrx/0bFXWMJY1Yy2Vh1LAjxnGMFIMBEHwcFj/EcJ15GOmL8082QL
         lv7AYv9VSm1xSlFx/bai/8T/Fw5yNsN3S+MzAnyn/pTpLtn1tVnoXSm+7FPhLz2j6zsV
         SeyGm5fzVmkCOtRRcb1xEozbI3yjF0ORB84oztOrulSvQo2ZlfefTsN+WfQVr15QDcug
         8Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRiJjtQ0xghFbImPbI4c+bn6fNY+q72vIJUH7J6LM24=;
        b=U6Pc2p7hGmKK1oCO6QcT/ZuUKqiLNWE8sTZCIFohI9Cap7ytTBrZq/jATsSWrylCAC
         N8c5+MzG7Kt/jfNajCBa6GCxagA3z6dEfiHDaHCBscjGqUCdKCpbquY4wLMRevvdsGVZ
         qR6biEhtafpWhJo2vJe+bSsqxyXqxvShi+/Hbea3+XCUAtNalOzUULJTJba6J7WGea33
         hOWbFYk57/z8LAIb0X/KX08ITXd3UOO0jJWEp0jS3i05OpLDASy3ziIuLTfR+9s6qwkn
         x2oit4jqEXiYP/JYa498/H+l+txpC5/I1YRHBr+DdAGuPbDsEPXmvYj41bsE0y1DDfX8
         SlLg==
X-Gm-Message-State: AOAM533L7lPQmwt0tW8znpTTV1sA7/jHB3oLnfSlfZgAH/DDUr0jx98x
        Cn0YnSxcRuRo6HmDTS7j6lD69g==
X-Google-Smtp-Source: ABdhPJw41zGP2t/S4dSBHWv1QJBpv34gjOGuH8+Hk2179C3ImNzlOLTrWf47VoLUbOu/RM9vBEVWTQ==
X-Received: by 2002:a2e:9d84:: with SMTP id c4mr22946472ljj.269.1643908716347;
        Thu, 03 Feb 2022 09:18:36 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b13sm1640699lff.240.2022.02.03.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:18:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] AB8500 charging, the final steps
Date:   Thu,  3 Feb 2022 18:16:27 +0100
Message-Id: <20220203171633.183828-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I am sending this series now so that we get some review despite
the AB8500 fixes not being applied yet. This series goes on top
of this:
https://lore.kernel.org/linux-pm/20220129004925.639684-1-linus.walleij@linaro.org/

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
 drivers/power/supply/ab8500_bmdata.c       |  46 +-
 drivers/power/supply/ab8500_btemp.c        |  14 +-
 drivers/power/supply/ab8500_chargalg.c     |  45 +-
 drivers/power/supply/ab8500_fg.c           |  35 +-
 drivers/power/supply/power_supply_core.c   | 134 +++-
 drivers/power/supply/samsung-sdi-battery.c | 674 +++++++++++++++++++++
 drivers/power/supply/samsung-sdi-battery.h |  13 +
 include/linux/power_supply.h               | 200 +++++-
 11 files changed, 1106 insertions(+), 92 deletions(-)
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h

-- 
2.34.1

