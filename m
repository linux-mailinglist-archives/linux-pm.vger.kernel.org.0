Return-Path: <linux-pm+bounces-20629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB645A150AD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC616788A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B91FFC4A;
	Fri, 17 Jan 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/7aOaye"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95561FE473;
	Fri, 17 Jan 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121209; cv=none; b=BgACYeTbvJsUkAP7T7XyfeS4qqvfxXZ2QLjW1RbfU/c+YNn+3Cv7b8OXu+1m9lDUJGSDakisbY4SR7p/K46mwrOJN4Itcx0QIpzLoljZQBrXB5oJzzZlu9fARVm/0JnT/kguubPU/yyVXbz1Q1PoWJSpZacExALGaYNOL2f3a7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121209; c=relaxed/simple;
	bh=HIsKDibyLgQ2phlkbtq16wJKaEV//ZLIlKDmJgbcek8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU3zNVTmV8gFQNtmrBabWyzdei8qhuR3w8GlAVYituvInQlj/5/zQv88CWXuLxGICvYtJBK6ls8pFusgklj9bBBgMuZAp+muJdlksbi4Cr6dwdUl1et99MZxaNSeamyDTlLWkc9ZrwUBWyKKux/6UnSrmoXCQQyvvk1Lx2hdOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/7aOaye; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737121208; x=1768657208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HIsKDibyLgQ2phlkbtq16wJKaEV//ZLIlKDmJgbcek8=;
  b=h/7aOayeII+a6gN4UkyR/ikBPvdxHnmHbc9VucCXpPp0NVw5lzNGkVhN
   eSAxxhoT4QCAIoj6PmXUXx4fBmoOyFjWUgTG2nfpBGymazSY2y7ADZ/d0
   p1Jb7bX2TdX+UEuLaqxafkweNTkg0C/IxLw64i0v13x70iRvhCj+QadAg
   E62UswuH3jUzb43IZQ0N47OnrlqkxrTV31+qTi+NltGaV49ehAeUriTWu
   WaeXo0FqmzJRZWUesNpa6/QyRfIfWwaqpilJMcc+llqsKmzY9s8pMoiLW
   kcddDf3OSbln5hmk2KMaAKbLD6zEulhA/GYeOe+VmW4mmGgusleowiFkn
   A==;
X-CSE-ConnectionGUID: fuCR/VPxSkGOtFMPjAk43w==
X-CSE-MsgGUID: +oiqxJVYQzum3KchFJgfFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41224579"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41224579"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:40:08 -0800
X-CSE-ConnectionGUID: z38mHNyERt+0c4k3Fm/Fkw==
X-CSE-MsgGUID: +G8dgRr8RZitEhK/3yojXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105597303"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:40:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYmZu-000000024kI-0obT;
	Fri, 17 Jan 2025 15:40:02 +0200
Date: Fri, 17 Jan 2025 15:40:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <Z4pdsR-Lyk5c-S1W@smile.fi.intel.com>
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
 <9f0c1792-a569-41c0-9e90-e52717185359@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f0c1792-a569-41c0-9e90-e52717185359@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 04:55:05PM +0000, Richard Fitzgerald wrote:
> On 16/01/2025 4:09 pm, Rafael J. Wysocki wrote:
> > On Thu, Jan 16, 2025 at 4:44 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > The introduced macros are not doing what they intend for, namely
> > > they won't eliminate the code when CONFIG_PM=n.
> > 
> > I don't think they have ever been expected to eliminate the code then.
> > They just don't export the symbols in that case.
> > 
> > > Also there were no users of them for all this time.
> 
> I had code changes to use them but they got lost at the bottom of a long
> backlog of other commits and have never been upstreamed. Removing these
> macros is fine with me.

I see, thanks for chiming in in both email threads!

> (apologies if you get this msg twice, there was a problem with email)

-- 
With Best Regards,
Andy Shevchenko



