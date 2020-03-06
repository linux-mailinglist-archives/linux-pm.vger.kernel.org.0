Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C358E17BC4B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 13:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgCFMGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 07:06:50 -0500
Received: from foss.arm.com ([217.140.110.172]:60366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFMGu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 07:06:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF38D31B;
        Fri,  6 Mar 2020 04:06:49 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8CC3F6C4;
        Fri,  6 Mar 2020 04:06:48 -0800 (PST)
Date:   Fri, 6 Mar 2020 12:06:46 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200306120646.GB44221@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org>
 <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus>
 <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus>
 <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 11:47:40AM +0100, Benjamin Gaignard wrote:
> Le ven. 6 mars 2020 à 11:04, Sudeep Holla <sudeep.holla@arm.com> a écrit :
> >
> > On Fri, Mar 06, 2020 at 10:28:10AM +0100, Ulf Hansson wrote:
> > > On Thu, 5 Mar 2020 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> >
> > [...]
> >
> > > > OK. The only state that cluster can enter when CPUs are in WFI are
> > > > cluster WFI and most hardware can handle it automatically. I don't see
> > > > the need to do any extra work for that.
> > >
> > > This isn't about cluster WFI, but about deeper cluster states, such as
> > > a cluster-clock-gated-state and a cluster-power-off-state. It's an ST
> > > platform, which Benjamin is working on.
> > >
> >
> > Then definitely something is completely wrong. You can't enter deeper
> > cluster states(clock-gated and power-off to be specific) with CPU in
> > just WFI state. So, if the attempt here is to enter those states, I
> > disagree with the change.
> >
> > Benjamin, please share the complete hierarchical topology for your platform.
>
> The platform is stm32mp157 SoC which embedded two Cortex A7 in one cluster.

Hang on a minute, is this the same platform where you wanted high
resolution timer and were hacking moving dirty tricks around[1]. Now I think
you have landed here.

> I would like to be able to put the system in a state where clocks of CPUs and
> hardware blocks are gated. In this state local timer are off.

Sure, please create a deeper CPU state than WFI and enter so that the CPU
state is saved and restored correctly. What is the problem doing that ?

> The platform should be allowed to go in this state when the devices
> within the power domain are pm_runtime_suspend and the CPUs in WFI.

Nope, we don't save and restore state when we enter/exit WFI. And hence
we can't allow deeper idle states in the hierarchy. No more discussion
on that.

> In DT I have one system power domain where the hardware blocks (i2,
> uart; spi, etc..) are attached + a power per CPU.

You really need a CPU idle state here.

--
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/a42dd20677cddd8d09ea91a369a4e10b@www.loen.fr/
