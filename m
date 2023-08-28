Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3378AAEE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjH1K03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjH1K0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 06:26:03 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5368A7
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:25:57 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bca3588edbso2041183a34.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693218357; x=1693823157;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RV6IehAxgBW01OkHmve1iNl4VRL1mnaDUT/WAuyqcEk=;
        b=EIMLBRbCHq9Ein3NsjizfS9p+VEHq+RXJ2Pw3JeQScKtmJpPEMxIpzhLcI2fNAgNjy
         e2IYbWrKIzR/xSktZW4ojpLQYtNp4QjfRP7nt7DMW4poVfr+7cbzGrIz7ZEcKj2UzwFw
         agoRKhnBTTTXzonpJlyyIubu91svhXTLHeMQVOOmb/3k6MHraaxsWRcFii3cl6dZ2azH
         8LuO2Kd4kani7hmJkQXwi+Sz6MpiY3mcQGpox4OaskQsvfvV0SoC1fTizLzWD3bfaQ+b
         JmnDkc0OI8WglV7gCQYVy03Pj62DiBAtw9btZeu7FLTWEkwjn4PPCtyoYxF626f//NAJ
         kDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218357; x=1693823157;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RV6IehAxgBW01OkHmve1iNl4VRL1mnaDUT/WAuyqcEk=;
        b=MaVgXU6L3n/OttZVFHhZ7fput8RI0A0QuDnQX9Ruo8WFW/8elsH4I7YSCo/WcxMRU8
         21fg2mbYzHR8F8d12JOKA4XEapA1VXtws3sfDy6DVi2pyXq47Oz9MoHhlMPxF4t2MeTq
         ega1YPlOYLqM+R5SFawmFd1v+lKbs27XafilQdEzFg4zFAyLnM2SLppcHksCUjZ8IgA6
         NO5/8t3sgzg36HohRMM3sLsNNeAYi5QN55YZ52pSmO2gsv3UIhNatLHRjnajP71oyXxC
         GwIbs7eFw4KIeoFp4NkMDjH/V70VmDtbPs8jnoFu12aLGPQZW696v2VeGWpSzFZbKyf4
         XHWQ==
X-Gm-Message-State: AOJu0YyGJlLA4fUxV4/gBQmJWhZmS9R61czYqUmhXjbdHVvpjCWJPEFb
        C/g1rJl3VSWpmU2wyvdZHofHLA==
X-Google-Smtp-Source: AGHT+IHuA/w7KA6uDDxajT/mu//ru834p5s74AmOn3ixJV0gd3vGE1yG0PM9nWDRv24v4+zGY6lUFA==
X-Received: by 2002:a05:6870:e314:b0:1bb:ec07:83f1 with SMTP id z20-20020a056870e31400b001bbec0783f1mr10075585oad.43.1693218357084;
        Mon, 28 Aug 2023 03:25:57 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id a14-20020a62bd0e000000b006870ff20254sm6226383pff.125.2023.08.28.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:25:56 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:55:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.6
Message-ID: <20230828102554.7efox2bjzfxpa26j@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.6

for you to fetch changes up to de0e85b29edfc68046d587c7d67bbd2bdc31b73f:

  cpufreq: tegra194: remove opp table in exit hook (2023-08-28 15:45:24 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.6

- Migrate various platforms to use remove callback returning void
  (Yangtao Li).

- Add online/offline/exit hooks for Tegra driver (Sumit Gupta).

- Explicitly include correct DT includes (Rob Herring).

- Frequency domain updates for qcom-hw driver (Neil Armstrong).

- Modify AMD pstate driver return the highest_perf value (Meng Li).

- Generic cleanups for cppc, mediatek and powernow driver (Liao Chang
  and Konrad Dybcio).

- Add more platforms to cpufreq-arm driver's blocklist (AngeloGioacchino
  Del Regno and Konrad Dybcio).

- brcmstb-avs-cpufreq: Fix -Warray-bounds bug (Gustavo A. R. Silva).

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      cpufreq: blocklist MSM8998 in cpufreq-dt-platdev

Gustavo A. R. Silva (1):
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Konrad Dybcio (2):
      cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
      cpufreq: mediatek-hw: Remove unused define

Liao Chang (4):
      cpufreq: Prefer to print cpuid in MIN/MAX QoS register error message
      cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.
      cpufreq: cppc: Set fie_disabled to FIE_DISABLED if fails to create kworker_fie
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Meng Li (1):
      cpufreq: amd-pstate-ut: Modify the function to get the highest_perf value

Neil Armstrong (2):
      dt-bindings: cpufreq: qcom-hw: add a 4th frequency domain
      cpufreq: qcom-cpufreq-hw: add support for 4 freq domains

Rob Herring (1):
      cpufreq: Explicitly include correct DT includes

Sumit Gupta (2):
      cpufreq: tegra194: add online/offline hooks
      cpufreq: tegra194: remove opp table in exit hook

Yangtao Li (19):
      cpufreq: sun50i: Convert to platform remove callback returning void
      cpufreq: dt: Convert to platform remove callback returning void
      cpufreq: qcom-cpufreq-hw: Convert to platform remove callback returning void
      cpufreq: vexpress: Convert to platform remove callback returning void
      cpufreq: imx6q: Convert to platform remove callback returning void
      cpufreq: mediatek-hw: Convert to platform remove callback returning void
      cpufreq: scpi: Convert to platform remove callback returning void
      cpufreq: tegra194: Convert to platform remove callback returning void
      cpufreq: brcmstb-avs-cpufreq: Convert to platform remove callback returning void
      cpufreq: imx-cpufreq-dt: Convert to platform remove callback returning void
      cpufreq: davinci: Convert to platform remove callback returning void
      cpufreq: raspberrypi: Convert to platform remove callback returning void
      cpufreq: pcc-cpufreq: Convert to platform remove callback returning void
      cpufreq: kirkwood: Convert to platform remove callback returning void
      cpufreq: qcom-nvmem: Convert to platform remove callback returning void
      cpufreq: tegra186: Convert to platform remove callback returning void
      cpufreq: acpi: Convert to platform remove callback returning void
      cpufreq: qoriq: Convert to platform remove callback returning void
      cpufreq: omap: Convert to platform remove callback returning void

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  5 ++++-
 drivers/cpufreq/acpi-cpufreq.c                                 |  6 ++----
 drivers/cpufreq/amd-pstate-ut.c                                |  4 ++--
 drivers/cpufreq/armada-37xx-cpufreq.c                          |  4 +---
 drivers/cpufreq/brcmstb-avs-cpufreq.c                          | 12 +++++++-----
 drivers/cpufreq/cppc_cpufreq.c                                 | 13 ++++++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c                           |  7 +++++++
 drivers/cpufreq/cpufreq-dt.c                                   |  5 ++---
 drivers/cpufreq/cpufreq.c                                      |  8 ++++----
 drivers/cpufreq/davinci-cpufreq.c                              |  6 ++----
 drivers/cpufreq/imx-cpufreq-dt.c                               |  6 ++----
 drivers/cpufreq/imx6q-cpufreq.c                                |  6 ++----
 drivers/cpufreq/kirkwood-cpufreq.c                             |  6 ++----
 drivers/cpufreq/mediatek-cpufreq-hw.c                          |  9 ++++-----
 drivers/cpufreq/mediatek-cpufreq.c                             |  2 --
 drivers/cpufreq/omap-cpufreq.c                                 |  6 ++----
 drivers/cpufreq/pcc-cpufreq.c                                  |  6 ++----
 drivers/cpufreq/powernow-k8.c                                  |  3 ++-
 drivers/cpufreq/ppc_cbe_cpufreq.c                              |  2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c                          |  1 -
 drivers/cpufreq/qcom-cpufreq-hw.c                              |  8 +++-----
 drivers/cpufreq/qcom-cpufreq-nvmem.c                           |  7 ++-----
 drivers/cpufreq/qoriq-cpufreq.c                                |  6 ++----
 drivers/cpufreq/raspberrypi-cpufreq.c                          |  6 ++----
 drivers/cpufreq/scpi-cpufreq.c                                 |  7 +++----
 drivers/cpufreq/sti-cpufreq.c                                  |  2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                         |  6 ++----
 drivers/cpufreq/tegra186-cpufreq.c                             |  6 ++----
 drivers/cpufreq/tegra194-cpufreq.c                             | 35 +++++++++++++++++++++++++++++++----
 drivers/cpufreq/ti-cpufreq.c                                   |  2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c                         |  6 ++----
 include/linux/cpufreq.h                                        |  2 +-
 32 files changed, 108 insertions(+), 102 deletions(-)


-- 
viresh
