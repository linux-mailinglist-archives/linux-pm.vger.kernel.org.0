Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8F207810
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404531AbgFXP4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404351AbgFXP4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D1C061573;
        Wed, 24 Jun 2020 08:56:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so2763917wrw.12;
        Wed, 24 Jun 2020 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kKEO/E+UNrweV7whzWyfeDv+7PjzgnRwHWXgtaaUvo=;
        b=LG7RCEyf8kwWsj5iULmeP6Nm6LbR1uPu5aeLHnKQBpaLELWjJw15iAnj/Ct+7e1O0W
         Y7gaoDVA8P2tqtJbezAT6ZTvelFzQ+iefTN6iRKg9aKkvKjSDYRjo7ANFNvyJcCIEc3N
         xUjR++eKGZXMlJ49c+l7zwk3puGRHTW+UqX8nuwi4w7YC5NAX6q4q869qUOJOOYsyZL1
         5ViWOm3kDmOG9B3W2Zur1bZ2VAzuX0BhW//5F5IxodOgbmiFZuwhsLkNNBOZwW1cQkO3
         8NpRuMJWKkbcWiorHI8dfDa3fY97KD3wdM/NMC3e+BAsw0nQETw3l4LGQjx53QONeWMu
         VnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kKEO/E+UNrweV7whzWyfeDv+7PjzgnRwHWXgtaaUvo=;
        b=erwenOORlIi9BIzHbxbRkd8Z8tbrzSBVYsFy8yzanXC1d7aOqUJRq9HZUbBzpMS1R1
         mpdFpp9PGUBGcFPsK8XULqEstnXje7Rp5l2WtlPVxUOdBACFhlTXiekzwaEGGs8djAwg
         jaZJcGlyZK5rPXp//xFHVQFA+/AgDvWQDAoQ68x5NNBr7XwhZuVyTvZneGgLiHcAE8PK
         c5bPC2ArJGizVnixjORp2QvDDpvQuxW6V3tU3YQxFnk7h9ZqgzbcLSWd1FZtagbVtJnz
         GUnAlZ2P7pwv5buqaK5ED7EDVpQ6WPuHPvoDMoBG12D9t3s3E/qn8KTf7MF9I4i7MKPm
         XPyA==
X-Gm-Message-State: AOAM533wFHcoZ7LkNtFj0ckxtyjYJFOX+870lRTsupRAzLOUfn4BgcUC
        soOgVpaBRfW2TOLxTFzzNkmQKzfz
X-Google-Smtp-Source: ABdhPJx8SmWM+Y7TRhOwmHqaHHLRA3HDyQIsRlVvv+pRkqWglb65pVyJISYpFBL4B3G1kEwThrCH3w==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr9709376wrb.118.1593014204793;
        Wed, 24 Jun 2020 08:56:44 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id z132sm2779839wmb.21.2020.06.24.08.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:43 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 0/6] power: supply: max17040 support compatible devices
Date:   Wed, 24 Jun 2020 18:56:27 +0300
Message-Id: <20200624155633.3557401-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max17040 fuel gauge is part of a family of 8 chips that have very similar
mode of operations and registers.

This patch set adds:
- compatible strings for all supported devices and handles the minor
  differences between them;
- handling for devices reporting double capacity via maxim,double-soc;
- handling for setting rcomp, a compensation value for more accurate reading,
  affected by battery chemistry and operating temps;
- suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling every
  second;
- improved max17040 driver with regmap and devm_

The datasheets of the supported devices are linked [0] [1] [2] [3].

[0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
[1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
[3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf

v2: https://lkml.org/lkml/2020/6/18/260
v1: https://lkml.org/lkml/2020/6/8/682

Changes in v2:
- remove maxim,skip-reset property in favor of device id
- split driver change into 4 pieces

Iskren Chernev (6):
  power: supply: max17040: Use regmap i2c
  dt-bindings: power: supply: Extend max17040 compatibility
  power: supply: max17040: Support compatible devices
  dt-bindings: power: supply: max17040: Add maxim,rcomp
  power: supply: max17040: Support setting rcomp
  power: supply: max17040: Support soc alert

 .../power/supply/max17040_battery.txt         |  21 +-
 drivers/power/supply/Kconfig                  |  11 +-
 drivers/power/supply/max17040_battery.c       | 473 ++++++++++++------
 3 files changed, 357 insertions(+), 148 deletions(-)


base-commit: cfafde3c949cae39483639c03c5da5fd91bb234e
--
2.27.0

