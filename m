Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2352D14DEAD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgA3QN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 11:13:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53037 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3QN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 11:13:57 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ixCRy-0002D5-6i; Thu, 30 Jan 2020 17:13:50 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ixCRv-0006ru-EY; Thu, 30 Jan 2020 17:13:47 +0100
Date:   Thu, 30 Jan 2020 17:13:47 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: USB Port Power-Off during suspend Bug?
Message-ID: <20200130161347.upni5rztqc5fm3nd@pengutronix.de>
References: <20200129225306.dmtoemf62qhogysh@pengutronix.de>
 <Pine.LNX.4.44L0.2001301030430.1441-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2001301030430.1441-100000@iolanthe.rowland.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:11:17 up 76 days,  7:29, 80 users,  load average: 0.61, 0.33,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-30 10:32, Alan Stern wrote:
> On Wed, 29 Jan 2020, Marco Felsch wrote:
> 
> > On 20-01-29 12:59, Alan Stern wrote:
> > > On Wed, 29 Jan 2020, Marco Felsch wrote:
> > > 
> > > > Hi Alan, Rafael, Greg,
> > > > 
> > > > long story short: I want to disable a usb-port completely during suspend
> > > 
> > > You're talking about what happens during a full system suspend, right?
> > 
> > Yes.
> > 
> > > > because it isn't needed and we need to save energy, because is a 32bit ARM
> > > > (OF-based) handheld device. I use the port to connect a usb-ethernet
> > > > dongle (all needed drivers are builtin no modules) which is needed for
> > > > the NFS. The usb-ethernet dongle supports the persist setting because it
> > > > does a hw-reset during resume anyway.
> > > > 
> > > > So what I did is:
> > > >  1) Set the persist bit for the usb device
> > > >  2) Set the control to auto for the usb device
> > > >  3) Unset the pm_qos_no_power_off flag for the usb-port
> > > > 
> > > > But the port gets not disabled. I debugged it and found a problem in
> > > > usb_port_suspend() logic [1] and the generic PM-framework more precisely
> > > > the dpm mechanism. The usbcore does the correct pm_runtime counting but
> > > > the call [2] don't trigger the usb_port_runtime_suspend() [3] because
> > > > the dpm enables all runtime-pm device before the shutdown is executed.
> > > 
> > > That's right; it's supposed to work that way.  We don't want runtime 
> > > suspend kicking in and messing things up during a system suspend.
> > 
> > I'm absolutly fine with that behaviour.
> > 
> > > > IMHO both subsystem behaviours are correct and I don't know the
> > > > _correct_ fix, therefore I wrote this email.
> > > 
> > > The correct fix is to add support for system suspend to the USB port 
> > > driver.  Currently it only supports runtime suspend, as you can see 
> > > from the definition of usb_port_pm_ops in port.c.
> > 
> > I tought that this was intentionally to support only the runtime-pm ops.
> 
> No, it wasn't intentional as far as I know.

Okay, adding a suspend handler seemed to be to easy ^^

> > Okay so this means that we need to check the:
> >   - persist
> >   - do_wakeup
> >   - pm_qos_power_off
> > bits again for the suspend case. I tought I miss something and we can
> > reuse the current checks.
> 
> We can.  Something like the patch below ought to work.  But I have not 
> tested it, and it may very well cause problems for some people.

Yes, something like that with a few more checks for the bits listed
above except the pm_qos_power_off. Thanks for your reply I will prepare
a patch next week.

Regards,
  Marco

> 
> Alan Stern
> 
> 
> 
> Index: usb-devel/drivers/usb/core/port.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/port.c
> +++ usb-devel/drivers/usb/core/port.c
> @@ -283,7 +283,23 @@ static int usb_port_runtime_suspend(stru
>  
>  	return retval;
>  }
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +/* Same as runtime suspend, but no error return */
> +static int usb_port_system_suspend(struct device *dev)
> +{
> +	usb_port_runtime_suspend(dev);
> +	return 0;
> +}
> +
> +static int usb_port_system_resume(struct device *dev)
> +{
> +	return usb_port_runtime_resume(dev);
> +}
> +
>  #endif
> +#endif /* CONFIG_PM */
>  
>  static void usb_port_shutdown(struct device *dev)
>  {
> @@ -294,10 +310,8 @@ static void usb_port_shutdown(struct dev
>  }
>  
>  static const struct dev_pm_ops usb_port_pm_ops = {
> -#ifdef CONFIG_PM
> -	.runtime_suspend =	usb_port_runtime_suspend,
> -	.runtime_resume =	usb_port_runtime_resume,
> -#endif
> +SET_RUNTIME_PM_OPS(usb_port_runtime_suspend, usb_port_runtime_resume, NULL)
> +SET_SYSTEM_SLEEP_PM_OPS(usb_port_system_suspend, usb_port_system_resume)
>  };
>  
>  struct device_type usb_port_device_type = {
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
