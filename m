Return-Path: <linux-pm+bounces-30354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2901AFC7AB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855C04A7E44
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5A25C810;
	Tue,  8 Jul 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AILA0yvy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA661401B;
	Tue,  8 Jul 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968882; cv=none; b=Oh/nBsURVLr8BS5/yzAAAj4iBYnNHDk/4Bn0GkWUFYPq69OGg580pv7by//NplQHgvy4rNO+ItEozDAmliV64ZvV10/+0O7cUnijpf7UfK3OsdSZ9hQ+YU0w+Ncw+c9TZMH0tVJuLOtrUok21WEg8qRoJw0Gyr71isFrjw3qVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968882; c=relaxed/simple;
	bh=sQk61ZQ1hu+jGZJr0c68/AYxulChjc+cOl9+CHKTxGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFUGkBsUUXUwbYkmVvVDXMhvkTI2OwD+YemHl0Raj13b6VphkApasLlxE1JjsEl/wAA1wOtOu4Y64OcF+y+/LmCbAXmXWOf+lAQe7SEc3Rk+lcEHu7m4wJ96YEvUxUfIx1Po8HtbCL84x7ZSUVeVoF0ZufR/9hLZoYoxFCoHcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AILA0yvy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751968881; x=1783504881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQk61ZQ1hu+jGZJr0c68/AYxulChjc+cOl9+CHKTxGE=;
  b=AILA0yvyb8FLNjWodekSI9pOYjktcBW1hjHPVtKHuAevzvhikAC/B+15
   0Iw0IFtqmo4pwvZswb6D4B4mxm2X4HeDK3ghrHF34myvrD7cDgj13gcf/
   C6YwLUEjk1PH/L86BncQFpQkfch5I/ySal85uH0iPMHA/kGxOWc5g3sH1
   0tYnIEcOqsf/6nmCa7f6EY7FMYNe/3xIGVnrPkaUYctQkXAI7tmhE+BlD
   LYWxnQi5eCSjRjIcIIwu83qwIxmgHztsO15kPp67WWgUvTcUSt0r5nEhn
   wIptayMZaVMPOCwMXzJVczP5E8W5Vh9FxynYsbynJBKDnu6H23uOQdwUq
   w==;
X-CSE-ConnectionGUID: DAmq3YfkTJ+1/byT8dBrkQ==
X-CSE-MsgGUID: Sw7BejvsR22gMviINx19EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54329588"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54329588"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:01:18 -0700
X-CSE-ConnectionGUID: eg1cFD5tSbKwDbgeOkpS6w==
X-CSE-MsgGUID: 1Vaw5xiATBeYWGutaRxLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159720161"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.230])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:01:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D81B5120898;
	Tue,  8 Jul 2025 13:01:08 +0300 (EEST)
Date: Tue, 8 Jul 2025 10:01:08 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aGzsZLIL9L62dGTU@kekkonen.localdomain>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <00203f87-f90d-4a19-998d-1a6b015ea515@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00203f87-f90d-4a19-998d-1a6b015ea515@sirena.org.uk>

Hi Mark,

On Fri, Jul 04, 2025 at 01:04:51PM +0100, Mark Brown wrote:
> On Fri, Jul 04, 2025 at 10:52:25AM +0300, Sakari Ailus wrote:
> 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > 		pm-runtime-6.17-rc1
> 
> > So before merging these, please pull Rafael's tag. My thinking is indeed
> > these would be best merged via the respective trees as there's some
> > potential for conflicts (there are around 920 call sites modified here).
> 
> Please if you're doing things like this in future could you send
> individual serieses to each subsystem - it just makes everything
> clearer, for those of us with multiple subsystems it makes life easier
> and a series this big causes scaling issues with the tooling (it took
> several minutes for b4 to figure out a base...).

Thanks for the feedback.

I guess at this phase it's really just mechanical and the added benefit of
having a single cover letter is minimal. Right now it looks like only a few
subsystems need v2 of this (drm, media and iio).

-- 
Kind regards,

Sakari Ailus

