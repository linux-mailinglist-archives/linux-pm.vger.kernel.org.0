Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FA36B3DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDZNMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 09:12:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhDZNMs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Apr 2021 09:12:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A63F331B;
        Mon, 26 Apr 2021 06:12:04 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41D853F70D;
        Mon, 26 Apr 2021 06:12:02 -0700 (PDT)
Date:   Mon, 26 Apr 2021 15:11:50 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, sudeep.holla@arm.com,
        souvik.chakravarty@arm.com, thierry.reding@gmail.com,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        jonathanh@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
Message-ID: <20210426131150.GA36549@e123083-lin>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
 <064341f7-dce3-5ad4-e69b-9568115035c1@arm.com>
 <486856be-1e66-fd77-e306-949b91bcdb1d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486856be-1e66-fd77-e306-949b91bcdb1d@nvidia.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Apr 23, 2021 at 03:24:51PM -0700, Sowjanya Komatineni wrote:
> On 4/23/21 1:16 PM, Lukasz Luba wrote:
> > Hi Sowjanya,
> > 
> > On 4/22/21 9:30 PM, Sowjanya Komatineni wrote:
> > > Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs
> > > which is
> > > in charge of deciding on state transition based on target state,
> > > state idle
> > > time, and some other Tegra CPU core cluster states information.
> > > 
> > > Current PSCI specification don't have function defined for passing
> > > runtime
> > > state idle time predicted by governor (based on next events and
> > > state target
> > > residency) to ARM trusted firmware.
> > 
> > Do you have some numbers from experiments showing that these idle
> > governor prediction values, which are passed from kernel to MCE
> > firmware, are making a good 'guess'?
> > How much precision (1us? 1ms?) in the values do you need there?
> 
> it could also be in few ms depending on when next cpu event/activity might
> happen which is not transparent to MCE firmware.
> 
> > 
> > IIRC (probably Rafael's presentations) predicting in the kernel
> > something like CPU idle time residency is not a trivial thing.
> > 
> > Another idea (depending on DT structure and PSCI bits):
> > Could this be solved differently, but just having a knowledge that if
> > the governor requested some C-state, this means governor 'predicted'
> > an idle residency to be greater that min_residency attached to this
> > C-state?
> > Then, when that request shows up in your FW, you know that it must be at
> > least min_residency because of this C-state id.
> C6 is the only deepest state for Tegra194 Carmel CPU that we support in
> addition to C1 (WFI) idle state.
> 
> MCE firmware gets state crossover thresholds for C1 to C6 transition from
> TF-A and uses it along with state idle time to decide on C6 state entry
> based on its background work.
> 
> Assuming for now if we use min_residency as state idle time which is static
> value from DT, then it enters into deepest state C6 always as we use
> min_residency value we use is always higher than state crossover threshold.
> 
> But MCE firmware is not aware of when next cpu event can happen to predict
> if next event can take longer than state min_residency time.
> 
> Using min residency in such case is very conservative where MCE firmware
> exits C6 state early where we may not have better power saving.
> 
> But with MCE firmware being aware of when next event can happen it can use
> that to stay in C6 state without early exit for better power savings.
> 
> > It would depend on number of available states, max_residency, scale
> > that you would choose while assigning values from [0, max_residency]
> > to each state.
> > IIRC there can be many state IDs for idle, so it would depend on
> > number of bits encoding this state, and your needs. Example of
> > linear scale:
> > 4-bits encoding idle state and max predicted residency 10msec,
> > that means 10000us / 16 states = 625us/state.
> > The max_residency might be split differently, using different than
> > linear function, to have some rage more precised.
> > 
> > Open question is if these idle states must be all represented
> > in DT, or there is a way of describing a 'set of idle states'
> > automatically.
> We only support C6 state through DT as C6 is the only deepest state for
> Tegra194 carmel CPU. WFI idle state is completely handled by kernel and does
> not require MCE sequences for entry/exit.

I think Lukasz's point is that you can encode the predicted idle time by
having multiple idle_state entries with different min_residency mapping
to the same actual idle-state. So you would several variants of C6 with
different min_residencies and if the OS picks one with longer
min_residency firmware would have a better estimate of the predicted
idle residency.

I'm not convinced it is the right way to work around passing this
information on to firmware. I would rather see an example of how well
this works (best with numbers) and have a proper solution.

Morten
