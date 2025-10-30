Return-Path: <linux-pm+bounces-37083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9356C1F057
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 09:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5F119C2BA7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970B312804;
	Thu, 30 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRs853jH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB58273D66;
	Thu, 30 Oct 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813480; cv=none; b=a/y8+ypJXYWUh8YbSljFz2R+zhf4aLb/oknJlbQW4n6Hk8YmF9I766myXDsfSt0DYwtPHA1MoApXIgdRKcw2+xz8MKJHup/6cQIKoct2kM35HfdG1TViPPNX/atoB9+WN2UkAkv7NVygYSHVWwCqQcE9PKg8h/uJBpuA5W25/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813480; c=relaxed/simple;
	bh=usge6ZZpEe6DkRtxDka/dN5QIQQfEtW67JBcAFZp/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUdC4ud6cEBuadcf3rQSo4oX+EwjvEczWSAwnNCt0pIIDxnFjFDz3papsy13cqkPdZOVnGxtaFyJQRNh26VBTjf5yKj1ksAK1BHWR0vJ+mAvk7dO9UZka/3T49xteh11M4lrhB8cdrvCw6YOmSEJAOkSKM31puAr2BJNa+jUSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRs853jH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761813479; x=1793349479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usge6ZZpEe6DkRtxDka/dN5QIQQfEtW67JBcAFZp/zw=;
  b=lRs853jHYL6pvPZsHKgArNWBo7jyf4DZr6opjZaL+E7FXFTf77EZWSFO
   2oMofEYXdrps+Cr2/jNo/VDgLW9i0WlUZzneY6DZ6u3/MaGBSrVOh7ESS
   oCe98H6suRcAJ2T0RyqZ0BcEeX4wXuw9bz59RCONnvev99UFwKWnChn+s
   +TIcYJMXa+U3vESCjJU+LqSa+5kGt1FCZbxXwSfh16HV5oLwsRHnDYnnO
   QRZ0b2pz+v1kJXuVboL2JBgVMSKjhObG1Y4pGyY8j0wAGbdnNmRmS6iwD
   I+et8ncTsnOz2zZGHrB7MByzAW5hdjKfYWxouOHTzARy/gDGdiGFzqjL4
   Q==;
X-CSE-ConnectionGUID: qMHQZOG3Temb1soD4BDcFg==
X-CSE-MsgGUID: F4aKbrXUTj6WJ3x2GfrhNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63152978"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63152978"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:37:58 -0700
X-CSE-ConnectionGUID: 7WIL9EBcSqygSEwYhk63IQ==
X-CSE-MsgGUID: PZIE/G1gTM+juI6NF22g7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216555795"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:37:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEOAK-00000003qbu-1kNG;
	Thu, 30 Oct 2025 10:37:52 +0200
Date: Thu, 30 Oct 2025 10:37:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
Message-ID: <aQMj4Bth84UnlT2e@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
 <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
 <aQMheocySykpTFDN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMheocySykpTFDN@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 10:27:38AM +0200, Andy Shevchenko wrote:
> On Wed, Oct 29, 2025 at 04:38:53PM +0100, Christian Marangi wrote:
> > On Wed, Oct 29, 2025 at 05:32:48PM +0200, Andy Shevchenko wrote:
> > > On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> > > > Add ERR_PTR_CONST macro to initialize global variables with error
> > > 
> > > ERR_PTR_CONST()
> > > 
> > > > pointers. This might be useful for specific case where there is a global
> > > > variables initialized to an error condition and then later set to the
> > > > real handle once probe finish/completes.
> > > 
> > > Okay, this has two caveats:
> > > 
> > > 1) naming is bad as it suggests something about const qualifier (and not, it's
> > > not about that at all);
> > > 
> > > 2) it doesn't explain what's wrong with ERR_PTR().
> > >
> > 
> > It can't be used for global variables as it does cause compilation
> > error.
> 
> Can you show an example, please?

Ah, it's probably due to static inline...

> > I wanted to use ERR_PTR to set the __smem handle instead of freecode
> > (void *) -EPROBE_DEFER and notice the compiler doesn't like using
> > ERR_PTR().
> > 
> > Then the problem is clear as static declaration require constant value
> > for initialization and ERR_PTR is a inline function.
> > 
> > This is why ERR_PTR_CONST following the pattern that was used for
> > FIELD_PREP -> FIELD_PREP_CONST that was also introduced for similar
> > case.
> > 
> > So yes this is specific for case of static global variables.

-- 
With Best Regards,
Andy Shevchenko



