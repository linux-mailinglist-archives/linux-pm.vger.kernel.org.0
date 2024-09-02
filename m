Return-Path: <linux-pm+bounces-13317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E17967F84
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A5B22159
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12B14EC7D;
	Mon,  2 Sep 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx9+cTxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16610F1;
	Mon,  2 Sep 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258699; cv=none; b=CHEhss2XjE7mrct+/3Qu4b0d6mKmZUmZjq+Lftfnbi/zB/nxplI856vuPmEK0dHh66myOuCDEE2HJ/yEAUJUP+JIHSCoJx1gmvjEhcBQcPSLCCNbgnCEc7bZcEB/zV4V2dSYrqDLktnhAE8IS/FIRB3Oi6JGFGAEOp4pEcVEInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258699; c=relaxed/simple;
	bh=1fyYoKVnKXSjfRK75SN67brorSz+ARXZeWe9jVZ7e14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvh/+D8ptoxQepoIqd0TfiViCip8D8SV82zdHMewL2yRdLvs6FjvsWoRH4zWvhn3hRWv3YXl79KEmdhBA05BiRKP2Xje4abrwf6DYo0pCnTOVVDUwqlGIcckijlmNmY6jEnQu8cipTXac31m/foEoI8I8MlbarBt5zcMxFKrjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nx9+cTxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BAFC4CEC2;
	Mon,  2 Sep 2024 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725258698;
	bh=1fyYoKVnKXSjfRK75SN67brorSz+ARXZeWe9jVZ7e14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx9+cTxqmB+qqvd93U6X0RoMEKBgwaivDhWivVEgoWxScKCcq1ndI11yfbC8IcKT+
	 7zxXixI099LEk72xFOE9JoHSTg5+45O378l2DIcobs8Gr90VHTsNnqVD6WOh0XzTeF
	 rnJbOYMNuP60LsVTfYgXLrqMKUCGfEnjUysnavJ4=
Date: Mon, 2 Sep 2024 08:31:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Wang <00107082@163.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
Message-ID: <2024090212-shuffling-gimmick-a2dc@gregkh>
References: <20240902054959.28073-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902054959.28073-1-00107082@163.com>

On Mon, Sep 02, 2024 at 01:49:59PM +0800, David Wang wrote:
> dpm_list_mtx does not protect any data used by
> dev_warn for checking parent's power, move
> dev_warn out of mutex lock block make the
> lock more efficient, especially when the warn
> is triggered. This can happen on some HW when
> resume from suspend with USB camera opened:

Please wrap changelog lines at 72 columns if possible.

>  >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
>  >..
>  >ep_81: PM: parent 3-1.1:1.1 should not be sleeping
> 
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..934e5bb61f13 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -134,10 +134,10 @@ void device_pm_add(struct device *dev)
>  	pr_debug("Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	device_pm_check_callbacks(dev);
> -	mutex_lock(&dpm_list_mtx);
>  	if (dev->parent && dev->parent->power.is_prepared)
>  		dev_warn(dev, "parent %s should not be sleeping\n",
>  			dev_name(dev->parent));
> +	mutex_lock(&dpm_list_mtx);

I do not understand how this change will remove the offending log
message.  It should be safe to hold the lock while the check happens and
the message is printed out, you should not see any functional change at
all.

So are you sure this is needed?

thanks,

greg k-h

