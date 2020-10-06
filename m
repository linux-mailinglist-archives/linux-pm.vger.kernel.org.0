Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C632846BE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgJFHFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 03:05:30 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:53620 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJFHF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 03:05:29 -0400
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 01F3D3A743D;
        Tue,  6 Oct 2020 07:04:20 +0000 (UTC)
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BAF111BF203;
        Tue,  6 Oct 2020 07:03:57 +0000 (UTC)
Date:   Tue, 6 Oct 2020 09:03:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     a.zummo@towertech.it, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        len.brown@intel.com, pavel@ucw.cz,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [Question] rtc wake behavior and sysfs
Message-ID: <20201006070357.GF2804081@piout.net>
References: <CAMdYzYrYdDYF_Y_TwQ65u=Ymu2_8Rs9KWm_TfXcaPGTwucT=jg@mail.gmail.com>
 <20201005222953.GD2804081@piout.net>
 <CAMdYzYpHxD4qSCM=-jhj0byBpoPv0LqBuCpkYH=QCX0NrvEAtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYpHxD4qSCM=-jhj0byBpoPv0LqBuCpkYH=QCX0NrvEAtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2020 21:47:01-0400, Peter Geis wrote:
> On Mon, Oct 5, 2020 at 6:29 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 05/10/2020 09:13:08-0400, Peter Geis wrote:
> > > Good Morning,
> > >
> > > While testing suspend to ram on the Ouya, I encountered an interesting
> > > issue with the rtc-tps65910 driver.
> > > Attempting to use rtc-wake on the default configuration returned:
> > > rtcwake: /dev/rtc0 not enabled for wakeup events
> > > This is due to:
> > > eb5eba4ef722 drivers/rtc/rtc-tps65910.c: enable/disable wake in suspend/resume
> > > This commit changed this driver's behavior to not enable wakeup by
> > > default, but enables it when entering sleep mode.
> > > This seems to be odd behavior to me.
> > > Looking at a few other rtc drivers show they simply enable themselves
> > > as wakeup sources by default.
> > >
> > > I also found the sysfs entries are at /sys/devices/ ..
> > > /tps65910-rtc/power but are missing at /sys/class/rtc/rtc0/power/
> > >
> > > I have two questions.
> > >  - Should the sysfs wakeup entries be missing at /sys/class/rtc/rtc0/power/ ?
> >
> > I would be in /sys/class/rtc/rtc0/device/power
> >
> > >  - Shouldn't a rtc be enabled as a wakeup source by default?
> > >
> >
> > The short answer is no, the reason being that not all RTCs are connected
> > to an IRQ or a pin that can wakeup or start the platform. What should be
> > done is enabling wakeup only when interrupts are available or the
> > wakeup-source property is in the rtc device tree node.
> 
> Thank you for your explanation.
> 
> So it would seem we have two issues.
> - The sysfs wakeup entries are not populating in
> /sys/class/rtc/rtc0/power when they are populating in
> /sys/devices/<..>/tps65910-rtc/power.

I think the rationale here is that the rtc device is not the wakeup
device but the underlying one is hence why it is in
/sys/class/rtc/rtc0/device/power and not in /sys/class/rtc/rtc0/power/.

> - The wakeup-source property is not being applied to the tps65910-rtc
> sub-device when it is applied in the tps65910 devicetree node.
> 
> Should wakeup-source handling be the tps65910-rtc driver's
> responsibility, or is that a limitation of the driver core that needs
> to be fixed?

For now, parsing this property is left to the individual drivers.
You'll have to implement it for the tps65910 and so you can get it from
the parent node if necessary.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
