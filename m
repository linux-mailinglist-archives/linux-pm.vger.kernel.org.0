Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5801321CC23
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 01:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGLX3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jul 2020 19:29:45 -0400
Received: from vps.xff.cz ([195.181.215.36]:60550 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgGLX3p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Jul 2020 19:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594596583; bh=mGpvPO69Sq3uBZZ4LMIGshZ9SukFLv4L6UJ+xxlTBSs=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=a8UcIIWVw0DeoiZqCVzEexyC+8qr0JumbaFjRMx1OAOluKaCH3YxXBxasO+UaKMU8
         ty8DKLtX58uRK4+W5Zm3Gupkk/v/MT+stUCSjl2ykbPH0bw8U1MUhTufgu/Lz4Y1ER
         5tZPLXAvIOIWqbEbF4N6Q7wcAtxSsgV0NMYKAJfo=
Date:   Mon, 13 Jul 2020 01:29:42 +0200
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
Message-ID: <20200712232942.eecoekr25i3wu2iq@core.my.home>
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
 <20200708134441.4lfuh7nwtqnkkg2a@core.my.home>
 <20200708135748.l4zncodhhggurp6s@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708135748.l4zncodhhggurp6s@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maxime,

On Wed, Jul 08, 2020 at 03:57:48PM +0200, Maxime Ripard wrote:
> On Wed, Jul 08, 2020 at 03:44:41PM +0200, Ondřej Jirman wrote:
> > >

[...]

> > > Yeah, but on the other hand, we regularly have people that come up and
> > > ask if a "legitimate" EPROBE_DEFER error message (as in: the driver
> > > wasn't there on the first attempt but was there on the second) is a
> > > cause of concern or not.
> > 
> > That's why I also added a success message, to distinguish this case. 
> 
> That doesn't really help though. We have plenty of drivers that have
> some sort of success message and people will still ask about that error
> message earlier.
> 
> > > > And people run several distros for 3-4 months without anyone noticing any
> > > > issues and that thermal regulation doesn't work. So it seems that lack of a
> > > > success message is not enough.
> > > 
> > > I understand what the issue is, but do you really expect phone users to
> > > monitor the kernel logs every time they boot their phone to see if the
> > > thermal throttling is enabled?
> > 
> > Not phone users, but people making their own kernels/distributions. Those people
> > monitor dmesg, and out of 4 distros or more nobody noticed there was an issue
> > (despite the complaints of overheating by their users).
> > 
> > So I thought some warning may be in order, so that distro people more easily
> > notice they have misconfigured the kernel or sometging.
> 
> I mean, then there's nothing we can do to properly address that then.
> 
> The configuration system is a gun, we can point at the target, but
> anyone is definitely free to shot themself in the foot.
> 
> You would have exactly the same result if you left the thermal driver
> disabled, or if you didn't have cpufreq support.

Right. Though I hope there's some middle ground. I mean all of those dev_err
in error paths of many drivers are there mostly to help debugging stuff.

And even though I was part of this driver's development, it took me quite
some time to figure out it was the missing sunxi-sid driver causing the issue,
with complete silence from the driver.

Maybe this can/will be solved at another level entirely, like having a device
core report devices probes that failed with EPROBE_DEFER some time after
the boot finished and modules had a chance to load, instead of immediately
for each probe retry.

regards,
	o.

> Maxime
