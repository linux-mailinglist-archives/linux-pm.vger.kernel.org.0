Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD77588FDC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiHCPzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiHCPzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 11:55:36 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D865B7
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 08:53:58 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3246910dac3so123851607b3.12
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l81u/XWIPAQ4mWbQyvzS7tNGosZBxdi5yLfzwhbpWPc=;
        b=Gk7Cryu6vV/DuloQOzdP2o/2IUWBjIC6YgkhB6Rcct80j8rtd7DYAmKrH337dqLVjU
         5n6bTGZEWI/6w+nyTNn9QCofl9ii4ux7sd49dvjcoT0+MkrJ2fRcMmQThUqiLBFTPKTB
         3Zdkrt7C379U846GqGgR6f1qzO8PQMElv+3JmS2r0a6McOrVj24h/d40kJx2OPyMDXyj
         uA8GvTjXPsMx62dJUWcivN9Oo4OLPgecu04m3NK+qVYITyR88njzMfvUxo1y+JDyjMPF
         vLql/8gyH2S3fKbVbz0iMsqFwydO85WJJyn7M36tkqc8GgffDsizO8+UO9BaJf9Py9bC
         lTvg==
X-Gm-Message-State: ACgBeo3YnTD4GjcuvFaZvVQa9XbmMb7HV+0noeV7nr+7XOb63TZTEsVH
        8kFQnyedqT94tC/RvIAYbMY45HMq027AQXaNEU1hMDy9
X-Google-Smtp-Source: AA6agR455RCE3N0eBptCDceJnh9ohJ8MDSR557tpVYIamlCKEWMtjIhRNzOqvrY217zsofr6x79bEtVpYw/gfLgx1Nc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr23270354ywb.326.1659542037969; Wed, 03
 Aug 2022 08:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802043813.qxl7etwseag2ncb3@vireshk-i7>
In-Reply-To: <20220802043813.qxl7etwseag2ncb3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 17:53:47 +0200
Message-ID: <CAJZ5v0j_KN_HnS0esFBvOhmoNUdO2h2GJT5pbOWBbgisz+mJTg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.20-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 2, 2022 at 6:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-5.20-rc1
>
> for you to fetch changes up to 1d95af02f23031c2e1cca7607c514b86ce85bc6e:
>
>   venus: pm_helpers: Fix warning in OPP during probe (2022-08-02 09:44:22 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 5.20-rc1
>
> - Make dev_pm_opp_set_regulators() accept NULL terminated list (Viresh
>   Kumar).
>
> - Add dev_pm_opp_set_config() and friends and migrate other
>   users/helpers to using them (Viresh Kumar).
>
> - Add support for multiple clocks for a device (Viresh Kumar and
>   Krzysztof Kozlowski).
>
> - Configure resources before adding OPP table for Venus (Stanimir
>   Varbanov).
>
> - Keep reference count up for opp->np and opp_table->np while they are
>   still in use (Liang He).
>
> - Minor cleanups (Viresh Kumar and Yang Li).
>
> ----------------------------------------------------------------
> Krzysztof Kozlowski (1):
>       dt-bindings: opp: accept array of frequencies
>
> Liang He (2):
>       OPP: Don't drop opp_table->np reference while it is still in use
>       OPP: Don't drop opp->np reference while it is still in use
>
> Stanimir Varbanov (1):
>       venus: pm_helpers: Fix warning in OPP during probe
>
> Tang Bin (1):
>       opp: Fix error check in dev_pm_opp_attach_genpd()
>
> Viresh Kumar (37):
>       OPP: Fix typo in comment
>       OPP: Track if clock name is configured by platform
>       OPP: Make dev_pm_opp_set_regulators() accept NULL terminated list
>       OPP: Add dev_pm_opp_set_config() and friends
>       cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
>       cpufreq: sti: Migrate to dev_pm_opp_set_config()
>       cpufreq: ti: Migrate to dev_pm_opp_set_config()
>       drm/lima: Migrate to dev_pm_opp_set_config()
>       soc/tegra: Add comment over devm_pm_opp_set_clkname()
>       soc/tegra: Migrate to dev_pm_opp_set_config()
>       OPP: Migrate set-regulators API to use set-config helpers
>       OPP: Migrate set-supported-hw API to use set-config helpers
>       OPP: Migrate set-clk-name API to use set-config helpers
>       OPP: Migrate set-opp-helper API to use set-config helpers
>       OPP: Migrate attach-genpd API to use set-config helpers
>       OPP: Migrate set-prop-name helper API to use set-config helpers
>       OPP: Add support for config_regulators() helper
>       OPP: Make _generic_set_opp_regulator() a config_regulators() interface
>       OPP: Add dev_pm_opp_get_supplies()
>       OPP: ti: Migrate to dev_pm_opp_set_config_regulators()
>       OPP: Remove custom OPP helper support
>       OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
>       OPP: Add generic key finding helpers and use them for freq APIs
>       OPP: Use generic key finding helpers for level key
>       OPP: Use generic key finding helpers for bandwidth key
>       OPP: Use consistent names for OPP table instances
>       OPP: Remove rate_not_available parameter to _opp_add()
>       OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
>       OPP: Make dev_pm_opp_set_opp() independent of frequency
>       OPP: Allow multiple clocks for a device
>       OPP: Compare bandwidths for all paths in _opp_compare_key()
>       OPP: Add key specific assert() method to key finding helpers
>       OPP: Assert clk_count == 1 for single clk helpers
>       OPP: Provide a simple implementation to configure multiple clocks
>       OPP: Allow config_clks helper for single clk case
>       PM / devfreq: tegra30: Register config_clks helper
>       OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
>
> Yang Li (1):
>       opp: Fix some kernel-doc comments
>
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml |   10 +
>  drivers/cpufreq/cpufreq-dt.c                           |   19 +-
>  drivers/cpufreq/imx-cpufreq-dt.c                       |   12 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c                   |  109 +++--------
>  drivers/cpufreq/sti-cpufreq.c                          |   27 +--
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c                 |   31 ++-
>  drivers/cpufreq/tegra20-cpufreq.c                      |   12 +-
>  drivers/cpufreq/ti-cpufreq.c                           |   42 ++--
>  drivers/devfreq/exynos-bus.c                           |   21 +-
>  drivers/devfreq/tegra30-devfreq.c                      |   22 ++-
>  drivers/gpu/drm/lima/lima_devfreq.c                    |   12 +-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c            |    3 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c                |   15 +-
>  drivers/media/platform/qcom/venus/pm_helpers.c         |   10 +-
>  drivers/memory/tegra/tegra124-emc.c                    |   11 +-
>  drivers/opp/core.c                                     | 1577 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
>  drivers/opp/cpu.c                                      |   12 +-
>  drivers/opp/debugfs.c                                  |   27 ++-
>  drivers/opp/of.c                                       |  150 +++++++-------
>  drivers/opp/opp.h                                      |   56 ++++--
>  drivers/opp/ti-opp-supply.c                            |   77 ++++----
>  drivers/soc/tegra/common.c                             |   49 +++--
>  drivers/soc/tegra/pmc.c                                |    4 +-
>  include/linux/pm_opp.h                                 |  322 ++++++++++++++++++------------
>  24 files changed, 1356 insertions(+), 1274 deletions(-)
>
> --

Pulled, thanks!
