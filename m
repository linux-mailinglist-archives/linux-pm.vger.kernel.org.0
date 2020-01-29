Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD92814CFFD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgA2R7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 12:59:43 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47696 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726851AbgA2R7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 12:59:42 -0500
Received: (qmail 7375 invoked by uid 2102); 29 Jan 2020 12:59:41 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2020 12:59:41 -0500
Date:   Wed, 29 Jan 2020 12:59:41 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Felsch <m.felsch@pengutronix.de>
cc:     Thinh.Nguyen@synopsys.com, <gregkh@linuxfoundation.org>,
        <rjw@rjwysocki.net>, <pavel@ucw.cz>, <len.brown@intel.com>,
        <kernel@pengutronix.de>, <linux-pm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: USB Port Power-Off during suspend Bug?
In-Reply-To: <20200129095442.3exfzwp3vrubfxir@pengutronix.de>
Message-ID: <Pine.LNX.4.44L0.2001291254080.1429-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Jan 2020, Marco Felsch wrote:

> Hi Alan, Rafael, Greg,
> 
> long story short: I want to disable a usb-port completely during suspend

You're talking about what happens during a full system suspend, right?

> because it isn't needed and we need to save energy, because is a 32bit ARM
> (OF-based) handheld device. I use the port to connect a usb-ethernet
> dongle (all needed drivers are builtin no modules) which is needed for
> the NFS. The usb-ethernet dongle supports the persist setting because it
> does a hw-reset during resume anyway.
> 
> So what I did is:
>  1) Set the persist bit for the usb device
>  2) Set the control to auto for the usb device
>  3) Unset the pm_qos_no_power_off flag for the usb-port
> 
> But the port gets not disabled. I debugged it and found a problem in
> usb_port_suspend() logic [1] and the generic PM-framework more precisely
> the dpm mechanism. The usbcore does the correct pm_runtime counting but
> the call [2] don't trigger the usb_port_runtime_suspend() [3] because
> the dpm enables all runtime-pm device before the shutdown is executed.

That's right; it's supposed to work that way.  We don't want runtime 
suspend kicking in and messing things up during a system suspend.

> IMHO both subsystem behaviours are correct and I don't know the
> _correct_ fix, therefore I wrote this email.

The correct fix is to add support for system suspend to the USB port 
driver.  Currently it only supports runtime suspend, as you can see 
from the definition of usb_port_pm_ops in port.c.

Alan Stern

> As far as I understood it all non-ACPI platforms are affected.
> 
> Regards,
>   Marco
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3238
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3328
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/port.c?h=v5.5#n247

