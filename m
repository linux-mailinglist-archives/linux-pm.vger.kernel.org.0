Return-Path: <linux-pm+bounces-16436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0C9AFC89
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4951C2125C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB61D26E0;
	Fri, 25 Oct 2024 08:28:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B941D1E79;
	Fri, 25 Oct 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844932; cv=none; b=UsdSLAEKV0vHP0EMOzsy9jVnRniFB8wtB/oS2GhP4M0H1c54T1TYt+8YzGJpGt9T0FZwNHMKR3jtfEkfqSr0rzBt0B1+0CyWYW2tzn58JSIAjaMaXHvQYTrOWIlppEiFCXv8jmFEfNE0rsA+yMJ+kn4opS0ZHRdpUw32Nl6AHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844932; c=relaxed/simple;
	bh=Qh0w84bisMxn6v4DNS3rR1p5e79heOUwAl9dMkiZdTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/k65oAd/x29k6XEK6fnYNo45jKTtzWOpFyLavFl/wIWC96hkjG2kpV6FcP2FroNQvSiwnvXDJKQ0fLB3FzA3PsrXx2iZAoc0uF9aRkk/Lzt3koAM/VG22zip+hOX89F7r1rypt2SqCVUnkBUX+70/YZYUzgWnh6FbJv7NFf98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CD8A339;
	Fri, 25 Oct 2024 01:29:19 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549333F73B;
	Fri, 25 Oct 2024 01:28:47 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:28:38 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan@kernel.org>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ZxtWtqsP5HdJYp5w@pluto>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
 <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd>
 <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>

On Fri, Oct 25, 2024 at 12:15:59PM +0530, Sibi Sankar wrote:
> 
> 
> On 10/25/24 11:44, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 11:38:36AM +0530, Sibi Sankar wrote:
> > > 

Hi,

> > > 
> > > On 10/23/24 21:56, Johan Hovold wrote:
> > > > On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> > > > > On 10/10/24 20:32, Johan Hovold wrote:
> > > > > > On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> > > > > > > The series addresses the kernel warnings reported by Johan at [1] and are
> > > > > > > are required to X1E cpufreq device tree changes [2] to land.
> > > > > > > 
> > > > > > > [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > > > > > > [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> > > > > > > 
> > > > > > > The following warnings remain unadressed:
> > > > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > > > 
> > > > > > Are there any plans for how to address these?
> > > > 
> > > > > Sorry missed replying to this. The error implies that duplicate
> > > > > opps are reported by the SCP firmware and appear once during probe.
> > > > 
> > > > I only see it at boot, but it shows up four times here with the CRD:
> > > 
> > > https://lore.kernel.org/lkml/d54f6851-d479-a136-f747-4c0180904a5e@quicinc.com/
> > > 
> > > As explained ^^, we see duplicates for max sustainable performance twice
> > > for each domain.
> > 
> > If existing products were shipped with the firmware that lists single
> > freq twice, please filter the frequencies like qcom-cpufreq-hw does.
> 
> That was a qualcomm specific driver and hence we could do such
> kind of filtering. This however is the generic scmi perf protocol
> and it's not something we should ever consider introducing :/
> 

+1

In the case of the other warnings, those were similarly related to
duplicates, but the warns themselves were genereated by the OPP
subsystem when trying to register a duplicate...it was indeed a bug
at the SCMI layer to try registering a well-known duplicate with
the OPP subsytem, so it was fixed in the SCMI stack...avoiding to
propagate it to the OPP layer...but the duplicate error condition
indeed still exist (since dependent on what the fw spits out) and they
are trapped at the SCMI level and those noisy warning are just meant
to trap this kind of firmware anomalies...

...IOW who would have ever spotted this thing and considered to fix the
firmware in future releases without the warnings :P ?

> > 
> > > 
> > > > 
> > > > [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > 
> > > > > This particular error can be fixed only by a firmware update and you
> > > > > should be able to test it out soon on the CRD first.
> > > > 
> > > > Can you explain why this can only be fixed by a firmware update? Why
> > > > can't we suppress these warnings as well, like we did for the other
> > > > warnings related to the duplicate entries?
> > > > 
> > > > IIUC the firmware is not really broken, but rather describes a feature
> > > > that Linux does not (yet) support, right?
> > > 
> > > We keep saying it's a buggy firmware because the SCP firmware reports
> > > identical perf and power levels for the additional two opps and the
> > > kernel has no way of treating it otherwise and we shouldn't suppress
> > > them. Out of the two duplicate opps reported one is a artifact from how
> > > Qualcomm usually show a transition to boost frequencies. The second opp
> > > which you say is a feature should be treated as a boost opp i.e. one
> > > core can run at max at a lower power when other cores are at idle but
> > > we can start marking them as such once they start advertising their
> > > correct power requirements. So I maintain that this is the best we
> > > can do and need a firmware update for us to address anything more.
> > 
> > Will existing shipping products get these firmware updates?
> 
> They are sure to trickle out but I guess it's upto the oem
> to decide if they do want to pick these up like some of the
> other firmware updates being tested only on CRD. Not sure why
> warnings duplicates should block cpufreq from landing for x1e
> but if that's what the community wants I can drop reposting
> this series!

Not sure indeed which is the problem with such warnings since they are
just doing their job...in general we tend not to disrupt operation even
when the firmware is buggy (if possible) BUT we definitely try to be
noisy about that to have firmware fixed (...not that fw guys seems so
scared usually about warnings though :P)

Anyway, I'm totally with Sibi here unless there is an impact at the
functional level...Sudeep may think otherwise of course ...

Thanks
Cristian


