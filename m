Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDFA435C4C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJUHrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUHrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 03:47:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A2C06161C
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 00:45:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mdSl1-0002iG-3h; Thu, 21 Oct 2021 09:44:59 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mdSky-0000cq-M2; Thu, 21 Oct 2021 09:44:56 +0200
Date:   Thu, 21 Oct 2021 09:44:56 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Petr Benes <petrben@gmail.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
Message-ID: <20211021074456.GD2298@pengutronix.de>
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de>
 <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021072000.GC2298@pengutronix.de>
 <afeea08b-6130-3c7c-be03-52691d00be57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afeea08b-6130-3c7c-be03-52691d00be57@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:43:36 up 245 days, 11:07, 119 users,  load average: 0.15, 0.12,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 21, 2021 at 09:41:35AM +0200, Daniel Lezcano wrote:
> On 21/10/2021 09:20, Oleksij Rempel wrote:
> > Hi Petr,
> > 
> > On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
> >> On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >>>
> >>> Hi Petr and Michal,
> >>>
> >>> I forgot to add you for v2 in CC. Please test/review this version.
> >>
> >> Hi Oleksij,
> >>
> >> It works good. with PM as well as without PM. The only minor issue I found is,
> >> that the first temperature reading (when the driver probes) fails. That is
> >> (val & soc_data->temp_valid_mask) == 0) holds true. How does
> >> pm_runtime_resume_and_get() behave in imx_thermal_probe()?
> >> Does it go through imx_thermal_runtime_resume() with usleep_range()?
> > 
> > On the first temperature reading, the PM and part of HW is not
> > initialized. Current probe sequence is racy and has at least following
> > issues:
> > - thermal_zone_device_register is executed before HW init was completed.
> >   It kind of worked before my patch, becaus part of reinit was done by
> >   temperature init. It  worked, since the irq_enabled flag was not set,
> >   but potentially would run enable_irq() two times if device is
> >   overheated on probe.
> > - the imx_thermal core is potentially disable after first race
> >   condition:
> >   CPU0					CPU1
> >   thermal_zone_device_register()
> > 					imx_get_temp()
> >   					irq_enabled == false
> > 						power_up
> > 						read_temp
> >   power_up
> >   						power_down
> >   irq_enabled = true;
> > 
> >   ... at this point imx_thermal is powered down for some amount of time,
> >   over temperature IRQ will not be triggered for some amount of time.
> > 
> > - if some part after thermal_zone_device_register() would fail or
> >   deferred, the worker polling temperature will run in to NULL pointer.
> >   This issue already happened...
> > 
> > After migrating to runtime PM, one of issues started to be visible even
> > on normal conditions.
> > I'll send one more patch with reworking probe sequence.
> 
> Are you planning to send a v3 with this patch? Or a separate patch?

I'm OK with both variants. What do you prefer?

I'll do i on top of PM patch to reduce refactoring overhead, if you OK
about it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
