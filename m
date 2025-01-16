Return-Path: <linux-pm+bounces-20550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEB4A13D64
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED9C3A9131
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A522B8B4;
	Thu, 16 Jan 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8DifIfS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA6143736;
	Thu, 16 Jan 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040480; cv=none; b=Le3sG2VFudUNFnk+Iox/khlD7EczdzmjqjhLrfo8I6BXQkz8AXVlofZFa1W6TfsESA2uIBlw6ronIn8PaUSjtZPGnlYRTy3uqsoFwTLQ/nblLQR5crhwmritHrgyqkZ4kZIRnV0iZ6i26VmKRNMZXhRY6ezTjPPm/uI34Bd2eK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040480; c=relaxed/simple;
	bh=dibBurV1tvL1BcyQaF95lXnEc+13fIUuc02gV37vziQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTNJ2rdT7jRnrihVodT16LXIxc77ive5PBpehClrYLyFtS53E5BBuhYEcDYMlHeeAC5zeYymMD/4ySwlmAf/qnsSF3ibyWGNWGDD/65ultkBq+AF1rY1G95eqnjs0iOgfoGainltYkME2klzRuin+Oof+Oz/mU8qBEss/J7nkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8DifIfS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737040480; x=1768576480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dibBurV1tvL1BcyQaF95lXnEc+13fIUuc02gV37vziQ=;
  b=b8DifIfSDwvdlwE6ngi1zMSYX/sp5kWRorlRoTP3g0t8WBJMMnD0hfXe
   sk98/3Y+6slAn341See3s4t9c6nBztC7zy95vEKzw5ZkFSn1A/8lKxdF1
   IZLQ2mvC3pUn4sX9O/8tPf/dQGflk5iCJ9A9VYZtt9Wgcbp6jI9CYPsQD
   4o4r7Zw0QbuhExVtQeRwdm8FOKyCHFImbWPWpWzxgWi8SnT5tWaze2Z5L
   T9wTBPqsPteKoBcEeDjGaufHORZ9RLVChon090f27fU0VKSzSnIz1lme2
   Xn8kKdfp+VcUlsVWQzaK1hchahn1SRPaNz4C2LPy3M6cttvCMxiLAQsMY
   g==;
X-CSE-ConnectionGUID: hmXzrFSsSEGVh8XdapRRvw==
X-CSE-MsgGUID: EnuphkOnR8ixPP/2S2fiAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="59907999"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="59907999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:14:34 -0800
X-CSE-ConnectionGUID: LoK+kJCtRhuclyS0VKcpVg==
X-CSE-MsgGUID: KHXwi/UpRICHgQwf7IN8mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105671312"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:14:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYRZk-00000001iCU-2ZHd;
	Thu, 16 Jan 2025 17:14:28 +0200
Date: Thu, 16 Jan 2025 17:14:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for
 exporting PM functions
Message-ID: <Z4kiVLrPTDZr3J2K@smile.fi.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
 <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
 <Z1ccjxyxO0NMNbkm@smile.fi.intel.com>
 <4ee01e24-176e-46ac-9ecd-a0976490cbdc@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee01e24-176e-46ac-9ecd-a0976490cbdc@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 07:11:41PM +0200, Adrian Hunter wrote:
> On 9/12/24 18:36, Andy Shevchenko wrote:
> > On Mon, Dec 09, 2024 at 12:38:59PM +0200, Adrian Hunter wrote:
> >> On 1/11/24 12:11, Andy Shevchenko wrote:
> >>> Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
> >>> for exporting PM functions. This helps cleaning up the other
> >>> SDHCI drivers in the future.
> >>
> >> It seems sdhci is the first code in the kernel to use
> >> EXPORT_PM_FN_NS_GPL() but it was not asked for ;-)
> >>
> >> As such, can you fill in a little background.  I am not
> >> sure what it achieves.  Why have CONFIG_PM if not to
> >> #ifdef dependent code behind it?
> > 
> > It makes sure that the code elimination happens at compile time and
> 
> Does it eliminate the code?  Maybe I am missing something,
> but it looks like it is still there:

Hmm... Indeed. My tests show the same. I believe these new macros were never
tested (and we have no users in the kernel).

Richard?

> > at the same time gives developer less uglified (by ifdeffery) code.
> > It means there is less risk to miss anything of that which make become
> > a compile-time warning of unused function, or even issues during linking
> > with modules, etc.
> > 
> > Should I update a commit message with that?

-- 
With Best Regards,
Andy Shevchenko



