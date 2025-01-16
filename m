Return-Path: <linux-pm+bounces-20575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DAFA13F88
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41EF188DBE0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543AC22BAD2;
	Thu, 16 Jan 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDhq7M5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5326AE4;
	Thu, 16 Jan 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045203; cv=none; b=QRHmAszOEuPGh6p6R1+Yoq0Ro5EH2uh/ab2LPBh5SHYxH3NJcmWbDZNy+MvjdeMnHyM+08Ffu30MCMXTswPzoC2IBvY7LMJhFlClQIAHJKbo1okbXYlaLtaUfDVSNwxBvqF+iSBnyDzDU8Bqn4tutfpFgFccHK8Jv8EVPaHj6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045203; c=relaxed/simple;
	bh=Fb3I/Bp2124e+fW91uWdDOYqME2v3hADQ2JKA4255Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyRM4Avjp/uwnbn3NldSmhq8Q/6VPJQrUZDb/KuUHNXNp92k/FV+F9Rk9t/nAtvUIBWU4vFW1HrfOADJFLWIY1/U7hzWpQ0p6x/4pbeJpWbhfIe1WNBt+XBJcxusxSCbhbdNll5aRVKpI/Assup1ekrw5UwSLs5/3TeHhFKUcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDhq7M5p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737045202; x=1768581202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fb3I/Bp2124e+fW91uWdDOYqME2v3hADQ2JKA4255Bo=;
  b=ZDhq7M5pL27fFqgq7Cy7U1DZZVxFLgfGOy/gU5xEXvp5/3o8jD1XXkG9
   McDm5qbTaomwjuR3BIqXXEm/cT4qaOBSIiGvIHTZ4SfiD+t6cew2mKBW4
   1DhctDRQnUjoN4PKrxd5VwFdFzxvNsqE011uKH7wlQx60Wy3dF6L/k5ku
   ALfFr73beCU+VPnEsa9XcUlybxng+rodI6+3LtifJWlRltSXHMI9b+6Sr
   CeB4QZc9rTnjQZjvbDziA2ywWe34kl/shJsAQ670A7QsYqxHmzuAexZbW
   dDnCcEYfHlQ7+3qseEyQUXEeRzvVjOEo7OMFoJR/66wHlTddntZuz0qjD
   g==;
X-CSE-ConnectionGUID: V6afgDI3QKq6wA9VXMQVRQ==
X-CSE-MsgGUID: FVxL/ItURzCk2621EL8JkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48839123"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48839123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:33:22 -0800
X-CSE-ConnectionGUID: ROM1xVyySFW++7I+cKzCyA==
X-CSE-MsgGUID: 5iuZFqKYSN2zNemETUprMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106427655"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:33:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYSo0-00000001jkN-2FRd;
	Thu, 16 Jan 2025 18:33:16 +0200
Date: Thu, 16 Jan 2025 18:33:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <Z4k0zGk83gtilO0n@smile.fi.intel.com>
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
 <Z4kwK6JCm5RDI4nG@smile.fi.intel.com>
 <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 05:27:59PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 16, 2025 at 5:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 16, 2025 at 4:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The introduced macros are not doing what they intend for, namely
> > > > they won't eliminate the code when CONFIG_PM=n.
> > >
> > > I don't think they have ever been expected to eliminate the code then.
> > > They just don't export the symbols in that case.
> >
> > Then I'm really puzzled with (potential) usefulness of them to begin with.
> > Having a dead code that is not exported is doubtful benefit.
> 
> Arguably, exported dead code is even worse.
> 
> Anyway, it is hard to say what they are good for if there are no users.
> 
> My point really is that you don't need to add anything beyond "this
> stuff has no users" to get it removed and arguing about what the
> unused stuff was intended for is not very useful so to speak.

I see. Shall I send a v3 with the reduced commit message?

-- 
With Best Regards,
Andy Shevchenko



