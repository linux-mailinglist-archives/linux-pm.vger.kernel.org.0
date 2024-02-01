Return-Path: <linux-pm+bounces-3161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E638458BA
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594311F28653
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208653368;
	Thu,  1 Feb 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+4WxpDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD586655;
	Thu,  1 Feb 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793611; cv=none; b=kSE/F/1k5OrEsdssPnUnckuB7uEQv3fB04hZlzEB44MM/jeHlFwKcsAS6v76ju1PdxU0fRmyDBqAEg0nqe4MWGwkfvROIEKXChwhkdHb03Lj0IpQcUbhXP8aQKxR2N5QtqbRIR9ulP2O4aZ+l67rZWonweeKvrxqpOD8Q3E1uVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793611; c=relaxed/simple;
	bh=9Cn+RDhWB3FouXmnA4Ta++EQXc0ji45Nvod4hODjo9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uazv+trVm4bfvBoBHoH6i5/hlJfF/EC54M0HC3/7ibPa1KxL6SUoybHGA6hl5k+mVMX1GON71wD9n2/Xb76tc2+pNUivMzJ/MjZO8ggbz+rEqLycFeFBYwJ5FfH6GX6eU7sg7bhZZg4zwjHYxWy8PwJad7wFa+5gp9JRPZ6cxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+4WxpDU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706793610; x=1738329610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Cn+RDhWB3FouXmnA4Ta++EQXc0ji45Nvod4hODjo9U=;
  b=P+4WxpDUSWHOKucGBTC0krjrStS2izJvE2J+Wsifn+7hixhOiQCMW3Al
   +snNO2jkyvgOusr9igilXgV1nrbwjr8/GHkRgf2kz5+ZhuDnthGmpQZoA
   GWCkP0z+eTVNBH9VjsDI560RYRt3HBZUxuDzxWLfBwNrkWu+0vmApKh3n
   m/XuYFxGsa5oudG3ZKN7WopDYypxb69dIZUneFlD0w7yAGxDtWny5f8LJ
   JEXK9L4UMNQLgMZCoSD+MGtxtOUeIfNzovwr+kZtSxB11nWD/lR08G1NL
   4oDf54zCChzo/5cOFW+NudxTXFga8pZ+KYOefqgmk22JG6vpBPDPXXM2d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17421379"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17421379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="23101605"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.120])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:20:07 -0800
Date: Thu, 1 Feb 2024 14:20:04 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <ZbuahAPSKbJgQmlI@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
 <20240201014808.GF18560@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201014808.GF18560@ranerica-svr.sc.intel.com>

On Wed, Jan 31, 2024 at 05:48:08PM -0800, Ricardo Neri wrote:
> >  drivers/thermal/intel/intel_hfi.c | 82 +++++++++++++++++++++++++++----
> >  1 file changed, 73 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 3b04c6ec4fca..50601f75f6dc 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/math.h>
> >  #include <linux/mutex.h>
> > +#include <linux/netlink.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/processor.h>
> > @@ -480,7 +481,8 @@ void intel_hfi_online(unsigned int cpu)
> >  	/* Enable this HFI instance if this is its first online CPU. */
> >  	if (cpumask_weight(hfi_instance->cpus) == 1) {
> >  		hfi_set_hw_table(hfi_instance);
> > -		hfi_enable();
> > +		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
> > +			hfi_enable();
> 
> You could avoid the extra level of indentation if you did:
> 	if (cpumask_weight() == 1 && has_listeners())

Ok.

> You would need to also update the comment.

I'd rather remove the comment, code looks obvious enough for me.

Regards
Stanislaw

