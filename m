Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AB14C863
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 10:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA2Jyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 04:54:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46273 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2Jyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 04:54:54 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iwk3Z-0002xw-EH; Wed, 29 Jan 2020 10:54:45 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iwk3W-0005RX-R0; Wed, 29 Jan 2020 10:54:42 +0100
Date:   Wed, 29 Jan 2020 10:54:42 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     stern@rowland.harvard.edu, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: USB Port Power-Off during suspend Bug?
Message-ID: <20200129095442.3exfzwp3vrubfxir@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:11:11 up 75 days, 29 min, 72 users,  load average: 0.19, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Alan, Rafael, Greg,

long story short: I want to disable a usb-port completely during suspend
because it isn't needed and we need to save energy, because is a 32bit ARM
(OF-based) handheld device. I use the port to connect a usb-ethernet
dongle (all needed drivers are builtin no modules) which is needed for
the NFS. The usb-ethernet dongle supports the persist setting because it
does a hw-reset during resume anyway.

So what I did is:
 1) Set the persist bit for the usb device
 2) Set the control to auto for the usb device
 3) Unset the pm_qos_no_power_off flag for the usb-port

But the port gets not disabled. I debugged it and found a problem in
usb_port_suspend() logic [1] and the generic PM-framework more precisely
the dpm mechanism. The usbcore does the correct pm_runtime counting but
the call [2] don't trigger the usb_port_runtime_suspend() [3] because
the dpm enables all runtime-pm device before the shutdown is executed.
IMHO both subsystem behaviours are correct and I don't know the
_correct_ fix, therefore I wrote this email.

As far as I understood it all non-ACPI platforms are affected.

Regards,
  Marco

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3238
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/hub.c?h=v5.5#n3328
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/core/port.c?h=v5.5#n247
