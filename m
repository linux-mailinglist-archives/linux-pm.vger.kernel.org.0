Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566BF126885
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSR6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:58:22 -0500
Received: from foss.arm.com ([217.140.110.172]:41548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfLSR6W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 12:58:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FAD81FB;
        Thu, 19 Dec 2019 09:58:21 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7588F3F67D;
        Thu, 19 Dec 2019 09:58:19 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:58:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 14/14] arm64: dts: Convert to the hierarchical CPU
 topology layout for MSM8916
Message-ID: <20191219175757.GA21846@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-15-ulf.hansson@linaro.org>
 <20191219143446.GG20746@bogus>
 <CAPDyKFpkSjq5RzuxCvj8wawU6Q15qq3qiBcrGz=H2X+1Wf3t8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpkSjq5RzuxCvj8wawU6Q15qq3qiBcrGz=H2X+1Wf3t8w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 04:48:47PM +0100, Ulf Hansson wrote:
> On Thu, 19 Dec 2019 at 15:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 04:43:43PM +0100, Ulf Hansson wrote:
> > > To enable the OS to better support PSCI OS initiated CPU suspend mode,
> > > let's convert from the flattened layout to the hierarchical layout.
> > >
> > > In the hierarchical layout, let's create a power domain provider per CPU
> > > and describe the idle states for each CPU inside the power domain provider
> > > node. To group the CPUs into a cluster, let's add another power domain
> > > provider and make it act as the master domain. Note that, the CPU's idle
> > > states remains compatible with "arm,idle-state", while the cluster's idle
> > > state becomes compatible with "domain-idle-state".
> > >
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v4:
> > >       - None.
> > >
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++--
> > >  1 file changed, 53 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > index 8686e101905c..282c36c8fa3b 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > @@ -102,10 +102,11 @@
> > >                       reg = <0x0>;
> > >                       next-level-cache = <&L2_0>;
> > >                       enable-method = "psci";
> > > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> > >                       clocks = <&apcs>;
> > >                       operating-points-v2 = <&cpu_opp_table>;
> > >                       #cooling-cells = <2>;
> > > +                     power-domains = <&CPU_PD0>;
> > > +                     power-domain-names = "psci";
> > >               };
> > >
> > >               CPU1: cpu@1 {
> > > @@ -114,10 +115,11 @@
> > >                       reg = <0x1>;
> > >                       next-level-cache = <&L2_0>;
> > >                       enable-method = "psci";
> > > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> > >                       clocks = <&apcs>;
> > >                       operating-points-v2 = <&cpu_opp_table>;
> > >                       #cooling-cells = <2>;
> > > +                     power-domains = <&CPU_PD1>;
> > > +                     power-domain-names = "psci";
> > >               };
> > >
> > >               CPU2: cpu@2 {
> > > @@ -126,10 +128,11 @@
> > >                       reg = <0x2>;
> > >                       next-level-cache = <&L2_0>;
> > >                       enable-method = "psci";
> > > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> > >                       clocks = <&apcs>;
> > >                       operating-points-v2 = <&cpu_opp_table>;
> > >                       #cooling-cells = <2>;
> > > +                     power-domains = <&CPU_PD2>;
> > > +                     power-domain-names = "psci";
> > >               };
> > >
> > >               CPU3: cpu@3 {
> > > @@ -138,10 +141,11 @@
> > >                       reg = <0x3>;
> > >                       next-level-cache = <&L2_0>;
> > >                       enable-method = "psci";
> > > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> > >                       clocks = <&apcs>;
> > >                       operating-points-v2 = <&cpu_opp_table>;
> > >                       #cooling-cells = <2>;
> > > +                     power-domains = <&CPU_PD3>;
> > > +                     power-domain-names = "psci";
> > >               };
> > >
> > >               L2_0: l2-cache {
> > > @@ -161,12 +165,57 @@
> > >                               min-residency-us = <2000>;
> > >                               local-timer-stop;
> > >                       };
> > > +
> > > +                     CLUSTER_RET: cluster-retention {
> > > +                             compatible = "domain-idle-state";
> > > +                             arm,psci-suspend-param = <0x41000012>;
> >
> > If I followed the thread correctly, we are now just using the param as is
> > without any extra logic like ORing like before. i.e. The domain state
> > parameter overrides the any param below it in the hierarchy.
> >
> > If that's correct, then
>
> That's correct!
>

Thanks for the confirmation.

--
Regards,
Sudeep
