Return-Path: <linux-pm+bounces-17050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54C9BDF2D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FBDB237CF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E2198E84;
	Wed,  6 Nov 2024 07:12:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63B18FDD0;
	Wed,  6 Nov 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877161; cv=none; b=KA46u6+yab1OMxKdug8BM1lonefg14SP+bBbgozKC53DLmNC3Sg6xB5AX+jBVjQ1rGr7uD35O4Z0ENn2tuO2cU4mHT/oF23un8QnhqU7U9p+80DJeVgPqkTC4J/QqlbiglYr0X2abcyfHfZYF5hkMG0ebg7wGoHFy/utVAmD7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877161; c=relaxed/simple;
	bh=SO8YTU1NVvXwpEfqSfCpy54QLboK8BuKAV6p/cHhFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p11+3wm7iGtyvxbwkjKt/tKNl/MX0IvxSHOMSq/h6MlnhCZqxMrYZudoATzBLDhQ3b1XTIIA2M9GQ0TnveukwRgGWQC7fjgui287Ikzz575J35rll7UbfwnE0DpYgWd/iHycgGOx+MlMov4G30B1kMJrLc2+RYnJ9UkyHG1EVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 245BF1063;
	Tue,  5 Nov 2024 23:13:07 -0800 (PST)
Received: from bogus (unknown [10.57.64.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744D13F66E;
	Tue,  5 Nov 2024 23:12:29 -0800 (PST)
Date: Wed, 6 Nov 2024 07:12:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, johan@kernel.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V5 0/6] firmware: arm_scmi: Misc Fixes
Message-ID: <20241106071215.jhnzcn4vkdfr3peg@bogus>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <CAPDyKFoY8CnxF7JXzkT9_WXyM-TJhW4kmTw=H8NEzch32N1_7Q@mail.gmail.com>
 <ZyJeuVIbWkohymW5@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJeuVIbWkohymW5@pluto>

On Wed, Oct 30, 2024 at 04:28:41PM +0000, Cristian Marussi wrote:
> On Wed, Oct 30, 2024 at 05:19:39PM +0100, Ulf Hansson wrote:
> > On Wed, 30 Oct 2024 at 13:55, Sibi Sankar <quic_sibis@quicinc.com> wrote:
> > >
> > > The series addresses the kernel warnings reported by Johan at [1] and are
> > > are required to X1E cpufreq device tree changes to land.
> > >
> > > [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > >
> > > Duplicate levels:
> > > arm-scmi arm-scmi.0.auto: Level 2976000 Power 218062 Latency 30us Ifreq 2976000 Index 10
> > > arm-scmi arm-scmi.0.auto: Level 3206400 Power 264356 Latency 30us Ifreq 3206400 Index 11
> > > arm-scmi arm-scmi.0.auto: Level 3417600 Power 314966 Latency 30us Ifreq 3417600 Index 12
> > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > arm-scmi arm-scmi.0.auto: Level 4012800 Power 528848 Latency 30us Ifreq 4012800 Index 15
> > >
> > > ^^ exist because SCP reports duplicate values for the highest sustainable
> > > freq for perf domains 1 and 2. These are the only freqs that appear as
> > > duplicates and will be fixed with a firmware update. FWIW the warnings
> > > that we are addressing in this series will also get fixed by a firmware
> > > update but they still have to land for devices already out in the wild.
> > >
> > > V4:
> > > * Rework debugfs node creation patch [Ulf/Dmitry]
> > > * Reduce report level to dev_info and tag it with FW_BUG [Johan/Dmitry]
> > > * Add cc stable and err logs to patch 1 commit message [Johan]
> > 
> > Patch4 and patch5 applied for fixes to my pmdomain tree - and by
> > adding a stable tag to them, thanks!
> > 
> > Potentially I could help to take the other patches too, to keep things
> > together, but in that case I need confirmation that's okay to do so.
> 
> SCMI patches in these series are all reviewed (all but one even by Sudeep)
> so it is really up to Sudeep preference...(who is travelling now so it could
> take a bit to reply)

I have added my reviewed by now.

> ...moreover I am not sure if the SCMI patches in this
> series could end up with wome trivial conflicts against the scmi patches
> already queued at
> 
> 	sudeep/for-next/scmi/updates
> 
> (at least the perf related ones 2 and 3 probably not)
>

I did a quick check and no conflicts were observed. Let me know if you need
a branch with first 3 patches, but I need to do that today or after Sunday
as I will away from my computer for few more days again from tomorrow.

Let me know ASAP.

-- 
Regards,
Sudeep

