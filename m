Return-Path: <linux-pm+bounces-23741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC39A58DDB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8F07A203A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CCC223311;
	Mon, 10 Mar 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehVJkKGp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0E2153D6;
	Mon, 10 Mar 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594646; cv=none; b=Gu4AgXLpqS676aStFJi1+CtB/xVAMYJ6uG8mYajUKDQePLxCeU+Fn18SZrET/Y/PENVTPiNRjwX6fM09Y8VMJHj8GiGfm8OJPlLuaT1ESsJaZ+fBiHpOYIxkNSRWllnJEVND1MMYgpMA6wiD/QuOcazS49lvbmLbzilx8lS4ZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594646; c=relaxed/simple;
	bh=uawa4JN2MXUgGhBTnOMJGYIztDfknKCASvvEPmNYWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgwF5BkjyAY0CyxBIsPpbOdOVfyi26PV3fItBNIA1mgwpCzO6CushBh/rhS62C0EhZPa6bs8uFu/44OAR9nNKri4kFs9Fab7mJtzHlNMUMVOiiPrriZqM8B5LNL0zBbh5T9KBYcnzSKopjilpZQBeMlwktzUwvw7jC6x2Ib5rd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehVJkKGp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741594645; x=1773130645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uawa4JN2MXUgGhBTnOMJGYIztDfknKCASvvEPmNYWpo=;
  b=ehVJkKGp+nrH91F8VEJtdhK2ltkRwRwcBv4Rk53FQt1OX/WwsVIpC2Er
   XOD7DUVLDpAd0Ci1gBsYw3tBwnj6nI47itYXwTcsC3MlCty1TMh6f7fPy
   SghkYy7F+RVYh8+2lvFpLVOb/xAboDcO7G9OjYWBcAoo4lkQr/dAtZb7X
   PhOvCvgtAIHjWsMediet+nW7BpVO0WxjRRWAqmoKL0b6zgqY6BmGKF0aA
   JfVPS235CGCArvLw3xHoJHDE5r41ctyTgJHl9vO2cfGEVnMlnIQ7g3Zpj
   cvCTfZYJlIdJhH5BctkyvkdfgI4uxG5jsx0Vg4A5XRgrI31kra1DcJTc9
   g==;
X-CSE-ConnectionGUID: O2ujGIseSNGQOIEnzG6rKg==
X-CSE-MsgGUID: VC7GRyNJTOScWs7TP59C/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42451119"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42451119"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:17:24 -0700
X-CSE-ConnectionGUID: qKaGnuGGTxG/yni8i6DnRg==
X-CSE-MsgGUID: qMrffTLPRlytlCS9ZfCoQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124916130"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:17:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYK2-00000001BlI-3H1A;
	Mon, 10 Mar 2025 10:17:14 +0200
Date: Mon, 10 Mar 2025 10:17:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <Z86gCjzuC5UFZBIL@smile.fi.intel.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
 <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
 <Z8sqJhbqEBla_Ch7@smile.fi.intel.com>
 <20250308003425.7b89bfb6@booty>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308003425.7b89bfb6@booty>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 12:34:25AM +0100, Luca Ceresoli wrote:
> On Fri, 7 Mar 2025 19:17:26 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 12:19:08PM +0100, Luca Ceresoli wrote:
> > > %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> > > add %pC{,n,r} format specifiers for clocks") introducing them does not
> > > clarify any intended difference. It can be assumed %pC is a default for
> > > %pCn as some other specifiers do, but not all are consistent with this
> > > policy. Moreover there is now no other suffix other than 'n', which makes a
> > > default not really useful.
> > > 
> > > All users in the kernel were using %pC except for one which has been
> > > converted. So now remove %pCn and all the unnecessary extra code and
> > > documentation.  
> > 
> > You seem forgot to update translation(s) of the documentation.
> 
> I'm afraid I don't speak Chinese. :-)

At bare minimum we can drop the same line in the list.
Also in such a case we may ask a Chinese speaking person to review / correct /
suggest the changes. I would not leave a leftover as it will be forgotten so
easily and documentation becomes not in sync.

> For this specific change I think I could come up with an approximation
> of it, but the both the docs and git log suggest this is not expected.


-- 
With Best Regards,
Andy Shevchenko



