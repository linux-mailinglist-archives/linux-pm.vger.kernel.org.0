Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FC533DAA
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiEYNUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbiEYNTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 09:19:53 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8771D0DD
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 06:19:41 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id g72so8183495ybf.0
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 06:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN7y3UT5BTE4F+2bbUgE6JO/7u5HkYZnnALakV1gSwo=;
        b=29LMFkrR4mBQcvfnQZ2r0VvaVu291kiYvMsPRNpWltgC9mOA2TwS9Gbh+QAPERJIuR
         T4Z4Ro6JVDVnrU75WIJYvo8B+b0N5vUak5FYKdR7SMnEZLmrf1CW1W9YuuFJ64VuAEPT
         PIrUleimToPlEWgadl5MVwoZJaqIheZ6y80+9Oi41h/yOMqNcvRTRliKnggGDM3iphSI
         RVv+3zDdtzAfO8R6bEChSgKer6xJxg3YI4ta3TMvnsWmfHtr9UaD5RPyj4l78Tb3e+Mw
         Zk8uPhqAaUJORLqgnY5tHCgs8rgHYYWqsA4yGQGWcH3piFMooM+9Eghcv3pv/US96TLC
         RB9g==
X-Gm-Message-State: AOAM533qKVNPHSksu/my1yblEIvOtJBlyQ7igth7LFpsrZ9in3NKE/OX
        nSlFTfMpVr8xHAMMtiHj1owMB0rQP4Azy7ltCC4=
X-Google-Smtp-Source: ABdhPJzrURzpKt8/h92nPvhM+mKRJ7DsSzhBPxP5Hps8GpY7P10+IJdvn0ln+nny0WRJ41W23F+hX8nrW04g0xknioU=
X-Received: by 2002:a25:6dc5:0:b0:655:bf98:2421 with SMTP id
 i188-20020a256dc5000000b00655bf982421mr2013906ybc.633.1653484764271; Wed, 25
 May 2022 06:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220524051731.lm2qg5ld34ss56hr@vireshk-i7>
In-Reply-To: <20220524051731.lm2qg5ld34ss56hr@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:19:13 +0200
Message-ID: <CAJZ5v0iV=a3nfTR0Y7UwzQ4_AwFBtu2yH-+VfOAsUiaxzTZvBQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.19-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 24, 2022 at 7:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The following changes since commit e4e6448638a01905faeda9bf96aa9df7c8ef463c:
>
>   cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts (2022-04-26 12:08:31 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-5.19-rc1
>
> for you to fetch changes up to 39b360102f3ac6b12cafac9db25762071eb0418c:
>
>   cpufreq: mediatek: Add support for MT8186 (2022-05-12 10:39:31 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm updates for 5.19-rc1
>
> - Tegra234 cpufreq support (Sumit Gupta).
>
> - Mediatek cleanups and enhancements (Wan Jiabing, Rex-BC Chen, and
>   Jia-Wei Chang).
>
> ----------------------------------------------------------------
> Jia-Wei Chang (8):
>       cpufreq: mediatek: Use module_init and add module_exit
>       cpufreq: mediatek: Cleanup variables and error handling in mtk_cpu_dvfs_info_init()
>       cpufreq: mediatek: Remove unused headers
>       cpufreq: mediatek: Enable clocks and regulators
>       cpufreq: mediatek: Record previous target vproc value
>       cpufreq: mediatek: Make sram regulator optional
>       cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
>       cpufreq: mediatek: Add support for MT8186
>
> Rex-BC Chen (7):
>       cpufreq: mediatek: Use device print to show logs
>       cpufreq: mediatek: Replace old_* with pre_*
>       cpufreq: mediatek: Unregister platform device on exit
>       cpufreq: mediatek: Move voltage limits to platform data
>       cpufreq: mediatek: Add opp notification support
>       dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
>       cpufreq: mediatek: Link CCI device to CPU
>
> Sumit Gupta (4):
>       dt-bindings: Document Tegra CCPLEX Cluster
>       cpufreq: tegra194: add soc data to support multiple soc
>       cpufreq: tegra194: Add support for Tegra234
>       arm64: tegra: add node for tegra234 cpufreq
>
> Wan Jiabing (2):
>       cpufreq: mediatek: Fix NULL pointer dereference in mediatek-cpufreq
>       cpufreq: mediatek: Fix potential deadlock problem in mtk_cpufreq_set_target
>
>  .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |  52 ++
>  .../bindings/cpufreq/cpufreq-mediatek.txt          |   7 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   7 +
>  drivers/cpufreq/mediatek-cpufreq.c                 | 636 ++++++++++++++-------
>  drivers/cpufreq/tegra194-cpufreq.c                 | 246 ++++++--
>  5 files changed, 689 insertions(+), 259 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

Pulled, thanks!
