Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594B66CEA2
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfGRNMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 09:12:10 -0400
Received: from foss.arm.com ([217.140.110.172]:58224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGRNMK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jul 2019 09:12:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF528344;
        Thu, 18 Jul 2019 06:12:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09D7C3F71F;
        Thu, 18 Jul 2019 06:12:06 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:11:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH 18/18] arm64: dts: hikey: Convert to the hierarchical CPU
 topology layout
Message-ID: <20190718131142.GA28633@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-19-ulf.hansson@linaro.org>
 <20190716144744.GB7250@e107155-lin>
 <CAPDyKFpc26yL6rOnfwawL=eL649NsgTMrF1WrMHZv7AVd=3PCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpc26yL6rOnfwawL=eL649NsgTMrF1WrMHZv7AVd=3PCA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 12:48:14PM +0200, Ulf Hansson wrote:
> On Tue, 16 Jul 2019 at 16:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, May 13, 2019 at 09:23:00PM +0200, Ulf Hansson wrote:
> > > To enable the OS to manage last-man standing activities for a CPU, while an
> > > idle state for a group of CPUs is selected, let's convert the Hikey
> > > platform into using the hierarchical CPU topology layout.
> > >
> > > Cc: Wei Xu <xuwei5@hisilicon.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes:
> > >       - None.
> > >
> > > ---
> > >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 87 ++++++++++++++++++++---
> > >  1 file changed, 76 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > > index 108e2a4227f6..36ff460f428f 100644
> > > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > >       cpus {
> >
> > [...]
> >
> > > @@ -70,9 +128,8 @@
> > >                       };
> > >
> > >                       CLUSTER_SLEEP: cluster-sleep {
> > > -                             compatible = "arm,idle-state";
> > > -                             local-timer-stop;
> > > -                             arm,psci-suspend-param = <0x1010000>;
> > > +                             compatible = "domain-idle-state";
> > > +                             arm,psci-suspend-param = <0x1000000>;
> > >                               entry-latency-us = <1000>;
> > >                               exit-latency-us = <700>;
> > >                               min-residency-us = <2700>;
> >
> > Again this must be original format and as per PSCI spec, your patch
> > changes this cluster sleep state into cluster retention state which I
> > think is not what you intended.
>
> If the hierarchical topology is used, the parameter for cluster states
> are ORed with the deepest idle state for the CPU.
>
> CPU_SLEEP: 0x0010000
> CLUSTER_SLEEP: 0x1000000
>
> After the ORed operation
> CLUSTER_SLEEP: 0x1010000
>
> So, this indeed works as expected.
>

Yes, it works. But we are not XOR-ing so what's wrong in keeping the
StateType as required and be compliant to specification. Why do we need
to make the state param on it's own non-complaint.

What's wrong in retaining CLUSTER_SLEEP as 0x1010000 so that it reflects
the state level and type correctly on it's own ?

> However, are you saying that ORing the state parameters like above has
> other problems? I am reading your other replies...
>

Yes OR-ing may have other problems but the point I made here was more on
PSCI spec compliance for each suspend parameter values independently.

--
Regards,
Sudeep
