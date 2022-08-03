Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54875588FDA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiHCPzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiHCPzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 11:55:19 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C7564DF
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 08:53:32 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31e7ca45091so176062467b3.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 08:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HBHqeyxcbnLI9faczCyH1rtG3WO3IhpgcuFCV7BdV0Y=;
        b=mw/HhSezeyXyxsjHIwG83nKT/x3XB7BEGTVhkjbdIX0o+e6ywcaS2WrdbRNdM2trBg
         f8bpUJV39pSvADlUvFpqwzOYWdf+W7FchK9rtYn7XV5Qf/gyvKecbmzaifcWfj/m7m7R
         UK1HKNg6zZwj4N0IsJP7LPWH6dFqrG0MBSLXKiY2ufLGfN2G5iasj0qcQk6QrAhyGmGR
         M641Yt9ltO22siIXRuygE/hnAUvH1Tt+fbsKHQ6HjJBjZ1HzeEC9MUaibP3SH8bTug97
         UIkqTCmAfRkeknSnB5RVbLZPmV89h3vndvlmElzfkgb/JL0igRcjdLtVge2a7yFGhkgd
         3uwg==
X-Gm-Message-State: ACgBeo18Vj4ti3p3cFf/0PfSkt2nTKI6N9DKaMFkzuNqhLcROqgwG0i4
        SuWndvkyjn10sNaQcz5iu1TS58GPHW80hZzWRu1XJVCd
X-Google-Smtp-Source: AA6agR5Pjq20liWIsBNCW5tWaPok9Gf6TBMV4qcp8HXJLz1utP7ZYEz8TKvMUkz9HNoWQUAJPU694v0k4rEz0Ptii5s=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr12886128ywd.149.1659542011555; Wed, 03
 Aug 2022 08:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220802043421.q6zykqujdyutt67k@vireshk-i7>
In-Reply-To: <20220802043421.q6zykqujdyutt67k@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 17:53:20 +0200
Message-ID: <CAJZ5v0hC-s+03YiVL9=2LEUWbV=kFzxPtRDAmSDHajabbEbk1w@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.20-rc1
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

On Tue, Aug 2, 2022 at 6:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit d2394860b45c3c1484e4b0a5d09909a1e3f6569e:
>
>   cpufreq: mediatek: Handle sram regulator probe deferral (2022-07-13 16:51:32 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-5.20-rc1
>
> for you to fetch changes up to 33fe1cb20cf44af9c12048b2bfdebae0408cd4aa:
>
>   cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances (2022-07-18 12:27:00 +0530)
>
> ----------------------------------------------------------------
> Cpufreq/arm updates for 5.20-rc1
>
> - Fix return error code in mtk_cpu_dvfs_info_init (Yang Yingliang).
>
> - Minor cleanups and support for new boards for Qcom cpufreq drivers
>   (Bryan O'Donoghue, Konrad Dybcio, Pierre Gondois, and Yicong Yang).
>
> - Fix sparse warnings for Tegra driver (Viresh Kumar).
>
> ----------------------------------------------------------------
> Bryan O'Donoghue (3):
>       dt-bindings: opp: opp-v2-kryo-cpu: Fix example binding checks
>       dt-bindings: opp: Add missing compat devices
>       dt-bindings: opp: Add msm8939 to the compatible list
>
> Konrad Dybcio (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6375 compatible
>
> Pierre Gondois (4):
>       cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
>       cpufreq: qcom-hw: Disable LMH irq when disabling policy
>       cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
>       cpufreq: Change order of online() CB and policy->cpus modification
>
> Viresh Kumar (1):
>       cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances
>
> Yang Yingliang (1):
>       cpufreq: mediatek: fix error return code in mtk_cpu_dvfs_info_init()
>
> Yicong Yang (1):
>       cpufreq: qcom-cpufreq-hw: use HZ_PER_KHZ macro in units.h
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml    |  1 +
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml |  7 +++++++
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml        | 15 +++++++++++++++
>  drivers/cpufreq/cpufreq.c                                         |  6 +++---
>  drivers/cpufreq/mediatek-cpufreq.c                                |  1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c                                 | 14 +++++++++-----
>  drivers/cpufreq/tegra194-cpufreq.c                                |  4 ++--
>  7 files changed, 38 insertions(+), 10 deletions(-)
>
> --

Pulled, thanks!
