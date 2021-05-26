Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE9391DC0
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEZRWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:22:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhEZRWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:22:19 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llxD4-0003Sl-Lm
        for linux-pm@vger.kernel.org; Wed, 26 May 2021 17:20:46 +0000
Received: by mail-vs1-f71.google.com with SMTP id l26-20020a67d51a0000b0290236861f1352so558342vsj.1
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iu90w1RN/NgPKQZcOE+tYtYndkYqjFREoyVTDiCy85c=;
        b=DEErS2FrbJ0ojZ6BQeVoz5uxeIJ3RZZF9p1M4uT737koc5Jx7N3lFa3bNB4lNWLAOj
         z6aBC4v1QCtYwKYxJGCGBm49ctJtT5B1wbfQvcvxPPmcePfoaQ/GpFMbEONLjfPF0DbD
         H1ncQLiqIgxTFTqEe3H1YRIDb1+OWMg4NfbQ/jUzBe4UDvmRCkFEFdZEd1I8JC4n/Z2v
         qUHfn7FfENi8weVC7BuSduDqEcdOfnvfueNrU7KNnW9cxixoZoyCqKdmUhoGtU+sarf6
         VeP5UoSBkquHjGSt3nWynoO92sySEIzR+gBG86kf2YfoqmRA7uNsP9jj+Jl9fjxKrh2/
         a54g==
X-Gm-Message-State: AOAM5321alpp1MIMLFfhdHxHOBSiZcxdqnFUKLtn5Cf07HJCYD9JQpaQ
        jRso3QyRj9Krcl0iWE0rJ1iJ4OqjW9Fh/97Yv5ynzrJwdjGfMSO7Bi2QZqEStzChfroRndT7JFA
        xhLSfySOHAUfGgl15hrou8rmE2CFn+3ElhtLh
X-Received: by 2002:a9f:2404:: with SMTP id 4mr33747719uaq.48.1622049645785;
        Wed, 26 May 2021 10:20:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze5V+MJ/4OmRium3GPvko310K8oOb/8zoCmZM316VMsekfJVF2t10PZ+IL1ycCaV8/jRxp5Q==
X-Received: by 2002:a9f:2404:: with SMTP id 4mr33747689uaq.48.1622049645594;
        Wed, 26 May 2021 10:20:45 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id u195sm2036032vsc.10.2021.05.26.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:20:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 0/7] mfd/power/rtc: Do not enforce (incorrect) interrupt trigger type
Date:   Wed, 26 May 2021 13:20:29 -0400
Message-Id: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a v2 with only minor changes:
1. Drop patches which landed in mainline.
2. Add acks.
3. Rebase max17040 power supply (dtschema conversion).

Patches are independent and there are no external dependencies, so
please pick up freely.

Best regards,
Krzysztof


Krzysztof Kozlowski (7):
  mfd: sec-irq: Do not enforce (incorrect) interrupt trigger type
  mfd: max77686: Do not enforce (incorrect) interrupt trigger type
  mfd: max77693: Do not enforce (incorrect) interrupt trigger type
  mfd: max14577: Do not enforce (incorrect) interrupt trigger type
  rtc: max77686: Do not enforce (incorrect) interrupt trigger type
  power: supply: max17042: Do not enforce (incorrect) interrupt trigger
    type
  power: supply: max17040: Do not enforce (incorrect) interrupt trigger
    type

 .../devicetree/bindings/clock/maxim,max77686.txt     |  4 ++--
 Documentation/devicetree/bindings/mfd/max14577.txt   |  4 ++--
 Documentation/devicetree/bindings/mfd/max77686.txt   |  2 +-
 Documentation/devicetree/bindings/mfd/max77693.txt   |  2 +-
 .../bindings/power/supply/maxim,max17040.yaml        |  2 +-
 .../devicetree/bindings/regulator/max77686.txt       |  2 +-
 drivers/mfd/max14577.c                               |  6 +++---
 drivers/mfd/max77686.c                               |  3 +--
 drivers/mfd/max77693.c                               | 12 ++++--------
 drivers/mfd/sec-irq.c                                |  3 +--
 drivers/power/supply/max17040_battery.c              |  4 +---
 drivers/power/supply/max17042_battery.c              |  2 +-
 drivers/rtc/rtc-max77686.c                           |  4 ++--
 13 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.27.0

