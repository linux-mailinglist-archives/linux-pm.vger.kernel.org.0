Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617C2185A9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgGHLKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 07:10:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:49176 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbgGHLKw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 07:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594206650; bh=HwMlt2AcB5R5z+ixudtSMz9QQLHUqR6NKrNCIv6ikVM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=cYWTa2siMsoYgQ7Z91koQPla54fDsMFlBfu1PY4kZBU0he2uUKTPt+n7ZEZXWnfTt
         +idq6HET2YSSsPaA8NXhJmN0Lni9sgfAaJv0De54NS+ARRA7AIV2eGGi51LaDYo4K2
         U9RBIz7IKxjX6hw0VmT0tKKDKEGi4VaTymKJ3ZWo=
Date:   Wed, 8 Jul 2020 13:10:50 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-sunxi@googlegroups.com,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Zhang Rui <rui.zhang@intel.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708111050.ivpkcutwwvm7kwcm@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-sunxi@googlegroups.com,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Zhang Rui <rui.zhang@intel.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708110301.GB1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708110301.GB1551@shell.armlinux.org.uk>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 12:03:01PM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > I noticed several mobile Linux distributions failing to enable the
> > thermal regulation correctly, because the kernel is silent
> > when thermal driver fails to probe. Add enough error reporting
> > to debug issues and warn users in case thermal sensor is failing
> > to probe.
> > 
> > Failing to notify users means, that SoC can easily overheat under
> > load.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > index 74d73be16496..9065e79ae743 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> >  
> >  	calcell = devm_nvmem_cell_get(dev, "calibration");
> >  	if (IS_ERR(calcell)) {
> > +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> > +			PTR_ERR(calcell));
> 
> Consider using:
> 
> 		dev_err(dev, "Failed to get calibration nvmem cell (%pe)\n",
> 			calcell);
> 
> which means the kernel can print the symbolic errno value.

Thank you, I'll change it in v2. :)

regards,
	o.

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
