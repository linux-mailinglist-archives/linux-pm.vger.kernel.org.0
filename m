Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961425F0A7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgIFVbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CAEC061573;
        Sun,  6 Sep 2020 14:31:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so12129468wme.5;
        Sun, 06 Sep 2020 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnK64bE3Zq16GfzXQOay457ZSh/RHiZ4BQh1ouo/TAA=;
        b=p94IeZfD1GPMCWr8TU0qQ2QG/OcPdRmeHethIbh4oeB34E1TdqWtR7fBVFVnLlPYzp
         8aMzftZeWEyucJKx3vEUAMeJVBtYTBeIf3b/kF1osCmXU6lwKwWt36UGPqVKbJ+eXATU
         gdpcMofEpMFPP+3j+0Qd93bQoKiNYqMqcSGP9/9/MhCSUZzt3L3tnpaA0eIrsreYinRv
         ahT6vILg8nRqEIYuonYh2zPQBM6HIg9NmDtTGKzvvYNSrRda24ljW52WLBfnJJdGyEyK
         OapMiqMisio8INxiLIoGzQHufLvn3C3WGxYFuy8rC/5gt3/zgJf8fL+kayTCiXgEIDEx
         0nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnK64bE3Zq16GfzXQOay457ZSh/RHiZ4BQh1ouo/TAA=;
        b=RhwxIDTkOTiuAS6h4HsFOh2o0LaXDr/AKSme3xdalqdwDsCqS/Jw7iH4rrB1myWk6g
         ljpEJ1fDJAFpL6cETdffF+bJWPiL/FKUEGXiSEtIdyOfYoz33yfr65h+CXIqEajPXHsQ
         qHMcgUMusnX9ZopmOp1BBwjEUscAUIGQEyJMaNPUSXOBo9xuPl7uIMw5xxFopfsTyPUk
         +iRDPlwTAgqDftC8KRFRc2vaaWqiPDUQZKpXA8KRonqitLiUy4i+piAhN1r+x7zPsGNl
         yacaaml/HjLx9AX7KsYGrxWtSiEjXOIXni4XQTqlLjTL4YCHtGqKE3X2UVJffxzaFJ2w
         HwiQ==
X-Gm-Message-State: AOAM532qVc1fCfSmKVLGldnUt2Yrz4TFOuvxM6T9HpRixlbMjwpLOB7F
        5T41UWvQrOPc4+cwLCn5B09IUstTEzhmeYwl
X-Google-Smtp-Source: ABdhPJz+59rnadWv89pECXfxYC3kIXz2XFp90WTyLVkV11OSjPgAI6ruXyek9LZoy7FLxEfUB3GeKA==
X-Received: by 2002:a1c:56d6:: with SMTP id k205mr17597089wmb.88.1599427867671;
        Sun, 06 Sep 2020 14:31:07 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id d18sm24741938wrm.10.2020.09.06.14.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:07 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <me@iskren.info>
Subject: [PATCH v4 0/7] power: supply: max17040 support compatible devices
Date:   Mon,  7 Sep 2020 00:30:49 +0300
Message-Id: <20200906213056.2161410-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Iskren Chernev <me@iskren.info>

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

v3: https://lkml.org/lkml/2020/6/24/874
v2: https://lkml.org/lkml/2020/6/18/260
v1: https://lkml.org/lkml/2020/6/8/682

Changes in v4:
- split refactor patch into devm_ and regmap patches (as suggested by
  Sebastian Reichel)
- correct handling of soc alert for double-soc devices
- rebased on 5.9-rc, incorporating upstream work

Iskren Chernev (7):
  power: supply: max17040: Use devm_ to automate remove
  power: supply: max17040: Use regmap i2c
  dt-bindings: power: supply: Extend max17040 compatibility
  power: supply: max17040: Support compatible devices
  dt-bindings: power: supply: max17040: Add maxim,rcomp
  power: supply: max17040: Support setting rcomp
  power: supply: max17040: Support soc alert

 .../power/supply/max17040_battery.txt         |  21 +-
 drivers/power/supply/Kconfig                  |  11 +-
 drivers/power/supply/max17040_battery.c       | 488 ++++++++++++------
 3 files changed, 366 insertions(+), 154 deletions(-)


base-commit: b36c969764ab12faebb74711c942fa3e6eaf1e96
--
2.28.0

