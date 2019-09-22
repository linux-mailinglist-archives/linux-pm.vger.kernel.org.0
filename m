Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4DBA390
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2019 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfIVSAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Sep 2019 14:00:16 -0400
Received: from muru.com ([72.249.23.125]:34172 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387966AbfIVSAQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Sep 2019 14:00:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 010F6804F;
        Sun, 22 Sep 2019 18:00:46 +0000 (UTC)
Date:   Sun, 22 Sep 2019 11:00:12 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Check voltage before
 orderly_poweroff
Message-ID: <20190922180012.GU5610@atomide.com>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-3-tony@atomide.com>
 <20190919091434.GB9644@amd>
 <20190920141237.GK5610@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920141237.GK5610@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190920 14:13]:
> * Pavel Machek <pavel@ucw.cz> [190919 09:15]:
> > Plus I see bigger problem: shutdown from mainline seems to leave
> > something powered in the phone (I believe I seen USB charge pump, for
> > example), so the battery will be completely empty next time I attempt
> > to use the phone. (I learned to reboot into stock android and shutdown
> > there).
> > 
> > Phone should last days when powered off, but it seems to only last
> > hours.
> > 
> > Unfortunately I don't know how to debug that :-(.
> 
> Yes there's some issue with shutdown. I think it's somehow related
> to mdm6600 being powered where the poweroff gpio does not allow
> device to shut down with modem powered. We could try adding a
> .power_off function to the modem code to see if it helps.

Sorry I mean .shutdown function. But I doubt this is a modem
issue you're seeing, I already fixed that issue most likely with
commit 8ead7e817224 ("usb: core: Add PM runtime calls to
usb_hcd_platform_shutdown"). Well at least things are shutting
down for me now after checking few times. I recall the symptoms
of the shut down failing issue is that the also the LCD backlight
stays on.

There are some issues left with musb configured as a usb
gadget, but I have not been able to quite track those down
so far. It seems that there are some gadget framework kobject
warnings with the musb controlling device (omap2430) unloaded
and then doing a shutdown. The device shuts down though.

> Additionally I've noticed that we leave some PMIC features powered
> when device is powered off without a modem consuming about 2.5mW
> while powering off from Android shows power consumption in uW
> range probably with only RTC being powered.

AFAIK this issue still remains. I'll take a look at adding a
.shutdown somewhere for cpcap driver(s) so we get it cleared
for a low-power state.

Regards,

Tony
