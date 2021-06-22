Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9287A3B0140
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFVKY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 06:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKY5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 06:24:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE8A961040;
        Tue, 22 Jun 2021 10:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624357362;
        bh=Nu66vJt+FgQme5pccZDawpQBCJtjKoF1ah13CKR4AQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ym6mtxCRM+YaeAdA7g+xHEDUuyVM3EsVl8fc90kaTbBjzMEWXSoenmIcPVtm3ywdp
         9KzQ8vyYga5cMkmOkbMCadQEx8CnrgNoKivvV+F2CTLag+VeabzTrcEx57LkixtxGk
         M+o2fjXNdBDUon6v4w+jCtfluufSRP4/yBNGYUg0=
Date:   Tue, 22 Jun 2021 12:22:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pingshuo <pingshuo@uniontech.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hibernation:stop resume screen during hibernation
Message-ID: <YNG579N8dJsmF+Mr@kroah.com>
References: <20210622083844.13892-1-pingshuo@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622083844.13892-1-pingshuo@uniontech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 04:38:44PM +0800, pingshuo wrote:
> The display will be woken up during hibernation,
> if the computer equipment is poor, it will cause the screen to flicker.
> Skip to reusme the display devices in "thaw".
> 
> Signed-off-by: pingshuo <pingshuo@uniontech.com>
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c7f51c94969d..376b2eca65c7 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -707,7 +707,7 @@ static int dpm_resume_skip_display_devices(struct device *dev, pm_message_t stat
>  {
>      struct pci_dev *pci_test = to_pci_dev(dev);
>      if (state.event == PM_EVENT_THAW) {
> -        /*
> +	/*
>          *Filter out the display devices
>          */
>          if((pci_test && ((pci_test->class&DISPLAY_PCI_CLASS_VALID_BIT) == DISPLAY_PCI_CLASS))||(dev->driver&&dev->driver->name&&strncmp(dev->driver->name,"video",6)==0))
> -- 
> 2.20.1
> 
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- The patch does not do what your description says it does, at all.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
