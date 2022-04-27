Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0A5121A8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiD0Sxj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiD0Sx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:53:28 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D05C9B74
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:39:39 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id m128so5010202ybm.5
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXM1X4eSWAP/oI5mIGY6pzukTtEg28nezONepuUy9sc=;
        b=Hco7LaiuMck6uiZpWiCMy/OvrJGghb9rZooGidh0XXj8f3YdX8NcZWTla0be/qiiKu
         k9jChEYgnYuav5b8GtrAQPAd7lareSWoDXl1syZB3PQ2/RQ+CKoSbgEJjnqg6Fm/qV42
         eckgtplcWApXbgQH+qnr0OXUNStfCcdwNU4krV4L1aY5TNEBw3CWQTH7dCHJkKHzBdIt
         dxqRAr8ZCMs4R3EzIScQ76ViaMp55Gz7PwxZ3aSPiaX2VYm4HfeKUpd2O8KSp1VkXnyt
         6ATG7zJPkodr+ArarSHGFtCVbVGJXDICJoR2v7QFTUv78cbmGaceVi1PdCfncfui6Yvn
         7P6A==
X-Gm-Message-State: AOAM532mdHTOEErZjaVKbR3VYqOISRtjfGsvp32/3BloP4HwHyvdU7gk
        9KUu2wdghfgdH7FwpV58ipZmz8w8+GNshV/Cwos=
X-Google-Smtp-Source: ABdhPJz+zwuQQsdI/8BuFByw3D8cnLrhLKJURkpGHMggVaEbPfUxVPfOAu4pPZriakNUX4LYkaF6dm1qrYxIm/mpkjM=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr26135109ybh.81.1651084778863; Wed, 27
 Apr 2022 11:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220426065239.qtho7kwvdohqnff2@vireshk-i7>
In-Reply-To: <20220426065239.qtho7kwvdohqnff2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Apr 2022 20:39:27 +0200
Message-ID: <CAJZ5v0jcCuDqk-ESfWDMYuciy5qpxP-2+8PinnA5F-LTQF5oLQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.18-rc5
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

On Tue, Apr 26, 2022 at 8:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
>
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.18-rc5
>
> for you to fetch changes up to e4e6448638a01905faeda9bf96aa9df7c8ef463c:
>
>   cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts (2022-04-26 12:08:31 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm fixes for 5.18-rc5
>
> - Fix issues with the Qualcomm's cpufreq driver (Dmitry Baryshkov and
>   Vladimir Zapolskiy).
> - Fix memory leak with the Sun501 driver (Xiaobing Luo).
>
> ----------------------------------------------------------------
> Dmitry Baryshkov (4):
>       cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
>       cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
>       cpufreq: qcom-hw: fix the opp entries refcounting
>       cpufreq: qcom-hw: provide online/offline operations
>
> Vladimir Zapolskiy (2):
>       cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms
>       cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
>
> Xiaobing Luo (1):
>       cpufreq: fix memory leak in sun50i_cpufreq_nvmem_probe
>
>  drivers/cpufreq/qcom-cpufreq-hw.c      | 70 +++++++++++++++++++++++++++-------
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  4 +-
>  2 files changed, 60 insertions(+), 14 deletions(-)
>
> --

Pulled and pushed out, thanks!
