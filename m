Return-Path: <linux-pm+bounces-15445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F69983B9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F8E1F24EB4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D41BFE12;
	Thu, 10 Oct 2024 10:34:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB541A00ED
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556462; cv=none; b=DB4IbM/CvghbkO5ZF19nFtPcWqRAn1FMCK9xp+YGRYlFWpYnCcNGJh24LCBJyWHcU4Qshqk2N2Hqru4gyCrqjYpgK4UccHLujhdndD0EmQc/g8eAlUE5RgkWkmC20pVgcpjIfp49qoB0qGFDrHPA7uhIFEdq2e/YHe/p4HurP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556462; c=relaxed/simple;
	bh=tcR4BtQbOhzU1yDgkyK5JW3FCGcy1QOcmoG0LhmE1jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7Q3b9ccQ54Oq2E8zaHYf0Hs8jmGB/PqpUDysfYL5snS/lvc6QOqoTEYMmGJ8WmOHffb5F+VEAzm8JKnp91pqDM842sF2jLo+nxXULpc3v+EIOVev+Saapej5eaziUZ+Eyr8sz+lJIApgzvRPudaY12jAt4v9IqdXYl0NajVINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEDFF497;
	Thu, 10 Oct 2024 03:34:49 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D4C3F58B;
	Thu, 10 Oct 2024 03:34:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:34:15 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: arm64 s2idle vs. workqueues
Message-ID: <ZwetpzhazHfMqsax@bogus>
References: <7ho73shkrw.fsf@baylibre.com>
 <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>

On Thu, Oct 10, 2024 at 12:23:25PM +0200, Rafael J. Wysocki wrote:
> Hi Kevin,
> 
> On Thu, Oct 10, 2024 at 2:19 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Hello,
> >
> > Looking for some pointers/tips on debugging s2idle, and in particular
> > why it is not staying in an idle state as long as expected.
> >
> > I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
> > AM62x), which doesn't (yet) have any DT defined idle-states, so is just
> > doing a WFI when idle.
> >
> > I'm doing an 8-second s2idle with RTC wakeup by using:
> >
> >   rtcwake -m freeze -s8
> >
> > and what I see is that 3 of the CPUs stay in their idle state for the
> > full 8 seconds, but one of them keeps waking due to the A53
> > arm_arch_timer firing, and processing misc. workqueue related activity
> > (example work listed below[1].)
> >
> > I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
> > the freezer part of suspend to stop/freeze them.  However, I am a bit
> > surprised to see this non-frozen workqueue activity happening often
> > enough (few times per second) to prevent all 4 CPUs from being idle for
> > long periods at the same time, thus preventing a deeper cluster-idle
> > state.
> >
> > Is there something else I'm missing that is needed to keep these
> > workqueues quiet for longer?  I had assumed that most of this workqueue
> > work would be deferred, and shouldn't need to wakeup a CPU just to run.
> >
> > In case it's helpful I have published a trace.dat from trace-cmd which
> > captures power, sched, irq, timer and workqueue events.  With
> > kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
> > are all nicely idle for 8 sec while CPU2 is waking due to the timer and
> > workqueue activity.
> >
> > Any pointers to how to improve this situation, or what else needs to be
> > tweaked here would be greatly appreciated,
> 
> It looks like tick_freeze() is not called, which only happens in
> enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
> there are any idle states with an .enter_s2idle() callback.
> 
> So does the cpuidle driver for this platform provide .enter_s2idle()
> callbacks for any of its idle states?

IIUC, his setup/platform doesn't support any deeper idle states than the
shallowest WFI on all arm systems. I was about to ask if he has already
tried to build a cpuidle driver with just that WFI state or is he relying
on default arch_cpu_idle() which is one possible reason to take different
path and hence not executing the expected s2idle path.

-- 
Regards,
Sudeep

