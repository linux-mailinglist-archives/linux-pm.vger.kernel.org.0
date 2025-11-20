Return-Path: <linux-pm+bounces-38268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D7C7249C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 06:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6A1A229138
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 05:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02722242D76;
	Thu, 20 Nov 2025 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMZDSqCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C163219E8C
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618272; cv=none; b=XT5i077Z4hCTq1Src2ul0MasxRmKnZc/ZNjxqJedp6ozfqEL5e7TCTOcw6smD5ZFSgNDktqmgglQHNHo6zzhXV+kJ9IjQMYXpHDGvEfPzwS3HVqP0jAgOUXV94ESnptVfd6NKl8YUogIzj93NRuOiSDDBUaTtbrJydKe/EWi0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618272; c=relaxed/simple;
	bh=YYOLraI2YNEBjOUmRAfqtOz2ZUAw6VdUu/xPDWO7d2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSQzwZ7TtH6lTCHGiCUbxgGBCj708CGe6mK/jUQ+tMDV0IM5LzZ1XQV0/6wSJNP3+2ssh9hhHzR/cvFC63xpDo3qVKXGwmJCwyN3tVVZ2Vz8r0y7e4ykrXaHj00Xr+223a9yn7NjscGkMtVWR4ArGthv70oy1gUahyHI3pim6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMZDSqCz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763618271; x=1795154271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YYOLraI2YNEBjOUmRAfqtOz2ZUAw6VdUu/xPDWO7d2M=;
  b=ZMZDSqCzul/J6EJCtIUd5ylhxVBYP57DVW5SHwl6/37xi+ZpHAE+TIQT
   8wT1CZp/FvkdfMJY56Lb4b3OpZU9+2uTu12/gB/QeK4nMV/zzrXGL7xox
   2vIMk79Vl3muqwORgtKrIPOOo1L6G+o01ZbnWlI8I69+fYfUfvFkF9HGO
   vPjuQYlq5q9SmQ/69WTdG0or+rOUGfVvuMHypPAkvXW69BV8cEQFtgN76
   NXNK7/WGSPB0Y9K9QGV3obLMdnetP6HKpjIbTRDwecx/8Imgc+4u2eFI0
   +q6hXc+fEzcgmzFWMregV2KhkWJEszLYI+6KSOyDdZSyE+IeZECotsm76
   w==;
X-CSE-ConnectionGUID: SbxCGBkhTAqLt4wTPX0ZIg==
X-CSE-MsgGUID: 8gFoXqXPQOuTyE13dQ/sNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="77141142"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="77141142"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:57:51 -0800
X-CSE-ConnectionGUID: TUzw8U/TSEqQBrn94xTcSg==
X-CSE-MsgGUID: Lix8mDebSu+srOV5K1xEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195750432"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 19 Nov 2025 21:57:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9718096; Thu, 20 Nov 2025 06:57:48 +0100 (CET)
Date: Thu, 20 Nov 2025 06:57:48 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Guntsche <michael.guntsche@it-loops.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: Oops when returning from hibernation with changed thunderbolt
 status
Message-ID: <20251120055748.GM2912318@black.igk.intel.com>
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>

Hi,

On Wed, Nov 19, 2025 at 06:43:16PM +0100, Michael Guntsche wrote:
> Hello,
> 
> I started seeing this issue with kernel v6.15, it worked fine up to 6.14.
> If my notebook went into hibernation with the docking station plugged
> in and I then started it up again with the docking station unplugged
> it would panic. Some times but not always it would also panic if the
> dock was still connected.
> With a lot of support from Mika (thanks again) I tried to debug this
> issue for weeks but was not able to get any meaningful debug output.
> Now finally with 6.18rc6 and freeze_filesystems set to 1 I managed to
> get at least "something" showing up on my screen with a backtrace.
> 
> Hibernating and waking up again works fine with no thunderbolt device connected.
> 
> The device in question is a
> Lenovo ThinkPad X1 Carbon Gen 11 with a 13th Gen Intel® Core™ i7-1355U
> 
> Please tell me if you require more information or want me to try
> something different.

Did you try to disable RTC_DRV_EFI? At least from the backtrace that's
where it crashes.

Also I think I asked you to check with the distro kernel because I remember
that you did some changes to get the crashdump working (please correct me
if I'm wrong) so this could be related to that. For instance it is jumping
to the crash kernel (through kexec) and tries to run EFI services related
to RTC but they are not there anymore due to kexec.

