Return-Path: <linux-pm+bounces-33405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15134B3B8A5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DD33BBD94
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00027E071;
	Fri, 29 Aug 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccL5yb4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4B1DF256
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462999; cv=none; b=U2t+gTRCrO5WKekafxmBjEvaK5hmFXrJH7wRjdGAeRjN02jtblGVdHtIjj42GEziIv9IbMlLm5zc64HZCG5+YPs0nNgvjPuB7m7vNJTvezBWoiHcMt9TehSgVQJu/+BxbN/YqbCj50Q3M57fB2DBlFpkXk0EjubIB7Sy/aGqn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462999; c=relaxed/simple;
	bh=kZRdCOIGhYqE1GPM0boj9I63hg9pL/iqaaPT3CJ0YfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNa2tJfJotx0Oce2OeWxK5Q45AIO+VFx0HHPiOOY8R+VIhQ0wl7WEbBqD8/cqlNHX7Ws6tXWg2uI+OcDZrF1czt5NJuxlqc8OzYX5hUTNCMzFrfrYbJ+6lXQST5IjpaKhBwO2eISRdUtsmfbHQ857x5e0ykFivR5PlP7IOhmQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccL5yb4s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756462998; x=1787998998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZRdCOIGhYqE1GPM0boj9I63hg9pL/iqaaPT3CJ0YfI=;
  b=ccL5yb4s3A4Qp+FtsUZDOywHXs5r3FldkGRZOj0QTgBO+xxQsebU3cWm
   apgCfoS4sMkBokmbB5FK5hYzUYPa66yvxmvytIDMptici2t/XzpsTI1AU
   BAWalXpG71UYVwR+DLd20zKKV/UjKQttXzqo4D9wViX3LCYUcrGI99aoU
   VrN3jcz4/ocM0ItGYotK7jlWcftxUNOIbaE4cHPvGVwBhhmGwnFyNA9Jn
   WTgavMQzlPzwGNA3HQp0lHD7+NtG/M1Gsf2SvSgZYSaNl/h0CBIRFBtFX
   q1ix6eiS8xY51mibVGpAQ2tPyb4d/o2EETo2EgopkkXygTxtOohUJy1oq
   Q==;
X-CSE-ConnectionGUID: skt6BIMqSiOTYW21E4zufw==
X-CSE-MsgGUID: hwOYJaxkRCSTg1VG96h4Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69454729"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69454729"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:23:17 -0700
X-CSE-ConnectionGUID: iMqzbHVeRROHXtAlPFF+2A==
X-CSE-MsgGUID: txRs6IJgSruXJ3VW75ktuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201293410"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.237])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:23:16 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 67EC911F97F;
	Fri, 29 Aug 2025 13:23:12 +0300 (EEST)
Date: Fri, 29 Aug 2025 13:23:12 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 1/6] pm: runtime: Document return values of suspend
 related API functions
Message-ID: <aLF_kC_OPr1f08WA@kekkonen.localdomain>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <20250616061212.2286741-2-sakari.ailus@linux.intel.com>
 <aJ5pkEJuixTaybV4@google.com>
 <aLD4TwJftEAeCJyf@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLD4TwJftEAeCJyf@google.com>

Hi Brian,

Thank you for the review.

On Thu, Aug 28, 2025 at 05:46:07PM -0700, Brian Norris wrote:
> After reading and rereading ... and then writing unit tests, because I
> can't trust my reading ... I think I can answer my own questions:
> 
> On Thu, Aug 14, 2025 at 03:56:24PM -0700, Brian Norris wrote:
> > Hi,
> > 
> > On Mon, Jun 16, 2025 at 09:12:07AM +0300, Sakari Ailus wrote:
> > > Document return values for device suspend and idle related API functions.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > I appreciate the documentation attempt here. I've often found it a maze
> > trying to weave through the indirection and figure out the actual API
> > contract for some of these.
> > 
> > But I have a few questions below:
> > 
> > > ---
> > >  include/linux/pm_runtime.h | 147 ++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 138 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index e7cb70fcc0af..9dd2e4031a27 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > 
> > 
> > > @@ -464,6 +525,17 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
> > >   *
> > >   * Decrement the runtime PM usage counter of @dev and if it turns out to be
> > >   * equal to 0, queue up a work item for @dev like in pm_request_idle().
> > > + *
> > > + * Return:
> > > + * * 0: Success.
> > > + * * -EINVAL: Runtime PM error.
> > > + * * -EACCES: Runtime PM disabled.
> > > + * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> > 
> > ^^ Is the "usage_count non-zero" true? For RPM_GET_PUT, we drop the
> > refcount, and if it's still nonzero, we simply return 0.
> 
> It *is* possible, but it would only occur with the following:
> 
> (1) we've acquired our usage_count by way of pm_runtime_get_noresume();
>     and
> (2) some other actor is racing with us, acquiring a usage_count between
>     when we decremented usage_count to 0, and when we check again in
>     rpm_idle()
> 
> IMO, as-is, the language is a bit misleading though. But then, the
> behavior is pretty subtle and hard to describe succinctly...

I think it'd be indeed best to improve this. The current description is
indeed at bit misleading: usage_count should be non-zero when this function
is called.

> 
> > > + * * -EBUSY: Runtime PM child_count non-zero.
> > > + * * -EPERM: Device PM QoS resume latency 0.
> > > + * * -EINPROGRESS: Suspend already in progress.
> > > + * * -ENOSYS: CONFIG_PM not enabled.
> > > + * * 1: Device already suspended.
> > 
> > This part isn't very clear to me: can we even hit this case? If the
> > usage count was already 0, we'd hit EINVAL, since this is a PUT
> > operation. If the usage count was non-zero, we can't already be
> > suspended. At a minimum, we'd be RESUMING (e.g., an async resume), no?
> 
> This is sort of possible in the same scenario as above. But it doesn't
> actually return 1; it still returns -EAGAIN.

Yes; rpm_idle() does set retval to -EAGAIN, after it was assigned to 1 (via
rpm_check_suspend_allowed()). I missed this while writing the
documentation.

> 
> Confusingly, pm_runtime_put_autosuspend() behaves differently, because
> it's based on rpm_suspend() instead of rpm_idle().
> 
> I plan to fix this, because I don't see why pm_runtime_put() and
> pm_runtime_put_autosuspend() should differ here.

I agree.

> 
> > >   */
> > >  static inline int pm_runtime_put(struct device *dev)
> > >  {
> > 
> > If these are indeed errors, I expect they're repeated on some of the
> > other related APIs too (like pm_runtime_put_sync(), pm_runtime_idle(),
> > and probably more).
> > 
> > I ask mostly for my own understanding, but I might consider patching the
> > docs if I'm not hallucinating these errors.
> 
> I've sent a patch series to fix some of the inconsistencies in the API
> and to fix the API docs:
> 
> Subject: [PATCH 3/3] PM: runtime: Update kerneldoc return codes
> https://lore.kernel.org/all/20250829003319.2785282-3-briannorris@chromium.org/

Thanks, I'll take a look.

-- 
Kind regards,

Sakari Ailus

