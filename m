Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D124DF4B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHUSSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:18:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35115 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgHUSSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:18:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id k4so2303738oik.2;
        Fri, 21 Aug 2020 11:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjJkBvBjo776ONBX3/HAkoIAhioOEeqkU0qIVdyiyL8=;
        b=Zw7l3EQNDJPzJ0cCrAE74lY53hO3/nIiZyeu67RjmrjaRx/JrVXBf9FuZ+A/F9VRS6
         AnCpiaXw2L7nPFbLQvLJLP5ZjHa1euXxCxyEs0Io1lxJLzJdQuiPDuH6bcqy4Dcle3n2
         7fDgWDn6OPQFz+SSg8ODRpYnF+oHl0Nixh9OjLxNuSvcMvhVe/YM5GP+1KcjNEMz2QGh
         M9N9Z/APfF7CHU4fcwsgmnxbamLy5K6tVn7WouvyoyYwl1+8prbUQTaVHR8F4SFMYBiL
         mNoIUNu1x9RSkS9VTqHjsICr5xxvyQ1z4+VrlwFJcyJ4rF9++P+rFogjMaR6aewQMMM8
         0w+Q==
X-Gm-Message-State: AOAM5305nCFt9Qzh4k5uiYi+Z2KsoF1zNmN/7ts51UvzUmWRUdr/AFpj
        fmgc4S4dvXDBciiAdsNCN8KYcgb0y+rIA1ZQv+s=
X-Google-Smtp-Source: ABdhPJwDXJduVUwizXZmHUX9etUgUltSIzd/6mAXhHVLPONoFfI4erptBGS0kKbtYaKBSso5vjmNWttHpEInKH3w9wo=
X-Received: by 2002:aca:110a:: with SMTP id 10mr2503242oir.68.1598033897265;
 Fri, 21 Aug 2020 11:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
 <20200820053945.xlwtpkvbt4o23flk@vireshk-i7> <20200820123711.GA19989@bogus> <20200821052209.efturkzs2kp4nbcn@vireshk-i7>
In-Reply-To: <20200821052209.efturkzs2kp4nbcn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Aug 2020 20:18:06 +0200
Message-ID: <CAJZ5v0jPdgxR2erER74gcPtRFBCzWkoD7Zq1E-SgN7Lx50bvYg@mail.gmail.com>
Subject: Re: [Patch] cpufreq: replace cpu_logical_map with read_cpuid_mpir
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bbasu@nvidia.com, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 21, 2020 at 7:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-08-20, 13:37, Sudeep Holla wrote:
> > On Thu, Aug 20, 2020 at 11:09:45AM +0530, Viresh Kumar wrote:
> > > On 12-08-20, 01:13, Sumit Gupta wrote:
> > > > Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> > > > fixes the issue with building tegra194 cpufreq driver as module. But
> > > > the fix might cause problem while supporting physical cpu hotplug[1].
> > > >
> > > > This patch fixes the original problem by avoiding use of cpu_logical_map().
> > > > Instead calling read_cpuid_mpidr() to get MPIDR on target cpu.
> > > >
> > > > [1] https://lore.kernel.org/linux-arm-kernel/20200724131059.GB6521@bogus/
> > > >
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > > > ---
> > > >  drivers/cpufreq/tegra194-cpufreq.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > Applied. Thanks.
> >
> > Just to confirm, is this going as a fix ? We want to drop exporting
> > cpu_logical_map in v5.9 so this needs to go as fix. I missed it earlier,
> > actually,
> >
> > Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
> > is appropriate here so that we can drop export symbol which was part of
> > Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> > as a workaround to  fix the build.
>
> Okay.
>
> Rafael: Please pick this patch directly for next rc with
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.9-rc3 material with a couple of minor edits in the
subject and changelog, thanks!
