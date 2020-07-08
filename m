Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F6218965
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgGHNoo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 09:44:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:52146 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgGHNoo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 09:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594215881; bh=m5N5EKsEYiWdipmJshuL2ZNQFzFFa5BIjVuaSql6fQU=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=V9fWo4fub+/jaUPMFn1CZ3J/auzdwkPbCVuj6tjqtv3mA1VTW2crqFCRhc7itDvTK
         cOgfo/pd3fqAHXsv2MNzYSiLg9wbKcYB+trS13XAwUeH+bszFw7r74hzcR6dkrxJD7
         Lx6RWlQU5gr8TnS46u4hlIQPoSasdJPxT20oZLdQ=
Date:   Wed, 8 Jul 2020 15:44:41 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708134441.4lfuh7nwtqnkkg2a@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708122542.73o3lbhgvbdw5c4z@gilmour.lan>
 <20200708132924.r6f5id2evprhybec@core.my.home>
 <20200708133654.fp7k4whl2qmn5ygy@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708133654.fp7k4whl2qmn5ygy@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 03:36:54PM +0200, Maxime Ripard wrote:
> On Wed, Jul 08, 2020 at 03:29:24PM +0200, Ondřej Jirman wrote:
> > Hello Maxime,
> > 
> > On Wed, Jul 08, 2020 at 02:25:42PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > > > I noticed several mobile Linux distributions failing to enable the
> > > > thermal regulation correctly, because the kernel is silent
> > > > when thermal driver fails to probe. Add enough error reporting
> > > > to debug issues and warn users in case thermal sensor is failing
> > > > to probe.
> > > > 
> > > > Failing to notify users means, that SoC can easily overheat under
> > > > load.
> > > > 
> > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > ---
> > > >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
> > > >  1 file changed, 43 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > > index 74d73be16496..9065e79ae743 100644
> > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> > > >  
> > > >  	calcell = devm_nvmem_cell_get(dev, "calibration");
> > > >  	if (IS_ERR(calcell)) {
> > > > +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> > > > +			PTR_ERR(calcell));
> > > > +
> > > >  		if (PTR_ERR(calcell) == -EPROBE_DEFER)
> > > >  			return -EPROBE_DEFER;
> > > > +
> > > 
> > > The rest of the patch makes sense, but we should probably put the error
> > > message after the EPROBE_DEFER return so that we don't print any extra
> > > noise that isn't necessarily useful
> > 
> > I thought about that, but in this case this would have helped, see my other
> > e-mail. Though lack of "probe success" message may be enough for me, to
> > debug the issue, I'm not sure the user will notice that a message is missing, while
> > he'll surely notice if there's a flood of repeated EPROBE_DEFER messages.
> 
> Yeah, but on the other hand, we regularly have people that come up and
> ask if a "legitimate" EPROBE_DEFER error message (as in: the driver
> wasn't there on the first attempt but was there on the second) is a
> cause of concern or not.

That's why I also added a success message, to distinguish this case. 

> > And people run several distros for 3-4 months without anyone noticing any
> > issues and that thermal regulation doesn't work. So it seems that lack of a
> > success message is not enough.
> 
> I understand what the issue is, but do you really expect phone users to
> monitor the kernel logs every time they boot their phone to see if the
> thermal throttling is enabled?

Not phone users, but people making their own kernels/distributions. Those people
monitor dmesg, and out of 4 distros or more nobody noticed there was an issue
(despite the complaints of overheating by their users).

So I thought some warning may be in order, so that distro people more easily
notice they have misconfigured the kernel or sometging.

End users really don't care about dmesg.

regards,
	o.

> If anything, it looks like a distro problem, and the notification /
> policy to deal with that should be implemented in userspace.
> 
> > Other solution may be to select CONFIG_NVMEM_SUNXI_SID if this driver
> > is enabled. That may get rid of this error scenario of waiting infinitely
> > for calibration data with EPROBE_DEFER. And other potential EPROBE_DEFER sources
> > will probably be quite visible even without this driver telling the user.
> > So this message may not be necessary in that case.
> 
> That would only partially solve your issue. If the nvmem driver doesn't
> load for some reason, you would end up in a similar situation.
> 
> Maxime
