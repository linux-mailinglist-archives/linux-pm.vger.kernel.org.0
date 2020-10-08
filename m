Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D739D2876FC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgJHPSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 11:18:38 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:33007 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgJHPSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 11:18:38 -0400
Received: by mail-oo1-f68.google.com with SMTP id r7so387652ool.0;
        Thu, 08 Oct 2020 08:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVTN3l7RCWCg+57rF3cB/zdsT9nZyrC1LZ/Pc3QOkPg=;
        b=h5q7OeANNvfFXdqJSfmu5Khf2vG/T318mcNU8r+JewYgqfP62BR0c8gEse+/rnD5wY
         uTS3eL1YlGdoOwoC/Ec+vMmjqMKW/x0W3pNTcnuomQ9OVsY/8JgK/X2mWB2Y5I7CPJFR
         25UeSRhjtkEG1mfS3qF3x0B91O+++cFcI4TN2Ew5vJp+NghP0r++AQ5O/0JuKnQighGi
         prks4Ya3n7yOukWRgd2SRYEbHfo+NFLgvhjeJLZPtTXelll6Itq7/p5ICgCM6Lu1L7ww
         uMcriwNkVjCw7y49CGTMsuZO4OCW1imdXL9TJAQTi6QzaJLoRteOo8eCN3CuVOKX1s9x
         +n6g==
X-Gm-Message-State: AOAM53314IHZt6DIajVG4ThJaP3wq9s3gSLTvJUvenjx7ivkd9M/4cKq
        wW4Q9f42kaUJW+FdmPvGHFmAXz4Ms12xyzQMw0aRBRwk
X-Google-Smtp-Source: ABdhPJwdTaCWeEKKtUZT0Fd4ttSycfvOA7vXKrn7kpF0QR9Q67ObsRAossur3ThMA7cjZYizHClXPKC9I5fu/d/hVwo=
X-Received: by 2002:a4a:d44:: with SMTP id 65mr5852302oob.44.1602170316044;
 Thu, 08 Oct 2020 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <CAJZ5v0hr+MZzokObNq5L0q1Fd0M5EXc6QmLXDv9b85P5b4yp4g@mail.gmail.com> <20201008140558.ovytcc34div3ih6m@bogus>
In-Reply-To: <20201008140558.ovytcc34div3ih6m@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Oct 2020 17:18:25 +0200
Message-ID: <CAJZ5v0hYu_86LB=nycAEDQQ3TsMMpcBV=Ue4WuOqH3YhxAehVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2]cpufreq,topology,arm: disable FI for BL_SWITCHER
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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

On Thu, Oct 8, 2020 at 4:06 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 07, 2020 at 04:34:44PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Sep 24, 2020 at 2:30 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > This series is the result of the discussions ([1], [2]) around the
> > > complications that the BL_SWITCHER poses when it comes to Frequency
> > > Invariance (FI) and it aims to restart the discussions.
> > >
> > > To properly scale its per-entity load-tracking signals, the task
> > > scheduler needs to be given a frequency scale factor, i.e. some image of
> > > the current frequency the CPU is running at, relative to its maximum
> > > frequency.
> > >
> > > But (reiterating the message in the changelog of patch 2/2), big.LITTLE
> > > switching complicates the setting of a correct cpufreq-based frequency
> > > invariance scale factor due to (as observed in
> > > drivers/cpufreq/vexpress-spc-cpufreq.c):
> > >  - Incorrect current and maximum frequencies as a result of the
> > >    exposure of a virtual frequency table to the cpufreq core,
> > >  - Missed updates as a result of asynchronous frequency adjustments
> > >    caused by frequency changes in other CPU pairs.
> > > More information on this feature can be found at [3].
> > >
> > > Given that its functionality is atypical in regards to FI and that this
> > > is an old technology, patch 2/2 disable FI for when big.LITTLE switching
> > > is configured in to prevent incorrect scale setting.
> > >
> > > For this purpose patch 1/2 changes the way arch_set_freq_scale() is
> > > defined in architecture code which brings it in line with the logic of
> > > other architectural function definitions while allowing for less invasive
> > > filtering of FI support.
> > >
> > > In the discussions at [2], three possible solutions were suggested:
> > >  - (1) conditioning FI by !CONFIG_BL_SWITCHER
> > >  - (2) leave as is with note in driver specifying this FI broken
> > >    functionality
> > >  - (3) removing full BL_SWITCHER support
> > >
> > > This series restructures the solution at (1). The reason for it is that
> > > the new patch limits the ifdef filtering to the arm topology include file,
> > > a location where frequency invariance functions are defined. Therefore,
> > > this seems more appropriate given that the b.L switcher is an arm
> > > technology and that the new FI filtering location seems more natural for
> > > conditioned FI disabling.
> > >
> > > Solutions (2) and (3) were not implemented given that there might be some
> > > remaining users of this technology (Samsung Chromebook 2 - Samsung Exynos
> > > 5 Octa 5420, Samsung Exynos 5 Octa 5800) and therefore leaving this
> > > broken (2) seems equally bad to removing support for it (3).
> > >
> > > [1] https://lore.kernel.org/lkml/20200701090751.7543-5-ionela.voinescu@arm.com/
> > > [2] https://lore.kernel.org/lkml/20200722093732.14297-4-ionela.voinescu@arm.com/
> > > [3] https://lwn.net/Articles/481055/
> >
> > I can take this set with the ACKs from Viresh if that's fine by
> > everyone.  Catalin?  Sudeep?
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com> (BL_SWITCHER and topology parts)

OK, the series has been applied as 5.10 material, thanks!
