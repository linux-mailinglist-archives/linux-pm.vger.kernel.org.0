Return-Path: <linux-pm+bounces-2028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF0828D22
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16797B2149A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A663D0B4;
	Tue,  9 Jan 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gt4OxAtX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758F3D0AF
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704827345; x=1736363345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E168HkP2p695iyl5I0x0BTE9RdVwI3PyGghMfy7pdpw=;
  b=Gt4OxAtXPQWJgnKnPtt2eMQ3KR53UV+KBr7ZnIn6ofM7DAQQgKbMAETq
   kDM16ZMA5CryV54KVWYcm99v1blVxzAQGlvoEweMPd89Szmhdr6YOI0Xl
   rm1+ylHky8Gy30dH6j0KL8GxsosPg8bU2m4ZrNpYAjV1Ah+fqxKhDH4XF
   n1ct+WKZYE2oj4VV0ElVR5BMs+Mi4vWEAnIcOfOsmDvXk2gJMb22+5WOJ
   4LZZMGG9Jjxx1+7t/IRgtI2h78MsLRLQRZkyuIVpkelZc+m0bGCm8GT0t
   DE5+l+La5iQak+OSqCLy7ZDmZdFxqJ+bkvtbzFPZAHX0+MVWEP/VQfBTv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5654062"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5654062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 11:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1113181285"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="1113181285"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 11:08:58 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 456DA11F8DE;
	Tue,  9 Jan 2024 21:08:56 +0200 (EET)
Date: Tue, 9 Jan 2024 19:08:56 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <ZZ2ZyEvVNgJ_Nimy@kekkonen.localdomain>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133657.111258-1-sakari.ailus@linux.intel.com>
 <ZZ2D3Tv2ZW9NuQoz@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2D3Tv2ZW9NuQoz@intel.com>

Hi Rodrigo,

Thanks for the review.

On Tue, Jan 09, 2024 at 12:35:25PM -0500, Rodrigo Vivi wrote:
> On Tue, Jan 09, 2024 at 03:36:57PM +0200, Sakari Ailus wrote:
> > There are two ways to opportunistically increment a device's runtime PM
> > usage count, calling either pm_runtime_get_if_active() or
> > pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> > ignore the usage count or not, and the latter simply calls the former with
> > ign_usage_count set to false. The other users that want to ignore the
> > usage_count will have to explitly set that argument to true which is a bit
> > cumbersome.
> > 
> > To make this function more practical to use, remove the ign_usage_count
> > argument from the function. The main implementation is renamed as
> > __pm_runtime_get_conditional().
> 
> Great idea! I recently found a bug in Xe caused by some confusion
> with the ign_usage_count var.
> 
> > + * This function is not intended to be called by drivers, use
> > + * pm_runtime_get_if_active() or pm_runtime_get_if_in_use() instead.
> >   */
> 
> Well, it is not intended, but we already have an usage for that.
> So, shouldn't we avoid the '__' and just put as recommendation?
> Like we have around the get_sync telling that the preferred way is
> the resume_and_get for a cleaner code?

I'll do that in v2, it's indeed not an issue to call this directly in a
driver as you have ign_usage_count value available. Which is why the
comment says "intended". Feel free to propose a better wording.

pm_runtime_resume_and_get() isn't a universal replacement for
pm_runtime_get_sync() as pm_runtime_resume_and_get() won't return 1 if the
device was already active---this was considered a possible source of bugs
AFAIR. So there will be drivers using pm_runtime_get_sync().

> 
> > -EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
> > +EXPORT_SYMBOL_GPL(__pm_runtime_get_conditional);
> 
> Also the '__' in the exported and documented one doesn't look so nice.
> Well, I know that this would be the case even without any driver using
> because of the static inline anyway.
> 
> >  
> >  /**
> >   * __pm_runtime_set_status - Set runtime PM status of a device.
> > diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
> > index 860b51b56a92..51cbca330bd5 100644
> > --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> > @@ -246,7 +246,7 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
> >  		 * function, since the power state is undefined. This applies
> >  		 * atm to the late/early system suspend/resume handlers.
> >  		 */
> > -		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
> > +		if (__pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
> 
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Thanks!

-- 
Regards,

Sakari Ailus

