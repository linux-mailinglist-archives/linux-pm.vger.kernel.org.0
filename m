Return-Path: <linux-pm+bounces-28775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D2ADA7C6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0653F189049A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08A1C6FFD;
	Mon, 16 Jun 2025 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCueyeQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12D1ACEDC
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052561; cv=none; b=jiV9njb0fqQu1W6KXyhW3rgTh3IGmC0Jy2k+I6QPqnIoRjzhR/F94lVSqkqCnFw6prQPDlwEmiepOCVuEp0PlWIW/3gDKA6o/QVzTk/FYJWXra3rOtNoTwG5dZxjUwBEI68b+AChqkY1Me/hBwzP0FrF+n4n5THv/7M1Hm+2UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052561; c=relaxed/simple;
	bh=rR7XYMSNtYqP5hy162/VhAkmHUzalhZpJuaEFOP/IIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXyFY/JlCNuO3+ONt5B8ZJ2GFINsCtwsi6n3zJY5HP3Z8yrbI2h27atFFRKEpsegTu6ekeH1T4gaFQMrQvuLKa67HDgo3epGDWrV+f1MpGptkQPLSANyjc5IIIw5vnVXLXHoyuPgKoecjMva8Cb1K6eqwvD+IOLZa3am/+bVEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCueyeQv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750052560; x=1781588560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rR7XYMSNtYqP5hy162/VhAkmHUzalhZpJuaEFOP/IIo=;
  b=lCueyeQv8dFaLo7V7cPlzqVGXR29S4w020sG10xojmrk5SevpHWR6sLl
   HuIrWFb0m6EfouK6aO8213Mzkmz6ujo87AKcp6hkQmhmNqKEEsdaR2rs3
   uDhbWIQx12dFnNqFXpJnNHHRNQG/OJagY8PDNaRpjcWOR0QDp6bwFbjJM
   1YpjFVRWpnOYwynYIXpEyqVtZ+fl4BzTz5keqLveifH7X/QIkdFpO+Vfc
   kIltIbMjQ+1V/aN7Lf3HG/31eF21topMg06PfmwwQyo0QG2d6naVSw6Ma
   LcxGj+NHDIE3SLPLhLaP52+TEnQX7kn9lRGzYmhK9b3WIfgLqKzuw3RkD
   w==;
X-CSE-ConnectionGUID: l+cowZMdRziSDjdurXyt7Q==
X-CSE-MsgGUID: KzOQaGPaScaijgg8HahXZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52276072"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52276072"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:42:39 -0700
X-CSE-ConnectionGUID: /3uCgQZ5Rnu9jeAAvtKusQ==
X-CSE-MsgGUID: +nB+2ZAZSQej46axbQuscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148209219"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:42:38 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D7E951211D5;
	Mon, 16 Jun 2025 08:42:35 +0300 (EEST)
Date: Mon, 16 Jun 2025 05:42:35 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 0/7] Update last busy timestamp in Runtime PM autosuspend
 callbacks
Message-ID: <aE-uy1XrYTY5E8lg@kekkonen.localdomain>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0iSNwPLLjvoHdgZRUG6_=EEZUrs6tvrfKAymRD8PH9-4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iSNwPLLjvoHdgZRUG6_=EEZUrs6tvrfKAymRD8PH9-4g@mail.gmail.com>

On Tue, Apr 29, 2025 at 01:10:59PM +0200, Rafael J. Wysocki wrote:
> > Sakari Ailus (7):
> >   Documentation: pm: runtime: Fix a reference to
> >     pm_runtime_autosuspend()
> >   pm: runtime: Document return values of suspend related API functions
> >   pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
> >   pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
> >   pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
> >   pm: runtime: Mark last busy stamp in pm_request_autosuspend()
> >   Documentation: PM: *_autosuspend() functions update last busy time
> >
> >  Documentation/power/runtime_pm.rst |  50 ++++----
> >  include/linux/pm_runtime.h         | 187 +++++++++++++++++++++++++----
> >  2 files changed, 186 insertions(+), 51 deletions(-)
> >
> > --
> 
> Am I correctly expecting a v2 of this series to be posted?

And replying to the correct thread this time. I'll send v2 soon.

-- 
Sakari Ailus

