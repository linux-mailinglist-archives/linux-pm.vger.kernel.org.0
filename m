Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDF1B24B8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDULPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 07:15:18 -0400
Received: from foss.arm.com ([217.140.110.172]:33308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDULPS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Apr 2020 07:15:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F0C1FB;
        Tue, 21 Apr 2020 04:15:17 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9217C3F73D;
        Tue, 21 Apr 2020 04:15:16 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:15:14 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200421111513.fy3oqebij6fnvbnc@e107158-lin.cambridge.arm.com>
References: <Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org>
 <Pine.LNX.4.44L0.2004201622260.22032-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2004201622260.22032-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/20/20 16:26, Alan Stern wrote:
> On Wed, 25 Mar 2020, Alan Stern wrote:
> 
> > On Wed, 25 Mar 2020, Qais Yousef wrote:
> > 
> > > Thanks for all the hints Alan.
> > > 
> > > I think I figured it out, the below patch seems to fix it for me. Looking
> > > at other drivers resume functions it seems we're missing the
> > > pm_runtime_disable()->set_active()->enable() dance. Doing that fixes the
> > > warning and the dev_err() in driver/base/power.
> > 
> > Ah, yes.  This should have been added years ago; guess I forgot.  :-(
> > 
> > > I don't see xhci-plat.c doing that, I wonder if it needs it too.
> > > 
> > > I'm not well versed about the details and the rules here. So my fix could be
> > > a hack, though it does seem the right thing to do.
> > > 
> > > I wonder why the power core doesn't handle this transparently..
> > 
> > Initially, we didn't want the PM core to do this automatically because
> > we thought some devices might want to remain runtime-suspended
> > following a system resume, and only the device driver would know what 
> > to do.
> 
> Qais:
> 
> So it looks like the discussion with Rafael will lead to changes in the
> PM core, but they won't go into the -stable kernels, and they won't
> directly fix the problem here.
> 
> In the meantime, why don't you write up your patch below and submit it
> properly?  Even better, create similar patches for ehci-platform.c and
> xhci-plat.c and submit them too.

Sure.

Thanks

--
Qais Yousef

> 
> Alan Stern
> 
> > > diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> > > index 7addfc2cbadc..eb92c8092fae 100644
> > > --- a/drivers/usb/host/ohci-platform.c
> > > +++ b/drivers/usb/host/ohci-platform.c
> > > @@ -299,6 +299,10 @@ static int ohci_platform_resume(struct device *dev)
> > >         }
> > > 
> > >         ohci_resume(hcd, false);
> > > +
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_set_active(dev);
> > > +       pm_runtime_enable(dev);
> > >         return 0;
> > >  }
> > >  #endif /* CONFIG_PM_SLEEP */
> > > 
> > > 
> > > Thanks
> > > 
> > > --
> > > Qais Yousef
> > 
> > 
> > 
> 
