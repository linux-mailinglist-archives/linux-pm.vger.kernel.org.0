Return-Path: <linux-pm+bounces-14123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEE97784A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 07:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEACC286938
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6479154BE9;
	Fri, 13 Sep 2024 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fg1iraEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEE1448ED;
	Fri, 13 Sep 2024 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205148; cv=none; b=YwYkajTkPTPKwRMvxbLlZUNNRBXDRUCiqpFmjQgJhnY66Zh80z2WHC6p9XuBbjyXctS6rgGENQaTwk6GcXWRdURkeqPGCwnv3q8bWtetL2m3dMn9SxMAGKSJbrPtpXfdbw21qHSk69fEDrXcfRK255xekUzTYabOc9CxaeujzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205148; c=relaxed/simple;
	bh=NvnynQVxtCwASRc03BGay6td2pkugPnoBWnUTgamBjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBKiZEcIl8JP69HTOQZBSb9aKTSaiAEh4f8UiEsiZBjvQhV4x3K6Y0+/M4eAZH2qcAh2bfrgYpDaC+i3dGU0QkQmEPiQ/LT87VWAh9ulKcCr2L4lUGoIu0p6iy+rBPFlSg0SlYFsSEO0pemESFZVCtMScOynO6PCCU1kHNMYzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fg1iraEU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726205147; x=1757741147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NvnynQVxtCwASRc03BGay6td2pkugPnoBWnUTgamBjA=;
  b=fg1iraEUf515+35gPAlS6eNw2W0tccSi8E6Iq9hT9/NZUFD0UziKCmM7
   +WliybK7BbldrqMLq63bG4fDWgboPKOQh+3lYsMXJzSJ6mAnY56W7/0as
   0PSt+fBz9jQHJlyiaf5VFYolp7vwq060AeDUjXCshhGQiaJP9qQjwHYgL
   QaXKfBWpHxvkVXpk25ymdmV4uUEiq0N/tm4DEXf4QuNyDUB3EVAOOU0km
   /AWy9l5LRiPU4eOiI3cgewzF+bwJ9uorqT8gDec+MyGBs8ry7t08cIKut
   rS37vL4uyzQmWo2KaI5mC4IxePgzjAIoZF3uRsfXKDsjMkomjUWr3Mvys
   w==;
X-CSE-ConnectionGUID: XkDjZyizTC2MyDqY7X0jWg==
X-CSE-MsgGUID: wWQIsZFSQZ+tY2bRDJT+mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24580279"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24580279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:25:46 -0700
X-CSE-ConnectionGUID: QXN/vjzcRgiGwn+IyLznwQ==
X-CSE-MsgGUID: dNuInLACRWy5HY4B8bohZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105406019"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 12 Sep 2024 22:25:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 72BBC32A; Fri, 13 Sep 2024 08:25:40 +0300 (EEST)
Date: Fri, 13 Sep 2024 08:25:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
Message-ID: <20240913052540.GN275077@black.fi.intel.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de>
 <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
 <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>

Hi,

On Thu, Sep 12, 2024 at 02:12:27PM -0700, Kenneth Crudup wrote:
> I'll run the stuff you need, but now it looks like whatever is breaking
> suspend/resume in Linus' master has been ported down from upstream into
> 6.10.10; I'm now getting the same panic()s as I did with master. I just had
> a failed resume and the crash dump (which happened on its own) looks the
> same as the one I'd posted here.

Is the crash you see something different from the hang? If you can catch
that with the backtrace and the register dump it should help.

Couple of additional steps to try:

- Unplug monitors from the dock and see if that makes it work (assuming
  you have monitors connected).

- Disable PCIe tunneling and see if that makes it work. This results
  that the PCIe devices on the dock are not functional but it can point
  us to the direction. You can do this on regular distro (Ubuntu, Fedora
  etC) like:

    $ boltctl config auth-mode disabled

  Or got to "Settings" -> "Privacy & Security" -> "Thunderbolt" and flip
  off the "Direct Access" switch.

> I may try and find some time to bisect the issue, but it'll take some time.

Sure.

