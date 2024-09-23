Return-Path: <linux-pm+bounces-14569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DE97EC03
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255791C213E7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75251991B0;
	Mon, 23 Sep 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2CcblEp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BA198E6F;
	Mon, 23 Sep 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096823; cv=none; b=CSYkP7AGMdErSEZwwo/t07/EwAVdAQF1/jGE1AcFftdSeMNmYJLWYnTU/K9UMaDh/TrnaP4+DbXIMI2Immo8cOZhipemQbZEyWCGuVs4myTJSjptJq0xT+mhcShAsT/MY7HRS5hnX2NX+4xdcH0+y9P2nZL8J2Dmf+fV2uZPRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096823; c=relaxed/simple;
	bh=o8HTBfVyR5kXn+aqXU7zjNAFtRfUn4jh6KoQZTzAbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4LQCqyf/taqaCGXgE8spAoo+XlJLHmiMxI5o/GN0DrU7Y5N9rIC2FogVTcRF2HOAsY6zDrTeY6+PIDHptjepmGnHpZBJrmvGw1I7b1zJ4FFfoujEIg0SHYl+U8fMm/a5xMwvjjnuyrn4ZmiCr9dW1sjQXHdTTayukO/6HQ8JrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2CcblEp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5D8C4CEC4;
	Mon, 23 Sep 2024 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727096823;
	bh=o8HTBfVyR5kXn+aqXU7zjNAFtRfUn4jh6KoQZTzAbkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2CcblEp8r66+Mre+tQmJTYKSydEuUo0Y964S1AwaEMY5uonHaHWBCK7YfYCFZ/d3J
	 MrXCuFZrCqXhALLUj9Bid0XS/gH6mQrdCFsx+85UBZ8H/pCs4FNVxbbrNAH3vBXUKW
	 G9lxZ7dua4SvCE3cIDrmsYfZa6GsEP2DeXkYNK60=
Date: Mon, 23 Sep 2024 15:06:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dengjie03 <dengjie03@kylinos.cn>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn, xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH] KYLIN: USB: Fix the issue of S4 wakeup queisce phase
 where task resumption fails due to USB status
Message-ID: <2024092355-chip-stuffy-bd93@gregkh>
References: <20240923100553.119324-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923100553.119324-1-dengjie03@kylinos.cn>

On Mon, Sep 23, 2024 at 06:05:53PM +0800, dengjie03 wrote:
> Reproduction of the problem: During the S4 stress test,
> when a USB device is inserted or removed, there is a
> probability that the S4 wakeup will turn into a reboot.
> The following two points describe how to analyze and
> locate the problem points:
> 
> 1. During the boot stage when S4 is awakened, after
> the USB RootHub is initialized,it will enter the
> runtime suspend state. From then on, whenever an
> xhci port change event occurs, it will trigger a
> remote wakeup request event and add wakeup_work to
> pm_wq, where the subsequent RootHub runtime resume
> process will be handled by pm_wq.
> 
> xhci runtime suspend flow：
> S4 boot
>    |->xhci init
>        |->register_root_hub
> 	   |->hub_probe
> 	       |->callback = RPM_GET_CALLBACK(dev, runtime_suspend)   /* xhci RootHub runtime suspend */
> 
> xhci runtime resume flow ：
> xhci_irq()
>     |->xhci_handle_event()
> 	|->handle_port_status()
>    	    |->if(hcd->state == HC_STATE_SUSPENDED)
> 		 |->usb_hcd_resume_root_hub()
> 		    |->set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags)   /* wakeup pending signal to be set */
>   		    |->queue_work(pm_wq, &hcd->wakeup_work)
> 			|->hcd_resume_work()			       /* hcd->wakeup_work */
> 			    |->usb_remote_wakeup()
> 				|->callback = RPM_GET_CALLBACK(dev, runtime_resume)
> 				    |->usb_runtime_resume()            /* usb runtime resume  */
> 					|->generic_resume()
> 					    |->hcd_bus_resume()
> 						|->clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
> 						  /* wakeup pending signal to be clear */
> 
> 2. However, during the quiesce phase of S4 wakeup,
> freeze_kernel_threads() will freeze this pm_wq,
> and between freeze_kernel_threads() and dpm_suspend_start(),
> there exists a very time-consuming S4 image loading process.
> This leads to a situation where, if an xhci port change event occurs
> after freeze_kernel_threads(), triggering the wakeup pending
> signal to be set,but it cannot be processed by pm_wq to clear
> this wakeup_pending bit, it will result in a subsequent
> dpm_suspend_start() where USB suspend_common() detects the
> wakeup pending signal being set and returns an -EBUSY error,
> interrupting the S4 quiesce process and reverting to a reboot.
> 
> S4 wakeup
>     |->resume_store
> 	|->software_resume()
> 	    |->freeze_kernel_threads()		/* will freeze pm_wq */
> 	    |->load_image_and_restore()
> 		  |->swsusp_read()    	        /* S4 image loading: time-consuming .
> When an xhci port change event occurs at this point, it triggers the wakeup pending signal to be set.
> However, since the pm_wq is in a frozen state, the wakeup_pending bit cannot be cleared.*/
>    		  |->hibernation_restore
> 			|->dpm_suspend_start(PMSG_QUIESCE)
> 			    |->hcd_pci_suspend()
> 				|->suspend_common()
> 				    |->if (do_wakeup && HCD_WAKEUP_PENDING(hcd))  return -EBUSY;
> 
> Below is a description of the countermeasures taken to address this issue:
> 1. Considering the restore process that occurs after
> the quiesce phase during S4 wakeup, which essentially
> resets all root hubs,checking this wakeup pending status
> in USB suspend_common() during the quiesce phase is of
> little significance and should therefore be filtered out.
> 
> S4 wakeup restore phase
>     |->dpm_resume(PMSG_RESTORE)
> 	|->hcd_pci_restore()
> 	    |->xhci_resume()		       /* reset all root hubs */
> 
> Fixes: 3904bdf0821c40352495f632862637080e6bd744(PM: hibernate: Freeze kernel threads in software_resume())

Please read the documentation for how to list a Fixes: tag, it should be
a bit smaller than this line :)

> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Co-developed-by: dengjie03 <dengjie03@kylinos.cn>

As the documentation states, we need real names, not email aliases.

And fix up how you use co-developed-by please, again, the documentation
shows how to do so.


> ---
>  drivers/base/power/main.c  |  5 +++++
>  drivers/usb/core/hcd-pci.c | 21 ++++++++++++++-------
>  include/linux/pm.h         |  1 +
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index fb4d18a0b185..264d08b9e331 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -559,6 +559,11 @@ bool dev_pm_may_skip_resume(struct device *dev)
>  	return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
>  }
>  
> +bool is_pm_queisce(void)

Bad name for a global function :(

> +{
> +	return pm_transition.event == PM_EVENT_QUIESCE;

What happens if it changes right after this?  Where is the locking
involved?  And why does USB only care about this and no other subsystem?

thanks,

greg k-h

