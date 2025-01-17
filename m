Return-Path: <linux-pm+bounces-20628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9053A150AB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192253A8A74
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE781FFC55;
	Fri, 17 Jan 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwNWlAv/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AE1FE473;
	Fri, 17 Jan 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121167; cv=none; b=Zi4gADgRG7CGM0GQmp97vm3TIjTf+Q02q/E7rNKT6NRxp5elOSYBefUj2/pEoqeSSZypvuitUNzc50GWTed7U5l4IbIBQYpMRo5/2czQn5drpnohBxwTY6QwtHM5QfZ60Q8z8uRYubu0xz70ZNzUjUCcSwD0tlDAkCjHwZJ9ZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121167; c=relaxed/simple;
	bh=8TtNyaUvJe63BN8jD44nnwszRs4vdA5Fh9Sm52ohqOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keo11oCpEcMCG3iS+y2Ep6gJDOMmOCmrl3V+wSJsa5do5L5iVZFScOTHvSWozKLHtyDYKFpdCV3uZ0U3NPM74OaMBr5fTGWMo5sxwKki0/0RUw1MkEWRMkuyCSbAxSc40Fdq1wabmw9c4jQE41cPxoRcT/7y9juDi9cMf/qzTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwNWlAv/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737121165; x=1768657165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8TtNyaUvJe63BN8jD44nnwszRs4vdA5Fh9Sm52ohqOQ=;
  b=KwNWlAv/zsJdtWMEQ+xS1AerXHOEzajZ7nqTHlaE2ttK5xKIvRNXDi4F
   UNKHrFJN9TI4JjUHDshCv/8jKM+Tj6vecEDTwXf/GgSVb7uOr6T5HLgnp
   glixQSYKMdfQKqdn0BOc/bSKJ88vXarI2ueP7SqXSUA3RUyCNNZ4MMPue
   3lXLBRuZGzcd7IOeqUyurbYFdktfRkJaaG+8Q4L8aD/CInZvELkkPcPyg
   5EZhfd4FmH1qq+S3taPXXA39ep2zVm/o+Y6Rfy8n0cwA843Fds5CrLfU8
   lMSVolAqqSnu7IIoNEsW6HRSKQJfMuTf3SLs1wPLW7aqQ5Ww/el+Z7FyM
   Q==;
X-CSE-ConnectionGUID: A84AW6l2TN+DDhc/obiamw==
X-CSE-MsgGUID: yTYWuNmYRxe0arWybVMo6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="25147640"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="25147640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:39:24 -0800
X-CSE-ConnectionGUID: yUgrCyjcRK2qxZJRHSEAPw==
X-CSE-MsgGUID: UEr9en18S5KnoxrQ+kCv5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105648231"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 05:39:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYmZD-000000024jl-2TR8;
	Fri, 17 Jan 2025 15:39:19 +0200
Date: Fri, 17 Jan 2025 15:39:19 +0200
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
Message-ID: <Z4pdh4LNSOzkatoi@smile.fi.intel.com>
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
 <Z4kwK6JCm5RDI4nG@smile.fi.intel.com>
 <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
 <Z4k0zGk83gtilO0n@smile.fi.intel.com>
 <CAJZ5v0iJPHPE9pJx2VTz5OwinwyLPD=H3SQJGViyt4_9uAgwNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iJPHPE9pJx2VTz5OwinwyLPD=H3SQJGViyt4_9uAgwNA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 08:18:19PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 16, 2025 at 5:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 16, 2025 at 05:27:59PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 16, 2025 at 5:13 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Jan 16, 2025 at 4:44 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > The introduced macros are not doing what they intend for, namely
> > > > > > they won't eliminate the code when CONFIG_PM=n.
> > > > >
> > > > > I don't think they have ever been expected to eliminate the code then.
> > > > > They just don't export the symbols in that case.
> > > >
> > > > Then I'm really puzzled with (potential) usefulness of them to begin with.
> > > > Having a dead code that is not exported is doubtful benefit.
> > >
> > > Arguably, exported dead code is even worse.
> > >
> > > Anyway, it is hard to say what they are good for if there are no users.
> > >
> > > My point really is that you don't need to add anything beyond "this
> > > stuff has no users" to get it removed and arguing about what the
> > > unused stuff was intended for is not very useful so to speak.
> >
> > I see. Shall I send a v3 with the reduced commit message?
> 
> It's there in my queue and I can take care of the changelog, so no need.

Ah, thanks!

-- 
With Best Regards,
Andy Shevchenko



