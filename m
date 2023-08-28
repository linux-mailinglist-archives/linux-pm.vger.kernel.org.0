Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9F78AFE6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjH1MS3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 28 Aug 2023 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjH1MSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 08:18:18 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E6125
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 05:18:15 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5710b0547easo101641eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 05:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225095; x=1693829895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxAELGF0SKbyTTlbnOkSYslBbLTAhhX6+P9DhsSBHHE=;
        b=lhU7bazwYccVeHkI7FVUdV8r+EOW3HS7EOe7h+/W6ryUpYay5mq9+iOSkTAUVQyz2L
         hg9hWFwA9evKi4HLD3Q9G8gOz6U0EW5o0GN3PRJHszCGhNptczjBuB7delQl2U/5Q9E4
         OOUAUXf2/9p+vQTQwM0ZJpRf64ftaOyX1E2olWWnRlTjWgn1LZmCSWC6Lmssh1yHOCnb
         zl70C5P9894TIm8gKcQkc2dnoDs03Xhj3JjusuLTeICsADP0Yju9hlpapUxriWwcw9mH
         XBCqjQBvTPcXGjKuicQUVGfOig5OjXx7MQvBUBJ9cmT6oTBlxyhPFqLXVLtKmpMDDBWW
         XFMg==
X-Gm-Message-State: AOJu0YxXI38u+JaB0U8TmVDOwiMFlQxe2wBT7f6e7iuyI2b9cxMoh5N0
        yrrdqOKsL2yxyJCTATkn5G2arbjDGRLg8U/BdyY=
X-Google-Smtp-Source: AGHT+IGsI4dDyjG6yLcb1sqAetAZ14r9Vedv0jBrxiY1Y/sUz9M8Nm5o0hmBQgGjIeDCTEHANDuaooJ9JgVQS1D9JrA=
X-Received: by 2002:a4a:ded9:0:b0:573:55af:777c with SMTP id
 w25-20020a4aded9000000b0057355af777cmr6479352oou.0.1693225094937; Mon, 28 Aug
 2023 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230828102554.7efox2bjzfxpa26j@vireshk-i7>
In-Reply-To: <20230828102554.7efox2bjzfxpa26j@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 14:18:00 +0200
Message-ID: <CAJZ5v0hfoemyWHPj=Mg2dc2Yfon79-dTooCdwOOYywP_ya-TMg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Aug 28, 2023 at 12:26 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.6
>
> for you to fetch changes up to de0e85b29edfc68046d587c7d67bbd2bdc31b73f:
>
>   cpufreq: tegra194: remove opp table in exit hook (2023-08-28 15:45:24 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.6
>
> - Migrate various platforms to use remove callback returning void
>   (Yangtao Li).
>
> - Add online/offline/exit hooks for Tegra driver (Sumit Gupta).
>
> - Explicitly include correct DT includes (Rob Herring).
>
> - Frequency domain updates for qcom-hw driver (Neil Armstrong).
>
> - Modify AMD pstate driver return the highest_perf value (Meng Li).
>
> - Generic cleanups for cppc, mediatek and powernow driver (Liao Chang
>   and Konrad Dybcio).
>
> - Add more platforms to cpufreq-arm driver's blocklist (AngeloGioacchino
>   Del Regno and Konrad Dybcio).
>
> - brcmstb-avs-cpufreq: Fix -Warray-bounds bug (Gustavo A. R. Silva).
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       cpufreq: blocklist MSM8998 in cpufreq-dt-platdev
>
> Gustavo A. R. Silva (1):
>       cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
>
> Konrad Dybcio (2):
>       cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
>       cpufreq: mediatek-hw: Remove unused define
>
> Liao Chang (4):
>       cpufreq: Prefer to print cpuid in MIN/MAX QoS register error message
>       cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.
>       cpufreq: cppc: Set fie_disabled to FIE_DISABLED if fails to create kworker_fie
>       cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
>
> Meng Li (1):
>       cpufreq: amd-pstate-ut: Modify the function to get the highest_perf value
>
> Neil Armstrong (2):
>       dt-bindings: cpufreq: qcom-hw: add a 4th frequency domain
>       cpufreq: qcom-cpufreq-hw: add support for 4 freq domains
>
> Rob Herring (1):
>       cpufreq: Explicitly include correct DT includes
>
> Sumit Gupta (2):
>       cpufreq: tegra194: add online/offline hooks
>       cpufreq: tegra194: remove opp table in exit hook
>
> Yangtao Li (19):
>       cpufreq: sun50i: Convert to platform remove callback returning void
>       cpufreq: dt: Convert to platform remove callback returning void
>       cpufreq: qcom-cpufreq-hw: Convert to platform remove callback returning void
>       cpufreq: vexpress: Convert to platform remove callback returning void
>       cpufreq: imx6q: Convert to platform remove callback returning void
>       cpufreq: mediatek-hw: Convert to platform remove callback returning void
>       cpufreq: scpi: Convert to platform remove callback returning void
>       cpufreq: tegra194: Convert to platform remove callback returning void
>       cpufreq: brcmstb-avs-cpufreq: Convert to platform remove callback returning void
>       cpufreq: imx-cpufreq-dt: Convert to platform remove callback returning void
>       cpufreq: davinci: Convert to platform remove callback returning void
>       cpufreq: raspberrypi: Convert to platform remove callback returning void
>       cpufreq: pcc-cpufreq: Convert to platform remove callback returning void
>       cpufreq: kirkwood: Convert to platform remove callback returning void
>       cpufreq: qcom-nvmem: Convert to platform remove callback returning void
>       cpufreq: tegra186: Convert to platform remove callback returning void
>       cpufreq: acpi: Convert to platform remove callback returning void
>       cpufreq: qoriq: Convert to platform remove callback returning void
>       cpufreq: omap: Convert to platform remove callback returning void
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  5 ++++-
>  drivers/cpufreq/acpi-cpufreq.c                                 |  6 ++----
>  drivers/cpufreq/amd-pstate-ut.c                                |  4 ++--
>  drivers/cpufreq/armada-37xx-cpufreq.c                          |  4 +---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c                          | 12 +++++++-----
>  drivers/cpufreq/cppc_cpufreq.c                                 | 13 ++++++++-----
>  drivers/cpufreq/cpufreq-dt-platdev.c                           |  7 +++++++
>  drivers/cpufreq/cpufreq-dt.c                                   |  5 ++---
>  drivers/cpufreq/cpufreq.c                                      |  8 ++++----
>  drivers/cpufreq/davinci-cpufreq.c                              |  6 ++----
>  drivers/cpufreq/imx-cpufreq-dt.c                               |  6 ++----
>  drivers/cpufreq/imx6q-cpufreq.c                                |  6 ++----
>  drivers/cpufreq/kirkwood-cpufreq.c                             |  6 ++----
>  drivers/cpufreq/mediatek-cpufreq-hw.c                          |  9 ++++-----
>  drivers/cpufreq/mediatek-cpufreq.c                             |  2 --
>  drivers/cpufreq/omap-cpufreq.c                                 |  6 ++----
>  drivers/cpufreq/pcc-cpufreq.c                                  |  6 ++----
>  drivers/cpufreq/powernow-k8.c                                  |  3 ++-
>  drivers/cpufreq/ppc_cbe_cpufreq.c                              |  2 +-
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c                          |  1 -
>  drivers/cpufreq/qcom-cpufreq-hw.c                              |  8 +++-----
>  drivers/cpufreq/qcom-cpufreq-nvmem.c                           |  7 ++-----
>  drivers/cpufreq/qoriq-cpufreq.c                                |  6 ++----
>  drivers/cpufreq/raspberrypi-cpufreq.c                          |  6 ++----
>  drivers/cpufreq/scpi-cpufreq.c                                 |  7 +++----
>  drivers/cpufreq/sti-cpufreq.c                                  |  2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c                         |  6 ++----
>  drivers/cpufreq/tegra186-cpufreq.c                             |  6 ++----
>  drivers/cpufreq/tegra194-cpufreq.c                             | 35 +++++++++++++++++++++++++++++++----
>  drivers/cpufreq/ti-cpufreq.c                                   |  2 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c                         |  6 ++----
>  include/linux/cpufreq.h                                        |  2 +-
>  32 files changed, 108 insertions(+), 102 deletions(-)
>
>
> --

Pulled, thanks!
