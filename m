Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25FE2E646E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632854AbgL1PuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 10:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404081AbgL1PuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 10:50:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC8C061795;
        Mon, 28 Dec 2020 07:49:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o19so24851281lfo.1;
        Mon, 28 Dec 2020 07:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM9en9kLcp++QJKTEEtXoFc1OKK5IPrdvT5nKnLAg5c=;
        b=WRqRhLPI56aNRbOGN5TcIK6xLDfq4h/Rkd7/CHGgJnJ5e/v79/0QUZb5Vl9a13B0xz
         g8lYhzNFK1gdnhzWMx5pQbdwZD5xp6otyh3rmNE8asBkwiCTMFReL1k8Df2g+52hfRRc
         b0Ld25pdFJcpr/OZlLk169SfzlJCKdi2EWs5iXBGBDw991Iz4TcTEhl9ZUfy3vgaRbB+
         Bf9vZEaiRuqQrIvJmi0X+WzmjDheTGi/NvYnEschKWLsSx/4ZlQt+wAM1+/jMvcsUOw9
         gUqenSwTr55yMxtb9EmrpRFyKEhLwZtCY1QJ1bsb4lPzXUKswzIvKKyF4/1E9RJq7qOf
         k+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM9en9kLcp++QJKTEEtXoFc1OKK5IPrdvT5nKnLAg5c=;
        b=FAskTW6tPMfivC0hX1YYu+lGzD0QUQtQDcfUv/R8dzxp08c4nuD+1UHynIDCwMU2ch
         KTPbtcBrKNZrPS6N801TiD1Ax/Im4+Pm8chgXXQkuVy9A47zkKPqTi4KDYqqF6vpe/k4
         oAtM7NHk83DEHOrTqu+DHRjB9bgllS18InG2yCZY0xea6+5xPEBznnkmmzu2PeZnht7t
         rmYhyTRYMAQCS+AmCuQKJ0OxLH6e+WYTda26NtrxfRert2AdvOy+0gFbMtxeFPrr936j
         UwkQbVMsRoHhj8/tPHWNu1+lhQr3fKn4Oo2Dct6wrXsGTQ9kFjOIw4apU8uw2GVgV7cy
         U3fQ==
X-Gm-Message-State: AOAM532dU5J8aw3XInvseFNTXcOvGWHBdpuyhggsd/2MGTppSbGQGsVy
        XKb81GsHDRI9xAQwpdNJ2+k=
X-Google-Smtp-Source: ABdhPJwFtnDhDgQztrn8TaUWje7svXW0Hk0Mlgc4uR1KPhQKrr0QArdg3/rR8A+bLW8kDv9cisfG5Q==
X-Received: by 2002:a19:4907:: with SMTP id w7mr6094774lfa.198.1609170579445;
        Mon, 28 Dec 2020 07:49:39 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id s27sm6502262ljd.25.2020.12.28.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 07:49:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v12 0/5] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Mon, 28 Dec 2020 18:49:15 +0300
Message-Id: <20201228154920.18846-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect support to Tegra124 EMC and display controller drivers.

Changelog:

v12: - This is a re-send of the remaining v11 patches [1] that didn't make
       into v5.11 kernel. No code changes.

       [1] https://lore.kernel.org/lkml/20201203192439.16177-1-digetx@gmail.com/

Dmitry Osipenko (5):
  memory: tegra124-emc: Make driver modular
  memory: tegra124-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra124: Support interconnect framework
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Extend debug stats with total number of events

 drivers/clk/tegra/Kconfig            |   3 +
 drivers/clk/tegra/Makefile           |   2 +-
 drivers/clk/tegra/clk-tegra124-emc.c |  41 ++-
 drivers/clk/tegra/clk-tegra124.c     |  26 +-
 drivers/clk/tegra/clk.h              |  18 +-
 drivers/gpu/drm/tegra/Kconfig        |   1 +
 drivers/gpu/drm/tegra/dc.c           | 359 +++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h           |  19 ++
 drivers/gpu/drm/tegra/drm.c          |  14 +
 drivers/gpu/drm/tegra/hub.c          |   3 +
 drivers/gpu/drm/tegra/plane.c        | 121 +++++++++
 drivers/gpu/drm/tegra/plane.h        |  15 ++
 drivers/memory/tegra/Kconfig         |   4 +-
 drivers/memory/tegra/tegra124-emc.c  | 377 ++++++++++++++++++++++++---
 drivers/memory/tegra/tegra124.c      |  82 +++++-
 include/linux/clk/tegra.h            |   8 +
 include/soc/tegra/emc.h              |  16 --
 17 files changed, 1038 insertions(+), 71 deletions(-)
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.29.2

