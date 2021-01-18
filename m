Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5CD2F96F2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbhARA4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhARA4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:56:16 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F644C061573;
        Sun, 17 Jan 2021 16:55:36 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u21so16546011lja.0;
        Sun, 17 Jan 2021 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMgp5qBVepVz5NKCcoZ4TY79R+AV1qH3h7i7WZm6eww=;
        b=DfJfh9Kk+MCB59YPAzxfUunHUTrnaLHCStoIyl3SZ6FXYsLwSv7PEWN3/9XtIpSFgV
         UelFVYApIyATt0TkGsspjlhezJ1kZr7YV1fpyxvWe6Clj3+fsKzGc6xljr6nWMtggTn5
         tpQoH9kzJSDhka2eGsDqRB+PrggGWUY8BwOO6wtCLfh5DZvmmcxmIvYMZCv/kAbAkLQC
         dQAlbrDcUz0HCKY6+qtMNJuJjnQmi9VJqbnbzyFiyiMacK90ZXYBb9o2tuRZI+zyaCdQ
         ZDQSatDwcaivCTtd4QABXcB6XbT7XiW0rJqR5I5JhqhOx0hpPaIxu4QFXtYIvGxMdDXK
         py/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMgp5qBVepVz5NKCcoZ4TY79R+AV1qH3h7i7WZm6eww=;
        b=rCTBNVkEF+bx0EPrna1NJE4MHM+aktBnV3ehTkWkW1Jwz+1KgQvI+l+0Nv/N84XAl+
         ud7IkqZOr6Xj1CGnw7Q+B45C34XVAH5xpRSEBCB1ZOAXfT4khy4WCbK8pZbLdeBWVG5b
         oRu4qZSmRQFLP3Z58/zQyJy7TLzao74I2lflkknDiKQ4FJAMC2W7UOEnUB6B+PpsmqPK
         ibnYZdmEhIEWDfue3SEvNMLzGRwdjk6zZ0F4+/M4B0YEm+ze1lxvi3w6gq2u7K+gVYV9
         OZy2Ip3m7Rp0ZXjwECU6VMwRdUFYCmwUA6NQq5Z4hhXoGckTEmep3RtRV+27dHWsGUzo
         RWHw==
X-Gm-Message-State: AOAM531sKMgyL7vgYmbX0Xsy5iHh3MOQBd/kiHMegWjpqYtd4634c1pb
        +MA1lkBV3wh+51gk3gt+88c=
X-Google-Smtp-Source: ABdhPJyE5TmK4dBOotPQzx4Metvd3XuBro3RPkVDf2RU/677Q+KiB8eMvdPnMG/1mYZbfR/LlEoPZA==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr9373344ljg.205.1610931334944;
        Sun, 17 Jan 2021 16:55:34 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 00/12] OPP API fixes and improvements
Date:   Mon, 18 Jan 2021 03:55:12 +0300
Message-Id: <20210118005524.27787-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series fixes problems and adds features to OPP API that are required
for implementation of a power domain driver for NVIDIA Tegra SoCs.

It is a continuation of [1], where Viresh Kumar asked to factor OPP
patches into a separate series. I factored out the patches into this
series, addressed the previous review comments and re-based patches
on top of [2], which replaced some of my patches that added resource-managed
helpers.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
[2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/

Changelog:

v3: - Reordered patches by importance.

    - Added locking to dev_pm_opp_set_voltage().

    - Reworked "Fix adding OPP entries in a wrong order if rate is unavailable"
      patch, like it was suggested by Viresh Kumar.

    - Reworked "Support set_opp() customization without requiring to use
      regulators" patch, like it was suggested by Viresh Kumar.

      The opp_table->set_opp_data is now allocated by dev_pm_opp_register_set_opp_helper().

      The set_opp_data is refcounted now and can be allocated by any other
      OPP functions if this will become needed in the future for other OPP API
      changes.

Dmitry Osipenko (12):
  opp: Fix adding OPP entries in a wrong order if rate is unavailable
  opp: Filter out OPPs based on availability of a required-OPP
  opp: Correct debug message in _opp_add_static_v2()
  opp: Add dev_pm_opp_sync_regulators()
  opp: Add dev_pm_opp_set_voltage()
  opp: Add dev_pm_opp_find_level_ceil()
  opp: Add dev_pm_opp_get_required_pstate()
  opp: Add devm_pm_opp_register_set_opp_helper
  opp: Add devm_pm_opp_attach_genpd
  opp: Support set_opp() customization without requiring to use
    regulators
  opp: Handle missing OPP table in dev_pm_opp_xlate_performance_state()
  opp: Print OPP level in debug message of _opp_add_static_v2()

 drivers/opp/core.c     | 309 +++++++++++++++++++++++++++++++++++++++--
 drivers/opp/of.c       |   9 +-
 include/linux/pm_opp.h |  49 +++++++
 3 files changed, 349 insertions(+), 18 deletions(-)

-- 
2.29.2

