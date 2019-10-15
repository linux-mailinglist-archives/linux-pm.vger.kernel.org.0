Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228EFD7DA6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbfJOR0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 15 Oct 2019 13:26:31 -0400
Received: from muru.com ([72.249.23.125]:37380 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbfJOR0b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 13:26:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 34E9D8108;
        Tue, 15 Oct 2019 17:27:04 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:26:27 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/2] power: supply: cpcap-battery: Check voltage before
 orderly_poweroff
Message-ID: <20191015172627.GA5610@atomide.com>
References: <20191009205252.9510-1-tony@atomide.com>
 <20191009205252.9510-2-tony@atomide.com>
 <20191013112810.GB5653@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191013112810.GB5653@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 11:28]:
> On Wed 2019-10-09 13:52:51, Tony Lindgren wrote:
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
> > +++ b/drivers/power/supply/cpcap-battery.c
> > @@ -562,12 +562,15 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
> >  	switch (d->action) {
> >  	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
> >  		if (latest->current_ua >= 0)
> > -			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
> > +			dev_warn(ddata->dev, "Battery low at %imV!\n",
> > +				latest->voltage / 1000);
> >  		break;
> >  	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
> > -		if (latest->current_ua >= 0) {
> > +		if (latest->current_ua >= 0 && latest->voltage >= 0 &&
> > +		    latest->voltage <= 3100000) {
> >  			dev_emerg(ddata->dev,
> > -				  "Battery empty at 3.1V, powering off\n");
> > +				  "Battery empty at %imV, powering off\n",
> > +				  latest->voltage / 1000);
> >  			orderly_poweroff(true);
> >  		}
> 
> Hmm.
> 
> So if latest->voltage is < 0, I'd preffer to shut down the machine,
> too.

Hmm I need to recheck if that is needed or not when booting without
a battery on a power supply.

> Actually, if we got POWEROFF irq, and voltage is close to 3.1V (like
> maybe < 3.2V), maybe it would be good to shutdown anyway?

No, this is some spurious interrupt issue that I've seen triggering
at way higher voltages than it should be happening at.

Regards,

Tony

