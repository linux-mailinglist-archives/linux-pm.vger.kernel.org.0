Return-Path: <linux-pm+bounces-3143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43B844ED0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 02:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9B2286A62
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDF5243;
	Thu,  1 Feb 2024 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRTMmJnH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847746B3;
	Thu,  1 Feb 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752009; cv=none; b=OUcXZqSW8f4Ihtg0FLwlJi4VL8MXFrDG3lobWPzu3h+Z3tcdqMaH+IjE0JCpcZ6+ILX+0icltgjQtOtQXit/jskaP/TNgzu+Y+teSuTpDbswHIA/wDPgOisa/eB21AdIpTiSBNq+Uyiel36aBNj7jyFiU9FCDxBtPl0LB72kr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752009; c=relaxed/simple;
	bh=FJzDsG9kSU8DbmUxMS4dfZM8sMHzJMKPGsS3zV9z0zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr1fNgSKmEwiNwUWwrMIpoOjmYfP9uMLL4o+STWm4OIevA0e48GXOgQ6yMfgOH0NeFF6BL3AwDG9mj1ylwjSuCkxzevyzqPLKizaHVyl3TArdaT1uFovhO+9bRKVn9wrSyVlvv4KFsY1EuiZ+9rWofy+fc9ehnfgCX2g/E8ljS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRTMmJnH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706752008; x=1738288008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJzDsG9kSU8DbmUxMS4dfZM8sMHzJMKPGsS3zV9z0zM=;
  b=PRTMmJnHF77frm5YgJ24N6WGEQNUN7xzVpe7wPbNm5UaY2wXwuDINS/g
   oL6OhPKjj4LKwHCVEPE5ygtJeUt7rxt93F1m3MmrhDzPIHIyw0moq7kdW
   aYa4tZCVxxqSPRKXun3XW68jT+lET8AU8T19g1blbnDc/6AvrVtvOqVAD
   fUmr3lMNyzCQTX2Q7GEW8erXrLXhAE7qOrD5jI1c5djLdYFPMRxCJOwE3
   JJm2nS9eZIR5MNbExooawRcbgHNDlW02fSYYg3LRQyaOXM8QizC/CSteV
   va6UQN23GVU904T3La6FCKFX6ZDQ0a2OXIOSO9D/ZwBn6CTQoZc91W0LR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17166280"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17166280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4243771"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:46:46 -0800
Date: Wed, 31 Jan 2024 17:48:08 -0800
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
Message-ID: <20240201014808.GF18560@ranerica-svr.sc.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 31, 2024 at 01:05:35PM +0100, Stanislaw Gruszka wrote:
> Enable and disable hardware feedback interface (HFI) when user space
> handler is present. For example, enable HFI, when intel-speed-select or
> Intel Low Power daemon is running and subscribing to thermal netlink
> events,. When user space handlers exit or remove subscription for
> thermal netlink events, disable HFI.

I'd rephrase as:

Enable and disable HFI when a user space handler is running and listening
to thermal netlink events (e.g., intel-speed-select, Intel Low Power
daemon). When the user space handlers exit or remove subscription, disable
HFI.

> 
> Summary of changes:
> 
> - When CPU is online, instead of blindly enabling HFI by calling
> hfi_enable(), check if the thermal netlink group has any listener.
> This will make sure that HFI is not enabled by default during boot
> time.

s/by calling hfi_enable()//

> 
> - Register a netlink notifier.
> 
> - In the notifier process reason code NETLINK_CHANGE and

s/notifier/notifier,/

> NETLINK_URELEASE. If thermal netlink group has any listener enable
> HFI on all packages. If there are no listener disable HFI on all
> packages.
> 
> - Actual processing to enable/disable matches what is done in
> suspend/resume callbacks. So, create two functions hfi_do_enable()

s/So,//

> and hfi_do_disable(), which can be called from  the netlink notifier
> callback and suspend/resume callbacks.
> 
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_hfi.c | 82 +++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 3b04c6ec4fca..50601f75f6dc 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -30,6 +30,7 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/netlink.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
> @@ -480,7 +481,8 @@ void intel_hfi_online(unsigned int cpu)
>  	/* Enable this HFI instance if this is its first online CPU. */
>  	if (cpumask_weight(hfi_instance->cpus) == 1) {
>  		hfi_set_hw_table(hfi_instance);
> -		hfi_enable();
> +		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
> +			hfi_enable();

You could avoid the extra level of indentation if you did:
	if (cpumask_weight() == 1 && has_listeners())

You would need to also update the comment.

My two cents.
 

