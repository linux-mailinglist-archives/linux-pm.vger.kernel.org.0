Return-Path: <linux-pm+bounces-16445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D29B001D
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D881C20C44
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8451E2602;
	Fri, 25 Oct 2024 10:29:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DE18B498;
	Fri, 25 Oct 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852153; cv=none; b=oipG0SFhH5sarBM+4F2HpuflvdiEmokAlau/xdeJOL0vnI40pFVKjJG7B5bUmxG3STTv5ppRHG6iXasApiJXvfs2l+yHsKdWklBFuFiwaxQ8ycToABYb+paPGKrjTOWYaE6/4qLuosyrXE+gMvKdEiMmN/6cvxw+vnVFuBdwuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852153; c=relaxed/simple;
	bh=kt4wYMkfsNTPdfoKwRwRU0gRMNf/RpLIukUSQs+5exU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYAqjjEui3j5Pwhqp8+K+Yr5toE3rjS2JUJOyCDiKqKPXB2q6rOOZCrZEBCAq/8JTKU/3POKpiGXjr3uCMMVShseoPlbpkuNWi4AUl9N9Wo2dsnwFBy6/Q2bbsyEzyyaysos+gg/ALat+iNVzqpFffQdCR0VyZeMqcih+uaAl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4B4339;
	Fri, 25 Oct 2024 03:29:39 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DF593F73B;
	Fri, 25 Oct 2024 03:29:07 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:29:05 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>,
	sudeep.holla@arm.com, cristian.marussi@arm.com,
	ulf.hansson@linaro.org, jassisinghbrar@gmail.com,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <Zxty8VaMPrU3fJAN@pluto>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
 <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd>
 <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
 <CAA8EJppx1OmYnfSsMDebRRTbNb3dfAE_MM55T1SpLccP=s_K1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppx1OmYnfSsMDebRRTbNb3dfAE_MM55T1SpLccP=s_K1A@mail.gmail.com>

On Fri, Oct 25, 2024 at 01:11:37PM +0300, Dmitry Baryshkov wrote:
> On Fri, 25 Oct 2024 at 09:46, Sibi Sankar <quic_sibis@quicinc.com> wrote:
> >
> >
> >
> > On 10/25/24 11:44, Dmitry Baryshkov wrote:
> > > On Fri, Oct 25, 2024 at 11:38:36AM +0530, Sibi Sankar wrote:
> > >>
> > >>
> > >> On 10/23/24 21:56, Johan Hovold wrote:
> > >>> On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> > >>>> On 10/10/24 20:32, Johan Hovold wrote:
> > >>>>> On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> > >>>>>> The series addresses the kernel warnings reported by Johan at [1] and are
> > >>>>>> are required to X1E cpufreq device tree changes [2] to land.
> > >>>>>>
> > >>>>>> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > >>>>>> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> > >>>>>>
> > >>>>>> The following warnings remain unadressed:
> > >>>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>>>>
> > >>>>> Are there any plans for how to address these?
> > >>>
> > >>>> Sorry missed replying to this. The error implies that duplicate
> > >>>> opps are reported by the SCP firmware and appear once during probe.
> > >>>
> > >>> I only see it at boot, but it shows up four times here with the CRD:
> > >>
> > >> https://lore.kernel.org/lkml/d54f6851-d479-a136-f747-4c0180904a5e@quicinc.com/
> > >>
> > >> As explained ^^, we see duplicates for max sustainable performance twice
> > >> for each domain.
> > >
> > > If existing products were shipped with the firmware that lists single
> > > freq twice, please filter the frequencies like qcom-cpufreq-hw does.
> >
> > That was a qualcomm specific driver and hence we could do such
> > kind of filtering. This however is the generic scmi perf protocol
> > and it's not something we should ever consider introducing :/
> 
> This depends on the maintainer's discretion.
> 
> >
> > >
> > >>
> > >>>
> > >>> [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>> [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>> [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>> [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > >>>
> > >>>> This particular error can be fixed only by a firmware update and you
> > >>>> should be able to test it out soon on the CRD first.
> > >>>
> > >>> Can you explain why this can only be fixed by a firmware update? Why
> > >>> can't we suppress these warnings as well, like we did for the other
> > >>> warnings related to the duplicate entries?
> > >>>
> > >>> IIUC the firmware is not really broken, but rather describes a feature
> > >>> that Linux does not (yet) support, right?
> > >>
> > >> We keep saying it's a buggy firmware because the SCP firmware reports
> > >> identical perf and power levels for the additional two opps and the
> > >> kernel has no way of treating it otherwise and we shouldn't suppress
> > >> them. Out of the two duplicate opps reported one is a artifact from how
> > >> Qualcomm usually show a transition to boost frequencies. The second opp
> > >> which you say is a feature should be treated as a boost opp i.e. one
> > >> core can run at max at a lower power when other cores are at idle but
> > >> we can start marking them as such once they start advertising their
> > >> correct power requirements. So I maintain that this is the best we
> > >> can do and need a firmware update for us to address anything more.
> > >
> > > Will existing shipping products get these firmware updates?
> >
> > They are sure to trickle out but I guess it's upto the oem
> > to decide if they do want to pick these up like some of the
> > other firmware updates being tested only on CRD. Not sure why
> > warnings duplicates should block cpufreq from landing for x1e
> > but if that's what the community wants I can drop reposting
> > this series!
> 
> No, the community definitely wants to have cpufreq for X1E.
> But at the same time some reviewers prefer to have a warning-free boot
> if those warnings can't be really fixed. I don't have such a strict
> position, but I'd prefer to see those messages at dev_info or dev_dbg
> level.

I think dev_info could be an option from the SCMI perspective (as per my
other mail), the important thing in these regards is to NOT go
completely silent against fw anomalies...to avoid the the risk of being
silently ignored .... I'll see what Sudeep thinks about...

Thanks,
Cristian

