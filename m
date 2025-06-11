Return-Path: <linux-pm+bounces-28490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9BAD5737
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E473A6025
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C532BD5AD;
	Wed, 11 Jun 2025 13:33:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208E2BD593;
	Wed, 11 Jun 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648839; cv=none; b=kPHBYLyXGnhSLxyc1Ruq+FkVuXLwpuaBUBZRH8KpfivfvE++zbur5dli2cffOTSsOMUvQRzxRbcdSsHVCR16A1rxYA47Lu51PU+yUPEtFZQILqHebVUp1Vsvnz2wqpkSvBOMyxa0mEaNOF2Lk4OoTILcbEDLTVXgFlm5jARousg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648839; c=relaxed/simple;
	bh=YEOpV0Qscs7CcXXj9sDb8chGC69grwKgyG3krO9d6vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcKBb+xSaJTFQ+svEtKLxySD+dRzPuCRKwF9n6xy3sF6KAPC3szK2aJb5bvackORnrfQoIljnATDp/Caxew4r+iqxroTBCNNZCK/FEjmWdUdOu/2K7qU6/zSFU5aL1A/v/h3JhGS6S98h5+F80MZl4al2yW9EjAL+rNoD9xI+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E1D15A1;
	Wed, 11 Jun 2025 06:33:37 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54F023F59E;
	Wed, 11 Jun 2025 06:33:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 14:33:37 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable
 notification only if supported by platform
Message-ID: <aEmFnJVG8lXTDNmO@pluto>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
 <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>

On Wed, Jun 11, 2025 at 01:17:11PM +0100, Sudeep Holla wrote:
> On Wed, Jun 11, 2025 at 03:52:42PM +0800, Peng Fan (OSS) wrote:
> > PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
> > commands. If use these commands on platforms that not support the two,
> > there is error log:
> >   SCMI Notifications - Failed to ENABLE events for key:13000008 !
> >   scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
> > 
> 

Hi,

I had a quick look/refresh to this stuff from years ago...

...wont be so short to explain :P

In general when you register a notifier_block for some SCMI events,
the assumption was that a driver using proto_X_ops could want to register
NOT only for proto_X events BUT also for other protos...in such a case you
are NOT guaranteed that such other proto_Y was initialized when your
driver probes and tries to register the notifier...indeed it could be
that such proto_Y could be a module that has still to be loaded !

...in this scenario you can end-up quickly in a hell of probe-dependency
if you write a driver asking for SCMI events that can or cannot be still
readily available when the driver probes...

....so the decision was to simply place such notifier registration requests
on hold on a pending list...whenever the needed missing protocol is
loaded/inialized the notifier registration is completed...if the proto_Y
never arrives nothing happens...and your driver caller can probe
successfully anyway...

This means in such a corner-case the notifier registration is sort of
asynchonous and eventual errors detected later, when the protocol is
finally initialized and notifiers finalized, cannot be easily reported
(BUT I think we could improve on this ... thinking about this...)

...BUT....

....this is NOT our case NOR the most common case...the usual scenario,
like cpufreq, is that a driver using proto_X_ops tries to register for
that same proto_X events and in such a case we can detect that such
domain is unsupported and fail while avoiding to send any message indeed....

....so....:P...while I was going through this rabbit-hole....this issues
started to feel familiar...O_o....

... indeed I realized that the function that you (Peng) now invoke to
set the per-domain perf_limit_notify flag was introduced just for these
reasons to check and avoid such situation for all protocols in the core:


commit 8733e86a80f5a7abb7b4b6ca3f417b32c3eb68e3
Author: Cristian Marussi <cristian.marussi@arm.com>
Date:   Mon Feb 12 12:32:23 2024 +0000

    firmware: arm_scmi: Check for notification support
    
    When registering protocol events, use the optional .is_notify_supported
    callback provided by the protocol to check if that specific notification
    type is available for that particular resource on the running system,
    marking it as unsupported otherwise.
    
    Then, when a notification enable request is received, return an error if
    it was previously marked as unsuppported, so avoiding to send a needless
    notification enable command and check the returned value for failure.
    
    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
    Link: https://lore.kernel.org/r/20240212123233.1230090-2-cristian.marussi@arm.com
    Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>


...so my suspect is that we are ALREADY avoiding to send unneeded
messages when a domain does NOT support notifications for ALL
protocols...it is just that we are a bit too noisy...

@Peng do you observe the message being sent instead ? (so maybe the
above has a bug...) or it is just the message ?

> I wonder if it makes sense to quiesce the warnings from the core if the
> platform doesn't support notifications. I prefer to not add if notification
> supported in all the protocols.
> 

yes

> If the interface can return -EOPNOTSUPP(equivalent to SCMI_ERR_SUPPORT),
> the caller must handle it appropriately(i.e. continue if it can handle
> absence of notification or propagate error).
> 

This is what we do indeed....

> Cristian, Thoughts/opinions ?
>
 
too many :D ....

> > If platforms not support perf notification, saving some cpu cycles
> > by introducing notify_supported ops.
> > 
> 
> Sure, makes sense to improve where ever possible.
> 

Should be solved as above...

Thanks,
Cristian

