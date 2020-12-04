Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D612A2CEEF9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgLDNrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 08:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgLDNrp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Dec 2020 08:47:45 -0500
X-Gm-Message-State: AOAM532yR9CrKr9xsuaI2fMRZyX3xtcX7lXPODRqXLUG3H39GNeMUNKx
        j9/v2Fku732LUH5JYHMjsmMpENR1tXivfutHUdE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607089624;
        bh=pm9VwuNY/VDkwZS2MZIL8VQEF5ZkZGjTf+DE9n6HcH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsFzRtyUz+b3IQfAaqJrq3lu2bmv2vxKbUEw2vnsAkLYB+pcNU1ynrZYoRYnrc0Cs
         unkI4iIddyCc9xFoA2S7WVoyAy46M1sLCK1KWrB8ceefXnnOdMkRWWT69yJjdw1V6y
         KamF8Vm0Og5rRB+YV/Pt5CMPqKruPkZ3U5KWV/PFWU2aHJIK6AoJ2fZthrRsBgX8Lo
         fh9sCZbLk8feNx8DW4bodXmk+XxlLFyLe/x6OIQV8IXbekKur1sUwGRjeJixo+AjGW
         ++VndNIZ5oMMNXV+LhuCIDHrhNyVRx93DLcDEOcw8gpnUsN4n+UpLauocMohlpg0n4
         xbXM0O+NHkTGw==
X-Google-Smtp-Source: ABdhPJyweb28R2vjGxZEpm6TmC7v5GuBGZYjfqoG6gp0tgT7IbA8GiLifcxIocR1Rtge9/fsqBo4eAHqmXVFWkWxfEw=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3687292otk.251.1607089623754;
 Fri, 04 Dec 2020 05:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20201203231809.1484631-1-arnd@kernel.org> <20201204113830.emyebwzeoas6trwy@bogus>
In-Reply-To: <20201204113830.emyebwzeoas6trwy@bogus>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 14:46:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nTCXg1nS_xRRk7aQ5shq-Y=v96UVc+OUXN6o1PMpzhA@mail.gmail.com>
Message-ID: <CAK8P3a1nTCXg1nS_xRRk7aQ5shq-Y=v96UVc+OUXN6o1PMpzhA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: scmi: add COMMON_CLK dependency
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 4, 2020 at 12:38 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Dec 04, 2020 at 12:17:46AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Wtihout CONFIG_COMMON_CLK, the scmi driver fails to link:
> >
> > arm-linux-gnueabi-ld: drivers/cpufreq/scmi-cpufreq.o: in function `scmi_cpufreq_probe':
> > scmi-cpufreq.c:(.text+0x20c): undefined reference to `devm_of_clk_add_hw_provider'
> > arm-linux-gnueabi-ld: scmi-cpufreq.c:(.text+0x22c): undefined reference to `of_clk_hw_simple_get'
> >
> > Add a Kconfig dependency for it.
> >
>
> There is a fix already upstream in later -rc(rc6 IIRC), I assume you are
> seeing this prior to that.
>
> Commit f943849f7206 ("cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK")

Ok, I missed that during my rebase.

> Since the only dependency on CONFIG_COMMON_CLK is to satisfy OPP adding
> dummy clock provider, I avoided adding dependency on CLK for this driver
> as this works fine for !CONFIG_COMMON_CLK.

Right. I don't think it makes much difference either way, though I usually
prefer code checks to be written as

        /* dummy clock provider as needed by OPP if clocks property is used */
        if (IS_ENABLED(CONFIG_COMMON_CLK) &&
           of_find_property(dev->of_node, "#clock-cells", NULL))
                devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);

which helps readability as well as compile coverage. Doesn't matter
here either, since there are only two lines inside.

     Arnd
