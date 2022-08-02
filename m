Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E310587669
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiHBEiS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 00:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBEiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 00:38:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37923E0B2
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 21:38:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h28so6135278pfq.11
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+sVDX8J2fsFaU4/JOLF7uHVZ3sDfDMe4Q5bGv+SxkRA=;
        b=CPGo4ofXPVNgguOet/7LhVmln6eOc/j3c3Dry4DVW+YWJZSEMF+gp8wkcpPKg/TmPJ
         q6XzpcPvivWO3MZgGAhHUZPlsSLkJO4ieBzxtg9F3g3SB/0AEDKilXbpusW+RH3v+KTg
         QRIIzr/fxdbmWnINxXnhhPznbFy1sJ8DOonLrIXeg8vLCUIXb5j9NQ6pjBgLyXm7cCkl
         JauSXYNAvQGPC28SHpbBOgncGYT+Fhv9psNxZaY5xcFy8IOTCE9D4A25cmOu9CEvmvAc
         2gAuVXQVGjeplDtFmghJYC03QSbiScCOpv3qNRfr7G3iFFug82DsXf2zdIOyythvTLMI
         wFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+sVDX8J2fsFaU4/JOLF7uHVZ3sDfDMe4Q5bGv+SxkRA=;
        b=pzm/7gmasvzi0MZH1g3bsmYcK6WqCrK9mzL7KpIRCeWTJCL8dJCdbgZZx8eQLwXcvF
         OdYz6Xz1yE/faceLtnSSexX8CtMzwSr8n1XL1XoG5wheYowXaQCObbVEojfIXLhwIYp1
         KrmJp/LEGLS8FaEmubXl6s/Bf/LuiFwyLaWWLKJ1Im6Lcsd22e/xjet+HskJOy5eBoAW
         qkuH4EzP8UftAkZ7VHmVBqY/sSqF+tYC03Gts8DgdEbpd4FpcsDBXbx66JtTCMWP9mmc
         o6gdbOWWDFDySvx8lIzYgpzMVeF/ZsDjUXN/+cpvAf+EkoQp6oTfGzcJC3t2EAuef1cP
         S+CQ==
X-Gm-Message-State: AJIora9Fqvl75EQlcs15EHaJbdFI0D4c3/fvChRLjxhd/CGgvj1MuqY4
        2g9ZQV4rPfJMVljudiOC8io75w==
X-Google-Smtp-Source: AGRyM1uYw8OYUDrO4CbOkdXZtNzLsXryFdYIeYdAVGA9ABzzV7H/QR4I39EqeNibRJfksQspemqvKw==
X-Received: by 2002:a65:5cc4:0:b0:41a:ae9f:5642 with SMTP id b4-20020a655cc4000000b0041aae9f5642mr15639247pgt.542.1659415095627;
        Mon, 01 Aug 2022 21:38:15 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y10-20020a655a0a000000b0041c66a66d41sm398386pgs.45.2022.08.01.21.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 21:38:15 -0700 (PDT)
Date:   Tue, 2 Aug 2022 10:08:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.20-rc1
Message-ID: <20220802043813.qxl7etwseag2ncb3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-5.20-rc1

for you to fetch changes up to 1d95af02f23031c2e1cca7607c514b86ce85bc6e:

  venus: pm_helpers: Fix warning in OPP during probe (2022-08-02 09:44:22 +0530)

----------------------------------------------------------------
OPP updates for 5.20-rc1

- Make dev_pm_opp_set_regulators() accept NULL terminated list (Viresh
  Kumar).

- Add dev_pm_opp_set_config() and friends and migrate other
  users/helpers to using them (Viresh Kumar).

- Add support for multiple clocks for a device (Viresh Kumar and
  Krzysztof Kozlowski).

- Configure resources before adding OPP table for Venus (Stanimir
  Varbanov).

- Keep reference count up for opp->np and opp_table->np while they are
  still in use (Liang He).

- Minor cleanups (Viresh Kumar and Yang Li).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: opp: accept array of frequencies

Liang He (2):
      OPP: Don't drop opp_table->np reference while it is still in use
      OPP: Don't drop opp->np reference while it is still in use

Stanimir Varbanov (1):
      venus: pm_helpers: Fix warning in OPP during probe

Tang Bin (1):
      opp: Fix error check in dev_pm_opp_attach_genpd()

Viresh Kumar (37):
      OPP: Fix typo in comment
      OPP: Track if clock name is configured by platform
      OPP: Make dev_pm_opp_set_regulators() accept NULL terminated list
      OPP: Add dev_pm_opp_set_config() and friends
      cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
      cpufreq: sti: Migrate to dev_pm_opp_set_config()
      cpufreq: ti: Migrate to dev_pm_opp_set_config()
      drm/lima: Migrate to dev_pm_opp_set_config()
      soc/tegra: Add comment over devm_pm_opp_set_clkname()
      soc/tegra: Migrate to dev_pm_opp_set_config()
      OPP: Migrate set-regulators API to use set-config helpers
      OPP: Migrate set-supported-hw API to use set-config helpers
      OPP: Migrate set-clk-name API to use set-config helpers
      OPP: Migrate set-opp-helper API to use set-config helpers
      OPP: Migrate attach-genpd API to use set-config helpers
      OPP: Migrate set-prop-name helper API to use set-config helpers
      OPP: Add support for config_regulators() helper
      OPP: Make _generic_set_opp_regulator() a config_regulators() interface
      OPP: Add dev_pm_opp_get_supplies()
      OPP: ti: Migrate to dev_pm_opp_set_config_regulators()
      OPP: Remove custom OPP helper support
      OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
      OPP: Add generic key finding helpers and use them for freq APIs
      OPP: Use generic key finding helpers for level key
      OPP: Use generic key finding helpers for bandwidth key
      OPP: Use consistent names for OPP table instances
      OPP: Remove rate_not_available parameter to _opp_add()
      OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
      OPP: Make dev_pm_opp_set_opp() independent of frequency
      OPP: Allow multiple clocks for a device
      OPP: Compare bandwidths for all paths in _opp_compare_key()
      OPP: Add key specific assert() method to key finding helpers
      OPP: Assert clk_count == 1 for single clk helpers
      OPP: Provide a simple implementation to configure multiple clocks
      OPP: Allow config_clks helper for single clk case
      PM / devfreq: tegra30: Register config_clks helper
      OPP: Remove dev{m}_pm_opp_of_add_table_noclk()

Yang Li (1):
      opp: Fix some kernel-doc comments

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml |   10 +
 drivers/cpufreq/cpufreq-dt.c                           |   19 +-
 drivers/cpufreq/imx-cpufreq-dt.c                       |   12 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c                   |  109 +++--------
 drivers/cpufreq/sti-cpufreq.c                          |   27 +--
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                 |   31 ++-
 drivers/cpufreq/tegra20-cpufreq.c                      |   12 +-
 drivers/cpufreq/ti-cpufreq.c                           |   42 ++--
 drivers/devfreq/exynos-bus.c                           |   21 +-
 drivers/devfreq/tegra30-devfreq.c                      |   22 ++-
 drivers/gpu/drm/lima/lima_devfreq.c                    |   12 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c            |    3 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c                |   15 +-
 drivers/media/platform/qcom/venus/pm_helpers.c         |   10 +-
 drivers/memory/tegra/tegra124-emc.c                    |   11 +-
 drivers/opp/core.c                                     | 1577 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 drivers/opp/cpu.c                                      |   12 +-
 drivers/opp/debugfs.c                                  |   27 ++-
 drivers/opp/of.c                                       |  150 +++++++-------
 drivers/opp/opp.h                                      |   56 ++++--
 drivers/opp/ti-opp-supply.c                            |   77 ++++----
 drivers/soc/tegra/common.c                             |   49 +++--
 drivers/soc/tegra/pmc.c                                |    4 +-
 include/linux/pm_opp.h                                 |  322 ++++++++++++++++++------------
 24 files changed, 1356 insertions(+), 1274 deletions(-)

-- 
viresh
