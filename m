Return-Path: <linux-pm+bounces-2053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A0829A0B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5C1C20BD3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B4481D0;
	Wed, 10 Jan 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZ7APRVc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AB4B5A4
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704887901; x=1736423901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z5Tuv2WSrteaAUcwm3Ij2GXm9M7DYmRSz7SLSybV2qI=;
  b=iZ7APRVcrf5foPpdkWIVb43PKtY1wVSvi7JlAl4C3HOSPvBedQTiWmjf
   f91Tc2Oao78XoGZC2C8x+E5GGH59TkIsYLkI/t30pMtAN3rHG3LuhMIjC
   7SF16Y+YEvq0SEEnmZGmVeJLfCPwpdN76/3L9pdJoCjvWY6QFVIEL8vD4
   g5tZ13CQF852mC/NiZJ7JPFhN31dDBZBGpJAFF8vhwvtKhDE0R+wrJuBO
   rnkp9NxT38lFjba1T4mkC/UN2TaNz+Qk6xgYt17c/NvH4vKGlpo8CJpZX
   ZZkft7prRS0SBK2HLStpufc9vb2K2Etb3Nsn/f70ZJU8/iG/EJBvxwAH6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="11978407"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11978407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="905507043"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905507043"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:58:15 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 08BFE11F913;
	Wed, 10 Jan 2024 13:58:12 +0200 (EET)
Date: Wed, 10 Jan 2024 11:58:11 +0000
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
Message-ID: <ZZ6GU-Gvm2HmfpMf@kekkonen.localdomain>
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

I'll change the above text to:

 * This function is not primarily intended for use in drivers, most of which are
 * better served by either pm_runtime_get_if_active() or
 * pm_runtime_get_if_in_use() instead.

Perhaps it would better reflect the intention and actual use.

-- 
Regards,

Sakari Ailus

