Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52819322A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 21:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCYUtJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 16:49:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42523 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727376AbgCYUtI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 16:49:08 -0400
Received: (qmail 11099 invoked by uid 500); 25 Mar 2020 16:49:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2020 16:49:07 -0400
Date:   Wed, 25 Mar 2020 16:49:07 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200325150017.xhabucfo3v6i234o@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Mar 2020, Qais Yousef wrote:

> Thanks for all the hints Alan.
> 
> I think I figured it out, the below patch seems to fix it for me. Looking
> at other drivers resume functions it seems we're missing the
> pm_runtime_disable()->set_active()->enable() dance. Doing that fixes the
> warning and the dev_err() in driver/base/power.

Ah, yes.  This should have been added years ago; guess I forgot.  :-(

> I don't see xhci-plat.c doing that, I wonder if it needs it too.
> 
> I'm not well versed about the details and the rules here. So my fix could be
> a hack, though it does seem the right thing to do.
> 
> I wonder why the power core doesn't handle this transparently..

Initially, we didn't want the PM core to do this automatically because
we thought some devices might want to remain runtime-suspended
following a system resume, and only the device driver would know what 
to do.

Raphael, now that we have the direct_complete mechanism, can we revisit 
this?  Should the PM core automatically call pm_runtime_set_active() if 
dev->power.direct_complete isn't set?  Perhaps in device_resume_early() 
prior to the pm_runtime_enable() call?

It's possible we discussed this and decided against it at the time when 
direct_complete was added, but if so I don't remember what was said.

Alan Stern

> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 7addfc2cbadc..eb92c8092fae 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -299,6 +299,10 @@ static int ohci_platform_resume(struct device *dev)
>         }
> 
>         ohci_resume(hcd, false);
> +
> +       pm_runtime_disable(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
>         return 0;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> 
> 
> Thanks
> 
> --
> Qais Yousef


