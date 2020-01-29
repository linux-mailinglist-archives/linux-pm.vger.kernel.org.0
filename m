Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0534514D340
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 23:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA2WxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 17:53:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56225 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 17:53:14 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iwwCr-0007iy-Me; Wed, 29 Jan 2020 23:53:09 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iwwCo-0006yK-FW; Wed, 29 Jan 2020 23:53:06 +0100
Date:   Wed, 29 Jan 2020 23:53:06 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: USB Port Power-Off during suspend Bug?
Message-ID: <20200129225306.dmtoemf62qhogysh@pengutronix.de>
References: <20200129095442.3exfzwp3vrubfxir@pengutronix.de>
 <Pine.LNX.4.44L0.2001291254080.1429-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2001291254080.1429-100000@iolanthe.rowland.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 23:46:04 up 75 days, 14:04, 71 users,  load average: 0.22, 0.17,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-29 12:59, Alan Stern wrote:
> On Wed, 29 Jan 2020, Marco Felsch wrote:
> 
> > Hi Alan, Rafael, Greg,
> > 
> > long story short: I want to disable a usb-port completely during suspend
> 
> You're talking about what happens during a full system suspend, right?

Yes.

> > because it isn't needed and we need to save energy, because is a 32bit ARM
> > (OF-based) handheld device. I use the port to connect a usb-ethernet
> > dongle (all needed drivers are builtin no modules) which is needed for
> > the NFS. The usb-ethernet dongle supports the persist setting because it
> > does a hw-reset during resume anyway.
> > 
> > So what I did is:
> >  1) Set the persist bit for the usb device
> >  2) Set the control to auto for the usb device
> >  3) Unset the pm_qos_no_power_off flag for the usb-port
> > 
> > But the port gets not disabled. I debugged it and found a problem in
> > usb_port_suspend() logic [1] and the generic PM-framework more precisely
> > the dpm mechanism. The usbcore does the correct pm_runtime counting but
> > the call [2] don't trigger the usb_port_runtime_suspend() [3] because
> > the dpm enables all runtime-pm device before the shutdown is executed.
> 
> That's right; it's supposed to work that way.  We don't want runtime 
> suspend kicking in and messing things up during a system suspend.

I'm absolutly fine with that behaviour.

> > IMHO both subsystem behaviours are correct and I don't know the
> > _correct_ fix, therefore I wrote this email.
> 
> The correct fix is to add support for system suspend to the USB port 
> driver.  Currently it only supports runtime suspend, as you can see 
> from the definition of usb_port_pm_ops in port.c.

I tought that this was intentionally to support only the runtime-pm ops.
Okay so this means that we need to check the:
  - persist
  - do_wakeup
  - pm_qos_power_off
bits again for the suspend case. I tought I miss something and we can
reuse the current checks.

Regards,
  Marco

> Alan Stern
> 
> > As far as I understood it all non-ACPI platforms are affected.
> > 
> > Regards,
> >   Marco
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3238
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3328
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/port.c?h=v5.5#n247
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
