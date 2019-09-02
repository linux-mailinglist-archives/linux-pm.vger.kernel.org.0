Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8522A5B40
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfIBQUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 12:20:50 -0400
Received: from muru.com ([72.249.23.125]:59480 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfIBQUu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 12:20:50 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5815A8022;
        Mon,  2 Sep 2019 16:21:19 +0000 (UTC)
Date:   Mon, 2 Sep 2019 09:20:46 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>
Subject: Re: [PATCH] power: supply: cpcap-charger: Enable vbus boost voltage
Message-ID: <20190902162046.GJ52127@atomide.com>
References: <20190830232316.53750-1-tony@atomide.com>
 <20190902075943.GB15850@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902075943.GB15850@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190902 08:00]:
> Hi!
> 
> > We are currently not enabling VBUS boost for cpcap when in host mode.
> > This means the VBUS is fed at the battery voltage level, which can cause
> > flakeyness enumerating devices.
> > 
> > Looks like the boost control for VBUS is CPCAP_BIT_VBUS_SWITCH that we
> > must enable in the charger for nice 4.92 V VBUS output. And looks like
> > we must not use the STBY pin enabling but must instead use manual VBUS
> > control in phy-cpcap-usb.
> > 
> > We want to do this in cpcap_charger_vbus_work() and also set a flag for
> > feeding_vbus to avoid races between USB detection and charger detection,
> > and disable charging if feeding_vbus is set.
> 
> I did not know phone is supposed to provide voltage on USB. USB mouse
> works for me.. in stock android, provided I conect USB hub and
> external power.

Yup that's standard USB OTG feature when ID pin is grounded.

> This does not seem to work for me.. and it does not even work on stock
> kernel. What is going on here?

Sounds like you're missing a USB micro-B cable with ID pin grounded
and trying to use debugfs/sysfs instead to force the host mode.

> Is there some kind of debug ineterface where I could test just the
> vbus switch? I do have voltmeter for the usb port...

Yeah well.. just ground the ID pin :) No debug interface should be
needed here.

If you really wanted to add some kind of debugfs interface for forcing
host mode without ID pin grounded, you could try to have the USB phy
driver enable ID pin pull-down via sysfs. That's the cpcap PMIC in this
case, I think some combination of CPCAP_BIT_ID* bits might do the
trick.

Regards,

Tony

