Return-Path: <linux-pm+bounces-22742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E119A40D40
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 08:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3557AC15D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28AC1FC0F7;
	Sun, 23 Feb 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXZqvBSd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60D10A3E;
	Sun, 23 Feb 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740296002; cv=none; b=uAVEWwPjFCBIwWGRlxW/aNeGZ/JVYYJ8uauSg6x9U8D3LJqoaCTcanjMVVnwKy04eDk/aCmUF3XF6PcitJPqEKcSYSlZbXxsH3AHyZi7n+zEV1otz9Xafltri/AmkiYGCNeV5MKvVDj0Tr1dGg+3+xfBuXyg/THuivmxtX2uk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740296002; c=relaxed/simple;
	bh=73Wqn9wE5s7jSO3fZC58CnnYARE4WDY+xXaQVFqk0vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv7qX1OXJ3q8f7vHBynIFORtx6zdn3quBNGKFk8clfVin7vOk0Qj4TP0KTHzoUpPe+KIQMPL4C9NqpZzIYGF8egn4Y/qkQClANP234fyzr03fhBS5OttFMwBEvXu2b/c1Cb2xn4DufHpdYaPVjIqGGrDgGWSVQpHds263sdfq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXZqvBSd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740296001; x=1771832001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73Wqn9wE5s7jSO3fZC58CnnYARE4WDY+xXaQVFqk0vI=;
  b=QXZqvBSdRr8AP4wHDvIxBdDdlMcgRx3wisHYt/Kv00N3ziCzfRagtCps
   Jc281eI/CJcCraaabWoZ8QadBO6Pu/aGKCptKLHr3Co48MHkod+qRtlaJ
   06sdjbFD6jUf84yZYOwnzN5BrfUMNcmZFYvPZb0OKbDyBxO5hzW5hYdc4
   jEWSK/MBNFied796D7OO942G6ZTOal9EdOQys6v4K/BlK1wydRo+fxBUi
   lb1aAQW+W+RmIwwxYOucWKnZm0V5TF9GzqUOQimPb/oNfk0jG9QlHNCOD
   MrSrlUqNYhF0byA1YBih2xNfh+/iEM1xsLlscbxZLLy0H2vcswaz+QNpj
   w==;
X-CSE-ConnectionGUID: 2N1yQKtQT06nkyv95CLslQ==
X-CSE-MsgGUID: oGS84O99RU+GFse4WMRB9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="51708034"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51708034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 23:33:20 -0800
X-CSE-ConnectionGUID: VwDMSUE1Q5yqfIXVC9U80w==
X-CSE-MsgGUID: 03Rn9Od4QwSR7mNggNpMvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="146612714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 23:33:17 -0800
Date: Sun, 23 Feb 2025 09:33:14 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Oliver Neukum <oneukum@suse.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Brian Norris <briannorris@google.com>
Subject: Re: [PATCH v1] PM: runtime: Unify error handling during suspend and
 resume
Message-ID: <Z7rPOt0x5hWncjhr@black.fi.intel.com>
References: <1922654.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1922654.tdWV9SEqCh@rjwysocki.net>

On Thu, Feb 20, 2025 at 09:18:23PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a confusing difference in error handling between rpm_suspend()
> and rpm_resume() related to the special way in which the -EAGAIN and
> -EBUSY error values are treated by the former.  Also, converting
> -EACCES coming from the callback to an I/O error, which it quite likely
> is not, may confuse runtime PM users a bit.
> 
> To address the above, modify rpm_callback() to convert -EACCES coming
> from the driver to -EAGAIN and to set power.runtime_error only if the
> return value is not -EAGAIN or -EBUSY.
> 
> This will cause the error handling in rpm_resume() and rpm_suspend() to
> work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> special case from the latter and make it retry autosuspend if
> power.runtime_error is unset.
> 
> Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -448,8 +448,13 @@
>  		retval = __rpm_callback(cb, dev);
>  	}
>  
> -	dev->power.runtime_error = retval;
> -	return retval != -EACCES ? retval : -EIO;
> +	if (retval == -EACCES)
> +		retval = -EAGAIN;

While this is one way to address the problem, are we opening the door
to changing error codes when convenient? This might lead to different
kind of confusion from user standpoint.

Raag

