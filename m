Return-Path: <linux-pm+bounces-37103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BBDC207C0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E36ED4EC486
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227118A93F;
	Thu, 30 Oct 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBwl913C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE051E5B9E;
	Thu, 30 Oct 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832855; cv=none; b=bMHnxBmzcl9YqA08njq40qYj7/YEdu5MdhqAkVjVRDKPJ0gAWRzqq192QO9Uh6gB3hRPByPXtka4K5fQLNWfZvkcMmUKLhRwf1qajVdbW2PMYP3RnycfHB9Tq8jt6gPIsu5o2PI89ojBBMB3uuNevMndieJgYUsvHDBsNO3zkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832855; c=relaxed/simple;
	bh=XUYybZu/Tr9eOAMQaOaQ+Fw4SF+ZmMyMy7iua1evwH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZU+rT3Uo5Q4Axv4NMiayWcfuIlhnodD5WAHd3wU+AiYDBrATJ+u4YYfttQkm2CkWXLapysZBKTTcgcAdRI5BXLD1g6Uq8vnvalGrVywtnnWO784ek3Y9ngXCYPDoLZ4D53r0mace+xVYsx1CeZE1hgrp0tqiAmVY3d7kDKGWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBwl913C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761832853; x=1793368853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUYybZu/Tr9eOAMQaOaQ+Fw4SF+ZmMyMy7iua1evwH8=;
  b=hBwl913Cr6lZDpiQi0gxbtS78cf5ZCPADvez3v7JFDYquY8RvhK/3QB/
   I+6b3uTXIVD3ZV6B8sf6wDIwKvl3Hr9mnDxKYmeAVy/2pqEaL3UV3ACCu
   8p30d6U4ANbcjdgk588j4YsuO85gJvOdI9Z3j/1OYhOTp2l2BQkO2NyzV
   G5zTlxIc8TL2dtM1NORgnAjcD1B2alpRELKRJnvb8oE6In+1f+JpPshU0
   YFNMsmbK4mnmNfd9bg2aC7aIvBU6QT+X9O7rPof73LnBzsGOdiudhK/7w
   IoCgbOwDO+KBRnA6MWEqqwCL9mywynMjslmn3ue6BxGylgzz8hIhU93y/
   A==;
X-CSE-ConnectionGUID: +udlj2gyTfKE+kKyJg6mcw==
X-CSE-MsgGUID: vFuypyS5T3qNj1P6iP7X6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63883650"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63883650"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:00:53 -0700
X-CSE-ConnectionGUID: U5k5Az+fQ6aj/IlFtAtMUA==
X-CSE-MsgGUID: +cuqg9vjRzuNBlSxwz0xqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="223182374"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:00:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vETCp-00000003vky-0vbP;
	Thu, 30 Oct 2025 16:00:47 +0200
Date: Thu, 30 Oct 2025 16:00:46 +0200
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
Message-ID: <aQNvjqJGqFO30JTx@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
 <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
 <aQMheocySykpTFDN@smile.fi.intel.com>
 <69033c55.df0a0220.1a33d7.49ff@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69033c55.df0a0220.1a33d7.49ff@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 11:22:11AM +0100, Christian Marangi wrote:
> On Thu, Oct 30, 2025 at 10:27:38AM +0200, Andy Shevchenko wrote:
> > On Wed, Oct 29, 2025 at 04:38:53PM +0100, Christian Marangi wrote:
> > > On Wed, Oct 29, 2025 at 05:32:48PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> > > > > Add ERR_PTR_CONST macro to initialize global variables with error
> > > > 
> > > > ERR_PTR_CONST()
> > > > 
> > > > > pointers. This might be useful for specific case where there is a global
> > > > > variables initialized to an error condition and then later set to the
> > > > > real handle once probe finish/completes.
> > > > 
> > > > Okay, this has two caveats:
> > > > 
> > > > 1) naming is bad as it suggests something about const qualifier (and not, it's
> > > > not about that at all);
> > > > 
> > > > 2) it doesn't explain what's wrong with ERR_PTR().
> > > >
> > > 
> > > It can't be used for global variables as it does cause compilation
> > > error.
> > 
> > Can you show an example, please?
> 
> drivers/soc/qcom/smem.c:361:35: error: initializer element is not constant
>   361 | static struct qcom_smem *__smem = ERR_PTR(-EPROBE_DEFER);
>       |                                   ^~~~~~~
> make[9]: *** [scripts/Makefile.build:229: drivers/soc/qcom/smem.o] Error 1
> 
> You want me to add this to the commit? Or any hint to better reword this
> so it's more understandable?

Just the first line would be enough.
And perhaps better naming for the macro, but I have no ideas from top of my
head right now. Ah, actually I do. We call those either INIT_*() or DEFINE_*()
with the difference that INIT_*() works like your proposed idea. i.e. returns
a suitable value, but DEFINE_*() incorporates a variable and a type.

I think the INIT_ERR_PTR() is what we want as a name.

> > > I wanted to use ERR_PTR to set the __smem handle instead of freecode
> > > (void *) -EPROBE_DEFER and notice the compiler doesn't like using
> > > ERR_PTR().
> > > 
> > > Then the problem is clear as static declaration require constant value
> > > for initialization and ERR_PTR is a inline function.
> > > 
> > > This is why ERR_PTR_CONST following the pattern that was used for
> > > FIELD_PREP -> FIELD_PREP_CONST that was also introduced for similar
> > > case.
> > > 
> > > So yes this is specific for case of static global variables.

-- 
With Best Regards,
Andy Shevchenko



