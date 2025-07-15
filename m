Return-Path: <linux-pm+bounces-30863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D571B05B7E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E384B7B6854
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402D2701B8;
	Tue, 15 Jul 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLAYK/pU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F62E11D3;
	Tue, 15 Jul 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585545; cv=none; b=EBBBtoLmB6D7950amf9WL3hPFJbhcJm9q7gdltZL5Xoa23hY5M/wSVXVHn0ib6gSdtfhZhpy78TVDKNbss4JAkCHRMFLbldHK1Iq2v/b/S0m6qAxs0zWnPB80Q+9mG5HhhnHOFZ5xtDGS//gHVMlOHp2C6e6UwvWva/QJtWYrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585545; c=relaxed/simple;
	bh=Q7CJmLoluI6Xm9e7tAsyLnHK9TYVSx9FLwZ/M7LJR04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVTiYnobj3kdg+vJTDZjIpJAm7GwbdYI+li1XHawAz4MwGhUmNBTYAoliCQ7ZMIfTuOG6fOeWGngw2J3eNUSWUZNb/ob3/gv3SiH0G0lcOfH9yse0fo8duNI0bmVJhW4WiMaOI4REhhuSGHx23mvCKzzlGfuRDmhvoPZv3l6SF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLAYK/pU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752585544; x=1784121544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q7CJmLoluI6Xm9e7tAsyLnHK9TYVSx9FLwZ/M7LJR04=;
  b=gLAYK/pUMtAyfdwsj89GKw4VNzb1hrRj7GFFxebNc8yeXhwVA0ujFmFK
   Qeq661iA0KPA47cwvu1bEXK4cPImyw3UCxYnLfR9B5lqhdcfZlBbe9BEN
   B0o+WHsa8MdDk20ip0uDDuiV4I3Djf6UCeLZm8TPF51alB0lrKTvqVtfe
   LUKx83j+8XEzMP/XyvlDi3GgBKhgwFZcseKRiadP2BdXaMjUBF6yI6UGM
   fadeVTDLa2aTtT6apiT2we77kubPdfk+l1gNNRIFb1/qrLnUptBpsFI8f
   8DGw0/bS4oLI6JEl6j71h6gq55Bd1xNeMcPGY6ghPPUI0ZCO43nRGUWSu
   g==;
X-CSE-ConnectionGUID: eLH1tClfQxme3ld0LM1GDA==
X-CSE-MsgGUID: Lb+2gG8TQzqoVSmWSIir/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65872056"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="65872056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 06:19:02 -0700
X-CSE-ConnectionGUID: IS/xJoJqR1u+4fCBsGY1DA==
X-CSE-MsgGUID: eps8aJzXQnmEXJseNvDhjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157316002"
Received: from ettammin-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 06:19:00 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D070911F8A6;
	Tue, 15 Jul 2025 16:18:57 +0300 (EEST)
Date: Tue, 15 Jul 2025 13:18:57 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in
 pm_runtime_get_if_in_use()
Message-ID: <aHZVQaY6E9R_YWKs@kekkonen.localdomain>
References: <12700973.O9o76ZdvQC@rjwysocki.net>
 <aHYCRvz0ohgi2xUk@kekkonen.localdomain>
 <CAJZ5v0jEELFB6vb1dtkPgu_3_eew7Y1Jebevfmhye+ZPLk0Jtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jEELFB6vb1dtkPgu_3_eew7Y1Jebevfmhye+ZPLk0Jtg@mail.gmail.com>

Hi Rafael,

On Tue, Jul 15, 2025 at 02:46:21PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Tue, Jul 15, 2025 at 9:28 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for the patch.
> >
> > On Wed, Jul 09, 2025 at 12:41:45PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > For all practical purposes, there is no difference between the situation
> > > in which a given device is not ignoring children and its active child
> > > count is nonzero and the situation in which its runtime PM usage counter
> > > is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
> > > device's usage counter and return 1 in the latter case.
> > >
> > > For consistency, make it do so in the former case either by adjusting
> > > pm_runtime_get_conditional() and update the related kerneldoc comments
> > > accordingly.
> > >
> > > Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> >
> > I guess this should be:
> >
> > Fixes: c111566bea7c ("PM: runtime: Add pm_runtime_get_if_active()")
> 
> Technically yes, but that would require specific backport changes for
> older "stable" series.

The lines in pm_runtime_get_conditional() were added by c111566bea7cc, it
looks like the actual fix would be backportable without changes whereas the
documentation would require them. So splitting the patch should allow
backporting the fix only while leaving the documentation as-is. I don't
really have an opinion either way. It's perhaps unlikely the issue causes
actual problems but you never know...

> 
> > Should this also be cc'd to stable?
> 
> Possibly.
> 
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Thank you!
> 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > >
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1203,10 +1203,12 @@
> > >   *
> > >   * Return -EINVAL if runtime PM is disabled for @dev.
> > >   *
> > > - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
> > > - * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
> > > - * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
> > > - * without changing the usage counter.
> > > + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
> > > + * is set, or (2) @dev is not ignoring children and its active child count is
> > > + * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
> > > + * the usage counter of @dev and return 1.
> > > + *
> > > + * Otherwise, return 0 without changing the usage counter.
> > >   *
> > >   * If @ign_usage_count is %true, this function can be used to prevent suspending
> > >   * the device when its runtime PM status is %RPM_ACTIVE.
> > > @@ -1228,7 +1230,8 @@
> > >               retval = -EINVAL;
> > >       } else if (dev->power.runtime_status != RPM_ACTIVE) {
> > >               retval = 0;
> > > -     } else if (ign_usage_count) {
> > > +     } else if (ign_usage_count || (!dev->power.ignore_children &&
> > > +                atomic_read(&dev->power.child_count) > 0)) {
> > >               retval = 1;
> > >               atomic_inc(&dev->power.usage_count);
> > >       } else {
> > > @@ -1261,10 +1264,16 @@
> > >   * @dev: Target device.
> > >   *
> > >   * Increment the runtime PM usage counter of @dev if its runtime PM status is
> > > - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
> > > - * it returns 1. If the device is in a different state or its usage_count is 0,
> > > - * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
> > > - * in which case also the usage_count will remain unmodified.
> > > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
> > > + * ignoring children and its active child count is nonzero.  1 is returned in
> > > + * this case.
> > > + *
> > > + * If @dev is in a different state or it is not in use (that is, its usage
> > > + * counter is 0, or it is ignoring children, or its active child count is 0),
> > > + * 0 is returned.
> > > + *
> > > + * -EINVAL is returned if runtime PM is disabled for the device, in which case
> > > + * also the usage counter of @dev is not updated.
> > >   */
> > >  int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > >
> > >
> >

-- 
Kind regards,

Sakari Ailus

