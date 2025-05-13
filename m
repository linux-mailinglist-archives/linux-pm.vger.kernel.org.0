Return-Path: <linux-pm+bounces-27071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B12AB4CF2
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688B217D7B9
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29D1F09AD;
	Tue, 13 May 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAKeHnQ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB203FBA7;
	Tue, 13 May 2025 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122131; cv=none; b=h9k159o/mTaW48Mxw/vryEBkpGADL1t7L7plM5bnPBD/d35a7PCcicMI4ZvhGIomjA38brAie5ns9Rgt4LI/XwHtN95kFv2OnolauxemWg7g/wGVqDxT8VONuWrrpdXfBy9WHyM0ripUOwqpKLbBdPzkj9Q42CJAo1tk+Edit4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122131; c=relaxed/simple;
	bh=M460D3zObSd+2Z7syVqEJCI611LBZLpaJavsxNSdSCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfxZLqs09dha/tDV5mT9vF3Kl/urO4/sKCjBoS+5Y5rreJXbVDOwJOw9a5WT2e1K6Oi/vGer0pPkYVZy4F3UhB0GESlZfKqP73HZukRTswepFZJeBK3MuU0v2x7nTTDg7XdVTZB6SmH10APWRlPfcamLg+udI5gmT2oWizNCvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAKeHnQ5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747122129; x=1778658129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M460D3zObSd+2Z7syVqEJCI611LBZLpaJavsxNSdSCE=;
  b=jAKeHnQ5fjo2mEPRRTXGVpFignvUZca7TR6u3DsZqCMmMtmxU+3/FKpM
   w9Rx/aKnUeHt7/YyWpJjf0jS37b8BKmIfuyeO/mpMvVumRR6mv2Bgvul/
   Uj+Arz/n9QC3Iy68sSnw7/uwUdA1BDCCu3wh9ihFgAtf7Ya1yOZB7lmxq
   JUXLcmR46pJWTwvLH4AWLD1B4tUdfnB4s5tbLUZNSA9wwzEYHBU/6KASl
   vz865DKnyqbP2KM5tz9vi0bf7GxxCBiK7pZRxW654DsAT6QEP0ww5Go6K
   pK5YwJQZQ21tZ30AE2ETLIoZ6Sy2lb394LZlz0yJuO8lNDWNixxTz+tF/
   Q==;
X-CSE-ConnectionGUID: aIkc28mxTAqdmgMA7QmQUw==
X-CSE-MsgGUID: KzT/QMZSSGigOrWjNGs24w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="36577130"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="36577130"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 00:42:08 -0700
X-CSE-ConnectionGUID: 8vPDbHKqRxe5vi8sIZk5MQ==
X-CSE-MsgGUID: zC07gZk1SImBsUmASNUdnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138556457"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 13 May 2025 00:42:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 May 2025 10:42:03 +0300
Date: Tue, 13 May 2025 10:42:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] ucsi_ccg: Disable async suspend in ucsi_ccg_probe()
Message-ID: <aCL3yx_z61IpGgw0@kuha.fi.intel.com>
References: <6180608.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6180608.lOV4Wx5bFT@rjwysocki.net>

On Mon, May 12, 2025 at 03:26:53PM +0200, Rafael J. Wysocki wrote:
> From: Jon Hunter <jonathanh@nvidia.com>
> 
> Commit aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending
> children") had triggered a suspend issue on Tegra boards because it had
> reordered the syspend of devices with async suspend enabled with respect
> to some other devices.  Specifically, the devices with async suspend
> enabled that have no children are now suspended before any other devices
> unless there are device links pointing to them as suppliers.
> 
> The investigation that followed the failure report uncovered that async
> suspend was enabled for the cypd4226 device that was a Type-C controller
> with a dependency on USB PHY and it turned out that disabling async
> suspend for that device made the issue go away.  Since async suspend
> takes dependencies between parents and children into account as well
> as other dependencies between devices represented by device links, this
> means that the cypd4226 has a dependency on another device that is
> not represented in any form in the kernel (a "hidden" dependency), in
> which case async suspend should not be enabled for it.
> 
> Accordingly, make ucsi_ccg_probe() disable async suspend for the
> devices handled by, which covers the cypd4226 device on the Tegra
> boards as well as other devices likely to have similar "hidden"
> dependencies.
> 
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> Closes: https://lore.kernel.org/linux-pm/c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com/
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Commit aa7a9275ab81 is in linux-next and it has not reached the mainline yet.
> 
> Thanks!
> 
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -1483,6 +1483,8 @@
>  
>  	i2c_set_clientdata(client, uc);
>  
> +	device_disable_async_suspend(uc->dev);
> +
>  	pm_runtime_set_active(uc->dev);
>  	pm_runtime_enable(uc->dev);
>  	pm_runtime_use_autosuspend(uc->dev);
> 
> 

-- 
heikki

