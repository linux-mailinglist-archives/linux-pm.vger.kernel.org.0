Return-Path: <linux-pm+bounces-2108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9782AB8C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 11:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B421C234E3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1E12E4C;
	Thu, 11 Jan 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUpRrpU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F12E4B
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704967548; x=1736503548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=euA9gOz8EZ0FIz39J4ikHE+5j3tCIoC9//VqenG77ZA=;
  b=DUpRrpU8gNdS+xfFVzHbaD1h7I7UsoGMp9TptkOhCfRmcHurUkcULM8Q
   rpcMmrp7+ogvCJCXvnAD68Pftb7+cbZ9BcLEWvH/ZK+sSBxD9R22Nt2Rp
   42IGUNoY/7SNNunfVvzyzLYppOAMqS6B+JukHJTIIxb73T6y+B0cq/SG5
   qv6Bp0vNatJbA1TLDjqKIcJxn53H5/rNlxxkIT74diZt6i6R1WdR0rtLr
   ySzh+vZYvxxvINQGze9pywpcv36uxIRUXAMtwT5zDeGdISf/djcIVRgPu
   524uVGIQnYR8Fbm3ph3YbAFcD+UXl8DPkCwGJ6JAcqyLAn9jtj0VTk10U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5532361"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5532361"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="782571335"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="782571335"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:05:45 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8085F11F913;
	Thu, 11 Jan 2024 12:05:42 +0200 (EET)
Date: Thu, 11 Jan 2024 10:05:42 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v2 0/2] Small runtime PM API changes
Message-ID: <ZZ-9do6AklaUr2t0@kekkonen.localdomain>
References: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hg=OTRUHi5Z2YW7f425C6Kw2+B5R+YhwkYj6Vo+zkamA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hg=OTRUHi5Z2YW7f425C6Kw2+B5R+YhwkYj6Vo+zkamA@mail.gmail.com>

Hi Rafael,

On Wed, Jan 10, 2024 at 03:28:58PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 10, 2024 at 1:24 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi folks,
> >
> > Here's a small but a different set of patches for making two relatively
> > minor changes to runtime PM API. I restarted version numbering as this is
> > meaningfully different from the previous set.
> >
> > pm_runtime_get_if_active() loses its second argument as it only made sense
> > to have ign_usage_count argument true.
> >
> > The other change is also small but it has an effect on callers:
> > pm_runtime_put_autosuspend() will, in the future, be re-purposed to
> > include a call to pm_runtime_mark_last_busy() as well. Before this,
> > current users of the function are moved to __pm_runtime_put_autosuspend()
> > (added by this patchset) which will continue to have the current
> > behaviour.
> >
> > I haven't included the conversion patches in this set as I only want to do
> > that once this set has been approved and merged. The tree specific patches
> > can be found here, on linux-next master (there are some V4L2 patches
> > there, too, please ignore them for now):
> > <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm>
> >
> > Later on, users calling pm_runtime_mark_last_busy() immediately followed
> > by __pm_runtime_put_autosuspend() will be switched back to
> > pm_runtime_put_autosuspend() once its behaviour change has been done (a
> > patch near top of that branch). I'll provide these once the preceding ones
> > have been merged.
> >
> > Comments are welcome.
> >
> > since v1:
> >
> > - patch 1: Rename __pm_runtime_get_conditional() as
> >   pm_runtime_get_conditional().
> >
> > - patch 1: Reword documentation on driver use of
> >   pm_runtime_get_conditional().
> >
> > Sakari Ailus (2):
> >   pm: runtime: Simplify pm_runtime_get_if_active() usage
> >   pm: runtime: Add pm_runtime_put_autosuspend() replacement
> >
> >  Documentation/power/runtime_pm.rst      | 22 ++++++++-----
> >  drivers/accel/ivpu/ivpu_pm.c            |  2 +-
> >  drivers/base/power/runtime.c            | 10 ++++--
> >  drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
> >  drivers/gpu/drm/xe/xe_pm.c              |  2 +-
> >  drivers/media/i2c/ccs/ccs-core.c        |  2 +-
> >  drivers/media/i2c/ov64a40.c             |  2 +-
> >  drivers/media/i2c/thp7312.c             |  2 +-
> >  drivers/net/ipa/ipa_smp2p.c             |  2 +-
> >  drivers/pci/pci.c                       |  2 +-
> >  include/linux/pm_runtime.h              | 44 ++++++++++++++++++++++---
> >  sound/hda/hdac_device.c                 |  2 +-
> >  12 files changed, 68 insertions(+), 26 deletions(-)
> >
> > --
> 
> All of this LGTM, but it touches multiple pieces that are all in-flux
> now, so can you please rebase it on something more consistent like
> 6.8-rc1 (when it's out) and resend with all of the tags received?

Thanks, I'll send v2 when rc1 is out.

-- 
Regards,

Sakari Ailus

