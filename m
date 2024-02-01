Return-Path: <linux-pm+bounces-3164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECF845D23
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70806286D03
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC055A4FF;
	Thu,  1 Feb 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/mrv4II"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A915A4E8;
	Thu,  1 Feb 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804407; cv=none; b=I1O9Ed6Akrfy2FBuFVbs0Q3gumyXGvlmyWlzyoCgHqHv4Jr58/iDYFwb3/67SwjlHWe7nlVsH6ksuHrMifZqnTFuPH2bXjZZJbpDib+uHxSNtlOEANsU6J01HIVLK56QYlm8bgsP3ovi6HZnqotnhRamgyU6wol5JjcDRpWTpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804407; c=relaxed/simple;
	bh=9mrXOkzAsPI9LfSua9gY9MCwsGcmuZlpNnrZSCMNiV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q92+dIx1cA5/jhtTNvqFVv0wVQ/Zj3TRmvodTR60uWvNHhGr0OPbh8BwV0vHO9N1S8xBVxlj0UaZDrcT0heeoh6Lf3UVcQSfDF/LhXB83o3sAXKuY49hLmj9SqOw8RPva7LecuuTNnhmdRpXnIuO19VdHbVPVfd10OD7D9Dh9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/mrv4II; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706804405; x=1738340405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9mrXOkzAsPI9LfSua9gY9MCwsGcmuZlpNnrZSCMNiV8=;
  b=j/mrv4IIl6ZiK6zXtr7KswTi6BLSFYkg708rtYPibskxdPMTvrty74Dj
   kXu/K+AGE2m8ecMRHEaO7IxNpa6i5CbPCYTrLb/LRoW0Rlkmh3fcmqyra
   NgIqePl5MIvqsZlSGW8plyFY9nyExm2mVjjoIHwInZh2anJXfpgpKYyHk
   t8qd4z1DD6/+/McWIzZHzXS/nSjELsjiWBFTkPDsGNvVxu1A5e/ZB7Ign
   /M39XFZZqMmr7TSY7hqWQiDGs2VFexBWixv88rwyOjJcR6iNJhdsBKxIP
   kxRlFGROiFn/glARyEIztWRJxVhul0B0vx5b5Rtjm6RVIHxKJqr7fmdxN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402776579"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="402776579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="912165321"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="912165321"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:20:04 -0800
Date: Thu, 1 Feb 2024 08:21:25 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <20240201162125.GA20261@ranerica-svr.sc.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
 <20240201014808.GF18560@ranerica-svr.sc.intel.com>
 <ZbuahAPSKbJgQmlI@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbuahAPSKbJgQmlI@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Feb 01, 2024 at 02:20:04PM +0100, Stanislaw Gruszka wrote:
> On Wed, Jan 31, 2024 at 05:48:08PM -0800, Ricardo Neri wrote:
> > >  drivers/thermal/intel/intel_hfi.c | 82 +++++++++++++++++++++++++++----
> > >  1 file changed, 73 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > index 3b04c6ec4fca..50601f75f6dc 100644
> > > --- a/drivers/thermal/intel/intel_hfi.c
> > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/math.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/netlink.h>
> > >  #include <linux/percpu-defs.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/processor.h>
> > > @@ -480,7 +481,8 @@ void intel_hfi_online(unsigned int cpu)
> > >  	/* Enable this HFI instance if this is its first online CPU. */
> > >  	if (cpumask_weight(hfi_instance->cpus) == 1) {
> > >  		hfi_set_hw_table(hfi_instance);
> > > -		hfi_enable();
> > > +		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
> > > +			hfi_enable();
> > 
> > You could avoid the extra level of indentation if you did:
> > 	if (cpumask_weight() == 1 && has_listeners())
> 
> Ok.
> 
> > You would need to also update the comment.
> 
> I'd rather remove the comment, code looks obvious enough for me.

Do you think that it is clar that needs to be done only once per
package? I guess it is clear but only after reading the more code.

