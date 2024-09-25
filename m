Return-Path: <linux-pm+bounces-14641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C7985307
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A32833CF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F10155725;
	Wed, 25 Sep 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIykPuBO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD6155385;
	Wed, 25 Sep 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246413; cv=none; b=ETw2K86LMwEdY2Iloj0LUejAgIBFfkdDUlP0hd+26i/mTp2AkhBvDztK9vBIu29j+RNYoTWDDjCSM+brvgzNYqsf3VlWvhlV63aD/XVynlCN6tr9GWV73t9VNc8m3vVb9I33953gNxMd2Wj8Anho7eMAhPiPfnfwNFuzVHkJNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246413; c=relaxed/simple;
	bh=kdrnwHoFYuyZVWUkJlIRI7Jl8wZFEWKJnF4UzyiMJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4g/u8CiRA3Ir9Xf/cXbQRqwjkYEFFNzPvJdd32gxRKIn3CBP2LFDgpaZ52PzfcSw/2EiJQyifRE0CWakHQp2I3RsYnrKKEh8ZjEYhFIjdSxUS5Py/ozBEn/SNuj+e5jHR7RhihInM7g0t3vNJJ4S0/CZvSOWHnMulNcX4x3V7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIykPuBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D5C4CEC3;
	Wed, 25 Sep 2024 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727246412;
	bh=kdrnwHoFYuyZVWUkJlIRI7Jl8wZFEWKJnF4UzyiMJHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIykPuBOtzCwWPL1TEM4Z1Knbrq7c40b8qyAAwJJJX6/eajG/M9HlP4MIOSYqWKqI
	 FGFr/YqHFE7U8OOC1YZ1CsUOu8wFfLUfTIYpG80jo+jVu4cPV02ruPTYvbT/0PH1Bn
	 vyHafCXhJUh7YP1MwX2EdtXhgKtR47uJ9zjTpMLU=
Date: Wed, 25 Sep 2024 08:40:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dengjie <dengjie03@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn, xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where
 task resumption fails due to USB status
Message-ID: <2024092543-enforcer-quaintly-9f3e@gregkh>
References: <20240923100553.119324-1-dengjie03@kylinos.cn>
 <20240925025041.149206-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925025041.149206-1-dengjie03@kylinos.cn>

On Wed, Sep 25, 2024 at 10:50:41AM +0800, dengjie wrote:
> Reproduction of the problem: During the S4 stress test, when a USB device is inserted or
> removed, there is a probability that the S4 wakeup will turn into a reboot.The following
> two points describe how to analyze and locate the problem points:
> 
> 1. During the boot stage when S4 is awakened, after the USB RootHub is initialized,
> it will enter the runtime suspend state. From then on, whenever an xhci port change
> event occurs, it will trigger a remote wakeup request event and add wakeup_work
> to pm_wq, where the subsequent RootHub runtime resume process will be handled by pm_wq.
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
> 2. However, during the quiesce phase of S4 wakeup, freeze_kernel_threads() will freeze this pm_wq,
> and between freeze_kernel_threads() and dpm_suspend_start(), there exists a very time-consuming
> S4 image loading process. This leads to a situation where, if an xhci port change event occurs
> after freeze_kernel_threads(), triggering the wakeup pending signal to be set,but it cannot
> be processed by pm_wq to clear this wakeup_pending bit, it will result in a subsequent
> dpm_suspend_start() where USB suspend_common() detects the wakeup pending signal being
> set and returns an -EBUSY error, interrupting the S4 quiesce process and reverting to a reboot.
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
> 1. Considering the restore process that occurs after the quiesce phase during S4 wakeup,
> which essentially resets all root hubs,checking this wakeup pending status in USB suspend_common()
> during the quiesce phase is of little significance and should therefore be filtered out.
> 
> S4 wakeup restore phase
>     |->dpm_resume(PMSG_RESTORE)
> 	|->hcd_pci_restore()
> 	    |->xhci_resume()		       /* reset all root hubs */
> 
> Fixes: 3904bdf0821c ("PM: hibernate: Freeze kernel threads in software_resume()")
> Signed-off-by: dengjie <dengjie03@kylinos.cn>

What happened to the other authorship information?

And again, please use your name, not an email alias.

thanks,

greg k-h

