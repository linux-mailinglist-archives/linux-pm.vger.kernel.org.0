Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C515A49D75B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiA0BOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiA0BOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C59C06173B
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e17so2008962ljk.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtBtToJsFMLwYQoP8lW6fSXGBbIbsCxBZggg6jXTK7c=;
        b=htmLZTm2dVYIspXW/pVKO2iXjtbnx/o5Ic6mnmpfUCfG457HtRCY8hDRVk8Hsr+iVp
         ooKt7ahWW93QXiRXCI3zpp0WAf6M2AynVhs5Q4duhnYxH+H71A3Al6cup/R6CakOXScD
         kSpiJx3bmGJmAioqPRGvXmj2Ak9aUMj6jVQJkDg8JieKFQDNwCm68pHTL6vvLNTrIDzT
         v/wn+25iHIP0MJhLyfkucsjGamxVejio1S1YeLS0+DpjbeH6OaKXKuPpAVWQv5Zn5+Cp
         GYXkudPP65uo2Pq1/0gDlg6/82o5oNm2K7WghDlf5e1y4HsxMxbr/3pfa1sezhvmSrgx
         WUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtBtToJsFMLwYQoP8lW6fSXGBbIbsCxBZggg6jXTK7c=;
        b=igggWe2uwYnRZThAckq2B+oTwZygSjgcTlM1zHUhKCVmwZ8La4ERTBH2YXJsgClmxq
         x3VvUvWr6WAeEa+cWD1xDkW8kj7CHRmUpy2NrjyA76/IpPJKuwXAVKkTE8yoXbOH9nuc
         7unRcznvrwd27lBh+wR1eACDfFXdsrV+cCIPfyyY2c1nqPYgIZwuko/v1GhrBbZMk2ZK
         RYhru12SqWVk/a74Pe9me0BE0elVq6JyZw+yP1bdIPbQd1dhImHLiajOmgzw6WzWTcZG
         XBrBjL9KOXveXbNbcvU7B4WtF9qWE5p0pYyqO795KnotQEHXPAk+ddmGQNy4uVbih8q0
         SHOA==
X-Gm-Message-State: AOAM532+gB9SWFkfKpDc15XCXWgG+braAq0UAb7dZEy19VunEQ92JOh4
        hbvpoxaDoZ0UNKyDnRmikGciNw==
X-Google-Smtp-Source: ABdhPJwsUuMM7Zs6/aVcJnopFYSIZ/Q4G/6rNpDIh9AcKow6s9VnZWzVvqev7Z7cq6z/VlblHlxq0w==
X-Received: by 2002:a2e:9e01:: with SMTP id e1mr1191059ljk.31.1643246081609;
        Wed, 26 Jan 2022 17:14:41 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/11] AB8500 charging fixes
Date:   Thu, 27 Jan 2022 02:12:25 +0100
Message-Id: <20220127011236.332687-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a first round of AB8500 charging patches for v5.18.

This fixes some minor and major bugs - they aren't tagged for
fixes or stable since the charging code is still default
disabled on the platform (Ux500) for a good reason
(it never worked properly).

We drop the custom charger sysfs ABI that we do not use anyway.

The thermal zone we are looking up is defined in a separate
DTS patch that will be merged through ARM SoC. The prerequisite
changes to the hwmon NTC driver were merged for v5.17 already.

Once this is agreed and merged I will follow this up with a
more important series with 6 patches that adds the
Samsung static battery data and actually makes charging
work on these platforms.

Linus Walleij (11):
  power: supply: ab8500: Drop BATCTRL thermal mode
  power: supply: ab8500: Swap max and overvoltage
  power: supply: ab8500: Integrate thermal zone
  power: supply: ab8500_fg: Break loop for measurement
  power: supply: ab8500_fg: Break out load compensated voltage
  power: supply: ab8500_fg: Safeguard compensated voltage
  power: supply: ab8500_fg: Drop useless parameter
  power: supply: ab8500_chargalg: Drop charging step
  power: supply: ab8500_chargalg: Drop enable/disable sysfs
  power: supply: ab8500_charger: Restrict ADC retrieveal
  power: supply: ab8500_charger: Fix VBAT interval check

 drivers/power/supply/Kconfig           |   2 +
 drivers/power/supply/ab8500-bm.h       |  49 ----
 drivers/power/supply/ab8500_bmdata.c   |  34 +--
 drivers/power/supply/ab8500_btemp.c    | 330 +++----------------------
 drivers/power/supply/ab8500_chargalg.c | 318 +-----------------------
 drivers/power/supply/ab8500_charger.c  |  43 ++--
 drivers/power/supply/ab8500_fg.c       |  96 ++++---
 7 files changed, 138 insertions(+), 734 deletions(-)

-- 
2.34.1

