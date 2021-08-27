Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99DE3F91F9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbhH0Bio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhH0Bio (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36903C061757;
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so10991607lfu.5;
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUmWVwWoAUbYJXKv2uQqUajLZbxGXscHex9Izfr6lxE=;
        b=nmWYP+2B4emQnIRAIpGYgl8CTo3uQOe6MWttJgK1JqN1Sl9p7Ru55pFrEogPMCQCY1
         +ErDQ7UrQhphvl1jYqfNOV7jPx6nE6MGGSMfG6vf3JTOtUD4JsxqJbBpqq4H8plmLWFB
         4rDSUVu2q4VZwhriLcJmGw+QMIB3E3NNAoHtkqqfhddlDEjADpICArF9Fc3vilMrT7/Y
         juVuzCwA+GSqXhmIiFNYU1yGc01myVgz7uLOyJqNd8vvtJjpcbi3SudS79gCDL8ivtwS
         hw24ncYnHLhKmTIlCkTpPfSypWZ2blZCV5PFZWVhjrWJGfUeU1zA/JROzUXCDqkEkNzF
         2DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUmWVwWoAUbYJXKv2uQqUajLZbxGXscHex9Izfr6lxE=;
        b=EDW+CyjT1LsVORP5RavUB4yl8EmCdCqYR1YPXzlDtFI/WQMiWLdesg3SVC9wpMIIhw
         3TBcg4OwfmiNyohnljTmEH+q5HzO/d5H6h6uPK5pk1cloISyszbHiJNW7RsDwabbqIcw
         6ETdN3/ZXA9SHHjxeOOgjMfxLwSNN0BKjN9D1U6ZUB5TgS5JMN4C06jHPy/9dnmb7+Ei
         LfWeJqX7kZou+5zzZ3TJlhLe+bnSRyNfttWX59eIPZISDSVDPmBb1dNb+RUXEzHBShEa
         3NwP6drKwWZtKnNgJpnbRUoGHB9sQbbuTeIm+bXYMWl+tCLAYPv6tnBEc4MLZT3tGHJp
         zV+A==
X-Gm-Message-State: AOAM533kwh/P5FNNfGG9+OrgVhkiOtq8BxjYss2yGMKtc0vJTruS4YyF
        fgUHyZbop9dLvBE2Ot0nAgI=
X-Google-Smtp-Source: ABdhPJyYXSVBc9MTcKidwSkHdYCNlqYYFWeCajI7avxHy44F7pjY++jRR+lVHnqmpB6n1aHNTegLuQ==
X-Received: by 2002:a05:6512:752:: with SMTP id c18mr4815761lfs.346.1630028274590;
        Thu, 26 Aug 2021 18:37:54 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 0/8] NVIDIA Tegra power management patches for 5.16
Date:   Fri, 27 Aug 2021 04:34:07 +0300
Message-Id: <20210827013415.24027-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a reduced version of the patchset which adds power management
support to NVIDIA Tegra drivers. Viresh Kumar asked to send these PD/OPP
patches separately for now to reduce the noise and finalize the review.

I implemented new get_performance_state() GENPD callback as was discussed
in v8. GR3D driver patch shows how it's used by consumer drivers, which
is a good example because 3d driver supports both cases of a single and
multi-domain hardware, it also uses OPP API more extensively than other
drivers.

Dmitry Osipenko (8):
  opp: Add dev_pm_opp_from_clk_rate()
  opp: Allow dev_pm_opp_set_clkname() to replace released clock
  opp: Change type of dev_pm_opp_attach_genpd(names) argument
  PM: domains: Add get_performance_state() callback
  soc/tegra: pmc: Implement get_performance_state() callback
  soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
  gpu: host1x: Add host1x_channel_stop()
  drm/tegra: gr3d: Support generic power domain and runtime PM

 drivers/base/power/domain.c  |  32 ++-
 drivers/gpu/drm/tegra/gr3d.c | 384 ++++++++++++++++++++++++++++++-----
 drivers/gpu/host1x/channel.c |   8 +
 drivers/opp/core.c           |  50 ++++-
 drivers/soc/tegra/pmc.c      |  86 ++++++++
 include/linux/host1x.h       |   1 +
 include/linux/pm_domain.h    |   2 +
 include/linux/pm_opp.h       |  14 +-
 include/soc/tegra/common.h   |  13 ++
 9 files changed, 522 insertions(+), 68 deletions(-)

-- 
2.32.0

