Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC34C353A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 19:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiBXTAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 14:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBXTAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 14:00:11 -0500
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B422B18E42D
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 10:59:41 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2d62593ad9bso8443547b3.8
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 10:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biMjq7d7fdiFE8LWV/4+Oo9Lfb5iQsYoLNiRi7q+H+4=;
        b=EFWB4rJwe49tAXxlokTGw7xWMupdgYQhLkofa7L0C7sXDGc3VzGBGaJRLt7d9BV54r
         9KrJliSBT56iUXlDE3InIRfpJeFxps1GLMpU7HiYN/xwp4x2WVj58vJnvZGbGUKjEnfh
         89/O4yNIIUihfMiqnh0hQbDgT1RRTuq88EKPpfIy07mRXlIWUs2dsNvpKd/xsNaVn00F
         qvEHwYY0ro1IZ8nxnTUEo4aHJ0h7mGtgo5Ot7fEi0mExQhFhm12SgAh92/uZhY8huTdv
         3LXXbnG0KCHPavtWGT8NVw5H50jOwE7rI7bkQGZtGvwJRFFMdMepQdxmdxUtXMOryJEg
         ysnw==
X-Gm-Message-State: AOAM530SPG0HN6clcOmF+moOBRbJxP/FNdKxdjyqQjtN5sHBSPISvDiR
        lxBiPMQuozGX+g4mug0qG6PeJ4ldo6l6sgXCpZm9qMlu
X-Google-Smtp-Source: ABdhPJxek5R8TMWzGWAOeOIDtsutjErAdvU0Cug1aNYH8QBH90kQqUGBiFO9uYqzr0D2Kev/AunbkOwRmHEkq+CA3D4=
X-Received: by 2002:a81:8487:0:b0:2d6:9167:ecab with SMTP id
 u129-20020a818487000000b002d69167ecabmr3799156ywf.515.1645729180970; Thu, 24
 Feb 2022 10:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20220224043147.psbkkusn4bdv2eni@vireshk-i7>
In-Reply-To: <20220224043147.psbkkusn4bdv2eni@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Feb 2022 19:59:30 +0100
Message-ID: <CAJZ5v0jm4s0e0o0WgV9fcMzJ9FsqLKKAviHdW3Q7i6O5v=oaJQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.17-rc6
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

On Thu, Feb 24, 2022 at 5:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request fixes issues related to throttle irq for Qcom SoCs.
>
> -------------------------8<-------------------------
>
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
>
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes
>
> for you to fetch changes up to ef8ee1cb8fc8976a68f5e89cd5f7b6f7de80c66f:
>
>   cpufreq: qcom-hw: Delay enabling throttle_irq (2022-02-09 13:18:49 +0530)
>
> ----------------------------------------------------------------
> Bjorn Andersson (2):
>       cpufreq: Reintroduce ready() callback
>       cpufreq: qcom-hw: Delay enabling throttle_irq
>
>  Documentation/cpu-freq/cpu-drivers.rst                    |  3 +++
>  Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |  2 ++
>  drivers/cpufreq/cpufreq.c                                 |  4 ++++
>  drivers/cpufreq/qcom-cpufreq-hw.c                         | 11 ++++++++++-
>  include/linux/cpufreq.h                                   |  3 +++
>  5 files changed, 22 insertions(+), 1 deletion(-)
>
> --

Pulled and pushed out, thanks!
