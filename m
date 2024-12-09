Return-Path: <linux-pm+bounces-18832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EB9E9BE1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963551605BD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49957145B18;
	Mon,  9 Dec 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dma8MD65"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B6135A63;
	Mon,  9 Dec 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762198; cv=none; b=rHG/1H4rxJn+30HRCD80FuhSX4qZnub45yt6zVSy7QKIssVhLd/9LOLkLEzX/lDn+HuXfC6AoPgEbyYTgnojXAZ+8ocEeZJ/NTAEmxNEdzLRBeS7JQNdjtqSj04u5WNMzVJKVuD2mkFteMjJNOsBYumjqYlKJvl9K9tuoziRKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762198; c=relaxed/simple;
	bh=xKG2ukKcw8N+OsYYylErisFU2NDm1V5YUx6EUt8IvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3m3eEK9eZ/8nMCuZVT3Piju+lCNl6HfugFEo3c3ZGUJDRbD98fDs7cG1CwbEbb9+7RW45XtkfnrNMGxFwlwec5qIgt1mZ9LDWvNzeWAJJvvYcK123uXuopqsMtzA6+MHhCqXk/fmcipd2xt3lRZJy0oZzvEveEiKLuosyarDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dma8MD65; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733762197; x=1765298197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xKG2ukKcw8N+OsYYylErisFU2NDm1V5YUx6EUt8IvM4=;
  b=dma8MD65cmquVnetplnk0A7/R3gzi4UE1P4JtkeMWdVNrU4XxqI092or
   oKz0Iy/K1pt/FMZLJfgguj0KCik2Eh5vWlQLcBKMJWfiAiHHaQ3NOkLSY
   nSNYgvGEWGVdIbKvXYeOZcX6Vmnextdt+oDj+eij6EFZ7RzBHzaq+GLe4
   84g63bmIAom1HNaNkiWD+t1yBTtcfkpeGZ2hI1D3l1H+2FuapNkklargX
   3Sq2zfCvoEVENL1MtW9S64RLVMprL4pOsfG5jo+z9Kf+tu/sQo/4YZjkK
   fa5AosFiDiE69V8QN4C51zXQU5+U9OJjZNkvceJ9TA6/nmclzOCHgPENt
   w==;
X-CSE-ConnectionGUID: PeLIDOeOSG24vxnTMLa6Kw==
X-CSE-MsgGUID: UKU/zHG4SASfSRBI93E8Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44539229"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="44539229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:36:36 -0800
X-CSE-ConnectionGUID: EVv6U4K0TXiFX4O3l7lF9Q==
X-CSE-MsgGUID: itg+lQy+Rlmxo7+u/mn48A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94988716"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:36:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKgkJ-00000005nVc-2eRb;
	Mon, 09 Dec 2024 18:36:31 +0200
Date: Mon, 9 Dec 2024 18:36:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for
 exporting PM functions
Message-ID: <Z1ccjxyxO0NMNbkm@smile.fi.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
 <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 12:38:59PM +0200, Adrian Hunter wrote:
> On 1/11/24 12:11, Andy Shevchenko wrote:
> > Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
> > for exporting PM functions. This helps cleaning up the other
> > SDHCI drivers in the future.
> 
> It seems sdhci is the first code in the kernel to use
> EXPORT_PM_FN_NS_GPL() but it was not asked for ;-)
> 
> As such, can you fill in a little background.  I am not
> sure what it achieves.  Why have CONFIG_PM if not to
> #ifdef dependent code behind it?

It makes sure that the code elimination happens at compile time and
at the same time gives developer less uglified (by ifdeffery) code.
It means there is less risk to miss anything of that which make become
a compile-time warning of unused function, or even issues during linking
with modules, etc.

Should I update a commit message with that?

-- 
With Best Regards,
Andy Shevchenko



