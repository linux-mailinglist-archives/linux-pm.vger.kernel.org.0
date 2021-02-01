Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130430A945
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhBAODA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:03:00 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35338 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhBAOC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 09:02:59 -0500
Received: by mail-oi1-f174.google.com with SMTP id w8so18862534oie.2;
        Mon, 01 Feb 2021 06:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjQ2aAipDSaq5oC4lmBya+0Rk1klXjpSSVN7GA5y3Ng=;
        b=tx1hsv+UOTZdkmkVsqprjcwNkmce1Z7Kmpr6pVGux/5cntzJ2+koInp0Of+ZT8GbbJ
         f3no2hLMfDxlojDrrdwgtfwFA6sAas2+nDMYMC546L4Z8+f92+XKR22Qlb3hW1/+2BAv
         76dK4TmaINCX7ABBvHZg24xqVRXC8AD2P/utJ7FAE8L6wkIbLHagITuqyVexyf86y4F/
         Va/7SNL6sHQ8wCtMJ9e1gKNSkdXTCPiB6beau2M09LDn6m9XuoLgwrbtD4FpLGHzZGNN
         s3knvojLv0oj72LR3mYLtGCf5T3JEUq9yYXkAIIDbByxu581gckufiBS4DsT+Z8bYH61
         JAaA==
X-Gm-Message-State: AOAM530BfBbSKtSkkefXKOXXPVRSEzvV8tY62vmTkcJsCkEFM4iAsNdQ
        kaJtlvfZA5wjvJZfRLdbuv3h08tQCLymoFSMxXWOs7q1
X-Google-Smtp-Source: ABdhPJw1DQOtXQiOfLob/rMGpYwphh6HqBDyeQVpm2HarfCzjirlfFQpNkL8KnEPZ6WvYaJWPQuOJUtbJQHKhwp2iUI=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr11038406oii.71.1612188138028;
 Mon, 01 Feb 2021 06:02:18 -0800 (PST)
MIME-Version: 1.0
References: <377d2e2d328276070ae2f26c65daa1497bb3c3cf.1612166647.git.viresh.kumar@linaro.org>
 <YBfNb91psVcf3TAS@light.dominikbrodowski.net> <20210201100502.xluaj5rpqosqsq7b@vireshk-i7>
In-Reply-To: <20210201100502.xluaj5rpqosqsq7b@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 15:02:06 +0100
Message-ID: <CAJZ5v0iowSHeie2HLPjHUftBDVBQXi30O1Kfk3Kxchc0K=gYag@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove CPUFREQ_STICKY flag
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 1, 2021 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-02-21, 10:44, Dominik Brodowski wrote:
> > IIRC, it was required on various ARM systems,[*] as CPUs were registered as
> > subsys_initcall(), while cpufreq used to be initialized only later, as an
>
> s/later/earlier ? arch happens before subsys not at least and that is
> the only way we can break cpufreq here, i.e. when the driver comes up
> before the CPUs are registered.
>
> > arch_initcall(). If the ordering is opposite now on all architectures (it
> > wasn't on ARM back then), we should be fine.
> >
> > [*] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/arm/mach-sa1100/cpu-sa1100.c?id=f59d3bbe35f6268d729f51be82af8325d62f20f5
>
> Thanks for your reply, it made me look at that aspect in some more
> detail to confirm I don't end up breaking anything. Unless I am making
> a mistake in reading the code, this is the code flow that we have
> right now:
>
> start_kernel()
> -> kernel_init()
>    -> kernel_init_freeable()
>       -> do_basic_setup()
>          -> driver_init()
>             -> cpu_dev_init()
>                -> subsys_system_register(for-CPUs)
>
>          -> do_initcalls()
>             -> register-cpufreq-driver from any level
>
> And so CPUs should always be there for a cpufreq driver.
>
> Makes sense ?

It does to me, but can you update the changelog, please?
