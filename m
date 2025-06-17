Return-Path: <linux-pm+bounces-28905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0FADCDC0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE13AD5D7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446442E2654;
	Tue, 17 Jun 2025 13:41:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236A2E265C;
	Tue, 17 Jun 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167710; cv=none; b=korjglrSxcJ2+DOGxq6618w9Bgagrt9jIgjf90QXfe6pDwT4VtXPwEPEhpdPRQrxmEHuqrvE09XOEiw5/9Gofg2RLtDETb/YgUrPvUdcO/+/CQoEAzvQdIzWArfpJ/7sv+3tAEaEARAWCTY6H3BY8R0lLeHTQ9awkbVN4KXC0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167710; c=relaxed/simple;
	bh=bhIM8WfhdoU/esl/3sd94kF+RRM1YkYE851Q+t8svZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwnrRy05zTh1HuBIpWieK5mboTVXfMhZ49xdkG5DzD2HWh1moZjVLI77tIvUU8tGFHiGkOkopY1SJfVvuDHHV3O0HkF6cj/W1c4gp9ddldMg5E6Th5WlL0Gzr7Zr27iwElQPraZnhyx/sx2gyVuihR0DOrutz4zDQv+9jDJpsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185CE150C;
	Tue, 17 Jun 2025 06:41:27 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CACFB3F673;
	Tue, 17 Jun 2025 06:41:46 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:41:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable
 notification only if supported by platform
Message-ID: <aFFwmBTPKr_evCnY@pluto>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
 <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>
 <aEmFnJVG8lXTDNmO@pluto>
 <20250612034351.GA7552@nxa18884-linux>
 <aEqsZWSlq9wKv10a@pluto>
 <20250613095059.GA10033@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613095059.GA10033@nxa18884-linux>

On Fri, Jun 13, 2025 at 05:50:59PM +0800, Peng Fan wrote:
> Hi Cristian,
> 
> On Thu, Jun 12, 2025 at 11:31:01AM +0100, Cristian Marussi wrote:
> >On Thu, Jun 12, 2025 at 11:43:52AM +0800, Peng Fan wrote:
> >> On Wed, Jun 11, 2025 at 02:33:37PM +0100, Cristian Marussi wrote:
> >> >On Wed, Jun 11, 2025 at 01:17:11PM +0100, Sudeep Holla wrote:
> >> >> On Wed, Jun 11, 2025 at 03:52:42PM +0800, Peng Fan (OSS) wrote:
> >> >> > PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
> >> >> > commands. If use these commands on platforms that not support the two,
> >> >> > there is error log:
> >> >> >   SCMI Notifications - Failed to ENABLE events for key:13000008 !
> >> >> >   scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
> >> >> > 
> >> >> 
> >> >
> >> >Hi,
> >> >

Hi,

> >> >I had a quick look/refresh to this stuff from years ago...
> >> >
> >> >...wont be so short to explain :P
> >> >
> >> >In general when you register a notifier_block for some SCMI events,
> >> >the assumption was that a driver using proto_X_ops could want to register
> >> >NOT only for proto_X events BUT also for other protos...in such a case you
> >> >are NOT guaranteed that such other proto_Y was initialized when your
> >> >driver probes and tries to register the notifier...indeed it could be
> >> >that such proto_Y could be a module that has still to be loaded !
> >> >
> >> >...in this scenario you can end-up quickly in a hell of probe-dependency
> >> >if you write a driver asking for SCMI events that can or cannot be still
> >> >readily available when the driver probes...
> >> >
> >> >....so the decision was to simply place such notifier registration requests
> >> >on hold on a pending list...whenever the needed missing protocol is
> >> >loaded/inialized the notifier registration is completed...if the proto_Y
> >> >never arrives nothing happens...and your driver caller can probe
> >> >successfully anyway...
> >> >
> >> >This means in such a corner-case the notifier registration is sort of
> >> >asynchonous and eventual errors detected later, when the protocol is
> >> >finally initialized and notifiers finalized, cannot be easily reported
> >> >(BUT I think we could improve on this ... thinking about this...)
> >> >
> >> >...BUT....
> >> >
> >> >....this is NOT our case NOR the most common case...the usual scenario,
> >> >like cpufreq, is that a driver using proto_X_ops tries to register for
> >> >that same proto_X events and in such a case we can detect that such
> >> >domain is unsupported and fail while avoiding to send any message indeed....
> >> >
> >> >....so....:P...while I was going through this rabbit-hole....this issues
> >> >started to feel familiar...O_o....
> >> >
> >> >... indeed I realized that the function that you (Peng) now invoke to
> >> >set the per-domain perf_limit_notify flag was introduced just for these
> >> >reasons to check and avoid such situation for all protocols in the core:
> >> >
> >> >
> >> >commit 8733e86a80f5a7abb7b4b6ca3f417b32c3eb68e3
> >> >Author: Cristian Marussi <cristian.marussi@arm.com>
> >> >Date:   Mon Feb 12 12:32:23 2024 +0000
> >> >
> >> >    firmware: arm_scmi: Check for notification support
> >> >    
> >> >    When registering protocol events, use the optional .is_notify_supported
> >> >    callback provided by the protocol to check if that specific notification
> >> >    type is available for that particular resource on the running system,
> >> >    marking it as unsupported otherwise.
> >> >    
> >> >    Then, when a notification enable request is received, return an error if
> >> >    it was previously marked as unsuppported, so avoiding to send a needless
> >> >    notification enable command and check the returned value for failure.
> >> >    
> >> >    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> >    Link: https://lore.kernel.org/r/20240212123233.1230090-2-cristian.marussi@arm.com
> >> >    Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> >
> >> >
> >> >...so my suspect is that we are ALREADY avoiding to send unneeded
> >> >messages when a domain does NOT support notifications for ALL
> >> >protocols...it is just that we are a bit too noisy...
> >> >
> >> >@Peng do you observe the message being sent instead ? (so maybe the
> >> >above has a bug...) or it is just the message ?
> >> 
> >> Just the message.
> >> 
> >> arm-scmi arm-scmi.0.auto: SCMI Notifications - Notification NOT supported - proto_id:19  evt_id:0  src_id:8
> >> SCMI Notifications - Failed to ENABLE events for key:13000008 !
> >> scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
> >> 
> >> It just make user has a feeling that there must be something wrong, especially
> >> those not know the internals.
> >
> >Yes indeed it is too much noisy...
> >
> >> 
> >> And from the error message, "Failed to ENABLE events for key..", we not
> >> know which protocol, and whether notification supported.
> >> 
> >> I was thinking to propogate the error value, but __scmi_enable_evt
> >> always use -EINVAL if not success.
> >> 
> >
> >I suppose, if you want also to save cycles that you could mark internally a
> >protocol, at init time, as NOT suporting notifs (if you can detect that no domain
> >is supported OR the related notfs commands are NOT available) and then
> >bailing out early with -ENOTOPSUPP when trying to register a new
> >notifier (amd muting all the errs to dbgs....) so that the caller can
> >warn if wanted or not...
> 
> Since you have more expertise in this area, do you have plan to improve here?
> 
> If no, I will give a look and see what I could do, but surely needs your
> suggestion.

... (would be) Happy to help but I dont have so much bandwidth as of now...I will
send you in reply to this an half-baked/UNTESTED patch to express what I
meant....

> 
> >
> >> >
> >> >> I wonder if it makes sense to quiesce the warnings from the core if the
> >> >> platform doesn't support notifications.
> >> 
> >> If not quiesce, we might need to make it clear from the error message,
> >> saying whether X events are supported for Y protocols or not, not just
> >> a "Failed to ENABLE events for key.."
> >> 
> >
> >Yes that was a very early and primitve errors message of mine...my bad :D
> 
> How about this?
> -------------------------------
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index e160ecb22948..1e5a34dc36ab 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1184,6 +1184,11 @@ static inline int __scmi_enable_evt(struct scmi_registered_event *r_evt,
>  							 src_id);
>  				if (!ret)
>  					refcount_set(sid, 1);
> +				else
> +					dev_err(r_evt->proto->ph->dev,
> +						"Enable Notification failed - proto_id:%d  evt_id:%d  src_id:%d, %pe",
> +						r_evt->proto->id, r_evt->evt->id,
> +						src_id, ret);
>  			} else {
>  				refcount_inc(sid);
>  			}
> @@ -1313,12 +1318,7 @@ static void scmi_put_active_handler(struct scmi_notify_instance *ni,
>   */
>  static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
>  {
> -	if (scmi_enable_events(hndl)) {
> -		pr_err("Failed to ENABLE events for key:%X !\n", hndl->key);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> +	return scmi_enable_events(hndl)
>  }

I was thinking more about something to cut way before the notifier
registration process...

I'll send you something I played with last week..

Thanks,
Cristian

