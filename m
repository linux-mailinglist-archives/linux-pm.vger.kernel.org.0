Return-Path: <linux-pm+bounces-37082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3FC1EFBB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B26E3B3C79
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089D337BB4;
	Thu, 30 Oct 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agtMmKK0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80A33436F;
	Thu, 30 Oct 2025 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812865; cv=none; b=T8yotKqaCQv+JQYdtxWfdzgusz2weiPP+hccCKtgCcMRtCpWM84Jk9bfUu9E8ecw1QJdeMTvIV3iUzyiDe/yQsi9SX6OtOc9OG7wqnt23/QaYWsSUcQCuLOjCJxROkOhcfyk2zt08MRMMXdAERs0ynLJG5HhVgsrbzgobafBrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812865; c=relaxed/simple;
	bh=lNchQvwtehvAgZ+kMCQMiDnyB1qKJPXg3ZxQ7YrlK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGEyxNtvaSHAlZrHdF7doYMG10ANohAThkCrr/6L0X+KpvrbbVaHI/BEhhD3QulAq6ntwW0QpZ4tubOlY04tzdEsDzEUwZNokT4C2GIVZLhxXH8vM1afE9lR4cBiiGFXOwHiWd9u+YzUveg5lKzEGoku4ILbIbAxpjwLh2wnU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agtMmKK0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761812864; x=1793348864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNchQvwtehvAgZ+kMCQMiDnyB1qKJPXg3ZxQ7YrlK+Q=;
  b=agtMmKK0Uww3+Kap6TRuZwDmM9ouSPXxfkFHwN8hG8Es5oN4wZeTRTVu
   9dCEEEJPw+ws6xjLFX/hrI7SnJSX0nOkIupkfna9DSrvVVJeoqb40Qk3C
   OrHI5TFHAhRLAbPVkapkU1fF9tVN55KWQYGR8/oAbM7+GVDlzpQ4ISFKI
   aMHFll0Fr+Ii0Gl7KR5//NkNAVNBzwVVH7OCwyRyEvodw/v0mEP9O1l9j
   2vj589tl62+y9NhKKSiCs6M1iNoSUwUFZQhR0KjjgaqWfKPn67q0/LsRo
   +Hw8o7S+y6oLRLCxsSzWLVE988ZgOVOv4lawkDSsprrQkJ7+7eqEa4IKU
   A==;
X-CSE-ConnectionGUID: DgsmMYMSRG+BYpNLMlyrAw==
X-CSE-MsgGUID: kGZCQg+VTv25hDec0D0pDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63832214"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63832214"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:27:44 -0700
X-CSE-ConnectionGUID: DTsPJpKaQPmFuBgE9CE4jg==
X-CSE-MsgGUID: T2cdlYDHRo2YREBNMYZsdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185591119"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:27:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEO0Q-00000003qTO-1Odv;
	Thu, 30 Oct 2025 10:27:38 +0200
Date: Thu, 30 Oct 2025 10:27:38 +0200
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
Message-ID: <aQMheocySykpTFDN@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
 <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 04:38:53PM +0100, Christian Marangi wrote:
> On Wed, Oct 29, 2025 at 05:32:48PM +0200, Andy Shevchenko wrote:
> > On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> > > Add ERR_PTR_CONST macro to initialize global variables with error
> > 
> > ERR_PTR_CONST()
> > 
> > > pointers. This might be useful for specific case where there is a global
> > > variables initialized to an error condition and then later set to the
> > > real handle once probe finish/completes.
> > 
> > Okay, this has two caveats:
> > 
> > 1) naming is bad as it suggests something about const qualifier (and not, it's
> > not about that at all);
> > 
> > 2) it doesn't explain what's wrong with ERR_PTR().
> >
> 
> It can't be used for global variables as it does cause compilation
> error.

Can you show an example, please?

> I wanted to use ERR_PTR to set the __smem handle instead of freecode
> (void *) -EPROBE_DEFER and notice the compiler doesn't like using
> ERR_PTR().
> 
> Then the problem is clear as static declaration require constant value
> for initialization and ERR_PTR is a inline function.
> 
> This is why ERR_PTR_CONST following the pattern that was used for
> FIELD_PREP -> FIELD_PREP_CONST that was also introduced for similar
> case.
> 
> So yes this is specific for case of static global variables.

-- 
With Best Regards,
Andy Shevchenko



