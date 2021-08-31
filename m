Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3F3FC8FB
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhHaN54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhHaN5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4AC061764;
        Tue, 31 Aug 2021 06:56:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m4so31915857ljq.8;
        Tue, 31 Aug 2021 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh1dGOF6z3ZHEXOnLNafwuf+KocUmg+Di2EHeSGPS14=;
        b=ESbQnhfCmCTAv6lQEk+bz2yhb0U05g9NZlMwZTZXxLDXNiktDG3SdJSKPGIRX7CmzQ
         h5i9e3k2A/SXOkPua8wV4mk/OWd1unmcuUZ0VaGiFzgHkHxt9tB0WSvywwt9ZHDDKoGJ
         l5n3AmISoacdCW3Zulxp9BTaKBGUOnjLTvPOTR+VCLvFoBcNkC7XQ9dtEQnObj1cBQf0
         tbrlNB8sXbtvZE1fcx13Pa+XwkRc/QCnme2+J4Yn487svGYnF+qxrLdDlcKMDsIbDsJ6
         myBCphEvLKIzuN35eED+SwEFlqsvEQQK/n//Bxt97W5z127qNCdOxZi0pQ7h9JuVNyPW
         vkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh1dGOF6z3ZHEXOnLNafwuf+KocUmg+Di2EHeSGPS14=;
        b=VkNXxwVa4lnIdPTA8zYPHDgQ4ODBRfRyYW3IybR8VNudHgaadXArqQKpXlHsha1UBU
         8vaLOd1jPU6dXxARdJ8PDz45HRPh0fbWZP7WvPaMicPjWQvHWg/3qw0p5v6l5iYZ0+S7
         mUzqdeg4GcAtHr8JFD6bW1jZM66WjlrKkhiYb0LDicGuMyFeOM8yN7U+XXcgJSkgdOeJ
         1xpGt98o0+H7uysLuMmxH9ZX9foaRgx1eH1fqxfC0pkhceeWrMPiGeQ8ofRolGussJyR
         ygAM6UIwcOiVJmZ8OicZylAzvFd1q2bX0z2nps09t6mM9lUAG2m11XOCaD/WpgdUSGsE
         wXJw==
X-Gm-Message-State: AOAM533nCroX5qo5Oj7wp6Istvh3jh2O9KIxM532xB7lmlkFX4sAZ7bB
        rgWYp3g3y/hCevI9RmVb8QM=
X-Google-Smtp-Source: ABdhPJzLG6MDZYE9+tYPEw2ML4qOqYcuZlHRjY8J0I5DsAoQoMQif5isenxdToNxPJBSPojKTTA5Iw==
X-Received: by 2002:a2e:a7cf:: with SMTP id x15mr25134828ljp.227.1630418217974;
        Tue, 31 Aug 2021 06:56:57 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:56:57 -0700 (PDT)
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
Subject: [PATCH v10 0/8] NVIDIA Tegra power management patches for 5.16
Date:   Tue, 31 Aug 2021 16:54:42 +0300
Message-Id: <20210831135450.26070-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a reduced version of the patchset which adds power management
support to NVIDIA Tegra drivers. Viresh Kumar asked to send these PD/OPP
patches separately for now to reduce the noise and finalize the review.

I implemented new dev_get_performance_state() GENPD callback as was
discussed in v8/v9. GR3D driver patch shows how it's used by consumer
drivers.

v10: - Replaced dev_pm_opp_from_clk_rate() with dev_pm_opp_get_current(),
       as was requested by Viresh Kumar.

     - Added more comments to the code and extended commit message,
       as was requested by Viresh Kumar and Ulf Hansson.

     - Renamed get_performance_state() to dev_get_performance_state(),
       as was requested by Ulf Hansson.

     - Factored out 'performance' code out of __genpd_dev_pm_attach() into
       a separate function genpd_dev_initialize_performance_state(), as was
       requested by Ulf Hansson.

     - Removed dev_suspended argument from dev_get_performance_state(),
       as was requested by Ulf Hansson. It's replaced by the usage of
       pm_runtime_status_suspended(), see genpd_dev_get_current_performance_state().

Dmitry Osipenko (8):
  opp: Add dev_pm_opp_get_current()
  opp: Allow dev_pm_opp_set_clkname() to replace released clock
  opp: Change type of dev_pm_opp_attach_genpd(names) argument
  PM: domains: Add dev_get_performance_state() callback
  soc/tegra: pmc: Implement dev_get_performance_state() callback
  soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
  gpu: host1x: Add host1x_channel_stop()
  drm/tegra: gr3d: Support generic power domain and runtime PM

 drivers/base/power/domain.c  |  90 ++++++--
 drivers/gpu/drm/tegra/gr3d.c | 384 ++++++++++++++++++++++++++++++-----
 drivers/gpu/host1x/channel.c |   8 +
 drivers/opp/core.c           |  51 ++++-
 drivers/soc/tegra/pmc.c      | 101 +++++++++
 include/linux/host1x.h       |   1 +
 include/linux/pm_domain.h    |   2 +
 include/linux/pm_opp.h       |  14 +-
 include/soc/tegra/common.h   |  13 ++
 9 files changed, 586 insertions(+), 78 deletions(-)

-- 
2.32.0

