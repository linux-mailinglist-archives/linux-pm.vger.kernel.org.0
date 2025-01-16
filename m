Return-Path: <linux-pm+bounces-20553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04215A13DB2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767F73AC604
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF421DE8A7;
	Thu, 16 Jan 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu7iOzMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4027082B;
	Thu, 16 Jan 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041551; cv=none; b=C1mE/vvAD7WNwFj5/cewOQZT6UYSOW4zWYq12a7A+3MgkSo2Tyqpo7pqfwCC8iCsamfuC7LFyeeH044dyLN0j5HtskxqTXXGSbPGBiwGfP/dNBqAjCIlqCASuRqF7S0q6be+DuRHUD4xcdK3H8pmqK7W/cKBWDTGM9QZ3i93eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041551; c=relaxed/simple;
	bh=w0jGwDIXwAK/MBTMe6aC2J/jDLkK9OgUeSC17rZNwwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4dL3mGp5v1ujaBX+w3PwWbOxmEKF+mFhM2pOQy3v8FH25oXTzoRAeJGYQYdR7qgJ+UUXW6Z8BiJfAMhOFcjPQ4NrRF0np/BxLpv7MGauBx0H/DbUq0ZUSvI6CKbbeSK7+Fp6Me97En+4JPlDMGhUjC80gZYwZaWJQbMh8lBba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu7iOzMo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041549; x=1768577549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0jGwDIXwAK/MBTMe6aC2J/jDLkK9OgUeSC17rZNwwo=;
  b=fu7iOzMomo23+f4F53jbjmUrgnGHifobE6bDXMOQ2pOm6LFSqVLj5sEm
   JGcxG0kvBn+C6cCbzPGQ8mfZNsc7g/ZpuK4egrqWPgv42/952wJnR7nVx
   x000suNbexzZNX1WXKHfyUbNen6L0UyqaQ1MDmgyTua9IZZMYm01EKk5C
   Hs9nAzLv/IltinnhuhhoJfnA80AZpUI/Opz2OY6j2JcPfwvopTt9YGxQ6
   lOiNB7IwRp+09+D2pKwJAUFAHMEeGE1QT/t7k/ELmWio1d1Mc4NlUmf39
   HvAMQfMLHQml7zsRE7aNpY5w/y3od4V2eQdl0tIiip946HrV9JhxNRIzz
   Q==;
X-CSE-ConnectionGUID: rL0GaY9nQ4izQJO/Wiaw3w==
X-CSE-MsgGUID: 71kve1HfSkWApLALh1LUXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41369605"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="41369605"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:32:27 -0800
X-CSE-ConnectionGUID: QIJmZyF6Rz6ZQZRNi9BAng==
X-CSE-MsgGUID: nkL9lpx0RoOyUJhxmvcqfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105674965"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:32:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYRr5-00000001iZD-1VRJ;
	Thu, 16 Jan 2025 17:32:23 +0200
Date: Thu, 16 Jan 2025 17:32:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <Z4kmh6YHkNUGFnMK@smile.fi.intel.com>
References: <20250116152152.147048-1-andriy.shevchenko@linux.intel.com>
 <2025011605-splashed-giddy-0289@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011605-splashed-giddy-0289@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 04:24:16PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 16, 2025 at 05:21:51PM +0200, Andy Shevchenko wrote:

...

> >  #ifdef CONFIG_PM
> >  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
> > -#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
> > -#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, "ns")
> >  #else
> >  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_DISCARD_PM_OPS(name, license, ns)
> > -#define EXPORT_PM_FN_GPL(name)
> > -#define EXPORT_PM_FN_NS_GPL(name, ns)
> 
> Why not start using them instead?

I tried and they didn't produce what we want (code elimination for
the CONFIG_PM=n).

-- 
With Best Regards,
Andy Shevchenko



