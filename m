Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72249457F1C
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKTP6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7017C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b1so57718623lfs.13
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzkKIp5Qvi3u4b3fYNXeztV/oQWWS3kAtKNm8Xg2kGI=;
        b=DV2twTaknybC7oLyMANNWbq/zpLoDi3/kAxloEORRpRqdhuMXTDs3s6umK+S6N+NFK
         LAAG2999L3lFvFcJl/kovxIi/9Ks7FQAAQAWdXtftGXZysxOk9EHRSQ4P1virtGrfDfC
         It3KOr7R5O4Pfxl+E6pNs8lUnoOTZca7VEtc8EnKHMk87G92DErz7OzZFUgbphzybAEN
         bzh5fjBWe+hj7ejDm17J0RSe+J2Yz5/mm2lPgvrO18Bht9zVrHk1a7fl5FVFghQ1ajQg
         HIeNEOW/BOxUv+dWkiwNtN20GCTshMwjSaegy4OifQwMWVQrXwG8Fod5/sGL6yhQTRpN
         LpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzkKIp5Qvi3u4b3fYNXeztV/oQWWS3kAtKNm8Xg2kGI=;
        b=OhqCqcUmOuD5sNR6OxFqbcsfnqpZtsVyJLRxWlCiJoYc2YjstzRTt9vxopz4cPeCIr
         /XML5jZ4KoJ14vr5gr1VFt7a9tcL4aRPQ/meGWhdAI5DU/HtEjQ8g2h+ujl5MKzEOl82
         0QkRjPEbjHG98Yr2dp1sls6M8C1KMVxbwHLBwGKTKbWsUAaAUQcZzfqMPegb/ijuzDWU
         aKy8xkr+swGWUNTq9QxUNpNZmOec6JbuCNTkXutLKjuLuaa42/iMpD5Q66M+p0PL0p0X
         g6YUFp1QtOg4SCMyJ9/P/mMqMZmUfvwMr4rFLvkNW3mVsheDP6J/t1ATSKsLOfe29JjI
         HGRw==
X-Gm-Message-State: AOAM531GynuCAd6/E19Le25OlPdY4yyFt67ZR9FzbRlhc8aBjNL+/4ll
        x8wOtxYqXN1TqtvXz6GmfNoNJx5si1pmew==
X-Google-Smtp-Source: ABdhPJwMVB7GM1khL7ReGg/L25E1yIkNOjYahFOzJDj3LZs2iNpkXm6Dzs80ujYv2QtDYQQgaUJKfw==
X-Received: by 2002:a19:5018:: with SMTP id e24mr43306271lfb.294.1637423732032;
        Sat, 20 Nov 2021 07:55:32 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 00/16] AB8500 charger to use power_supply_battery_info
Date:   Sat, 20 Nov 2021 16:53:10 +0100
Message-Id: <20211120155326.2891664-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the first set of patches starting to migrate the
AB8500 charging code to use the struct power_supply_battery_info.
We drop some cruft along the road.

This series does not add anything to the struct, just reuse
what is already there. Adding new stuff comes in the next
patch series.

The AB8500 charging code has not been in working condition for
some time, but it is slowly getting there. Some of this is
just regular maintenance.

ChangeLog v1->v2:
- Fixed review comments on patch 1.

Linus Walleij (16):
  power: supply: ab8500: Use core battery parser
  power: supply: ab8500: Sink current tables into charger code
  power: supply: ab8500: Standardize operating temperature
  power: supply: ab8500: Drop unused battery types
  power: supply: ab8500: Use only one battery type
  power: supply: ab8500: Standardize design capacity
  power: supply: ab8500: Standardize technology
  power: supply: ab8500: Standardize voltages
  power: supply: ab8500_fg: Init battery data in bind()
  power: supply: ab8500: Standardize internal resistance
  power: supply: ab8500: Standardize termination current
  power: supply: ab8500: Make recharge capacity a constant
  power: supply: ab8500: Standardize CC current
  power: supply: ab8500: Standardize CV voltage
  power: supply: ab8500: Standardize temp res lookup
  power: supply: ab8500: Standardize capacity lookup

 drivers/power/supply/ab8500-bm.h       | 123 ++----
 drivers/power/supply/ab8500-chargalg.h |   8 +-
 drivers/power/supply/ab8500_bmdata.c   | 572 ++++++-------------------
 drivers/power/supply/ab8500_btemp.c    |  61 ++-
 drivers/power/supply/ab8500_chargalg.c | 315 +++++++-------
 drivers/power/supply/ab8500_charger.c  | 536 ++++++++++++-----------
 drivers/power/supply/ab8500_fg.c       | 371 ++++++++--------
 7 files changed, 804 insertions(+), 1182 deletions(-)

-- 
2.31.1

