Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7770286151
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgJGOe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 10:34:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43281 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 10:34:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so2377764ota.10;
        Wed, 07 Oct 2020 07:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgDc8dM2xrjB20bw4f4PiZlRABZ5H2dY1eMkVvg7OTU=;
        b=ZiliCAk5eFLadW2BHu6zBenHCg99TiXL9geEI4s9rQOC3iZ+EeY2IFXfiGBa1mSmQL
         hrisOTb1LaiuzZ30PMm3wzWJ6Qr5a5n+4FCABlQk+v5puwFz4hGe9T9sXx0eTybNSYaQ
         Iy+BRx6ch0i7XbAW8FbyfJ0MvYj1ROACtvvOBe6j/yaR799imf2tskwGIU5enUB9dhXb
         6BSrKFYGH5y09YHbmjjnXPLHKroYVHB6WTK4VqzmNP4WqxHjbESu0T8Pv50IIvy+W/Ng
         dEBSn7whu8whe1ujAG9/PJs7fu4MUEQwCtAgLbFGqrWP/JfIQcVPnIv2qHQmLMfN+zfp
         52Hg==
X-Gm-Message-State: AOAM530Mn+hxadM3Jkv2G85ONI5cxFkfUlU+4+cSUGjHcFjrwU+920YD
        X15BQAWwc5chuhF5UElOV7/kikSQbLTikH0aa9Y=
X-Google-Smtp-Source: ABdhPJzu23bGwguFFrdflPnWMvQ9i8Nmkl4xL/jF3WIk7+7lZcfnMh87Zsp+cw/WRcpil19L3vljSNpmkgIAa3oLSbc=
X-Received: by 2002:a9d:3626:: with SMTP id w35mr2148009otb.206.1602081295952;
 Wed, 07 Oct 2020 07:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
In-Reply-To: <20200924123016.13427-1-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Oct 2020 16:34:44 +0200
Message-ID: <CAJZ5v0hr+MZzokObNq5L0q1Fd0M5EXc6QmLXDv9b85P5b4yp4g@mail.gmail.com>
Subject: Re: [PATCH 0/2]cpufreq,topology,arm: disable FI for BL_SWITCHER
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 2:30 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> This series is the result of the discussions ([1], [2]) around the
> complications that the BL_SWITCHER poses when it comes to Frequency
> Invariance (FI) and it aims to restart the discussions.
>
> To properly scale its per-entity load-tracking signals, the task
> scheduler needs to be given a frequency scale factor, i.e. some image of
> the current frequency the CPU is running at, relative to its maximum
> frequency.
>
> But (reiterating the message in the changelog of patch 2/2), big.LITTLE
> switching complicates the setting of a correct cpufreq-based frequency
> invariance scale factor due to (as observed in
> drivers/cpufreq/vexpress-spc-cpufreq.c):
>  - Incorrect current and maximum frequencies as a result of the
>    exposure of a virtual frequency table to the cpufreq core,
>  - Missed updates as a result of asynchronous frequency adjustments
>    caused by frequency changes in other CPU pairs.
> More information on this feature can be found at [3].
>
> Given that its functionality is atypical in regards to FI and that this
> is an old technology, patch 2/2 disable FI for when big.LITTLE switching
> is configured in to prevent incorrect scale setting.
>
> For this purpose patch 1/2 changes the way arch_set_freq_scale() is
> defined in architecture code which brings it in line with the logic of
> other architectural function definitions while allowing for less invasive
> filtering of FI support.
>
> In the discussions at [2], three possible solutions were suggested:
>  - (1) conditioning FI by !CONFIG_BL_SWITCHER
>  - (2) leave as is with note in driver specifying this FI broken
>    functionality
>  - (3) removing full BL_SWITCHER support
>
> This series restructures the solution at (1). The reason for it is that
> the new patch limits the ifdef filtering to the arm topology include file,
> a location where frequency invariance functions are defined. Therefore,
> this seems more appropriate given that the b.L switcher is an arm
> technology and that the new FI filtering location seems more natural for
> conditioned FI disabling.
>
> Solutions (2) and (3) were not implemented given that there might be some
> remaining users of this technology (Samsung Chromebook 2 - Samsung Exynos
> 5 Octa 5420, Samsung Exynos 5 Octa 5800) and therefore leaving this
> broken (2) seems equally bad to removing support for it (3).
>
> [1] https://lore.kernel.org/lkml/20200701090751.7543-5-ionela.voinescu@arm.com/
> [2] https://lore.kernel.org/lkml/20200722093732.14297-4-ionela.voinescu@arm.com/
> [3] https://lwn.net/Articles/481055/

I can take this set with the ACKs from Viresh if that's fine by
everyone.  Catalin?  Sudeep?
