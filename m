Return-Path: <linux-pm+bounces-14973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705698AD06
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369DD282BD5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4DE199252;
	Mon, 30 Sep 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LrSlqcwe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C21198E84
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725119; cv=none; b=J5xEu54KEByFdfkEh0eKLDa5V/HoZx6aazKsOl30dsOIirjdHxDwRr0gqfuMMyUJf0Fq8ClhcfhhOZxVseRI1faOWfKYwovnlknElaVqxPFOduomypQbNbX/oZM9pQwobCL+FKEzJc9siy3qjmK/G6C/3+a0q0+b/cu25Lf9iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725119; c=relaxed/simple;
	bh=IXmSMKiXKdaiCbcxxxBg2lE24aJBrS5+YZB+0XqXjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd50js317cuIEX2uwZ55jRv2w+b3NuCz6R5W3mfLW0Ja1dEWBMe/aCJoXIdU6XPsg03T0lQNz3oXA0KFn3dISE4epoaYsFbNJSqMG41QDffuTwqK/VbPQuC9zkufSLNHMLekRGX2dWsSR1X/YOUmk/RdpAlX069cbB69/adNSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LrSlqcwe; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e22cb0b19aso40185717b3.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727725117; x=1728329917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Igar7HUQ0HxrMn2e/eYcDg+h6hVnRcsuB41ALV0g+i4=;
        b=LrSlqcweExmFzZgjEYQnTDLcg/IxqsSN/0Zb8ldf5IF073cPy6+bgOSdyGgnFy0NjJ
         A1WZJbA9b0fx1jZg6+B2tZPZkOHrWCRkZzOzeVxqki+IJRr+6Ab6YFCjfHegEkj2KAfL
         +l7d2Ygq90eex9gShwVUmtMS26IHS4WYQam/utL3RnEz1/WuiTBkvX8DAbBQcC1z/ei3
         aifHmWs/GGL/UgYHPJcOjLprtDj+hVJQNexgDm+mdSz/JruwGSJV2W9EkacVYGkCyQSF
         kpUbMGKKXXtNIiUvu+e2sgXeHJ/ySf88VektL6Ac1b6UkBaxX/e3LdfkirQD6V7E6Oco
         Etiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727725117; x=1728329917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Igar7HUQ0HxrMn2e/eYcDg+h6hVnRcsuB41ALV0g+i4=;
        b=Bu/o7YCrzWeF6R+F8CdCvjinQSvRf1I/1uh0rrmzPFR0ESsle0r8pWnvBRzIXkVb3G
         BiTCkoj/C7isn34FH7BeRVKCJTu93Bp1puT1FUg+SHwkCE1vdP1K5BFpEHGApNpn1N87
         6hnsjezTfhZXW5OUihX9sATqzvW6FTM4mjvEfc7/m9QaaBSQ9J3Rxf4WCK4W/OqQ+yGO
         DBWchQDEFQ/naSXRCb5HpW8lQY1De/V71XEGKHUJanIXgLm9sb0Tm1JjUTYJLqPOpSpo
         8qDqPel4c2MLaeAXe4MJeU5B+Lgi05ALiGrc3aXOVrm0w+jaaToHKgGdurOEeOIb2fs2
         C+8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDL8XWDyj80AqLlUrNpLRyTziduQBHWb1921eVXmu/86MqdJySL2YDRAzuu6jyaTEMXzmZw+NaFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOxJmefnyQDRMXAJrbq1K48qPJPfLSWQQJGk7swRoeXs0N+sX
	1f/kyOvqfhW5GdxEZKlHUOZ4lEbEqKuvJcUCNy2UUwhPzQLBt5RFM3ZcHFBjmg==
X-Google-Smtp-Source: AGHT+IF34IrJOIZeVqWCJ7ovVHULCc7AXBhsCuxkTeKum0GTFJS3HFjhLYri9Qs5KtKystdVYdg0ZQ==
X-Received: by 2002:a05:690c:85:b0:6b9:d327:9ad6 with SMTP id 00721157ae682-6e24760050cmr98338037b3.33.1727725116931;
        Mon, 30 Sep 2024 12:38:36 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5638])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b60f8f4sm42545376d6.33.2024.09.30.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:38:36 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:38:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: dengjie <dengjie03@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	xiehongyu1@kylinos.cn, duanchenghao@kylinos.cn, xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where
 task resumption fails due to USB status
Message-ID: <85105e45-3553-4a8c-b132-3875c4657c4b@rowland.harvard.edu>
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

I'm very sorry it has taken so long for me to respond to this...

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

At this point, do_wakeup is supposed to be 0 and so the "return -EBUSY" 
error should not occur.

You can see that this is true by reading choose_wakeup() in 
drivers/usb/core/driver.c.  At the start of the function it says:

	/*
	 * For FREEZE/QUIESCE, disable remote wakeups so no interrupts get
	 * generated.
	 */
	if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_QUIESCE) {
		w = 0;

and at the end it does:

	udev->do_remote_wakeup = w;

Therefore the problem you are describing should not happen and your 
patch should not be needed.

Now maybe things are't working the way they are supposed to.  If that's 
so then you should submit a patch fixing the code so that it _does_ work 
this way.

For instance, in suspend_common(), do_wakeup is derived from 
device_may_wakeup(rhdev), which is determined by 
rhdev->power.should_wakeup -- see the definition in 
include/linux/pm_wakeup.h.  Maybe this flag isn't getting cleared 
properly.  (In fact, at the moment I don't see where that flag gets set 
or cleared at all...)

> Below is a description of the countermeasures taken to address this issue:
> 1. Considering the restore process that occurs after the quiesce phase during S4 wakeup,
> which essentially resets all root hubs,checking this wakeup pending status in USB suspend_common()
> during the quiesce phase is of little significance and should therefore be filtered out.
> 
> S4 wakeup restore phase
>     |->dpm_resume(PMSG_RESTORE)
> 	|->hcd_pci_restore()
> 	    |->xhci_resume()		       /* reset all root hubs */

The wakeup-pending status is checked only if wakeup is enabled.  And 
during the quiesce phase, wakeup is not supposed to be enabled.  So 
nothing needs to be filtered out.

Alan Stern

