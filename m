Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1DB9170
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfITOMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 10:12:41 -0400
Received: from muru.com ([72.249.23.125]:33942 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbfITOMl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 10:12:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F07EE80AA;
        Fri, 20 Sep 2019 14:13:11 +0000 (UTC)
Date:   Fri, 20 Sep 2019 07:12:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Check voltage before
 orderly_poweroff
Message-ID: <20190920141237.GK5610@atomide.com>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-3-tony@atomide.com>
 <20190919091434.GB9644@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919091434.GB9644@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190919 09:15]:
> On Tue 2019-09-17 14:35:00, Tony Lindgren wrote:
> > We can get the low voltage interrupt trigger sometimes way too early,
> > maybe because of CPU load spikes. This causes orderly_poweroff() be
> > called too easily.
> > 
> > Let's check the voltage before orderly_poweroff in case it was not
> > yet a permanent condition. We will be getting more interrupts anyways
> > if the condition persists.
> > 
> > Let's also show the measured voltages for low battery and battery
> > empty warnings since we have them.
> 
> Well, this is decision that will shorten battery lifetime. There's
> very little capacity left when battery is down to 3.3V...
> 
> What kind of "way too early" do you see?

I've seen it trigger spontaneously already around battery low
interrupt time.

> > @@ -562,12 +562,15 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
> >  	switch (d->action) {
> >  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
> >  		if (latest->current_ua >= 0)
> > -			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
> > +			dev_warn(ddata->dev, "Battery low at %i!\n",
> > +				latest->voltage);
> >  		break;
> 
> I'd still leave unit ("uV"?) there. Or do /1000, as and display mV, as
> our 
> > -				  "Battery empty at 3.1V, powering off\n");
> > +				  "Battery empty at %i, powering off\n",
> > +				  latest->voltage);
> >  			orderly_poweroff(true);
> 
> Same here.

Sure yeah I'll update it.

> Plus I see bigger problem: shutdown from mainline seems to leave
> something powered in the phone (I believe I seen USB charge pump, for
> example), so the battery will be completely empty next time I attempt
> to use the phone. (I learned to reboot into stock android and shutdown
> there).
> 
> Phone should last days when powered off, but it seems to only last
> hours.
> 
> Unfortunately I don't know how to debug that :-(.

Yes there's some issue with shutdown. I think it's somehow related
to mdm6600 being powered where the poweroff gpio does not allow
device to shut down with modem powered. We could try adding a
.power_off function to the modem code to see if it helps.

Additionally I've noticed that we leave some PMIC features powered
when device is powered off without a modem consuming about 2.5mW
while powering off from Android shows power consumption in uW
range probably with only RTC being powered.

Regards,

Tony
