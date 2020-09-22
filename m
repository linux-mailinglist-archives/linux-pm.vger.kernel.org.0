Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD427411D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVLnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgIVLnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:43:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260C1C061755;
        Tue, 22 Sep 2020 04:43:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so2987701wmh.4;
        Tue, 22 Sep 2020 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hx5o5MPaK7diP2i6MWvOvec7p9+pTYWAqdrxIV16j5g=;
        b=a19IzS1kHQO70+YrqmLrKGarjNoDKBE8HeWYimBCTOXwa/I0kvA2OTwYQyGDeM4NI0
         vYA/+MQa5UHZY+snA0BPnHwyksq3RB8Pn+gB7rub4IrNAJWd+nyC/hKygLhj3e23vkOM
         3d7lWdoQ8sm+x6te2lBMta00NiYnuhly35WALC56aJyPgSFJJH7eVOGSkOkCIT3fqXy5
         DTFwAr3tWEbo2t70wZ/0BHGykvUI96yfveMLF9VViQShL8TtmJzqakbEaaCuhPx7/dWp
         rMbUcOUGCPlFtwEnoJcW/KAglOEgw2Z8GkYwyrc7v98kALdEl5e8LmBA4ptNFZpPskPL
         CAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hx5o5MPaK7diP2i6MWvOvec7p9+pTYWAqdrxIV16j5g=;
        b=jo1lR1c/MGkfnA8i5uwN2cnAnUqQsqC5fdUX05UeDcwA+V95zl4Hlcq296MW7okXyT
         b4W2ceR1wbEzwkUrjJIl2uU82fx4uuG88FqD4NhIIVx+GrT5UECSMnV3p4emy7jgt6Zp
         a4okGye22h28z7jHz1ntxI2F5xxpLyA/Y9fOUjJuyBn3rIQRnSz6+N6ey/2ECnVAik58
         itvElOVtmhvgCxtr5h9ocxPTXTmjil+DZfvZagI7BFVGeXMVWH0oJcgVJVtjssfaPQKe
         jdUtJJd4AIdFAj2DqeRIOcRhlzxSlROHmt8ZgubmL+aXCOS4oIYCpNkHtnC4lxyNiQ7q
         TQyw==
X-Gm-Message-State: AOAM530y6bpSiEfWfpdY32Uoymr+khuWhaLtYvRgc2YBl/F74QPr/mne
        ASTyHpzuCvz16WOFg2fmtCk=
X-Google-Smtp-Source: ABdhPJwXPz4IBVcHUUaBogWlqzeGDAMa6qqmCb/lNjtX+tLgO5rjRDfkkqryocSu/hUJwsVSZMzVOA==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr580999wmj.44.1600775000716;
        Tue, 22 Sep 2020 04:43:20 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id z8sm3009611wrl.11.2020.09.22.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:19 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v5 0/7] power: supply: max17040 support compatible devices
Date:   Tue, 22 Sep 2020 14:42:30 +0300
Message-Id: <20200922114237.1803628-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max17040 fuel gauge is part of a family of 8 chips that have very
similar mode of operations and registers.

This patch set adds:
- compatible strings for all supported devices and handles the minor
  differences between them;
- handling for devices reporting double capacity via maxim,double-soc;
- handling for setting rcomp, a compensation value for more accurate
  reading, affected by battery chemistry and operating temps;
- suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling
  every second;
- improved max17040 driver with regmap and devm_

The datasheets of the supported devices are linked [0] [1] [2] [3].

[0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
[1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
[3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf

v4: https://lkml.org/lkml/2020/9/6/237
v3: https://lkml.org/lkml/2020/6/24/874
v2: https://lkml.org/lkml/2020/6/18/260
v1: https://lkml.org/lkml/2020/6/8/682

Changes from v4:
- fix warning reported by kernel test robot <lkp@intel.com> for v4
  patch 4/7
- ensure all patches have Sign-off-by matching author (was violated
  for v4 patch 2/7)

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
 drivers/power/supply/max17040_battery.c       | 489 ++++++++++++------
 3 files changed, 367 insertions(+), 154 deletions(-)


base-commit: e64997027d5f171148687e58b78c8b3c869a6158
--
2.28.0

