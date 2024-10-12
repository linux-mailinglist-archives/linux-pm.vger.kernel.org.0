Return-Path: <linux-pm+bounces-15569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7599B4D9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14ED1C21898
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85C1714A1;
	Sat, 12 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+zM6JUL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92538DF9;
	Sat, 12 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736779; cv=none; b=fXV6JjZIgWSjbk2j40z9kcPA29iJFPOjS3S8j+O6evROiUIV+viedSYSwEiEN9uXhtPB1HWC8WcP+tD3wuBSFXx3RX2A710hWYndUwaNqM0MDdgP3IZzsTX+1Ue5wms/Iw98uaY+RvPKLkKDuLzozvdUk8ZgIWDNDzTU1b3tzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736779; c=relaxed/simple;
	bh=Vrj4K0uK7xHkOtHOFrZzsAQEV8qw/S/KlFdTRd+vFyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AylSYBARUpwCHbeWqpslfwcWuYMNO0iR/zxhqSMOhg1TptQU+NwJnB8gz6m8kLzDYm1rG2BQniNWSFdRzO3YCaAGkIkPE2yZYiYcJOBWbvmxdThuh7/Vs9VOXRNrYhv+eW6xxPLVoWBGgi2fKecwrcCsCzys55Cedw8z5A3VyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+zM6JUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCD2C4CEC6;
	Sat, 12 Oct 2024 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728736779;
	bh=Vrj4K0uK7xHkOtHOFrZzsAQEV8qw/S/KlFdTRd+vFyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1+zM6JULcckggmSvkqp3PIL7TBxzsWAgV4hiIRxWMGTad9qjtf3Ywq1yJQh3LWeDm
	 +YolpnmtxEL5se/jgrIjJDfd72wD6k/fTKZ+tl2TVgZ9EB46MoUdceZmgmYwo1bwG5
	 IJwieZdacj4AeRORVFeyzCwpbHsnsJ7zS7xbw2+Y=
Date: Sat, 12 Oct 2024 14:39:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Duan Chenghao <duanchenghao@kylinos.cn>
Cc: stern@rowland.harvard.edu, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com
Subject: Re: [PATCH v3] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2024101215-congenial-petticoat-324c@gregkh>
References: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
 <20241012094633.126736-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012094633.126736-1-duanchenghao@kylinos.cn>

On Sat, Oct 12, 2024 at 05:46:33PM +0800, Duan Chenghao wrote:
> When a device is inserted into the USB port and an S4 wakeup is initiated,
> after the USB-hub initialization is completed, it will automatically enter
> suspend mode. Upon detecting a device on the USB port, it will proceed with
> resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During the S4
> wakeup process, peripherals are put into suspend mode, followed by task
> recovery. However, upon detecting that the hcd is in the
> HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status, causing the
> S4 suspend to fail and subsequent task recovery to not proceed.
> -
> [   27.594598][ 1]  PM: pci_pm_freeze(): hcd_pci_suspend+0x0/0x28 returns -16
> [   27.594601][ 1]  PM: dpm_run_callback(): pci_pm_freeze+0x0/0x100 returns -16
> [   27.603420][ 1]  ehci-pci 0000:00:04.1: pci_pm_freeze+0x0/0x100 returned 0 after 3 usecs
> [   27.612233][ 1]  ehci-pci 0000:00:05.1: pci_pm_freeze+0x0/0x100 returned -16 after 17223 usecs
> [   27.810067][ 1]  PM: Device 0000:00:05.1 failed to quiesce async: error -16
> [   27.816988][ 1]  PM: quiesce of devices aborted after 1833.282 msecs
> [   27.823302][ 1]  PM: start quiesce of devices aborted after 1839.975 msecs
> ......
> [   31.303172][ 1]  PM: recover of devices complete after 3473.039 msecs
> [   31.309818][ 1]  PM: Failed to load hibernation image, recovering.
> [   31.348188][ 1]  PM: Basic memory bitmaps freed
> [   31.352686][ 1]  OOM killer enabled.
> [   31.356232][ 1]  Restarting tasks ... done.
> [   31.360609][ 1]  PM: resume from hibernation failed (0)
> [   31.365800][ 1]  PM: Hibernation image not present or could not be loaded.
> 
> The "do_wakeup" is determined based on whether the controller's
> power/wakeup attribute is set. The current issue necessitates considering
> the type of suspend that is occurring. If the suspend type is either
> PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be set to
> false.
> 
> Co-authored-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> ---
>  drivers/usb/core/hcd-pci.c | 14 ++++++++++++--
>  include/linux/pm.h         |  3 ++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index a08f3f228e6d..2c7d4446b82e 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -422,7 +422,12 @@ static int suspend_common(struct device *dev, pm_message_t msg)
>  	bool			do_wakeup;
>  	int			retval;
>  
> -	do_wakeup = PMSG_IS_AUTO(msg) ? true : device_may_wakeup(dev);
> +	if (PMSG_IS_AUTO(msg))
> +		do_wakeup = true;
> +	else if (PMSG_NO_WAKEUP(msg))
> +		do_wakeup = false;
> +	else
> +		do_wakeup = device_may_wakeup(dev);
>  
>  	/* Root hub suspend should have stopped all downstream traffic,
>  	 * and all bus master traffic.  And done so for both the interface
> @@ -521,6 +526,11 @@ static int hcd_pci_suspend(struct device *dev)
>  	return suspend_common(dev, PMSG_SUSPEND);
>  }
>  
> +static int hcd_pci_freeze(struct device *dev)
> +{
> +	return suspend_common(dev, PMSG_FREEZE);
> +}
> +
>  static int hcd_pci_suspend_noirq(struct device *dev)
>  {
>  	struct pci_dev		*pci_dev = to_pci_dev(dev);
> @@ -624,7 +634,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>  	.resume_noirq	= hcd_pci_resume_noirq,
>  	.resume		= hcd_pci_resume,
> -	.freeze		= hcd_pci_suspend,
> +	.freeze		= hcd_pci_freeze,
>  	.freeze_noirq	= check_root_hub_suspended,
>  	.thaw_noirq	= NULL,
>  	.thaw		= hcd_pci_resume,
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 97b0e23363c8..0dd7f559188b 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -570,7 +570,8 @@ const struct dev_pm_ops name = { \
>  					{ .event = PM_EVENT_AUTO_RESUME, })
>  
>  #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
> -
> +#define PMSG_NO_WAKEUP(msg)	(((msg.event) & \
> +				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)
>  /*
>   * Device run-time power management status.
>   *
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

