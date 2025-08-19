Return-Path: <linux-pm+bounces-32662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B7B2CD17
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 21:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D45623076
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BB733CE84;
	Tue, 19 Aug 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdvP56Ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE122FDEC;
	Tue, 19 Aug 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632475; cv=none; b=rWgOIsdxRpVdcWrI0n9YmsRnEJw7yeqaFmCi6sughM1kI/vkPECL2ddDR8pGtzpjMv/xADFyDKdxSDQt9TCot+mzVMWOb5PJ01F16i77hU8MoM00gOu5TP0nyLPPqn1oxeUdnX+7Km1+kqVqCL1nrzUIXBpzXfVKQqlxqa6+78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632475; c=relaxed/simple;
	bh=6k0fMLmvdxJEM15SIJgnHJgTnEbkFLC8Sv+RWQRhuts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGPa8ft0Kl1Jjapo1hOLyFruJzRWEgGahbd1BQLaWa8wODtJ1WpqIZElAqTOXdktrb7Bu0fQbIqXbsiETRVs9a7bA9s1mYLm5PfiBzTgLOJwKpfvMgKedVu8zf7Kqa00RxNTBqWsh2Z2kT9A8mpBfIaCJ77VIdh1t+zh5nkgoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdvP56Ng; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755632474; x=1787168474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6k0fMLmvdxJEM15SIJgnHJgTnEbkFLC8Sv+RWQRhuts=;
  b=hdvP56NgjW+OMjk8qOOS+q6BsvX1QUFRn8wzfMO+5YUn8h3w20XWmuhb
   a4gg44L1JdufYKFT4HfDGTV0qGXHD535I15Sw6sE7gXiTBDC5gAdI9oDL
   m23MM7UBBXgnTYHI7yfMThWgC5pcC57GuB4eTkHIWDDT+t7XY5A8RknyF
   pqgFzbMeKiimMZiDTNKzjUAdl5FJ0Cx7KMQrjAkjIWOHtoOzqU/D1DqhA
   IDB7Xy02kCpfFtXtTX2fl4ZLfMu8WXGxh3SkCaJRNupMnxEGEFonzAee8
   s3xw0zlC6HbHnKxqzeEmtPA7dSnjEeANQFb0O3+uF5gnLZyBHmXg3EVyL
   Q==;
X-CSE-ConnectionGUID: oy+L1pXsT3aeBGTq9jARuQ==
X-CSE-MsgGUID: il2CC/OMT4uTL0B2g4mORA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57817374"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57817374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 12:41:14 -0700
X-CSE-ConnectionGUID: /kNpU3lVSfGyXuGX6UA6DA==
X-CSE-MsgGUID: W549zCc/TK+s2b0/XsGY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172365446"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.220.219])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 12:41:13 -0700
Date: Tue, 19 Aug 2025 12:41:11 -0700
From: David Box <david.e.box@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Xi Pardee <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
Message-ID: <mxzvvne6qycybtc25vj3mdoait5zz355kza7jcg5wcxz2ciji3@yn7k3jib72x7>
References: <20250814195156.628714-1-xi.pardee@linux.intel.com>
 <88da5769-1eae-4520-99b0-78a59bdbd867@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88da5769-1eae-4520-99b0-78a59bdbd867@app.fastmail.com>

Hi Xi,

On Mon, Aug 18, 2025 at 11:40:47AM -0400, Mark Pearson wrote:
> Thanks Xi
> 
> On Thu, Aug 14, 2025, at 3:51 PM, Xi Pardee wrote:
> > Updated ARL_PMT_DMU_GUID value. Arrow Lake PMT DMU GUID has
> > been updated after it was released. This updates ensures that
> > the die c6 value is available in the debug filesystem.
> >
> > Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support 
> > to intel_pmc_core driver")
> > Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/pmc/core.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/intel/pmc/core.h 
> > b/drivers/platform/x86/intel/pmc/core.h
> > index 4a94a4ee031e6..24139617eef61 100644
> > --- a/drivers/platform/x86/intel/pmc/core.h
> > +++ b/drivers/platform/x86/intel/pmc/core.h
> > @@ -282,7 +282,7 @@ enum ppfear_regs {
> >  /* Die C6 from PUNIT telemetry */
> >  #define MTL_PMT_DMU_DIE_C6_OFFSET		15
> >  #define MTL_PMT_DMU_GUID			0x1A067102
> > -#define ARL_PMT_DMU_GUID			0x1A06A000
> > +#define ARL_PMT_DMU_GUID			0x1A06A102
> > 
> >  #define LNL_PMC_MMIO_REG_LEN			0x2708
> >  #define LNL_PMC_LTR_OSSE			0x1B88
> > -- 
> > 2.43.0
> 
> Tested this on my Lenovo P1 G8 and confirmed that it fixed the error message that was seen previously.
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

If you send another version, please tag with a link to the bugzilla,
https://bugzilla.kernel.org/show_bug.cgi?id=220421

Thanks

David

